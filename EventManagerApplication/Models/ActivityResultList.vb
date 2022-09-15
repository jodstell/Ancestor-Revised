Public Class ActivityResultList

    Private _id As Integer
    Public Property ID() As Integer
        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property

    Private _activityID As Integer
    Public Property ActivityID() As Integer
        Get
            Return _activityID
        End Get
        Set(ByVal value As Integer)
            _activityID = value
        End Set
    End Property

    Private _result As String
    Public Property Result() As String
        Get
            Return _result
        End Get
        Set(ByVal value As String)
            _result = value
        End Set
    End Property

    Private _count As Integer
    Public Property Count() As Integer
        Get
            Return _count
        End Get
        Set(ByVal value As Integer)
            _count = value
        End Set
    End Property

    Private _percent As Integer
    Public Property Percent() As Integer
        Get
            Return _percent
        End Get
        Set(ByVal value As Integer)
            _percent = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(ByVal id As Integer, ByVal activityID As Integer, ByVal result As String, ByVal count As Integer, percent As Integer)

        Me.ID = id
        Me.ActivityID = activityID
        Me.Result = result
        Me.Count = count
        Me.Percent = percent
    End Sub


End Class
