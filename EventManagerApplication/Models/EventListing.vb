Public Class EventListing

    Private _eventID As Integer
    Public Property eventID() As Integer
        Get
            Return _eventID
        End Get
        Set(ByVal value As Integer)
            _eventID = value
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

    Private _brandNames As String
    Public Property BrandNames() As String
        Get
            Return _brandNames
        End Get
        Set(ByVal value As String)
            _brandNames = value
        End Set
    End Property

    Private _eventTypeID As Integer
    Public Property EventTypeID() As Integer
        Get
            Return _eventTypeID
        End Get
        Set(ByVal value As Integer)
            _eventTypeID = value
        End Set
    End Property

    Private _eventType As String
    Public Property EventType() As String
        Get
            Return _eventType
        End Get
        Set(ByVal value As String)
            _eventType = value
        End Set
    End Property

    Private _statusID As Integer
    Public Property StatusID() As Integer
        Get
            Return _statusID
        End Get
        Set(ByVal value As Integer)
            _statusID = value
        End Set
    End Property

    Private _status As String
    Public Property Status() As String
        Get
            Return _status
        End Get
        Set(ByVal value As String)
            _status = value
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

    Private _marketID As Integer
    Public Property MarketID() As Integer
        Get
            Return _marketID
        End Get
        Set(ByVal value As Integer)
            _marketID = value
        End Set
    End Property

    Private _marketName As String
    Public Property MarketName() As String
        Get
            Return _marketName
        End Get
        Set(ByVal value As String)
            _marketName = value
        End Set
    End Property

    Private _accountID As Integer
    Public Property AccountID() As Integer
        Get
            Return _accountID
        End Get
        Set(ByVal value As Integer)
            _accountID = value
        End Set
    End Property

    Private _accountName As String
    Public Property AccountName() As String
        Get
            Return _accountName
        End Get
        Set(ByVal value As String)
            _accountName = value
        End Set
    End Property


    Public Sub New()

    End Sub

    Public Sub New(ByVal eventID As Integer, ByVal eventName As String, ByVal eventdate As Date, ByVal starttime As String, ByVal endtime As String,
                   ByVal brandNames As String, ByVal eventTypeID As Integer, ByVal eventType As String, ByVal statusID As Integer, ByVal status As String,
                   ByVal address As String, ByVal city As String, ByVal state As String, ByVal marketID As Integer, ByVal marketName As String)

        Me.eventID = eventID
        Me.EventName = eventName
        Me.EventDate = eventdate
        Me.StartTime = starttime
        Me.EndTime = endtime
        Me.BrandNames = brandNames
        Me.EventTypeID = eventTypeID
        Me.EventType = eventType
        Me.StatusID = statusID
        Me.Status = status
        Me.Address = address
        Me.State = state
        Me.MarketID = marketID
        Me.MarketName = marketName

    End Sub
End Class
