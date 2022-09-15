Public Class ClassRoomNavBar
    Inherits System.Web.UI.UserControl
    Dim db As New LMSDataClassesDataContext
    Dim pageTitle As String
    Dim pageName As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            bindLeftNavBar()
        End If

        pageName = System.IO.Path.GetFileName(Request.Url.ToString())
        pageTitle = pageName.Substring(0, pageName.IndexOf("?"))

    End Sub

    Function GetWidgetName() As String
        Return (From p In db.CourseWidgets Where p.WidgetName = pageTitle And p.CourseID = Request.QueryString("CourseID") Select p.Title).FirstOrDefault
    End Function

    Sub bindLeftNavBar()

        Dim q = From p In db.CourseWidgets Where p.CourseID = Request.QueryString("CourseID") And p.LeftNav = True And p.Enabled = True Order By p.Order Select p

        LeftNavBar.DataSource = q
        LeftNavBar.DataBind()


        Repeater1.DataSource = q
        Repeater1.DataBind()


        LeftNavBarComboBox.DataSource = q
        LeftNavBarComboBox.DataTextField = "Title"
        LeftNavBarComboBox.DataValueField = "CourseID"

        LeftNavBarComboBox.DataBind()




    End Sub

    Function getIcon(ByVal name As String) As String
        Return (From p In db.Icons Where p.IconName = name Select p.IconDetail).FirstOrDefault

    End Function

End Class