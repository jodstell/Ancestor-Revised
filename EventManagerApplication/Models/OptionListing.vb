Public Class OptionListing
    Private _optionName As String
    Public Property OptionName() As String
        Get
            Return _optionName
        End Get
        Set(ByVal value As String)
            _optionName = value
        End Set
    End Property

    Public Sub New()

    End Sub
    Public Sub New(ByVal optionName As String)

        Me.OptionName = optionName

    End Sub

End Class
