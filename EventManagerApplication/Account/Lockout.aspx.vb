
Partial Public Class Lockout
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Context.GetOwinContext().Authentication.SignOut()
    End Sub
End Class
