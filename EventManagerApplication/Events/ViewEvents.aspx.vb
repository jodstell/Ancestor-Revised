Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI
Imports System
Imports System.Web.UI.WebControls


Public Class Events
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime
    Dim userdb As New LMSDataClassesDataContext

    Shared filter As Boolean = False
    Shared numberofrows As Integer
    Private Shared ReadOnly CookieName As String = "EventGridPF"

    Private Sub Events_Init(sender As Object, e As EventArgs) Handles Me.Init
        RadPersistenceManager1.StorageProviderKey = CookieName
        RadPersistenceManager1.StorageProvider = New CookieStorageProvider(CookieName)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load




        'define the css for the tool tips
        btnViewMonth.CssClass = "btn btn-default ui-tooltip"
        btnViewWeek.CssClass = "btn btn-default ui-tooltip"


        Dim mapLayer As MapLayer = GetMapLayer()
        RadMap1.LayersCollection.Clear()
        RadMap1.LayersCollection.Add(mapLayer)

        Try
            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            HiddenUserID.Value = currentUser.Id
        Catch ex As Exception
            MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on ViewEvents", "Could not find user")

        End Try


        'Try
        '    HiddenClientID.Value = Common.GetCurrentClientID()
        'Catch ex As Exception

        '    MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on ViewEvents", "Could not find current client id")

        '    HiddenClientID.Value = "18"
        'End Try


        Dim action = Request.QueryString("action")

        Select Case action
            Case 0
            Case 1
                msgLabel.Text = Common.ShowAlert("success", "The Event was created successfully!")
            Case 2
                msgLabel.Text = Common.ShowAlert("success", "The Event was deleted!")
            Case 3
                msgLabel.Text = Common.ShowAlertNoClose("warning", "We did not find the event that you requested.  Maybe it was deleted.")
        End Select


        If Not Page.IsPostBack Then

            ' EventDataGrid.MasterTableView.GetColumn("teamName").Display = False
            EventDataGrid.MasterTableView.GetColumn("importFileID").Display = False

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 30 - dtNow.DayOfWeek, dtNow) 'was 13

            'Displays first day of the week
            lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")

            FromDatePicker.SelectedDate = weekStartDate
            ToDatePicker.SelectedDate = weekEndDate

            PopulateCountLabels()

        End If


        If Not Page.IsPostBack Then

            Try

                If Request.Cookies(CookieName) IsNot Nothing Then


                    If Request.QueryString("LoadState") IsNot Nothing Then

                        Dim state = Request.QueryString("LoadState")

                        If state = "Yes" Then
                            If Not Page.IsPostBack Then

                                '
                                Try
                                    RadPersistenceManager1.LoadState()

                                    'set the date range from session state
                                    FromDatePicker.SelectedDate = Session("FromDate")
                                    ToDatePicker.SelectedDate = Session("ToDate")

                                    PopulateCountLabels()
                                    EventDataGrid.Rebind()
                                Catch ex As Exception

                                    dtNow = Date.Now()

                                    nowdayofweek = dtNow.DayOfWeek
                                    weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
                                    weekEndDate = DateAdd("d", 30 - dtNow.DayOfWeek, dtNow) 'was 13

                                    'Displays first day of the week
                                    lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")

                                    FromDatePicker.SelectedDate = weekStartDate
                                    ToDatePicker.SelectedDate = weekEndDate

                                    PopulateCountLabels()

                                End Try

                            End If
                            ' End If
                        End If

                    End If

                Else
                    'there are no cookies so we need to just load the labels

                    PopulateCountLabels()


                End If
            Catch ex As Exception
                MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on ViewEvents", ex.Message)

            End Try

        End If

    End Sub

    Function getImage(status As String) As String
        Select Case status
            Case "Booked"
                Return "/images/StatusIcons/Green.png"
            Case "Requested"
                Return "/images/StatusIcons/Blue.png"
                Exit Select
            Case "Scheduled"
                Return "/images/StatusIcons/Yellow.png"
                Exit Select
            Case "Cancelled"
                Return "/images/StatusIcons/Red.png"
                Exit Select
            Case "Cancelled Last Minute"
                Return "/images/StatusIcons/Red.png"
                Exit Select
            Case "Toplined"
                Return "/images/StatusIcons/Purple.png"
                Exit Select
            Case "Approved"
                Return "/images/StatusIcons/Light Blue.png"
                Exit Select
            Case Else
                Exit Select

        End Select

    End Function


    Private Sub RadScheduler1_AppointmentDataBound(sender As Object, e As SchedulerEventArgs) Handles RadScheduler1.AppointmentDataBound
        If e.Appointment.Resources.GetResourceByType("StatusName") <> Nothing Then
            Select Case e.Appointment.Resources.GetResourceByType("StatusName").Text
                Case "Requested"
                    e.Appointment.CssClass = "rsRequested"
                    Exit Select
                Case "Scheduled"
                    e.Appointment.CssClass = "rsScheduled"
                    Exit Select
                Case "Booked"
                    e.Appointment.CssClass = "rsBooked"
                    Exit Select
                Case "Cancelled"
                    e.Appointment.CssClass = "rsCancelled"
                    Exit Select
                Case "Toplined"
                    e.Appointment.CssClass = "rsToplined"
                    Exit Select
                Case "Approved"
                    e.Appointment.CssClass = "rsApproved"
                    Exit Select
                Case Else
                    Exit Select
            End Select
        End If

        e.Appointment.ToolTip = e.Appointment.Description


    End Sub

    Protected Sub OnClientAppointmentClick(sender As Object, e As SchedulerEventArgs)
        Dim StrID As String = e.Appointment.ID.ToString()
    End Sub

    'Sub bindEvent()
    '    Dim q = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

    '    'EventNameLabel.Text = q.eventTitle
    '    'EventDateLabel.Text = String.Format("{0: D}", q.eventDate)
    '    'EventTypeLabel.Text = getEventTypeName(q.eventTypeID)
    '    'SupplierLabel.Text = getSupplierName(q.supplierID)
    '    'MarketLabel.Text = getMarketName(q.marketID)
    'End Sub

    'Function getEventTypeName(ByVal id As Integer) As String
    '    Return (From p In db.tblEventTypes Where p.eventTypeID = id Select p.eventTypeName).FirstOrDefault
    'End Function

    'Function getMarketName(ByVal id As Integer) As String
    '    Return (From p In db.tblMarkets Where p.marketID = id Select p.marketName).FirstOrDefault
    'End Function

    'Function getSupplierName(ByVal id As Integer) As String
    '    Return (From p In db.tblSuppliers Where p.supplierID = id Select p.supplierName).FirstOrDefault
    'End Function

    Private Function GetMapLayer() As MapLayer

        Dim provider As String = "Bing"
        Dim providerName As String = "Bing"

        Dim mapLayer As MapLayer = New MapLayer

        mapLayer.Type = Map.LayerType.Bing
        mapLayer.Key = ConfigurationManager.AppSettings.Get("BingMapsAPIKey").ToString()

        Return mapLayer

    End Function
    Private Sub EventDataGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles EventDataGrid.ItemCommand

        Select Case e.CommandName
            Case "ViewEvent"
                RadPersistenceManager1.SaveState()
                Session.Add("FromDate", FromDatePicker.SelectedDate)
                Session.Add("ToDate", ToDatePicker.SelectedDate)

                Response.Redirect("/Events/EventDetails?ID=" & e.CommandArgument)


            Case "ClearFilters"
                For Each column As GridColumn In EventDataGrid.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                EventDataGrid.MasterTableView.FilterExpression = [String].Empty
                EventDataGrid.MasterTableView.Rebind()

            Case "ResetGrid"
                Response.Redirect("/Events/ViewEvents")

            Case "ExportToExcel"

                EventDataGrid.ExportSettings.ExportOnlyData = False
                EventDataGrid.ExportSettings.IgnorePaging = True
                EventDataGrid.ExportSettings.OpenInNewWindow = True
                EventDataGrid.ExportSettings.UseItemStyles = False
                EventDataGrid.ExportSettings.FileName = "Events"

                EventDataGrid.MasterTableView.GetColumn("Stage").Visible = False
                EventDataGrid.MasterTableView.GetColumn("eventID1").Visible = True
                EventDataGrid.MasterTableView.GetColumn("eventID").Visible = False
                EventDataGrid.MasterTableView.GetColumn("statusName").Visible = False
                EventDataGrid.MasterTableView.GetColumn("status").Visible = True
                EventDataGrid.MasterTableView.GetColumn("accountName").Visible = False
                EventDataGrid.MasterTableView.GetColumn("accountName1").Visible = True
                EventDataGrid.MasterTableView.GetColumn("address").Visible = True
                EventDataGrid.MasterTableView.GetColumn("city").Visible = True
                EventDataGrid.MasterTableView.GetColumn("state").Visible = True

                EventDataGrid.MasterTableView.GetColumn("marketName").HeaderText = "Market"

                EventDataGrid.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

                EventDataGrid.MasterTableView.ExportToExcel()

            Case "AddNewEvent"

                Response.Redirect("/Events/AddNewEvent.aspx")
        End Select

    End Sub

    Function getLocationName(id As String) As String
        Return (From p In db.tblAccounts Where p.Vpid = id Select p.accountName).FirstOrDefault
    End Function

    Function getLocationAddress(id As String) As String
        Dim q = (From p In db.tblAccounts Where p.Vpid = id Select p).FirstOrDefault

        Return String.Format("{0}<br>{1}, {2}", q.streetAddress1, q.city, q.state)

    End Function

    Function getVpid(id As String) As String
        Return (From p In db.tblAccounts Where p.Vpid = id Select p.accountID).FirstOrDefault
    End Function

    Private Sub Events_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        For Each col As GridColumn In EventDataGrid.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next

    End Sub

    Function getTrainingResult(eventID As String, userID As String) As String

        'get the brands
        Dim _brandID = From a In db.getBrandTrainingGroupByEventIDs Where a.eventID = eventID Select a


        For Each a In _brandID

            Dim _curriculum = (From l In userdb.Curriculums Where l.CurriculumGroupID = a.courseGroupID Select l).Distinct

            For Each list In _curriculum

                Dim test = (From u In userdb.CurriculumLists Where u.CurriculumID = list.CurriculumID And u.ContentType = 7 Select u).Distinct

                For Each u In test
                    Dim type = (From y In userdb.CurriculumLists Where y.CurriculumID = list.CurriculumID Select y.ContentType).FirstOrDefault
                    Dim _testID = (From b In userdb.CurriculumLists Where b.CurriculumID = list.CurriculumID Select b.TestID).FirstOrDefault

                    Dim _result = (From t In userdb.baretc_TestResults Where t.UserName = userID And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Result).FirstOrDefault
                    Dim _score = (From t In userdb.baretc_TestResults Where t.UserName = userID And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Score).FirstOrDefault


                    Dim testresult As String
                    Dim resultlabel As String
                    Dim scoreLabel As String

                    Select Case _result
                        Case "Passed"
                            testresult = "success"
                            resultlabel = "Passed"
                            scoreLabel = String.Format("{0}%", _score)
                        Case "Failed"
                            testresult = "danger"
                            resultlabel = "Failed"
                            scoreLabel = String.Format("{0}%", _score)
                        Case Else
                            testresult = "warning"
                            resultlabel = "Not Started"
                            scoreLabel = ""
                    End Select



                    Return String.Format("<h4><span class='label label-{0}'>{1} {2}</span></h4>", testresult, resultlabel, scoreLabel)

                Next

            Next

        Next 'end of brands



    End Function

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click

        btnViewMonth.CssClass = "btn btn-default ui-tooltip"
        btnViewWeek.CssClass = "btn btn-default ui-tooltip"

        Dim _startDate As Date = FromDatePicker.SelectedDate
        Dim _endDate As Date = ToDatePicker.SelectedDate

        Session.Add("FromDate", FromDatePicker.SelectedDate)
        Session.Add("ToDate", ToDatePicker.SelectedDate)

        lblWeek.Text = _startDate.ToString("dddd, MMMM dd") & " - " & _endDate.ToString("dddd, MMMM dd")
        EventDataGrid.Rebind()

        PopulateCountLabels()



    End Sub

    Sub PopulateCountLabels()
        Try

            Dim t = (From p In db.GetEventStatusTotalsByUserID(Context.User.Identity.GetUserId(), FromDatePicker.SelectedDate, ToDatePicker.SelectedDate) Select p).FirstOrDefault

            TotalCountLabel.Text = t.Total
            ApprovedCountLabel.Text = t.Approved
            BookedCountLabel.Text = t.Booked
            CancelledCountLabel.Text = t.Cancelled
            ScheduledCountLabel.Text = t.Scheduled
            ToplinedCountLabel.Text = t.Toplined

            Dim q = From p In db.tblRequestedEvents Where p.clientID = Common.GetCurrentClientID() And p.deleted Is Nothing Select p
            RequestedCountLabel.Text = q.Count

        Catch ex As Exception

            MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on ViewEvents", "There was a problem populating the totals")
        End Try



    End Sub



    Private Sub btnViewMonth_Click(sender As Object, e As EventArgs) Handles btnViewMonth.Click
        btnViewMonth.CssClass = "btn btn-success ui-tooltip"
        btnViewWeek.CssClass = "btn btn-default ui-tooltip"
        Dim dtFirst As New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
        Dim endDate As DateTime = dtFirst.AddMonths(1).AddDays(-1)

        'Displays first day of the week
        lblWeek.Text = dtFirst.ToString("dddd, MMMM dd") & " - " & endDate.ToString("dddd, MMMM dd")

        FromDatePicker.SelectedDate = dtFirst
        ToDatePicker.SelectedDate = endDate

        EventDataGrid.Rebind()
        PopulateCountLabels()

    End Sub

    Private Sub btnViewWeek_Click(sender As Object, e As EventArgs) Handles btnViewWeek.Click
        btnViewWeek.CssClass = "btn btn-success ui-tooltip"
        btnViewMonth.CssClass = "btn btn-default ui-tooltip"
        dtNow = Date.Now()

        nowdayofweek = dtNow.DayOfWeek
        weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
        weekEndDate = DateAdd("d", 6 - dtNow.DayOfWeek, dtNow)

        'Displays first day of the week
        lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")

        FromDatePicker.SelectedDate = weekStartDate
        ToDatePicker.SelectedDate = weekEndDate

        EventDataGrid.Rebind()
        PopulateCountLabels()

    End Sub

    Protected Sub EventDataGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryViewEvents where eventDate >= '{1}' and eventDate <= '{2}' and clientid = {3} order by {0}", field, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, Common.GetCurrentClientID())

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


    Protected Sub AssignmentsGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetAssignmentDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Public Function GetAssignmentDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryViewEvents where eventDate >= '{1}' and eventDate <= '{2}' and clientid = {3} order by {0}", field, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, Common.GetCurrentClientID())

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

    Private Sub btnHideMap_Click(sender As Object, e As EventArgs) Handles btnHideMap.Click
        MapPanel.Visible = False

        btnCalendar.CssClass = "btn btn-default ui-tooltip"
        btnMap.CssClass = "btn btn-default ui-tooltip"
    End Sub

    Private Sub btnCalendar_Click(sender As Object, e As EventArgs) Handles btnCalendar.Click

        RadScheduler1.DataSourceID = "getEventsByUserID"

        CalendarPanel.Visible = True

        If MapPanel.Visible = True Then
            MapPanel.Visible = False
        End If

        btnCalendar.CssClass = "btn btn-success ui-tooltip"
        btnMap.CssClass = "btn btn-default ui-tooltip"
    End Sub

    Private Sub btnMap_Click(sender As Object, e As EventArgs) Handles btnMap.Click

        RadMap1.DataSourceID = "getEventsByUserID"

        MapPanel.Visible = True

        If CalendarPanel.Visible = True Then
            CalendarPanel.Visible = False
        End If

        btnMap.CssClass = "btn btn-success ui-tooltip"
        btnCalendar.CssClass = "btn btn-default ui-tooltip"
    End Sub

    Private Sub btnHideCalendar_Click(sender As Object, e As EventArgs) Handles btnHideCalendar.Click
        CalendarPanel.Visible = False

        btnCalendar.CssClass = "btn btn-default ui-tooltip"
        btnMap.CssClass = "btn btn-default ui-tooltip"
    End Sub



    Private Sub EventDataGrid_ItemCreated(sender As Object, e As GridItemEventArgs) Handles EventDataGrid.ItemCreated
        If TypeOf e.Item Is GridHeaderItem Then
            Dim headerItem As GridHeaderItem = TryCast(e.Item, GridHeaderItem)
            For Each column As GridColumn In EventDataGrid.MasterTableView.RenderColumns
                Dim isFiltered As Boolean = Not String.IsNullOrEmpty(column.EvaluateFilterExpression())
                If isFiltered Then
                    Dim button As New ImageButton()
                    button.AlternateText = "Clear filters"
                    button.ImageUrl = "~/filter.png"
                    button.ImageAlign = ImageAlign.Right
                    button.OnClientClick = "clearColumnFilter('" + column.UniqueName + "'); return false;"
                    button.Enabled = False

                    headerItem(column.UniqueName).Controls.Add(button)
                End If
            Next
        End If



    End Sub

    'Private Sub Events_Error(sender As Object, e As EventArgs) Handles Me.[Error]
    '    'reload the page if there is an error
    '    'Response.Redirect("/Events/ViewEvents")

    '    Dim PageException As String = Server.GetLastError().ToString()
    '    Dim strBuild As New StringBuilder()
    '    strBuild.Append("Exception!")
    '    strBuild.Append(PageException)

    '    Dim manager = New UserManager()
    '    Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
    '    'Session.Add("CurrentUserID", currentUser.Id)


    '    strBuild.Append("UserID: " & currentUser.Id)

    '    'Response.Write(strBuild.ToString())

    '    MailHelper.SendMailMessage("no-reply@gigengyn.com", "There was an error on ViewEvents", strBuild.ToString())
    '    Context.ClearError()

    '    Response.Redirect("/Events/ViewEvents")

    'End Sub

    'Private Sub EventWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.CancelButtonClick
    '    AddNewEventPanel.Visible = False
    '    DatePanel.Visible = True
    '    GridPanel.Visible = True
    '    CalendarPanel.Visible = False
    '    MapPanel.Visible = False
    '    BoxesPanel.Visible = True
    'End Sub

    'Private Sub EventWizard_NextButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.NextButtonClick
    '    Response.Redirect("/Events/NewEvent?supplierID=" & supplierIDComboBox.SelectedValue)
    'End Sub

    Private Sub btnViewAssignments_Click(sender As Object, e As EventArgs) Handles btnViewAssignments.Click

        ' AssignmentsGrid.DataSourceID = "getAssignments"
        ' AssignmentsGrid.DataBind()


        ' AssignmentsPanel.Visible = True
        'AddNewEventPanel.Visible = False
        DatePanel.Visible = True
        GridPanel.Visible = False
        CalendarPanel.Visible = False
        MapPanel.Visible = False
        BoxesPanel.Visible = True

        btnViewEvents.Visible = True
        btnViewAssignments.Visible = False

    End Sub

    Private Sub btnViewEvents_Click(sender As Object, e As EventArgs) Handles btnViewEvents.Click
        ' AssignmentsPanel.Visible = False
        'AddNewEventPanel.Visible = False
        DatePanel.Visible = True
        GridPanel.Visible = True
        CalendarPanel.Visible = False
        MapPanel.Visible = False
        BoxesPanel.Visible = True

        btnViewEvents.Visible = False
        btnViewAssignments.Visible = True
    End Sub

    Private Sub EventDataGrid_GridExporting(sender As Object, e As GridExportingArgs) Handles EventDataGrid.GridExporting

    End Sub

    Private Sub EventDataGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles EventDataGrid.NeedDataSource
        TryCast(sender, RadGrid).DataSource = GetDataTable()
    End Sub

    Public Function GetDataTable() As DataTable
        ' Dim query As String = "SELECT eventID, supplierName, eventDate, marketName, eventTypeName, statusName FROM qryViewEvents"

        Dim query As String = "getEvents_ByUserID"

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()
        adapter.SelectCommand = New SqlCommand(query, conn)

        adapter.SelectCommand.CommandType = CommandType.StoredProcedure

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@UserID", SqlDbType.NVarChar))
        adapter.SelectCommand.Parameters("@UserID").Value = Context.User.Identity.GetUserId()

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@fromDate", SqlDbType.Date))
        adapter.SelectCommand.Parameters("@fromDate").Value = FromDatePicker.SelectedDate

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@toDate", SqlDbType.Date))
        adapter.SelectCommand.Parameters("@toDate").Value = ToDatePicker.SelectedDate


        Dim myDataTable As New DataTable()

        conn.Open()
        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function

    'Private Sub btnFilterScheduledEvents_Click(sender As Object, e As EventArgs) Handles btnFilterScheduledEvents.Click


    '    EventDataGrid.MasterTableView.FilterExpression = "([statusName] Equals '%Scheduled%')"
    '    Dim column As GridColumn = EventDataGrid.MasterTableView.GetColumnSafe("statusName")
    '    column.CurrentFilterFunction = GridKnownFunction.EqualTo
    '    column.CurrentFilterValue = "Scheduled"
    '    EventDataGrid.Rebind()

    'End Sub


    '  Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

    '    'Dim str1 As String = EventDataGrid.MasterTableView.Columns.FindByUniqueName("statusName").CurrentFilterFunction.ToString()

    '    Dim statusfilter As String = EventDataGrid.MasterTableView.Columns.FindByUniqueName("statusName").CurrentFilterValue
    '    Dim marketfilter As String = EventDataGrid.MasterTableView.Columns.FindByUniqueName("statusName").CurrentFilterValue
    '    Dim eventtypefilter As String = EventDataGrid.MasterTableView.Columns.FindByUniqueName("statusName").CurrentFilterValue
    '    Dim locationfilter As String = EventDataGrid.MasterTableView.Columns.FindByUniqueName("statusName").CurrentFilterValue



    'If (Not Page.IsPostBack) Then
    '    EventDataGrid.MasterTableView.FilterExpression = "([statusName] Equals '%Toplined%') "
    '    Dim column As GridColumn = EventDataGrid.MasterTableView.GetColumnSafe("statusName")
    '    column.CurrentFilterFunction = GridKnownFunction.Contains
    '    column.CurrentFilterValue = "Toplined"
    '    EventDataGrid.MasterTableView.Rebind()
    'End If



    '  End Sub
End Class