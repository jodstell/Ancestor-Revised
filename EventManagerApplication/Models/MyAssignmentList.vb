Public Class MyAssignmentList

    Private _assignmentID As String
    Public Property AssignmentID() As String
        Get
            Return _assignmentID
        End Get
        Set(ByVal value As String)
            _assignmentID = value
        End Set
    End Property

    Private _username As String
    Public Property UserName() As String
        Get
            Return _username
        End Get
        Set(ByVal value As String)
            _username = value
        End Set
    End Property


    Private _courseID As String
    Public Property CourseID() As String
        Get
            Return _courseID
        End Get
        Set(ByVal value As String)
            _courseID = value
        End Set
    End Property

    Private _title As String
    Public Property Title() As String
        Get
            Return _title
        End Get
        Set(ByVal value As String)
            _title = value
        End Set
    End Property

    Private _description As String
    Public Property Description() As String
        Get
            Return _description
        End Get
        Set(ByVal value As String)
            _description = value
        End Set
    End Property

    Private _startDate As DateTime
    Public Property StartDate() As Date
        Get
            Return _startDate
        End Get
        Set(ByVal value As Date)
            _startDate = value
        End Set
    End Property

    Private _dueDate As DateTime
    Public Property DueDate() As Date
        Get
            Return _dueDate
        End Get
        Set(ByVal value As Date)
            _dueDate = value
        End Set
    End Property

    Private _link As String
    Public Property Link() As String
        Get
            Return _link
        End Get
        Set(ByVal value As String)
            _link = value
        End Set
    End Property

    Private _assignmentType As Integer
    Public Property AssignmentType() As Integer
        Get
            Return _assignmentType
        End Get
        Set(ByVal value As Integer)
            _assignmentType = value
        End Set
    End Property

    Private _submitted As Boolean
    Public Property Submitted() As Boolean
        Get
            Return _submitted
        End Get
        Set(ByVal value As Boolean)
            _submitted = value
        End Set
    End Property

    Private _graded As Boolean
    Public Property Graded() As Boolean
        Get
            Return _graded
        End Get
        Set(ByVal value As Boolean)
            _graded = value
        End Set
    End Property


    Public Sub New()
    End Sub

    Public Sub New(ByVal assignmentid As String, ByVal username As String, ByVal courseid As String, ByVal title As String, ByVal description As String, ByVal startdate As Date, ByVal duedate As Date, ByVal link As String, ByVal submitted As Boolean, ByVal graded As Boolean)
        Me.AssignmentID = assignmentid
        Me.UserName = username
        Me.CourseID = courseid
        Me.Title = title
        Me.Description = description
        Me.StartDate = startdate
        Me.DueDate = duedate
        Me.Link = link
        Me.Submitted = submitted
        Me.Graded = graded
    End Sub

End Class
