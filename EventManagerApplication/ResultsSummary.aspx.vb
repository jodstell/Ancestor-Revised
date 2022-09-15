Public Class ResultsSummary
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("SessionID") = "" Or Nothing Then
            Response.Redirect("/")

        End If

        If Request.QueryString("Status") = "TimeOut" Then

            Response.Redirect("/Timeout?SessionID?" & Request.QueryString("SessionID"))

        End If


        ' TestTitleLabel
        Dim testID = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.QuizID).FirstOrDefault

        TestTitleLabel.Text = (From p In db.Tests Where p.QuizID = testID Select p.Title).FirstOrDefault


        Dim dv2 As New System.Data.DataView
        dv2 = Me.getBlankAnswers.Select(DataSourceSelectArguments.Empty)

        If dv2.Count = 0 Then
            Response.Redirect("results.aspx?SessionID=" & Request.QueryString("SessionID") & "&Status=Success")

        Else

            StatusLabel.Visible = False
        End If
    End Sub

    Protected Sub ScoreTest_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("results.aspx?QuizID=" & Request.QueryString("QuizID") & "&GUID=" & Request.QueryString("GUID") & "&SiteID=" & Request.QueryString("SiteID") & "&SessionID=" & Request.QueryString("SessionID") & "&Status=Success")
    End Sub
End Class