Public Class SiteConfigurationControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Private Sub SiteConfigurationFormView_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles SiteConfigurationFormView.ItemCommand
        Select Case e.CommandName

        End Select
    End Sub

    Private Sub SiteConfigurationFormView_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles SiteConfigurationFormView.ItemUpdated


        ' RadNotification1.Show()
    End Sub


End Class