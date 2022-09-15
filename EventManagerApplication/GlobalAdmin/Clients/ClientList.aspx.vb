Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class ClientList
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    'Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
    '    Response.Redirect("/dashboard")
    'End Sub

    Private Sub ClientList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ClientList.ItemCommand
        Select Case e.CommandName

            Case "NewClient"

                Response.Redirect("/GlobalAdmin/Clients/NewClient")

            Case "ViewClient"

                'Session("CurrentClientID") = Convert.ToInt32(e.CommandArgument)

                Dim db As New DataClassesDataContext

                Dim manager = New UserManager()
                Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

                Dim result = (From p In db.tblProfiles Where p.userID = currentUser.Id Select p).FirstOrDefault

                result.currentClientID = Convert.ToInt32(e.CommandArgument)

                db.SubmitChanges()

                'ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = Convert.ToInt32(e.CommandArgument) Select p.clientName).FirstOrDefault

                Response.Redirect("/dashboard")



            Case "DeleteClient"
                db.DeleteClient(Convert.ToInt32(e.CommandArgument))
                ClientList.DataBind()

        End Select
    End Sub
End Class