Imports Telerik.Web.UI

Public Class SupplierBrandsListControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub BrandsList_FilterCheckListItemsRequested(sender As Object, e As Telerik.Web.UI.GridFilterCheckListItemsRequestedEventArgs)

    End Sub

    Private Sub BrandsList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles BrandsList.ItemCommand
        Select Case e.CommandName
            Case "AddNew"
                Response.Redirect("/admin/events/newbrand?ClientID=" & Common.GetCurrentClientID() & "&SupplierID=" & Request.QueryString("SupplierID"))
            Case "EditBrand"
                Response.Redirect("/admin/events/editbrand?BrandID=" & e.CommandArgument & "&SupplierID=" & Request.QueryString("SupplierID"))
        End Select
    End Sub
End Class