Imports System.IO
Imports CuteWebUI
Imports Telerik.Web.UI

Public Class EditPOSItems1
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Page.Title = "Editing Item"


        If Not Page.IsPostBack Then

            Dim q = (From p In db.qryIsBrandInGroups Where p.brandID = Request.QueryString("BrandID") Select p).Count

            If q = 0 Then
                AddtoGroupPanel.Visible = False
                'ckbxInGroup.SelectedValue = "False"
            Else
                AddtoGroupPanel.Visible = True
                '  ckbxInGroup.SelectedValue = (From p In db.tblInventoryItems Where p.itemID = Request.QueryString("ItemID") Select p.inGroup).FirstOrDefault
            End If


            btnDownload.NavigateUrl = "/Admin/POSPhotoHandler.aspx?photoID=" & Request.QueryString("ItemID")

        End If


    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click

        If lblPath.Text = "" Then

        Else
            'delete the photo from the temp folder
            Try
                Dim filePath2 As String = Server.MapPath(lblPath.Text)
                System.IO.File.Delete(filePath2)
            Catch ex As Exception
                'do nothing
            End Try
        End If

        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CancelEdit();", True)
    End Sub

    Protected Sub UploadAttachments1_Photo(ByVal sender As Object, ByVal args As UploaderEventArgs)

        Try

            If lblPath.Text = "" Then

                'Get the full path of file that will be saved.
                Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
                lblPath.Text = virpath

                'Map the path to to a physical path.
                Dim savepath As String = Server.MapPath(virpath)

                'Do not overwrite an existing file
                If System.IO.File.Exists(savepath) Then
                    Return
                End If

                'Move the uploaded file to the target location
                args.MoveTo(savepath)


                headshot.Visible = False
                PhotoPanel.Visible = True
                lblInfoPhoto.Visible = True
                Image1.ImageUrl = virpath
                Image1.DataBind()
                btnDownload.Visible = False

            Else

                Try
                    Dim filePath2 As String = Server.MapPath(lblPath.Text)
                    System.IO.File.Delete(filePath2)
                    lblPath.Text = ""
                Catch ex As Exception
                    'do nothing
                End Try

                'Get the full path of file that will be saved.
                Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
                lblPath.Text = virpath

                'Map the path to to a physical path.
                Dim savepath As String = Server.MapPath(virpath)

                'Do not overwrite an existing file
                If System.IO.File.Exists(savepath) Then
                    Return
                End If

                'Move the uploaded file to the target location
                args.MoveTo(savepath)

                headshot.Visible = False
                PhotoPanel.Visible = True
                lblInfoPhoto.Visible = True
                Image1.ImageUrl = virpath
                Image1.DataBind()
                btnDownload.Visible = False

            End If

        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        InventoryItemForm.UpdateItem(True)

        Dim posItem = (From p In db.tblInventoryItems Where p.itemID = Request.QueryString("ItemID") Select p).FirstOrDefault

        'upload the photo
        If lblPath.Text = "" Then

        Else

            Dim filePath As String = Server.MapPath(lblPath.Text)

            Dim filename As String = Path.GetFileName(filePath)


            Dim fs As FileStream = New FileStream(filePath, FileMode.Open, FileAccess.Read)

            Dim br As BinaryReader = New BinaryReader(fs)

            Dim bytes As Byte() = br.ReadBytes(Convert.ToInt32(fs.Length))

            posItem.image = MakeThumb(bytes, 500)
            posItem.thumbnail = MakeThumb(bytes, 100)


            br.Close()

            fs.Close()

        End If


        'For Each file As UploadedFile In RadAsyncUpload1.UploadedFiles
        '    Dim bytes(file.ContentLength - 1) As Byte
        '    file.InputStream.Read(bytes, 0, file.ContentLength)

        '    posItem.image = MakeThumb(bytes, 500)
        '    posItem.thumbnail = MakeThumb(bytes, 100)
        'Next

        '  posItem.inGroup = ckbxInGroup.SelectedValue

        db.SubmitChanges()



        'delete the photo from the temp folder
        Try
            Dim filePath2 As String = Server.MapPath(lblPath.Text)
            System.IO.File.Delete(filePath2)
        Catch ex As Exception
            'do nothing
        End Try


        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", True)
    End Sub

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
End Class