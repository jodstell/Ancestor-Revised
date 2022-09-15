Imports System.Data.SqlClient
Imports System.IO
Imports Microsoft.AspNet.Identity

Public Class results
    Inherits System.Web.UI.Page
    Dim ContactEmail As String
    Dim TestName As String
    Dim HostName As String
    Dim Address As String
    Dim City As String
    Dim State As String
    Dim Zip As String
    Dim Phone As String
    Dim CellPhone As String
    Dim DOB As String
    Dim EmailAddress As String
    Dim SSN As String
    Dim Terminal As String

    Dim test As String

    Dim score As Integer
    Dim result As String

    Dim db As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.QueryString("SessionID") = "" Or Nothing Then
            Response.Redirect("/")

        End If

        Dim body As HtmlGenericControl = DirectCast(Master.FindControl("master_body"), HtmlGenericControl)
        body.Attributes.Add("onload", "noBack();")
        body.Attributes.Add("onunload", "")
        body.Attributes.Add("onpageshow", "if (event.persisted) noBack();")


        If Not Page.IsPostBack Then

            Dim q = From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID")
            For Each p In q
                Me.HF_SessionID.Value = p.SessionID
                Me.HF_QuizID.Value = p.QuizID
                Me.HF_Question.Value = ""
                Me.HF_UserName.Value = p.UserName
                Me.HF_SiteID.Value = p.SiteID
            Next


            'check is time has expired
            Dim Status As String = Request.QueryString("Status")
            If Status = "TimeOut" Then
                StatusLabel.Text = "Your time limit for this test has expired"
            End If

            test = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.TestID).FirstOrDefault

            QuizTitle.Text = (From p In db.Tests Where p.TestID = test Select p.Title).FirstOrDefault

            'grade the test
            Dim available_points = (From p In db.Questions Where p.TestID = test Select p.Points).Sum
            Dim earned_points = (From p In db.AnswerLists Where p.TestSessionID = Request.QueryString("SessionID") Select p.EarnedPoints).Sum
            Dim passing_grade = (From p In db.Tests Where p.TestID = test Select p.PassingGrade).FirstOrDefault

            Dim elap_time = FormatTime((From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.RunningTime).FirstOrDefault)

            Dim questions = (From p In db.AnswerLists Where p.TestSessionID = Request.QueryString("SessionID") Select p).Count
            Dim correct = (From p In db.AnswerLists Where p.TestSessionID = Request.QueryString("SessionID") And p.Result = "Correct" Select p).Count

            Grade.Text = String.Format("{0}%", passing_grade)

            ElapTime.Text = elap_time

            PointsAvailableText.Text = available_points.ToString()
            PointsEarnedText.Text = earned_points.ToString()

            NumberCorrect.Text = correct
            NumberQuestions.Text = questions

            score = earned_points / available_points * 100

            If score >= passing_grade Then
                result = "Passed"
                ResultsLabel.Text = "<h1><span class='label label-success'>Passed " & String.Format("{0:#%}", earned_points / available_points) & "</span></h1>"
            Else
                result = "Failed"
                ResultsLabel.Text = "<h1><span class='label label-danger'>Failed " & String.Format("{0:#%}", earned_points / available_points) & "</span></h1>"
            End If

            'show or hide results
            Dim show_Results = (From p In db.Tests Where p.TestID = test Select p.ShowResults).FirstOrDefault
            If show_Results = "False" Then
                resultGrid.Visible = False
                answerDetails.Visible = False
                ResultsPanel.Visible = False
                TestHistoryGrid.Visible = False
            End If

            'populate resultgrid
            Dim al As New DataTable
            al = GetDataTable()

            If al Is Nothing Then
                Response.Redirect("/dashboard")
            End If


            TestHistoryGrid.DataSource = al
            TestHistoryGrid.DataBind()

            'checking that the test has not been scored already
            Dim r = (From p In db.TestScores Where p.TestSessionID = Request.QueryString("SessionID") Select p.Result).FirstOrDefault
            If r = "Passed" Or r = "Failed" Then
                'do nothing
            Else

                'add event to activity log
                '    Common.InsertActivityLog("Test Completed", TestName, HF_UserName.Value, HF_SiteID.Value, Request.UserHostAddress)

                'get the number of times the test has been taken


                Dim c = (From p In db.TestScores Where p.ID = test And p.UserName = HF_UserName.Value Select p).Count

                'Save results
                Dim testresult = (From p In db.TestScores Where p.TestSessionID = Request.QueryString("SessionID") Select p).FirstOrDefault

                testresult.DateTimeCompleted = DateTime.Now.ToString()
                testresult.Score = score
                testresult.Result = result

                If c = 1 Then
                    testresult.RetakeTestHrs = (From p In db.Tests Where p.TestID = test Select p.RetakeHours1).FirstOrDefault
                End If

                If c = 2 Then
                    testresult.RetakeTestHrs = (From p In db.Tests Where p.TestID = test Select p.RetakeHours2).FirstOrDefault
                End If

                If c = 3 Then
                    testresult.RetakeTestHrs = (From p In db.Tests Where p.TestID = test Select p.RetakeHours3).FirstOrDefault
                End If

                If c > 3 Then
                    testresult.RetakeTestHrs = (From p In db.Tests Where p.TestID = test Select p.RetakeHours3).FirstOrDefault
                End If

                testresult.TotalElapTime = (From p In db.TestSessions Where p.SessionID = Request.QueryString("SessionID") Select p.RunningTime).FirstOrDefault

                db.SubmitChanges()

                'send email alert
                If result = "Passed" Then

                    StatusLabel.Text = (From p In db.Tests Where p.TestID = test Select p.CompletedText).FirstOrDefault
                    SendEmail(score, "Passed")


                    Dim _testID = (From i In db.TestSessions Where i.SessionID = Request.QueryString("SessionID") Select i.TestID).FirstOrDefault
                    Dim _courseID = (From w In db.Tests Where w.TestID = _testID Select w.CourseID).FirstOrDefault


                    ' Dim id = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CourseID).FirstOrDefault

                    Dim InCourseID As String = (From p In db.StudentsInCourses Where p.CourseID = _courseID And p.UserName = Context.User.Identity.Name
                                                Select p.StudentInCourseID).FirstOrDefault


                    Dim result As New CurriculumResult With {.CurriculumID = Session("CurrentCurriculumID"),
                                                                .DateCompleted = Date.Now(),
                                                                .StudentInCourseID = InCourseID,
                                                                .UserName = Context.User.Identity.Name,
                                                                .Completed = True}

                    db.CurriculumResults.InsertOnSubmit(result)
                    db.SubmitChanges()


                End If

                If result = "Failed" Then
                    StatusLabel.Text = (From p In db.Tests Where p.TestID = test Select p.FailedText).FirstOrDefault

                    If c = 1 Then
                        RetakeLabel.Text = (From p In db.Tests Where p.TestID = test Select p.RetakeText1).FirstOrDefault
                    End If
                    If c = 2 Then
                        RetakeLabel.Text = (From p In db.Tests Where p.TestID = test Select p.RetakeText2).FirstOrDefault
                    End If
                    If c = 3 Then
                        RetakeLabel.Text = (From p In db.Tests Where p.TestID = test Select p.RetakeText3).FirstOrDefault
                    End If

                    If c > 3 Then
                        RetakeLabel.Text = (From p In db.Tests Where p.TestID = test Select p.RetakeText3).FirstOrDefault
                    End If

                    SendEmail(score, "Failed")
                End If

            End If

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

    'Protected Sub resultGrid_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles resultGrid.SelectedIndexChanged
    '    GetAnswerList.FilterExpression = "QuestionOrder=" & resultGrid.SelectedValue.ToString()
    'End Sub

    Public Function GetDataTable() As DataTable

        Dim query As String = "getAnswerListBySessionID"

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("LMSConnection").ConnectionString
        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()
        adapter.SelectCommand = New SqlCommand(query, conn)

        adapter.SelectCommand.CommandType = CommandType.StoredProcedure

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@sessionID", SqlDbType.NVarChar))
        adapter.SelectCommand.Parameters("@sessionID").Value = Request.QueryString("SessionID")

        Dim myDataTable As New DataTable()

        conn.Open()
        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function
    Private Function PopulateArrayList() As ArrayList
        Dim aList As ArrayList = New ArrayList
        Dim query As String = "SELECT QuizID, QuestionID, CorrectAnswer, UserAnswer, CASE WHEN CorrectAnswer = UserAnswer THEN 'Correct' ELSE 'Incorrect' END AS Result FROM AnswerList WHERE (TestSessionID = @TestSessionID)"

        Dim myConnection As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("LMSConnection").ToString())

        Dim myCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(query, myConnection)
        myCommand.Parameters.AddWithValue("@TestSessionID", Request.QueryString("SessionID"))

        Dim dr As System.Data.SqlClient.SqlDataReader = Nothing
        Try
            myConnection.Open()
            dr = myCommand.ExecuteReader
            While dr.Read
                Dim a As Answer = New Answer()
                a.QuestionID = dr("QuestionID").ToString()
                a.CorrectAnswer = dr("CorrectAnswer").ToString()
                a.UserAnswer = dr("UserAnswer").ToString()
                aList.Add(a)

            End While
        Finally
            dr.Close()
            myCommand.Dispose()
            myConnection.Close()
        End Try
        Return aList
    End Function

    Protected Sub BtnContinue_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnContinue.Click

        Dim _testID = (From i In db.TestSessions Where i.SessionID = Request.QueryString("SessionID") Select i.TestID).FirstOrDefault
        Dim _courseID = (From w In db.Tests Where w.TestID = _testID Select w.CourseID).FirstOrDefault


        ' Dim id = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CourseID).FirstOrDefault

        'Dim InCourseID As String = (From p In db.StudentsInCourses Where p.CourseID = _courseID And p.UserName = Context.User.Identity.Name
        '                            Select p.StudentInCourseID).FirstOrDefault


        'Dim result As New CurriculumResult With {.CurriculumID = Session("CurrentCurriculumID"),
        '                                            .DateCompleted = Date.Now(),
        '                                            .StudentInCourseID = InCourseID,
        '                                            .Completed = True}

        'db.CurriculumResults.InsertOnSubmit(result)
        'db.SubmitChanges()


        If ValidatePage() = True Then
            Response.Redirect("/application/classroom/lessonplan?CourseID=" & _courseID)
        Else
            Response.Redirect("/dashboard")
        End If

    End Sub

    Protected Sub SendEmail(ByVal d As Double, ByVal result As String)

        If User.Identity.IsAuthenticated Then

            ' Dim CompanyName As String

            HostName = ""


            'get and populate userinfo    
            Dim student = From p In db.Applicants Where p.dbGUID = User.Identity.Name Select p
            For Each p In student
                Address = p.Address
                City = p.City
                State = p.State
                Zip = p.Zip
                Phone = p.Phone
                CellPhone = p.CellPhone
                DOB = p.DOB
                EmailAddress = p.EmailAddress
                SSN = p.SSN

            Next




            'send email
            Dim reader As New StreamReader(Server.MapPath("~/Files/TestCompleted.html"))
            Dim readFile As String = reader.ReadToEnd()
            Dim myString As String = ""
            myString = readFile
            myString = myString.Replace("$$FullName$$", Common.GetFullName(Context.User.Identity.GetUserId()))
            myString = myString.Replace("$$TestName$$", (From p In db.Tests Where p.TestID = test Select p.Title).FirstOrDefault)
            myString = myString.Replace("$$DateCompleted$$", Date.Now())

            myString = myString.Replace("$$UserName$$", Common.GetFullName(Context.User.Identity.GetUserName()))
            myString = myString.Replace("$$City$$", City)
            myString = myString.Replace("$$State$$", State)
            myString = myString.Replace("$$Zip$$", Zip)

            myString = myString.Replace("$$Score$$", score)
            myString = myString.Replace("$$Result$$", result)
            myString = myString.Replace("$$URL_Link$$", "http://events.gigengyn.com/Ambassadors/ViewTestResults?ID=" & Request.QueryString("SessionID"))

            'get instructor
            Dim instructor = (From p In db.Tests Where p.TestID = test Select p.InstructorID).FirstOrDefault
            'get instructor email
            Dim recipient = "no-reply@gigengyn.com" '(From p In db.Instructors Where p.InstructorID = instructor Select p.InstructorEmail).FirstOrDefault

            'send email
            MailHelper.SendMailMessage(recipient, "A test has been completed on Baretc Event Manager", myString)
        End If

    End Sub

    Function GetFullName() As String

        Dim q = From p In db.Applicants Where p.dbGUID = User.Identity.Name Select p
        For Each p In q
            Return String.Format("{0} {1}", p.FirstName, p.LastName)
        Next
#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths

    Function ValidatePage() As Boolean
        Dim host As String = "GigEngyn"

        'Dim db As New DataClassesDataContext
        'Dim q = From p In db.Sites Where p.Host = host Select p

        'For Each p In q
        '    Return True
        'Next

        Return True

    End Function

End Class