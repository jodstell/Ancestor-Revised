Public Class EditEventTypeQuestion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click

        Response.Redirect("/admin/eventtypes/editeventtype?ClientID=" & Common.GetCurrentClientID() & "&EventTypeID=" & Request.QueryString("EventTypeID"))
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Response.Redirect("/admin/eventtypes/editeventtype?ClientID=" & Common.GetCurrentClientID() & "&EventTypeID=" & Request.QueryString("EventTypeID"))

    End Sub
End Class