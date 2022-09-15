Imports System.Data.SqlClient
Imports System.IO
Imports LinqToExcel
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI
Imports BingGeocoder

Public Class ImportEvents1
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim count As Integer = 0
    Dim failed As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub btnImportExcel_Click(sender As Object, e As EventArgs) Handles btnImportExcel.Click

        If Not Page.IsPostBack Then

        End If
        Dim fileGuid As String = System.Guid.NewGuid.ToString()


        For Each f As UploadedFile In AsyncUpload1.UploadedFiles
            Dim theFileName As String = Path.Combine(Server.MapPath("~/files"), f.FileName)

            f.SaveAs(theFileName)


            Try
                count = 0

                Dim excel = New ExcelQueryFactory(Server.MapPath("~/files/" & f.FileName))

                ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

                Dim events = From x In excel.Worksheet(Of ImportEvent)(WorksheetNameTextBox.Text)
                             Select x



                For Each u In events
                    Try

                        'add the event
                        Dim newevent As New tblRequestedEvent
                        newevent.eventTitle = u.EventName
                        newevent.eventTypeID = EventTypeIDComboBox.SelectedValue
                        newevent.eventDate = u.EventDate

                        Dim dt As Date = Date.Parse(u.EventDate)
                        Dim dateString = dt.ToShortDateString()

                        newevent.requestType = "Import"
                        newevent.startTime = dateString & " " & u.StartTime
                        newevent.endTime = dateString & " " & u.EndTime
                        newevent.locationName = u.LocationName
                        newevent.locationAddress = u.Address
                        newevent.locationCity = u.City
                        newevent.locationState = u.State
                        newevent.locationZip = u.Zip
                        newevent.eventDescription = u.Description
                        newevent.distributer = u.Distributer
                        newevent.CreatedBy = u.RequestedBy
                        newevent.CreatedByEmail = ""
                        newevent.supplierID = SupplierIDComboBox.SelectedValue

                        Dim clientID = (From p In db.tblSuppliers Where p.supplierID = SupplierIDComboBox.SelectedValue Select p).FirstOrDefault

                        newevent.clientID = clientID.clientID
                        newevent.CreatedDate = DateTime.Now()


                        If TeamComboBox.SelectedIndex = -1 Then
                            'do nothing
                        Else
                            newevent.teamID = TeamComboBox.SelectedValue
                        End If

                        If MatchComboBox.SelectedValue = "0" Then
                            Dim address As String = String.Format("{0}, {1}, {2}, {3}", u.Address, u.City, u.State, u.Zip)

                            newevent.latitude = getLatitude(address.Replace("#", ""))
                            newevent.longitude = getLongitude(address.Replace("#", ""))


                            newevent.matchedLocationID = getMatch(u.LocationName, getLatitude(address.Replace("#", "")), getLongitude(address.Replace("#", "")))
                        End If

                        If MatchComboBox.SelectedValue = "1" Then
                            newevent.matchedLocationID = getLocationNameMatch(u.LocationName)
                        End If


                        db.tblRequestedEvents.InsertOnSubmit(newevent)
                        db.SubmitChanges()

                        count = count + 1

                        'add the brands
                        Dim collection As IList(Of RadListBoxItem) = BrandListBox.CheckedItems

                        For Each item As RadListBoxItem In collection

                            Dim newBrand As New tblBrandsInRequestedEvent With {.requestedEventID = newevent.requestedEventID, .brandID = item.Value}

                            db.tblBrandsInRequestedEvents.InsertOnSubmit(newBrand)
                            db.SubmitChanges()

                        Next

                    Catch ex As Exception
                        msgLabel.Text = ex.Message
                    End Try

                Next

            Catch ex As Exception
                msgLabel.Text = ex.Message
            End Try


            '  System.IO.File.Delete(Server.MapPath(theFileName))

        Next

        Response.Redirect("/Events/ViewRequestedEvents")

        'RadNotification1.Show()

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

    Function getLocationNameMatch(ByVal locationname As String)

        Dim q = From p In db.tblAccounts Where p.accountName = locationname Select p

        If q.count = 0 Then
            Return "0"
        Else
            Return (From p In db.tblAccounts Where p.accountName = locationname Select p.Vpid).FirstOrDefault
        End If

    End Function

    Function getMatch(ByVal locationname As String, ByVal loc1 As String, loc2 As String) As String
        Try
            'Dim q = (From p In db.tblRequestedEvents Where p.requestedEventID = ID Select p).FirstOrDefault
            'Dim address As String = String.Format("{0}, {1}, {2}, {3}", q.locationAddress, q.locationCity, q.locationState, q.locationZip)

            'Dim loc1 = getLatitude(address.Replace("#", ""))
            'Dim loc2 = getLongitude(address.Replace("#", ""))

            Dim b As String = loc1.Substring(0, 5)

            Dim c As String = loc2.Substring(0, 7)

            ' Dim r = (From p In db.getShortGeoLocations Where p.shortLatitude = b And p.shortLongitude = c Select p).Count


            Dim r = (From p In db.getMatchedLocation(locationname, b, c) Select p.Vpid).FirstOrDefault

            If (From p In db.getMatchedLocation(locationname, b, c) Select p.Vpid).Count = 0 Then
                Return 0
            Else
                Return r.ToString()

            End If




        Catch ex As Exception
            Return 0
        End Try


    End Function

    Private Sub SupplierIDComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles SupplierIDComboBox.SelectedIndexChanged

        ' BrandListBox.Items.Clear()

        ' LoadBrands()

        Response.Redirect("ImportEventsBySupplier?SupplierID=" & e.Value)
    End Sub

    Protected Sub LoadBrands(ByVal supplierID As String)

        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        Dim adapter As New SqlDataAdapter("SELECT * FROM getBrandsbySupplier WHERE supplierID=@supplierID ORDER By brandName", connection)

        adapter.SelectCommand.Parameters.AddWithValue("@supplierID", supplierID)

        Dim dt As New DataTable()
        adapter.Fill(dt)

        BrandListBox.DataSource = dt
        BrandListBox.DataBind()

    End Sub

End Class



