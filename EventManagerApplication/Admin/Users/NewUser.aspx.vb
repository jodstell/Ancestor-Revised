Imports Telerik.Web.UI
Imports System
Imports System.Web.UI.WebControls
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin
Imports BingGeocoder
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.Drawing
Public Class NewUser1
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim userdb As New LMSDataClassesDataContext

    Public Class UserManager1
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub AccountWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles AccountWizard.CancelButtonClick
        Response.Redirect("/admin/viewuserslist")
    End Sub

    Private Sub AccountWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles AccountWizard.FinishButtonClick

        msgLabel.Text = "Finish Button Clicked"

        Dim userName As String = userNameTextBox.Text
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
        Dim result = manager.Create(user, passwordTextBox.Text)

        If result.Succeeded Then


            user.Email = emailAdressTextBox.Text
            user.PhoneNumber = phoneNumberTextBox.Text
            manager.Update(user)

            manager.AddToRole(user.Id, RoleRadioButtonList.SelectedValue)
            manager.Update(user)

            'add to asp.net profile
            Dim newProfile As New AspNetUsersProfile
            newProfile.UserID = user.Id
            newProfile.SiteID = "GigEngyn"
            newProfile.FirstName = firstNameTextBox.Text
            newProfile.LastName = lastNameTextBox.Text
            newProfile.Phone1 = phoneNumberTextBox.Text
            newProfile.Status = "Active"
            newProfile.LastLoginDate = Date.Now()

            userdb.AspNetUsersProfiles.InsertOnSubmit(newProfile)
            userdb.SubmitChanges()

            'add profile
            Dim userProfile As New tblProfile
            userProfile.userID = user.Id
            userProfile.firstName = firstNameTextBox.Text
            userProfile.lastName = lastNameTextBox.Text
            userProfile.IsStaff = False
            userProfile.timeZone = ddlTimeZone.SelectedValue
            userProfile.lastLoginDate = Date.Now()
            userProfile.lastActivityDate = Date.Now()
            userProfile.hasLoggedIn = False
            userProfile.IsOnline = False
            userProfile.userName = userNameTextBox.Text
            userProfile.userGUID = passwordTextBox.Text
            userProfile.status = 1
            userProfile.IsStaff = 1
            userProfile.modifiedBy = Context.User.Identity.GetUserId()
            userProfile.modifiedDate = Date.Now()
            userProfile.role = RoleRadioButtonList.SelectedValue

            If TeamComboBox.SelectedIndex = -1 Then
                'set to null if nothing is selected
                userProfile.teamID = Nothing
            Else
                'set to the selected value
                userProfile.teamID = TeamComboBox.SelectedValue
            End If

            'add clients
            If EnableAllClientsCheckBox.Checked = True Then
                userProfile.enableAllClients = True
            Else
                Dim Clients As IList(Of RadListBoxItem) = ClientListBox.CheckedItems
                For Each item As RadListBoxItem In Clients

                    Dim client As New tblStaffClient With {.clientID = item.Value, .userID = user.Id}
                    db.tblStaffClients.InsertOnSubmit(client)
                    db.SubmitChanges()

                Next

                userProfile.enableAllClients = False
            End If

            'add markets
            If EnableAllMarketsCheckBox.Checked = True Then
                userProfile.enableAllMarkets = True
            Else
                Dim Markets As IList(Of RadListBoxItem) = MarketListBox.CheckedItems
                For Each item As RadListBoxItem In Markets

                    Dim market As New tblStaffMarket With {.marketID = item.Value, .userID = user.Id}
                    db.tblStaffMarkets.InsertOnSubmit(market)
                    db.SubmitChanges()

                Next

                userProfile.enableAllMarkets = False
            End If

            ' add suppliers
            If EnableAllSupplierCheckBox.Checked = True Then
                userProfile.enableAllSuppliers = True

            Else
                Dim Supplers As IList(Of RadListBoxItem) = SupplierListBox.CheckedItems
                For Each item As RadListBoxItem In Supplers

                    Dim suppler As New tblStaffSupplier With {.supplierID = item.Value, .userID = user.Id}
                    db.tblStaffSuppliers.InsertOnSubmit(suppler)
                    db.SubmitChanges()

                    Try
                        'insert into course
                        Dim c = (From p In db.tblSuppliers Where p.supplierID = item.Value Select p.CourseID).FirstOrDefault

                        userdb.AddUserToCourse(user.Id, c)
                    Catch ex As Exception
                        'do nothing
                    End Try


                Next

                userProfile.enableAllSuppliers = False
            End If

            db.tblProfiles.InsertOnSubmit(userProfile)
            db.SubmitChanges()

            Response.Redirect("/admin/viewuserslist")

        Else

            msgLabel.Text = "There was a problem adding the user: " & result.Errors.FirstOrDefault()
        End If



    End Sub

    Private Sub EnableAllClientsCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles EnableAllClientsCheckBox.CheckedChanged
        If EnableAllClientsCheckBox.Checked = True Then
            ClientListBox.Visible = False
        Else
            ClientListBox.Visible = True
        End If
    End Sub

    Private Sub EnableAllMarketsCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles EnableAllMarketsCheckBox.CheckedChanged

        If EnableAllMarketsCheckBox.Checked = True Then
            MarketListBox.Visible = False
        Else
            MarketListBox.Visible = True
        End If
    End Sub

    Private Sub EnableAllSupplierCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles EnableAllSupplierCheckBox.CheckedChanged
        If EnableAllSupplierCheckBox.Checked = True Then
            SupplierListBox.Visible = False
        Else
            SupplierListBox.Visible = True
        End If
    End Sub

    'Private Sub userNameTextBox_TextChanged(sender As Object, e As EventArgs) Handles userNameTextBox.TextChanged

    '    'check if user exists
    '    Dim user As New LMSDataClassesDataContext
    '    Dim q = From p In user.AspNetUsers Where p.UserName = userNameTextBox.Text Select p

    '    If q.Count <> 0 Then
    '        '  UnavailableUserNameLabel.Text = "<span class='errorlabel'>User name already exists.</span>"

    '    Else
    '        ' UnavailableUserNameLabel.Text = ""
    '    End If


    'End Sub

    Sub ServerValidation(source As Object, args As ServerValidateEventArgs)

        'check if user exists
        Dim user As New LMSDataClassesDataContext
        Dim q = From p In user.AspNetUsers Where p.UserName = userNameTextBox.Text Select p

        If q.Count <> 0 Then
            ' UnavailableUserNameLabel.Text = "<span class='errorlabel'>User name already exists.</span>"
            args.IsValid = False
        Else
            args.IsValid = False
        End If

        args.IsValid = False

    End Sub
End Class