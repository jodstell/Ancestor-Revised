Public Class ClassAnnouncementsControl
    Inherits System.Web.UI.UserControl
    Dim db As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            bindAnnouncements()
        End If
    End Sub

    Sub bindAnnouncements()

        Dim q = From p In db.CourseAnnouncements
                Where p.StartDate < Date.Now And p.EndDate > Date.Now And p.CourseID = Request.QueryString("CourseID")
                Select p

        AnnouncementsList.DataSource = q
        AnnouncementsList.DataBind()

    End Sub

    Private Sub AnnouncementsList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles AnnouncementsList.ItemCommand
        If e.CommandName = "OpenAnnouncement" Then
            ' Me.Label1.Text = "Hello World"
        End If
    End Sub

    Private Sub AnnouncementsList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles AnnouncementsList.ItemDataBound
        If AnnouncementsList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If

    End Sub

End Class