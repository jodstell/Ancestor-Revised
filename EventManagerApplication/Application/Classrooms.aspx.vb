Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.Reflection
Imports System.Threading
Imports System.Globalization

Public Class Classrooms
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim db1 As New DataClassesDataContext

    Private Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        Page.Title = GetTabName(5)
    End Sub

    Protected Overrides Sub InitializeCulture()

        'Set the UICulture and the Culture with a value stored in a Session-object. I called mine “MyCulture”
        Thread.CurrentThread.CurrentUICulture = New CultureInfo(Session("MyCulture").ToString)
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(Session("MyCulture").ToString)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



        'Dim q = From p In db.StudentsInCourses
        '        Join c In db.Courses
        '        On c.CourseID Equals p.CourseID
        '        Where p.UserName = currentUser.UserName.ToString() And c.CourseID IsNot "1c6fd977-048c-4550-8dbc-02d73f4f3e77" And c.Enabled = True
        '        Select c

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Dim a = From r In db.qryGetCourseListByUserIDs Where r.UserID = currentUser.Id And r.CourseID <> "1c6fd977-048c-4550-8dbc-02d73f4f3e77" Select r

        DataList1.DataSource = a
        DataList1.DataBind()


        ' For Each r In a
        'Dim q = From p In db.Courses
        '            Where p.Enabled = True And p.CourseID = r.courseID
        '            Order By p.CourseTitle
        '            Select p

        '    DataList1.DataSource = q
        '    DataList1.DataBind()
        ' Next




        Try
                Dim i = From p In db.Courses Where p.CourseID = "1c6fd977-048c-4550-8dbc-02d73f4f3e77" Select p

                Repeater1.DataSource = i
                Repeater1.DataBind()
            Catch ex As Exception

            End Try


        TabNameLabel.Text = GetTabName(5)
        TabDescLabel.Text = GetTabDescription(5)

    End Sub

    Function getCourseTitle(ByVal courseID As String) As String

        Try
            Return (From p In db.Courses Where p.CourseID = courseID Select p.CourseTitle).FirstOrDefault

        Catch ex As Exception
            Return "Error"
        End Try

    End Function

    Function calculatPercentComplete(courseID) As String
        Try
            Dim result = From p In db.baretc_BrandTrainingResult(Context.User.Identity.GetUserId(), 18) Where p.CourseID = courseID Select p
            Dim totalCount As Integer
            Dim completeCount As Integer

            For Each p In result
                totalCount = p.CurriculumCount
                completeCount = p.CurriculumCompletedCount
            Next

            Dim percent As Double = (CDbl(totalCount) / completeCount)

            Return String.Format("{0:p}", percent)
        Catch ex As Exception
            Return "Error"
        End Try


    End Function



    Function getIcon(ByVal courseID As String) As String

        Try
            Return (From p In db.Courses Where p.CourseID = courseID Select p.IconURL).FirstOrDefault

        Catch ex As Exception

        End Try

    End Function

    Function getWidgetName(ByVal courseid As String, ByVal name As String) As String
        Try
            Return (From p In db.CourseWidgets Where p.CourseID = courseid And p.WidgetName = name Select p.Title).FirstOrDefault
        Catch ex As Exception
            Return "Error"
        End Try


    End Function
    Function GetTabName(ByVal id As Integer) As String
        Try
            Dim siteid As String = GetSiteID()
            Return (From p In db.DashboardTabs Where p.SiteID = siteid And p.TabID = id Select p.Title).FirstOrDefault
        Catch ex As Exception
            Return "Error"
        End Try


    End Function

    Function GetTabDescription(ByVal id As Integer) As String
        Try
            Dim siteid As String = GetSiteID()
            Return (From p In db.DashboardTabs Where p.SiteID = siteid And p.TabID = id Select p.Title).FirstOrDefault
        Catch ex As Exception
            Return "Error"
        End Try


    End Function

    Function countTests(ByVal courseid As String) As Integer
        Try
            Return (From p In db.TestCount_byCourseIDs Where p.CourseID = courseid Select p.TotalTests).FirstOrDefault

        Catch ex As Exception
            Return 0
        End Try
    End Function


    Function countFiles(ByVal courseid As String) As Integer
        Try
            Return (From p In db.CourseFiles_Counts Where p.CourseID = courseid Select p.TotalFiles).FirstOrDefault

        Catch ex As Exception
            Return 0
        End Try
    End Function

    Function countLessons(ByVal courseid As String) As Integer
        Try
            Return (From p In db.TotalLessonCount_byCourseIDs Where p.CourseID = courseid Select p.TotalLessons).FirstOrDefault

        Catch ex As Exception
            Return 0
        End Try
    End Function

    Function GetSiteID() As String

        Return "GigEngyn"

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
            Return (From p In db.TestGroups Where p.GroupID = id Select p.GroupTitle).FirstOrDefault
        Catch ex As Exception
            Return ""
        End Try

    End Function

End Class