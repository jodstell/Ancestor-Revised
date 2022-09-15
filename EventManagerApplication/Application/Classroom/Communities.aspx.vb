Public Class Communities
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext

    Dim StudentisInCourse As Boolean = False
    Dim StudentisInCommunity As Boolean = False
    Dim pageName As String
    Dim pageTitle As String

    Private Sub Communities_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit

        pageName = System.IO.Path.GetFileName(Request.Url.ToString())
        pageTitle = pageName.Substring(0, pageName.IndexOf("?"))

        Page.Title = GetWidgetName() & " | " & getCourseName()

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getCourseName() As String
        Try
            Return (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.CourseTitle).FirstOrDefault

        Catch ex As Exception
            Return "There was an error"
        End Try
    End Function

    Function GetWidgetName() As String

        Try
            Return (From p In db.CourseWidgets Where p.WidgetName = pageTitle And p.CourseID = Request.QueryString("CourseID") Select p.Title).FirstOrDefault

        Catch ex As Exception
            Return "There was a problem"
        End Try


    End Function

    Function GetWidgetDescription() As String
        Try
            Return (From p In db.CourseWidgets Where p.WidgetName = pageTitle And p.CourseID = Request.QueryString("CourseID") Select p.DescriptionText).FirstOrDefault

        Catch ex As Exception
            Return "There was a problem"
        End Try

    End Function

End Class