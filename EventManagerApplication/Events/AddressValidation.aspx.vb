Imports BingGeocoder

Public Class AddressValidation
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub btnLookup_Click(sender As Object, e As EventArgs) Handles btnLookup.Click

        Dim address As String = txtAddress.Text

        Dim loc1 = getLatitude(address.Replace("#", ""))
        Dim loc2 = getLongitude(address.Replace("#", ""))


        LatitudeLabel.Text = loc1.Substring(0, 5)

        LongitudeLabel.Text = loc2.Substring(0, 7)

        MatchedLocationIDLabel.Text = getMatch(getLatitude(address.Replace("#", "")), getLongitude(address.Replace("#", "")))
    End Sub

    Function getLatitude(ByVal address As String) As String

        Try
            Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

            Dim geocoder = New BingGeocoderClient(BingKey)
            Dim result = New BingGeocoderResult()
            result = geocoder.Geocode(address)

            Return result.Latitude
        Catch ex As Exception
            Return "0"
        End Try


    End Function

    Function getLongitude(ByVal address As String) As String
        Try
            Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

            Dim geocoder = New BingGeocoderClient(BingKey)
            Dim result = New BingGeocoderResult()
            result = geocoder.Geocode(address)

            Return result.Longitude
        Catch ex As Exception
            Return "0"
        End Try


    End Function

    Function getMatch(ByVal loc1 As String, loc2 As String) As String
        Try
            'Dim q = (From p In db.tblRequestedEvents Where p.requestedEventID = ID Select p).FirstOrDefault
            'Dim address As String = String.Format("{0}, {1}, {2}, {3}", q.locationAddress, q.locationCity, q.locationState, q.locationZip)

            'Dim loc1 = getLatitude(address.Replace("#", ""))
            'Dim loc2 = getLongitude(address.Replace("#", ""))

            Dim b As String = loc1.Substring(0, 5)

            Dim c As String = loc2.Substring(0, 7)

            'Dim r = (From p In db.getShortGeoLocations Where p.shortLatitude = b And p.shortLongitude = c Select p).Count

            'If r = 0 Then
            '    Return 0
            'Else

            '    Dim sb As New StringBuilder()

            '    Dim q = (From p In db.getShortGeoLocations Where p.shortLatitude = b And p.shortLongitude = c And p.accountName Like txtName.Text Select p)

            '    For Each p In q
            '        sb.Append(p.accountName & ", ")
            '    Next

            '    Return sb.ToString() '(From p In db.getShortGeoLocations Where p.shortLatitude = b And p.shortLongitude = c Select p.Vpid).FirstOrDefault
            'End If

            Dim r = (From p In db.getMatchedLocation(txtName.Text, b, c) Select p.Vpid).FirstOrDefault

            If (From p In db.getMatchedLocation(txtName.Text, b, c) Select p.Vpid).Count = 0 Then
                Return 0
            Else
                Return r.ToString()

            End If


        Catch ex As Exception
            Return 0
        End Try


    End Function

End Class