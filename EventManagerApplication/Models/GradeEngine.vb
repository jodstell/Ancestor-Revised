Public Class GradeEngine

    Shared Function ScoreQuestion_PointsEarned(ByVal questionID As Integer, ByVal testID As String, ByVal userAnswer As Integer) As Integer
        Dim db As New LMSDataClassesDataContext

        Dim q = (From p In db.Questions Where p.TestID = testID And p.QuestionOrder = questionID Select p).FirstOrDefault

        If q.CorrectAnswer = userAnswer Then
            Return q.Points
        End If

        Return 0

    End Function

    Shared Function ScoreQuestion_PointsEarned_FillIn(ByVal questionID As Integer, ByVal testID As String, ByVal userAnswer As String) As Integer
        Dim db As New LMSDataClassesDataContext

        Dim q = (From p In db.Questions Where p.TestID = testID And p.QuestionOrder = questionID Select p).FirstOrDefault

        If q.AnswerText.ToLower() = userAnswer.ToLower() Then
            Return q.Points
        End If

        Return 0

    End Function

End Class
