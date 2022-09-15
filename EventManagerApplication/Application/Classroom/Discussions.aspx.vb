Imports System.Globalization
Imports Telerik.Web.UI

Public Class Discussions
    Inherits System.Web.UI.Page

    Dim db As New LMSDataClassesDataContext
    Dim selectedStudent As String = ""
    Dim selectedTopic As String = ""
    Dim pageName As String
    Dim pageTitle As String

    Private Sub Discussions_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit

        pageName = System.IO.Path.GetFileName(Request.Url.ToString())
        pageTitle = pageName.Substring(0, pageName.IndexOf("?"))

        Page.Title = GetWidgetName() & " | " & getCourseName()

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim myculture = (From p In db.Sites Where p.SiteID = GetSiteID() Select p.CultureInfoCode).FirstOrDefault

        If Not Page.IsPostBack Then
            BindTopics()
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


    Sub BindTopics()

        Dim l = From p In db.DiscussionBoards
                Join t In db.DiscussionTopics
                On t.BoardID Equals p.BoardID
                Where p.CourseID = Request.QueryString("CourseID") And t.Active = True
                Select t.Title, t.CreatedBy, t.CreatedDate, t.TopicID

        TopicList.DataSource = l
        TopicList.DataBind()
    End Sub


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

    Function GetTimeAdjustment(ByVal d As Date) As String
        Try

            Dim MyTimeZone As String = (From p In db.Sites Where p.SiteID = GetSiteID() Select p.DefaultTimeZone).FirstOrDefault
            Dim MyCulture As String = (From p In db.Sites Where p.SiteID = GetSiteID() Select p.CultureInfoCode).FirstOrDefault

            Dim cstZone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(MyTimeZone)

            Dim cstTime As DateTime = TimeZoneInfo.ConvertTimeFromUtc(d, cstZone)

            'add culture
            Dim culture As CultureInfo = CultureInfo.CreateSpecificCulture(MyCulture)

            Return String.Format("{0} ({1})", cstTime.ToString(culture.DateTimeFormat), ShortTimeZoneFormat(MyTimeZone))
        Catch ex As Exception
            Return d
        End Try

    End Function

    Private Function ShortTimeZoneFormat(timeZoneStandardName As String) As String
        Dim TimeZoneElements As String() = timeZoneStandardName.Split(" "c)
        Dim shortTimeZone As String = [String].Empty
        For Each element As String In TimeZoneElements
            'copies the first element of each word
            shortTimeZone += element(0)
        Next
        Return shortTimeZone
    End Function

    Function buildUserLink(ByVal _username As String) As String

        Dim students = From p In db.StudentDetails Where p.SiteID = GetSiteID() Select p
        Dim instructors = From p In db.Instructors Where p.SiteID = GetSiteID() Select p

        Dim userlist As New List(Of UserInformation)

        For Each p In students
            userlist.Add(New UserInformation(p.FirstName, p.LastName, p.Email, p.FirstName & " " & p.LastName, "Student"))
        Next

        For Each p In instructors
            userlist.Add(New UserInformation("", "", p.InstructorEmail, p.InstructorName, "Instructor"))
        Next

        Dim result = (From r In userlist Where r.EmailAddress = _username Select r.FullName, r.EmailAddress, r.Role).FirstOrDefault

        If result.Role = "Student" Then
            Return String.Format("<a href='/application/classroom/studentdetails?CourseID={0}&StudentID={1}'><i class='fa fa-user'></i>&nbsp;{2}</a>", Request.QueryString("CourseID"), result.EmailAddress, result.FullName)
        End If

        If result.Role = "Instructor" Then
            Return String.Format("<a href='/application/classroom/instructordetails?CourseID={0}&InstructorID={1}'><i class='fa fa-user'></i>&nbsp;{2}</a>", Request.QueryString("CourseID"), result.EmailAddress, result.FullName)
        End If

    End Function

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

    Function getRelpiesCount(topicID As String) As Integer

        Dim c = (From p In db.DiscussionThreads Where p.TopicID = topicID Select p).Count

        Return c

    End Function

    Function getLastPost(topicID As String) As String

        Dim q = From p In db.DiscussionThreads Where p.TopicID = topicID Order By p.CreatedDate Descending Select p Take (1)
        For Each p In q
            Return buildUserLink(p.CreatedBy)
        Next

        Return ""

    End Function

    Function getLastPostDate(topicID As String) As String

        Dim q = From p In db.DiscussionThreads Where p.TopicID = topicID Order By p.CreatedDate Descending Select p Take (1)
        For Each p In q
            Return GetTimeAdjustment(p.CreatedDate)
        Next

        Return ""

    End Function

    Private Sub TopicList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles TopicList.ItemCommand
        If e.CommandName = "ViewTopic" Then

            'bind the topic
            selectedTopic = e.CommandArgument

            Dim q = (From p In db.DiscussionTopics Where p.TopicID = selectedTopic Select p).FirstOrDefault

            lblTopicTitle.Text = q.Title
            lblTopicAuthor.Text = getUserFullName(q.CreatedBy)
            lblTopicBody.Text = q.BodyText
            lblDate.Text = GetTimeAdjustment(q.CreatedDate)

            'TODO Bind Reply's

            Dim t = From p In db.DiscussionThreads Where p.TopicID = selectedTopic And p.ParentID Is Nothing Select p

            TopicThreadList.DataSource = t
            TopicThreadList.DataBind()

            DiscussionsPanel.Visible = False
            ViewTopicPanel.Visible = True
        End If
    End Sub

    Private Sub btnViewAllTopics_Click(sender As Object, e As EventArgs) Handles btnViewAllTopics.Click
        DiscussionsPanel.Visible = True
        ViewTopicPanel.Visible = False
    End Sub

    Private Sub btnReplytoTopic_Click(sender As Object, e As EventArgs) Handles btnReplytoTopic.Click
        ViewTopicPanel.Visible = False
        TopicReplyPanel.Visible = True
    End Sub

    Private Sub btnSaveTopicReply_Click(sender As Object, e As EventArgs) Handles btnSaveTopicReply.Click
        ViewTopicPanel.Visible = True
        TopicReplyPanel.Visible = False

        'TODO Bind Reply's


    End Sub

    Private Sub TopicThreadList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles TopicThreadList.ItemCommand
        If e.CommandName = "ReplytoThread" Then
            ViewTopicPanel.Visible = False
            TopicReplyPanel.Visible = True
        End If

    End Sub

    Private Sub TopicThreadList_ItemDataBound(sender As Object, e As RadListViewItemEventArgs) Handles TopicThreadList.ItemDataBound

        If e.Item.ItemType = RadListViewItemType.DataItem OrElse e.Item.ItemType = RadListViewItemType.AlternatingItem Then

            ' Dim lblThreadID As Label = DirectCast(DirectCast(e.Item, RadListViewDataItem).DataItem, Label)

            'Get datarow
            ' Dim group As Group = DirectCast(DirectCast(e.Item, RadListViewDataItem).DataItem, Group)

            'Find controls
            Dim lblThreadID As Label = DirectCast(e.Item.FindControl("lblThreadID"), Label)
            Dim rlvItems As RadListView = DirectCast(e.Item.FindControl("ThreadList"), RadListView)


            'Populate controls
            Dim data = From p In db.DiscussionThreads Where p.ParentID = lblThreadID.Text Select p

            rlvItems.DataSource = data
            rlvItems.DataBind()

        End If

    End Sub

End Class