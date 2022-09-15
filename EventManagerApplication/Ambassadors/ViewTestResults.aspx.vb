Public Class ViewTestResults
    Inherits System.Web.UI.Page

    Dim db As New LMSDataClassesDataContext
    Dim db1 As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        HF_UserName.Value = (From p In db.TestResults Where p.TestSessionID = Request.QueryString("ID") Select p.UserName).FirstOrDefault
        HF_UserID.Value = (From p In db1.tblProfiles Where p.userName = HF_UserName.Value Select p.userID).FirstOrDefault

    End Sub

    Function getStudentName() As String
        Try
            Dim _testSessionID = Request.QueryString("ID")
            Dim _userName = (From p In db.TestResults Where p.TestSessionID = _testSessionID Select p.UserName).FirstOrDefault
            Dim _firstName = (From p In db1.tblProfiles Where p.userName = _userName Select p.firstName).FirstOrDefault
            Dim _lastName = (From p In db1.tblProfiles Where p.userName = _userName Select p.lastName).FirstOrDefault

            Return String.Format("{0} {1}", _firstName, _lastName)
        Catch ex As Exception
            Return "Error"
        End Try

    End Function

    Function getUserID() As String

        Try
            Dim _testSessionID = Request.QueryString("ID")
            Dim _userName = (From p In db.TestResults Where p.TestSessionID = _testSessionID Select p.UserName).FirstOrDefault

            Return String.Format("{0}", (From p In db1.tblProfiles Where p.userName = _userName Select p.userID).FirstOrDefault)
        Catch ex As Exception
            Return "Error"
        End Try

    End Function

    Function getCourseID() As String
        Try
            Dim _testID = (From p In db.TestScores Where p.TestSessionID = Request.QueryString("ID") Select p.TestID).FirstOrDefault
            Return (From p In db.Tests Where p.QuizID = _testID Select p.CourseID).FirstOrDefault
        Catch ex As Exception
            Return "Error"
        End Try
    End Function

    Function getTestName() As String
        Dim _testID = (From p In db.TestScores Where p.TestSessionID = Request.QueryString("ID") Select p.TestID).FirstOrDefault
        Return (From p In db.Tests Where p.QuizID = _testID Select p.Title).FirstOrDefault
    End Function

    Function getTestScore() As String
        Try
            Dim _testSessionID = Request.QueryString("ID")
            Return (From p In db.TestResults Where p.TestSessionID = _testSessionID Select p.Score).FirstOrDefault
        Catch ex As Exception
            Return "Error"
        End Try

    End Function

    Function getTestResult() As String
        Try
            Dim _testSessionID = Request.QueryString("ID")
            Return (From p In db.TestResults Where p.TestSessionID = _testSessionID Select p.Result).FirstOrDefault
        Catch ex As Exception
            Return "Error"
        End Try

    End Function

    Function getPassingScore() As String
        Try
            Dim _testID = (From p In db.TestScores Where p.TestSessionID = Request.QueryString("ID") Select p.TestID).FirstOrDefault
            Return (From p In db.Tests Where p.QuizID = _testID Select p.PassingGrade).FirstOrDefault
        Catch ex As Exception
            Return "Error"
        End Try

    End Function

    Function getTestDate() As String
        Try
            Dim _testSessionID = Request.QueryString("ID")
            Dim datecompleted As Date = (From p In db.TestResults Where p.TestSessionID = _testSessionID Select p.DateTimeCompleted).FirstOrDefault

            Return Common.GetTimeAdjustment(datecompleted)

        Catch ex As Exception
            Return "Error"
        End Try

    End Function

    Function getTestTime() As String
        Try
            Dim _testSessionID = Request.QueryString("ID")
            ' Return (From p In db.TotalTimeOnTests Where p.TestSessionID = _testSessionID Select p.TimeOnTest).FirstOrDefault
        Catch ex As Exception
            Return "Error"
        End Try

    End Function

    Function getTotalQuestions() As String

        Return (From p In db.AnswerLists Where p.TestSessionID = Request.QueryString("ID") Select p).Count

    End Function

    Function getTotalCorrect() As String

        Return (From p In db.AnswerLists Where p.TestSessionID = Request.QueryString("ID") And p.CorrectAnswer = p.UserAnswer Select p).Count

    End Function

    Function getTotalIncorrect() As String

        Return (From p In db.AnswerLists Where p.TestSessionID = Request.QueryString("ID") And p.CorrectAnswer <> p.UserAnswer Select p).Count

    End Function

    Function getImage(ByVal UserAnswer As Integer, ByVal CorrectAnswer As Integer, ByVal AnswerNumber As Integer)
        If UserAnswer = CorrectAnswer And CorrectAnswer = AnswerNumber Then
            Return "/images/grncheck.gif"
        End If

        If UserAnswer <> CorrectAnswer And UserAnswer = AnswerNumber Then
            Return "/images/redx.gif"
        End If

        Return "/images/1x1.gif"
    End Function

    Function getResultBadge(ByVal result) As String

        Try
            Select Case result
                Case "Passed"
                    Return "label label-success pull-right"
                Case "Failed"
                    Return "label label-primary pull-right"
                Case "Cancelled"
                    Return "label label-default pull-right"
            End Select
        Catch ex As Exception
            Return "Error"
        End Try


    End Function

End Class