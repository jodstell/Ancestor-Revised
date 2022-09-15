Public Class AmbassadorList

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

    Private _email As String
    Public Property Email() As String
        Get
            Return _email
        End Get
        Set(ByVal value As String)
            _email = value
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

    Private _streetAddress2 As String
    Public Property StreetAddress2() As String
        Get
            Return _streetAddress2
        End Get
        Set(ByVal value As String)
            _streetAddress2 = value
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

    Private _gender As String
    Public Property Gender() As String
        Get
            Return _gender
        End Get
        Set(ByVal value As String)
            _gender = value
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

    Private _payrollID As String
    Public Property PayrollID() As String
        Get
            Return _payrollID
        End Get
        Set(ByVal value As String)
            _payrollID = value
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

    Private _lastLogin As String
    Public Property LastLogin() As String
        Get
            Return _lastLogin
        End Get
        Set(ByVal value As String)
            _lastLogin = value
        End Set
    End Property
End Class
