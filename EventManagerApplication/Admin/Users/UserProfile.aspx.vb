Imports Telerik.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin

Public Class UserProfile
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim userdb As New LMSDataClassesDataContext


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim user As String = Request.QueryString("UserID")
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(user)

        'UserIDLabel.Text = user

        If Not Page.IsPostBack Then
            Dim q = From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p
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

                Try
                    TeamComboBox.SelectedValue = p.teamID
                Catch ex As Exception

                End Try


                If p.enableAllClients = True Then
                    EnableAllClientsCheckBox.Checked = True
                    clientsPanel.Visible = False
                End If

                If p.enableAllSuppliers = True Then
                    EnableAllSupplierCheckBox.Checked = True
                    SuppliersPanel.Visible = False
                End If

                If p.enableAllMarkets = True Then
                    EnableAllMarketsCheckBox.Checked = True
                    MarketsPanel.Visible = False
                End If

                'check if AspNetProfile exists
                Dim r = From i In userdb.AspNetUsersProfiles Where i.UserID = Request.QueryString("UserID") Select i

                If r.Count = 0 Then
                    'add to asp.net profile
                    Dim newProfile As New AspNetUsersProfile
                    newProfile.UserID = Request.QueryString("UserID")
                    newProfile.SiteID = "GigEngyn"
                    newProfile.FirstName = p.firstName
                    newProfile.LastName = p.lastName
                    newProfile.Status = "Active"
                    newProfile.LastLoginDate = Date.Now()

                    userdb.AspNetUsersProfiles.InsertOnSubmit(newProfile)
                    userdb.SubmitChanges()

                Else
                    'do nothing
                End If

            Next

            If manager.IsInRole(currentUser.Id, "Administrator") Then
                'Me.ckAdmin.Checked = True
                RoleRadioButtonList.SelectedValue = "Administrator"

            End If

            If manager.IsInRole(currentUser.Id, "Accounting") Then
                'Me.ckAccounting.Checked = True
                RoleRadioButtonList.SelectedValue = "Administrator"
            End If

            If manager.IsInRole(currentUser.Id, "Agency") Then
                'Me.ckAgency.Checked = True
                RoleRadioButtonList.SelectedValue = "Agency"
            End If

            If manager.IsInRole(currentUser.Id, "Client") Then
                'Me.ckClient.Checked = True
                RoleRadioButtonList.SelectedValue = "Client"
            End If

            If manager.IsInRole(currentUser.Id, "EventManager") Then
                'Me.ckEventManager.Checked = True
                RoleRadioButtonList.SelectedValue = "EventManager"
            End If

            If manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
                'Me.ckRecuiter.Checked = True
                RoleRadioButtonList.SelectedValue = "Recruiter/Booking"
            End If

            If manager.IsInRole(currentUser.Id, "BrandMarketer") Then
                'Me.ckRecuiter.Checked = True
                RoleRadioButtonList.SelectedValue = "BrandMarketer"
            End If




        End If

    End Sub

    Private Sub LogEvent(ByVal sender As Object, ByVal eventName As String, ByVal items As IEnumerable(Of RadListBoxItem))

        Dim affectedItems As New List(Of String)()

        For Each item As RadListBoxItem In items
            affectedItems.Add(item.Value)
        Next

        Dim message As String = String.Format("{0}", affectedItems.ToArray())
        HF_SelectedItemID.Value = message

    End Sub


    Protected Sub SelectedSupplierList_Inserted(sender As Object, e As RadListBoxEventArgs)

        Try

            'get the brandID
            LogEvent(sender, "Inserted", e.Items)

            Dim userID As String = Request.QueryString("userID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'insert the item
            db.InsertStaffSupplier(selectedValue, userID)
            db.SubmitChanges()

            'insert into course
            Dim c = (From p In db.tblSuppliers Where p.supplierID = selectedValue Select p.CourseID).FirstOrDefault

            userdb.AddUserToCourse(userID, c)

        Catch ex As Exception

        End Try

    End Sub

    Protected Sub SelectedSupplierList_Deleted(sender As Object, e As RadListBoxEventArgs)

        Try
            'get the supplierID
            LogEvent(sender, "Deleted", e.Items)

            Dim userID As String = Request.QueryString("userID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'delete the item
            db.DeleteStaffSupplier(selectedValue, userID)
            db.SubmitChanges()

            Dim c = (From p In db.tblSuppliers Where p.supplierID = selectedValue Select p.CourseID).FirstOrDefault

            userdb.RemoveUserFromCourse(userID, c)


        Catch ex As Exception

        End Try

    End Sub

    Protected Sub SelectedClientList_Inserted(sender As Object, e As RadListBoxEventArgs)

        Try

            'get the brandID
            LogEvent(sender, "Inserted", e.Items)

            Dim userID As String = Request.QueryString("userID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'insert the item
            db.InsertStaffClient(selectedValue, userID)
            db.SubmitChanges()

            'rebind the lists
            'SelectedSupplierList.DataBind()
            'SupplierList.DataBind()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try

    End Sub

    Protected Sub SelectedClientList_Deleted(sender As Object, e As RadListBoxEventArgs)

        Try
            'get the supplierID
            LogEvent(sender, "Deleted", e.Items)

            Dim userID As String = Request.QueryString("userID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'delete the item
            db.DeleteStaffClient(selectedValue, userID)
            db.SubmitChanges()

            'rebind the grids
            'SelectedSuppliers.DataBind()
            ' AvailableSuppliers.DataBind()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try

    End Sub

    Protected Sub SelectedMarketList_Inserted(sender As Object, e As RadListBoxEventArgs)

        Try

            'get the brandID
            LogEvent(sender, "Inserted", e.Items)

            Dim userID As String = Request.QueryString("userID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'insert the item
            db.InsertStaffMarket(selectedValue, userID)
            db.SubmitChanges()

            'rebind the lists
            'SelectedSupplierList.DataBind()
            'SupplierList.DataBind()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try

    End Sub

    Protected Sub SelectedMarketList_Deleted(sender As Object, e As RadListBoxEventArgs)

        Try
            'get the supplierID
            LogEvent(sender, "Deleted", e.Items)

            Dim userID As String = Request.QueryString("userID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'delete the item
            db.DeleteStaffMarket(selectedValue, userID)
            db.SubmitChanges()

            'rebind the grids
            'SelectedSuppliers.DataBind()
            ' AvailableSuppliers.DataBind()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try

    End Sub

    Private Sub EnableAllClientsCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles EnableAllClientsCheckBox.CheckedChanged

        ' clientsPanel.Visible = True

        Dim enableClient = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p.enableAllClients).FirstOrDefault

        If enableClient = True Then
            'set to false
            Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
            m.enableAllClients = False
            db.SubmitChanges()

            'set the marketlist to true
            clientsPanel.Visible = True

        Else
            Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
            m.enableAllClients = True
            db.SubmitChanges()

            'set the marketlist to true
            clientsPanel.Visible = False
        End If

    End Sub

    Private Sub EnableAllMarketsCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles EnableAllMarketsCheckBox.CheckedChanged
        'get the new value
        Dim enableMarket = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p.enableAllMarkets).FirstOrDefault

        If enableMarket = True Then
            'set to false
            Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
            m.enableAllMarkets = False
            db.SubmitChanges()

            'set the marketlist to true
            MarketsPanel.Visible = True

        Else
            Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
            m.enableAllMarkets = True
            db.SubmitChanges()

            'set the marketlist to true
            MarketsPanel.Visible = False
        End If


    End Sub

    Private Sub RoleRadioButtonList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles RoleRadioButtonList.SelectedIndexChanged

        Dim user2 = Request.QueryString("UserID")

        Dim profile = (From p In db.tblProfiles Where p.userID = user2).FirstOrDefault

        db.SubmitChanges()

        If RoleRadioButtonList.SelectedValue = "Administrator" Then
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)


            manager.AddToRole(currentUser.Id, "Administrator")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

            profile.role = "Administrator"
            db.SubmitChanges()
        Else
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)

            manager.RemoveFromRole(currentUser.Id, "Administrator")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
        End If


        If RoleRadioButtonList.SelectedValue = "Accounting" Then
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)


            manager.AddToRole(currentUser.Id, "Accounting")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

            profile.role = "Accounting"
            db.SubmitChanges()
        Else
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)

            manager.RemoveFromRole(currentUser.Id, "Accounting")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
        End If


        If RoleRadioButtonList.SelectedValue = "Agency" Then
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)


            manager.AddToRole(currentUser.Id, "Agency")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

            profile.role = "Agency"
            db.SubmitChanges()
        Else
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)

            manager.RemoveFromRole(currentUser.Id, "Agency")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
        End If


        If RoleRadioButtonList.SelectedValue = "Client" Then
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)


            manager.AddToRole(currentUser.Id, "Client")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

            profile.role = "Client"
            db.SubmitChanges()
        Else
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)

            manager.RemoveFromRole(currentUser.Id, "Client")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
        End If


        If RoleRadioButtonList.SelectedValue = "EventManager" Then
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)


            manager.AddToRole(currentUser.Id, "EventManager")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

            profile.role = "EventManager"
            db.SubmitChanges()
        Else
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)

            manager.RemoveFromRole(currentUser.Id, "EventManager")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
        End If


        If RoleRadioButtonList.SelectedValue = "Recruiter/Booking" Then
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)


            manager.AddToRole(currentUser.Id, "Recruiter/Booking")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

            profile.role = "Recruiter/Booking"
            db.SubmitChanges()
        Else
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)

            manager.RemoveFromRole(currentUser.Id, "Recruiter/Booking")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
        End If

        If RoleRadioButtonList.SelectedValue = "BrandMarketer" Then
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)


            manager.AddToRole(currentUser.Id, "BrandMarketer")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

            profile.role = "BrandMarketer"
            db.SubmitChanges()
        Else
            Dim user As String = Request.QueryString("UserID")

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(user)

            manager.RemoveFromRole(currentUser.Id, "BrandMarketer")

            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
        End If

    End Sub

    'Private Sub ckAdmin_CheckedChanged(sender As Object, e As EventArgs) Handles ckAdmin.CheckedChanged

    '    If ckAdmin.Checked = True Then
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)


    '        manager.AddToRole(currentUser.Id, "Administrator")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    Else
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)

    '        manager.RemoveFromRole(currentUser.Id, "Administrator")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    End If

    'End Sub

    'Private Sub ckAccounting_CheckedChanged(sender As Object, e As EventArgs) Handles ckAccounting.CheckedChanged

    '    If ckAccounting.Checked = True Then
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)


    '        manager.AddToRole(currentUser.Id, "Accounting")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    Else
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)

    '        manager.RemoveFromRole(currentUser.Id, "Accounting")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    End If

    'End Sub

    'Private Sub ckAgency_CheckedChanged(sender As Object, e As EventArgs) Handles ckAgency.CheckedChanged

    '    If ckAgency.Checked = True Then
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)


    '        manager.AddToRole(currentUser.Id, "Agency")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    Else
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)

    '        manager.RemoveFromRole(currentUser.Id, "Agency")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    End If

    'End Sub

    'Private Sub ckClient_CheckedChanged(sender As Object, e As EventArgs) Handles ckClient.CheckedChanged

    '    If ckClient.Checked = True Then
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)


    '        manager.AddToRole(currentUser.Id, "Client")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    Else
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)

    '        manager.RemoveFromRole(currentUser.Id, "Client")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    End If

    'End Sub

    'Private Sub ckEventManager_CheckedChanged(sender As Object, e As EventArgs) Handles ckEventManager.CheckedChanged

    '    If ckEventManager.Checked = True Then
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)


    '        manager.AddToRole(currentUser.Id, "Recruiter/Booking")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    Else
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)

    '        manager.RemoveFromRole(currentUser.Id, "Recruiter/Booking")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    End If

    'End Sub

    'Private Sub ckRecuiter_CheckedChanged(sender As Object, e As EventArgs) Handles ckRecuiter.CheckedChanged

    '    If ckRecuiter.Checked = True Then
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)


    '        manager.AddToRole(currentUser.Id, "EventManager")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    Else
    '        Dim user As String = Request.QueryString("UserID")

    '        Dim manager = New UserManager()
    '        Dim currentUser = manager.FindById(user)

    '        manager.RemoveFromRole(currentUser.Id, "EventManager")

    '        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

    '    End If
    'End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        'identity
        Dim user As String = Request.QueryString("UserID")

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(user)

        currentUser.Email = EmailTextBox.Text
        currentUser.PhoneNumber = phoneNumberTextBox.Text

        manager.Update(currentUser)


        'tblProfile
        Dim profile = (From p In db.tblProfiles Where p.userID = user).FirstOrDefault
        profile.firstName = FirstName.Text
        profile.lastName = LastName.Text
        profile.timeZone = ddlTimeZone.SelectedValue
        profile.modifiedBy = Context.User.Identity.GetUserId()
        profile.modifiedDate = Date.Now()

        db.SubmitChanges()

        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")


        'ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", True)


    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click

        Dim user As String = Request.QueryString("UserID")

        If IsValid Then
                Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
                Dim signInManager = Context.GetOwinContext().Get(Of ApplicationSignInManager)()
                Dim result As IdentityResult = manager.ChangePassword(user, PortalPassword.Text, NewPasswordTextBox.Text)
                If result.Succeeded Then
                    Dim userInfo = manager.FindById(user)
                    ' signInManager.SignIn(userInfo, isPersistent:=False, rememberBrowser:=False)

                    Dim q = (From p In db.tblProfiles Where p.userID = user Select p).FirstOrDefault
                    q.userGUID = NewPasswordTextBox.Text
                    db.SubmitChanges()

                    PortalPassword.Text = NewPasswordTextBox.Text

                    msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
                Else
                msgLabel.Text = Common.ShowAlert("warning", "There was a problem saving your password!  " & result.Errors.FirstOrDefault())
            End If
            End If

            NewPasswordTextBox.Text = ""
            ConfirmTextBox.Text = ""

    End Sub

    Private Sub EnableAllSupplierCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles EnableAllSupplierCheckBox.CheckedChanged
        'get the new value
        Dim enableSupplier = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p.enableAllSuppliers).FirstOrDefault

        If enableSupplier = True Then
            'set to false
            Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
            m.enableAllSuppliers = False
            db.SubmitChanges()

            'set the supplierlist to true
            SuppliersPanel.Visible = True

        Else
            Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
            m.enableAllSuppliers = True
            db.SubmitChanges()

            'set the supplierlist to true
            SuppliersPanel.Visible = False
        End If

    End Sub

    Private Sub btnReturn_Click(sender As Object, e As EventArgs) Handles btnReturn.Click
        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", True)
    End Sub

    'Private Sub TeamsListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles TeamsListBox.ItemDataBound

    '    'populate the teams list

    '    Dim s = From p In db.tblStaffTeams Where p.userID = Request.QueryString("UserID") Select p

    '    For Each p In s


    '        Dim collection As IList(Of RadListBoxItem) = TeamsListBox.Items

    '        For Each item As RadListBoxItem In collection

    '            Try
    '                Dim itemToSelect As RadListBoxItem = TeamsListBox.FindItemByValue(p.teamID)
    '                itemToSelect.Checked = True

    '            Catch ex As Exception

    '            End Try

    '        Next


    '    Next

    'End Sub

    Private Sub btnUpdateTeams_Click(sender As Object, e As EventArgs) Handles btnUpdateTeams.Click

        If TeamComboBox.SelectedIndex = -1 Then
            'set to null if nothing is selected
            Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
            m.teamID = Nothing
            db.SubmitChanges()
        Else
            'set to the selected value
            Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
            m.teamID = TeamComboBox.SelectedValue
            db.SubmitChanges()
        End If

        'set to null if none is selected
        If TeamComboBox.SelectedValue = 0 Then
            Dim m = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault
            m.teamID = Nothing
            db.SubmitChanges()
        End If





        'Dim Teams As IList(Of RadListBoxItem) = TeamsListBox.CheckedItems
        'For Each item As RadListBoxItem In Teams

        '    Dim team As New tblStaffTeam With {.userID = Request.QueryString("UserID"), .teamID = item.Value}
        '    db.tblStaffTeams.InsertOnSubmit(team)
        '    db.SubmitChanges()

        'Next

    End Sub


End Class