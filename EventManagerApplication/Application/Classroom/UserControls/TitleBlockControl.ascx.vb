Public Class TitleBlockControl
    Inherits System.Web.UI.UserControl

    Dim db As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        TitleLabel.Text = MyCulture.getCulture(Request.QueryString("CourseID"), "CourseTitle", Session("MyCulture"), getCourseName(Request.QueryString("CourseID")))

        If Not Page.IsPostBack Then
            Dim showSubTitle = (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.ShowCourseSubHeading).FirstOrDefault
            SubTitlePanel.Visible = showSubTitle
        End If

    End Sub

    Function getCourseName(courseid As String) As String

        Return (From p In db.Courses Where p.CourseID = courseid Select p.CourseTitle).FirstOrDefault

    End Function

    Function getCourseInfo() As String

        Dim coarsecode As String = (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.CourseCode).FirstOrDefault
        Dim instructor As String = (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.InstructorID).FirstOrDefault
        Dim group As String = (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.GroupID).FirstOrDefault

        Return String.Format("{0}, {1}, {2}", coarsecode, GetGroupTitle(group), GetInstructorName(instructor))

    End Function

    Function GetInstructorName(ByVal id As String) As String
        Try
            Return (From p In db.Instructors Where p.InstructorID = id Select p.InstructorName).FirstOrDefault
        Catch ex As Exception
            Return ""
        End Try

    End Function

    Function GetGroupTitle(ByVal id As String) As String
        Try

            Dim t = (From p In db.TestGroups Where p.GroupID = id Select p).FirstOrDefault
            Return MyCulture.getCulture(t.GroupID, "GroupTitle", Session("MyCulture"), t.GroupTitle)



        Catch ex As Exception
            Return ""
        End Try

    End Function

End Class