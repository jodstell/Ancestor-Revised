Public Class Test1
    Inherits System.Web.UI.Page

    Dim correctAnswer As String
    Dim QuestionID As Integer
    Dim QuestionType As Integer

    Shared CorrectCount As Integer

    Dim db1 As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim result = (From p In db1.Questions Where p.TestID = Request.QueryString("TestID") And p.QuestionOrder = Request.QueryString("P") Select p).FirstOrDefault

        correctAnswer = "BtnAnswer" & result.CorrectAnswer
        QuestionID = result.QuestionID
        QuestionType = Convert.ToInt32(result.QuestionType)

        TotalQuestionsLabel.Text = (From r In db1.Questions Where r.TestID = Request.QueryString("TestID") Select r).Count
        TestTitleLabel.Text = (From p In db1.Tests Where p.TestID = Request.QueryString("TestID") Select p.Title).FirstOrDefault


        'BtnAnswer1.Text = result.Answer1

        'TargetCount = result.Points

        BindAnswerButtons()

    End Sub

    Sub BindAnswerButtons()
        Dim q = (From p In db1.Questions Where p.TestID = Request.QueryString("TestID") And p.QuestionOrder = Request.QueryString("P") Select p).FirstOrDefault

        QuestionNumberLabel.Text = q.QuestionOrder
        QuestionLabel.Text = q.Title
        BtnAnswer1.Text = If((q.Answer1 Is Nothing), "", q.Answer1)
        BtnAnswer2.Text = If((q.Answer2 Is Nothing), "", q.Answer2)
        BtnAnswer3.Text = If((q.Answer3 Is Nothing), "", q.Answer3)
        BtnAnswer4.Text = If((q.Answer4 Is Nothing), "", q.Answer4)
        BtnAnswer5.Text = If((q.Answer5 Is Nothing), "", q.Answer5)
        BtnAnswer6.Text = If((q.Answer6 Is Nothing), "", q.Answer6)
        ' correctAnswer = q.CorrectAnswer

        If q.Answer1 Is Nothing Or q.Answer1 = "" Then
            BtnAnswer1.Visible = False
        End If

        If q.Answer2 Is Nothing Or q.Answer2 = "" Then
            BtnAnswer2.Visible = False
        End If

        If q.Answer3 Is Nothing Or q.Answer3 = "" Then
            BtnAnswer3.Visible = False
        End If

        If q.Answer4 Is Nothing Or q.Answer4 = "" Then
            BtnAnswer4.Visible = False
        End If

        If q.Answer5 Is Nothing Or q.Answer5 = "" Then
            BtnAnswer5.Visible = False
        End If

        If q.Answer6 Is Nothing Or q.Answer6 = "" Then
            BtnAnswer6.Visible = False
        End If

        If TotalQuestionsLabel.Text = QuestionNumberLabel.Text Then
            buttonNext_med.Text = "Finish >>"
        End If

    End Sub

    Protected Sub GetResult_Click(sender As Object, e As EventArgs)

        Select Case QuestionType
            Case 1
                resetAllButtons()

                Dim button As Button = DirectCast(sender, Button)
                Dim buttonId As String = button.ID

                If correctAnswer = buttonId Then

                    formatSuccessButton(buttonId)

                    ResultLabel.ForeColor = Drawing.Color.Green
                    ResultLabel.Text = "Yes! That is correct."
                    buttonNext_sm.Visible = True
                    buttonNext_med.Visible = True

                    disableAllButtons()
                Else
                    formatDangerButton(buttonId)

                    button.Enabled = False

                    ResultLabel.ForeColor = Drawing.Color.Red
                    ResultLabel.Text = "Sorry, that is not correct.  Try again."
                    buttonNext_sm.Visible = False
                    buttonNext_med.Visible = False
                End If
            Case 2
                resetAllButtons()

                Dim button As Button = DirectCast(sender, Button)
                Dim buttonId As String = button.ID

                If correctAnswer = buttonId Then

                    formatSuccessButton(buttonId)

                    ResultLabel.ForeColor = Drawing.Color.Green
                    ResultLabel.Text = "Yes! That is correct."
                    buttonNext_sm.Visible = True
                    buttonNext_med.Visible = True

                    disableAllButtons()
                Else
                    formatDangerButton(buttonId)

                    button.Enabled = False

                    ResultLabel.ForeColor = Drawing.Color.Red
                    ResultLabel.Text = "Sorry, that is not correct.  Try again."
                    buttonNext_sm.Visible = False
                    buttonNext_med.Visible = False
                End If

            Case 3

                Dim TargetCount As Integer = (From p In db1.Questions Where p.TestID = Request.QueryString("TestID") And p.QuestionOrder = Request.QueryString("P") Select p.Points).FirstOrDefault

                Dim button As Button = DirectCast(sender, Button)
                Dim buttonId As String = button.ID

                Dim result = (From p In db1.CorrectAnswers Where p.QuestionID = QuestionID And p.CorrectAnswer = Convert.ToInt32(CleanID(buttonId)) Select p).Count

                If result > 0 Then
                    button.CssClass = "btn btn-lg btn-success btn-block"
                    button.Enabled = False

                    CorrectCount += 1

                    ' ResultLabel.Text = CorrectCount
                    ResultLabel.ForeColor = Drawing.Color.Green
                    ResultLabel.Text = "Yes! That is correct.  Please select " & TargetCount - CorrectCount & " more."

                    If CorrectCount = TargetCount Then
                        ResultLabel.ForeColor = Drawing.Color.Green
                        ResultLabel.Text = "Yes! That is correct."
                        buttonNext_sm.Visible = True
                        buttonNext_med.Visible = True

                        disableAllButtons()
                    End If

                Else

                    button.Enabled = False

                    ResultLabel.ForeColor = Drawing.Color.Red
                    ResultLabel.Text = "Sorry, that is not correct.  Try again."
                    buttonNext_sm.Visible = False
                    buttonNext_med.Visible = False
                End If

        End Select

    End Sub


    Protected Sub Next_Click(sender As Object, e As EventArgs)

        If TotalQuestionsLabel.Text = QuestionNumberLabel.Text Then

        End If

        'clear the correct count.
        CorrectCount = 0

        Dim NextQuestionNumber As Integer = Convert.ToInt32(Request.QueryString("P")) + 1

        Response.Redirect("/training/test?TestID=" & Request.QueryString("TestID") & "&P=" & NextQuestionNumber)

    End Sub

    Public Function CurrentQuestionNumber() As String

        Dim i = Request.QueryString("P")

        Dim o = (From r In db1.Questions Where r.TestID = Request.QueryString("TestID") Select r).Count

        Return i / o * 100

    End Function

    Function CurrentTotalNumber() As String
        Dim i = Request.QueryString("P")

        Dim o = (From r In db1.Questions Where r.TestID = Request.QueryString("TestID") Select r).Count

        Dim l = i / o * 100

        Return String.Format("width: {0}%", l)


    End Function

    Function CleanID(id As String) As String
        Select Case id
            Case "BtnAnswer1"
                Return "1"
            Case "BtnAnswer2"
                Return "2"
            Case "BtnAnswer3"
                Return "3"
            Case "BtnAnswer4"
                Return "4"
            Case "BtnAnswer5"
                Return "5"
            Case "BtnAnswer6"
                Return "6"
            Case Else
                Return ""
        End Select

    End Function

    Sub disableAllButtons()
        BtnAnswer1.Enabled = False
        BtnAnswer2.Enabled = False
        BtnAnswer3.Enabled = False
        BtnAnswer4.Enabled = False
        BtnAnswer5.Enabled = False
        BtnAnswer6.Enabled = False
    End Sub

    Sub resetAllButtons()
        BtnAnswer1.CssClass = "btn btn-lg btn-default btn-block"
        BtnAnswer2.CssClass = "btn btn-lg btn-default btn-block"
        BtnAnswer3.CssClass = "btn btn-lg btn-default btn-block"
        BtnAnswer4.CssClass = "btn btn-lg btn-default btn-block"
        BtnAnswer5.CssClass = "btn btn-lg btn-default btn-block"
        BtnAnswer6.CssClass = "btn btn-lg btn-default btn-block"
    End Sub

    Sub formatSuccessButton(id)

        Select Case id
            Case "BtnAnswer1"
                BtnAnswer1.CssClass = "btn btn-lg btn-success btn-block"
            Case "BtnAnswer2"
                BtnAnswer2.CssClass = "btn btn-lg btn-success btn-block"
            Case "BtnAnswer3"
                BtnAnswer3.CssClass = "btn btn-lg btn-success btn-block"
            Case "BtnAnswer4"
                BtnAnswer4.CssClass = "btn btn-lg btn-success btn-block"
        End Select
    End Sub

    Sub formatDangerButton(id)

        Select Case id
            Case "BtnAnswer1"
                BtnAnswer1.CssClass = "btn btn-lg btn-danger btn-block"
            Case "BtnAnswer2"
                BtnAnswer2.CssClass = "btn btn-lg btn-danger btn-block"
            Case "BtnAnswer3"
                BtnAnswer3.CssClass = "btn btn-lg btn-danger btn-block"
            Case "BtnAnswer4"
                BtnAnswer4.CssClass = "btn btn-lg btn-danger btn-block"
        End Select
    End Sub

End Class