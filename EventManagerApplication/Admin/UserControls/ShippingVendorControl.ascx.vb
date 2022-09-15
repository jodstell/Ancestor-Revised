Imports Telerik.Web.UI
Public Class ShippingVendorControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub ShippingVendorGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ShippingVendorGrid.ItemCommand

        Select Case e.CommandName
            Case "AddNew"

                Response.Redirect("admin/settings/newshippingvendor")

            Case "ExportToExcel"
                ShippingVendorGrid.ExportSettings.ExportOnlyData = False
                ShippingVendorGrid.ExportSettings.IgnorePaging = True
                ShippingVendorGrid.ExportSettings.OpenInNewWindow = True
                ShippingVendorGrid.ExportSettings.UseItemStyles = False
                ShippingVendorGrid.ExportSettings.FileName = "ShippingVendorList"

                ShippingVendorGrid.MasterTableView.GetColumn("ViewButton").Visible = False
                'ExpenseTypeGrid.MasterTableView.GetColumn("active").Visible = False

                ShippingVendorGrid.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

                ShippingVendorGrid.MasterTableView.ExportToExcel()

            Case "ClearFilters"

                For Each column As GridColumn In ShippingVendorGrid.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                ShippingVendorGrid.MasterTableView.FilterExpression = [String].Empty
                ShippingVendorGrid.MasterTableView.Rebind()

            Case "EditExpenseType"

                Response.Redirect("admin/settings/editshipingvendor?ShippingVendorID=" & e.CommandArgument)
        End Select

    End Sub
End Class