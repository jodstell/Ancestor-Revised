Imports System.IO
Imports Microsoft.AspNet.Identity

Public Class Start
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'disable back button
        'Dim body As HtmlGenericControl = DirectCast(Master.FindControl("master_body"), HtmlGenericControl)
        'body.Attributes.Add("onload", "noBack();")
        'body.Attributes.Add("onunload", "")
        'body.Attributes.Add("onpageshow", "if (event.persisted) noBack();")

        If Request.QueryString("id") = "" Or Nothing Then
            Response.Redirect("/")

        End If

        AgreementText.Text = GetTestAgreement()
    End Sub

    Protected Function GetTestAgreement() As String
        Dim id As String = Request.QueryString("id")
        Dim q = From p In db.Tests Where p.TestID = id Select p
        For Each p In q
            Return p.AgreementPage
        Next

        Return "There was an error retrieving the test for id " & id
    End Function

    Protected Function GetTestName() As String
        Dim id As String = Request.QueryString("id")
        Dim q = From p In db.Tests Where p.TestID = id Select p
        For Each p In q
            Return p.Title
        Next

        Return "There was an error retrieving the test for id " & id
    End Function

    Protected Function GetPassingGrade() As String
        Dim id As String = Request.QueryString("id")
        Dim q = From p In db.Tests Where p.TestID = id Select p
        For Each p In q
            Return p.PassingGrade.ToString()
        Next

        Return "There was an error retrieving the test for id " & id
    End Function

    Protected Function GetTimeLimit() As String
        Dim id As String = Request.QueryString("id")
        Dim q = From p In db.Tests Where p.TestID = id Select p
        For Each p In q
            Return p.TimeLimit.ToString()
        Next

        Return "There was an error retrieving the test for id " & id
    End Function

    Protected Function GetTotalQuestions() As String
        Dim id As String = Request.QueryString("id")
        Dim q = (From p In db.Questions Where p.TestID = id Select p).Count

        Return q
    End Function

    Protected Function GetRetakeHours() As String
        Dim id As String = Request.QueryString("id")
        Dim q = (From p In db.Tests Where p.TestID = id Select p.RetakeHours1).FirstOrDefault

        Return q
    End Function


    Private Sub StartButton_Click(sender As Object, e As EventArgs) Handles StartButton.Click

        Dim TestSessionID As String = System.Guid.NewGuid().ToString()
        Dim UserName As String
        Dim SiteID As String
        Dim _quizID = (From p In db.Tests Where p.TestID = Request.QueryString("ID") Select p.QuizID).FirstOrDefault

        If User.Identity.IsAuthenticated Then
            UserName = User.Identity.Name
            SiteID = GetSiteID()
        Else
            UserName = "Demo"
            SiteID = "Demo"
        End If

        Dim newsession = New TestSession With {.SessionID = TestSessionID,
                                               .StartDate = Date.Now(),
                                               .TestID = Request.QueryString("id"),
                                               .QuizID = _quizID,
                                               .IPAddress = Request.UserHostAddress,
                                               .UserName = UserName,
                                               .CurrentQuestionID = 1,
                                               .SiteID = SiteID,
                                               .TimeLimit = GetTimeLimit() * 60,
                                               .RunningTime = 0}
        db.TestSessions.InsertOnSubmit(newsession)
        db.SubmitChanges()


        'Create New Test Result without Score
        Dim newtest = New TestScore With {.TestSessionID = TestSessionID,
                                          .ID = Request.QueryString("id"),
                                          .TestID = _quizID,
                                          .UserName = UserName,
                                          .Terminal = Request.UserHostAddress,
                                          .Result = "Incomplete",
                                          .PassingGrade = GetPassingGrade(),
                                          .RetakeTestHrs = GetRetakeHours(),
                                          .StartTime = Date.Now.ToString()}
        db.TestScores.InsertOnSubmit(newtest)
        db.SubmitChanges()

        'Insert no value Answers for Test
        Dim starttest = db.StartTest(TestSessionID)
        db.SubmitChanges()

        'add event to activity log
        '  Common.InsertActivityLog("Test Started", GetTestName(), UserName, GetSiteID(), Request.UserHostAddress)

        If User.Identity.IsAuthenticated Then
            'send email
            Dim reader As New StreamReader(Server.MapPath("~/Files/TestStarted.html"))
            Dim readFile As String = reader.ReadToEnd()
            Dim myString As String = ""
            myString = readFile
            myString = myString.Replace("$$FullName$$", Common.GetFullName(Context.User.Identity.GetUserId()))
            myString = myString.Replace("$$UserName$$", Common.GetFullName(Context.User.Identity.GetUserName()))
            myString = myString.Replace("$$TestName$$", (From p In db.Tests Where p.TestID = Request.QueryString("id") Select p.Title).FirstOrDefault)
            myString = myString.Replace("$$StartDate$$", Date.Now())

            'get instructor
            Dim instructor = (From p In db.Tests Where p.TestID = Request.QueryString("id") Select p.InstructorID).FirstOrDefault
            'get instructor email
            Dim recipient = "no-reply@gigengyn.com"   ' (From p In db.Instructors Where p.InstructorID = instructor Select p.InstructorEmail).FirstOrDefault

            'send email
            MailHelper.SendMailMessage(recipient, "New test started on Baretc Event Manager", myString)
        End If

        Response.Redirect("/training/pages/test?SessionID=" & TestSessionID)
        ' Response.Redirect("/Questions?SessionID=" & TestSessionID & "&Question=1")

    End Sub

    Function GetSiteID() As String

        Dim host As String = "congitiiv"

        'Try
        '    Dim q = From p In db.Sites Where p.Host = host Select p

        '    For Each p In q
        '        Return (p.SiteID)
        '    Next
        'Catch ex As Exception

        'End Try

        Return host

    End Function

    'Function ValidatePage() As Boolean

    '    'Dim host As String = Request.Url.Host.ToLower

    '    'Dim db As New DataClassesDataContext
    '    'Dim q = From p In db.Sites Where p.Host = host Select p

    '    'For Each p In q
    '    '    Return True
    '    'Next

    '    'Return False

    'End Function

End Class