Imports System.Data.SqlClient
Imports System.IO
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI
Imports Telerik.Windows.Documents.Spreadsheet.FormatProviders
Imports Telerik.Windows.Documents.Spreadsheet.FormatProviders.OpenXml.Xlsx
Imports Telerik.Windows.Documents.Spreadsheet.FormatProviders.Pdf
Imports Telerik.Windows.Documents.Spreadsheet.FormatProviders.TextBased.Csv
Imports Telerik.Windows.Documents.Spreadsheet.FormatProviders.TextBased.Txt
Imports Telerik.Windows.Documents.Spreadsheet.Model


Public Class ViewAssignments
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime
    Dim userdb As New LMSDataClassesDataContext

    Private Shared ReadOnly IndexColumnEventID As Integer = 0
    Private Shared ReadOnly IndexColumnAmbassadorName As Integer = 1
    Private Shared ReadOnly IndexColumnAmbassadorEmail As Integer = 2
    Private Shared ReadOnly IndexColumnAmbassadorPhone As Integer = 3
    Private Shared ReadOnly IndexColumnSupplierName As Integer = 4
    Private Shared ReadOnly IndexColumnBrands As Integer = 5
    Private Shared ReadOnly IndexColumnEventDate As Integer = 6
    Private Shared ReadOnly IndexColumnStartTime As Integer = 7
    Private Shared ReadOnly IndexColumnEndTime As Integer = 8
    Private Shared ReadOnly IndexColumnTraining As Integer = 9
    Private Shared ReadOnly IndexColumnCheckInTime As Integer = 10
    Private Shared ReadOnly IndexColumnPOS As Integer = 11
    Private Shared ReadOnly IndexColumnAccountName As Integer = 12
    Private Shared ReadOnly IndexColumnAccountAddress As Integer = 13
    Private Shared ReadOnly IndexColumnAccountCity As Integer = 14
    Private Shared ReadOnly IndexColumnAccountState As Integer = 15
    Private Shared ReadOnly IndexColumnStatus As Integer = 16

    Private Shared ReadOnly IndexRowItemStart As Integer = 1

    Private Shared ReadOnly EnUSCultureAccountFormatString As String = "_($ #,##0.00_);_($ (#,##0.00);_(@_)"

    Shared filter As Boolean = False
    Shared numberofrows As Integer
    Private Shared ReadOnly CookieName As String = "EventGridPF"

    Private Sub Events_Init(sender As Object, e As EventArgs) Handles Me.Init
        RadPersistenceManager1.StorageProviderKey = CookieName
        RadPersistenceManager1.StorageProvider = New CookieStorageProvider(CookieName)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'demos.telerik.com/aspnet-ajax/spreadprocessing/generate-documents/defaultvb.aspx


        btnViewMonth.CssClass = "btn btn-default ui-tooltip"
        btnViewWeek.CssClass = "btn btn-default ui-tooltip"

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        'Session.Add("CurrentUserID", currentUser.Id)

        HiddenUserID.Value = currentUser.Id

        Dim action = Request.QueryString("action")

        Select Case action
            Case 0
            Case 1
                msgLabel.Text = Common.ShowAlert("success", "The Event was created successfully!")
            Case 2
                msgLabel.Text = Common.ShowAlert("success", "The Event was deleted!")
        End Select


        '  Dim Label11 As Label = DirectCast(Master.FindControl("ClientIDLabel"), Label)

        If Not Page.IsPostBack Then

            'Enter any Date in MDY format

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 13 - dtNow.DayOfWeek, dtNow)

            'Displays first day of the week
            lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")

            FromDatePicker.SelectedDate = weekStartDate
            ToDatePicker.SelectedDate = weekEndDate

            PopulateCountLabels()

        End If


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


                            AssignmentsGrid.Rebind()
                        Catch ex As Exception

                        End Try

                    End If
                    ' End If
                End If

            End If

        Else

            PopulateCountLabels()


        End If

        '  repairBrandRecapQuestions()



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
                Return ""
                Exit Select

        End Select

    End Function


    Protected Sub OnClientAppointmentClick(sender As Object, e As SchedulerEventArgs)
        Dim StrID As String = e.Appointment.ID.ToString()
    End Sub

    Sub bindEvent()
        Dim q = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault


    End Sub

    Function getEventTypeName(ByVal id As Integer) As String
        Return (From p In db.tblEventTypes Where p.eventTypeID = id Select p.eventTypeName).FirstOrDefault
    End Function

    Function getMarketName(ByVal id As Integer) As String
        Return (From p In db.tblMarkets Where p.marketID = id Select p.marketName).FirstOrDefault
    End Function

    Function getSupplierName(ByVal id As Integer) As String
        Return (From p In db.tblSuppliers Where p.supplierID = id Select p.supplierName).FirstOrDefault
    End Function

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

        For Each col As GridColumn In AssignmentsGrid.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next

    End Sub

    Function getTrainingResult(eventID As String, userID As String) As String

        Dim _userName = (From p In db.tblProfiles Where p.userID = userID Select p.userName).FirstOrDefault

        'get the brands
        Dim _brandID = From a In db.getBrandTrainingGroupByEventIDs Where a.eventID = eventID Select a

        Dim _CurriculumCount As Integer = 0
        Dim _CurriculumCompletedCount As Integer = 0

        For Each a In _brandID

            Try

                Dim _courseID = (From p In userdb.CurriculumGroups Where p.CurriculumGroupID = a.courseGroupID Select p.CourseID).FirstOrDefault
                Dim thisCourse = (From p In userdb.Courses Where p.CourseID = _courseID Select p.Enabled).FirstOrDefault

                If thisCourse = True Then
                    _CurriculumCount = _CurriculumCount + (From p In userdb.BrandGroupTrainingResultByUserID(userID, a.courseGroupID) Select p.CurriculumCount).FirstOrDefault
                End If

            Catch ex As Exception
                _CurriculumCount = _CurriculumCount + 0
            End Try

            Try
                Dim _courseID = (From p In userdb.CurriculumGroups Where p.CurriculumGroupID = a.courseGroupID Select p.CourseID).FirstOrDefault
                Dim thisCourse = (From p In userdb.Courses Where p.CourseID = _courseID Select p.Enabled).FirstOrDefault

                If thisCourse = True Then
                    _CurriculumCompletedCount = _CurriculumCompletedCount + (From p In userdb.BrandGroupTrainingResultByUserID(userID, a.courseGroupID) Select p.CurriculumCompletedCount).FirstOrDefault
                End If

            Catch ex As Exception
                _CurriculumCompletedCount = _CurriculumCompletedCount + 0
            End Try

        Next 'end of brands

        Dim percent As Double = (CDbl(_CurriculumCompletedCount) / _CurriculumCount)

        If percent.ToString = "NaN" Then
            Return "n/a"
        Else
            Return String.Format("{0:p}", percent)
        End If

    End Function

    'Function getTrainingResult(eventID As String, userID As String) As String

    '    'get the brands
    '    Dim _brandID = From a In db.getBrandTrainingGroupByEventIDs Where a.eventID = eventID Select a


    '    For Each a In _brandID

    '        Dim _curriculum = (From l In userdb.Curriculums Where l.CurriculumGroupID = a.courseGroupID Select l).Distinct

    '        For Each list In _curriculum

    '            Dim test = (From u In userdb.CurriculumLists Where u.CurriculumID = list.CurriculumID And u.ContentType = 7 Select u).Distinct

    '            For Each u In test
    '                Dim type = (From y In userdb.CurriculumLists Where y.CurriculumID = list.CurriculumID Select y.ContentType).FirstOrDefault
    '                Dim _testID = (From b In userdb.CurriculumLists Where b.CurriculumID = list.CurriculumID Select b.TestID).FirstOrDefault

    '                Dim _result = (From t In userdb.baretc_TestResults Where t.UserName = userID And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Result).FirstOrDefault
    '                Dim _score = (From t In userdb.baretc_TestResults Where t.UserName = userID And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Score).FirstOrDefault


    '                Dim testresult As String
    '                Dim resultlabel As String
    '                Dim scoreLabel As String

    '                Select Case _result
    '                    Case "Passed"
    '                        testresult = "success"
    '                        resultlabel = "Passed"
    '                        scoreLabel = String.Format("{0}%", _score)
    '                    Case "Failed"
    '                        testresult = "danger"
    '                        resultlabel = "Failed"
    '                        scoreLabel = String.Format("{0}%", _score)
    '                    Case Else
    '                        testresult = "warning"
    '                        resultlabel = "Not Started"
    '                        scoreLabel = ""
    '                End Select


    '                Return String.Format("{0} {1}", resultlabel, scoreLabel)


    '            Next

    '        Next

    '    Next 'end of brands



    'End Function



    'Function getTrainingResultNostyle(eventID As String, userID As String) As String

    '    'get the brands
    '    Dim _brandID = From a In db.getBrandTrainingGroupByEventIDs Where a.eventID = eventID Select a


    '    For Each a In _brandID

    '        Dim _curriculum = (From l In userdb.Curriculums Where l.CurriculumGroupID = a.courseGroupID Select l).Distinct

    '        For Each list In _curriculum

    '            Dim test = (From u In userdb.CurriculumLists Where u.CurriculumID = list.CurriculumID And u.ContentType = 7 Select u).Distinct

    '            For Each u In test
    '                Dim type = (From y In userdb.CurriculumLists Where y.CurriculumID = list.CurriculumID Select y.ContentType).FirstOrDefault
    '                Dim _testID = (From b In userdb.CurriculumLists Where b.CurriculumID = list.CurriculumID Select b.TestID).FirstOrDefault

    '                Dim _result = (From t In userdb.baretc_TestResults Where t.UserName = userID And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Result).FirstOrDefault
    '                Dim _score = (From t In userdb.baretc_TestResults Where t.UserName = userID And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Score).FirstOrDefault


    '                'Dim testresult As String
    '                Dim resultlabel As String
    '                Dim scoreLabel As String

    '                Select Case _result
    '                    Case "Passed"
    '                        'testresult = "success"
    '                        resultlabel = "Passed"
    '                        scoreLabel = String.Format("{0}%", _score)
    '                    Case "Failed"
    '                        'testresult = "danger"
    '                        resultlabel = "Failed"
    '                        scoreLabel = String.Format("{0}%", _score)
    '                    Case Else
    '                        'testresult = "warning"
    '                        resultlabel = "Not Started"
    '                        scoreLabel = ""
    '                End Select

    '                Return String.Format("{0} {1}", resultlabel, scoreLabel)



    '            Next

    '        Next

    '    Next 'end of brands



    'End Function

    Function getTracking(ByVal eventID As String) As String

        Try
            Dim tracking As String = (From p In db.tblPosKits Where p.eventID = eventID Select p.trackingNumber).FirstOrDefault

            Dim vendor As String = (From p In db.tblPosKits Where p.eventID = eventID Select p.shippingVendorID).FirstOrDefault

            Dim trackingString As String

            If tracking = "" Then
                'do nothing
                trackingString = ""
            Else

                'get the shipping vendor

                Select Case vendor
                    Case "1"
                        'FedEx
                        Return String.Format("http://www.fedex.com/Tracking?language=english&cntry_code=us&tracknumbers={0}", tracking)

                    Case "2"
                        'UPS
                        Return String.Format("http://wwwapps.ups.com/WebTracking/track?track=yes&trackNums={0}", tracking)


                    Case "3"
                        Return ""   'None

                    Case "4"
                        Return "" 'Other


                End Select


            End If
        Catch ex As Exception
            Return ""
        End Try


    End Function

    'Private Sub EventDataGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles EventDataGrid.NeedDataSource

    '    If True Then
    '        ' Set datasource here…

    '        If Not IsPostBack Then
    '            ' Set initial filter on [RadGrid]
    '            Me.EventDataGrid.MasterTableView.FilterExpression = String.Format("([eventDate] = '{0}')", DateTime.Today)

    '            ' Set current filter function and value on [Date]
    '            Dim column As GridColumn = Me.EventDataGrid.MasterTableView.GetColumnSafe("eventDate")
    '            column.CurrentFilterFunction = GridKnownFunction.EqualTo
    '            column.CurrentFilterValue = DateTime.Today.ToString()
    '        End If
    '    End If

    'End Sub

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click

        btnViewMonth.CssClass = "btn btn-default ui-tooltip"
        btnViewWeek.CssClass = "btn btn-default ui-tooltip"

        Dim _startDate As Date = FromDatePicker.SelectedDate
        Dim _endDate As Date = ToDatePicker.SelectedDate

        Session.Add("FromDate", FromDatePicker.SelectedDate)
        Session.Add("ToDate", ToDatePicker.SelectedDate)

        lblWeek.Text = _startDate.ToString("dddd, MMMM dd") & " - " & _endDate.ToString("dddd, MMMM dd")
        AssignmentsGrid.Rebind()

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
            MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on ViewAssignments", "There was a problem populating the totals")
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

        AssignmentsGrid.Rebind()
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

        AssignmentsGrid.Rebind()
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

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryViewAssignments where eventDate >= '{1}' and eventDate <= '{2}' and clientid = {3} order by {0}", field, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, Session("CurrentClientID"))

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

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryViewEvents where eventDate >= '{1}' and eventDate <= '{2}' and clientid = {3} order by {0}", field, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, Session("CurrentClientID"))

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

    Private Sub btnExportExcel_Click(sender As Object, e As EventArgs) Handles btnExportExcel.Click

        Dim formatProvider As IWorkbookFormatProvider = GetFormatProvider(".xlsx")
        If formatProvider Is Nothing Then
            Return
        End If

        Dim workbook As Workbook = Me.CreateWorkbook()
        Dim renderedBytes As Byte() = Nothing

        Using ms As New MemoryStream()
            formatProvider.Export(workbook, ms)
            renderedBytes = ms.ToArray()
        End Using

        Response.ClearHeaders()
        Response.ClearContent()
        Response.AppendHeader("content-disposition", "attachment; filename=ExportedFile" + ".xlsx")
        Response.ContentType = GetMimeType(".xlsx")
        Response.BinaryWrite(renderedBytes)
        Response.[End]()
    End Sub

    Private Sub AssignmentsGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles AssignmentsGrid.ItemCommand

        Select Case e.CommandName
            Case "ResetGrid"

            Case "ClearFilters"
                For Each column As GridColumn In AssignmentsGrid.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                AssignmentsGrid.MasterTableView.FilterExpression = [String].Empty
                AssignmentsGrid.MasterTableView.Rebind()

            Case "ExportToExcel"

                AssignmentsGrid.ExportSettings.ExportOnlyData = True
                AssignmentsGrid.ExportSettings.IgnorePaging = True
                AssignmentsGrid.ExportSettings.OpenInNewWindow = True
                AssignmentsGrid.ExportSettings.UseItemStyles = False
                AssignmentsGrid.ExportSettings.FileName = "Assignments"

                AssignmentsGrid.MasterTableView.GetColumn("eventID").Visible = False
                AssignmentsGrid.MasterTableView.GetColumn("eventIDexcel").Visible = True
                AssignmentsGrid.MasterTableView.GetColumn("AmbassadorName").Visible = False
                AssignmentsGrid.MasterTableView.GetColumn("AmbassadorNameExcel").Visible = True
                AssignmentsGrid.MasterTableView.GetColumn("AmbassadorEmailExcel").Visible = True
                AssignmentsGrid.MasterTableView.GetColumn("PhoneExcel").Visible = True
                'AssignmentsGrid.MasterTableView.GetColumn("Training").Visible = False
                'AssignmentsGrid.MasterTableView.GetColumn("TrainingExcel").Visible = True
                AssignmentsGrid.MasterTableView.GetColumn("PosStatus").Visible = False
                AssignmentsGrid.MasterTableView.GetColumn("PosStatusExcel").Visible = True
                AssignmentsGrid.MasterTableView.GetColumn("accountName").Visible = False
                AssignmentsGrid.MasterTableView.GetColumn("accountName1").Visible = True
                AssignmentsGrid.MasterTableView.GetColumn("address").Visible = True
                AssignmentsGrid.MasterTableView.GetColumn("city").Visible = True
                AssignmentsGrid.MasterTableView.GetColumn("state").Visible = True

                'EventDataGrid.MasterTableView.GetColumn("marketName").HeaderText = "Market"

                AssignmentsGrid.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

                AssignmentsGrid.MasterTableView.ExportToExcel()



        End Select
    End Sub



    Private Sub AssignmentsGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles AssignmentsGrid.NeedDataSource

        TryCast(sender, RadGrid).DataSource = GetDataTable()

    End Sub

    Public Function GetDataTable() As DataTable

        Dim query As String = "getAssignments_ByUserID"

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


#Region "Export to Excel"

    'populate the list
    Private ReadOnly Property Assignments() As List(Of AssignmentList)
        Get
            Using db As New DataClassesDataContext

                Dim list = db.getAssignments_ByUserID(Context.User.Identity.GetUserId(), FromDatePicker.SelectedDate, ToDatePicker.SelectedDate).[Select](Function(p) New AssignmentList() With {
                .EventID = p.eventID,
                .AmbassadorName = p.AmbassadorName,
                .AmbassadorEmail = p.EmailAddress,
                .AmbassadorPhone = p.Phone,
                .SupplierName = p.supplierName,
                .Brands = p.brands,
                .EventDate = p.shortEventDate,
                .StartTime = p.shortStartTime,
                .EndTime = p.shortEndTime,
                .Training = "",
                .CheckInTime = p.checkInTime.ToString(),
                .POS = p.PosStatus,
                .AccountName = p.accountName,
                .AccountAddress = p.address,
                .AccountCity = p.city,
                .AccountState = p.state,
                .Status = p.statusName
                })

                Return list.ToList()
            End Using
        End Get
    End Property

    Private Function GetMimeType(fileExt As String) As String
        Dim mimeType As String = [String].Empty
        Select Case fileExt.ToLower()
            Case ".xlsx"
                mimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Exit Select
            Case ".pdf"
                mimeType = "application/pdf"
                Exit Select
            Case ".txt"
                mimeType = "text/plain"
                Exit Select
            Case ".csv"
                mimeType = "text/csv"
                Exit Select
        End Select
        Return mimeType
    End Function

    Public Shared Function GetFormatProvider(extension As String) As IWorkbookFormatProvider
        Dim formatProvider As IWorkbookFormatProvider
        Select Case extension
            Case ".xlsx"
                formatProvider = New XlsxFormatProvider()
                Exit Select
            Case ".csv"
                formatProvider = New CsvFormatProvider()
                DirectCast(formatProvider, CsvFormatProvider).Settings.HasHeaderRow = True
                Exit Select
            Case ".txt"
                formatProvider = New TxtFormatProvider()
                Exit Select
            Case ".pdf"
                formatProvider = New PdfFormatProvider()
                Exit Select
            Case Else
                formatProvider = Nothing
                Exit Select
        End Select

        Return formatProvider
    End Function

    Private Function CreateWorkbook() As Workbook
        Dim workbook As New Workbook()
        workbook.Sheets.Add(SheetType.Worksheet)

        Dim worksheet As Worksheet = workbook.ActiveWorksheet

        Me.PrepareInvoiceDocument(worksheet, Assignments.Count)

        Dim currentRow As Integer = IndexRowItemStart + 1
        For Each item As AssignmentList In Assignments
            worksheet.Cells(currentRow, 0).SetValue(item.EventID)
            worksheet.Cells(currentRow, IndexColumnAmbassadorName).SetValue(item.AmbassadorName)
            worksheet.Cells(currentRow, IndexColumnAmbassadorEmail).SetValue(item.AmbassadorEmail)
            worksheet.Cells(currentRow, IndexColumnAmbassadorPhone).SetValue(item.AmbassadorPhone)
            worksheet.Cells(currentRow, IndexColumnSupplierName).SetValue(item.SupplierName)
            worksheet.Cells(currentRow, IndexColumnBrands).SetValue(item.Brands)
            worksheet.Cells(currentRow, IndexColumnEventDate).SetValue(item.EventDate)
            worksheet.Cells(currentRow, IndexColumnStartTime).SetValue(item.StartTime)
            worksheet.Cells(currentRow, IndexColumnEndTime).SetValue(item.EndTime)
            worksheet.Cells(currentRow, IndexColumnTraining).SetValue(item.Training)
            worksheet.Cells(currentRow, IndexColumnCheckInTime).SetValue(item.CheckInTime)
            worksheet.Cells(currentRow, IndexColumnPOS).SetValue(item.POS)
            worksheet.Cells(currentRow, IndexColumnAccountName).SetValue(item.AccountName)
            worksheet.Cells(currentRow, IndexColumnAccountAddress).SetValue(item.AccountAddress)
            worksheet.Cells(currentRow, IndexColumnAccountCity).SetValue(item.AccountCity)
            worksheet.Cells(currentRow, IndexColumnAccountState).SetValue(item.AccountState)
            worksheet.Cells(currentRow, IndexColumnStatus).SetValue(item.Status)

            currentRow += 1
        Next

        For i As Integer = 0 To worksheet.Columns.Count - 1
            worksheet.Columns(i).AutoFitWidth()

        Next

        Return workbook
    End Function

    Private Sub PrepareInvoiceDocument(worksheet As Worksheet, itemsCount As Integer)
        Dim lastItemIndexRow As Integer = IndexRowItemStart + itemsCount

        Dim firstRowFirstCellIndex As New CellIndex(0, 0)
        Dim firstRowLastCellIndex As New CellIndex(0, 16)
        Dim lastRowFirstCellIndex As New CellIndex(lastItemIndexRow + 1, IndexColumnEventID)
        Dim lastRowLastCellIndex As New CellIndex(lastItemIndexRow + 1, IndexColumnStatus)
        worksheet.Cells(firstRowFirstCellIndex, firstRowLastCellIndex).MergeAcross()
        worksheet.Cells(firstRowFirstCellIndex).SetValue("Event Assignments from " & FromDatePicker.SelectedDate & " to " & ToDatePicker.SelectedDate)
        worksheet.Cells(firstRowFirstCellIndex).SetFontSize(20)


        worksheet.Cells(IndexRowItemStart, IndexColumnEventID).SetValue("EventID")
        worksheet.Cells(IndexRowItemStart, IndexColumnAmbassadorName).SetValue("Ambassador Name")
        worksheet.Cells(IndexRowItemStart, IndexColumnAmbassadorEmail).SetValue("Ambassador Email")
        worksheet.Cells(IndexRowItemStart, IndexColumnAmbassadorPhone).SetValue("Phone")
        worksheet.Cells(IndexRowItemStart, IndexColumnSupplierName).SetValue("Supplier Name")
        worksheet.Cells(IndexRowItemStart, IndexColumnBrands).SetValue("Brands")
        worksheet.Cells(IndexRowItemStart, IndexColumnEventDate).SetValue("Event Date")
        worksheet.Cells(IndexRowItemStart, IndexColumnStartTime).SetValue("Start Time")
        worksheet.Cells(IndexRowItemStart, IndexColumnEndTime).SetValue("End Time")
        worksheet.Cells(IndexRowItemStart, IndexColumnTraining).SetValue("Training")
        worksheet.Cells(IndexRowItemStart, IndexColumnCheckInTime).SetValue("CheckInTime")
        worksheet.Cells(IndexRowItemStart, IndexColumnPOS).SetValue("POS")
        worksheet.Cells(IndexRowItemStart, IndexColumnAccountName).SetValue("Account Name")
        worksheet.Cells(IndexRowItemStart, IndexColumnAccountAddress).SetValue("Account Address")
        worksheet.Cells(IndexRowItemStart, IndexColumnAccountCity).SetValue("Account City")
        worksheet.Cells(IndexRowItemStart, IndexColumnAccountState).SetValue("Account State")
        worksheet.Cells(IndexRowItemStart, IndexColumnStatus).SetValue("Status")

        worksheet.Cells(IndexRowItemStart, IndexColumnEventID, IndexRowItemStart, IndexColumnStatus).SetIsBold(True)

    End Sub

#End Region

End Class