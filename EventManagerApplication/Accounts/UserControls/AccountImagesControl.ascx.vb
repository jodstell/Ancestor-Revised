Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class AccountImagesControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


        For Each file As UploadedFile In RadAsyncUpload1.UploadedFiles

            Dim bytes(file.ContentLength - 1) As Byte
            file.InputStream.Read(bytes, 0, file.ContentLength)


            Dim i As New tblAccountPhoto
            i.Image = MakeThumb(bytes, 1200)
            i.LargeImage = MakeThumb(bytes, 500) '1
            i.SmallImage = MakeThumb(bytes, 350) '2
            i.ThumbImage = MakeThumb(bytes, 100) '3

            i.photoTitle = ""
            i.dateUploaded = Date.Now()
            i.uploadedBy = currentUser.Id
            i.fileName = file.GetName

            i.accountID = Request.QueryString("AccountID")
            db.tblAccountPhotos.InsertOnSubmit(i)
            db.SubmitChanges()

        Next

        PhotoListView.DataBind()


        'show/hide panels
        UploadPanel.Visible = False
        ViewPanel.Visible = True
        ButtonPanel.Visible = True


    End Sub


    Protected Property ImageWidth() As Unit

        Get
            Dim state As Object = If(ViewState("ImageWidth"), Unit.Pixel(150))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageWidth") = value
        End Set

    End Property

    Protected Property ImageHeight() As Unit
        Get
            Dim state As Object = If(ViewState("ImageHeight"), Unit.Pixel(150))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageHeight") = value
        End Set

    End Property




    Const sizeThumb As Integer = 100

    Public Shared Function MakeThumb(ByVal fullsize As Byte()) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim targetH, targetW As Integer

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image
        If (iOriginal.Height > iOriginal.Width) Then
            targetH = sizeThumb
            targetW = CInt(iOriginal.Width * (sizeThumb / iOriginal.Height))
        Else
            targetW = sizeThumb
            targetH = CInt(iOriginal.Height * (sizeThumb / iOriginal.Width))
        End If
        iThumb = iOriginal.GetThumbnailImage(targetW, targetH, Nothing, System.IntPtr.Zero)
        Dim m As New IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function


    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal newwidth As Integer, ByVal newheight As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scaleH, scaleW As Double
        Dim srcRect As Drawing.Rectangle


        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))
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

        Dim m As New IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function

    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal maxwidth As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scale As Double

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))

        If iOriginal.Width > maxwidth Then

            scale = iOriginal.Width / maxwidth
            Dim newheight As Integer = CInt(iOriginal.Height / scale)

            iThumb = New System.Drawing.Bitmap(iOriginal, maxwidth, newheight)
            Dim m As New IO.MemoryStream()
            iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
            Return m.GetBuffer()
        Else
            Return fullsize
        End If
    End Function

    Private Sub PhotoListView_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PhotoListView.ItemCommand
        'If e.CommandName = "DeleteImage" Then

        '    Dim id As Integer = e.CommandArgument

        '    Try
        '        Dim deletephoto = db.DeletePhoto(id)

        '        PhotoListView.DataBind()
        '    Catch ex As Exception
        '        errorLabel.Text = ex.Message
        '    End Try


        'End If
    End Sub

    Private Sub AddPhotoButton_Click(sender As Object, e As EventArgs) Handles AddPhotoButton.Click
        UploadPanel.Visible = True
        ViewPanel.Visible = False
        ButtonPanel.Visible = False
    End Sub

    Private Sub btnCancelUpload_Click(sender As Object, e As EventArgs) Handles btnCancelUpload.Click
        UploadPanel.Visible = False
        ViewPanel.Visible = True
        ButtonPanel.Visible = True
    End Sub

    Protected Function CreateWindowScript(ByVal accountID As Integer, ByVal photoID As Integer) As String
        Return String.Format("var win = window.radopen('/Accounts/PhotoDetails.aspx?AccountID={0}&PhotoID={1}','Details');win.center();", accountID, photoID)
    End Function

End Class