Public Class UserInformation
    Private _FirstName As String
    Public Property FisrtName() As String
        Get
            Return _FirstName
        End Get
        Set(ByVal value As String)
            _FirstName = value
        End Set
    End Property

    Private _LastName As String
    Public Property LastName() As String
        Get
            Return _LastName
        End Get
        Set(ByVal value As String)
            _LastName = value
        End Set
    End Property

    Private _UserName As String
    Public Property UserName() As String
        Get
            Return _UserName
        End Get
        Set(ByVal value As String)
            _UserName = value
        End Set
    End Property

    Private _EmailAddress As String
    Public Property EmailAddress() As String
        Get
            Return _EmailAddress
        End Get
        Set(ByVal value As String)
            _EmailAddress = value
        End Set
    End Property

    Private _FullName As String
    Public Property FullName() As String
        Get
            Return _FullName
        End Get
        Set(ByVal value As String)
            _FullName = value
        End Set
    End Property

    Private _Role As String
    Public Property Role() As String
        Get
            Return _Role
        End Get
        Set(ByVal value As String)
            _Role = value
        End Set
    End Property

    Public Sub New()
    End Sub

    Public Sub New(ByVal firstname As String, ByVal lastname As String, ByRef emailaddress As String, ByVal fullname As String, role As String)
        Me.FisrtName = firstname
        Me.LastName = lastname
        Me.EmailAddress = emailaddress
        Me.FullName = fullname
        Me.Role = role
    End Sub
End Class
