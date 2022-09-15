Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.IO
Imports System.Globalization
Imports System.Web.Script.Serialization
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports System.Net

Public Class SiteAdministration
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim db2 As New LMSDataClassesDataContext
    Dim siteid As String = "GigEngyn"

    Private Shared ReadOnly CookieName As String = "TabSession"


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'set Client Name
        ClientNameLabel.Text = Common.GetCurrentClientName()



        'get counts
        CurrentLoginCountLabel.Text = (From p In db.qryGetLoggedInUsers Select p).Count
        TotalLoginCount.Text = (From p In db.qryGetLoggedInUsers_last24hours Select p).Count

        Dim con0 = (From p In db.GetLoggedInUserTotals() Select p).FirstOrDefault

        If con0.Difference = 0 Then
            CurrentLoginIcon.Text = ""
            TotalLoginIcon.Text = ""
        ElseIf con0.Difference > 0 Then
            CurrentLoginIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
            TotalLoginIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            CurrentLoginIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
            TotalLoginIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        Dim total = (From p In db.qryGetLoggedInUsers_last24hours Select p).Count
        Dim visits = (From p In db.qryGetNewVisits_last24hours Select p).Count

        NewVisitPercentLabel.Text = String.Format("{0:0%}", visits / total)

        Dim con = (From p In db.GetNewVisitsTotals() Select p).FirstOrDefault

        If con.Difference = 0 Then
            NewVisitPercentIcon.Text = ""
        ElseIf con.Difference > 0 Then
            NewVisitPercentIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewVisitPercentIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If




        RecapsSubmittedLabel.Text = (From p In db.qryGetRecapCreated_last24hours Select p).Count

        Dim con1 = (From p In db.GetLastHourChangeCount("Recap Completed") Select p).FirstOrDefault

        If con1.Total = 0 Then
            RecapsSubmittedIcon.Text = ""
        ElseIf con1.Total > 0 Then
            RecapsSubmittedIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            RecapsSubmittedIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        ApprovedEventsCountLabel.Text = (From p In db.qryGetApprovedEvents_last24hrs Select p).Count
        Dim con2 = (From p In db.GetLastHourChangeCount("Event Approved") Select p).FirstOrDefault
        If con2.Total = 0 Then
            ApprovedEventIcon.Text = ""
        ElseIf con2.Total > 0 Then
            ApprovedEventIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            ApprovedEventIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If



        'New Events Count
        NewEventsCountLabel.Text = (From p In db.qryGetNewEvents_last24hours Select p).Count

        Dim con3 = (From p In db.GetLastHourChangeCount("Event Created") Select p).FirstOrDefault
        If con3.Total = 0 Then
            NewEventIcon.Text = ""
        ElseIf con3.Total > 0 Then
            NewEventIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewEventIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If

        NewRegistrationsLabel.Text = (From p In db.qryGetRegistrations_last24hrs Select p).Count
        Dim con5 = (From p In db.GetNewRegistrations() Select p).FirstOrDefault
        If con5.Difference = 0 Then
            NewRegistrationsIcon.Text = ""
        ElseIf con5.Difference > 0 Then
            NewRegistrationsIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewRegistrationsIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        NewAmbassadorsLabel.Text = (From p In db.qryGetNewAmbassadors_last24hrs Select p).Count


        NewAssignmentsLabel.Text = (From p In db.qryGetAmbassadorAssigned_last24hrs Select p).Count

        Dim con4 = (From p In db.GetLastHourChangeCount("Ambassador Assigned") Select p).FirstOrDefault
        If con4.Total = 0 Then
            NewAssignmentsIcon.Text = ""
        ElseIf con4.Total > 0 Then
            NewAssignmentsIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewAssignmentsIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        'LMSVersionLabel.Text = (From p In db2.Sites Where p.SiteID = "GigEngyn" Select p.RequiredTestText).FirstOrDefault

        lblASPVersion.Text = String.Format("Build Version: {0} ", System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString())



        If Request.Cookies(CookieName) IsNot Nothing Then


            If Request.QueryString("LoadState") IsNot Nothing Then

                Dim state = Request.QueryString("LoadState")

                If state = "Yes" Then
                    If Not Page.IsPostBack Then

                        '
                        Try
                            RadPersistenceManager1.LoadState()

                        Catch ex As Exception

                        End Try

                    End If
                    ' End If
                End If

            End If

        End If



    End Sub

    Sub BindStats()
        'get counts
        CurrentLoginCountLabel.Text = (From p In db.qryGetLoggedInUsers Select p).Count
        TotalLoginCount.Text = (From p In db.qryGetLoggedInUsers_last24hours Select p).Count

        Dim con0 = (From p In db.GetLoggedInUserTotals() Select p).FirstOrDefault

        If con0.Difference = 0 Then
            CurrentLoginIcon.Text = ""
            TotalLoginIcon.Text = ""
        ElseIf con0.Difference > 0 Then
            CurrentLoginIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
            TotalLoginIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            CurrentLoginIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
            TotalLoginIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        Dim total = (From p In db.qryGetLoggedInUsers_last24hours Select p).Count
        Dim visits = (From p In db.qryGetNewVisits_last24hours Select p).Count

        NewVisitPercentLabel.Text = String.Format("{0:0%}", visits / total)

        Dim con = (From p In db.GetNewVisitsTotals() Select p).FirstOrDefault

        If con.Difference = 0 Then
            NewVisitPercentIcon.Text = ""
        ElseIf con.Difference > 0 Then
            NewVisitPercentIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewVisitPercentIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If




        RecapsSubmittedLabel.Text = (From p In db.qryGetRecapCreated_last24hours Select p).Count

        Dim con1 = (From p In db.GetLastHourChangeCount("Recap Completed") Select p).FirstOrDefault

        If con1.Total = 0 Then
            RecapsSubmittedIcon.Text = ""
        ElseIf con1.Total > 0 Then
            RecapsSubmittedIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            RecapsSubmittedIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        ApprovedEventsCountLabel.Text = (From p In db.qryGetApprovedEvents_last24hrs Select p).Count
        Dim con2 = (From p In db.GetLastHourChangeCount("Event Approved") Select p).FirstOrDefault
        If con2.Total = 0 Then
            ApprovedEventIcon.Text = ""
        ElseIf con2.Total > 0 Then
            ApprovedEventIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            ApprovedEventIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If
    End Sub

    Function getAccountsCount(ByVal marketID As Integer) As Integer

        Return (From p In db.tblAccounts Where p.marketID = marketID Select p).Count

    End Function

    Private Sub btnViewSiteConfiguration_Click(sender As Object, e As EventArgs) Handles btnViewSiteConfiguration.Click
        ' row1.Visible = False
        ' PanelSiteConfiguration.Visible = True

        Response.Redirect("/admin/sitesettings")
    End Sub

    'Private Sub ButtonSiteConfiguration_Click(sender As Object, e As EventArgs) Handles ButtonSiteConfiguration.Click
    '    row1.Visible = True
    '    PanelSiteConfiguration.Visible = False
    'End Sub

    Private Sub btnViewStaffConfiguration_Click(sender As Object, e As EventArgs) Handles btnViewStaffConfiguration.Click
        row1.Visible = False
        PanelStaffConfiguration.Visible = True
    End Sub

    Private Sub ButtonStaffConfiguration_Click(sender As Object, e As EventArgs) Handles ButtonStaffConfiguration.Click
        row1.Visible = True
        PanelStaffConfiguration.Visible = False
    End Sub

    Function getMarketCount(ByVal regionID As Integer) As Integer

        Return (From p In db.tblMarkets Where p.regionID = regionID Select p).Count

    End Function

    Private Sub btnWeatherAPI_Click(sender As Object, e As EventArgs) Handles btnWeatherAPI.Click

        row1.Visible = False
        PanelWeatherAPI.Visible = True

    End Sub

    Private Sub ButtonWeatherAPIConfiguration_Click(sender As Object, e As EventArgs) Handles ButtonWeatherAPIConfiguration.Click
        row1.Visible = True
        PanelWeatherAPI.Visible = False
    End Sub



    'User Manager Control
    Function checkIfAdmin(ByVal id As String) As Boolean
        Try
            Dim manager = New UserManager()
            Dim currentUser = manager.FindByName(id)

            If manager.IsInRole(currentUser.Id, "Administrator") Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try

        Return False

    End Function

    Function checkIfInstr(ByVal id As String) As Boolean
        Try
            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(id)

            If manager.IsInRole(currentUser.Id, "Instructor") Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try

    End Function

    Function checkIfEditor(ByVal id As String) As Boolean
        Try
            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(id)

            If manager.IsInRole(currentUser.Id, "Editor") Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try

    End Function

    Function checkIfStudent(ByVal id As String) As Boolean
        Try
            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(id)

            If manager.IsInRole(currentUser.Id, "Student") Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try

    End Function

    Function getLastLoginDate(ByVal currentUser)

        Try
            Dim manager = New UserManager()

            Dim user As ApplicationUser = manager.FindByName(currentUser)

            Dim q = (From p In db2.UserDetails Where p.UserID = user.Id Select p.LastLoginDate).FirstOrDefault

            Return GetTimeAdjustment(q)
        Catch ex As Exception
            Return ""
        End Try

    End Function

    Function GetTimeAdjustment(ByVal d As Date) As String

        Try

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            Dim MyTimeZone As String

            Dim currentuser_TimeZone = (From p In db2.AspNetUsersProfiles Where p.UserID = currentUser.Id Select p.TimeZone).FirstOrDefault

            If currentuser_TimeZone = "" Or Nothing Then
                MyTimeZone = (From p In db2.Sites Where p.SiteID = siteid Select p.DefaultTimeZone).FirstOrDefault
            Else
                MyTimeZone = currentuser_TimeZone
            End If

            Dim MyCulture As String = (From p In db2.Sites Where p.SiteID = siteid Select p.CultureInfoCode).FirstOrDefault

            Dim cstZone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(MyTimeZone)

            Dim cstTime As DateTime = TimeZoneInfo.ConvertTimeFromUtc(d, cstZone)

            'add culture
            Dim culture As CultureInfo = CultureInfo.CreateSpecificCulture(MyCulture)


            Return String.Format("{0} ({1})", cstTime.ToString(culture.DateTimeFormat), ShortTimeZoneFormat(MyTimeZone))
        Catch ex As Exception
            Return ""
        End Try

    End Function

    Private Function ShortTimeZoneFormat(timeZoneStandardName As String) As String
        Dim TimeZoneElements As String() = timeZoneStandardName.Split(" "c)
        Dim shortTimeZone As String = [String].Empty
        For Each element As String In TimeZoneElements
            'copies the first element of each word
            shortTimeZone += element(0)
        Next
        Return shortTimeZone
    End Function

    Function getformat(ByVal status As String) As String

        Select Case status
            Case "Active"
                Return "success"
            Case "Pending"
                Return "secondary"
            Case ""
                Return ""

        End Select

#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths




    Protected Sub EventDataGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)
        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM tblProfiles where IsStaff = true order by {0}", field)

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()

        adapter.SelectCommand = New SqlCommand(query, conn)

        Dim myDataTable As New DataTable()

        conn.Open()

        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function



    Function getOnlineStatus(id As String) As String

        Dim q = (From p In db.qryGetLoggedInUsers Where p.userID = id Select p).Count

        If q = 0 Then Return "No" Else Return "Yes"
    End Function

    Function getRoles(id As String) As String
        Dim myline As String

        Dim q = From p In db2.qryUserRoles Where p.UserId = id Select p

        For Each p In q
            'myline = p.Name
            Return myline.Join(",", p.Name).ToString()
        Next

#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Protected Sub btnCancelFilter2_Click(sender As Object, e As EventArgs)
        Response.Redirect("/admin/siteadministration" & "users")
    End Sub

    Private Sub btnUpdateWeather_Click(sender As Object, e As EventArgs) Handles btnUpdateWeather.Click

        'delete all eventCourse records
        db.DeleteWeather()


        Dim i = From a In db.qryGetUpcomingEventLocations Select a
        For Each a In i


            Try
                Dim appId As String = "a77cf9b3936cbf96fecb944778c5718c"
                Dim url As String = String.Format("http://api.openweathermap.org/data/2.5/forecast/daily?q={0}&units=imperial&cnt=3&APPID={1}", a.location, appId)
                Using client As New WebClient()
                    Dim json As String = client.DownloadString(url)

                    Dim weatherInfo As WeatherInfo = (New JavaScriptSerializer()).Deserialize(Of WeatherInfo)(json)
                    Dim lblMain0 As String = weatherInfo.list(0).weather(0).main
                    Dim lblMain1 As String = weatherInfo.list(1).weather(0).main
                    Dim lblMain2 As String = weatherInfo.list(2).weather(0).main

                    Dim imgWeatherIcon0 As String = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(0).weather(0).icon)
                    Dim imgWeatherIcon1 As String = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(1).weather(0).icon)
                    Dim imgWeatherIcon2 As String = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(2).weather(0).icon)

                    Dim lblTempMin0 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(0).temp.min, 1))
                    Dim lblTempMin1 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(1).temp.min, 1))
                    Dim lblTempMin2 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(2).temp.min, 1))

                    Dim lblTempMax0 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(0).temp.max, 1))
                    Dim lblTempMax1 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(1).temp.max, 1))
                    Dim lblTempMax2 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(2).temp.max, 1))


                    Dim q0 As New tblWeatherInfo
                    q0.cityName = a.city
                    q0.stateName = a.state
                    q0.weatherDate = Date.Now()
                    q0.lowTemp = lblTempMin1
                    q0.highTemp = lblTempMax1
                    q0.icon = imgWeatherIcon1
                    q0.condition = lblMain1
                    q0.location = a.location
                    q0.day = getDayofWeek(Date.Now().DayOfWeek)
                    q0.dayNumber = Date.Now().Day

                    db.tblWeatherInfos.InsertOnSubmit(q0)


                    Dim q1 As New tblWeatherInfo
                    q1.cityName = a.city
                    q1.stateName = a.state
                    q1.weatherDate = Date.Now().AddDays(1)
                    q1.lowTemp = lblTempMin0
                    q1.highTemp = lblTempMax0
                    q1.icon = imgWeatherIcon0
                    q1.condition = lblMain0
                    q1.location = a.location
                    q1.day = getDayofWeek(Date.Now().AddDays(1).DayOfWeek)
                    q1.dayNumber = Date.Now().AddDays(1).Day

                    db.tblWeatherInfos.InsertOnSubmit(q1)

                    Dim q2 As New tblWeatherInfo
                    q2.cityName = a.city
                    q2.stateName = a.state
                    q2.weatherDate = Date.Now().AddDays(2)
                    q2.lowTemp = lblTempMin0
                    q2.highTemp = lblTempMax0
                    q2.icon = imgWeatherIcon0
                    q2.condition = lblMain0
                    q2.location = a.location
                    q2.day = getDayofWeek(Date.Now().AddDays(2).DayOfWeek)
                    q2.dayNumber = Date.Now().AddDays(2).Day

                    db.tblWeatherInfos.InsertOnSubmit(q2)

                    db.SubmitChanges()

                End Using
            Catch ex As Exception
                UpdateWeatherResultLabel.Text = ex.Message()
            End Try

        Next

        UpdateWeatherResultLabel.Text = "Import Completed"
    End Sub

    Function getDayofWeek(day As Integer) As String

        Select Case day

            Case 1
                Return "Monday"
            Case 2
                Return "Tuesday"
            Case 3
                Return "Wednesday"
            Case 4
                Return "Thursday"
            Case 5
                Return "Friday"
            Case 6
                Return "Saturday"
            Case 7
                Return "Sunday"
            Case Else
                Return ""
        End Select
    End Function

    Private Sub SiteAdministration_Init(sender As Object, e As EventArgs) Handles Me.Init
        RadPersistenceManager1.StorageProviderKey = CookieName
        RadPersistenceManager1.StorageProvider = New CookieStorageProvider(CookieName)
    End Sub





    Private Sub btnEmail_Click(sender As Object, e As EventArgs) Handles btnEmail.Click
        Response.Redirect("/admin/EmailMessages?messageID=1")
    End Sub

    Private Sub btnConfiguration_Click(sender As Object, e As EventArgs) Handles btnConfiguration.Click

        Response.Redirect("/admin/ClientDetails?ClientID=" & GetCurrentClientID())
    End Sub

    Private Sub btnUsers_Click(sender As Object, e As EventArgs) Handles btnUsers.Click
        Response.Redirect("/admin/viewuserslist")
    End Sub

    Function GetCurrentClientID() As String
        Try
            Dim db As New DataClassesDataContext

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

            Dim result = (From p In db.tblProfiles Where p.userID = currentUser.Id Select p).FirstOrDefault

            Return String.Format("{0}", result.currentClientID)
        Catch ex As Exception

            Return "There was an error"
        End Try


    End Function

    Private Sub Timer1_Tick(sender As Object, e As EventArgs) Handles Timer1.Tick

        'get counts
        CurrentLoginCountLabel.Text = (From p In db.qryGetLoggedInUsers Select p).Count
        TotalLoginCount.Text = (From p In db.qryGetLoggedInUsers_last24hours Select p).Count

        Dim con0 = (From p In db.GetLoggedInUserTotals() Select p).FirstOrDefault

        If con0.Difference = 0 Then
            CurrentLoginIcon.Text = ""
            TotalLoginIcon.Text = ""
        ElseIf con0.Difference > 0 Then
            CurrentLoginIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
            TotalLoginIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            CurrentLoginIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
            TotalLoginIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        Dim total = (From p In db.qryGetLoggedInUsers_last24hours Select p).Count
        Dim visits = (From p In db.qryGetNewVisits_last24hours Select p).Count

        NewVisitPercentLabel.Text = String.Format("{0:0%}", visits / total)

        Dim con = (From p In db.GetNewVisitsTotals() Select p).FirstOrDefault

        If con.Difference = 0 Then
            NewVisitPercentIcon.Text = ""
        ElseIf con.Difference > 0 Then
            NewVisitPercentIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewVisitPercentIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If




        RecapsSubmittedLabel.Text = (From p In db.qryGetRecapCreated_last24hours Select p).Count

        Dim con1 = (From p In db.GetLastHourChangeCount("Recap Completed") Select p).FirstOrDefault

        If con1.Total = 0 Then
            RecapsSubmittedIcon.Text = ""
        ElseIf con1.Total > 0 Then
            RecapsSubmittedIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            RecapsSubmittedIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        ApprovedEventsCountLabel.Text = (From p In db.qryGetApprovedEvents_last24hrs Select p).Count
        Dim con2 = (From p In db.GetLastHourChangeCount("Event Approved") Select p).FirstOrDefault
        If con2.Total = 0 Then
            ApprovedEventIcon.Text = ""
        ElseIf con2.Total > 0 Then
            ApprovedEventIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            ApprovedEventIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If



        'New Events Count
        NewEventsCountLabel.Text = (From p In db.qryGetNewEvents_last24hours Select p).Count

        Dim con3 = (From p In db.GetLastHourChangeCount("Event Created") Select p).FirstOrDefault
        If con3.Total = 0 Then
            NewEventIcon.Text = ""
        ElseIf con3.Total > 0 Then
            NewEventIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewEventIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If

        NewRegistrationsLabel.Text = (From p In db.qryGetRegistrations_last24hrs Select p).Count
        Dim con5 = (From p In db.GetNewRegistrations() Select p).FirstOrDefault
        If con5.Difference = 0 Then
            NewRegistrationsIcon.Text = ""
        ElseIf con5.Difference > 0 Then
            NewRegistrationsIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewRegistrationsIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If



        NewAssignmentsLabel.Text = (From p In db.qryGetAmbassadorAssigned_last24hrs Select p).Count

        Dim con4 = (From p In db.GetLastHourChangeCount("Ambassador Assigned") Select p).FirstOrDefault
        If con4.Total = 0 Then
            NewAssignmentsIcon.Text = ""
        ElseIf con4.Total > 0 Then
            NewAssignmentsIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewAssignmentsIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


    End Sub

#Region "Weather Classes"

    Public Class WeatherInfo
        Public Property city As City
        Public Property list As List(Of List)
    End Class

    Public Class City
        Public Property name As String
        Public Property country As String
    End Class

    Public Class Temp
        Public Property day As Double
        Public Property min As Double
        Public Property max As Double
        Public Property night As Double
    End Class

    Public Class Weather
        Public Property description As String
        Public Property main As String
        Public Property icon As String
    End Class

    Public Class List
        Public Property temp As Temp
        Public Property humidity As Integer
        Public Property weather As List(Of Weather)
    End Class

#End Region

End Class