Public Class ViewTestQuestions
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        TestTitleLabel.Text = (From p In db.Tests Where p.TestID = Request.QueryString("TestID") Select p.Title).FirstOrDefault

        PassingGradeLabel.Text = GetPassingGrade()
        TotalQuestionsLabel.Text = GetTotalQuestions()
        TimeLimitLabel.Text = GetTimeLimit()



    End Sub

    Protected Function GetPassingGrade() As String
        Dim id As String = Request.QueryString("TestID")
        Dim q = From p In db.Tests Where p.TestID = id Select p
        For Each p In q
            Return p.PassingGrade.ToString()
        Next

        Return "There was an error retrieving the test for id " & id
    End Function

    Protected Function GetTimeLimit() As String
        Dim id As String = Request.QueryString("TestID")
        Dim q = From p In db.Tests Where p.TestID = id Select p
        For Each p In q
            Return p.TimeLimit.ToString()
        Next

        Return "There was an error retrieving the test for id " & id
    End Function

    Protected Function GetTotalQuestions() As String
        Dim id As String = Request.QueryString("TestID")
        Dim q = (From p In db.Questions Where p.TestID = id Select p).Count

        Return q
    End Function
End Class