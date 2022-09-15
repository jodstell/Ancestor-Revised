Imports System
Imports System.Globalization
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports Telerik.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI.GridExcelBuilder

Public Class RetailOffPremiseReport
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        hiddenUserID.Value = currentUser.Id


        If Not Page.IsPostBack Then

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 6 - dtNow.DayOfWeek, dtNow)

            'Displays first day of the week
            ' lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")
            '   FromDatePicker.SelectedDate = weekStartDate
            '  ToDatePicker.SelectedDate = weekEndDate


            Dim dtFirst As New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
            Dim endDate As DateTime = dtFirst.AddMonths(1).AddDays(-1)

            FromDatePicker.SelectedDate = dtFirst
            ToDatePicker.SelectedDate = endDate

            'select first item
            SelectedSupplier.SelectedIndex = 0

        End If

    End Sub

    Function GetConversionRate(ByVal eventID As Integer) As String

        Try
            Dim sold As Integer = (From p In db.qrySalesRecapReports Where p.eventID = eventID Select p.bottlesSold).FirstOrDefault
            Dim bottlessampled As Integer = (From p In db.qrySalesRecapReports Where p.eventID = eventID Select p.sampled).FirstOrDefault


            Dim conversionRate As Integer = (sold / bottlessampled) * 100
            Return String.Format("{0:0.0}%", conversionRate)
        Catch ex As Exception
            Return "0.0%"
        End Try



    End Function

    Function GetBrandConversionRate(value As String) As String

        Try
            Dim eventID As String
            Dim brandID As String

            Dim s As String()
            s = Split(value, ":")


            eventID = s(0)
            brandID = s(1)


            Dim sold As Integer = (From p In db.qrySalesRecapReportBrandTotals Where p.eventID = eventID And p.brandID = brandID Select p.bottlesSold).FirstOrDefault
            Dim bottlessampled As Integer = (From p In db.qrySalesRecapReportBrandTotals Where p.eventID = eventID And p.brandID = brandID Select p.sampled).FirstOrDefault


            Dim conversionRate As Integer = (sold / bottlessampled) * 100
            Return String.Format("{0:0.0}%", conversionRate)
        Catch ex As Exception
            Return "0.0%"
        End Try



    End Function

    Function GetBrandRevenueRate(value As String) As String

        'Dim eventID As String
        'Dim brandID As String

        'Dim s As String()
        's = Split(value, ":")


        'eventID = s(0)
        'brandID = s(1)


        ''  Dim q = (From p In db.tblBrands Where p.brandID = brandID Select p.avaeragePrice).FirstOrDefault

        'Return q

        Return ""


    End Function

    Function GetRevenueRate(eventID As Integer) As String
        Try
            Dim price As Integer = (From p In db.qrySalesRecapReports Where p.eventID = eventID Select p.averagePrice).FirstOrDefault
            Dim sold As Integer = (From p In db.qrySalesRecapReports Where p.eventID = eventID Select p.bottlesSold).FirstOrDefault

            Return String.Format("{0:c}", price * sold)
        Catch ex As Exception
            Return "0.0%"
        End Try

    End Function

    Protected Sub RadGrid1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadGrid1.PreRender

        If Not Page.IsPostBack Then

            RadGrid1.MasterTableView.Items(0).Expanded = True

            RadGrid1.MasterTableView.Items(0).ChildItem.NestedTableViews(0).Items(0).Expanded = True

        End If

    End Sub

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click
        Dim Sampled = (From p In db.getRecapResultsbyDateRange(0, 1, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.total).Sum()

        Dim Sold = (From p In db.getRecapResultsbyDateRange(0, 3, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.total).Sum()


        Try
            Dim conversionRate As Integer = (Sold / Sampled) * 100
            ConversionRateLabel.Text = String.Format("{0:0.0}%", conversionRate)
        Catch ex As Exception
            ConversionRateLabel.Text = "There was an error"
            'no results
            ReportPanel.Visible = False
            LabelPanel.Visible = False

            DefaultMessage.Visible = False
            NoResultLabel.Visible = True
            NoResultLabel.Text = Common.ShowAlertNoClose("warning", "<b>Warning!</b>  There were no events found!  Please adjust your filter.")
            Exit Sub
        End Try



        VolumeLabel.Text = (From p In db.getRecapResultsbyDateRange(0, 1, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.total).Count()
        SampledTotalLabel.Text = (From p In db.getRecapResultsbyDateRange(0, 1, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.total).Sum()

        BottlesSoldTotalLabel.Text = (From p In db.getRecapResultsbyDateRange(0, 3, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.total).Sum()



        Dim myInt As Int64 = (From p In db.getRecapWeeklyEstimatedRevenue(FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue) Select p.TOTAL).Sum
        Dim nfi As NumberFormatInfo = New CultureInfo("en-US", False).NumberFormat
        nfi.CurrencyDecimalDigits = 0


        RevenueLabel.Text = myInt.ToString("C", nfi)

        DateRangeLabel.Text = String.Format("{0:D} - {1:D}", FromDatePicker.SelectedDate, ToDatePicker.SelectedDate)

        DefaultMessage.Visible = False
        NoResultLabel.Visible = False
        ReportPanel.Visible = True
        LabelPanel.Visible = True
    End Sub

    Protected Sub RadGrid1_ExcelMLExportRowCreated(ByVal source As Object, ByVal e As GridExportExcelMLRowCreatedArgs) Handles RadGrid1.ExcelMLExportRowCreated
        ' e.Row.Cells.GetCellByName("brandName").StyleValue = "myCustomStyle"




    End Sub
    Protected Sub RadGrid1_ExcelMLExportStylesCreated(ByVal source As Object, ByVal e As GridExportExcelMLStyleCreatedArgs) Handles RadGrid1.ExcelMLExportStylesCreated

        For Each style As StyleElement In e.Styles
            Select Case style.Id
                Case "headerStyle"
                    style.FontStyle.Bold = True
                Case "itemStyle"
                    ' style.FontStyle.Color = System.Drawing.Color.LightBlue
                    Exit Select
                Case "alternatingItemStyle"
                    ' style.FontStyle.Color = System.Drawing.Color.Blue
                    Exit Select
            End Select
        Next

        'Dim myStyle As New StyleElement("myCustomStyle")
        ''  myStyle.NumberFormat.FormatType = NumberFormatType.Currency
        'myStyle.FontStyle.Bold = True

        ''  myStyle.NumberFormat.Attributes("ss:Format") = "MM/dd/yyyy"

        'e.Styles.Add(myStyle)
    End Sub




    Private Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand



        Select Case e.CommandName

            Case "ExportML"

                RadGrid1.ExportSettings.FileName = "OffPremiseReport"
                RadGrid1.ExportSettings.IgnorePaging = True
                RadGrid1.ExportSettings.ExportOnlyData = True
                RadGrid1.ExportSettings.OpenInNewWindow = True
                RadGrid1.MasterTableView.UseAllDataFields = True
                RadGrid1.MasterTableView.DetailTables(0).UseAllDataFields = True

                RadGrid1.ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML

                RadGrid1.MasterTableView.HierarchyDefaultExpanded = True
                RadGrid1.MasterTableView.DetailTables(0).HierarchyDefaultExpanded = True

                RadGrid1.MasterTableView.HierarchyLoadMode = GridChildLoadMode.Client

                RadGrid1.MasterTableView.DetailTables(0).HierarchyLoadMode = GridChildLoadMode.Client

                RadGrid1.MasterTableView.ExportToExcel()


            Case "ExportXLSX"


                RadGrid1.RetainExpandStateOnRebind = True

                RadGrid1.ExportSettings.ExportOnlyData = False
                RadGrid1.ExportSettings.IgnorePaging = True
                RadGrid1.ExportSettings.OpenInNewWindow = True
                RadGrid1.ExportSettings.UseItemStyles = False
                RadGrid1.ExportSettings.FileName = "SalesReport2"

                RadGrid1.MasterTableView.HierarchyDefaultExpanded = True
                RadGrid1.MasterTableView.DetailTables(0).HierarchyDefaultExpanded = True

                RadGrid1.MasterTableView.HierarchyLoadMode = GridChildLoadMode.Client

                RadGrid1.MasterTableView.DetailTables(0).HierarchyLoadMode = GridChildLoadMode.Client

                RadGrid1.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

                RadGrid1.MasterTableView.ExportToExcel()

            Case "ExportToExcel"


                RadGrid1.ExportSettings.ExportOnlyData = False
                RadGrid1.ExportSettings.IgnorePaging = True
                RadGrid1.RetainExpandStateOnRebind = True

                RadGrid1.ExportSettings.OpenInNewWindow = True
                RadGrid1.ExportSettings.UseItemStyles = False
                'RadGrid1.MasterTableView.UseAllDataFields = True
                RadGrid1.ExportSettings.FileName = "SalesReport"



                RadGrid1.MasterTableView.ExportToExcel()

            Case "ExportTocsv"

                'Is the item about to be expanded or collapsed
                If Not e.Item.Expanded Then
                    'Save its unique index among all the items in the hierarchy
                    Me.ExpandedStates(e.Item.ItemIndexHierarchical) = True
                Else
                    'collapsed
                    Me.ExpandedStates.Remove(e.Item.ItemIndexHierarchical)
                    Me.ClearExpandedChildren(e.Item.ItemIndexHierarchical)
                End If



                RadGrid1.ExportSettings.ExportOnlyData = False
                RadGrid1.ExportSettings.IgnorePaging = True
                RadGrid1.ExportSettings.OpenInNewWindow = True
                RadGrid1.ExportSettings.UseItemStyles = False
                'RadGrid1.MasterTableView.UseAllDataFields = True
                RadGrid1.ExportSettings.FileName = "SalesReport1"

                RadGrid1.MasterTableView.HierarchyDefaultExpanded = True
                RadGrid1.MasterTableView.DetailTables(0).HierarchyDefaultExpanded = True


                RadGrid1.MasterTableView.HierarchyLoadMode = GridChildLoadMode.Client
                RadGrid1.MasterTableView.DetailTables(0).HierarchyLoadMode = GridChildLoadMode.Client

                RadGrid1.MasterTableView.EnableHierarchyExpandAll = True

                RadGrid1.MasterTableView.ExportToCSV()

            Case "ExportHTML"

                RadGrid1.ExportSettings.FileName = "filename"
                ' RadGrid1.ExportSettings.Excel.FileExtension = "xlsx"
                RadGrid1.ExportSettings.IgnorePaging = True
                RadGrid1.ExportSettings.ExportOnlyData = True
                RadGrid1.ExportSettings.OpenInNewWindow = True
                RadGrid1.MasterTableView.UseAllDataFields = True

                RadGrid1.ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML

                RadGrid1.MasterTableView.HierarchyDefaultExpanded = True
                RadGrid1.MasterTableView.DetailTables(0).HierarchyDefaultExpanded = True

                RadGrid1.MasterTableView.HierarchyLoadMode = GridChildLoadMode.Client
                RadGrid1.MasterTableView.DetailTables(0).HierarchyLoadMode = GridChildLoadMode.Client

                RadGrid1.MasterTableView.ExportToExcel()
        End Select

    End Sub

    Private _ordersExpandedState As Hashtable

    'Save/load expanded states Hash from the session
    'this can also be implemented in the ViewState
    Private ReadOnly Property ExpandedStates() As Hashtable
        Get
            If Me._ordersExpandedState Is Nothing Then
                _ordersExpandedState = TryCast(Me.Session("_ordersExpandedState"), Hashtable)
                If _ordersExpandedState Is Nothing Then
                    _ordersExpandedState = New Hashtable()
                    Me.Session("_ordersExpandedState") = _ordersExpandedState
                End If
            End If

            Return Me._ordersExpandedState
        End Get
    End Property

    'Clear the state for all expanded children if a parent item is collapsed
    Private Sub ClearExpandedChildren(ByVal parentHierarchicalIndex As String)
        Dim indexes As String() = New String(Me.ExpandedStates.Keys.Count - 1) {}
        Me.ExpandedStates.Keys.CopyTo(indexes, 0)
        For Each index As String In indexes
            'all indexes of child items
            If index.StartsWith(parentHierarchicalIndex + "_") OrElse index.StartsWith(parentHierarchicalIndex + ":") Then
                Me.ExpandedStates.Remove(index)
            End If
        Next
    End Sub


End Class