Public Class EventImportList

    Private _id As Integer
    Public Property ID() As Integer
        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property

    Private _eventName As String
    Public Property EventName() As String
        Get
            Return _eventName
        End Get
        Set(ByVal value As String)
            _eventName = value
        End Set
    End Property

    Private _vpid As Integer
    Public Property Vpid() As Integer
        Get
            Return _vpid
        End Get
        Set(ByVal value As Integer)
            _vpid = value
        End Set
    End Property



End Class
