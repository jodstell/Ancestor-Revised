Public Class PreviousEventsControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub PreviousEventsList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles PreviousEventsList.ItemDataBound
        If PreviousEventsList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If

    End Sub
End Class