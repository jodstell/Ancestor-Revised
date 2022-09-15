Public Class ImportEvent

    Private _eventName As String
    Public Property EventName() As String
        Get
            Return _eventName
        End Get
        Set(ByVal value As String)
            _eventName = value
        End Set
    End Property

    Private _eventDate As Date
    Public Property EventDate() As Date
        Get
            Return _eventDate
        End Get
        Set(ByVal value As Date)
            _eventDate = value
        End Set
    End Property


    Private _startTime As DateTime
    Public Property StartTime() As DateTime
        Get
            Return _startTime
        End Get
        Set(ByVal value As DateTime)
            _startTime = value
        End Set
    End Property

    Private _endTime As DateTime
    Public Property EndTime() As DateTime
        Get
            Return _endTime
        End Get
        Set(ByVal value As DateTime)
            _endTime = value
        End Set
    End Property

    Private _loactionName As String
    Public Property LocationName() As String
        Get
            Return _loactionName
        End Get
        Set(ByVal value As String)
            _loactionName = value
        End Set
    End Property

    Private _address As String
    Public Property Address() As String
        Get
            Return _address
        End Get
        Set(ByVal value As String)
            _address = value
        End Set
    End Property

    Private _city As String
    Public Property City() As String
        Get
            Return _city
        End Get
        Set(ByVal value As String)
            _city = value
        End Set
    End Property

    Private _state As String
    Public Property State() As String
        Get
            Return _state
        End Get
        Set(ByVal value As String)
            _state = value
        End Set
    End Property

    Private _zip As String
    Public Property Zip() As String
        Get
            Return _zip
        End Get
        Set(ByVal value As String)
            _zip = value
        End Set
    End Property

    Private _description As String
    Public Property Description() As String
        Get
            Return _description
        End Get
        Set(ByVal value As String)
            _description = value
        End Set
    End Property

    Private _distributer As String
    Public Property Distributer() As String
        Get
            Return _distributer
        End Get
        Set(ByVal value As String)
            _distributer = value
        End Set
    End Property

    Private _requestedBy As String
    Public Property RequestedBy() As String
        Get
            Return _requestedBy
        End Get
        Set(ByVal value As String)
            _requestedBy = value
        End Set
    End Property

End Class
