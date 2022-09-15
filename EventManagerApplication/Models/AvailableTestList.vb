Public Class AvailableTestList

    Private m_testID As Integer
    Public Property TestID() As Integer
        Get
            Return m_testID
        End Get
        Set(ByVal value As Integer)
            m_testID = value
        End Set
    End Property

    Private m_testTitle As String
    Public Property TestTitle() As String
        Get
            Return m_testTitle
        End Get
        Set(ByVal value As String)
            m_testTitle = value
        End Set
    End Property

    Private m_dbGUID As String
    Public Property dbGUID() As String
        Get
            Return m_dbGUID
        End Get
        Set(ByVal value As String)
            m_dbGUID = value
        End Set
    End Property

    Private M_Result As String
    Public Property Result() As String
        Get
            Return M_Result
        End Get
        Set(ByVal value As String)
            M_Result = value
        End Set
    End Property

    Private m_prerequisite As Integer
    Public Property PreRequisite() As Integer
        Get
            Return m_prerequisite
        End Get
        Set(ByVal value As Integer)
            m_prerequisite = value
        End Set
    End Property

    Private m_preReqResult As String
    Public Property PreReqResult() As String
        Get
            Return m_preReqResult
        End Get
        Set(ByVal value As String)
            m_preReqResult = value
        End Set
    End Property


    Private m_enabled As Boolean
    Public Property Enabled() As Boolean
        Get
            Return m_enabled
        End Get
        Set(ByVal value As Boolean)
            m_enabled = value
        End Set
    End Property

    Private m_retakeHours As Integer
    Public Property RetakeHours() As Integer
        Get
            Return m_retakeHours
        End Get
        Set(ByVal value As Integer)
            m_retakeHours = value
        End Set
    End Property

    Private m_siteID As String
    Public Property SiteID() As String
        Get
            Return m_siteID
        End Get
        Set(ByVal value As String)
            m_siteID = value
        End Set
    End Property


    Private m_groupID As String
    Public Property GroupID() As String
        Get
            Return m_groupID
        End Get
        Set(ByVal value As String)
            m_groupID = value
        End Set
    End Property

    Private m_instructorID As String
    Public Property InstructorID() As String
        Get
            Return m_instructorID
        End Get
        Set(ByVal value As String)
            m_instructorID = value
        End Set
    End Property



    Public Sub New()
    End Sub

    Public Sub New(ByVal testID As Integer, ByVal testtitle As String, ByVal dbguid As String, ByVal result As String, ByVal prereq As Integer, ByVal prereqresult As String, ByVal enabled As Boolean, ByVal retakehours As Integer, ByVal siteid As String, ByVal groupid As String, ByVal instructorid As String)
        Me.TestID = testID
        Me.TestTitle = testtitle
        Me.dbGUID = dbguid
        Me.Result = result
        Me.PreRequisite = prereq
        Me.PreReqResult = prereqresult
        Me.Enabled = enabled
        Me.RetakeHours = retakehours
        Me.SiteID = siteid
        Me.GroupID = groupid
        Me.InstructorID = instructorid
    End Sub


End Class
