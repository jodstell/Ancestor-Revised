Public Class MyCulture
    Shared Function getCulture(ByVal id As String, ByVal name As String, ByVal cultureID As String, ByVal title As String) As String

        Dim db As New LMSDataClassesDataContext

        If cultureID <> "en-US" Then
            Dim result = (From p In db.CultureResources Where p.CultureID = cultureID And p.ID = id And p.Name = name Select p.Value).FirstOrDefault

            If result = "" Or Nothing Then
                Return title
            Else
                Return result
            End If

        End If

        Return title

    End Function
End Class
