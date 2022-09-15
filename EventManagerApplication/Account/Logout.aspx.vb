Public Class Logout1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Context.GetOwinContext().Authentication.SignOut()
        Response.Redirect("/")
    End Sub

End Class