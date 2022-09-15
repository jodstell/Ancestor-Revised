Public Class Questions
    Inherits System.Web.UI.Page
    Dim TimeLimit As Integer
    ' Dim StartTime As Date
    Dim myStartDate As DateTime
    Dim NextQuestionNumber As Integer
    Dim PreviousQuestionNumber As Integer
    Dim CorrectAnswer As Integer
    Dim _testID As String

    Public Property StartTime As TimeSpan
    Public Property EndTime As TimeSpan



    Dim db As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.QueryString("SessionID") = "" Or Nothing Then
            Response.Redirect("/")

        End If

        Dim body As HtmlGenericControl = DirectCast(Master.FindControl("master_body"), HtmlGenericControl)
        body.Attributes.Add("onload", "noBack();")
        body.Attributes.Add("onunload", "")
        body.Attributes.Add("onpageshow", "if (event.persisted) noBack();")

        _testID = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.TestID).FirstOrDefault

        ' check the timer
        Dim _timelimit = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.TimeLimit).FirstOrDefault
        Dim _elaptime = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.RunningTime).FirstOrDefault

        If _elaptime > _timelimit Then
            'ran out of time
            Response.Redirect("ResultsSummary.aspx?SessionID=" & Request.QueryString("SessionID") & "&Status=TimeOut")
        End If

        If Not Page.IsPostBack Then
            'get the remaining time
            TxtRemainingSeconds.Value = _timelimit - _elaptime

            'get a new time span for the counter
            ' hid_Ticker = New TimeSpan(0, 0, 0).ToString()

            ' internalize the Timespan objects
            StartTime = New TimeSpan(DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second)
            ' calc end time from start time
            EndTime = StartTime.Add(New TimeSpan(0, 0, 0))

        End If

        Dim q = From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID")
        For Each p In q
            Me.HF_SessionID.Value = p.SessionID
            Me.HF_QuizID.Value = p.QuizID
            Me.HF_Question.Value = Request.QueryString("Question")
            Me.HF_UserName.Value = p.UserName
            Me.HF_SiteID.Value = p.SiteID
        Next

        '   Me.HF_Points.Value = (From p In db.Questions Where p.QuestionID Where p.QuestionID = Request.QueryString("QuestionID") Select p.Points).FirstOrDefault

        LoadQuestion() 'Load Question
        LoadTest() ' Load Test Details
        GetSavedAnswer() ' Populate Answer from Database

        If NextQuestionNumber = TotalQuestionsLabel.Text + 1 Then
            buttonNext.Text = "Score Test"
        End If





    End Sub

    Public Function CurrentQuestionNumber() As String

        Dim i = Request.QueryString("Question")

        Dim s = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.TestID).FirstOrDefault
        Dim o = (From r In db.Questions Where r.TestID = s Select r).Count


        Return i / o * 100

    End Function

    Function CurrentTotalNumber() As String
        Dim i = Request.QueryString("Question")

        Dim s = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.TestID).FirstOrDefault
        Dim o = (From r In db.Questions Where r.TestID = s Select r).Count

        Dim l = i / o * 100

        Return String.Format("width: {0}%", l)


    End Function

    Private Sub LoadQuestion()
        ' Load Question from Datasource
        Dim s = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.TestID).FirstOrDefault
        Dim q = (From p In db.Questions Where p.TestID = _testID And p.QuestionOrder = Request.QueryString("Question") Select p).FirstOrDefault

        Dim qv As New System.Data.DataView
        qv = Me.getQuestionDetails.Select(DataSourceSelectArguments.Empty)

        QuestionNumberLabel.Text = q.QuestionOrder
        QuestionLabel.Text = q.Title
        RadioButton1.Text = "&nbsp; 1) " & q.Answer1
        RadioButton2.Text = "&nbsp; 2) " & q.Answer2
        RadioButton3.Text = "&nbsp; 3) " & q.Answer3
        RadioButton4.Text = "&nbsp; 4) " & q.Answer4
        RadioButton5.Text = "&nbsp; 5) " & q.Answer5
        RadioButton6.Text = "&nbsp; 6) " & q.Answer6
        CorrectAnswer = q.CorrectAnswer

        ' Image1.ImageUrl = "Handler.ashx?Size=O&PhotoID=" & qv(0)(10)


        If q.Answer1.ToString() = "" Then
            RadioButton1.Visible = False
        End If

        If q.Answer2.ToString() = "" Then
            RadioButton2.Visible = False
        End If

        If q.Answer3.ToString() = "" Then
            RadioButton3.Visible = False
        End If

        If q.Answer4.ToString() = "" Then
            RadioButton4.Visible = False
        End If

        If qv(0)(7).ToString() = "" Then
            RadioButton5.Visible = False
        End If

        If qv(0)(8).ToString() = "" Then
            RadioButton6.Visible = False
        End If

        Dim qType = (From p In db.Questions Where p.TestID = _testID And p.QuestionOrder = Request.QueryString("Question") Select p.QuestionType).FirstOrDefault

        If qType = "3" Then
            TxtFillPanel.Visible = True
            TxtFillIn.Visible = True
            RadioPanel.Visible = False
        End If

        ' TxtFillIn

        ' Assign Next Question Number
        NextQuestionNumber = qv(0)(1) + 1

        ' Assign Previous Question Number
        PreviousQuestionNumber = qv(0)(1) - 1

    End Sub
    Private Sub LoadTest()
        Dim s = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.TestID).FirstOrDefault
        TestTitleLabel.Text = (From p In db.Tests Where p.TestID = s Select p.Title).FirstOrDefault

        TotalQuestionsLabel.Text = (From r In db.Questions Where r.TestID = s Select r).Count

    End Sub

    Private Sub GetSavedAnswer()
        If Page.IsPostBack = False Then
            Try
                Dim sd As SqlDataSource = New SqlDataSource
                sd.ConnectionString = ConfigurationManager.ConnectionStrings("LMSConnection").ToString()

                sd.SelectCommand = "SELECT COALESCE (UserAnswer, 0) AS Expr1 FROM AnswerList WHERE (TestSessionID = @TestSessionID) AND (QuizID = @QuizID) AND (QuestionID = @QuestionID)"

                sd.SelectParameters.Add("TestSessionID", Request.QueryString("SessionID"))
                sd.SelectParameters.Add("QuizID", HF_QuizID.Value)
                sd.SelectParameters.Add("QuestionID", Request.QueryString("Question"))

                Dim vd As New System.Data.DataView
                vd = sd.Select(DataSourceSelectArguments.Empty)

                If vd.Count > 0 Then
                    SavedAnswer.Text = vd(0)(0)
                    Select Case vd(0)(0)
                        Case 1
                            Me.RadioButton1.Checked = True
                        Case 2
                            Me.RadioButton2.Checked = True
                        Case 3
                            Me.RadioButton3.Checked = True
                        Case 4
                            Me.RadioButton4.Checked = True
                        Case 5
                            Me.RadioButton5.Checked = True
                        Case 6
                            Me.RadioButton6.Checked = True
                    End Select
                End If
            Catch ex As Exception
                ' Response.Write("saved answer: " & ex.Message)
            End Try
        End If



    End Sub

    Protected Sub buttonNext_Click(ByVal sender As Object, ByVal e As System.EventArgs)

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
        SaveAnswer()

        ' Go to next Question
        If NextQuestionNumber - 1 = TotalQuestionsLabel.Text Then
            ' Go to evaluate answers
            Response.Redirect("ResultsSummary.aspx?QuizID=" & Request.QueryString("QuizID") & "&GUID=" & Request.QueryString("GUID") & "&SiteID=" & Request.QueryString("SiteID") & "&SessionID=" & Request.QueryString("SessionID") & "&Status=Success")
        Else

            'Update TestSession
            Dim s = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p).FirstOrDefault
            s.CurrentQuestionID = NextQuestionNumber
            s.RunningTime = s.RunningTime + EndTime.Seconds
            db.SubmitChanges()


            Response.Redirect("Questions?SessionID=" & Request.QueryString("SessionID") & "&Question=" & NextQuestionNumber)
        End If



    End Sub

    Function FormatTime(TimeElapsed As Integer) As String
        Dim Seconds As Integer
        Dim Minutes As Integer
        Dim Hours As Integer

        'Find The Seconds
        Seconds = TimeElapsed Mod 60

        'Find The Minutes
        Minutes = (TimeElapsed \ 60) Mod 60

        'Find The Hours
        Hours = (TimeElapsed \ 3600)

        'Format The Time
        If Hours > 0 Then
            FormatTime = Format(Hours, "00") & ":"
        End If
        FormatTime = Format(Hours, "00") & ":"
        FormatTime = FormatTime & Format(Minutes, "00") & ":"
        FormatTime = FormatTime & Format(Seconds, "00")
    End Function

    Protected Sub PreviousQuestion_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim GUID As String = Request.QueryString("GUID")
        Dim QuizID As String = Request.QueryString("QuizID")
        Dim SiteID As String = Request.QueryString("SiteID")
        Dim SessionID As String = Request.QueryString("SessionID")

        If PreviousQuestionNumber = 0 Then
            PreviousQuestionNumber = 1
            UserMsgBox("There are no previous questions")
        Else
            'get and set timer value

            'get and set timer value

            EndTime = StartTime.Add(New TimeSpan(DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second))

            Dim t1 As String() = EndTime.ToString.Split(":"c)

            ' Dim t1 As String() = hid_Ticker.Split(":"c)

            Dim hours As Integer = Convert.ToInt32(t1(0))
            Dim minutes As Integer = Convert.ToInt32(t1(1))
            Dim seconds As Integer = Convert.ToInt32(t1(2))

            Dim sHours As Integer = hours * (3600)
            Dim sMinutes As Integer = minutes * (60)
            Dim sSeconds As Integer = seconds
            Dim tSeconds As Integer = sHours + sMinutes + sSeconds

            'Update TestSession
            Dim s = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p).FirstOrDefault
            s.CurrentQuestionID = PreviousQuestionNumber
            s.RunningTime = s.RunningTime + EndTime.Seconds
            db.SubmitChanges()

            Response.Redirect("Questions?SessionID=" & SessionID & "&Question=" & PreviousQuestionNumber)
        End If

    End Sub

    Private Sub SaveAnswer()

        If RadioButton1.Checked Then
            HiddenUserAnswer.Text = 1
        ElseIf RadioButton2.Checked Then
            HiddenUserAnswer.Text = 2
        ElseIf RadioButton3.Checked Then
            HiddenUserAnswer.Text = 3
        ElseIf RadioButton4.Checked Then
            HiddenUserAnswer.Text = 4
        ElseIf RadioButton5.Checked Then
            HiddenUserAnswer.Text = 5
        ElseIf RadioButton6.Checked Then
            HiddenUserAnswer.Text = 6
        Else
            HiddenUserAnswer.Text = 0
        End If

        Dim qType = (From p In db.Questions Where p.TestID = _testID And p.QuestionOrder = Request.QueryString("Question") Select p.QuestionType).FirstOrDefault

        If qType = "1" Then

            Dim points = GradeEngine.ScoreQuestion_PointsEarned(Request.QueryString("Question"), _testID, HiddenUserAnswer.Text)
            Dim result As String

            'Request.QueryString("QuestionID"), _testID, HiddenUserAnswer.Text
            If points > 0 Then result = "Correct" Else result = "Incorrect"

            ' Save Answer to database
            Dim answer = db.UpdateAnswerList1(Request.QueryString("SessionID"), HF_QuizID.Value, HF_Question.Value, CorrectAnswer, HiddenUserAnswer.Text.ToString(), points, result, TxtFillIn.Text)


        End If

        If qType = "2" Then

            Dim points = GradeEngine.ScoreQuestion_PointsEarned(Request.QueryString("Question"), _testID, HiddenUserAnswer.Text)
            Dim result As String

            'Request.QueryString("QuestionID"), _testID, HiddenUserAnswer.Text
            If points > 0 Then result = "Correct" Else result = "Incorrect"

            ' Save Answer to database
            Dim answer = db.UpdateAnswerList1(Request.QueryString("SessionID"), HF_QuizID.Value, HF_Question.Value, CorrectAnswer, HiddenUserAnswer.Text.ToString(), points, result, TxtFillIn.Text)


        End If

        If qType = "3" Then

            Dim points = GradeEngine.ScoreQuestion_PointsEarned_FillIn(Request.QueryString("Question"), _testID, TxtFillIn.Text)
            Dim result As String


            'Request.QueryString("QuestionID"), _testID, HiddenUserAnswer.Text
            If points > 0 Then result = "Correct" Else result = "Incorrect"
            If points > 0 Then HiddenUserAnswer.Text = 1

            ' Save Answer to database
            Dim answer = db.UpdateAnswerList1(Request.QueryString("SessionID"), HF_QuizID.Value, HF_Question.Value, CorrectAnswer, HiddenUserAnswer.Text.ToString(), points, result, TxtFillIn.Text)

        End If




    End Sub

    Public Sub UserMsgBox(ByVal sMsg As String)

        Dim sb As New StringBuilder()
        Dim oFormObject As System.Web.UI.Control

        sMsg = sMsg.Replace("'", "\'")
        sMsg = sMsg.Replace(Chr(34), "\" & Chr(34))
        sMsg = sMsg.Replace(vbCrLf, "\n")
        sMsg = "<script language=javascript>confirm(""" & sMsg & """)</script>"

        sb = New StringBuilder()
        sb.Append(sMsg)

        For Each oFormObject In Me.Controls
            If TypeOf oFormObject Is HtmlForm Then
                Exit For
            End If
        Next

        ' Add the javascript after the form object so that the 
        ' message doesn't appear on a blank screen.
#Disable Warning BC42104 ' Variable is used before it has been assigned a value
        oFormObject.Controls.AddAt(oFormObject.Controls.Count, New LiteralControl(sb.ToString()))
#Enable Warning BC42104 ' Variable is used before it has been assigned a value


    End Sub

    Protected Sub cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'delete current sessionID from test
        Dim cn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection
        cn.ConnectionString = ConfigurationManager.ConnectionStrings("LMSConnection").ToString()
        Dim cmd As System.Data.SqlClient.SqlCommand = cn.CreateCommand
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.CommandText = "QuitTest"
        cmd.Parameters.AddWithValue("@SessionID", Request.QueryString("SessionID"))
        cmd.Parameters.AddWithValue("@DateTimeCompleted", Date.Now())


        Try
            cn.Open()
            'get result from stored procedure
            cmd.ExecuteNonQuery()

            'add event to activity log
            '    Common.InsertActivityLog("Test Cancelled", "", "", "", Request.UserHostAddress)

            Response.Redirect("/ambassadors/dashboard")
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            cn.Close()
        End Try

    End Sub

    Protected Sub ScoreTest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ScoreTest.Click
        SaveAnswer()
        Response.Redirect("ResultsSummary.aspx?QuizID=" & Request.QueryString("QuizID") & "&GUID=" & Request.QueryString("GUID") & "&SiteID=" & Request.QueryString("SiteID") & "&SessionID=" & Request.QueryString("SessionID") & "&Status=Success")
    End Sub



    'Private Sub Timer1_Tick(sender As Object, e As EventArgs) Handles Timer1.Tick
    '    hid_Ticker = TimeSpan.Parse(hid_Ticker).Add(New TimeSpan(0, 0, 1)).ToString()
    '    ' lit_Timer.Text = "Time spent on this question: " + hid_Ticker.Value.ToString()




    'End Sub

End Class