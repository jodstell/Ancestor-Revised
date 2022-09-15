Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI

Public Class AddNewEvent
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Private Sub EventWizard_NextButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.NextButtonClick

        'add session variables
        Session.Add("EventName", eventTitleTextBox.Text)
        Session.Add("EventTypeID", EventTypeIDComboBox.SelectedValue)

        If TeamComboBox.SelectedIndex = -1 Then
            'do nothing
        Else
            Session.Add("TeamID", TeamComboBox.SelectedValue)
        End If


        Response.Redirect("/Events/NewEvent?supplierID=" & supplierIDComboBox.SelectedValue)
    End Sub

    Private Sub EventWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.CancelButtonClick
        Response.Redirect("/Events/ViewEvents")
    End Sub

End Class