Public Class AssignmentList

    Private _eventID As Integer
    Public Property EventID() As Integer
        Get
            Return _eventID
        End Get
        Set(ByVal value As Integer)
            _eventID = value
        End Set
    End Property

    Private _ambassadorName As String
    Public Property AmbassadorName() As String
        Get
            Return _ambassadorName
        End Get
        Set(ByVal value As String)
            _ambassadorName = value
        End Set
    End Property

    Private _ambassadorEmail As String
    Public Property AmbassadorEmail() As String
        Get
            Return _ambassadorEmail
        End Get
        Set(ByVal value As String)
            _ambassadorEmail = value
        End Set
    End Property

    Private _ambassadorPhone As String
    Public Property AmbassadorPhone() As String
        Get
            Return _ambassadorPhone
        End Get
        Set(ByVal value As String)
            _ambassadorPhone = value
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
    Public Property EventDate() As String
        Get
            Return _eventDate
        End Get
        Set(ByVal value As String)
            _eventDate = value
        End Set
    End Property

    Private _startTime As String
    Public Property StartTime() As String
        Get
            Return _startTime
        End Get
        Set(ByVal value As String)
            _startTime = value
        End Set
    End Property

    Private _endTime As String
    Public Property EndTime() As String
        Get
            Return _endTime
        End Get
        Set(ByVal value As String)
            _endTime = value
        End Set
    End Property

    Private _training As String
    Public Property Training() As String
        Get
            Return _training
        End Get
        Set(ByVal value As String)
            _training = value
        End Set
    End Property

    Private _checkInTime As String
    Public Property CheckInTime() As String
        Get
            Return _checkInTime
        End Get
        Set(ByVal value As String)
            _checkInTime = value
        End Set
    End Property

    Private _pos As String
    Public Property POS() As String
        Get
            Return _pos
        End Get
        Set(ByVal value As String)
            _pos = value
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

    Private _accountAddress As String
    Public Property AccountAddress() As String
        Get
            Return _accountAddress
        End Get
        Set(ByVal value As String)
            _accountAddress = value
        End Set
    End Property

    Private _AccountCity As String
    Public Property AccountCity() As String
        Get
            Return _AccountCity
        End Get
        Set(ByVal value As String)
            _AccountCity = value
        End Set
    End Property

    Private _accountState As String
    Public Property AccountState() As String
        Get
            Return _accountState
        End Get
        Set(ByVal value As String)
            _accountState = value
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
End Class
