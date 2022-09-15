Imports Telerik.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin
Imports BingGeocoder
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.Drawing
Imports CuteWebUI
Imports System.IO

Public Class AddAmbassador
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim userdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            'Hidden temp UserID
            tempUserID.Value = System.Guid.NewGuid().ToString()


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


                HeadPanel.Visible = True
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

                HeadPanel.Visible = True
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

                BodyPanel.Visible = True
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

                BodyPanel.Visible = True
                ImageBody.ImageUrl = virpath
                ImageBody.DataBind()

            End If

        Catch ex As Exception

        End Try


    End Sub

    Private Sub EventWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.FinishButtonClick

        If lblStatus.Text = "<i class='fa fa-exclamation-circle' aria-hidden='true'></i> User Name already exists." Then

            Exit Sub
        End If

        'add asp.net user and roles
        Dim userName As String = UserNameTextBox.Text
        Dim manager = New UserManager()
        manager.UserValidator = New UserValidator(Of ApplicationUser)(manager) With {.AllowOnlyAlphanumericUserNames = False}

        manager.PasswordValidator = New PasswordValidator() With {
                .RequiredLength = 4,
                .RequireNonLetterOrDigit = False,
                .RequireDigit = False,
                .RequireLowercase = False,
                .RequireUppercase = False
            }

        Dim user = New ApplicationUser() With {.UserName = userName}
        Dim result = manager.Create(user, PortalPasswordTextBox.Text)

        If result.Succeeded Then


            'add email address to aspnetuser
            user.Email = EmailAddressTextBox.Text
            manager.Update(user)

            'add role
            manager.AddToRole(user.Id, "Student")
            manager.Update(user)


            Dim newAmbassador As New tblAmbassador
            Try
                'insert into ambassador
                Dim street_address As String = Address1TextBox.Text.Replace("#", "")
                Dim address As String = street_address & " " & CityTextBox.Text & ", " & StateDropDownList.SelectedValue & " " & ZipTextBox.Text

                newAmbassador.userID = user.Id
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
                newAmbassador.userGUID = PortalPasswordTextBox.Text
                newAmbassador.userName = UserNameTextBox.Text
                newAmbassador.Status = "Active"
                newAmbassador.LastLoginDate = Date.Now()
                newAmbassador.piersings = PiercingsDropDownList.SelectedValue
                newAmbassador.smartphone = SmartphoneDropDownList.SelectedValue
                newAmbassador.smartPhoneOS = SmartphoneOSDropDownList.SelectedValue
                newAmbassador.lgbt = LGBTAccountsDropDownList.SelectedValue
                newAmbassador.transportation = ReliableTransportation.SelectedValue
                newAmbassador.mile = WillingMilesDropDownList.SelectedValue
                newAmbassador.payrollID = user.UserName
                newAmbassador.dateCreated = Date.Now()


                ' this could slow things down
                newAmbassador.latitude = getLatitude(address)
                newAmbassador.longitude = getLongitude(address)


                'For Each file As UploadedFile In headShotUpload.UploadedFiles
                '    'Dim bytes(file.ContentLength - 1) As Byte
                '    'file.InputStream.Read(bytes, 0, file.ContentLength)

                '    newAmbassador.headShotUploaded = True
                'Next

                'bodyshot image
                'For Each file2 As UploadedFile In bodyShotUpload.UploadedFiles
                '    'Dim bytes2(file2.ContentLength - 1) As Byte
                '    'file2.InputStream.Read(bytes2, 0, file2.ContentLength)

                '    newAmbassador.bodyShotUploaded = True
                'Next


                If lblPathHead.Text = "" Then

                Else
                    newAmbassador.headShotUploaded = True
                End If

                If lblPathBody.Text = "" Then

                Else
                    newAmbassador.bodyShotUploaded = True
                End If



                db.tblAmbassadors.InsertOnSubmit(newAmbassador)
                db.SubmitChanges()

            Catch ex As Exception
                msgLabel.Text = "There was an error: " & ex.Message()

                'MailHelper.SendMailMessage("no-reply@gigengyn.com", "There was an error on the GigEngyn Web App", "An error occured while adding an ambassador to the tblAmbassador table.  UserID: " & user.Id & "<br>Error: " & ex.Message())

            End Try



            'add Photos
            Dim newPhoto As New tblAmbassadorPhoto
            newPhoto.userID = newAmbassador.userID

            'For Each file As UploadedFile In headShotUpload.UploadedFiles
            '    Dim bytes(file.ContentLength - 1) As Byte
            '    file.InputStream.Read(bytes, 0, file.ContentLength)

            '    newPhoto.headshot = MakeThumb(bytes, 500)
            '    newPhoto.headshot_thumbnail = MakeThumb(bytes, 100)
            'Next

            'headshot image
            If lblPathHead.Text = "" Then

            Else

                Dim filePath As String = Server.MapPath(lblPathHead.Text)

                Dim filename As String = Path.GetFileName(filePath)


                Dim fs As FileStream = New FileStream(filePath, FileMode.Open, FileAccess.Read)

                Dim br As BinaryReader = New BinaryReader(fs)

                Dim bytes As Byte() = br.ReadBytes(Convert.ToInt32(fs.Length))


                newPhoto.headshot = MakeThumb(bytes, 500)
                newPhoto.headshot_thumbnail = MakeThumb(bytes, 100)


                br.Close()

                fs.Close()

            End If


            'For Each file2 As UploadedFile In bodyShotUpload.UploadedFiles
            '    Dim bytes2(file2.ContentLength - 1) As Byte
            '    file2.InputStream.Read(bytes2, 0, file2.ContentLength)

            '    newPhoto.bodyshot = MakeThumb(bytes2, 500)
            '    newPhoto.bodyshot_thumbnail = MakeThumb(bytes2, 100)
            'Next

            'bodyshot image
            If lblPathBody.Text = "" Then

            Else

                Dim filePath2 As String = Server.MapPath(lblPathBody.Text)

                Dim filename2 As String = Path.GetFileName(filePath2)


                Dim fs2 As FileStream = New FileStream(filePath2, FileMode.Open, FileAccess.Read)

                Dim br2 As BinaryReader = New BinaryReader(fs2)

                Dim bytes2 As Byte() = br2.ReadBytes(Convert.ToInt32(fs2.Length))

                newPhoto.bodyshot = MakeThumb(bytes2, 500)
                newPhoto.bodyshot_thumbnail = MakeThumb(bytes2, 100)

                br2.Close()

                fs2.Close()

            End If


            db.tblAmbassadorPhotos.InsertOnSubmit(newPhoto)
            db.SubmitChanges()


            'add to asp.net profile
            Try
                Dim newProfile As New AspNetUsersProfile
                newProfile.UserID = user.Id
                newProfile.SiteID = "GigEngyn"
                newProfile.FirstName = FirstNameTextBox.Text
                newProfile.LastName = LastNameTextBox.Text
                newProfile.Address = Address1TextBox.Text
                newProfile.Address2 = Address2TextBox.Text
                newProfile.City = CityTextBox.Text
                newProfile.State = StateDropDownList.SelectedValue
                newProfile.PostCode = ZipTextBox.Text
                newProfile.Phone1 = PhoneNumberTextBox.Text
                newProfile.DOB = ddlMonth.SelectedValue & "/" & ddlDay.SelectedValue & "/" & ddlYear.SelectedValue
                newProfile.Status = "Active"
                newProfile.LastLoginDate = Date.Now()

                userdb.AspNetUsersProfiles.InsertOnSubmit(newProfile)
                userdb.SubmitChanges()
            Catch ex As Exception
                MailHelper.SendMailMessage("no-reply@gigengyn.com", "There was an error on the GigEngyn Web App", "An error occured while adding an ambassador to the tblAspNetUserProfiles table.  UserID: " & user.Id & "<br>Error: " & ex.Message())
            End Try


            'add to profile
            Try
                Dim userProfile As New tblProfile
                userProfile.userID = user.Id
                userProfile.firstName = FirstNameTextBox.Text
                userProfile.lastName = LastNameTextBox.Text
                userProfile.nickName = NicknameTextBox.Text
                userProfile.IsStaff = False
                userProfile.timeZone = "Central Standard Time"
                userProfile.lastLoginDate = Date.Now()
                userProfile.lastActivityDate = Date.Now()
                userProfile.hasLoggedIn = False
                userProfile.IsOnline = False
                userProfile.enableAllClients = False
                userProfile.enableAllMarkets = False
                userProfile.enableAllSuppliers = False
                userProfile.userGUID = PortalPasswordTextBox.Text
                userProfile.userName = UserNameTextBox.Text
                userProfile.modifiedBy = Context.User.Identity.GetUserId()
                userProfile.modifiedDate = Date.Now()
                userProfile.status = 1
                userProfile.IsStaff = 0
                userProfile.teamID = TeamComboBox.SelectedValue



                db.tblProfiles.InsertOnSubmit(userProfile)
                db.SubmitChanges()


            Catch ex As Exception
                MailHelper.SendMailMessage("no-reply@gigengyn.com", "There was an error on the GigEngyn Web App", "An error occured while adding an ambassador to the tblProfile table.  UserID: " & user.Id & "<br>Error: " & ex.Message())
            End Try




            'add the resumes and licenses to the new ambassador
            Dim doc = (From p In db.tblAmbassadorDocuments Where p.userID = tempUserID.Value Select p)

            Try

                For Each p In doc
                    p.userID = user.Id
                Next

            Catch ex As Exception
                MailHelper.SendMailMessage("no-reply@gigengyn.com", "There was an error on the GigEngyn Web App", "An error occured while adding an ambassador document to the tblAmbassaorDocument table.  UserID: " & user.Id & "<br>Error: " & ex.Message())
            End Try

            'add markets
            Dim Markets As IList(Of RadListBoxItem) = MarketList.CheckedItems
            For Each item As RadListBoxItem In Markets

                Dim market As New tblAmbassadorMarket With {.marketID = item.Value, .userID = user.Id}
                db.tblAmbassadorMarkets.InsertOnSubmit(market)
                db.SubmitChanges()

            Next

            'add positions
            Dim Positions As IList(Of RadListBoxItem) = PositionsListBox.CheckedItems
            For Each item As RadListBoxItem In Positions

                Dim position As New tblAmbassadorPosition With {.positionID = item.Value, .userID = user.Id}
                db.tblAmbassadorPositions.InsertOnSubmit(position)
                db.SubmitChanges()

            Next

            'add brands
            'Dim a = (From p In db.tblAmbassadors Where p.ambassadorID = Request.QueryString("UserID") Select p).FirstOrDefault

            'If ckbBeer.Checked = True Then a.beer = True
            'If ckbSpirits.Checked = True Then a.spirits = True
            'If ckbWine.Checked = True Then a.wine = True
            'If ckbReadyToDrink.Checked = True Then a.ready = True
            'If ckbOther.Checked = True Then a.other = True

            'db.SubmitChanges()


            'add to courses in GigEngyn
            userdb.AddStudentToCourse(user.UserName, "1c6fd977-048c-4550-8dbc-02d73f4f3e77")
            'userdb.AddStudentToAllCourses(user.UserName)

            db.SubmitChanges()


            'Response.Redirect("/Ambassadors/ActiveList?action=1")

            Try
                'if there are no images this procedure will add the default images
                db.UpdateHeadBodyShot()
            Catch ex As Exception
                MailHelper.SendMailMessage("no-reply@gigengyn.com", "There was an error on the GigEngyn Web App", "An error occured while adding an ambassador.  UserID: " & user.Id & "<br>Error: " & ex.Message)
            End Try


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


            Response.Redirect("/Ambassadors/ViewAmbassadorDetails?UserID=" & user.Id)



        Else
            msgLabel.Text = "There was a problem adding the user: " & result.Errors.FirstOrDefault()

            MailHelper.SendMailMessage("no-reply@gigengyn.com", "There was an error on the GigEngyn Web App", "An error occured while adding an ambassador.  UserID: " & user.Id & "<br>Error: " & result.Errors.FirstOrDefault())

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

    Private Sub EventWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.CancelButtonClick

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


        Response.Redirect("/Ambassadors/ActiveList")
    End Sub

    'Private Sub LogEvent(ByVal sender As Object, ByVal eventName As String, ByVal items As IEnumerable(Of RadListBoxItem))

    '    Dim affectedItems As New List(Of String)()

    '    For Each item As RadListBoxItem In items
    '        affectedItems.Add(item.Value)
    '    Next

    '    Dim message As String = String.Format("{0}", affectedItems.ToArray())
    '    HF_SelectedItemID.Value = message

    'End Sub

    'Protected Sub SelectedClientsList_Inserted(sender As Object, e As RadListBoxEventArgs)

    '    Try
    '        'get the brandID
    '        LogEvent(sender, "Inserted", e.Items)

    '        Dim userID As String = Request.QueryString("UserID")
    '        Dim selectedValue As Integer = HF_SelectedItemID.Value

    '        'insert the item
    '        db.InsertTempAmbassadorClient(selectedValue, userID)
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
    '        db.DeleteTempAmbassadorClient(selectedValue, userID)
    '        db.SubmitChanges()

    '        'rebind the grids
    '        'SelectedSuppliers.DataBind()
    '        ' AvailableSuppliers.DataBind()

    '        msgLabel.Text = ""

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try
    'End Sub

    'Protected Sub AmbassadorPositionList_Inserted(sender As Object, e As RadListBoxEventArgs)
    '    Try

    '        LogEvent(sender, "Inserted", e.Items)

    '        Dim selectedValue As Integer = HF_SelectedItemID.Value
    '        Dim userID As String = Request.QueryString("UserID")

    '        'insert the item
    '        db.InsertTempAmbassadorPosition(selectedValue, userID)
    '        db.SubmitChanges()

    '        'rebind the lists
    '        '  SelectedBrandsList.DataBind()
    '        ' AssociatedBrandsList.DataBind()

    '        msgLabel.Text = ""

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try
    'End Sub

    'Protected Sub AmbassadorPositionList_Deleted(sender As Object, e As RadListBoxEventArgs)
    '    Try
    '        'get the supplierID
    '        LogEvent(sender, "Deleted", e.Items)

    '        Dim selectedValue As Integer = HF_SelectedItemID.Value
    '        Dim userID As String = Request.QueryString("UserID")

    '        'delete the item
    '        db.DeleteTempAmbassadorPosition(selectedValue, userID)
    '        db.SubmitChanges()

    '        'rebind the grids
    '        'SelectedSuppliers.DataBind()
    '        ' AvailableSuppliers.DataBind()

    '        msgLabel.Text = ""

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try

    'End Sub


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

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim ambassadorID = tempUserID.Value


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
        Dim ambassadorID = tempUserID.Value


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
        Next
        db.tblAmbassadorDocuments.InsertOnSubmit(a)
        db.SubmitChanges()

        LicenseList.DataBind()

        PanelDocuments.Visible = True
        UploadLicensePanel.Visible = False

        ExpirationTextBox.Text = ""
        LicenseNameTextBox.Text = ""


    End Sub

    Private Sub BtnValidateAddress_Click(sender As Object, e As EventArgs) Handles BtnValidateAddress.Click

        Dim street_address As String = Address1TextBox.Text.Replace("#", "")
        Dim address As String = street_address & " " & CityTextBox.Text & ", " & StateDropDownList.SelectedValue & " " & ZipTextBox.Text

        LatitudeTextBox.Text = getLatitude(address)
        LongitudeTextBox.Text = getLongitude(address)


    End Sub
End Class