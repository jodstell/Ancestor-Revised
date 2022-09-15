Public Class SideMenuControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function clientFolder() As String
        'Try
        '    Select Case Session("CurrentClientID")
        '        Case "18"
        '            Return "BARetc"
        '        Case "19"
        '            Return "Gallo"
        '        Case "20"
        '            Return "WindyHill"
        '        Case "21"
        '            Return "Stoli"
        '    End Select

        'Catch ex As Exception
        '    Return "BARetc"
        'End Try

        Return "BARetc"

    End Function

End Class