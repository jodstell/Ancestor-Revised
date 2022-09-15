Imports System.Data.SqlClient
Imports Telerik.Web.UI

Public Class ViewActivities
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime
    Dim userdb As New LMSDataClassesDataContext

    Shared filter As Boolean = False
    Shared numberofrows As Integer

    Private Shared ReadOnly CookieName As String = "ActivityGridPF"

    Private Sub ViewActivities_Init(sender As Object, e As EventArgs) Handles Me.Init
        RadPersistenceManager1.StorageProviderKey = CookieName
        RadPersistenceManager1.StorageProvider = New CookieStorageProvider(CookieName)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            'Enter any Date in MDY format

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", -5 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 6 - dtNow.DayOfWeek, dtNow)

            'Displays first day of the week
            lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")

            FromDatePicker.SelectedDate = weekStartDate
            ToDatePicker.SelectedDate = weekEndDate


        End If

        If Request.QueryString("LoadState") IsNot Nothing Then

            Dim state = Request.QueryString("LoadState")

            If state = "Yes" Then
                If Not Page.IsPostBack Then

                    If Request.Cookies(CookieName) IsNot Nothing Then
                        RadPersistenceManager1.LoadState()

                        'set the date range from session state
                        FromDatePicker.SelectedDate = Session("FromDate_Activity")
                        ToDatePicker.SelectedDate = Session("ToDate_Activity")


                        ActivityGrid.Rebind()
                    End If
                End If
            End If

        End If

    End Sub


    Protected Sub ActivityGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()

    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryGetAccountActivities order by {0}", field)

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

        ActivityGrid.DataBind()


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

        ActivityGrid.DataBind()


    End Sub

    Private Sub ActivityGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ActivityGrid.ItemCommand
        Select Case e.CommandName
            Case "ExportToExcell"

                ActivityGrid.ExportSettings.ExportOnlyData = False
                ActivityGrid.ExportSettings.IgnorePaging = True
                ActivityGrid.ExportSettings.OpenInNewWindow = True
                ActivityGrid.ExportSettings.UseItemStyles = False
                ActivityGrid.ExportSettings.FileName = "Activities"

                ActivityGrid.MasterTableView.GetColumn("ViewButton").Visible = False

                ActivityGrid.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

                ActivityGrid.MasterTableView.ExportToExcel()

            Case "EditActivity"

                Dim q = (From p In db.tblAccountActivities Where p.accountActivityID = Convert.ToInt32(e.CommandArgument) Select p.accountID).FirstOrDefault

                RadPersistenceManager1.SaveState()
                Session.Add("FromDate_Activity", FromDatePicker.SelectedDate)
                Session.Add("ToDate_Activity", ToDatePicker.SelectedDate)

                Response.Redirect(String.Format("/accounts/editactivity?ActivityID={0}&AccountID={1}&Mode=View", e.CommandArgument, q))


        End Select


    End Sub

    Private Sub ActivityGrid_ItemCreated(sender As Object, e As GridItemEventArgs) Handles ActivityGrid.ItemCreated
        If TypeOf e.Item Is GridHeaderItem Then
            Dim headerItem As GridHeaderItem = TryCast(e.Item, GridHeaderItem)
            For Each column As GridColumn In ActivityGrid.MasterTableView.RenderColumns
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
End Class