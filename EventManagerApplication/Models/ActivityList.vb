Public Class ActivityList

    Private _activityID As Integer
    Public Property ActivityID() As Integer
        Get
            Return _activityID
        End Get
        Set(ByVal value As Integer)
            _activityID = value
        End Set
    End Property

    Private _activityName As String
    Public Property ActivityName() As String
        Get
            Return _activityName
        End Get
        Set(ByVal value As String)
            _activityName = value
        End Set
    End Property

    Private _sortOrder As Integer
    Public Property SortOrder() As Integer
        Get
            Return _sortOrder
        End Get
        Set(ByVal value As Integer)
            _sortOrder = value
        End Set
    End Property

    Private _type As String
    Public Property Type() As String
        Get
            Return _type
        End Get
        Set(ByVal value As String)
            _type = value
        End Set
    End Property

    'Public Sub New()

    'End Sub

    Public Sub New(ByVal activityID As Integer, ByVal activityName As String, ByVal sortOrder As Integer, ByVal type As String)

        Me.ActivityID = activityID
        Me.ActivityName = activityName
        Me.SortOrder = sortOrder
        Me.Type = type
    End Sub

End Class
