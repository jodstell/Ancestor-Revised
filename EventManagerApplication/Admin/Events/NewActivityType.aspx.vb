Imports Telerik.Web.UI

Public Class NewActivityType
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'create a temp ID




    End Sub

    Private Sub NewActivityTypeWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles NewActivityTypeWizard.CancelButtonClick

        Response.Redirect("/admin/ClientDetails?Action=0&ClientID=" & Common.GetCurrentClientID() & "#accounttab/accountactivities")

    End Sub

    Private Sub NewActivityTypeWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles NewActivityTypeWizard.FinishButtonClick


        Response.Redirect("/admin/ClientDetails?Action=0&ClientID=" & Common.GetCurrentClientID() & "#accounttab/accountactivities")
    End Sub
End Class