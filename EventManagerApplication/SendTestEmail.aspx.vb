Public Class SendTestEmail
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub BtnSend_Click(sender As Object, e As EventArgs) Handles BtnSend.Click

        MailHelper.SendMailMessage("no-reply@gigengyn.com", "Test Email", "This is a test for GigEngyn!")

        ResultLabel.Text = "Email Sent!"

    End Sub
End Class