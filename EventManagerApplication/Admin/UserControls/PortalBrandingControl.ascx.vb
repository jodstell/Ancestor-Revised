Public Class PortalBrandingControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ClientLogo.ImageUrl = (From p In db.tblClients Where p.clientID = Common.GetCurrentClientID() Select p.portalLogoURL).FirstOrDefault
    End Sub

End Class