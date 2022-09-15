Imports Telerik.Web.UI

Public Class Test2
    Inherits System.Web.UI.Page

    Public Property StartTime As TimeSpan
    Public Property EndTime As TimeSpan

    Dim _testID As String

    Dim correctAnswer As String
    Dim QuestionID As Integer
    Dim QuestionType As Integer

    Shared CorrectCount As Integer
    Shared SelectedCount As Integer
    Shared TargetCount As Integer

    Shared questionNumber As Integer

    Dim db1 As New LMSDataClassesDataContext


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        BindAnswerButtons()

    End Sub

    Public Sub BindAnswerButtons()

       ' HiddenUserAnswer.Text = 0

        _testID = (From p In db1.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.TestID).FirstOrDefault

        questionNumber = (From p In db1.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.CurrentQuestionID).FirstOrDefault

        Dim result = (From p In db1.Questions Where p.TestID = _testID And p.QuestionOrder = questionNumber Select p).FirstOrDefault

        correctAnswer = "BtnAnswer" & result.CorrectAnswer
        QuestionID = result.QuestionID
        QuestionType = Convert.ToInt32(result.QuestionType)

        TotalQuestionsLabel.Text = (From r In db1.Questions Where r.TestID = _testID Select r).Count
        TestTitleLabel.Text = (From p In db1.Tests Where p.TestID = _testID Select p.Title).FirstOrDefault


        Dim q1 = From p In db1.TestSessions Where p.SessionID = Request.QueryString("SessionID")
        For Each p In q1
            Me.HF_SessionID.Value = p.SessionID
            Me.HF_QuizID.Value = p.QuizID
            Me.HF_Question.Value = questionNumber
            Me.HF_UserName.Value = p.UserName
            Me.HF_SiteID.Value = p.SiteID
        Next


        Dim q2 = (From p In db1.Questions Where p.TestID = _testID And p.QuestionOrder = questionNumber Select p).FirstOrDefault

        QuestionNumberLabel.Text = q2.QuestionOrder
        QuestionLabel.Text = q2.Title
        BtnAnswer1.Text = If((q2.Answer1 Is Nothing), "", "A) " & q2.Answer1)
        BtnAnswer2.Text = If((q2.Answer2 Is Nothing), "", "B) " & q2.Answer2)
        BtnAnswer3.Text = If((q2.Answer3 Is Nothing), "", "C) " & q2.Answer3)
        BtnAnswer4.Text = If((q2.Answer4 Is Nothing), "", "D) " & q2.Answer4)
        BtnAnswer5.Text = If((q2.Answer5 Is Nothing), "", "E) " & q2.Answer5)
        BtnAnswer6.Text = If((q2.Answer6 Is Nothing), "", "F) " & q2.Answer6)
        ' correctAnswer = q.CorrectAnswer

        If q2.Answer1 Is Nothing Or q2.Answer1 = "" Then
            BtnAnswer1.Visible = False
        End If

        If q2.Answer2 Is Nothing Or q2.Answer2 = "" Then
            BtnAnswer2.Visible = False
        End If

        If q2.Answer3 Is Nothing Or q2.Answer3 = "" Then
            BtnAnswer3.Visible = False
        End If

        If q2.Answer4 Is Nothing Or q2.Answer4 = "" Then
            BtnAnswer4.Visible = False
        End If

        If q2.Answer5 Is Nothing Or q2.Answer5 = "" Then
            BtnAnswer5.Visible = False
        End If

        If q2.Answer6 Is Nothing Or q2.Answer6 = "" Then
            BtnAnswer6.Visible = False
        End If

        If TotalQuestionsLabel.Text = QuestionNumberLabel.Text Then
            buttonNext_med.Text = "Finish >>"
        End If

        Select Case q2.QuestionType
            Case 1
                SelectLabel.Text = "Select Answer"
            Case 2
                SelectLabel.Text = "Select Answer"
            Case 3
                SelectLabel.Text = "Choose all that apply"
        End Select


    End Sub

    Protected Sub GetResult_Click(sender As Object, e As EventArgs)

        Select Case QuestionType
            Case 1
                resetAllButtons()
                enableAllButtons()

                Dim button As Button = DirectCast(sender, Button)
                Dim buttonId As String = button.ID

                HiddenUserAnswer.Text = CleanID(buttonId)

                If correctAnswer = buttonId Then

                    formatSuccessButton(buttonId)

                    ResultLabel.ForeColor = Drawing.Color.Green
                    ResultLabel.Text = "1" '"Yes! That is correct."
                    PassedLabel.Text = "Correct"
                    'buttonNext_sm.Visible = True
                    ' buttonNext_med.Visible = True

                    'disableAllButtons()
                Else
                    formatSuccessButton(buttonId)

                    ' button.Enabled = False

                    ResultLabel.ForeColor = Drawing.Color.Green
                    ResultLabel.Text = "0" '"Sorry, that is not correct.  Try again."
                    PassedLabel.Text = "Incorrect"

                    'buttonNext_sm.Visible = False
                    'buttonNext_med.Visible = False
                End If
            Case 2
                resetAllButtons()
                enableAllButtons()

                Dim button As Button = DirectCast(sender, Button)
                Dim buttonId As String = button.ID

                HiddenUserAnswer.Text = CleanID(buttonId)

                If correctAnswer = buttonId Then

                    formatSuccessButton(buttonId)

                    ResultLabel.ForeColor = Drawing.Color.Green
                    ResultLabel.Text = "1" '"Yes! That is correct."
                    PassedLabel.Text = "Correct"
                    'buttonNext_sm.Visible = True
                    ' buttonNext_med.Visible = True

                    'disableAllButtons()
                Else
                    formatSuccessButton(buttonId)

                    ' button.Enabled = False

                    ResultLabel.ForeColor = Drawing.Color.Green
                    ResultLabel.Text = "0" '"Sorry, that is not correct.  Try again."
                    PassedLabel.Text = "Incorrect"

                    'buttonNext_sm.Visible = False
                    'buttonNext_med.Visible = False
                End If

            Case 3

                HiddenUserAnswer.Text = 0

                'Dim TargetCount As Integer = (From p In db1.Questions Where p.TestID = Request.QueryString("TestID") And p.QuestionOrder = Request.QueryString("P") Select p.Points).FirstOrDefault

                Dim button As Button = DirectCast(sender, Button)
                Dim buttonId As String = button.ID

                TargetCount = (From p In db1.Questions Where p.TestID = _testID And p.QuestionOrder = questionNumber Select p.Points).FirstOrDefault

                Dim result = (From p In db1.CorrectAnswers Where p.QuestionID = QuestionID And p.CorrectAnswer = Convert.ToInt32(CleanID(buttonId)) Select p).Count

                If result > 0 Then
                    If button.CssClass = "btn btn-lg btn-success btn-block rbDecorated" Then
                        button.CssClass = "btn btn-lg btn-default btn-block rbDecorated"

                        SelectedCount += -1
                        CorrectCount += -1
                    Else
                        button.CssClass = "btn btn-lg btn-success btn-block rbDecorated"

                        SelectedCount += 1
                        CorrectCount += 1

                    End If

                    ' button.Enabled = False



                    ' ResultLabel.Text = CorrectCount
                    ResultLabel.ForeColor = Drawing.Color.Green

                    TargetPoints.Text = TargetCount & " target points"
                    ResultLabel.Text = CorrectCount  '"Yes! That is correct.  Please select " & TargetCount - CorrectCount & " more."
                    PointsLabel.Text = SelectedCount & " selected buttons"

                    If CorrectCount = TargetCount Then
                        ResultLabel.ForeColor = Drawing.Color.Green

                        TargetPoints.Text = TargetCount & " target points"
                        ResultLabel.Text = CorrectCount
                        PointsLabel.Text = SelectedCount & " selected buttons"

                        'passed

                        ' buttonNext_sm.Visible = True
                        ' buttonNext_med.Visible = True

                        'disableAllButtons()
                    End If

                Else


                    If button.CssClass = "btn btn-lg btn-success btn-block rbDecorated" Then
                        button.CssClass = "btn btn-lg btn-default btn-block rbDecorated"

                        SelectedCount += -1

                    Else
                        button.CssClass = "btn btn-lg btn-success btn-block rbDecorated"

                        SelectedCount += 1


                    End If

                    ResultLabel.ForeColor = Drawing.Color.Green
                    TargetPoints.Text = TargetCount & " target points"
                    ResultLabel.Text = CorrectCount  '"Sorry, that is not correct.  Try again."
                    PointsLabel.Text = SelectedCount & " selected buttons"


                    ' buttonNext_sm.Visible = False
                    ' buttonNext_med.Visible = False
                End If

                If TargetCount = CorrectCount And SelectedCount = TargetCount Then
                    PassedLabel.Text = "Correct"
                Else
                    PassedLabel.Text = "Incorrect"
                End If

        End Select

    End Sub


    Protected Sub Next_Click(sender As Object, e As EventArgs)

        If TotalQuestionsLabel.Text = QuestionNumberLabel.Text Then

        End If

        'clear the correct count.
        CorrectCount = 0
        TargetCount = 0
        SelectedCount = 0

        'get and set timer value
        EndTime = StartTime.Add(New TimeSpan(DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second))

        Dim t1 As String() = EndTime.ToString.Split(":"c)

        Dim hours As Integer = Convert.ToInt32(t1(0))
        Dim minutes As Integer = Convert.ToInt32(t1(1))
        Dim seconds As Integer = Convert.ToInt32(t1(2))

        Dim sHours As Integer = hours * (3600)
        Dim sMinutes As Integer = minutes * (60)
        Dim sSeconds As Integer = seconds
        Dim tSeconds As Integer = sHours + sMinutes + sSeconds


        ' Insert or Update Answer
        ' SaveAnswer()

        Dim answer = db1.UpdateSavedAnswerList(Request.QueryString("SessionID"), questionNumber, Convert.ToInt32(HiddenUserAnswer.Text), PassedLabel.Text, HiddenUserAnswer.Text, Convert.ToInt32(ResultLabel.Text))


        Dim NextQuestionNumber As Integer = Convert.ToInt32(questionNumber) + 1

        If NextQuestionNumber - 1 = TotalQuestionsLabel.Text Then
            ' Go to evaluate answers
            Response.Redirect("/ResultsSummary.aspx?QuizID=" & Request.QueryString("QuizID") & "&GUID=" & Request.QueryString("GUID") & "&SiteID=" & Request.QueryString("SiteID") & "&SessionID=" & Request.QueryString("SessionID") & "&Status=Success")
        Else

            'Update TestSession
            Dim s = (From p In db1.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p).FirstOrDefault
            s.CurrentQuestionID = NextQuestionNumber
            s.RunningTime = s.RunningTime + EndTime.Seconds
            db1.SubmitChanges()

            resetAllButtons()
            BtnAnswer1.Visible = True
            BtnAnswer2.Visible = True
            BtnAnswer3.Visible = True
            BtnAnswer4.Visible = True
            BtnAnswer5.Visible = True
            BtnAnswer6.Visible = True

            BindAnswerButtons()

            ' Response.Redirect("/training/pages/test?SessionID=" & Request.QueryString("SessionID") & "&Question=" & NextQuestionNumber)
        End If


    End Sub




    Public Function CurrentQuestionNumber() As String

        Dim i = questionNumber

        Dim o = (From r In db1.Questions Where r.TestID = _testID Select r).Count

        Return i / o * 100

    End Function

    Function CurrentTotalNumber() As String
        Dim i = questionNumber

        Dim o = (From r In db1.Questions Where r.TestID = _testID Select r).Count

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

    Sub enableAllButtons()
        BtnAnswer1.Enabled = True
        BtnAnswer2.Enabled = True
        BtnAnswer3.Enabled = True
        BtnAnswer4.Enabled = True
        BtnAnswer5.Enabled = True
        BtnAnswer6.Enabled = True
    End Sub

    Sub resetAllButtons()
        BtnAnswer1.CssClass = "btn btn-lg btn-default btn-block rbDecorated"
        BtnAnswer2.CssClass = "btn btn-lg btn-default btn-block rbDecorated"
        BtnAnswer3.CssClass = "btn btn-lg btn-default btn-block rbDecorated"
        BtnAnswer4.CssClass = "btn btn-lg btn-default btn-block rbDecorated"
        BtnAnswer5.CssClass = "btn btn-lg btn-default btn-block rbDecorated"
        BtnAnswer6.CssClass = "btn btn-lg btn-default btn-block rbDecorated"
    End Sub

    Sub formatSuccessButton(id)

        Select Case id
            Case "BtnAnswer1"
                BtnAnswer1.CssClass = "btn btn-lg btn-success btn-block rbDecorated"
            Case "BtnAnswer2"
                BtnAnswer2.CssClass = "btn btn-lg btn-success btn-block rbDecorated"
            Case "BtnAnswer3"
                BtnAnswer3.CssClass = "btn btn-lg btn-success btn-block rbDecorated"
            Case "BtnAnswer4"
                BtnAnswer4.CssClass = "btn btn-lg btn-success btn-block rbDecorated"
            Case "BtnAnswer5"
                BtnAnswer5.CssClass = "btn btn-lg btn-success btn-block rbDecorated"
            Case "BtnAnswer6"
                BtnAnswer6.CssClass = "btn btn-lg btn-success btn-block rbDecorated"
        End Select
    End Sub

    Sub formatDangerButton(id)

        Select Case id
            Case "BtnAnswer1"
                BtnAnswer1.CssClass = "btn btn-lg btn-danger btn-block rbDecorated"
            Case "BtnAnswer2"
                BtnAnswer2.CssClass = "btn btn-lg btn-danger btn-block rbDecorated"
            Case "BtnAnswer3"
                BtnAnswer3.CssClass = "btn btn-lg btn-danger btn-block rbDecorated"
            Case "BtnAnswer4"
                BtnAnswer4.CssClass = "btn btn-lg btn-danger btn-block rbDecorated"
            Case "BtnAnswer5"
                BtnAnswer5.CssClass = "btn btn-lg btn-danger btn-block rbDecorated"
            Case "BtnAnswer6"
                BtnAnswer6.CssClass = "btn btn-lg btn-danger btn-block rbDecorated"
        End Select
    End Sub

    Private Sub btnQuit_Click(sender As Object, e As EventArgs) Handles btnQuit.Click

        Try
            'delete current sessionID from test
            Dim cn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection
            cn.ConnectionString = ConfigurationManager.ConnectionStrings("LMSConnection").ToString()
            Dim cmd As System.Data.SqlClient.SqlCommand = cn.CreateCommand
            cmd.CommandType = System.Data.CommandType.StoredProcedure
            cmd.CommandText = "QuitTest"
            cmd.Parameters.AddWithValue("@SessionID", Request.QueryString("SessionID"))
            cmd.Parameters.AddWithValue("@DateTimeCompleted", Date.Now())



            cn.Open()
            'get result from stored procedure
            cmd.ExecuteNonQuery()

            'add event to activity log
            '    Common.InsertActivityLog("Test Cancelled", "", "", "", Request.UserHostAddress)

            'Response.Redirect("/ambassadors/dashboard")

            cn.Close()
        Catch ex As Exception
            ' Response.Write(ex.Message)
        Finally

        End Try


        Dim _testID = (From i In db1.TestSessions Where i.SessionID = Request.QueryString("SessionID") Select i.TestID).FirstOrDefault
        Dim _courseID = (From w In db1.Tests Where w.TestID = _testID Select w.CourseID).FirstOrDefault

        Response.Redirect("/application/classroom/lessonplan?CourseID=" & _courseID)


    End Sub
End Class