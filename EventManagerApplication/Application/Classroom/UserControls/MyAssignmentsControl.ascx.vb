Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.Reflection

Public Class MyAssignmentsControl
    Inherits System.Web.UI.UserControl
    Dim db As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

            Dim assignmentlist As New List(Of MyAssignmentList)

            'assignments for current student
            Dim r = From p In db.CourseAssignments
                    Where p.StudentID = currentUser.UserName.ToString()
                    Select p
            For Each p In r
                assignmentlist.Add(New MyAssignmentList(p.AssignmentID, p.StudentID, p.CourseID, p.Title, p.Description, p.StartDate, p.DateDue, p.Link, getSubmittedResult(p.AssignmentID, p.StudentID), getGradedResult(p.AssignmentID, p.StudentID)))
            Next

            'assignments for class
            Dim q = From p In db.CourseAssignments
                    Join c In db.StudentsInCourses
              On p.CourseID Equals c.CourseID
                    Where p.StudentID Is Nothing And c.UserName = currentUser.UserName
                    Select p

            For Each p In q
                assignmentlist.Add(New MyAssignmentList(p.AssignmentID, currentUser.UserName, p.CourseID, p.Title, p.Description, p.StartDate, p.DateDue, p.Link, getSubmittedResult(p.AssignmentID, currentUser.UserName), getGradedResult(p.AssignmentID, currentUser.UserName)))
            Next

            Dim current = From p In assignmentlist Where p.Submitted = False And p.CourseID = Request.QueryString("CourseID") Select p


            MyAssignmentList.DataSource = current
            MyAssignmentList.DataBind()


            bindRightNavBar()

            'show or hide AssignmentPanel
            Dim showAssignemnts = (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.EnableAssignments).FirstOrDefault

            AssignmentPanel.Visible = showAssignemnts


        End If
    End Sub

    Sub bindRightNavBar()

        Dim q = From p In db.CourseWidgets Where p.CourseID = Request.QueryString("CourseID") And p.RightNav = True And p.Enabled = True Order By p.Order Select p

        RightNavBar.DataSource = q
        RightNavBar.DataBind()
    End Sub


    Function getIcon(ByVal name As String) As String
        Return (From p In db.Icons Where p.IconName = name Select p.IconDetail).FirstOrDefault

    End Function

    Function getCourseTitle(ByVal id As String) As String
        Return (From p In db.Courses Where p.CourseID = id Select p.CourseTitle).FirstOrDefault
    End Function

    Function getSubmittedResult(ByVal id As String, ByVal student As String) As Boolean
        Try
            Return (From p In db.CourseAssignmentResults Where p.AssignmentID = id And p.StudentID = student Select p.Completed).FirstOrDefault

        Catch ex As Exception
            Return False
        End Try
    End Function

    Function getGradedResult(ByVal id As String, ByVal student As String) As Boolean
        Try
            Return (From p In db.CourseAssignmentResults Where p.AssignmentID = id And p.StudentID = student Select p.Graded).FirstOrDefault

        Catch ex As Exception
            Return False
        End Try
    End Function

    Private Sub MyAssignmentList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles MyAssignmentList.ItemCommand
        If e.CommandName = "ViewAssignment" Then
            Dim id As String = e.CommandArgument
            Response.Redirect("ViewAssignment?AssignmentID=" & id & "&CourseID=" & Request.QueryString("CourseID"))
        End If
    End Sub

    Private Sub MyAssignmentList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles MyAssignmentList.ItemDataBound

        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then

            Dim lblDate As Label = DirectCast(e.Item.FindControl("lblDate"), Label)

            If lblDate.Text < Date.Now() Then
                lblDate.Text = String.Format("<span style='color:red'>{0}</span>", "Past Due:")
            Else
                lblDate.Text = String.Format("{0}", "Date Due:")
            End If
        End If


        If MyAssignmentList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If


    End Sub

    Private Sub btnAskQuestion_Click(sender As Object, e As EventArgs) Handles btnAskQuestion.Click

        'set referance page into memory

        Dim query As String = Request.ServerVariables("QUERY_STRING")
        Dim path As String = Request.ServerVariables("PATH_INFO")

        Session.Add("returnpath", path & "?" & query)

        Response.Redirect("SubmitQuestion?CourseID=" & Request.QueryString("CourseID"))

        'Response.Write(Session("returnpath"))

    End Sub

End Class