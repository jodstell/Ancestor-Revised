Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class PrivateDashboard
    Inherits System.Web.UI.MasterPage
    Dim CurrentClientID As String
    Dim db1 As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



        Try
            If Not Page.IsPostBack Then

                Dim db As New DataClassesDataContext

                Dim clientID As String = Common.GetCurrentClientID() 'get the current Client ID
                Session.Add("CurrentClientID", Common.GetCurrentClientID()) 'save the current ClientID in a session


                'show/hide admin panels
                Dim manager = New UserManager()
                Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

                Session.Add("CurrentUserID", currentUser.Id)

                Dim strUserAgent As String = Request.UserAgent.ToString().ToLower()
                If strUserAgent IsNot Nothing Then
                    If Request.Browser.IsMobileDevice = True OrElse strUserAgent.Contains("iphone") OrElse strUserAgent.Contains("blackberry") OrElse strUserAgent.Contains("mobile") OrElse strUserAgent.Contains("windows ce") OrElse strUserAgent.Contains("opera mini") OrElse strUserAgent.Contains("palm") Then
                        db1.UpdateLastActivity2(currentUser.Id, HttpContext.Current.Request.Url.AbsolutePath, True)
                    Else
                        db1.UpdateLastActivity2(currentUser.Id, HttpContext.Current.Request.Url.AbsolutePath, False)
                    End If
                End If



                Dim lmsdb As New LMSDataClassesDataContext
                Dim MyEventID As Integer = 0
                Try
                    If Request.Url.AbsolutePath = "/Events/EventDetails" Or Request.Url.AbsolutePath = "/Events/Event_Details" Then
                        MyEventID = Request.QueryString("ID")
                    End If
                    lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), MyEventID, Date.Now(), "Page Viewed", "", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)
                Catch ex As Exception

                End Try


                If Not manager.IsInRole(currentUser.Id, "Administrator") And manager.IsInRole(currentUser.Id, "Student") Then

                    'check if active
                    Dim thisAmbassador = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p).FirstOrDefault
                    If thisAmbassador.Status = "Terminated" Then
                        Response.Redirect("/Account/Lockout")
                        Context.GetOwinContext().Authentication.SignOut()
                    End If

                End If

                ' db.UpdateLastActivity(currentUser.Id, HttpContext.Current.Request.Url.AbsolutePath)

                If manager.IsInRole(currentUser.Id, "Administrator") Then
                    dashboardTab.Visible = True
                    ambassadorTab.Visible = False
                    classroomTab.Visible = False
                    events.Visible = False
                    events_dropdown.Visible = True
                    eventhitory.Visible = True
                    eventhitory2.Visible = True

                    'accounts.Visible = True
                    accounts_dropdown.Visible = True
                    accountsTab1.Visible = True
                    accountsTab2.Visible = True
                    accountsTab4.Visible = True
                    accountsdivider.Visible = True

                    gallery.Visible = True
                    reports.Visible = True
                    pos.Visible = True
                    profiletab.Visible = False
                    password.Visible = False
                    divider.Visible = False
                    logout.Visible = False
                    availableEventsTab.Visible = False
                    paymentsTab.Visible = False

                    ambassadors1.Visible = True
                    settings.Visible = True
                    admin.Visible = True

                    ClientNameLabel.Text = (From p In db1.tblClients Where p.clientID = clientID Select p.clientName).FirstOrDefault

                End If

                If manager.IsInRole(currentUser.Id, "GlobalAdmin") Then
                    dashboardTab.Visible = True
                    ambassadorTab.Visible = False
                    classroomTab.Visible = False
                    events.Visible = False
                    events_dropdown.Visible = True
                    eventhitory.Visible = True
                    eventhitory2.Visible = True

                    'accounts.Visible = True
                    accounts_dropdown.Visible = True
                    accountsTab1.Visible = True
                    accountsTab2.Visible = True
                    accountsTab4.Visible = True
                    accountsdivider.Visible = True

                    gallery.Visible = True
                    reports.Visible = True
                    pos.Visible = True
                    profiletab.Visible = False
                    password.Visible = False
                    divider.Visible = False
                    logout.Visible = False
                    availableEventsTab.Visible = False
                    paymentsTab.Visible = False

                    ambassadors1.Visible = True
                    settings.Visible = True
                    admin.Visible = True


                    ClientNameLabel.Text = (From p In db1.tblClients Where p.clientID = clientID Select p.clientName).FirstOrDefault

                End If

                If manager.IsInRole(currentUser.Id, "EventManager") Then
                    DashboardTab.Visible = True
                    ambassadorTab.Visible = False
                    classroomTab.Visible = False
                    Events.Visible = False
                    events_dropdown.Visible = True
                    eventhitory.Visible = False
                    eventhitory2.Visible = False

                    'Accounts.Visible = True
                    accounts_dropdown.Visible = True
                    accountsTab1.Visible = True
                    accountsTab2.Visible = True
                    accountsTab4.Visible = True
                    accountsdivider.Visible = True

                    gallery.Visible = True
                    reports.Visible = True
                    pos.Visible = True
                    profiletab.Visible = False
                    password.Visible = False
                    divider.Visible = False
                    Logout.Visible = False
                    availableEventsTab.Visible = False
                    paymentsTab.Visible = False

                    ambassadors1.Visible = True
                    settings.Visible = False
                    admin.Visible = False

                    ClientNameLabel.Text = (From p In db1.tblClients Where p.clientID = clientID Select p.clientName).FirstOrDefault

                End If

                If manager.IsInRole(currentUser.Id, "BrandMarketer") Then
                    dashboardTab.Visible = True
                    ambassadorTab.Visible = False
                    classroomTab.Visible = False
                    events.Visible = False
                    events_dropdown.Visible = True
                    eventhitory.Visible = False
                    eventhitory2.Visible = False

                    'accounts.Visible = True
                    accounts_dropdown.Visible = True
                    accountsTab1.Visible = True
                    accountsTab2.Visible = True
                    accountsTab4.Visible = True
                    accountsdivider.Visible = True

                    gallery.Visible = True
                    reports.Visible = True
                    pos.Visible = True
                    profiletab.Visible = False
                    password.Visible = False
                    divider.Visible = False
                    logout.Visible = False
                    availableEventsTab.Visible = False
                    paymentsTab.Visible = False

                    ambassadors1.Visible = True
                    settings.Visible = False
                    admin.Visible = False

                    ClientNameLabel.Text = (From p In db1.tblClients Where p.clientID = clientID Select p.clientName).FirstOrDefault

                End If

                If manager.IsInRole(currentUser.Id, "Accounting") Then
                    DashboardTab.Visible = True
                    ambassadorTab.Visible = False
                    classroomTab.Visible = False
                    Events.Visible = False
                    events_dropdown.Visible = True
                    eventhitory.Visible = False
                    eventhitory2.Visible = False

                    'Accounts.Visible = True
                    accounts_dropdown.Visible = True
                    accountsTab1.Visible = True
                    accountsTab2.Visible = False
                    accountsTab4.Visible = False
                    accountsdivider.Visible = False

                    gallery.Visible = True
                    reports.Visible = True
                    pos.Visible = True
                    profiletab.Visible = False
                    password.Visible = False
                    divider.Visible = False
                    Logout.Visible = False
                    availableEventsTab.Visible = False
                    paymentsTab.Visible = False

                    ambassadors1.Visible = True
                    settings.Visible = True
                    admin.Visible = False

                    ClientNameLabel.Text = (From p In db1.tblClients Where p.clientID = clientID Select p.clientName).FirstOrDefault

                End If

                If manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
                    DashboardTab.Visible = True
                    ambassadorTab.Visible = False
                    classroomTab.Visible = False
                    Events.Visible = False
                    events_dropdown.Visible = True
                    eventhitory.Visible = False
                    eventhitory2.Visible = False

                    'Accounts.Visible = True
                    accounts_dropdown.Visible = True
                    accountsTab1.Visible = True
                    accountsTab2.Visible = True
                    accountsTab4.Visible = True
                    accountsdivider.Visible = True

                    gallery.Visible = True
                    reports.Visible = True
                    pos.Visible = True
                    profiletab.Visible = False
                    password.Visible = False
                    divider.Visible = False
                    Logout.Visible = False
                    availableEventsTab.Visible = False
                    paymentsTab.Visible = False

                    ambassadors1.Visible = True
                    settings.Visible = False
                    admin.Visible = False

                    ClientNameLabel.Text = (From p In db1.tblClients Where p.clientID = clientID Select p.clientName).FirstOrDefault

                End If

                If manager.IsInRole(currentUser.Id, "Client") Then
                    DashboardTab.Visible = True
                    ambassadorTab.Visible = False
                    classroomTab.Visible = False
                    Events.Visible = True
                    events_dropdown.Visible = False
                    eventhitory.Visible = False
                    eventhitory2.Visible = False

                    'Accounts.Visible = True
                    accounts_dropdown.Visible = True
                    accountsTab1.Visible = True
                    accountsTab2.Visible = False
                    accountsTab4.Visible = False
                    accountsdivider.Visible = False

                    gallery.Visible = True
                    reports.Visible = True
                    pos.Visible = True
                    profiletab.Visible = False
                    password.Visible = False
                    divider.Visible = False
                    Logout.Visible = False
                    availableEventsTab.Visible = False
                    paymentsTab.Visible = False

                    ambassadors1.Visible = False
                    settings.Visible = False
                    admin.Visible = False

                    ClientNameLabel.Text = (From p In db1.tblClients Where p.clientID = clientID Select p.clientName).FirstOrDefault

                End If

                If manager.IsInRole(currentUser.Id, "Agency") Then
                    DashboardTab.Visible = True
                    ambassadorTab.Visible = False
                    classroomTab.Visible = False
                    Events.Visible = True
                    events_dropdown.Visible = False
                    eventhitory.Visible = False
                    eventhitory2.Visible = False

                    'Accounts.Visible = True
                    accounts_dropdown.Visible = True
                    accountsTab1.Visible = True
                    accountsTab2.Visible = False
                    accountsTab4.Visible = False
                    accountsdivider.Visible = False

                    gallery.Visible = True
                    reports.Visible = False
                    pos.Visible = False
                    profiletab.Visible = False
                    password.Visible = False
                    divider.Visible = False
                    Logout.Visible = False
                    availableEventsTab.Visible = False
                    paymentsTab.Visible = False

                    ambassadors1.Visible = False
                    settings.Visible = False
                    admin.Visible = False

                    ClientNameLabel.Text = (From p In db1.tblClients Where p.clientID = clientID Select p.clientName).FirstOrDefault

                End If

                If manager.IsInRole(currentUser.Id, "Student") Then
                    TopRightNavPanel.Visible = False
                    DashboardTab.Visible = False
                    ambassadorTab.Visible = True
                    Events.Visible = False
                    events_dropdown.Visible = False
                    classroomTab.Visible = True
                    eventhitory.Visible = False
                    eventhitory2.Visible = False

                    'Accounts.Visible = False
                    accounts_dropdown.Visible = False
                    accountsTab1.Visible = False
                    accountsTab2.Visible = False
                    accountsTab4.Visible = False
                    accountsdivider.Visible = False

                    gallery.Visible = False
                    reports.Visible = False
                    pos.Visible = False
                    profiletab.Visible = True
                    password.Visible = True
                    divider.Visible = True
                    Logout.Visible = True
                    clientfooter.Visible = False
                    availableEventsTab.Visible = True
                    paymentsTab.Visible = True

                    ambassadors1.Visible = False
                    settings.Visible = False
                    admin.Visible = False

                    ClientNameLabel.Text = (From p In db1.tblClients Where p.clientID = clientID Select p.clientName).FirstOrDefault

                End If


                ' If (Session("CurrentClientID") IsNot Nothing) Then




                ' ClientNameLabel2.Text = (From p In db1.tblClients Where p.clientID = clientID Select p.clientName).FirstOrDefault



            End If




        Catch ex As Exception
            Response.Redirect("/")
        End Try

        SettingsLink1.Text = "Configuration"
        SettingsLink1.NavigateUrl = "/admin/ClientDetails?ClientID=" & Common.GetCurrentClientID
        SettingsLink2.Text = "Manage Users"
        SettingsLink2.NavigateUrl = "/admin/viewuserslist?ClientID=" & Common.GetCurrentClientID
        SettingsLink3.Text = "Settings"
        SettingsLink3.NavigateUrl = "/admin/sitesettings?ClientID=" & Common.GetCurrentClientID
        SettingsLink4.Text = "Email Messages"
        SettingsLink4.NavigateUrl = "/admin/EmailMessages?messageID=1?ClientID=" & Common.GetCurrentClientID

        FullNameLabel.Text = GetFullName()

    End Sub

    Function GetFullName() As String
        Try
            Dim db As New DataClassesDataContext

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

            Dim result = (From p In db.tblProfiles Where p.userID = currentUser.Id Select p).FirstOrDefault

            Return String.Format("{0} {1}", result.firstName, result.lastName)
        Catch ex As Exception

            Return "There was an error"
        End Try


    End Function



    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class


    Function ViewClientMenu(clientID As String) As String

        Dim result = (From p In db1.tblStaffClients Where p.userID = Common.GetCurrentClientID() And p.clientID = clientID Select p).Count
        If result > 0 Then
            Return "True"
        Else
            Return "False"
        End If


        Return True
    End Function

    'Private Sub ClientMenuRepeater_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles ClientMenuRepeater.ItemCommand

    '    Select Case e.CommandName
    '        Case "ChangeClient"

    '            Session("CurrentClientID") = Convert.ToInt32(e.CommandArgument)

    '            Dim db As New DataClassesDataContext

    '            Dim manager = New UserManager()
    '            Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

    '            Dim result = (From p In db.tblProfiles Where p.userID = currentUser.Id Select p).FirstOrDefault

    '            result.currentClientID = Convert.ToInt32(e.CommandArgument)

    '            db.SubmitChanges()

    '            ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = Convert.ToInt32(e.CommandArgument) Select p.clientName).FirstOrDefault

    '            Response.Redirect("/dashboard")
    '    End Select
    'End Sub
End Class