Public Class SubmitQuestion
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim pageName As String
    Dim pageTitle As String


    Private Sub Notes_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        pageName = System.IO.Path.GetFileName(Request.Url.ToString())
        pageTitle = pageName.Substring(0, pageName.IndexOf("?"))

        Page.Title = GetWidgetName() & " | " & getCourseName()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getCourseName() As String
        Return (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.CourseTitle).FirstOrDefault
    End Function

    Function GetWidgetName() As String

        Return (From p In db.CourseWidgets Where p.WidgetName = pageTitle And p.CourseID = Request.QueryString("CourseID") Select p.Title).FirstOrDefault

    End Function

    Function GetWidgetDescription() As String

        Return (From p In db.CourseWidgets Where p.WidgetName = pageTitle And p.CourseID = Request.QueryString("CourseID") Select p.DescriptionText).FirstOrDefault

    End Function

End Class