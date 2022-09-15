Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.Reflection
Imports System.Threading
Imports System.Globalization

Public Class Dashboard3
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext

    Protected Overrides Sub InitializeCulture()

        'Set the UICulture and the Culture with a value stored in a Session-object. I called mine “MyCulture”
        Thread.CurrentThread.CurrentUICulture = New CultureInfo(Session("MyCulture").ToString)
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(Session("MyCulture").ToString)
    End Sub

    Private Sub Classroom_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        Page.Title = "Classroom | " & getCourseName()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'validate student is in course
        'get current user
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Dim q = From p In db.StudentsInCourses
                Where p.UserName = currentUser.UserName.ToString() And p.CourseID = Request.QueryString("CourseID")
                Select p

        '  If q.Count = 0 Then Response.Redirect("noaccess")


        CourseDescriptionHolder.Controls.Add(New LiteralControl(GetCourseDescription(Request.QueryString("CourseID"))))
        CourseSyllabusHolder.Controls.Add(New LiteralControl(GetCourseSyllabus(Request.QueryString("CourseID"))))
        CourseDates.Controls.Add(New LiteralControl(FormatCourseDates(Request.QueryString("CourseID"))))

        ' lblCourseTitle.Text = getCourseName(Request.QueryString("CourseID"))

        If Not Page.IsPostBack Then
            bindAnnouncements()
            bindTopRow()
            bindBottomRow()

            Dim showSupportPanel = (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.EnableSideBarSupport).FirstOrDefault
            SupportPanel.Visible = showSupportPanel

            Dim showClassAnnouncementsControl = (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.EnableSideBarAnnouncements).FirstOrDefault
            ClassAnnouncementsControl1.Visible = showClassAnnouncementsControl
        End If

    End Sub

    Function getCourseName() As String
        Return (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.CourseTitle).FirstOrDefault
    End Function

    Function GetTabName(ByVal id As Integer) As String

        Dim siteid As String = GetSiteID()
        Return (From p In db.DashboardTabs Where p.SiteID = siteid And p.TabID = id Select p.ToolBarTitle).FirstOrDefault

    End Function

    Function GetSiteID() As String

        Return "GigEngyn"

    End Function

    Sub bindTopRow()

        Dim q = From p In db.CourseWidgets Where p.CourseID = Request.QueryString("CourseID") And p.Dashboard = True And p.Enabled = True Order By p.Order Take 3 Select p Order By p.Order

        Row1Dashboard.DataSource = q
        Row1Dashboard.DataBind()
    End Sub

    Sub bindBottomRow()

        Dim q = From p In db.CourseWidgets Where p.CourseID = Request.QueryString("CourseID") And p.Dashboard = True And p.Enabled = True Order By p.Order Skip 3 Take 4 Select p

        Row2Dashboard.DataSource = q
        Row2Dashboard.DataBind()
    End Sub

    Sub bindAnnouncements()

        Dim q = From p In db.CourseAnnouncements
                Where p.StartDate < Date.Now And p.EndDate > Date.Now And p.CourseID = Request.QueryString("CourseID")
                Select p

        AnnouncementsList.DataSource = q
        AnnouncementsList.DataBind()

    End Sub

    Function getIcon(ByVal name As String) As String
        Return (From p In db.Icons Where p.IconName = name Select p.IconDetail).FirstOrDefault

    End Function

    Function FormatCourseDates(ByVal id As String) As String

        Dim s = (From p In db.Courses Where p.CourseID = id Select p.StartDate).FirstOrDefault
        Dim e = (From p In db.Courses Where p.CourseID = id Select p.EndDate).FirstOrDefault

        If s.ToString() = "" Then
            'do nothing
        Else

            Dim w = Resources.Resource.CourseDatesLabel

            Return String.Format("<div class='panel panel-default'><div class='panel-body'><h4><i class='fa fa-calendar'></i>&nbsp;" & Resources.Resource.CourseDatesLabel & "</h4><table><tr><td valign='top'>" & Resources.Resource.StartLabel & ":&nbsp;&nbsp;</td><td>{0:D}</td></tr><tr><td valign='top'>" & Resources.Resource.EndLabel & ":&nbsp;</td><td>{1:D}</td></tr></table></div></div>", s, e)
        End If

    End Function

    Function GetCourseDescription(ByVal id As String) As String
        Return (From p In db.Courses Where p.CourseID = id Select p.Description).FirstOrDefault
    End Function

    Function GetCourseSyllabus(ByVal id As String) As String

        Return (From p In db.Courses Where p.CourseID = id Select p.Syllabus).FirstOrDefault
    End Function

    Private Sub AnnouncementsList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles AnnouncementsList.ItemDataBound
        If AnnouncementsList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If

    End Sub


End Class