Imports Telerik.Web.UI
Imports BingGeocoder
Imports Microsoft.AspNet.Identity

Public Class AddAccount
    Inherits System.Web.UI.Page
    Dim tempAccountID As Integer
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            HiddenAccountID.Value = getNewAccountNumber()
        End If



    End Sub

    Private Sub AccountWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles AccountWizard.CancelButtonClick

        'delete all temp records
        ' Dim id = AccountIDTextBox.Text

        'AccountHours
        'AccountDemographics
        'AccountContacts


        'go back to the accounts page
        Response.Redirect("/Accounts/ViewAccounts")
    End Sub

    Private Sub AccountWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles AccountWizard.FinishButtonClick

        Dim clientID = "18"

        Try
            'save the account
            Dim account As New tblAccount
            account.accountID = HiddenAccountID.Value
            account.Vpid = getNewVPIDNumber()
            account.accountName = AccountNameTextBox.Text
            account.DBAName = CompanyNameTextBox.Text
            account.status = statusddl.SelectedValue
            account.accountTypeID = AccountTypeIDTextBox.SelectedValue
            account.distributorID = DistributorIDTextBox.Text

            account.streetAddress1 = streetAddress1TextBox.Text
            account.streetAddress2 = streetAddress2TextBox.Text
            account.city = cityTextBox.Text
            account.state = ddlState.SelectedValue
            account.zipCode = zipCodeTextBox.Text
            account.phone = PhoneTextBox.Text
            account.neighborhood = neighborhoodTextBox.Text
            account.marketID = marketIDddl.SelectedValue
            account.website = websiteTextBox.Text
            account.facebook = FacebookTextBox.Text
            account.twitter = TwitterTextBox.Text
            account.yelp = YelpTextBox.Text

            account.createdDate = Date.Now()
            account.createdBy = Context.User.Identity.GetUserId()
            account.modifiedDate = Date.Now()
            account.modifiedBy = Context.User.Identity.GetUserId()



            account.clientID = Convert.ToInt32(clientID)

            Dim address As String = String.Format("{0}, {1}, {2}, {3}", streetAddress1TextBox.Text, cityTextBox.Text, ddlState.SelectedValue, zipCodeTextBox.Text)

            account.latitude = getLatitude(address.Replace("#", ""))
            account.longitude = getLongitude(address.Replace("#", ""))

            db.tblAccounts.InsertOnSubmit(account)
            db.SubmitChanges()

            'do the rest of the items to add

            Dim details As New tblAccountDetail
            details.accountID = account.accountID
            details.capacity = capacityTextBox.Text
            details.traffic = trafficTextBox.Text
            details.bars = barsTextBox.Text
            details.barStations = barStationsTextBox.Text

            If patioSeatingCheckBox.Checked Then
                details.patioSeating = True
            Else
                details.patioSeating = False
            End If

            If liveMusicCheckBox.Checked Then
                details.liveMusic = True
            Else
                details.liveMusic = False
            End If

            If poolTablesCheckBox.Checked Then
                details.poolTables = True
            Else
                details.poolTables = False
            End If

            If dartsCheckBox.Checked Then
                details.darts = True
            Else
                details.darts = False
            End If

            If arcadeGamesCheckBox.Checked Then
                details.arcadeGames = True
            Else
                details.arcadeGames = False
            End If

            details.otherGames = otherGamesTextBox.Text

            db.tblAccountDetails.InsertOnSubmit(details)



            'save account hours
            Dim hours As New tblAccountHour
            hours.accountID = account.accountID
            hours.monOpen = monOpenTextBox.Text
            hours.monClose = monCloseTextBox.Text
            hours.tuesOpen = tuesOpenTextBox.Text
            hours.tuesClose = tuesCloseTextBox.Text

            hours.wedOpen = wedOpenTextBox.Text
            hours.wedClose = wedCloseTextBox.Text

            hours.thurOpen = thurOpenTextBox.Text
            hours.thurClose = thurCloseTextBox.Text

            hours.friOpen = friOpenTextBox.Text
            hours.friClose = friCloseTextBox.Text

            hours.satOpen = satOpenTextBox.Text
            hours.satClose = satCloseTextBox.Text

            hours.sunOpen = sunOpenTextBox.Text
            hours.sunClose = sunCloseTextBox.Text

            hours.monStart = monStartTextBox.Text
            hours.monEnd = monEndTextBox.Text

            hours.tuesStart = tuesStartTextBox.Text
            hours.tuesEnd = tuesEndTextBox.Text

            hours.wedStart = wedStartTextBox.Text
            hours.wedEnd = wedEndTextBox.Text

            hours.thurStart = thurStartTextBox.Text
            hours.thurEnd = thurEndTextBox.Text

            hours.friStart = friStartTextBox.Text
            hours.friEnd = friEndTextBox.Text

            hours.satStart = satStartTextBox.Text
            hours.satEnd = satEndTextBox.Text

            hours.sunStart = sunStartTextBox.Text
            hours.sunEnd = sunEndTextBox.Text

            db.tblAccountHours.InsertOnSubmit(hours)

            'save account demographics
            Dim d As New tblAccountDemographic
            d.accountID = account.accountID
            d.caucasian = caucasianTextBox.Text
            d.africanAmerican = africanAmericanTextBox.Text
            d.hispanic = hispanicTextBox.Text
            d.asian = asianTextBox.Text
            d.other = otherTextBox.Text
            d._21_25 = _21_25TextBox.Text
            d._26_30 = _26_30TextBox.Text
            d._31_35 = _31_35TextBox.Text
            d._36_40 = _36_40TextBox.Text
            d._40_ = _40_TextBox.Text
            d.income20to35 = income20to35TextBox.Text
            d.income36to50 = income36to50TextBox.Text
            d.income51to75 = income51to75TextBox.Text
            d.income76to100 = income76to100TextBox.Text
            d.income100plus = income100plusTextBox.Text
            d.female = femaleTextBox.Text
            d.male = maleTextBox.Text

            db.tblAccountDemographics.InsertOnSubmit(d)
            db.SubmitChanges()

            'go back to the accounts page
            Response.Redirect("/Accounts/ViewAccounts")
        Catch ex As Exception
            msgLabel.Text = Common.ShowAlertNoClose("danger", "There was an error saving the form. " & ex.Message())
        End Try

        Response.Redirect("/Accounts/ViewAccounts")

    End Sub

    Function getNewAccountNumber() As Integer
        Dim q = (From p In db.tblAccounts Order By p.accountID Descending Select p.accountID).FirstOrDefault
        Return q + 1
    End Function

    Function getNewVPIDNumber() As Integer
        Dim q = (From p In db.tblAccounts Order By p.Vpid Descending Select p.Vpid).FirstOrDefault
        Return q + 1
    End Function


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
End Class