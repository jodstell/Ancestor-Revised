Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.IO
Imports System.Runtime.Serialization
Imports CuteWebUI
Imports Microsoft.AspNet.Identity

Public Class TestUploader
    Inherits System.Web.UI.Page

    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    'Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click

    '    Try
    '        Dim filePath2 As String = Server.MapPath(lblPath.Text)
    '        System.IO.File.Delete(filePath2)
    '        lblPath.Text = ""
    '    Catch ex As Exception
    '        'Do nothing
    '    End Try

    '    Response.Redirect("/Account/TestUploader.aspx")
    'End Sub

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

                PhotoPanel.Visible = True
                Image1.ImageUrl = virpath
                Image1.DataBind()

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

                PhotoPanel.Visible = True
                Image1.ImageUrl = virpath
                Image1.DataBind()


            End If

        Catch ex As Exception
            msgLabel.Text = Common.ShowAlertNoClose("warning", ex.Message())
        End Try

    End Sub

    Protected Sub UploadAttachments1_FileUploaded(ByVal sender As Object, ByVal args As UploaderEventArgs)


        Try
            ' Read the file and convert it to Byte Array
            Dim data As Byte() = New Byte((args.FileSize) - 1) {}

            'get file extension
            Dim extensioin As String = args.FileName.Substring((args.FileName.LastIndexOf(".") + 1))
            Dim fileType As String = ""

            'set the file type based on File Extension
            Select Case (extensioin)
                Case "doc"
                    fileType = "application/vnd.ms-word"
                Case "docx"
                    fileType = "application/vnd.ms-word"
                Case "xls"
                    fileType = "application/vnd.ms-excel"
                Case "xlsx"
                    fileType = "application/vnd.ms-excel"
                Case "jpg"
                    fileType = "image/jpg"
                Case "png"
                    fileType = "image/png"
                Case "gif"
                    fileType = "image/gif"
                Case "pdf"
                    fileType = "application/pdf"
            End Select

            Dim stream As Stream = args.OpenStream

            'read the file as stream
            stream.Read(data, 0, data.Length)

            ' Dim bytes(file.ContentLength - 1) As Byte
            ' File.InputStream.Read(bytes, 0, file.ContentLength

            Dim image As New tempPhoto
            image.photoTitle = "Test"
            image.fileName = args.FileName
            'image.photoDescription = "Test for rotation."
            'image.keywords = "CuteUploader"
            image.tag = Request.UserAgent.ToString().ToLower()
            'image.Image = data


            Dim ms As New MemoryStream(data)
            Dim originalImage As System.Drawing.Image = System.Drawing.Image.FromStream(ms)

            If originalImage.PropertyIdList.Contains(&H112) Then
                Dim rotationValue As Integer = originalImage.GetPropertyItem(&H112).Value(0)
                Select Case rotationValue
                    Case 1
                        'landscape, do nothing
                        image.Image = data

                        image.photoDescription = "Case 1"
                        image.keywords = "Not Rotated"

                        Exit Select

                    Case 2
                        originalImage.RotateFlip(RotateFlipType.RotateNoneFlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        image.Image = m.GetBuffer()

                        image.photoDescription = "Case 2"
                        image.keywords = "Rotated"

                        Exit Select

                    Case 3
                        ' bottoms up
                        originalImage.RotateFlip(RotateFlipType.Rotate180FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        image.Image = m.GetBuffer()

                        image.photoDescription = "Case 3"
                        image.keywords = "Rotated"

                        Exit Select

                    Case 4
                        originalImage.RotateFlip(RotateFlipType.Rotate180FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        image.Image = m.GetBuffer()

                        image.photoDescription = "Case 4"
                        image.keywords = "Rotated"

                        Exit Select

                    Case 5
                        originalImage.RotateFlip(RotateFlipType.Rotate90FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        image.Image = m.GetBuffer()

                        image.photoDescription = "Case 5"
                        image.keywords = "Rotated"

                        Exit Select

                    Case 6
                        ' rotated 90 left
                        originalImage.RotateFlip(RotateFlipType.Rotate90FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        image.Image = m.GetBuffer()

                        image.photoDescription = "Case 6"
                        image.keywords = "Rotated"

                        Exit Select

                    Case 7
                        'originalImage.RotateFlip(RotateFlipType.Rotate270FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        image.Image = m.GetBuffer()

                        image.photoDescription = "Case 7"
                        image.keywords = "Rotated"

                        Exit Select

                    Case 8
                        ' rotated 90 right
                        ' de-rotate:
                        originalImage.RotateFlip(RotateFlipType.Rotate270FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        image.Image = m.GetBuffer()

                        image.photoDescription = "Case 8"
                        image.keywords = "Rotated"

                        Exit Select

                End Select

            Else
                'Dim pi As PropertyItem = CType(FormatterServices.GetUninitializedObject(GetType(PropertyItem)), PropertyItem)
                'image.photoDescription = Convert.ToString(pi.Value)

                image.Image = data
                image.photoDescription = "Case Nothing"
                image.keywords = "Not Rotated"
            End If


            db.tempPhotos.InsertOnSubmit(image)
            db.SubmitChanges()

            stream.Close()

        Catch ex As Exception

            PhotoListView.DataBind()

        End Try

        Try

        Catch ex As Exception
            msgLabel.Text = ex.Message.ToString()
        End Try


        PhotoListView.DataBind()

        'Response.Redirect("/Account/TestUploader.aspx")



    End Sub

    'Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

    '    Try

    '        'Dim manager = New UserManager()
    '        'Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '        'Dim image As New tblPhoto
    '        'image.photoTitle = Path.GetFileName(filePath)
    '        'expense.eventStaffingRequirementID = Hidden_EventRequirementStaffingID.Value
    '        'expense.expenseTypeID = ddlExpenseType.SelectedValue
    '        'expense.description = descriptionTextBox.Text
    '        'expense.amount = amountTextBox.Text
    '        'expense.submittedDate = Date.Now()
    '        'expense.submittedBy = currentUser.Id


    '        Dim filePath2 As String = Server.MapPath(lblPath.Text)

    '        Dim image As New tempPhoto
    '        image.photoTitle = Path.GetFileName(filePath2)
    '        image.fileName = "TestUploader.png"
    '        image.photoDescription = "Test for rotation."
    '        image.keywords = "CuteUploader"


    '        'upload the receipt
    '        If lblPath.Text = "" Then

    '        Else

    '            Dim filePath As String = Server.MapPath(lblPath.Text)

    '            Dim filename As String = Path.GetFileName(filePath)


    '            Dim fs As FileStream = New FileStream(filePath, FileMode.Open, FileAccess.Read)

    '            Dim br As BinaryReader = New BinaryReader(fs)

    '            Dim bytes As Byte() = br.ReadBytes(Convert.ToInt32(fs.Length))


    '            Dim ms As New MemoryStream(bytes)
    '            Dim originalImage = System.Drawing.Image.FromStream(ms)

    '            If originalImage.PropertyIdList.Contains(&H112) Then
    '                Dim rotationValue As Integer = originalImage.GetPropertyItem(&H112).Value(0)
    '                Select Case rotationValue
    '                    Case 1
    '                        ' landscape, do nothing
    '                        Exit Select

    '                    Case 2
    '                        originalImage.RotateFlip(RotateFlipType.RotateNoneFlipX)

    '                        Dim bmp As New Bitmap(originalImage)
    '                        Dim m As New IO.MemoryStream()
    '                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

    '                        image.Image = m.GetBuffer()

    '                        Exit Select

    '                    Case 3
    '                        ' bottoms up
    '                        originalImage.RotateFlip(RotateFlipType.Rotate180FlipNone)

    '                        Dim bmp As New Bitmap(originalImage)
    '                        Dim m As New IO.MemoryStream()
    '                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

    '                        image.Image = m.GetBuffer()

    '                        Exit Select

    '                    Case 4
    '                        originalImage.RotateFlip(RotateFlipType.Rotate180FlipX)

    '                        Dim bmp As New Bitmap(originalImage)
    '                        Dim m As New IO.MemoryStream()
    '                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

    '                        image.Image = m.GetBuffer()

    '                        Exit Select

    '                    Case 5
    '                        originalImage.RotateFlip(RotateFlipType.Rotate90FlipX)

    '                        Dim bmp As New Bitmap(originalImage)
    '                        Dim m As New IO.MemoryStream()
    '                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

    '                        image.Image = m.GetBuffer()

    '                        Exit Select

    '                    Case 6
    '                        ' rotated 90 left
    '                        originalImage.RotateFlip(RotateFlipType.Rotate90FlipNone)

    '                        Dim bmp As New Bitmap(originalImage)
    '                        Dim m As New IO.MemoryStream()
    '                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

    '                        image.Image = m.GetBuffer()

    '                        Exit Select

    '                    Case 7
    '                        originalImage.RotateFlip(RotateFlipType.Rotate270FlipX)

    '                        Dim bmp As New Bitmap(originalImage)
    '                        Dim m As New IO.MemoryStream()
    '                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

    '                        image.Image = m.GetBuffer()

    '                        Exit Select

    '                    Case 8
    '                        ' rotated 90 right
    '                        ' de-rotate:
    '                        originalImage.RotateFlip(RotateFlipType.Rotate270FlipNone)

    '                        Dim bmp As New Bitmap(originalImage)
    '                        Dim m As New IO.MemoryStream()
    '                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

    '                        image.Image = m.GetBuffer()

    '                        Exit Select

    '                End Select
    '            End If


    '            br.Close()

    '            fs.Close()

    '        End If

    '        'Dim imageData As Byte() = New Byte(FileUpload.ContentLength - 1) {}
    '        'FileUpload.InputStream.Read(imageData, 0, FileUpload.ContentLength)



    '        db.tempPhotos.InsertOnSubmit(image)
    '        db.SubmitChanges()



    '        'ReceiptUploadAttachments.Upload(ReceiptUploadAttachments.Items(0).FileSize, ReceiptUploadAttachments.Items(0).FileName, ReceiptUploadAttachments.Items(0).OpenStream)

    '        'Dim data() As Byte = New Byte((ReceiptUploadAttachments.Items(0).FileSize) - 1) {}

    '        '    Dim extensioin As String = ReceiptUploadAttachments.Items(0).FileName.Substring((ReceiptUploadAttachments.Items(0).FileName.LastIndexOf(".") + 1))
    '        '    Dim fileType As String = ""

    '        '    'set the file type based on File Extension
    '        '    Select Case (extensioin)
    '        '        Case "doc"
    '        '            fileType = "application/vnd.ms-word"
    '        '        Case "docx"
    '        '            fileType = "application/vnd.ms-word"
    '        '        Case "xls"
    '        '            fileType = "application/vnd.ms-excel"
    '        '        Case "xlsx"
    '        '            fileType = "application/vnd.ms-excel"
    '        '        Case "jpg"
    '        '            fileType = "image/jpg"
    '        '        Case "png"
    '        '            fileType = "image/png"
    '        '        Case "gif"
    '        '            fileType = "image/gif"
    '        '        Case "pdf"
    '        '            fileType = "application/pdf"
    '        '    End Select

    '        'Dim stream As Stream = ReceiptUploadAttachments.Items(0).OpenStream

    '        ''read the file as stream
    '        'stream.Read(data, 0, data.Length)


    '        'expense.receipt = (data)

    '        'stream.Close()

    '        'For Each file As UploadedFile In ReceiptUploadAttachments.Items
    '        '    Dim bytes(file.ContentLength - 1) As Byte
    '        '    file.InputStream.Read(bytes, 0, file.ContentLength)

    '        '    expense.receipt = (bytes)
    '        'Next



    '        Try
    '            'add to history log
    '            'lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Expense Added", "An expense has been added to an event", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)
    '        Catch ex1 As Exception
    '            ' do nothing
    '        End Try


    '        'EventExpenseList.DataBind()


    '        'delete the photo from the temp folder
    '        Try
    '            Dim filePath3 As String = Server.MapPath(lblPath.Text)
    '            System.IO.File.Delete(filePath3)
    '            lblPath.Text = ""

    '        Catch ex As Exception
    '            'do nothing
    '        End Try


    '    Catch ex As Exception

    '        msgLabel.Text = Common.ShowAlertNoClose("danger", "There was a problem saving your image.  Please try again.")

    '        'add to history log
    '        'lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Error adding Expense", ex.Message, Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)


    '        'EventExpenseList.DataBind()

    '        'clear the form
    '        'ddlExpenseType.SelectedIndex = 0
    '        'descriptionTextBox.Text = ""
    '        'amountTextBox.Text = ""

    '        'AddNewExpensePanel.Visible = False
    '        'RecapWizard.Visible = True

    '        PhotoListView.DataBind()

    '        Response.Redirect("/Account/TestUploader.aspx")

    '    End Try

    'End Sub


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

End Class