Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class ActivitiesControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '  btnAddNew.NavigateUrl = "/accounts/newactivity?AccountID=" & Request.QueryString("AccountID") & "&Mode=New"

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Then
            Response.Redirect("/AccessDenied")
        End If

        If manager.IsInRole(currentUser.Id, "Client") Then
            '      btnAddNew.Visible = False
        End If

    End Sub

    Private Sub getActivities_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getActivities.Inserting
        Dim item As tblAccountActivity
        item = CType(e.NewObject, tblAccountActivity)
        item.accountID = Request.QueryString("AccountID")
    End Sub


    Private Sub ActivitiesList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles ActivitiesList.ItemCommand
        If e.CommandName = "EditActivity" Then
            Response.Redirect("/accounts/editactivity?ActivityID=" & e.CommandArgument & "&AccountID=" & Request.QueryString("AccountID"))
        End If
    End Sub

    Function getActivityName(id As Integer) As String
        Return (From p In db.tblActivityTypes Where p.activityTypeID = id Select p.activityName).FirstOrDefault
    End Function

    Private Sub AnnouncementsList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles ActivitiesList.ItemDataBound
        If ActivitiesList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If

    End Sub

    Shared Function ShowAlertNoClose(ByVal type As String, ByVal msg As String) As String
        Return String.Format("<div class='alert alert-{0}'>{1}</div>", type, msg)
    End Function

End Class