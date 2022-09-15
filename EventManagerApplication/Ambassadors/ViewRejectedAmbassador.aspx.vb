Imports System.IO
Imports System.Threading
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class ViewRejectedAmbassador
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim userdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            BindAmbassador()

            ambassadorUserIDHidden.Value = (From p In db.tblAmbassadors Where p.ambassadorID = Request.QueryString("UserID") Select p.userID).FirstOrDefault
        End If

    End Sub

    Sub BindAmbassador()

        Dim userid As String = Request.QueryString("UserID")
        AccountNameLabel.Text = (From p In db.tblAmbassadors Where p.ambassadorID = Request.QueryString("UserID") Select p.FirstName & " " & p.LastName).FirstOrDefault
        ' CreatedDateLabel.Text = String.Format("{0:D}", (From p In db.tblAmbassadors Where p.ambassadorID = Request.QueryString("UserID") Select p.LastLoginDate).FirstOrDefault)

        CreatedDateLabel.Text = Common.GetTimeAdjustment((From p In db.tblAmbassadors Where p.ambassadorID = Request.QueryString("UserID") Select p.LastLoginDate).FirstOrDefault)

        BindForm(userid)
    End Sub

    Private Sub BindForm(ByVal id As String)

        'btnDownloadResume.NavigateUrl = "/ambassadors/GetResume?UserID=" & Request.QueryString("UserID") & "&file=resume"
        'btnDownloadLicense.NavigateUrl = "/ambassadors/GetLicense?UserID=" & Request.QueryString("UserID") & "&file=license"

        Dim Ambassador = (From p In db.tblAmbassadors Where p.ambassadorID = id Select p)

        For Each p In Ambassador
            Try
                FirstName.Text = p.FirstName
                LastName.Text = p.LastName
                StatusLabel.Text = p.Status
                PortalLoginLabel.Text = p.userName
                PasswordLabel.Text = p.userGUID
                EmailAddress.Text = p.EmailAddress
                DateofBirth.Text = p.DOB
                Address1.Text = p.Address1
                Address2.Text = p.Address2
                City.Text = p.City
                PhoneNumber.Text = Common.FormatPhoneNumber(p.Phone)
                State.Text = p.State
                Zip.Text = p.Zip
                Gender.Text = p.gender
                Citizen.Text = Common.formatBoolean(p.citizen)
                Height.Text = p.height
                Weight.Text = p.weight
                HairColor.Text = p.hairColor
                EyeColor.Text = p.eyeColor
                Piersings.Text = Common.formatBoolean(p.piersings)
                Smartphone.Text = Common.formatBoolean(p.smartphone)
                SmartphoneOS.Text = p.smartPhoneOS
                AvailabilityDate.Text = p.availabilityDate
                LGBTAccounts.Text = Common.formatBoolean(p.lgbt)
                ReliableTransportation.Text = Common.formatBoolean(p.transportation)
                WillingMiles.Text = p.mile

                'If p.resume = Nothing Then
                '    ResumeLabel.Visible = True
                '    btnDownloadResume.Visible = False
                'Else
                '    ResumeLabel.Visible = False
                '    btnDownloadResume.Visible = True
                'End If

                'If p.license = Nothing Then
                '    Licenselabel.Visible = True
                '    btnDownloadLicense.Visible = False
                'Else
                '    Licenselabel.Visible = False
                '    btnDownloadLicense.Visible = True
                'End If

            Catch ex As Exception

            End Try

        Next


    End Sub

    Protected Function CreateWindowScript(ByVal userID As String, ByVal image As Integer) As String
        Return String.Format("var win = window.radopen('/Profile_Image.aspx?image={1}&UserID={0}','Details');win.center();", userID, image)
    End Function

    Private Sub btnApprove_Click(sender As Object, e As EventArgs) Handles btnApprove.Click

        DetailPanel.Visible = False
        ApprovePanel.Visible = True
    End Sub

    Function getFullName2(ByVal id As String) As String
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(id)

        Dim result = (From p In userdb.AspNetUsersProfiles Where p.UserID = currentUser.Id Select p).FirstOrDefault

        Return String.Format("{0} {1}", result.FirstName, result.LastName)

    End Function

    Private Sub btnSubmitAmbassador_Click(sender As Object, e As EventArgs) Handles btnSubmitAmbassador.Click

        'create a newuserID
        Dim NewUserID As String
        Dim OldUserID As String = (From p In db.tblAmbassadors Where p.ambassadorID = Request.QueryString("UserID") Select p.userID).FirstOrDefault

        'add asp.net user and roles
        Dim manager = New UserManager()
        manager.UserValidator = New UserValidator(Of ApplicationUser)(manager) With {.AllowOnlyAlphanumericUserNames = False}

        Dim user = New ApplicationUser() With {.UserName = PayrollIDTextBox.Text}
        Dim result = manager.Create(user, PasswordTextBox.Text)
        If result.Succeeded Then

            user.Email = (From p In db.tblAmbassadors Where p.ambassadorID = Request.QueryString("UserID") Select p.EmailAddress).FirstOrDefault
            manager.Update(user)

            manager.AddToRole(user.Id, "Student")
            manager.Update(user)

            NewUserID = user.Id


        End If


        'add to asp.net profile
        Dim q = From p In db.tblAmbassadors Where p.ambassadorID = Request.QueryString("UserID") Select p

        For Each p In q

            Dim newProfile As New AspNetUsersProfile

            newProfile.SiteID = "GigEngyn"
            newProfile.UserID = user.Id

            newProfile.FirstName = p.FirstName
            newProfile.LastName = p.LastName
            newProfile.Address = p.Address1
            newProfile.Address2 = p.Address2
            newProfile.City = p.City
            newProfile.State = p.State
            newProfile.PostCode = p.Zip
            newProfile.Phone1 = p.Phone
            newProfile.DOB = p.DOB
            newProfile.Status = "Active"
            newProfile.LastLoginDate = Date.Now()

            userdb.AspNetUsersProfiles.InsertOnSubmit(newProfile)
            userdb.SubmitChanges()


            'add to profile
            Dim userProfile As New tblProfile

            userProfile.userID = user.Id
            userProfile.firstName = p.FirstName
            userProfile.lastName = p.LastName
            userProfile.IsStaff = False
            userProfile.timeZone = "Central Standard Time"
            userProfile.lastLoginDate = Date.Now()
            userProfile.lastActivityDate = Date.Now()
            userProfile.hasLoggedIn = False
            userProfile.IsOnline = False
            userProfile.enableAllClients = False
            userProfile.enableAllMarkets = False
            userProfile.enableAllSuppliers = False

            db.tblProfiles.InsertOnSubmit(userProfile)
            db.SubmitChanges()

        Next

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

        'add to courses
        userdb.AddStudentToCourse(PayrollIDTextBox.Text, "1c6fd977-048c-4550-8dbc-02d73f4f3e77")

        'update ambassador with new login
        Dim ambassador = (From p In db.tblAmbassadors Where p.ambassadorID = Request.QueryString("UserID") Select p).FirstOrDefault
        ambassador.userID = user.Id
        ambassador.Status = "Active"
        ambassador.userName = user.UserName
        ambassador.payrollID = user.UserName
        ambassador.userGUID = PasswordTextBox.Text
        ambassador.dateCreated = Date.Now()
        ambassador.createdBy = Context.User.Identity.GetUserId()

        db.SubmitChanges()


        Dim newnote As New tblAmbassadorNote
        newnote.userID = ambassador.userID
        newnote.comment = RadTextBox1.Text
        newnote.createdBy = Context.User.Identity.GetUserId()
        newnote.createdDate = Date.Now()

        db.tblAmbassadorNotes.InsertOnSubmit(newnote)
        db.SubmitChanges()


        db.ApproveNewAmbassador(OldUserID, user.Id)


        Response.Redirect("/ambassadors/ViewAmbassadorDetails?UserID=" & ambassador.userID)

    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        DetailPanel.Visible = True
        ApprovePanel.Visible = False
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click

        Response.Redirect("/ambassadors/RejectedList")
    End Sub

End Class