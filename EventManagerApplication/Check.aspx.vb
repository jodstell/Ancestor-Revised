Imports Microsoft.AspNet.Identity

Public Class Check
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        hiddenUserName.Text = currentUser.Id
        hiddenEventID.Text = "111111"

    End Sub

End Class