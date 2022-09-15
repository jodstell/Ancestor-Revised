Public Class TestResults

    Private _userName As String
    Public Property UserName() As String
        Get
            Return _userName
        End Get
        Set(ByVal value As String)
            _userName = value
        End Set
    End Property

    Public Sub New()
    End Sub

    Public Sub New(ByVal username As String)
        Me.UserName = username
    End Sub

End Class
