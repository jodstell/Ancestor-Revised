Public Class EventDocumentList


    Private _fileID As String
    Public Property FileID() As String
        Get
            Return _fileID
        End Get
        Set(ByVal value As String)
            _fileID = value
        End Set
    End Property

    Private _fileName As String
    Public Property FileName() As String
        Get
            Return _fileName
        End Get
        Set(ByVal value As String)
            _fileName = value
        End Set
    End Property

    Private _fileType As String
    Public Property FileType() As String
        Get
            Return _fileType
        End Get
        Set(ByVal value As String)
            _fileType = value
        End Set
    End Property

    Private _fileURL As String
    Public Property FileURL() As String
        Get
            Return _fileURL
        End Get
        Set(ByVal value As String)
            _fileURL = value
        End Set
    End Property

    Private _showRemove As String
    Public Property ShowRemove() As String
        Get
            Return _showRemove
        End Get
        Set(ByVal value As String)
            _showRemove = value
        End Set
    End Property

    Private _commandName As String
    Public Property CommandName() As String
        Get
            Return _commandName
        End Get
        Set(ByVal value As String)
            _commandName = value
        End Set
    End Property

    Private _visible As String
    Public Property Visible() As String
        Get
            Return _visible
        End Get
        Set(ByVal value As String)
            _visible = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(ByVal fileID As String, ByVal fileName As String, ByVal fileType As String, ByVal fileURL As String, ByVal showRemove As String, ByVal commandName As String, ByVal visible As String)

        Me.FileID = fileID
        Me.FileName = fileName
        Me.FileType = fileType
        Me.FileURL = fileURL
        Me.ShowRemove = showRemove
        Me.CommandName = commandName
        Me.Visible = visible

    End Sub


End Class
