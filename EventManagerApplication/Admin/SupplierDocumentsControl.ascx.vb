Public Class SupplierDocumentsControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub btnAddFiles_Click(sender As Object, e As EventArgs) Handles btnAddFiles.Click
        UploadPanel.Visible = True
        GridPanel.Visible = False
    End Sub

    Private Sub btnCancelUpload_Click(sender As Object, e As EventArgs) Handles btnCancelUpload.Click
        UploadPanel.Visible = False
        GridPanel.Visible = True
    End Sub

    Private Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click


        UploadPanel.Visible = False
        GridPanel.Visible = True

        GridPanel.DataBind()


    End Sub
End Class