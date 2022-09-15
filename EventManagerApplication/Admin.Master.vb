Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Public Class Admin
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        FullNameLabel.Text = GetFullName()
    End Sub

    Function GetFullName() As String
        Try
            Dim db As New DataClassesDataContext

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

            Dim result = (From p In db.tblProfiles Where p.userID = currentUser.Id Select p).FirstOrDefault

            Return String.Format("{0} {1}", result.firstName, result.lastName)
        Catch ex As Exception

            Return "There was an error"
        End Try


    End Function

End Class