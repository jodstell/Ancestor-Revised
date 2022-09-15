Imports Telerik.Web.UI

Public Class BrandProcuctsControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub ProcustList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ProcustList.ItemCommand
        Select Case e.CommandName
            Case "EditBrand"

                'RadPersistenceManager1.SaveState()
                Response.Redirect("/admin/events/newProduct?ClientID=" & Common.GetCurrentClientID() & "&BrandID=" & e.CommandArgument)


            Case "AddNew"
                If e.CommandName = "AddNew" Then Response.Redirect("/admin/events/newproduct?ClientID=" & Common.GetCurrentClientID() & "&BrandID=" & Request.QueryString("BrandID"))
        End Select

    End Sub
End Class