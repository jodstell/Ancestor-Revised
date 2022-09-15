Imports Telerik.Web.UI
Public Class ExpenseTypeControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub ExpenseTypeGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ExpenseTypeGrid.ItemCommand

        Select Case e.CommandName
            Case "AddNew"

                Response.Redirect("/admin/settings/newexpensetype")

            Case "ExportToExcel"
                ExpenseTypeGrid.ExportSettings.ExportOnlyData = False
                ExpenseTypeGrid.ExportSettings.IgnorePaging = True
                ExpenseTypeGrid.ExportSettings.OpenInNewWindow = True
                ExpenseTypeGrid.ExportSettings.UseItemStyles = False
                ExpenseTypeGrid.ExportSettings.FileName = "ExpenseTypeList"

                ExpenseTypeGrid.MasterTableView.GetColumn("ViewButton").Visible = False
                'ExpenseTypeGrid.MasterTableView.GetColumn("active").Visible = False

                ExpenseTypeGrid.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

                ExpenseTypeGrid.MasterTableView.ExportToExcel()

            Case "ClearFilters"

                For Each column As GridColumn In ExpenseTypeGrid.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                ExpenseTypeGrid.MasterTableView.FilterExpression = [String].Empty
                ExpenseTypeGrid.MasterTableView.Rebind()

            Case "EditExpenseType"

                Response.Redirect("/admin/settings/editexpensetype?expensetypeID=" & e.CommandArgument)
        End Select
    End Sub

End Class