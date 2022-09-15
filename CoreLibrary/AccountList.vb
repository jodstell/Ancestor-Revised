Public Class AccountList

    Private _id As Integer
    Public Property ID() As Integer
        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
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

    Private _accountName As String
    Public Property AccountName() As String
        Get
            Return _accountName
        End Get
        Set(ByVal value As String)
            _accountName = value
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

    Private _accountType As String
    Public Property AccountType() As String
        Get
            Return _accountType
        End Get
        Set(ByVal value As String)
            _accountType = value
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

    Public Sub New(ByVal accountname As String, ByVal latitude As String, ByVal longitude As String)

        Me.AccountName = accountname
        Me.Latitude = latitude
        Me.Longitude = longitude
    End Sub

End Class
