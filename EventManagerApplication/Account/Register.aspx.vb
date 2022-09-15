Imports System
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Owin
Imports Telerik.Web.UI
Imports BingGeocoder
Imports CuteWebUI
Imports System.IO

Partial Public Class Register
    Inherits Page
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Not Page.IsPostBack Then

            'Hidden temp UserID
            tempUserID.Value = System.Guid.NewGuid().ToString()
            lbluserID.Text = tempUserID.Value

            ddlYear.Items.Clear()

            Dim lt As ListItem = New ListItem

            lt.Text = "Year"
            lt.Value = ""
            ddlYear.Items.Add(lt)

            Dim i As Integer = DateTime.Now.Year
            Do While (i >= 1940)
                lt = New ListItem
                lt.Text = i.ToString
                lt.Value = i.ToString
                ddlYear.Items.Add(lt)
                i = (i - 1)
            Loop

            ddlYearAD.Items.Clear()

            Dim ADlt As ListItem = New ListItem

            ADlt.Text = "2017"
            ADlt.Value = "2017"
            ddlYearAD.Items.Add(ADlt)

            Dim j As Integer = DateTime.Now.Year
            Do While (j >= 2010)
                lt = New ListItem
                lt.Text = j.ToString
                lt.Value = j.ToString
                ddlYearAD.Items.Add(lt)
                j = (j - 1)
            Loop

        End If
    End Sub

    Private Sub RegistrationWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles RegistrationWizard.CancelButtonClick
        Response.Redirect("/")
    End Sub

    Private Sub RegistrationWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RegistrationWizard.FinishButtonClick

        Try

            Dim ambassador = (From p In db.tblAmbassadors Where p.EmailAddress = EmailAddressTextBox.Text Select p).ToList()

            'insert into ambassador
            Dim street_address As String = Address1TextBox.Text.Replace("#", "")

            Dim address As String = street_address & " " & CityTextBox.Text & ", " & StateDropDownList.SelectedValue & " " & ZipTextBox.Text

            Dim newAmbassador As New tblAmbassador
            'create a temporary ID
            newAmbassador.userID = tempUserID.Value

            newAmbassador.FirstName = FirstNameTextBox.Text
            newAmbassador.LastName = LastNameTextBox.Text
            newAmbassador.Address1 = Address1TextBox.Text
            newAmbassador.Address2 = Address2TextBox.Text
            newAmbassador.City = CityTextBox.Text
            newAmbassador.State = StateDropDownList.SelectedValue
            newAmbassador.Zip = ZipTextBox.Text
            newAmbassador.Phone = PhoneNumberTextBox.Text
            newAmbassador.EmailAddress = EmailAddressTextBox.Text
            newAmbassador.DOB = ddlMonth.SelectedValue & "/" & ddlDay.SelectedValue & "/" & ddlYear.SelectedValue
            newAmbassador.availabilityDate = ddlMonthAD.SelectedValue & "/" & ddlDayAD.SelectedValue & "/" & ddlYearAD.SelectedValue
            newAmbassador.citizen = True
            newAmbassador.gender = GenderDropDownList.SelectedValue

            newAmbassador.weight = WeightDropDownList.SelectedValue
            newAmbassador.height = HeightDropDownList.SelectedValue
            newAmbassador.hairColor = HairColorDropDownList.SelectedValue
            newAmbassador.eyeColor = EyeColorDropDownList.SelectedValue


            'newAmbassador.userGUID = PortalPasswordTextBox.Text
            'newAmbassador.userName = UserNameTextBox.Text
            newAmbassador.Status = "Pending"
            newAmbassador.LastLoginDate = Date.Now()

            newAmbassador.piersings = PiercingsDropDownList.SelectedValue
            newAmbassador.smartphone = SmartphoneDropDownList.SelectedValue
            newAmbassador.smartPhoneOS = SmartphoneOSDropDownList.SelectedValue


            newAmbassador.lgbt = LGBTAccountsDropDownList.SelectedValue
            newAmbassador.transportation = ReliableTransportation.SelectedValue

            newAmbassador.mile = WillingMilesDropDownList.SelectedValue
            Try
                'newAmbassador.licenseExpirationDate = LicenseExpirationDateTextBox.Text
            Catch ex As Exception

            End Try


            'headshot inage
            'For Each file As UploadedFile In headShotUpload.UploadedFiles
            '    Dim bytes(file.ContentLength - 1) As Byte
            '    file.InputStream.Read(bytes, 0, file.ContentLength)

            '    
            'Next

            'bodyshot image
            'For Each file2 As UploadedFile In bodyShotUpload.UploadedFiles
            '    Dim bytes2(file2.ContentLength - 1) As Byte
            '    file2.InputStream.Read(bytes2, 0, file2.ContentLength)

            '    
            'Next


            'headshot bodyshot image
            Dim checkpic2 = (From p In db.tblAmbassadorPhotos Where p.userID = tempUserID.Value Select p).FirstOrDefault

            If checkpic2.headshot IsNot Nothing Then
                newAmbassador.headShotUploaded = True
            Else
                newAmbassador.headShotUploaded = False
            End If

            If checkpic2.bodyshot IsNot Nothing Then
                newAmbassador.bodyShotUploaded = True
            Else
                newAmbassador.bodyShotUploaded = False
            End If



            db.tblAmbassadors.InsertOnSubmit(newAmbassador)
            db.SubmitChanges()





            'bodyshot image
            'For Each file2 As UploadedFile In bodyShotUpload.UploadedFiles
            '    Dim bytes2(file2.ContentLength - 1) As Byte
            '    file2.InputStream.Read(bytes2, 0, file2.ContentLength)

            '    newPhoto.bodyshot = MakeThumb(bytes2, 500)
            '    newPhoto.bodyshot_thumbnail = MakeThumb(bytes2, 100)
            '    newAmbassador.bodyShotUploaded = True
            'Next


            newAmbassador.latitude = getLatitude(address)
            newAmbassador.longitude = getLongitude(address)





            'if there are no images this procedure will add the default images
            db.UpdateHeadBodyShot()
            db.SubmitChanges()


            'update ambassador table
            'If resumeUpload.UploadedFiles.Count > 0 Then

            '    Dim a As New tblAmbassadorDocument
            '    For Each file As UploadedFile In resumeUpload.UploadedFiles
            '        Dim bytes(file.ContentLength - 1) As Byte
            '        file.InputStream.Read(bytes, 0, file.ContentLength)

            '        a.data = bytes
            '        a.documentName = file.FileName
            '        a.contentType = file.ContentType
            '        a.size = file.ContentLength
            '        a.dateUploaded = Date.Now()
            '        a.category = "Resume"
            '        a.uploadedBy = newAmbassador.userID
            '        a.userID = newAmbassador.userID

            '        db.tblAmbassadorDocuments.InsertOnSubmit(a)
            '        db.SubmitChanges()
            '    Next

            'End If



            'update ambassador table
            'If licenseUpload.UploadedFiles.Count > 0 Then

            '    Dim a2 As New tblAmbassadorDocument
            '    For Each file As UploadedFile In licenseUpload.UploadedFiles
            '        Dim bytes(file.ContentLength - 1) As Byte
            '        file.InputStream.Read(bytes, 0, file.ContentLength)

            '        a2.data = bytes
            '        a2.documentName = file.FileName
            '        a2.contentType = file.ContentType
            '        a2.size = file.ContentLength
            '        a2.dateUploaded = Date.Now()
            '        a2.category = "License"
            '        a2.uploadedBy = newAmbassador.userID
            '        a2.userID = newAmbassador.userID
            '        'a2.expirationDate = LicenseExpirationDateTextBox.Text
            '        a2.documentTitle = file.FileName

            '        db.tblAmbassadorDocuments.InsertOnSubmit(a2)
            '        db.SubmitChanges()
            '    Next

            'End If



            RegistrationWizard.Visible = False

            ConfirmationPanel.Visible = True



            'send email

            Dim q = (From p In db.tblMessages Where p.messageID = 5 Select p).FirstOrDefault

            Dim myString As String = ""
            myString = q.messageText
            myString = myString.Replace("[FirstName]", FirstNameTextBox.Text)
            myString = myString.Replace("[LastName]", LastNameTextBox.Text)

            Dim recipient = EmailAddressTextBox.Text

            'send email
            MailHelper.SendEmailMessage(5, recipient, q.fromAddress, q.fromName, q.subject, myString.ToString())



            'End If



        Catch ex As Exception
            msgLabel.Text = ex.Message()
        End Try


    End Sub

    Function getLatitude(ByVal address As String) As String

        Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

        Dim geocoder = New BingGeocoderClient(BingKey)
        Dim result = New BingGeocoderResult()
        result = geocoder.Geocode(address)

        Return result.Latitude

    End Function

    Function getLongitude(ByVal address As String) As String

        Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

        Dim geocoder = New BingGeocoderClient(BingKey)
        Dim result = New BingGeocoderResult()
        result = geocoder.Geocode(address)

        Return result.Longitude

    End Function

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


    Private Sub LicenseList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles LicenseList.ItemDataBound
        If LicenseList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If
    End Sub

    Private Sub ResumeList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles ResumeList.ItemDataBound
        If ResumeList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If
    End Sub

    Private Sub ResumeList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles ResumeList.ItemCommand
        If e.CommandName = "DeleteFile" Then
            db.DeleteAmbassadorDocument(Convert.ToInt32(e.CommandArgument))
        End If

        ResumeList.DataBind()
    End Sub

    Private Sub LicenseList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles LicenseList.ItemCommand
        If e.CommandName = "DeleteFile" Then
            db.DeleteAmbassadorDocument(Convert.ToInt32(e.CommandArgument))
        End If

        LicenseList.DataBind()

    End Sub

    Private Sub btnOpenUpload1_Click(sender As Object, e As EventArgs) Handles btnOpenUpload1.Click
        PanelDocuments.Visible = False
        UploadResumePanel.Visible = True
    End Sub

    Private Sub btnOpenUpload2_Click(sender As Object, e As EventArgs) Handles btnOpenUpload2.Click
        PanelDocuments.Visible = False
        UploadLicensePanel.Visible = True
    End Sub

    Private Sub btnCancelUploadResume_Click(sender As Object, e As EventArgs) Handles btnCancelUploadResume.Click
        PanelDocuments.Visible = True
        UploadResumePanel.Visible = False
    End Sub

    Private Sub btnCancelUploadLicense_Click(sender As Object, e As EventArgs) Handles btnCancelUploadLicense.Click
        PanelDocuments.Visible = True
        UploadLicensePanel.Visible = False
    End Sub

    Private Sub btnUploadResume_Click(sender As Object, e As EventArgs) Handles btnUploadResume.Click

        Try
            Dim ambassadorID = tempUserID.Value

            If resumeUpload.UploadedFiles.Count > 0 Then

                'update ambassador table
                Dim a As New tblAmbassadorDocument

                For Each file As UploadedFile In resumeUpload.UploadedFiles
                    Dim bytes(file.ContentLength - 1) As Byte
                    file.InputStream.Read(bytes, 0, file.ContentLength)

                    a.data = bytes
                    a.documentName = file.FileName
                    a.contentType = file.ContentType
                    a.size = file.ContentLength
                    a.dateUploaded = Date.Now()
                    a.category = "Resume"
                    a.uploadedBy = ambassadorID
                    a.userID = ambassadorID

                    db.tblAmbassadorDocuments.InsertOnSubmit(a)
                    db.SubmitChanges()
                Next

            End If


            ResumeList.DataBind()

            PanelDocuments.Visible = True
            UploadResumePanel.Visible = False

        Catch ex As Exception
            MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on Registration Page", ex.Message)

        End Try


    End Sub

    Private Sub btnUploadLicense_Click(sender As Object, e As EventArgs) Handles btnUploadLicense.Click

        Try
            Dim ambassadorID = tempUserID.Value

            If LicenseUpload2.UploadedFiles.Count > 0 Then

                'update ambassador table
                Dim a As New tblAmbassadorDocument

                For Each file As UploadedFile In LicenseUpload2.UploadedFiles
                    Dim bytes(file.ContentLength - 1) As Byte
                    file.InputStream.Read(bytes, 0, file.ContentLength)

                    a.data = bytes
                    a.documentName = file.FileName
                    a.contentType = file.ContentType
                    a.size = file.ContentLength
                    a.dateUploaded = Date.Now()
                    a.category = "License"
                    a.uploadedBy = ambassadorID
                    a.userID = ambassadorID
                    a.expirationDate = ExpirationTextBox.Text
                    a.documentTitle = LicenseNameTextBox.Text

                    db.tblAmbassadorDocuments.InsertOnSubmit(a)
                    db.SubmitChanges()
                Next

            End If

            LicenseList.DataBind()

            PanelDocuments.Visible = True
            UploadLicensePanel.Visible = False

            ExpirationTextBox.Text = ""
            LicenseNameTextBox.Text = ""
        Catch ex As Exception

            MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on Registration Page", ex.Message)

        End Try



    End Sub

    Private Sub btnGoToForm_Click(sender As Object, e As EventArgs) Handles btnGoToForm.Click

        ExistingRegistrationPanel.Visible = False
        RegistrationWizard.Visible = True

    End Sub

    Private Sub headshot1_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles headshot1.ItemCommand

        If e.CommandName = "DeleteImage" Then

            Dim id As Integer = e.CommandArgument

            Try
                'Dim deletephoto = db.DeletePhoto(id)

                headshot1.DataBind()
            Catch ex As Exception
                errorLabel.Text = ex.Message
            End Try


            'Dim photo = (From p In db.tblPhotos Where p.eventID = Request.QueryString("EventID") Select p)
            'If photo.Count = 0 Then
            '    MissingPhotoPanel.Visible = True
            'Else
            '    MissingPhotoPanel.Visible = False
            'End If


        End If

    End Sub


    Protected Sub UploadAttachments1_HeadShot(ByVal sender As Object, ByVal args As UploaderEventArgs)

        Try

            ' Read the file and convert it to Byte Array
            Dim data() As Byte = New Byte((args.FileSize) - 1) {}

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

            'check if has a picture allready
            Dim checkpic = (From p In db.tblAmbassadorPhotos Where p.userID = tempUserID.Value Select p)

            If checkpic.Count = 0 Then
                'directly add the photo
                Dim newPhoto As New tblAmbassadorPhoto
                newPhoto.userID = tempUserID.Value
                newPhoto.headshot = MakeThumb(data, 500)
                newPhoto.headshot_thumbnail = MakeThumb(data, 100)

                db.tblAmbassadorPhotos.InsertOnSubmit(newPhoto)
                db.SubmitChanges()

            Else
                'update photo
                Dim a = (From p In db.tblAmbassadorPhotos Where p.userID = tempUserID.Value Select p).FirstOrDefault
                a.headshot = MakeThumb(data, 500)
                a.headshot_thumbnail = MakeThumb(data, 100)

                db.SubmitChanges()

            End If


            Dim checkpic2 = (From p In db.tblAmbassadorPhotos Where p.userID = tempUserID.Value Select p).FirstOrDefault

            If checkpic2.bodyshot IsNot Nothing Then
                HeadBodyShot.Text = "Success"
            Else

            End If


        Catch ex As Exception
            'ErrorPanel.Visible = True
            errorLabel.Text = ex.Message

            headshot1.DataBind()

        End Try


        headshot1.DataBind()

        HeadShotPanel.Visible = True


    End Sub


    Protected Sub UploadAttachments2_BodyShot(ByVal sender As Object, ByVal args As UploaderEventArgs)

        Try

            'Read the file and convert it to Byte Array
            Dim data2() As Byte = New Byte((args.FileSize) - 1) {}

            'get file extension
            Dim extensioin2 As String = args.FileName.Substring((args.FileName.LastIndexOf(".") + 1))
            Dim fileType2 As String = ""

            'set the file type based on File Extension
            Select Case (extensioin2)
                Case "doc"
                    fileType2 = "application/vnd.ms-word"
                Case "docx"
                    fileType2 = "application/vnd.ms-word"
                Case "xls"
                    fileType2 = "application/vnd.ms-excel"
                Case "xlsx"
                    fileType2 = "application/vnd.ms-excel"
                Case "jpg"
                    fileType2 = "image/jpg"
                Case "png"
                    fileType2 = "image/png"
                Case "gif"
                    fileType2 = "image/gif"
                Case "pdf"
                    fileType2 = "application/pdf"
            End Select

            Dim stream As Stream = args.OpenStream

            'read the file as stream
            stream.Read(data2, 0, data2.Length)

            'check if has a picture allready
            Dim checkpic = (From p In db.tblAmbassadorPhotos Where p.userID = tempUserID.Value Select p)

            If checkpic.Count = 0 Then
                'directly add the photo
                Dim newPhoto2 As New tblAmbassadorPhoto
                newPhoto2.userID = tempUserID.Value
                newPhoto2.bodyshot = MakeThumb(data2, 500)
                newPhoto2.bodyshot_thumbnail = MakeThumb(data2, 100)

                db.tblAmbassadorPhotos.InsertOnSubmit(newPhoto2)
                db.SubmitChanges()

            Else
                'update photo
                Dim a = (From p In db.tblAmbassadorPhotos Where p.userID = tempUserID.Value Select p).FirstOrDefault
                a.bodyshot = MakeThumb(data2, 500)
                a.bodyshot_thumbnail = MakeThumb(data2, 100)

                db.SubmitChanges()

            End If


            Dim checkpic2 = (From p In db.tblAmbassadorPhotos Where p.userID = tempUserID.Value Select p).FirstOrDefault

            If checkpic2.headshot IsNot Nothing Then
                HeadBodyShot.Text = "Success"
            Else

            End If


        Catch ex As Exception
            'ErrorPanel.Visible = True
            errorLabel.Text = ex.Message

            bodyShot2.DataBind()

        End Try


        bodyShot2.DataBind()

        BodyshotPanel.Visible = True





        ' Dim bytes(file.ContentLength - 1) As Byte
        ' File.InputStream.Read(bytes, 0, file.ContentLength)
        'headshot image
        'Dim bytes(File.ContentLength - 1) As Byte
        'File.InputStream.Read(bytes, 0, File.ContentLength)
        'newAmbassador.headShotUploaded = True
        'bodyshot image
        'For Each file2 As UploadedFile In bodyShotUpload.UploadedFiles
        '    Dim bytes2(file2.ContentLength - 1) As Byte
        '    file2.InputStream.Read(bytes2, 0, file2.ContentLength)

        '    newPhoto.bodyshot = MakeThumb(bytes2, 500)
        '    newPhoto.bodyshot_thumbnail = MakeThumb(bytes2, 100)
        '    newAmbassador.bodyShotUploaded = True
        'Next

    End Sub

End Class

