Public Class ValidUserList


    Private _userName As String
    Public Property UserName() As String
        Get
            Return _userName
        End Get
        Set(ByVal value As String)
            _userName = value
        End Set
    End Property

    Private _isValid As Integer
    Public Property IsValid() As Integer
        Get
            Return _isValid
        End Get
        Set(ByVal value As Integer)
            _isValid = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(username As String, isvalid As Integer)

        Me.UserName = username
        Me.IsValid = isvalid

    End Sub
End Class
