Imports Telerik.Web.UI

Public Class Library
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim pageName As String
    Dim pageTitle As String

    Private Sub Library_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit

        pageName = System.IO.Path.GetFileName(Request.Url.ToString())
        pageTitle = pageName.Substring(0, pageName.IndexOf("?"))

        Page.Title = GetWidgetName() & " | " & getCourseName()

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim myculture = (From p In db.Sites Where p.SiteID = GetSiteID() Select p.CultureInfoCode).FirstOrDefault

        If Not Page.IsPostBack Then
            BindLibrary()
            BindLinks()
        End If

    End Sub

    Function getCourseName() As String
        Return (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.CourseTitle).FirstOrDefault
    End Function

    Function GetWidgetName() As String

        Return (From p In db.CourseWidgets Where p.WidgetName = pageTitle Select p.Title).FirstOrDefault

    End Function

    Function GetWidgetDescription() As String

        Return (From p In db.CourseWidgets Where p.WidgetName = pageTitle Select p.DescriptionText).FirstOrDefault

    End Function

    Sub BindLibrary()

        Dim q = From p In db.CourseFiles
                Join c In db.Files
                On c.ID Equals p.FileID
                Where p.CourseID = Request.QueryString("CourseID")
                Select c.FileName, c.ID, c.Size, c.DateUploaded, c.UploadedBy, c.ContentType, p.FileID

        LibraryFileList.DataSource = q
        LibraryFileList.DataBind()

    End Sub

    Sub BindLinks()

        Dim q = From p In db.CourseLinks
                Join c In db.Links
               On c.ID Equals p.LinkID
                Where p.CourseID = Request.QueryString("CourseID")
                Select c.LinkTitle, c.ID, c.LinkURL, p.LinkID

        CourseLinksList.DataSource = q
        CourseLinksList.DataBind()

    End Sub

    Function getUserFullName(ByVal username As String) As String

        Dim students = From p In db.StudentDetails Where p.SiteID = GetSiteID() Select p
        Dim instructors = From p In db.Instructors Where p.SiteID = GetSiteID() Select p

        Dim userlist As New List(Of UserInformation)

        For Each p In students
            userlist.Add(New UserInformation(p.FirstName, p.LastName, p.Email, p.FirstName & " " & p.LastName, "Student"))
        Next

        For Each p In instructors
            userlist.Add(New UserInformation("", "", p.InstructorEmail, p.InstructorName, "Instructor"))
        Next

        Dim result = (From r In userlist Where r.EmailAddress = username Select r.FullName).FirstOrDefault

        Return result



    End Function

    Function getFileType(type As String) As String

        Select Case type
            Case "application/pdf"
                Return ".pdf"
            Case "image/png"
                Return ".png"

        End Select
    End Function

    Function GetSiteID() As String

        Dim host As String = Request.Url.Host.ToLower
        Try
            Dim q = From p In db.Sites Where p.Host = host Select p

            For Each p In q
                Return (p.SiteID)
            Next
        Catch ex As Exception
        End Try

        Return host

    End Function

End Class