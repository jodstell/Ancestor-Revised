Public Class SiteUsers

    Private m_UserID As String
    Public Property UserID() As String
        Get
            Return m_UserID
        End Get
        Set(ByVal value As String)
            m_UserID = value
        End Set
    End Property

    Private m_SiteID As String
    Public Property SiteID() As String
        Get
            Return m_SiteID
        End Get
        Set(ByVal value As String)
            m_SiteID = value
        End Set
    End Property

    Private m_UserName As String
    Public Property UserName() As String
        Get
            Return m_UserName
        End Get
        Set(ByVal value As String)
            m_UserName = value
        End Set
    End Property


    Private m_FirstName As String
    Public Property FirstName() As String
        Get
            Return m_FirstName
        End Get
        Set(ByVal value As String)
            m_FirstName = value
        End Set
    End Property

    Private m_LastName As String
    Public Property LastName() As String
        Get
            Return m_LastName
        End Get
        Set(ByVal value As String)
            m_LastName = value
        End Set
    End Property

    Private m_Admin As Boolean
    Public Property Admin() As Boolean
        Get
            Return m_Admin
        End Get
        Set(ByVal value As Boolean)
            m_Admin = value
        End Set
    End Property

    Private m_Instr As Boolean
    Public Property Instr() As Boolean
        Get
            Return m_Instr
        End Get
        Set(ByVal value As Boolean)
            m_Instr = value
        End Set
    End Property

    Private m_Editor As Boolean
    Public Property Editor() As Boolean
        Get
            Return m_Editor
        End Get
        Set(ByVal value As Boolean)
            m_Editor = value
        End Set
    End Property

    Private m_Student As Boolean
    Public Property Student() As Boolean
        Get
            Return m_Student
        End Get
        Set(ByVal value As Boolean)
            m_Student = value
        End Set
    End Property


    Private m_LastLoginDate As Date
    Public Property LastLoginDate() As Date
        Get
            Return m_LastLoginDate
        End Get
        Set(ByVal value As Date)
            m_LastLoginDate = value
        End Set
    End Property

    Private m_Status As String
    Public Property Status() As String
        Get
            Return m_Status
        End Get
        Set(ByVal value As String)
            m_Status = value
        End Set
    End Property


    Public Sub New()
    End Sub

    Public Sub New(ByVal userID As String, ByVal siteID As String, ByVal username As String, ByVal firstname As String, ByVal lastname As String, ByVal admin As Boolean, ByVal instr As Boolean, ByVal editor As Boolean, ByVal student As Boolean, ByVal lastlogindate As Date, ByVal status As String)

        Me.UserID = userID
        Me.SiteID = siteID
        Me.UserName = username
        Me.FirstName = firstname
        Me.LastName = lastname
        Me.Admin = admin
        Me.Instr = instr
        Me.Editor = editor
        Me.Student = student
        Me.LastLoginDate = lastlogindate
        Me.Status = status

    End Sub


End Class

