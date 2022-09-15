Imports Microsoft.AspNet.Identity

Public Class NewClient
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim userdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub ClientFormView_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles ClientFormView.ItemInserted

        Response.Redirect("/GlobalAdmin/Clients/ClientList")
    End Sub

    Private Sub ClientFormView_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles ClientFormView.ItemCommand
        Select Case e.CommandName
            Case "Cancel"
                Response.Redirect("/GlobalAdmin/Clients/ClientList")
        End Select
    End Sub

    'Private Sub btnSaveClient_Click(sender As Object, e As EventArgs) Handles btnSaveClient.Click

    '    'add to datasource
    '    Dim newClient As New tblClient

    '    'newClient.clientName = clientNameTextBox.Text
    '    'newClient.phoneNumber = phoneNumberTextBox.Text

    '    db.tblClients.InsertOnSubmit(newClient)
    '    db.SubmitChanges()

    '    Response.Redirect("/GlobalAdmin/Clients/ClientList")

    'End Sub

    'Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
    '    Response.Redirect("/GlobalAdmin/Clients/ClientList")
    'End Sub
End Class