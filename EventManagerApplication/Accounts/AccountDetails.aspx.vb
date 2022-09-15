Imports Telerik.Web.UI
Imports BingGeocoder
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class Account_Details
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Then
            Response.Redirect("/AccessDenied")
        End If

        If manager.IsInRole(currentUser.Id, "Agency") Then
            brandTracker.Visible = False
            activitieslist.Visible = False
        End If

        If manager.IsInRole(currentUser.Id, "Agency") Or manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Accounting") Then
            accountPhotosControl.Visible = False
        End If


        If Not Page.IsPostBack Then
            bindAccount(Request.QueryString("AccountID"))
        End If


        UpcomingEventsCountLabel.Text = (From p In db.qryViewCurrentEvents Where p.accountID = Request.QueryString("AccountID") Select p).Count
        PreviousEventsCountLabel.Text = (From p In db.qryViewPastEvents Where p.accountID = Request.QueryString("AccountID") Select p).Count


        Dim i = (From p In db.tblAccountHours Where p.accountID = Request.QueryString("AccountID") Select p).Count

        If i = 0 Then

            Dim newHours As New tblAccountHour With {.accountID = Request.QueryString("AccountID")}
            db.tblAccountHours.InsertOnSubmit(newHours)
            db.SubmitChanges()

        End If

    End Sub


    Sub bindAccount(ByVal id As Integer)

        Try
            Dim q = (From p In db.tblAccounts Where p.accountID = id Or p.Vpid = id Select p).FirstOrDefault
            Try


                'populate labels
                Me.AccountNameLabel.Text = q.accountName
                Me.AccountIDLabel.Text = q.accountID
                VpidLabel.Text = q.Vpid

                'populate labels
                AccountNameLabel1.Text = q.accountName
                AccountAddressLabel1.Text = String.Format("{0} {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)

                geoLocationLabel.Text = String.Format("Coordinates: {0}, {1}", q.latitude, q.longitude)


            Catch ex As Exception

            End Try


            Try
                CreatedDateLabel.Text = Common.GetTimeAdjustment(q.createdDate)
            Catch ex As Exception
                CreatedDateLabel.Text = "N/A"
            End Try

            'get the last updated date and format it
            Try
                If q.modifiedDate Is Nothing Then
                    Me.LastUpdateLabel.Text = "None"
                Else
                    Me.LastUpdateLabel.Text = Common.GetTimeAdjustment(q.modifiedDate)
                End If

            Catch ex As Exception
                Me.LastUpdateLabel.Text = ex.Message
            End Try

            Try
                'populate location
                Me.LatitudeTextBox.Value = q.latitude
                Me.LongtitudeTextBox.Value = q.longitude
                Me.LocationTextBox.Value = q.city & ", " & q.state
            Catch ex As Exception

            End Try

            If q.latitude = "0" Or Nothing Then
                MapErrorPanel.Visible = True
                MapPanel.Visible = False

                Try
                    streetAddress1TextBox.Text = q.streetAddress1
                    streetAddress2TextBox.Text = q.streetAddress2
                    cityTextBox.Text = q.city
                    DropDownListState.SelectedValue = q.state
                    zipCodeTextBox.Text = q.zipCode
                Catch ex As Exception

                End Try



            End If
        Catch ex As Exception

        End Try





    End Sub

    Private Sub btnFixCoordinates_Click(sender As Object, e As EventArgs) Handles btnFixCoordinates.Click

        Dim address As String = String.Format("{0}, {1}, {2}, {3}", streetAddress1TextBox.Text.Replace("#", ""), cityTextBox.Text, DropDownListState.SelectedValue, zipCodeTextBox.Text)

        Dim latitude As String = getLatitude(address)
        Dim longitude As String = getLongitude(address)


        'show failed result
        Label1.Text = latitude & "...   Latitude located"
        Label2.Text = longitude & "...   Longtitude located"

        'update the address
        Dim newaddress = (From p In db.tblAccounts Where p.accountID = Request.QueryString("AccountID") Select p).FirstOrDefault
            newaddress.latitude = latitude
            newaddress.longitude = longitude
            newaddress.streetAddress1 = streetAddress1TextBox.Text
            newaddress.streetAddress2 = streetAddress2TextBox.Text
            newaddress.city = cityTextBox.Text
            newaddress.state = DropDownListState.SelectedValue
            newaddress.zipCode = zipCodeTextBox.Text

            db.SubmitChanges()

        'show success result

        Response.Redirect("/Accounts/AccountDetails?AccountID=" & Request.QueryString("AccountID"))



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

    Private Sub Account_Details_PreLoad(sender As Object, e As EventArgs) Handles Me.PreLoad

        Dim i = (From p In db.tblAccountHours Where p.accountID = Request.QueryString("AccountID") Select p).Count

        If i = 0 Then

            Dim newHours As New tblAccountHour With {.accountID = Request.QueryString("AccountID")}
            db.tblAccountHours.InsertOnSubmit(newHours)
            db.SubmitChanges()

        End If


        Dim x = (From p In db.tblAccountDemographics Where p.accountID = Request.QueryString("AccountID") Select p).Count

        If x = 0 Then

            Dim newDemographic As New tblAccountDemographic With {.accountID = Request.QueryString("AccountID")}
            db.tblAccountDemographics.InsertOnSubmit(newDemographic)
            db.SubmitChanges()

        End If

        Dim y = (From p In db.tblAccountDetails Where p.accountID = Request.QueryString("AccountID") Select p).Count

        If y = 0 Then

            Dim newDetail As New tblAccountDetail With {.accountID = Request.QueryString("AccountID")}
            db.tblAccountDetails.InsertOnSubmit(newDetail)
            db.SubmitChanges()

        End If

    End Sub


    'Private Sub AccountInformation_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles AccountInformation.ItemCommand

    '    Select Case e.CommandName
    '        Case "EditItem"
    '            DetailPanel.Visible = False
    '            EditPanel.Visible = True


    '        Case "DeleteAccount"
    '            db.DeleteAccount(Convert.ToInt32(e.CommandArgument))
    '            db.SubmitChanges()

    '            Response.Redirect("/Accounts/ViewAccounts?Action=3")
    '    End Select


    'End Sub

    Private Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


        For Each file As UploadedFile In RadAsyncUpload1.UploadedFiles

            Dim bytes(file.ContentLength - 1) As Byte
            file.InputStream.Read(bytes, 0, file.ContentLength)


            Dim i As New tblAccountPhoto
            i.Image = MakeThumb(bytes, 1200)
            i.LargeImage = MakeThumb(bytes, 500) '1
            i.SmallImage = MakeThumb(bytes, 350) '2
            i.ThumbImage = MakeThumb(bytes, 100) '3

            i.photoTitle = ""
            i.dateUploaded = Date.Now()
            i.uploadedBy = currentUser.Id
            i.fileName = file.GetName

            i.accountID = Request.QueryString("AccountID")
            db.tblAccountPhotos.InsertOnSubmit(i)
            db.SubmitChanges()

        Next

        'show/hide panels
        UploadPanel.Visible = False
        ViewPanel.Visible = True
        ButtonPanel.Visible = True


        PhotoListView.DataBind()

    End Sub

    Private Sub PhotoListView_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PhotoListView.ItemCommand
        If e.CommandName = "DeleteImage" Then

            Dim photoid As Integer = e.CommandArgument

            Try
                Dim deletephoto = db.DeleteAccountPhoto(photoid)

                PhotoListView.DataBind()
            Catch ex As Exception
                errorLabel.Text = ex.Message
            End Try


        End If
    End Sub


    Const sizeThumb As Integer = 100

    Public Shared Function MakeThumb(ByVal fullsize As Byte()) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim targetH, targetW As Integer

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image
        If (iOriginal.Height > iOriginal.Width) Then
            targetH = sizeThumb
            targetW = CInt(iOriginal.Width * (sizeThumb / iOriginal.Height))
        Else
            targetW = sizeThumb
            targetH = CInt(iOriginal.Height * (sizeThumb / iOriginal.Width))
        End If
        iThumb = iOriginal.GetThumbnailImage(targetW, targetH, Nothing, System.IntPtr.Zero)
        Dim m As New IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function


    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal newwidth As Integer, ByVal newheight As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scaleH, scaleW As Double
        Dim srcRect As Drawing.Rectangle


        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image

        scaleH = iOriginal.Height / newheight
        scaleW = iOriginal.Width / newwidth
        If scaleH = scaleW Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = iOriginal.Height
            srcRect.X = 0
            srcRect.Y = 0
        ElseIf (scaleH) > (scaleW) Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = CInt(newheight * scaleW)
            srcRect.X = 0
            srcRect.Y = CInt((iOriginal.Height - srcRect.Height) / 2)
        Else
            srcRect.Width = CInt(newwidth * scaleH)
            srcRect.Height = iOriginal.Height
            srcRect.X = CInt((iOriginal.Width - srcRect.Width) / 2)
            srcRect.Y = 0
        End If

        iThumb = New System.Drawing.Bitmap(newwidth, newheight)
        Dim g As Drawing.Graphics = Drawing.Graphics.FromImage(iThumb)
        g.DrawImage(iOriginal, New Drawing.Rectangle(0, 0, newwidth, newheight), srcRect, Drawing.GraphicsUnit.Pixel)

        Dim m As New IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function

    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal maxwidth As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scale As Double

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))

        If iOriginal.Width > maxwidth Then

            scale = iOriginal.Width / maxwidth
            Dim newheight As Integer = CInt(iOriginal.Height / scale)

            iThumb = New System.Drawing.Bitmap(iOriginal, maxwidth, newheight)
            Dim m As New IO.MemoryStream()
            iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
            Return m.GetBuffer()
        Else
            Return fullsize
        End If
    End Function

    Private Sub AddPhotoButton_Click(sender As Object, e As EventArgs) Handles AddPhotoButton.Click
        UploadPanel.Visible = True
        ViewPanel.Visible = False
        ButtonPanel.Visible = False
    End Sub

    Private Sub btnCancelUpload_Click(sender As Object, e As EventArgs) Handles btnCancelUpload.Click
        UploadPanel.Visible = False
        ViewPanel.Visible = True
        ButtonPanel.Visible = True
    End Sub

    Protected Function CreateWindowScript(ByVal accountID As Integer, ByVal photoID As Integer) As String
        Return String.Format("var win = window.radopen('/Accounts/PhotoDetails.aspx?AccountID={0}&PhotoID={1}','Details');win.center();", accountID, photoID)
    End Function

    Private Sub btnUpdateCoordinates_Click(sender As Object, e As EventArgs) Handles btnUpdateCoordinates.Click
        Dim address As String = String.Format("{0}, {1}, {2}, {3}", streetAddress1TextBox.Text.Replace("#", ""), cityTextBox.Text, DropDownListState.SelectedValue, zipCodeTextBox.Text)

        Dim latitude As String = getLatitude(address)
        Dim longitude As String = getLongitude(address)

        'update the address
        Dim newaddress = (From p In db.tblAccounts Where p.accountID = Request.QueryString("AccountID") Select p).FirstOrDefault
        newaddress.latitude = latitude
        newaddress.longitude = longitude

        db.SubmitChanges()

        'show success result

        Response.Redirect("/Accounts/AccountDetails?AccountID=" & Request.QueryString("AccountID"))
    End Sub

    Protected Property ImageWidth() As Unit

        Get
            Dim state As Object = If(ViewState("ImageWidth"), Unit.Pixel(150))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageWidth") = value
        End Set

    End Property

    Protected Property ImageHeight() As Unit
        Get
            Dim state As Object = If(ViewState("ImageHeight"), Unit.Pixel(150))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageHeight") = value
        End Set

    End Property

End Class