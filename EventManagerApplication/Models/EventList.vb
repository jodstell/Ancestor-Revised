Public Class EventList

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

    Private _eventDate As Date
    Public Property EventDate() As Date
        Get
            Return _eventDate
        End Get
        Set(ByVal value As Date)
            _eventDate = value
        End Set
    End Property

    Private _formatedEventDate As String
    Public Property FormatedEventDate() As String
        Get
            Return _formatedEventDate
        End Get
        Set(ByVal value As String)
            _formatedEventDate = value
        End Set
    End Property

    Private _formatedStartTime As String
    Public Property FormatedStartTime() As String
        Get
            Return _formatedStartTime
        End Get
        Set(ByVal value As String)
            _formatedStartTime = value
        End Set
    End Property

    Private _formatedEndTime As String
    Public Property FormatedEndTime() As String
        Get
            Return _formatedEndTime
        End Get
        Set(ByVal value As String)
            _formatedEndTime = value
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

    Private _supplier As String
    Public Property Supplier() As String
        Get
            Return _supplier
        End Get
        Set(ByVal value As String)
            _supplier = value
        End Set
    End Property

    Private _brand As String
    Public Property Brand() As String
        Get
            Return _brand
        End Get
        Set(ByVal value As String)
            _brand = value
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

    Private _status As String
    Public Property Status() As String
        Get
            Return _status
        End Get
        Set(ByVal value As String)
            _status = value
        End Set
    End Property

    Private _pushPinIcon As String
    Public Property PushPinIcon() As String
        Get
            Return _pushPinIcon
        End Get
        Set(ByVal value As String)
            _pushPinIcon = value
        End Set
    End Property


    Private _address1 As String
    Public Property Address1() As String
        Get
            Return _address1
        End Get
        Set(ByVal value As String)
            _address1 = value
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

    Private _market As String
    Public Property Market() As String
        Get
            Return _market
        End Get
        Set(ByVal value As String)
            _market = value
        End Set
    End Property

    Private _program As String
    Public Property Program() As String
        Get
            Return _program
        End Get
        Set(ByVal value As String)
            _program = value
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

    Private _venueName As String
    Public Property VenueName() As String
        Get
            Return _venueName
        End Get
        Set(ByVal value As String)
            _venueName = value
        End Set
    End Property

    Private _venueAddress As String
    Public Property VenueAddress() As String
        Get
            Return _venueAddress
        End Get
        Set(ByVal value As String)
            _venueAddress = value
        End Set
    End Property

    Private _venueCity As String
    Public Property VenueCity() As String
        Get
            Return _venueCity
        End Get
        Set(ByVal value As String)
            _venueCity = value
        End Set
    End Property

    Private _venueState As String
    Public Property VenueState() As String
        Get
            Return _venueState
        End Get
        Set(ByVal value As String)
            _venueState = value
        End Set
    End Property

    Private _venueZip As String
    Public Property VenueZip() As String
        Get
            Return _venueZip
        End Get
        Set(ByVal value As String)
            _venueZip = value
        End Set
    End Property

    Private _latitude As String
    Public Property Latitude() As String
        Get
            Return _latitude
        End Get
        Set(ByVal value As String)
            _latitude = value
        End Set
    End Property

    Private _longitude As String
    Public Property Longitude() As String
        Get
            Return _longitude
        End Get
        Set(ByVal value As String)
            _longitude = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(ByVal eventName As String, ByVal latitude As String, ByVal longitude As String, pushpinicon As String, ByVal eventdate As Date, ByVal starttime As String, ByVal endtime As String, ByVal eventid As String, ByVal formatedeventdate As String, formatedstarttime As String, supplierName As String, accountName As String, address As String, city As String, state As String)

        Me.EventName = eventName
        Me.Latitude = latitude
        Me.Longitude = longitude
        Me.PushPinIcon = pushpinicon
        Me.EventDate = eventdate
        Me.StartTime = starttime
        Me.EndTime = endtime
        Me.ID = eventid
        Me.FormatedEventDate = formatedeventdate
        Me.FormatedStartTime = formatedstarttime
        Me.Supplier = supplierName
        Me.VenueName = accountName
        Me.Address1 = address
        Me.City = city
        Me.State = state
    End Sub


End Class
