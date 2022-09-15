Public Class Answer
    Private m_QuestionID As String
    Private m_CorrectAnswer As String
    Private m_UserAnswer As String
    Private m_Result As String

    Public Property QuestionID() As String
        Get
            Return m_QuestionID
        End Get
        Set(ByVal value As String)
            m_QuestionID = value
        End Set
    End Property

    Public Property CorrectAnswer() As String
        Get
            Return m_CorrectAnswer
        End Get
        Set(ByVal value As String)
            m_CorrectAnswer = value
        End Set
    End Property

    Public Property UserAnswer() As String
        Get
            Return m_UserAnswer
        End Get
        Set(ByVal value As String)
            m_UserAnswer = value
        End Set
    End Property

    Public ReadOnly Property Result() As ResultValue
        Get
            If m_UserAnswer = m_CorrectAnswer Then
                Return ResultValue.Correct
            Else
                Return ResultValue.Incorrect
            End If
        End Get
    End Property

    Public Enum ResultValue
        Correct
        Incorrect
    End Enum

End Class
