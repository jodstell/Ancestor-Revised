Public Class AvailableAmbassadorList

    Private _userID As String
    Public Property UserID() As String
        Get
            Return _userID
        End Get
        Set(ByVal value As String)
            _userID = value
        End Set
    End Property

    Private _userName As String
    Public Property UserName() As String
        Get
            Return _userName
        End Get
        Set(ByVal value As String)
            _userName = value
        End Set
    End Property

    Private _firstName As String
    Public Property FirstName() As String
        Get
            Return _firstName
        End Get
        Set(ByVal value As String)
            _firstName = value
        End Set
    End Property

    Private _lastName As String
    Public Property LastName() As String
        Get
            Return _lastName
        End Get
        Set(ByVal value As String)
            _lastName = value
        End Set
    End Property

    Private _fullName As String
    Public Property FullName() As String
        Get
            Return _fullName
        End Get
        Set(ByVal value As String)
            _fullName = value
        End Set
    End Property

    Private _email As String
    Public Property Email() As String
        Get
            Return _email
        End Get
        Set(ByVal value As String)
            _email = value
        End Set
    End Property

    Private _miles As String
    Public Property Miles() As String
        Get
            Return _miles
        End Get
        Set(ByVal value As String)
            _miles = value
        End Set
    End Property

    Private _phone As String
    Public Property Phone() As String
        Get
            Return _phone
        End Get
        Set(ByVal value As String)
            _phone = value
        End Set
    End Property

    Private _streetAddress1 As String
    Public Property StreetAddress1() As String
        Get
            Return _streetAddress1
        End Get
        Set(ByVal value As String)
            _streetAddress1 = value
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

    Private _dob As String
    Public Property DOB() As String
        Get
            Return _dob
        End Get
        Set(ByVal value As String)
            _dob = value
        End Set
    End Property

    Private _isRequested As String
    Public Property IsRequested() As String
        Get
            Return _isRequested
        End Get
        Set(ByVal value As String)
            _isRequested = value
        End Set
    End Property

    Private _requestID As String
    Public Property RequestID() As String
        Get
            Return _requestID
        End Get
        Set(ByVal value As String)
            _requestID = value
        End Set
    End Property

    Private _requested As String
    Public Property Requested() As String
        Get
            Return _requested
        End Get
        Set(ByVal value As String)
            _requested = value
        End Set
    End Property

    Private _positions As String
    Public Property Positions() As String
        Get
            Return _positions
        End Get
        Set(ByVal value As String)
            _positions = value
        End Set
    End Property

    Private _markets As String
    Public Property Markets() As String
        Get
            Return _markets
        End Get
        Set(ByVal value As String)
            _markets = value
        End Set
    End Property

    Private _ytdEventCount As String
    Public Property YTDEventCount() As String
        Get
            Return _ytdEventCount
        End Get
        Set(ByVal value As String)
            _ytdEventCount = value
        End Set
    End Property

    Private _ytdHours As String
    Public Property YTDHours() As String
        Get
            Return _ytdHours
        End Get
        Set(ByVal value As String)
            _ytdHours = value
        End Set
    End Property

    Private _ytdPay As String
    Public Property YTDPay() As String
        Get
            Return _ytdPay
        End Get
        Set(ByVal value As String)
            _ytdPay = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(ByVal userID As String, ByVal firstName As String, ByVal lastName As String, ByVal fullName As String, ByVal email As String, ByVal miles As String, ByVal phone As String, ByVal streetAddress1 As String, ByVal city As String, ByVal state As String, ByVal zip As String, ByVal dob As String, ByVal isRequested As String, ByVal requestID As String, ByVal requested As String, ByVal positions As String, ByVal markets As String, ByVal ytdEventCount As String, ByVal ytdHours As String, ByVal ytdPay As String)

        Me.UserID = userID
        Me.FirstName = firstName
        Me.LastName = lastName
        Me.FullName = fullName
        Me.Email = email
        Me.Phone = phone
        Me.StreetAddress1 = streetAddress1
        Me.City = city
        Me.State = state
        Me.Zip = zip
        Me.DOB = dob
        Me.IsRequested = isRequested
        Me.RequestID = requestID
        Me.Requested = requested
        Me.Positions = positions
        Me.Markets = markets
        Me.YTDEventCount = ytdEventCount
        Me.YTDHours = ytdHours
        Me.YTDPay = ytdPay

    End Sub
End Class
