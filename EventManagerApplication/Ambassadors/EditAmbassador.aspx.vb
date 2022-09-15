Imports Telerik.Web.UI
Imports System.Drawing
Imports System.Drawing.Drawing2D
Imports BingGeocoder
Imports System.Globalization
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports CuteWebUI
Imports System.IO

Public Class EditAmbassador
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

        If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Agency") Then
            Response.Redirect("/AccessDenied")
        End If


        If Not Page.IsPostBack Then

            userid = Request.QueryString("UserID")
            BindForm(userid)

            Dim thisAmbassador = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault

            If thisAmbassador.Status = "Terminated" Then

                btnTerminate.Visible = False
                btnReactivate.Visible = True
            Else

                btnTerminate.Visible = True
                btnReactivate.Visible = False
            End If
        End If

    End Sub

    Private Sub CancelButton_Click(sender As Object, e As EventArgs) Handles CancelButton.Click

        If lblPathHead.Text = "" Then

        Else
            'delete the head shot from the temp folder
            Try
                Dim filePath2 As String = Server.MapPath(lblPathHead.Text)
                System.IO.File.Delete(filePath2)
            Catch ex As Exception
                'do nothing
            End Try
        End If

        If lblPathBody.Text = "" Then

        Else
            'delete the body shot from the temp folder
            Try
                Dim filePath3 As String = Server.MapPath(lblPathBody.Text)
                System.IO.File.Delete(filePath3)
            Catch ex As Exception
                'do nothing
            End Try
        End If


        Response.Redirect("ViewAmbassadorDetails?UserID=" & Request.QueryString("UserID"))
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
                SmartphoneOSDropDownList.SelectedValue = p.smartPhoneOS
                LGBTAccountsDropDownList.SelectedValue = p.lgbt
                ReliableTransportation.SelectedValue = p.transportation
                WillingMilesDropDownList.SelectedValue = p.mile
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
            PhoneNumberTextBox.Text = p.Phone
            StateDropDownList.Text = p.State
            ZipTextBox.Text = p.Zip

            Try
                latitudeTextBox.Text = p.latitude
                longtitudeTextBox.Text = p.longitude
            Catch ex As Exception

            End Try


            Try
                CitizenDropDownList.SelectedValue = p.citizen
            Catch ex As Exception

            End Try

        Next

        Dim userProfile = (From p In db.tblProfiles Where p.userID = id).FirstOrDefault
        userProfile.firstName = FirstNameTextBox.Text
        userProfile.lastName = LastNameTextBox.Text
        ' userProfile.timeZone = ddlTimeZone.SelectedValue
        userProfile.modifiedBy = Context.User.Identity.GetUserId()
        userProfile.modifiedDate = Date.Now()

        db.SubmitChanges()

        Try
            Dim Profile = (From p In userdb.AspNetUsersProfiles Where p.UserID = id Select p)
            For Each p In Profile
                NicknameTextBox.Text = p.NickName
            Next
        Catch ex As Exception

        End Try



        ' Brand category
        'Dim beer = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 1 And p.userName = id Select p).Count
        'If beer = 0 Then
        '    ckbBeer.Checked = False
        'Else
        '    ckbBeer.Checked = True
        'End If

        'Dim spirit = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 2 And p.userName = id Select p).Count
        'If spirit = 0 Then
        '    ckbSpirits.Checked = False
        'Else
        '    ckbSpirits.Checked = True
        'End If

        'Dim wine = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 3 And p.userName = id Select p).Count
        'If spirit = 0 Then
        '    ckbWine.Checked = False
        'Else
        '    ckbWine.Checked = True
        'End If

        'Dim ready = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 4 And p.userName = id Select p).Count
        'If ready = 0 Then
        '    ckbReadyToDrink.Checked = False
        'Else
        '    ckbReadyToDrink.Checked = True
        'End If

        'Dim other = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 5 And p.userName = id Select p).Count
        'If other = 0 Then
        '    ckbOther.Checked = False
        'Else
        '    ckbOther.Checked = True
        'End If



        'team label
        Dim q = From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p


        For Each p In q

            PayrollIDTextBox.Text = p.userName
            Try
                TeamComboBox.SelectedValue = p.teamID
            Catch ex As Exception

            End Try
        Next


    End Sub



    Public Function ResizeImage(ByVal stream As IO.Stream) As Bitmap

        Dim originalImage As System.Drawing.Image = Bitmap.FromStream(stream)
        Dim height As Integer = 331
        Dim width As Integer = 495

        Dim scaledImage As New Bitmap(width, height)

        Using g As Graphics = Graphics.FromImage(scaledImage)
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic
            g.DrawImage(originalImage, 0, 0, width, height)
            g.DrawString("My photo from ", New Font("Tahoma", 18), Brushes.White, New PointF(0, 0))

            Return scaledImage

        End Using

    End Function


    Protected Sub UploadAttachments1_Head(ByVal sender As Object, ByVal args As UploaderEventArgs)

        Try

            If lblPathHead.Text = "" Then

                'Get the full path of file that will be saved.
                Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
                lblPathHead.Text = virpath

                'Map the path to to a physical path.
                Dim savepath As String = Server.MapPath(virpath)

                'Do not overwrite an existing file
                If System.IO.File.Exists(savepath) Then
                    Return
                End If

                'Move the uploaded file to the target location
                args.MoveTo(savepath)


                'Get the data of uploaded file		
                'Dim link As New HyperLink()
                'link.Text = Convert.ToString("Open " + args.FileName + " : ") & virpath
                'link.NavigateUrl = virpath
                'link.Target = "_blank"
                'link.Style(HtmlTextWriterStyle.Display) = "block"

                headshot.Visible = False
                HeadPanel.Visible = True
                lblInfoHead.Visible = True
                ImageHead.ImageUrl = virpath
                ImageHead.DataBind()

            Else

                Try
                    Dim filePath2 As String = Server.MapPath(lblPathHead.Text)
                    System.IO.File.Delete(filePath2)
                    lblPathHead.Text = ""
                Catch ex As Exception
                    'do nothing
                End Try

                'Get the full path of file that will be saved.
                Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
                lblPathHead.Text = virpath

                'Map the path to to a physical path.
                Dim savepath As String = Server.MapPath(virpath)

                'Do not overwrite an existing file
                If System.IO.File.Exists(savepath) Then
                    Return
                End If

                'Move the uploaded file to the target location
                args.MoveTo(savepath)


                'Get the data of uploaded file		
                'Dim link As New HyperLink()
                'link.Text = Convert.ToString("Open " + args.FileName + " : ") & virpath
                'link.NavigateUrl = virpath
                'link.Target = "_blank"
                'link.Style(HtmlTextWriterStyle.Display) = "block"

                headshot.Visible = False
                HeadPanel.Visible = True
                lblInfoHead.Visible = True
                ImageHead.ImageUrl = virpath
                ImageHead.DataBind()


            End If



        Catch ex As Exception

        End Try


    End Sub

    Protected Sub UploadAttachments1_Body(ByVal sender As Object, ByVal args As UploaderEventArgs)

        Try

            If lblPathBody.Text = "" Then

                'Get the full path of file that will be saved.
                Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
                lblPathBody.Text = virpath

                'Map the path to to a physical path.
                Dim savepath As String = Server.MapPath(virpath)

                'Do not overwrite an existing file
                If System.IO.File.Exists(savepath) Then
                    Return
                End If

                'Move the uploaded file to the target location
                args.MoveTo(savepath)


                'Get the data of uploaded file		
                'Dim link As New HyperLink()
                'link.Text = Convert.ToString("Open " + args.FileName + " : ") & virpath
                'link.NavigateUrl = virpath
                'link.Target = "_blank"
                'link.Style(HtmlTextWriterStyle.Display) = "block"

                bodyShot.Visible = False
                BodyPanel.Visible = True
                lblInfoBody.Visible = True
                ImageBody.ImageUrl = virpath
                ImageBody.DataBind()

            Else

                Try
                    Dim filePath2 As String = Server.MapPath(lblPathBody.Text)
                    System.IO.File.Delete(filePath2)
                    lblPathBody.Text = ""
                Catch ex As Exception
                    'do nothing
                End Try

                'Get the full path of file that will be saved.
                Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
                lblPathBody.Text = virpath

                'Map the path to to a physical path.
                Dim savepath As String = Server.MapPath(virpath)

                'Do not overwrite an existing file
                If System.IO.File.Exists(savepath) Then
                    Return
                End If

                'Move the uploaded file to the target location
                args.MoveTo(savepath)


                'Get the data of uploaded file		
                'Dim link As New HyperLink()
                'link.Text = Convert.ToString("Open " + args.FileName + " : ") & virpath
                'link.NavigateUrl = virpath
                'link.Target = "_blank"
                'link.Style(HtmlTextWriterStyle.Display) = "block"

                bodyShot.Visible = False
                BodyPanel.Visible = True
                lblInfoBody.Visible = True
                ImageBody.ImageUrl = virpath
                ImageBody.DataBind()


            End If



        Catch ex As Exception

        End Try


    End Sub


    Private Sub UpdateButton_Click(sender As Object, e As EventArgs) Handles UpdateButton.Click


        Try
            Dim ti As TextInfo = New CultureInfo("en-US", False).TextInfo

            Dim userid As String = Request.QueryString("UserID")


            'change username
            Dim currentUserName As String = (From u In userdb.AspNetUsers Where u.Id = Request.QueryString("UserID") Select u.UserName).FirstOrDefault
            Dim newUserName As String = PayrollIDTextBox.Text

            If currentUserName = newUserName Then
                'do nothing
            Else
                'update the username in AspNetUsers
                Dim user = (From u In userdb.AspNetUsers Where u.Id = Request.QueryString("UserID") Select u).FirstOrDefault
                user.UserName = PayrollIDTextBox.Text
                userdb.SubmitChanges()

                'update any assigned events
                db.updateUserName(currentUserName, newUserName)
            End If


            'change emailaddress
            Dim currentEmail As String = (From u In userdb.AspNetUsers Where u.Id = Request.QueryString("UserID") Select u.Email).FirstOrDefault
            Dim newEmail As String = EmailAddressTextBox.Text

            If currentEmail = newEmail Then
                'do nothing
            Else
                'update the username in AspNetUsers
                Dim user = (From u In userdb.AspNetUsers Where u.Id = Request.QueryString("UserID") Select u).FirstOrDefault
                user.Email = EmailAddressTextBox.Text
                userdb.SubmitChanges()

            End If



            'update the aspNetUserProfile
            Dim userProfile = (From p In userdb.AspNetUsersProfiles Where p.UserID = Request.QueryString("UserID")).FirstOrDefault

            'update ambassador table
            Dim a = (From p In db.tblAmbassadors Where p.userID = userid Select p).FirstOrDefault



            If (From p In db.tblAmbassadorPhotos Where p.userID = Request.QueryString("UserID") Select p).Count = 0 Then
                'create a record
                Dim newPhoto As New tblAmbassadorPhoto With {.userID = Request.QueryString("UserID")}
                db.tblAmbassadorPhotos.InsertOnSubmit(newPhoto)
                db.SubmitChanges()

                'if there are no images this procedure will add the default images
                db.UpdateHeadBodyShot()
                db.SubmitChanges()

            End If



            'For Each file As UploadedFile In RadAsyncUpload12.UploadedFiles
            '    Dim bytes(file.ContentLength - 1) As Byte
            '    file.InputStream.Read(bytes, 0, file.ContentLength)

            '    x.headshot = MakeThumb(bytes, 500)
            '    x.headshot_thumbnail = MakeThumb(bytes, 100)
            '    a.headShotUploaded = True
            'Next

            'For Each file2 As UploadedFile In bodyShotUpload2.UploadedFiles
            '    Dim bytes2(file2.ContentLength - 1) As Byte
            '    file2.InputStream.Read(bytes2, 0, file2.ContentLength)

            '    x.bodyshot = MakeThumb(bytes2, 500)
            '    x.bodyshot_thumbnail = MakeThumb(bytes2, 100)
            '    a.bodyShotUploaded = True
            'Next


            Dim x = (From p In db.tblAmbassadorPhotos Where p.userID = userid Select p).FirstOrDefault
            'headshot image
            If lblPathHead.Text = "" Then

            Else

                Dim filePath As String = Server.MapPath(lblPathHead.Text)

                Dim filename As String = Path.GetFileName(filePath)


                Dim fs As FileStream = New FileStream(filePath, FileMode.Open, FileAccess.Read)

                Dim br As BinaryReader = New BinaryReader(fs)

                Dim bytes As Byte() = br.ReadBytes(Convert.ToInt32(fs.Length))


                x.headshot = MakeThumb(bytes, 500)
                x.headshot_thumbnail = MakeThumb(bytes, 100)
                a.headShotUploaded = True


                br.Close()

                fs.Close()

            End If


            'bodyshot image
            If lblPathBody.Text = "" Then

            Else

                Dim filePath2 As String = Server.MapPath(lblPathBody.Text)

                Dim filename2 As String = Path.GetFileName(filePath2)


                Dim fs2 As FileStream = New FileStream(filePath2, FileMode.Open, FileAccess.Read)

                Dim br2 As BinaryReader = New BinaryReader(fs2)

                Dim bytes2 As Byte() = br2.ReadBytes(Convert.ToInt32(fs2.Length))

                x.bodyshot = MakeThumb(bytes2, 500)
                x.bodyshot_thumbnail = MakeThumb(bytes2, 100)
                a.bodyShotUploaded = True


                br2.Close()

                fs2.Close()

            End If



            'resume upload
            'For Each file3 As UploadedFile In resumeUpload.UploadedFiles
            '    Dim bytes3(file3.ContentLength - 1) As Byte
            '    file3.InputStream.Read(bytes3, 0, file3.ContentLength)

            '    a.resume = bytes3
            '    a.resumeUploaded = True
            '    a.resumeFileType = file3.ContentType
            '    a.resumeFileName = file3.FileName
            'Next

            ''license upload
            'For Each file4 As UploadedFile In licenseUpload.UploadedFiles
            '    Dim bytes4(file4.ContentLength - 1) As Byte
            '    file4.InputStream.Read(bytes4, 0, file4.ContentLength)

            '    a.license = bytes4
            '    a.licenseUploaded = True
            '    a.licenseFileType = file4.ContentType
            '    a.licenseFileName = file4.FileName
            'Next

            a.userName = PayrollIDTextBox.Text
            a.gender = GenderDropDownList.SelectedValue
            a.citizen = CitizenDropDownList.SelectedValue
            a.height = HeightDropDownList.SelectedValue
            a.weight = WeightDropDownList.SelectedValue
            a.hairColor = HairColorDropDownList.SelectedValue
            a.eyeColor = EyeColorDropDownList.SelectedValue
            a.piersings = PiersingsDropDownList.SelectedValue
            a.smartphone = SmartphoneDropDownList.SelectedValue
            a.smartPhoneOS = SmartphoneOSDropDownList.SelectedValue
            a.lgbt = LGBTAccountsDropDownList.SelectedValue
            a.transportation = ReliableTransportation.SelectedValue
            a.mile = WillingMilesDropDownList.SelectedValue

            a.latitude = latitudeTextBox.Text
            a.longitude = longtitudeTextBox.Text

            Dim ad As Date = ddlMonthAD.SelectedValue & "/" & ddlDayAD.SelectedValue & "/" & ddlYearAD.SelectedValue
            a.availabilityDate = ad

            a.FirstName = FirstNameTextBox.Text
            userProfile.FirstName = FirstNameTextBox.Text

            a.NickName = NicknameTextBox.Text
            userProfile.NickName = NicknameTextBox.Text

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

            a.Phone = PhoneNumberTextBox.Text
            userProfile.Phone1 = PhoneNumberTextBox.Text

            a.State = StateDropDownList.SelectedValue
            userProfile.State = StateDropDownList.SelectedValue

            a.Zip = ZipTextBox.Text
            userProfile.PostCode = ZipTextBox.Text

            a.modifiedDate = Date.Now()



            ' Brand category
            ' beer
            'If ckbBeer.Checked = True Then
            '    'see if it is in the db
            '    Dim beer = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 1 And p.userName = userid Select p).Count

            '    If Not beer = 0 Then
            '        ' it is in the database so do nothing
            '    Else
            '        'add it to the database
            '        Dim add = db.prAddBrandTypeToAmbassador(userid, 1)
            '    End If

            'Else
            '    'see if it is in the db
            '    Dim beer = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 1 And p.userName = userid Select p).Count
            '    If beer = 0 Then
            '        'do nothing
            '    Else
            '        'delete the silly record
            '        Dim delete = db.prDeleteBrandTypeFromAmbassador(userid, 1)
            '    End If
            'End If



            '' spirit
            'If ckbSpirits.Checked = True Then
            '    'see if it is in the db
            '    Dim spirit = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 2 And p.userName = userid Select p).Count

            '    If Not spirit = 0 Then
            '        ' it is in the database so do nothing
            '    Else
            '        'add it to the database
            '        Dim add = db.prAddBrandTypeToAmbassador(userid, 2)
            '    End If

            'Else
            '    'see if it is in the db
            '    Dim spirit = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 2 And p.userName = userid Select p).Count
            '    If spirit = 0 Then
            '        'do nothing
            '    Else
            '        'delete the silly record
            '        Dim delete = db.prDeleteBrandTypeFromAmbassador(userid, 2)
            '    End If
            'End If



            '' wine
            'If ckbWine.Checked = True Then
            '    'see if it is in the db
            '    Dim wine = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 3 And p.userName = userid Select p).Count

            '    If Not wine = 0 Then
            '        ' it is in the database so do nothing
            '    Else
            '        'add it to the database
            '        Dim add = db.prAddBrandTypeToAmbassador(userid, 3)
            '    End If

            'Else
            '    'see if it is in the db
            '    Dim wine = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 3 And p.userName = userid Select p).Count
            '    If wine = 0 Then
            '        'do nothing
            '    Else
            '        'delete the silly record
            '        Dim delete = db.prDeleteBrandTypeFromAmbassador(userid, 3)
            '    End If
            'End If



            '' ready to drink
            'If ckbReadyToDrink.Checked = True Then
            '    'see if it is in the db
            '    Dim ready = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 4 And p.userName = userid Select p).Count

            '    If Not ready = 0 Then
            '        ' it is in the database so do nothing
            '    Else
            '        'add it to the database
            '        Dim add = db.prAddBrandTypeToAmbassador(userid, 4)
            '    End If

            'Else
            '    'see if it is in the db
            '    Dim ready = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 4 And p.userName = userid Select p).Count
            '    If ready = 0 Then
            '        'do nothing
            '    Else
            '        'delete the silly record
            '        Dim delete = db.prDeleteBrandTypeFromAmbassador(userid, 4)
            '    End If
            'End If




            '' other
            'If ckbOther.Checked = True Then
            '    'see if it is in the db
            '    Dim other = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 5 And p.userName = userid Select p).Count

            '    If Not other = 0 Then
            '        ' it is in the database so do nothing
            '    Else
            '        'add it to the database
            '        Dim add = db.prAddBrandTypeToAmbassador(userid, 5)
            '    End If

            'Else
            '    'see if it is in the db
            '    Dim other = (From p In db.tblAmbassadorBrandCategoryTypes Where p.brandCategoryID = 5 And p.userName = userid Select p).Count
            '    If other = 0 Then
            '        'do nothing
            '    Else
            '        'delete the silly record
            '        Dim delete = db.prDeleteBrandTypeFromAmbassador(userid, 5)
            '    End If
            'End If




            If TeamComboBox.SelectedIndex = -1 Then
                'set to null if nothing is selected
                Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
                m.teamID = Nothing
            Else
                'set to the selected value
                Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
                m.teamID = TeamComboBox.SelectedValue
            End If

            'set to null if none is selected
            If TeamComboBox.SelectedValue = 0 Then
                Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
                m.teamID = Nothing
            End If

            Dim z = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault

            z.firstName = FirstNameTextBox.Text
            z.lastName = LastNameTextBox.Text
            z.nickName = NicknameTextBox.Text
            z.userName = PayrollIDTextBox.Text
            z.modifiedBy = Context.User.Identity.GetUserId()
            z.modifiedDate = Date.Now()

            db.SubmitChanges()
            userdb.SubmitChanges()



            'delete the head shot from the temp folder
            Try
                Dim filePath2 As String = Server.MapPath(lblPathHead.Text)
                System.IO.File.Delete(filePath2)
            Catch ex As Exception
                'do nothing
            End Try

            'delete the body shot from the temp folder
            Try
                Dim filePath3 As String = Server.MapPath(lblPathBody.Text)
                System.IO.File.Delete(filePath3)
            Catch ex As Exception
                'do nothing
            End Try


            Response.Redirect("ViewAmbassadorDetails?UserID=" & userid & "&action=1")
        Catch ex As Exception
            msgLabel.Text = ex.Message()
        End Try

    End Sub

    Private Sub LogEvent(ByVal sender As Object, ByVal eventName As String, ByVal items As IEnumerable(Of RadListBoxItem))

        Dim affectedItems As New List(Of String)()

        For Each item As RadListBoxItem In items
            affectedItems.Add(item.Value)
        Next

        Dim message As String = String.Format("{0}", affectedItems.ToArray())
        HF_SelectedItemID.Value = message

    End Sub


    'Protected Sub SelectedClientsList_Inserted(sender As Object, e As RadListBoxEventArgs)
    '    Try
    '        'get the brandID
    '        LogEvent(sender, "Inserted", e.Items)

    '        Dim userID As String = Request.QueryString("UserID")
    '        Dim selectedValue As Integer = HF_SelectedItemID.Value

    '        'insert the item
    '        db.InsertAmbassadorClient(selectedValue, userID)
    '        db.SubmitChanges()

    '        'rebind the lists
    '        '  SelectedBrandsList.DataBind()
    '        ' AssociatedBrandsList.DataBind()

    '        msgLabel.Text = ""

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try
    'End Sub

    'Protected Sub SelectedClientsList_Deleted(sender As Object, e As RadListBoxEventArgs)
    '    Try
    '        'get the supplierID
    '        LogEvent(sender, "Deleted", e.Items)

    '        Dim selectedValue As Integer = HF_SelectedItemID.Value
    '        Dim userID As String = Request.QueryString("UserID")

    '        'delete the item
    '        db.DeleteAmbassadorClient(selectedValue, userID)
    '        db.SubmitChanges()

    '        'rebind the grids
    '        'SelectedSuppliers.DataBind()
    '        ' AvailableSuppliers.DataBind()

    '        msgLabel.Text = ""

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try
    'End Sub

    Protected Sub AmbassadorPositionList_Inserted(sender As Object, e As RadListBoxEventArgs)
        Try

            LogEvent(sender, "Inserted", e.Items)

            Dim selectedValue As Integer = HF_SelectedItemID.Value
            Dim userID As String = Request.QueryString("UserID")

            'insert the item
            db.InsertAmbassadorPosition(selectedValue, userID)
            db.SubmitChanges()

            'rebind the lists
            '  SelectedBrandsList.DataBind()
            ' AssociatedBrandsList.DataBind()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Protected Sub AmbassadorPositionList_Deleted(sender As Object, e As RadListBoxEventArgs)
        Try
            'get the supplierID
            LogEvent(sender, "Deleted", e.Items)

            Dim selectedValue As Integer = HF_SelectedItemID.Value
            Dim userID As String = Request.QueryString("UserID")

            'delete the item
            db.DeleteAmbassadorPosition(selectedValue, userID)
            db.SubmitChanges()

            'rebind the grids
            'SelectedSuppliers.DataBind()
            ' AvailableSuppliers.DataBind()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Protected Sub AmbassadorMarketsList_Inserted(sender As Object, e As RadListBoxEventArgs)
        Try

            LogEvent(sender, "Inserted", e.Items)

            Dim selectedValue As Integer = HF_SelectedItemID.Value
            Dim userID As String = Request.QueryString("UserID")

            'insert the item
            db.InsertAmbassadorMarket(selectedValue, userID)
            db.SubmitChanges()

            'rebind the lists
            '  SelectedBrandsList.DataBind()
            ' AssociatedBrandsList.DataBind()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Protected Sub AmbassadorMarketsList_Deleted(sender As Object, e As RadListBoxEventArgs)
        Try
            'get the supplierID
            LogEvent(sender, "Deleted", e.Items)

            Dim selectedValue As Integer = HF_SelectedItemID.Value
            Dim userID As String = Request.QueryString("UserID")

            'delete the item
            db.DeleteAmbassadorMarket(selectedValue, userID)
            db.SubmitChanges()

            'rebind the grids
            'SelectedSuppliers.DataBind()
            ' AvailableSuppliers.DataBind()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
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

    Private Sub btnUpdateGeoCoords_Click(sender As Object, e As EventArgs) Handles btnUpdateGeoCoords.Click


        Dim street_address As String = Address1TextBox.Text.Replace("#", "")

        Dim address As String = street_address & " " & CityTextBox.Text & ", " & StateDropDownList.SelectedValue & " " & ZipTextBox.Text

        latitudeTextBox.Text = getLatitude(address)
        longtitudeTextBox.Text = getLongitude(address)


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

    Private Sub btnTerminate_Click(sender As Object, e As EventArgs) Handles btnTerminate.Click

        Dim thisAmbassador = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault

        thisAmbassador.Status = "Terminated"
        thisAmbassador.modifiedDate = Date.Now()
        thisAmbassador.modifiedBy = Context.User.Identity.GetUserId()
        db.SubmitChanges()

        Response.Redirect("/ambassadors/EditAmbassador?UserID=" & Request.QueryString("UserID"))

    End Sub

    Private Sub btnReactivate_Click(sender As Object, e As EventArgs) Handles btnReactivate.Click
        Dim thisAmbassador = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault

        thisAmbassador.Status = "Active"
        thisAmbassador.modifiedDate = Date.Now()
        thisAmbassador.modifiedBy = Context.User.Identity.GetUserId()
        db.SubmitChanges()

        Response.Redirect("/ambassadors/EditAmbassador?UserID=" & Request.QueryString("UserID"))

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

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim ambassadorID = Request.QueryString("UserID")


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
            a.userID = ambassadorID

            db.tblAmbassadorDocuments.InsertOnSubmit(a)
            db.SubmitChanges()
        Next



        ResumeList.DataBind()

        PanelDocuments.Visible = True
        UploadResumePanel.Visible = False

    End Sub

    Private Sub btnUploadLicense_Click(sender As Object, e As EventArgs) Handles btnUploadLicense.Click

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim ambassadorID = Request.QueryString("UserID")


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
            a.userID = ambassadorID
            a.expirationDate = ExpirationTextBox.Text
            a.documentTitle = LicenseNameTextBox.Text

            db.tblAmbassadorDocuments.InsertOnSubmit(a)
            db.SubmitChanges()
        Next

        LicenseList.DataBind()

        PanelDocuments.Visible = True
        UploadLicensePanel.Visible = False

        ExpirationTextBox.Text = ""
        LicenseNameTextBox.Text = ""


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

    Function getFullName2(ByVal id As String) As String
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(id)

        Dim result = (From p In userdb.AspNetUsersProfiles Where p.UserID = currentUser.Id Select p).FirstOrDefault

        Return String.Format("{0} {1}", result.FirstName, result.LastName)

    End Function

    Protected Sub btnInsert_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub DeleteButton_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub CancelButton2_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub UpdateButton2_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub EditButton_Click(sender As Object, e As EventArgs)

    End Sub 'End Notes Tab Code

    Private Sub getAmbassadorNotes_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getAmbassadorNotes.Inserting

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Dim i As tblAmbassadorNote
        i = CType(e.NewObject, tblAmbassadorNote)
        i.userID = Request.QueryString("userID")
        i.createdBy = currentUser.Id
        i.createdDate = Date.Now()

    End Sub

End Class