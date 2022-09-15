Imports System.Data.SqlClient
Imports System.Drawing
Imports System.IO
Imports Telerik.Web.UI

Public Class EventImages
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub PhotoListView_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PhotoListView.ItemCommand

        Select Case e.CommandName
            Case "DeleteImage"
                Dim id As Integer = e.CommandArgument

                Try
                    Dim deletephoto = db.DeletePhoto(id)

                    PhotoListView.DataBind()
                Catch ex As Exception
                    errorLabel.Text = ex.Message
                End Try
            Case "Rotate"

                'Response.Redirect(e.CommandArgument)

                Dim photoID = Convert.ToInt32(e.CommandArgument)

                'get the image from sql and save as to disk
                Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault

                Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
                    sqlconnection.Open()

                    Dim selectQuery As String = String.Format("SELECT Image FROM tblPhoto WHERE photoID ={0}", photoID)

                    Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)
                    Dim reader As SqlDataReader = selectCommand.ExecuteReader()
                    If reader.Read() Then
                        Dim byteData As Byte() = DirectCast(reader(0), Byte())
                        Dim strData As String = Encoding.UTF8.GetString(byteData)

                        System.IO.File.WriteAllBytes(Server.MapPath(Convert.ToString("~/documents/rotator/" & _fileName)), byteData)

                    End If
                    sqlconnection.Close()
                End Using

                'rotate the image
                ' get the full path of image url

                Dim path As String = Server.MapPath("~/documents/rotator/" & _fileName)
                Dim newpath As String = Server.MapPath("~/documents/rotator/new/" & photoID & ".png")

                ' creating image from the image url
                Dim i As System.Drawing.Image = System.Drawing.Image.FromFile(path)

                ' rotate Image 90' Degree
                i.RotateFlip(RotateFlipType.Rotate90FlipNone)

                ' save it to its actual path
                i.Save(newpath)

                ' release Image File
                i.Dispose()


                'save image to sql
                Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
                    sqlconnection.Open()

                    Dim bytes As Byte() = Nothing
                    Dim fs As New FileStream(newpath, FileMode.Open, FileAccess.Read)
                    Dim br As New BinaryReader(fs)
                    bytes = br.ReadBytes(CInt(fs.Length))


                    Dim selectQuery As String = String.Format("UPDATE tblPhoto set Image = @image, ThumbImage = @thumbimage, SmallImage = @smallimage, LargeImage = @largeimage WHERE photoID = @photoID")
                    Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)


                    selectCommand.Parameters.Add(New SqlParameter("@photoID", photoID))
                    selectCommand.Parameters.Add(New SqlParameter("@image", MakeThumb(bytes, 1200)))
                    selectCommand.Parameters.Add(New SqlParameter("@thumbimage", MakeThumb(bytes, 100)))
                    selectCommand.Parameters.Add(New SqlParameter("@smallimage", MakeThumb(bytes, 350)))
                    selectCommand.Parameters.Add(New SqlParameter("@largeimage", MakeThumb(bytes, 500)))

                    selectCommand.ExecuteNonQuery()
                    sqlconnection.Close()

                End Using

                PhotoListView.DataBind()

        End Select
    End Sub

    Protected Property ImageWidth() As Unit

        Get
            Dim state As Object = If(ViewState("ImageWidth"), Unit.Pixel(200))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageWidth") = value
        End Set

    End Property


    Protected Property ImageHeight() As Unit

        Get
            Dim state As Object = If(ViewState("ImageHeight"), Unit.Pixel(200))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageHeight") = value
        End Set

    End Property

    Protected Function CreateWindowScript3(ByVal eventID As Integer, ByVal photoID As Integer) As String
        Return String.Format("var win = window.radopen('/PhotoGallery.aspx?ID={0}&PhotoID={1}','Details');win.center();", eventID, photoID)
    End Function


#Region "Make Thumnail"
    Const sizeThumb As Integer = 100

    Public Shared Function MakeThumb(ByVal fullsize As Byte()) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim targetH, targetW As Integer

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New System.IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image
        If (iOriginal.Height > iOriginal.Width) Then
            targetH = sizeThumb
            targetW = CInt(iOriginal.Width * (sizeThumb / iOriginal.Height))
        Else
            targetW = sizeThumb
            targetH = CInt(iOriginal.Height * (sizeThumb / iOriginal.Width))
        End If
        iThumb = iOriginal.GetThumbnailImage(targetW, targetH, Nothing, System.IntPtr.Zero)
        Dim m As New System.IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function


    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal newwidth As Integer, ByVal newheight As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scaleH, scaleW As Double
        Dim srcRect As Drawing.Rectangle


        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New System.IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image

        scaleH = iOriginal.Height / newheight
        scaleW = iOriginal.Width / newwidth
        If scaleH = scaleW Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = iOriginal.Height
            srcRect.X = 0
            srcRect.Y = 0
        ElseIf (scaleH) > (scaleW) Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = CInt(newheight * scaleW)
            srcRect.X = 0
            srcRect.Y = CInt((iOriginal.Height - srcRect.Height) / 2)
        Else
            srcRect.Width = CInt(newwidth * scaleH)
            srcRect.Height = iOriginal.Height
            srcRect.X = CInt((iOriginal.Width - srcRect.Width) / 2)
            srcRect.Y = 0
        End If

        iThumb = New System.Drawing.Bitmap(newwidth, newheight)
        Dim g As Drawing.Graphics = Drawing.Graphics.FromImage(iThumb)
        g.DrawImage(iOriginal, New Drawing.Rectangle(0, 0, newwidth, newheight), srcRect, Drawing.GraphicsUnit.Pixel)

        Dim m As New System.IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function

    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal maxwidth As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scale As Double

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New System.IO.MemoryStream(fullsize))

        If iOriginal.Width > maxwidth Then

            scale = iOriginal.Width / maxwidth
            Dim newheight As Integer = CInt(iOriginal.Height / scale)

            iThumb = New System.Drawing.Bitmap(iOriginal, maxwidth, newheight)
            Dim m As New System.IO.MemoryStream()
            iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
            Return m.GetBuffer()
        Else
            Return fullsize
        End If

    End Function
#End Region
End Class