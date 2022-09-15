Public Class UpcomingEventsControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CurrentDate.Value = Date.Now()
    End Sub

    Private Sub UpcomingEventsList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles UpcomingEventsList.ItemDataBound
        If UpcomingEventsList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If


    End Sub
End Class