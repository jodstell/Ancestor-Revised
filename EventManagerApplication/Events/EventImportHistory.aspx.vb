Imports Telerik.Web.UI

Public Class EventImportHistory
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ImportGrid_FilterCheckListItemsRequested(sender As Object, e As Telerik.Web.UI.GridFilterCheckListItemsRequestedEventArgs)

    End Sub

    Private Sub ImportGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ImportGrid.ItemCommand

        Select Case e.CommandName
            Case "ViewEvent"
                Dim id = e.CommandArgument

                Response.Redirect("EventImport?ImportID=" & id)

        End Select

    End Sub
End Class