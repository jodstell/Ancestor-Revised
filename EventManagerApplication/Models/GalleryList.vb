

Public Class GalleryList

    Private _eventID As Integer
    Public Property EventID() As Integer
        Get
            Return _eventID
        End Get
        Set(ByVal value As Integer)
            _eventID = value
        End Set
    End Property

    Private _supplierName As String
    Public Property SupplierName() As String
        Get
            Return _supplierName
        End Get
        Set(ByVal value As String)
            _supplierName = value
        End Set
    End Property

    Private _brands As String
    Public Property Brands() As String
        Get
            Return _brands
        End Get
        Set(ByVal value As String)
            _brands = value
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

    Private _statusName As String
    Public Property StatusName() As String
        Get
            Return _statusName
        End Get
        Set(ByVal value As String)
            _statusName = value
        End Set
    End Property

    Private _statusID As String
    Public Property StatusID() As String
        Get
            Return _statusID
        End Get
        Set(ByVal value As String)
            _statusID = value
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

    Private _eventTypeName As String
    Public Property EventTypeName() As String
        Get
            Return _eventTypeName
        End Get
        Set(ByVal value As String)
            _eventTypeName = value
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

    Private _locationID As String
    Public Property LocationID() As String
        Get
            Return _locationID
        End Get
        Set(ByVal value As String)
            _locationID = value
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

    Private _vpid As Integer
    Public Property Vpid() As Integer
        Get
            Return _vpid
        End Get
        Set(ByVal value As Integer)
            _vpid = value
        End Set
    End Property

    Private _labelText As String
    Public Property LabelText() As String
        Get
            Return _labelText
        End Get
        Set(ByVal value As String)
            _labelText = value
        End Set
    End Property


    Public Sub New()

    End Sub

    Public Sub New(ByVal eventID As String, ByVal supplierName As String, ByVal brands As String, ByVal eventDate As String, ByVal statusName As String, ByVal statusID As String, ByVal marketName As String, ByVal eventTypeName As String, ByVal accountName As String, ByVal locationID As String, ByVal address As String, ByVal city As String, ByVal state As String, ByVal vpID As String, ByVal labelText As String)

        Me.EventID = eventID
        Me.SupplierName = supplierName
        Me.Brands = brands
        Me.EventDate = eventDate
        Me.StatusName = statusName
        Me.StatusID = statusID
        Me.MarketName = marketName
        Me.EventTypeName = eventTypeName
        Me.AccountName = accountName
        Me.LocationID = locationID
        Me.Address = address
        Me.City = city
        Me.State = state
        Me.Vpid = vpID
        Me.LabelText = labelText

    End Sub


End Class

