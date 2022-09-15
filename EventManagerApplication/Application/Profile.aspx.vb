Imports Telerik.Web.UI
Imports System.Drawing
Imports System.Drawing.Drawing2D
Imports BingGeocoder
Imports System.Globalization
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports CuteWebUI
Imports System.IO

Public Class Profile
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim userdb As New LMSDataClassesDataContext
    Dim userid As String

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Then
            StaffPanel.Visible = False
            MainPanel.Visible = True
        Else
            StaffPanel.Visible = True
            MainPanel.Visible = False
        End If


        If Not Page.IsPostBack Then

            Dim userid As String = currentUser.Id
            Session.Add("CurrentUserID", userid)
            BindForm(userid)


            Dim q = From p In db.tblProfiles Where p.userID = currentUser.Id Select p
            For Each p In q
                FirstName.Text = p.firstName
                LastName.Text = p.lastName
                LastLoginDate.Text = p.lastLoginDate
                'TimeZone.Text = p.timeZone
                ddlTimeZone.SelectedValue = p.timeZone
                UserName.Text = p.userName
                PortalPassword.Text = p.userGUID

                phoneNumberTextBox.Text = currentUser.PhoneNumber
                EmailTextBox.Text = currentUser.Email

            Next


        End If


        Dim action = Request.QueryString("action")

        Select Case action
            Case 0
                RadNotification1.Show()
                RadNotification1.Text = "Your changes were updated sucessfully!"
                RadNotification1.Title = "Success"
                RadNotification1.TitleIcon = "info"
                RadNotification1.ShowSound = True
            Case 1
                msgLabel.Text = Common.ShowAlert("success", "Your changes were updated sucessfully!")
            Case 2
                msgLabel.Text = Common.ShowAlert("success", "The file was uploaded successfully!")
            Case 3
                msgLabel.Text = Common.ShowAlert("success", "Your password has been changed!")

        End Select



    End Sub



    Sub BindForm(ByVal id As String)


        ddlYear.Items.Clear()
        ddlYearAD.Items.Clear()

        Dim lt As ListItem = New ListItem

        lt.Text = "Year"
        lt.Value = ""
        ddlYear.Items.Add(lt)
        ddlYearAD.Items.Add(lt)

        Dim i As Integer = DateTime.Now.Year
        Do While (i >= 1940)
            lt = New ListItem
            lt.Text = i.ToString
            lt.Value = i.ToString
            ddlYear.Items.Add(lt)
            i = (i - 1)
        Loop


        Dim j As Integer = DateTime.Now.Year
        Do While (j >= 2010)
            lt = New ListItem
            lt.Text = j.ToString
            lt.Value = j.ToString
            ddlYearAD.Items.Add(lt)
            j = (j - 1)
        Loop


        Dim Ambassador = (From p In db.tblAmbassadors Where p.userID = id Select p)

        For Each p In Ambassador
            FirstNameTextBox.Text = StrConv(p.FirstName, VbStrConv.ProperCase)
            LastNameTextBox.Text = StrConv(p.LastName, VbStrConv.ProperCase)
            EmailAddressTextBox.Text = p.EmailAddress
            Try
                GenderDropDownList.SelectedValue = p.gender
                HeightDropDownList.SelectedValue = p.height
                WeightDropDownList.SelectedValue = p.weight
            Catch ex As Exception

            End Try

            Try
                HairColorDropDownList.SelectedValue = p.hairColor
                EyeColorDropDownList.SelectedValue = p.eyeColor
                PiersingsDropDownList.SelectedValue = p.piersings
                SmartphoneDropDownList.SelectedValue = p.smartphone
                SmartphoneOSRadComboBox.SelectedValue = p.smartPhoneOS
                LGBTAccountsDropDownList.SelectedValue = p.lgbt
                ReliableTransportation.SelectedValue = p.transportation
                WillingMilesRadComboBox.SelectedValue = p.mile
            Catch ex As Exception

            End Try


            Try
                ddlMonthAD.SelectedValue = Month(p.availabilityDate)
                ddlDayAD.SelectedValue = Day(p.availabilityDate)
                ddlYearAD.SelectedValue = Year(p.availabilityDate)
            Catch ex As Exception

            End Try

            Try
                ddlMonth.SelectedValue = Month(p.DOB)
                ddlDay.SelectedValue = Day(p.DOB)
                ddlYear.SelectedValue = Year(p.DOB)
            Catch ex As Exception

            End Try


            Address1TextBox.Text = p.Address1
            Address2TextBox.Text = p.Address2
            CityTextBox.Text = p.City
            phoneNumberTextBoxambass.Text = p.Phone
            StateDropDownList.Text = p.State
            ZipTextBox.Text = p.Zip

            Try
                CitizenDropDownList.SelectedValue = p.citizen
            Catch ex As Exception

            End Try

            If p.latitude > 0 Then
                AddressVerifiedCheckBox.Checked = True
                BtnValidateAddress.Visible = False
                ValidateHelpLabel.Visible = False
            Else
                AddressVerifiedCheckBox.Checked = False
                BtnValidateAddress.Visible = True
                ValidateHelpLabel.Visible = True
            End If

        Next

        'Dim userProfile = (From p In db.tblProfiles Where p.userID = id).FirstOrDefault
        'userProfile.firstName = FirstNameTextBox.Text
        'userProfile.lastName = LastNameTextBox.Text
        '' userProfile.timeZone = ddlTimeZone.SelectedValue
        'userProfile.modifiedBy = Context.User.Identity.GetUserId()
        'userProfile.modifiedDate = Date.Now()

        'db.SubmitChanges()

        'Try
        '    Dim Profile = (From p In userdb.AspNetUsersProfiles Where p.UserID = id Select p)
        '    For Each p In Profile
        '        MiddleNameTextBox.Text = p.NickName
        '    Next
        'Catch ex As Exception

        'End Try


    End Sub


    Private Sub CancelButton_Click(sender As Object, e As EventArgs) Handles CancelButton.Click
        Response.Redirect("/ambassadors/dashboard")
    End Sub


    Private Sub UpdateButton_Click(sender As Object, e As EventArgs) Handles UpdateButton.Click


        Try
            Dim ti As TextInfo = New CultureInfo("en-US", False).TextInfo


            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            Dim userid As String = currentUser.Id


            ''change username
            'Dim currentUserName As String = (From u In userdb.AspNetUsers Where u.Id = Request.QueryString("UserID") Select u.UserName).FirstOrDefault
            'Dim newUserName As String = PayrollIDTextBox.Text

            'If currentUserName = newUserName Then
            '    'do nothing
            'Else
            '    'update the username in AspNetUsers
            '    Dim user = (From u In userdb.AspNetUsers Where u.Id = Request.QueryString("UserID") Select u).FirstOrDefault
            '    user.UserName = PayrollIDTextBox.Text
            '    userdb.SubmitChanges()

            '    'update any assigned events
            '    db.updateUserName(currentUserName, newUserName)
            'End If



            'update the aspNetUserProfile
            Dim userProfile = (From p In userdb.AspNetUsersProfiles Where p.UserID = userid).FirstOrDefault

            'update ambassador table
            Dim a = (From p In db.tblAmbassadors Where p.userID = userid Select p).FirstOrDefault

            'a.userName = PayrollIDTextBox.Text
            a.gender = GenderDropDownList.SelectedValue
            a.citizen = CitizenDropDownList.SelectedValue
            a.height = HeightDropDownList.SelectedValue
            a.weight = WeightDropDownList.SelectedValue
            a.hairColor = HairColorDropDownList.SelectedValue
            a.eyeColor = EyeColorDropDownList.SelectedValue
            a.piersings = PiersingsDropDownList.SelectedValue
            a.smartphone = SmartphoneDropDownList.SelectedValue
            a.smartPhoneOS = SmartphoneOSRadComboBox.SelectedValue
            a.lgbt = LGBTAccountsDropDownList.SelectedValue
            a.transportation = ReliableTransportation.SelectedValue
            a.mile = WillingMilesRadComboBox.SelectedValue

            Dim ad As Date = ddlMonthAD.SelectedValue & "/" & ddlDayAD.SelectedValue & "/" & ddlYearAD.SelectedValue
            a.availabilityDate = ad

            a.FirstName = FirstNameTextBox.Text
            userProfile.FirstName = FirstNameTextBox.Text

            a.NickName = MiddleNameTextBox.Text
            userProfile.NickName = MiddleNameTextBox.Text

            a.LastName = LastNameTextBox.Text
            userProfile.LastName = LastNameTextBox.Text

            a.EmailAddress = EmailAddressTextBox.Text


            Dim d As Date = ddlMonth.SelectedValue & "/" & ddlDay.SelectedValue & "/" & ddlYear.SelectedValue
            a.DOB = d
            userProfile.DOB = d

            a.Address1 = ti.ToTitleCase(Address1TextBox.Text)
            userProfile.Address = ti.ToTitleCase(Address1TextBox.Text)

            a.Address2 = Address2TextBox.Text
            userProfile.Address2 = Address2TextBox.Text

            a.City = ti.ToTitleCase(CityTextBox.Text)
            userProfile.City = ti.ToTitleCase(CityTextBox.Text)

            a.Phone = phoneNumberTextBoxambass.Text
            userProfile.Phone1 = phoneNumberTextBoxambass.Text

            a.State = StateDropDownList.SelectedValue
            userProfile.State = StateDropDownList.SelectedValue

            a.Zip = ZipTextBox.Text
            userProfile.PostCode = ZipTextBox.Text

            a.modifiedDate = Date.Now()

            Dim z = (From p In db.tblProfiles Where p.userID = userid Select p).FirstOrDefault

            z.firstName = FirstNameTextBox.Text
            z.lastName = LastNameTextBox.Text
            z.nickName = MiddleNameTextBox.Text
            'z.userName = PayrollIDTextBox.Text
            z.modifiedBy = Context.User.Identity.GetUserId()
            z.modifiedDate = Date.Now()

            db.SubmitChanges()
            userdb.SubmitChanges()



            'Response.Redirect("/ambassadors/dashboard")

            RadNotification1.Show()
            RadNotification1.Text = "Your changes were updated sucessfully!"
            RadNotification1.Title = "Success"
            RadNotification1.TitleIcon = "info"
            RadNotification1.ShowSound = True

        Catch ex As Exception
            msgLabel.Text = ex.Message()
        End Try

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


            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            'update ambassador table
            If (From p In db.tblAmbassadorPhotos Where p.userID = currentUser.Id Select p).Count = 0 Then
                'create a record
                Dim newPhoto As New tblAmbassadorPhoto With {.userID = currentUser.Id}
                db.tblAmbassadorPhotos.InsertOnSubmit(newPhoto)
                db.SubmitChanges()

                'if there are no images this procedure will add the default images
                db.UpdateHeadBodyShot()
                db.SubmitChanges()

            End If

            Dim a = (From p In db.tblAmbassadorPhotos Where p.userID = currentUser.Id Select p).FirstOrDefault

            Dim a1 = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p).FirstOrDefault

            'headshot image
            a.headshot = MakeThumb(data, 500)
            a.headshot_thumbnail = MakeThumb(data, 100)

            a1.headShotUploaded = True

            Dim ms As New MemoryStream(data)
            Dim originalImage As System.Drawing.Image = System.Drawing.Image.FromStream(ms)


            If originalImage.PropertyIdList.Contains(&H112) Then
                Dim rotationValue As Integer = originalImage.GetPropertyItem(&H112).Value(0)
                Select Case rotationValue
                    Case 1
                        'landscape, do nothing
                        a.headshot = MakeThumb(data, 500)
                        a.headshot_thumbnail = MakeThumb(data, 100)

                        a1.headShotUploaded = True

                        Exit Select

                    Case 2
                        originalImage.RotateFlip(RotateFlipType.RotateNoneFlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.headshot = MakeThumb(m.GetBuffer(), 500)
                        a.headshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.headShotUploaded = True

                        Exit Select

                    Case 3
                        ' bottoms up
                        originalImage.RotateFlip(RotateFlipType.Rotate180FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.headshot = MakeThumb(m.GetBuffer(), 500)
                        a.headshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.headShotUploaded = True

                        Exit Select

                    Case 4
                        originalImage.RotateFlip(RotateFlipType.Rotate180FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.headshot = MakeThumb(m.GetBuffer(), 500)
                        a.headshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.headShotUploaded = True

                        Exit Select

                    Case 5
                        originalImage.RotateFlip(RotateFlipType.Rotate90FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.headshot = MakeThumb(m.GetBuffer(), 500)
                        a.headshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.headShotUploaded = True

                        Exit Select

                    Case 6
                        ' rotated 90 left
                        originalImage.RotateFlip(RotateFlipType.Rotate90FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.headshot = MakeThumb(m.GetBuffer(), 500)
                        a.headshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.headShotUploaded = True

                        Exit Select

                    Case 7
                        originalImage.RotateFlip(RotateFlipType.Rotate270FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.headshot = MakeThumb(m.GetBuffer(), 500)
                        a.headshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.headShotUploaded = True

                        Exit Select

                    Case 8
                        ' rotated 90 right
                        ' de-rotate:
                        originalImage.RotateFlip(RotateFlipType.Rotate270FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.headshot = MakeThumb(m.GetBuffer(), 500)
                        a.headshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.headShotUploaded = True

                        Exit Select

                End Select

            Else
                a.headshot = MakeThumb(data, 500)
                a.headshot_thumbnail = MakeThumb(data, 100)

                a1.headShotUploaded = True
            End If


            db.SubmitChanges()

            'AppearanceFormView.DataBind()

            headshot1.DataBind()

            RadNotification1.Show()
            RadNotification1.Text = "Your file was uploaded successfully!"
            RadNotification1.Title = "Success"
            RadNotification1.TitleIcon = "info"
            RadNotification1.ShowSound = True


        Catch ex As Exception
            RadNotification1.Show()
            RadNotification1.Text = ex.Message()
            RadNotification1.Title = "There was an error uploading your image"
            RadNotification1.TitleIcon = "warning"
            RadNotification1.ShowSound = True
        End Try


    End Sub


    'Private Sub btnUploadNewHeadShot_Click(sender As Object, e As EventArgs) Handles btnUploadNewHeadShot.Click

    '    Try
    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


    '        'update ambassador table

    '        If (From p In db.tblAmbassadorPhotos Where p.userID = currentUser.Id Select p).Count = 0 Then
    '            'create a record
    '            Dim newPhoto As New tblAmbassadorPhoto With {.userID = currentUser.Id}
    '            db.tblAmbassadorPhotos.InsertOnSubmit(newPhoto)
    '            db.SubmitChanges()

    '            'if there are no images this procedure will add the default images
    '            db.UpdateHeadBodyShot()
    '            db.SubmitChanges()

    '        End If

    '        Dim a = (From p In db.tblAmbassadorPhotos Where p.userID = currentUser.Id Select p).FirstOrDefault

    '        Dim a1 = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p).FirstOrDefault

    '        'headshot image
    '        For Each file As UploadedFile In HeadShotUploader.UploadedFiles
    '            Dim bytes(file.ContentLength - 1) As Byte
    '            file.InputStream.Read(bytes, 0, file.ContentLength)

    '            a.headshot = MakeThumb(bytes, 500)
    '            a1.headShotUploaded = True
    '        Next

    '        db.SubmitChanges()

    '        'AppearanceFormView.DataBind()

    '        headshot1.DataBind()

    '        RadNotification1.Show()
    '        RadNotification1.Text = "Your file was uploaded successfully!"
    '        RadNotification1.Title = "Success"
    '        RadNotification1.TitleIcon = "info"
    '        RadNotification1.ShowSound = True

    '    Catch ex As Exception
    '        RadNotification1.Show()
    '        RadNotification1.Text = ex.Message()
    '        RadNotification1.Title = "There was an error uploading your image"
    '        RadNotification1.TitleIcon = "warning"
    '        RadNotification1.ShowSound = True
    '    End Try


    'End Sub


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


            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            'update ambassador table
            If (From p In db.tblAmbassadorPhotos Where p.userID = currentUser.Id Select p).Count = 0 Then
                'create a record
                Dim newPhoto As New tblAmbassadorPhoto With {.userID = currentUser.Id}
                db.tblAmbassadorPhotos.InsertOnSubmit(newPhoto)
                db.SubmitChanges()

                'if there are no images this procedure will add the default images
                db.UpdateHeadBodyShot()
                db.SubmitChanges()

            End If

            Dim a = (From p In db.tblAmbassadorPhotos Where p.userID = currentUser.Id Select p).FirstOrDefault

            Dim a1 = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p).FirstOrDefault

            'headshot image
            a.bodyshot = MakeThumb(data2, 500)
            a.bodyshot_thumbnail = MakeThumb(data2, 100)

            a1.bodyShotUploaded = True

            Dim ms As New MemoryStream(data2)
            Dim originalImage As System.Drawing.Image = System.Drawing.Image.FromStream(ms)


            If originalImage.PropertyIdList.Contains(&H112) Then
                Dim rotationValue As Integer = originalImage.GetPropertyItem(&H112).Value(0)
                Select Case rotationValue
                    Case 1
                        'landscape, do nothing
                        a.bodyshot = MakeThumb(data2, 500)
                        a.bodyshot_thumbnail = MakeThumb(data2, 100)

                        a1.bodyShotUploaded = True

                        Exit Select

                    Case 2
                        originalImage.RotateFlip(RotateFlipType.RotateNoneFlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.bodyshot = MakeThumb(m.GetBuffer(), 500)
                        a.bodyshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.bodyShotUploaded = True

                        Exit Select

                    Case 3
                        ' bottoms up
                        originalImage.RotateFlip(RotateFlipType.Rotate180FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.bodyshot = MakeThumb(m.GetBuffer(), 500)
                        a.bodyshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.bodyShotUploaded = True

                        Exit Select

                    Case 4
                        originalImage.RotateFlip(RotateFlipType.Rotate180FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.bodyshot = MakeThumb(m.GetBuffer(), 500)
                        a.bodyshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.bodyShotUploaded = True

                        Exit Select

                    Case 5
                        originalImage.RotateFlip(RotateFlipType.Rotate90FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.bodyshot = MakeThumb(m.GetBuffer(), 500)
                        a.bodyshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.bodyShotUploaded = True

                        Exit Select

                    Case 6
                        ' rotated 90 left
                        originalImage.RotateFlip(RotateFlipType.Rotate90FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.bodyshot = MakeThumb(m.GetBuffer(), 500)
                        a.bodyshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.bodyShotUploaded = True

                        Exit Select

                    Case 7
                        originalImage.RotateFlip(RotateFlipType.Rotate270FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.bodyshot = MakeThumb(m.GetBuffer(), 500)
                        a.bodyshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.bodyShotUploaded = True

                        Exit Select

                    Case 8
                        ' rotated 90 right
                        ' de-rotate:
                        originalImage.RotateFlip(RotateFlipType.Rotate270FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        a.bodyshot = MakeThumb(m.GetBuffer(), 500)
                        a.bodyshot_thumbnail = MakeThumb(m.GetBuffer(), 100)

                        a1.bodyShotUploaded = True

                        Exit Select

                End Select

            Else
                a.bodyshot = MakeThumb(data2, 500)
                a.bodyshot_thumbnail = MakeThumb(data2, 100)

                a1.bodyShotUploaded = True
            End If

            db.SubmitChanges()

            'AppearanceFormView.DataBind()

            bodyShot2.DataBind()

            RadNotification1.Show()
            RadNotification1.Text = "Your file was uploaded successfully!"
            RadNotification1.Title = "Success"
            RadNotification1.TitleIcon = "info"
            RadNotification1.ShowSound = True

        Catch ex As Exception
            RadNotification1.Show()
            RadNotification1.Text = ex.Message()
            RadNotification1.Title = "There was an error uploading your image"
            RadNotification1.TitleIcon = "warning"
            RadNotification1.ShowSound = True
        End Try


    End Sub


    'Private Sub btnUploadNewBodyShot_Click(sender As Object, e As EventArgs) Handles btnUploadNewBodyShot.Click

    '    Dim manager = New UserManager()
    '    Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


    '    'update ambassador table
    '    Dim a = (From p In db.tblAmbassadorPhotos Where p.userID = currentUser.Id Select p).FirstOrDefault
    '    Dim a1 = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p).FirstOrDefault

    '    'bodyshot image
    '    For Each file2 As UploadedFile In BodyShotUploader.UploadedFiles
    '        Dim bytes2(file2.ContentLength - 1) As Byte
    '        file2.InputStream.Read(bytes2, 0, file2.ContentLength)

    '        a.bodyshot = MakeThumb(bytes2, 500)
    '        a1.bodyShotUploaded = True
    '    Next

    '    db.SubmitChanges()

    '    'AppearanceFormView.DataBind()

    '    bodyShot2.DataBind()

    '    RadNotification1.Show()
    '    RadNotification1.Text = "Your file was uploaded successfully!"
    '    RadNotification1.Title = "Success"
    '    RadNotification1.TitleIcon = "info"
    '    RadNotification1.ShowSound = True

    'End Sub

    Private Sub ResumeList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles ResumeList.ItemDataBound
        If ResumeList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If
        End If
    End Sub

    Private Sub LicenseList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles LicenseList.ItemDataBound
        If LicenseList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If
    End Sub

    Shared Function ShowAlertNoClose(ByVal type As String, ByVal msg As String) As String
        Return String.Format("<div class='alert alert-{0}'>{1}</div>", type, msg)
    End Function

    Private Sub btnOpenUpload1_Click(sender As Object, e As EventArgs) Handles btnOpenUpload1.Click

        ProfilePanel.Visible = False
        UploadResumePanel.Visible = True
    End Sub

    Private Sub btnOpenUpload2_Click(sender As Object, e As EventArgs) Handles btnOpenUpload2.Click

        ProfilePanel.Visible = False
        UploadLicensePanel.Visible = True

    End Sub

    Private Sub btnCancelUploadResume_Click(sender As Object, e As EventArgs) Handles btnCancelUploadResume.Click
        'cancel upload
        ProfilePanel.Visible = True
        UploadResumePanel.Visible = False
    End Sub

    Private Sub btnUploadResume_Click(sender As Object, e As EventArgs) Handles btnUploadResume.Click

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


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
                a.uploadedBy = currentUser.Id
                a.userID = currentUser.Id

                db.tblAmbassadorDocuments.InsertOnSubmit(a)
                db.SubmitChanges()

                ResumeList.DataBind()


                RadNotification1.Show()
                RadNotification1.Text = "Your file was uploaded successfully!"
                RadNotification1.Title = "Success"
                RadNotification1.TitleIcon = "info"
                RadNotification1.ShowSound = True

                Dim lmsdb As New LMSDataClassesDataContext

                'add to history log
                lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Resume Uploaded", "", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)
            Next

        End If

        ProfilePanel.Visible = True
        UploadResumePanel.Visible = False

    End Sub

    Private Sub btnUploadLicense_Click(sender As Object, e As EventArgs) Handles btnUploadLicense.Click

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


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
                a.uploadedBy = currentUser.Id
                a.userID = currentUser.Id
                a.expirationDate = ExpirationTextBox.Text
                a.documentTitle = LicenseNameTextBox.Text

                db.tblAmbassadorDocuments.InsertOnSubmit(a)
                db.SubmitChanges()
            Next

        End If

        LicenseList.DataBind()

        ProfilePanel.Visible = True
        UploadLicensePanel.Visible = False

        ExpirationTextBox.Text = ""
        LicenseNameTextBox.Text = ""

        RadNotification1.Show()
        RadNotification1.Text = "Your file was uploaded successfully!"
        RadNotification1.Title = "Success"
        RadNotification1.TitleIcon = "info"
        RadNotification1.ShowSound = True


    End Sub

    Private Sub btnCancelUploadLicense_Click(sender As Object, e As EventArgs) Handles btnCancelUploadLicense.Click
        ProfilePanel.Visible = True
        UploadLicensePanel.Visible = False
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

    'Private Sub HeadShotUploader_FileUploaded(sender As Object, e As FileUploadedEventArgs) Handles HeadShotUploader.FileUploaded

    '    btnUploadNewHeadShot.Visible = True

    'End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        'identity
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userid As String = currentUser.Id

        currentUser.Email = EmailTextBox.Text
        currentUser.PhoneNumber = phoneNumberTextBox.Text

        manager.Update(currentUser)


        'tblProfile
        Dim profile = (From p In db.tblProfiles Where p.userID = userid).FirstOrDefault

        profile.firstName = FirstName.Text
        profile.lastName = LastName.Text
        profile.timeZone = ddlTimeZone.SelectedValue
        profile.modifiedBy = Context.User.Identity.GetUserId()
        profile.modifiedDate = Date.Now()

        db.SubmitChanges()

        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    End Sub

    Private Sub BtnValidateAddress_Click(sender As Object, e As EventArgs) Handles BtnValidateAddress.Click

        Dim ti As TextInfo = New CultureInfo("en-US", False).TextInfo

        Dim street_address As String = Address1TextBox.Text.Replace("#", "")

        Dim address As String = street_address & " " & CityTextBox.Text & ", " & StateDropDownList.SelectedValue & " " & ZipTextBox.Text

        If getLatitude(address) <> 0 Then



            'update the aspNetUserProfile
            Dim userProfile = (From p In userdb.AspNetUsersProfiles Where p.UserID = Context.User.Identity.GetUserId()).FirstOrDefault

            'update ambassador table
            Dim a = (From p In db.tblAmbassadors Where p.userID = Context.User.Identity.GetUserId() Select p).FirstOrDefault

            a.latitude = getLatitude(address)
            a.longitude = getLongitude(address)

            a.Address1 = ti.ToTitleCase(Address1TextBox.Text)
            UserProfile.Address = ti.ToTitleCase(Address1TextBox.Text)

            a.Address2 = Address2TextBox.Text
            UserProfile.Address2 = Address2TextBox.Text

            a.City = ti.ToTitleCase(CityTextBox.Text)
            UserProfile.City = ti.ToTitleCase(CityTextBox.Text)

            a.State = StateDropDownList.SelectedValue
            userProfile.State = StateDropDownList.SelectedValue

            a.Zip = ZipTextBox.Text
            UserProfile.PostCode = ZipTextBox.Text

            a.modifiedDate = Date.Now()

            db.SubmitChanges()
            userdb.SubmitChanges()

            BindForm(Context.User.Identity.GetUserId())

        Else
            'show another label

        End If

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
End Class