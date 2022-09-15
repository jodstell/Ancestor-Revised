Imports BingGeocoder
Imports Telerik.Web.UI

Public Class Accounts
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '  bindGrid()
    End Sub

    Sub bindGrid()

        Dim q = From p In db.tblAccounts Select p

        RadGrid1.DataSource = q
        RadGrid1.DataBind()

    End Sub



    Function getLatitude(ByVal address As String) As String

        Dim geocoder = New BingGeocoderClient("Ar9r5Jz1bSVYhbZJ4p8CYoOLi1NuWoHVYl1NxJftPJz_FkhXUOxosfSgxDqbIpGg")
        Dim result = New BingGeocoderResult()
        result = geocoder.Geocode(address)

        Return result.Latitude

    End Function

    Function getLongitude(ByVal address As String) As String

        Dim geocoder = New BingGeocoderClient("Ar9r5Jz1bSVYhbZJ4p8CYoOLi1NuWoHVYl1NxJftPJz_FkhXUOxosfSgxDqbIpGg")
        Dim result = New BingGeocoderResult()
        result = geocoder.Geocode(address)

        Return result.Longitude

    End Function

    Private Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand
        If e.CommandName = "TryAgain" Then

            Dim account As String = e.CommandArgument
            Try
                Dim q = (From p In db.tblAccounts Where p.accountID = account Select p).FirstOrDefault


                Dim address As String = String.Format("{0}, {1}, {2}, {3}", q.streetAddress1, q.city, q.state, q.zipCode)

                q.latitude = getLatitude(address)
                q.longitude = getLongitude(address)

                db.SubmitChanges()

                RadGrid1.DataBind()

            Catch ex As Exception
                Response.Write(ex.Message())
            End Try


        End If
    End Sub
End Class