Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin

Public Class Logout
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())



        Context.GetOwinContext().Authentication.SignOut()

        Response.Redirect("/")
    End Sub

End Class