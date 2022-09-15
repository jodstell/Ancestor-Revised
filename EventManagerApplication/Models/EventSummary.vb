Public Class EventSummary

    Private _title As String
    Public Property Title() As String
        Get
            Return _title
        End Get
        Set(ByVal value As String)
            _title = value
        End Set
    End Property

    Private _total As Integer
    Public Property Total() As Integer
        Get
            Return _total
        End Get
        Set(ByVal value As Integer)
            _total = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(title As String, total As Integer)

        Me.Title = title
        Me.Total = total

    End Sub

End Class
