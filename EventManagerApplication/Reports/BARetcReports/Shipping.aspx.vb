Imports Telerik.Web.UI

Public Class Shipping
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Enter any Date in MDY format

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 6 - dtNow.DayOfWeek, dtNow)

            'Displays first day of the week
            ' lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")

            FromDatePicker.SelectedDate = weekStartDate
            ToDatePicker.SelectedDate = weekEndDate
        End If


    End Sub

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click
        ShippingCostsGrid.Visible = True
    End Sub

    Private Sub ShippingCostsGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ShippingCostsGrid.ItemCommand

        Select Case e.CommandName


            Case "ClearFilters"
                For Each column As GridColumn In ShippingCostsGrid.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                ShippingCostsGrid.MasterTableView.FilterExpression = [String].Empty
                ShippingCostsGrid.MasterTableView.Rebind()

            Case "ExportToExcel"

                ShippingCostsGrid.ExportSettings.ExportOnlyData = False
                ShippingCostsGrid.ExportSettings.IgnorePaging = True
                ShippingCostsGrid.ExportSettings.OpenInNewWindow = True
                ShippingCostsGrid.ExportSettings.UseItemStyles = False
                ShippingCostsGrid.ExportSettings.FileName = "ShippingCost"

                ShippingCostsGrid.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

                ShippingCostsGrid.MasterTableView.ExportToExcel()

        End Select
    End Sub
End Class