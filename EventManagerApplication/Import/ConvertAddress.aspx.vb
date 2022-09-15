Imports BingGeocoder

Public Class ConvertAddress
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim count As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        resultLabel.Text = (From p In db.tblAccounts Where p.latitude Is Nothing Select p).Count
    End Sub


    Function getLatitude(ByVal address As String) As String

        Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

        Dim geocoder = New BingGeocoderClient(BingKey)
        Dim result = New BingGeocoderResult()
        result = geocoder.Geocode(address)

        Return result.Latitude

    End Function

    Function getLongitude(ByVal address As String) As String

        Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

        Dim geocoder = New BingGeocoderClient(BingKey)
        Dim result = New BingGeocoderResult()
        result = geocoder.Geocode(address)

        Return result.Longitude

    End Function

    Public Function distance(ByVal lat1 As Double, ByVal lon1 As Double, ByVal lat2 As Double, ByVal lon2 As Double, ByVal unit As Char) As Double
        Dim theta As Double = lon1 - lon2
        Dim dist As Double = Math.Sin(deg2rad(lat1)) * Math.Sin(deg2rad(lat2)) + Math.Cos(deg2rad(lat1)) * Math.Cos(deg2rad(lat2)) * Math.Cos(deg2rad(theta))
        dist = Math.Acos(dist)
        dist = rad2deg(dist)
        dist = dist * 60 * 1.1515
        If unit = "K" Then
            dist = dist * 1.609344
        ElseIf unit = "N" Then
            dist = dist * 0.8684
        End If
        Return dist
    End Function

    Private Function deg2rad(ByVal deg As Double) As Double
        Return (deg * Math.PI / 180.0)
    End Function

    Private Function rad2deg(ByVal rad As Double) As Double
        Return rad / Math.PI * 180.0
    End Function


    Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        Try
            Dim q = (From p In db.tblAccounts Where p.accountID = accountNumberTextBox1.Text Select p).FirstOrDefault

            Dim address As String = String.Format("{0}, {1}, {2}, {3}", q.streetAddress1, q.city, q.state, q.zipCode)


            addressLabel1.Text = address
            LatitudeLabel1.Text = getLatitude(address.Replace("#", ""))
            LongitudeLabel1.Text = getLongitude(address.Replace("#", ""))

        Catch ex As Exception
            errorLabel1.Text = ex.Message()
        End Try

        Try
            Dim q = (From p In db.tblAccounts Where p.accountID = accountNumberTextBox2.Text Select p).FirstOrDefault

            Dim address As String = String.Format("{0}, {1}, {2}, {3}", q.streetAddress1, q.city, q.state, q.zipCode)

            addressLabel2.Text = address
            LatitudeLabel2.Text = getLatitude(address.Replace("#", ""))
            LongitudeLabel2.Text = getLongitude(address.Replace("#", ""))

        Catch ex As Exception
            errorLabel2.Text = ex.Message()
        End Try

        Try
            resultLabel.Text = distance(LatitudeLabel1.Text, LongitudeLabel1.Text, LatitudeLabel2.Text, LongitudeLabel2.Text, "M")
        Catch ex As Exception
            resultLabel.Text = ex.Message()
        End Try

    End Sub

    Private Sub btnBatchConvert_Click(sender As Object, e As EventArgs) Handles btnBatchConvert.Click

        Try

            Dim q = From p In db.tblAccounts Where p.geoLocationUpdated = 0 Select p Take (300)

            For Each p In q
                Dim address As String = String.Format("{0}, {1}, {2}, {3}", p.streetAddress1, p.city, p.state, p.zipCode)

                p.latitude = getLatitude(address.Replace("#", ""))
                p.longitude = getLongitude(address.Replace("#", ""))
                p.geoLocationUpdated = True

                db.SubmitChanges()
                count = count + 1

            Next

            Dim remaining = (From p In db.tblAccounts Where p.geoLocationUpdated = 0 Select p).Count

            resultLabel.Text = "Updated " & count & " records.  " & remaining & " remaining."

        Catch ex As Exception
            errorLabel1.Text = ex.Message()
        End Try

    End Sub
End Class