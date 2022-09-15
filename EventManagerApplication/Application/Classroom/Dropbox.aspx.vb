Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.Reflection
Imports Telerik.Web.UI

Public Class Dropbox
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim username As String
    Dim pageName As String
    Dim pageTitle As String

    Private Sub DropBox_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit

        pageName = System.IO.Path.GetFileName(Request.Url.ToString())
        pageTitle = pageName.Substring(0, pageName.IndexOf("?"))

        Page.Title = GetWidgetName() & " | " & getCourseName()

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())
        username = currentUser.UserName

        If Not Page.IsPostBack Then
            bindAssignmentUploads()
        End If
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


    Sub bindAssignmentUploads()

        Dim q = From p In db.AssignmentFiles
                Join c In db.Files
                On p.FileID Equals c.ID
                Join a In db.CourseAssignments
                On p.AssignmentID Equals a.AssignmentID
                Where p.StudentID = username
                Select p.AssignmentID, c.FileName, c.DateUploaded, a.Title, c.ID

        MyAssignmentUploads.DataSource = q
        MyAssignmentUploads.DataBind()
    End Sub


End Class