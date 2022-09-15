Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI
Imports BingGeocoder
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.Net
Imports System.Web.Script.Serialization
Imports System.IO
Imports System.Xml.Linq

Public Class NewRequestedEvent
    Inherits System.Web.UI.Page
    Dim order As Integer = 0
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext


#Region "User Manager"
    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

#End Region

    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)
        generateDynamicControls()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        HiddenClientID.Value = Session("CurrentClientID")

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Or manager.IsInRole(currentUser.Id, "Client") Then
            Response.Redirect("/AccessDenied")
        End If


        If Not Page.IsPostBack Then
            statusIDTextBox.SelectedValue = "4"


            Dim requestedEventID = Request.QueryString("requestedEventID")
            Dim requestEvent = (From p In db.qryGetRequestedEvents Where p.requestedEventID = requestedEventID Select p).FirstOrDefault

            RequestByLabel.Text = requestEvent.CreatedBy
            RequestByEmailLabel.Text = requestEvent.CreatedByEmail

            eventTitleTextBox.Text = requestEvent.eventTitle
            supplierLabel.Text = requestEvent.supplierName

            Try
                Dim myEvent = (From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p).FirstOrDefault

                If myEvent.teamID = 0 Then
                    TeamComboBox.SelectedItem.Value = 0

                Else
                    TeamComboBox.SelectedValue = myEvent.teamID

                End If


            Catch ex As Exception

            End Try

            Dim brandsInRequestedEvent = (From p In db.tblBrandsInRequestedEvents Where p.requestedEventID = requestedEventID Select p.brandID).FirstOrDefault
            Dim brandsNames = (From p In db.tblBrands Where p.brandID = brandsInRequestedEvent Select p.brandName).FirstOrDefault

            supplierIdHiddenField.Value = (From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.supplierID).FirstOrDefault


            EventTypeIDTextBox.SelectedValue = (From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.eventTypeID).FirstOrDefault

            'account details from the supplier
            Dim txtLocation = (From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p).FirstOrDefault

            supplierAccountNameLabel.Text = (From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.locationName).FirstOrDefault
            supplierAccountAddressLabel.Text = (From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.locationAddress).FirstOrDefault
            supplierAccountCityStateLabel.Text = String.Format("{0}, {1}  {2}", txtLocation.locationCity, txtLocation.locationState, txtLocation.locationZip)

            'check if there is a match with the location
            If txtLocation.matchedLocationID = 0 Then

                noAccountLabel.Text = "Unable to match the requested event location. Use the search feature to look up and add the location."
                noAccountPanel.Visible = True

            Else

                Dim _city As String = (From p In db.tblAccounts Where p.Vpid = txtLocation.matchedLocationID Select p.city).FirstOrDefault
                Dim _state As String = (From p In db.tblAccounts Where p.Vpid = txtLocation.matchedLocationID Select p.state).FirstOrDefault
                Dim _zip As String = (From p In db.tblAccounts Where p.Vpid = txtLocation.matchedLocationID Select p.zipCode).FirstOrDefault

                LocationPanel.Visible = True
                ResultsPanel.Visible = False
                SearchPanel.Visible = False

                AccountNameLabel.Text = (From p In db.tblAccounts Where p.Vpid = txtLocation.matchedLocationID Select p.accountName).FirstOrDefault
                AccountAddressLabel.Text = (From p In db.tblAccounts Where p.Vpid = txtLocation.matchedLocationID Select p.streetAddress1).FirstOrDefault
                AccountCityStateLabel.Text = String.Format("{0}, {1}  {2}", _city, _state, _zip)

                HiddenLocationID.Value = txtLocation.matchedLocationID

            End If

            Try
                PositionCountTextBox.Text = (From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.BA_Count).FirstOrDefault

            Catch ex As Exception
                PositionCountTextBox.Text = 1
            End Try

            'date/time pickers
            StartDateTimePicker.DbSelectedDate = Format((From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.startTime).FirstOrDefault, "MM-dd-yyyy HH:mm")
            EventDatePicker.DbSelectedDate = Format((From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.eventDate).FirstOrDefault, "MM-dd-yyyy HH:mm")
            EndDateTimePicker.DbSelectedDate = Format((From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.endTime).FirstOrDefault, "MM-dd-yyyy HH:mm")

            'positions
            PositionStartTimePicker.DbSelectedDate = Format((From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.startTime).FirstOrDefault, "MM-dd-yyyy h:mm tt")
            PositionEndTimePicker.DbSelectedDate = Format((From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.endTime).FirstOrDefault, "MM-dd-yyyy h:mm tt")


            'event description
            eventDescriptionTextBox.Text = (From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.eventDescription).FirstOrDefault

            distributorTextBox.Text = (From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p.distributer).FirstOrDefault


        End If

    End Sub

    Private Sub MarketList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles MarketList.SelectedIndexChanged

        Try

            For Each column As GridColumn In ResultsGrid.MasterTableView.Columns
                column.CurrentFilterFunction = GridKnownFunction.NoFilter
                column.CurrentFilterValue = [String].Empty
            Next

            ResultsGrid.MasterTableView.FilterExpression = [String].Empty
            ResultsGrid.MasterTableView.Rebind()

            ResultsGrid.Visible = True
            ResultsPanel.Visible = True

            noAccountPanel.Visible = False



        Catch ex As Exception
            msgLabel.Text = ex.Message()
        End Try


    End Sub

    Protected Sub EventWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.CancelButtonClick

        Response.Redirect("/Events/ViewRequestedEvents")

    End Sub

    'Protected Sub EventWizard_NextButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.NextButtonClick
    '    e.NextStep.ValidationGroup = "location"
    '    e.NextStep.ValidationGroup = "eventdate"
    '    e.NextStep.ValidationGroup = "details"

    'End Sub

    Private Sub ResultsGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ResultsGrid.ItemCommand
        If e.CommandName = "SelectAccount" Then

            Dim id As Integer = e.CommandArgument

            Dim _city As String = (From p In db.tblAccounts Where p.Vpid = id Select p.city).FirstOrDefault
            Dim _state As String = (From p In db.tblAccounts Where p.Vpid = id Select p.state).FirstOrDefault
            Dim _zip As String = (From p In db.tblAccounts Where p.Vpid = id Select p.zipCode).FirstOrDefault

            LocationPanel.Visible = True
            ResultsPanel.Visible = False
            SearchPanel.Visible = False

            AccountNameLabel.Text = (From p In db.tblAccounts Where p.Vpid = id Select p.accountName).FirstOrDefault
            AccountAddressLabel.Text = (From p In db.tblAccounts Where p.Vpid = id Select p.streetAddress1).FirstOrDefault
            AccountCityStateLabel.Text = String.Format("{0}, {1}  {2}", _city, _state, _zip)

            HiddenLocationID.Value = id
        End If
    End Sub

    Private Sub btnRemoveAccount_Click(sender As Object, e As EventArgs) Handles btnRemoveAccount.Click

        LocationPanel.Visible = False
        ResultsPanel.Visible = True
        SearchPanel.Visible = True

        AccountNameLabel.Text = ""
        AccountAddressLabel.Text = ""
        AccountCityStateLabel.Text = ""

    End Sub

    Function getNewAccountNumber() As Integer
        Dim q = (From p In db.tblAccounts Order By p.accountID Descending Select p.accountID).FirstOrDefault
        Return q + 1
    End Function

    Function getNewVPIDNumber() As Integer
        Dim q = (From p In db.tblAccounts Order By p.Vpid Descending Select p.Vpid).FirstOrDefault
        Return q + 1
    End Function


    Private Sub EventWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.FinishButtonClick

        'add new event functions

        Dim vpid As Integer
        vpid = getNewVPIDNumber()

        Try
            'add new account
            If txtAccountName.Text IsNot "" Then
                'add new account
                Dim newaccount As New tblAccount
                newaccount.accountID = getNewAccountNumber()

                newaccount.Vpid = vpid

                newaccount.accountName = txtAccountName.Text
                newaccount.streetAddress1 = txtAddress1.Text
                newaccount.city = txtCity.Text
                newaccount.state = ddlState.SelectedValue
                newaccount.zipCode = txtZip.Text
                newaccount.phone = txtPhone.Text
                newaccount.accountTypeID = AccountTypeIDTextBox.SelectedValue
                newaccount.marketID = marketIDddl.SelectedValue
                newaccount.createdBy = Context.User.Identity.GetUserId()
                newaccount.createdDate = Date.Now()
                newaccount.modifiedBy = Context.User.Identity.GetUserId()
                newaccount.modifiedDate = Date.Now()

                Dim address As String = String.Format("{0}, {1}, {2}, {3}", txtAddress1.Text, txtCity.Text, ddlState.SelectedValue, txtZip.Text)

                newaccount.latitude = getLatitude(address)
                newaccount.longitude = getLongitude(address)

                db.tblAccounts.InsertOnSubmit(newaccount)
                db.SubmitChanges()


                'insert tblAccountHour
                Dim newHours As New tblAccountHour With {.accountID = newaccount.accountID}
                db.tblAccountHours.InsertOnSubmit(newHours)
                db.SubmitChanges()


                'insert tblAccountDemographic
                Dim newDemographic As New tblAccountDemographic With {.accountID = newaccount.accountID}
                db.tblAccountDemographics.InsertOnSubmit(newDemographic)
                db.SubmitChanges()


                'insert tblAccountDetail
                Dim newDetail As New tblAccountDetail With {.accountID = newaccount.accountID}
                db.tblAccountDetails.InsertOnSubmit(newDetail)
                db.SubmitChanges()



            End If


            'save the event
            Dim newevent As New tblEvent
            newevent.eventTitle = eventTitleTextBox.Text
            newevent.supplierID = supplierIdHiddenField.Value
            newevent.eventTypeID = EventTypeIDTextBox.SelectedValue
            newevent.statusID = statusIDTextBox.SelectedValue
            newevent.eventDescription = eventDescriptionTextBox.Text
            newevent.distributer = distributorTextBox.Text
            newevent.eventDate = EventDatePicker.SelectedDate
            newevent.startTime = StartDateTimePicker.SelectedDate
            newevent.endTime = EndDateTimePicker.SelectedDate
            newevent.attire = attireTextEditor.Content
            newevent.posRequirements = posRequirementsEditor.Content
            newevent.samplingNotes = samplingNotesRadEditor.Content
            newevent.posShippingAddress = POSShippingAddressTextBox.Text


            If TeamComboBox.SelectedIndex = -1 Then
                'do nothing
            Else
                newevent.teamID = TeamComboBox.SelectedValue

                Dim hasBA = (From p In db.tblProfiles Where p.teamID = newevent.teamID And p.IsStaff = 0 Select p.userName).Count
                If hasBA = 0 Then
                    newevent.statusID = 4 'set to Scheduled
                Else
                    newevent.statusID = 2 'set to Booked
                End If



            End If

            newevent.brandID = 0 'unused
            newevent.billableEvent = True

            'client ID
            Dim clientID = (From p In db.tblRequestedEvents Where p.requestedEventID = Request.QueryString("requestedEventID") Select p).FirstOrDefault
            newevent.clientID = clientID.clientID

            newevent.recapStatus = 0
            newevent.CreatedDate = Date.Now()
            newevent.CreatedBy = Session("CurrentUserID")
            newevent.Modified = 1

            Dim id = Request.QueryString("requestedEventID")
            Dim myEvent = (From p In db.tblRequestedEvents Where p.requestedEventID = id Select p).FirstOrDefault

            newevent.importFileID = myEvent.importFileID

            If myEvent.requestType = "Online" Then
                newevent.createdSource = 3  'set to Requested
                newevent.requestedBy = RequestByLabel.Text
            End If

            If myEvent.requestType = "Import" Then
                newevent.createdSource = 2  'set to Imported
                newevent.requestedBy = RequestByLabel.Text
            End If

            Try
                If txtAccountName.Text IsNot "" Then
                    newevent.locationID = vpid
                    newevent.marketID = marketIDddl.SelectedValue
                Else

                    Dim marketID2 As Integer
                    marketID2 = (From p In db.tblAccounts Where p.Vpid = HiddenLocationID.Value Select p.marketID).FirstOrDefault
                    newevent.marketID = marketID2
                    newevent.locationID = HiddenLocationID.Value

                End If
            Catch ex As Exception

            End Try


            db.tblEvents.InsertOnSubmit(newevent)
            db.SubmitChanges()



            'get brands from selected list
            Dim collection As IList(Of RadListBoxItem) = SelectedBrandsList.CheckedItems

            For Each item As RadListBoxItem In collection

                Dim neweventbrand As New tblBrandInEvent
                neweventbrand.eventID = newevent.eventID
                neweventbrand.brandID = item.Value

                db.tblBrandInEvents.InsertOnSubmit(neweventbrand)
                db.SubmitChanges()



            Next

            'add position to event

            Dim n = Convert.ToInt32(PositionCountTextBox.Text)

            Dim i As Integer

            For i = 0 To n - 1

                Dim position As New tblEventStaffingRequirement
                position.eventID = newevent.eventID
                position.positionID = ddlStaffingPositionID.SelectedValue
                position.startTime = PositionStartTimePicker.SelectedDate
                position.endTime = PositionEndTimePicker.SelectedDate
                position.rate = RateTextBox.Text

                position.billingRate = (From p In db.GetBillingRateBySupplier(newevent.supplierID, newevent.eventTypeID, ddlStaffingPositionID.SelectedValue, newevent.marketID) Select p.billingRate).FirstOrDefault

                position.assigned = False

                If newevent.teamID > 0 Then
                    position.assignedUserName = (From p In db.tblProfiles Where p.teamID = newevent.teamID And p.IsStaff = 0 Select p.userName).FirstOrDefault
                Else
                    'do nothing
                End If

                db.tblEventStaffingRequirements.InsertOnSubmit(position)
                db.SubmitChanges()

            Next

            'delete all eventCourse records
            db.deleteEventCourse(Convert.ToInt32(newevent.eventID))



            'get brands
            Dim r = From p In db.getCourseForEvents Where p.eventID = newevent.eventID Select p

            For Each p In r

                Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Order By l.SortOrder Select l

                If course.Count = 0 Then

                Else
                    For Each l In course

                        Dim newCourse As New tblEventCourse
                        newCourse.eventID = newevent.eventID
                        newCourse.CourseTitle = getBrandCourseGroupName(p.CourseTitle)

                        Dim _CurriculumLists = (From u In lmsdb.CurriculumLists Where u.CurriculumID = l.CurriculumID Select u).FirstOrDefault

                        Dim type = _CurriculumLists.ContentType
                        Dim _testID = _CurriculumLists.TestID

                        newCourse.contentID = _CurriculumLists.ContentType
                        newCourse.testID = _CurriculumLists.TestID

                        Dim icon As String = ""

                        Select Case type
                            Case "1"
                                icon = "<i class='fa fa-file-text-o' aria-hidden='True'></i>"

                                newCourse.icon = icon
                                newCourse.curriculumTitle = l.CurriculumTitle
                                newCourse.curriculumID = l.CurriculumID

                            Case "2"
                                icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

                                newCourse.icon = icon
                                newCourse.curriculumTitle = l.CurriculumTitle
                                newCourse.curriculumID = l.CurriculumID

                            Case "3"
                                icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

                                newCourse.icon = icon
                                newCourse.curriculumTitle = l.CurriculumTitle
                                newCourse.curriculumID = l.CurriculumID

                            Case "4"
                                icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                                newCourse.icon = icon
                                newCourse.curriculumTitle = l.CurriculumTitle
                                newCourse.curriculumID = l.CurriculumID

                            Case "5"
                                icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                                newCourse.icon = icon
                                newCourse.curriculumTitle = l.CurriculumTitle
                                newCourse.curriculumID = l.CurriculumID

                            Case "6"
                                icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                                newCourse.icon = icon
                                newCourse.curriculumTitle = l.CurriculumTitle
                                newCourse.curriculumID = l.CurriculumID

                            Case "7"
                                icon = "<i class='fa fa-check-square-o' aria-hidden='true'></i>"

                                newCourse.icon = icon
                                newCourse.curriculumTitle = l.CurriculumTitle
                                newCourse.curriculumID = l.CurriculumID

                        End Select

                        db.tblEventCourses.InsertOnSubmit(newCourse)
                        db.SubmitChanges()

                    Next

                End If


            Next

            Try
                db.UpdateBudgetQuestionEventID(Convert.ToInt32(Request.QueryString("requestedEventID")), newevent.eventID)
            Catch ex As Exception

            End Try


            'Dim question = From p In db.tblSupplierBudgetQuestionResults Where p.eventID = Request.QueryString("requestedEventID") Select p Order By p.order

            '' Dim question = From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("SupplierID") Select p Order By p.sortOrder

            'For Each p In question

            '    Dim NewSupplierBudgetQuestion As New tblSupplierBudgetQuestionResult

            '    NewSupplierBudgetQuestion.eventID = newevent.eventID
            '    NewSupplierBudgetQuestion.order = p.order
            '    NewSupplierBudgetQuestion.question = p.question
            '    NewSupplierBudgetQuestion.fieldType = p.fieldType
            '    NewSupplierBudgetQuestion.fieldID = p.fieldID


            '    Select Case p.fieldType
            '        Case "text"
            '            Dim txtbox As TextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.fieldID & "result"), TextBox)
            '            NewSupplierBudgetQuestion.answer = txtbox.Text


            '        Case "multiline"
            '            Dim txtbox As TextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.fieldID & "result"), TextBox)
            '            NewSupplierBudgetQuestion.answer = txtbox.Text
            '            NewSupplierBudgetQuestion.rows = p.rows

            '        Case "choice"

            '            Try
            '                Dim txtbox As RadComboBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.fieldID & "result"), RadComboBox)
            '                NewSupplierBudgetQuestion.answer = txtbox.SelectedValue


            '            Catch ex As Exception
            '                NewSupplierBudgetQuestion.answer = "error"
            '            End Try


            '        Case "number"
            '            Dim txtbox As RadNumericTextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.fieldID & "result"), RadNumericTextBox)
            '            NewSupplierBudgetQuestion.answer = txtbox.Text

            '        Case "date"
            '            Dim txtbox As RadDatePicker = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.fieldID & "result"), RadDatePicker)
            '            NewSupplierBudgetQuestion.answer = txtbox.SelectedDate


            '        Case "time"
            '            Dim txtbox As RadTimePicker = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.fieldID & "result"), RadTimePicker)
            '            NewSupplierBudgetQuestion.answer = txtbox.SelectedDate

            '        Case "currency"
            '            Dim txtbox As RadNumericTextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.fieldID & "result"), RadNumericTextBox)
            '            NewSupplierBudgetQuestion.answer = txtbox.Text

            '        Case "yes/no"
            '            Try
            '                Dim txtbox As RadioButtonList = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.fieldID & "result"), RadioButtonList)
            '                NewSupplierBudgetQuestion.answer = txtbox.SelectedItem.Value
            '            Catch ex As Exception

            '            End Try


            '    End Select
            '    db.tblSupplierBudgetQuestionResults.InsertOnSubmit(NewSupplierBudgetQuestion)
            '    db.SubmitChanges()
            'Next


            'Dim insertlog = db.InsertEventLog(newevent.eventID, "Event Created", "The event was created.", Context.User.Identity.GetUserId(), Date.Now())

            Dim type2 = (From p In db.tblRequestedEvents Where p.requestedEventID = Request.QueryString("requestedEventID") Select p).FirstOrDefault

            If type2.requestType = "Online" Then

                Dim insertlog = db.InsertEventLog(newevent.eventID, "Event Created", "The event was created from online request type. It's was reqested by " & type2.CreatedBy & " on " & type2.CreatedDate & ".", Context.User.Identity.GetUserId(), Date.Now())

            End If


            If type2.requestType = "Import" Then

                Dim insertlog = db.InsertEventLog(newevent.eventID, "Event Created", "The event was created from import request type. It's was imported by " & type2.CreatedBy & " on " & type2.CreatedDate & ".", Context.User.Identity.GetUserId(), Date.Now())

            End If

            Try
                Dim result = (From p In db.qryViewEvents Where p.eventID = newevent.eventID Select p).FirstOrDefault

                Dim xmlDoc As XDocument = XDocument.Load(Server.MapPath("\Documents\Events.xml"))

                Dim root As New XElement("Event", New XAttribute("EventID", newevent.eventID),
                                     New XAttribute("CreatedDate", DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss")),
                                     New XAttribute("CreatedBy", Common.GetFullName(newevent.CreatedBy)),
                                     New XAttribute("Source", type2.requestType),
                                     New XElement("Details",
                                                  New XElement("EventDate", newevent.eventDate),
                                                  New XElement("EventTitle", newevent.eventTitle),
                                                  New XElement("Supplier", result.supplierName),
                                                  New XElement("Market", result.marketName),
                                                  New XElement("Brands", result.brands),
                                                  New XElement("EventType", result.eventTypeName),
                                                  New XElement("Location",
                                                               New XElement("Name", result.accountName),
                                                               New XElement("Address", result.address),
                                                               New XElement("City", result.city),
                                                               New XElement("State", result.state))
                                                               ))

                xmlDoc.Root.Add(root)
                xmlDoc.Save(Server.MapPath("\Documents\Events.xml"))
            Catch ex As Exception
                ' MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error adding to xml file", ex.Message())
            End Try


            'delete the event from tblRequestedEvent
            Dim requestedEventID As Integer = Request.QueryString("requestedEventID")

            db.DeleteRequestedEvent(requestedEventID, newevent.eventID)


            'go to the event page
            Response.Redirect("/Events/ViewRequestedEvents")

        Catch ex As Exception
            ' msgLabel.Text = ex.Message.ToString()

        End Try


    End Sub

    Function getBrandCourseGroupName(groupID As String) As String
        Return (From p In lmsdb.CurriculumGroups Where p.CurriculumGroupID = groupID Select p.Title).FirstOrDefault

    End Function

    Function getBrandName(id As Integer) As String
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function

    Function getPPS(id As Integer) As String
        Dim pps = (From p In db.tblBrands Where p.brandID = id Select p.packageSize).FirstOrDefault

        If pps = "" Then
            Return "bottles"
        Else
            Return pps & " bottles"
        End If

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

    Private Sub EventTypeIDTextBox_SelectedIndexChanged(sender As Object, e As EventArgs) Handles EventTypeIDTextBox.SelectedIndexChanged

        ' get a list of brands
        'For Each item As RadListBoxItem In SelectedBrandsList.Items

        '    Dim attireText As String = attireTextEditor.Content & String.Format("<b>{0}:</b><br />{1}<br /><br />", getBrandName(item.Value), (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDTextBox.SelectedValue Select p.attire).FirstOrDefault)

        '    attireTextEditor.Content = attireText ' .ToString() '.Replace("<br />", Environment.NewLine)

        '    Dim posRequirementsText As String = posRequirementsEditor.Content & String.Format("<b>{0}</b>:<br />{1}<br /><br />", getBrandName(item.Value), (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDTextBox.SelectedValue Select p.pos).FirstOrDefault)

        '    posRequirementsEditor.Content = posRequirementsText '.ToString().Replace("<br />", Environment.NewLine)

        '    Dim samplingNotesText As String = samplingNotesRadEditor.Content & String.Format("<b>{0}</b>:<br />{1}<br /><br />", getBrandName(item.Value), (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDTextBox.SelectedValue Select p.samplingInstructions).FirstOrDefault)

        '    samplingNotesRadEditor.Content = samplingNotesText '.ToString().Replace("<br />", Environment.NewLine)

        'Next


        Dim collection As IList(Of RadListBoxItem) = SelectedBrandsList.CheckedItems
        ' get a list of brands
        For Each item As RadListBoxItem In collection

            Dim attire_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDTextBox.SelectedValue Select p.attire).FirstOrDefault

            If attire_Text = "" Then
                'do nothing
            Else
                Dim attireText As String = attireTextEditor.Content & String.Format("<p><b>{0}:</b> {1}</p>", getBrandName(item.Value), attire_Text)
                attireTextEditor.Content = attireText
            End If



            Dim posRequirements_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDTextBox.SelectedValue Select p.pos).FirstOrDefault

            If posRequirements_Text = "" Then
                'do nothing
            Else
                Dim posRequirementsText As String = posRequirementsEditor.Content & String.Format("<p><b>{0}</b>: {1}</p>", getBrandName(item.Value), posRequirements_Text)
                posRequirementsEditor.Content = posRequirementsText '.ToString().Replace("<br />", Environment.NewLine)
            End If




            Dim samplingNotes_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDTextBox.SelectedValue Select p.samplingInstructions).FirstOrDefault

            If samplingNotes_Text = "" Then
                'do nothing
            Else
                Dim samplingNotesText As String = samplingNotesRadEditor.Content & String.Format("<p><b>{0}</b>: {1}</p>", getBrandName(item.Value), samplingNotes_Text)
                samplingNotesRadEditor.Content = samplingNotesText '.ToString().Replace("<br />", Environment.NewLine)
            End If



        Next


        '
    End Sub

    Private Sub btnAddNewLocation_Click(sender As Object, e As EventArgs) Handles btnAddNewLocation.Click

        LocationPanel.Visible = False
        ResultsPanel.Visible = False
        SearchPanel.Visible = False

        AddLocationPanel.Visible = True

        Try
            'populate the textboxes
            Dim requestedEventID = Request.QueryString("requestedEventID")
            Dim requestEvent = (From p In db.tblRequestedEvents Where p.requestedEventID = requestedEventID Select p).FirstOrDefault

            txtAccountName.Text = requestEvent.locationName
            txtAddress1.Text = requestEvent.locationAddress
            txtCity.Text = requestEvent.locationCity
            ddlState.SelectedValue = requestEvent.locationState.Trim()
            txtZip.Text = requestEvent.locationZip
        Catch ex As Exception

        End Try



    End Sub

    Private Sub btnCancelAddAccount_Click(sender As Object, e As EventArgs) Handles btnCancelAddAccount.Click
        LocationPanel.Visible = False
        ResultsPanel.Visible = False
        SearchPanel.Visible = True

        AddLocationPanel.Visible = False
        MarketList.ClearSelection()

    End Sub

    Protected Sub EventDatePicker_SelectedDateChanged(sender As Object, e As Calendar.SelectedDateChangedEventArgs)

        StartDateTimePicker.DbSelectedDate = EventDatePicker.SelectedDate
        EndDateTimePicker.DbSelectedDate = EventDatePicker.SelectedDate
        PositionStartTimePicker.DbSelectedDate = EventDatePicker.SelectedDate

    End Sub

    Protected Sub StartDateTimePicker_SelectedDateChanged(sender As Object, e As Calendar.SelectedDateChangedEventArgs)

        PositionStartTimePicker.DbSelectedDate = StartDateTimePicker.SelectedDate

    End Sub

    Protected Sub EndDateTimePicker_SelectedDateChanged(sender As Object, e As Calendar.SelectedDateChangedEventArgs)

        PositionEndTimePicker.DbSelectedDate = EndDateTimePicker.SelectedDate

    End Sub

    Protected Sub ddlStaffingPositionID_SelectedIndexChanged(sender As Object, e As EventArgs)
        RateTextBox.Text = (From p In db.tblStaffingPositions Where p.staffingPositionID = ddlStaffingPositionID.SelectedValue Select p.payRate).FirstOrDefault
    End Sub

    Protected Sub btnSelect_Click(sender As Object, e As EventArgs)
        selectedAccountMsg.Text = Common.ShowAlert("success", "You've selected the account! Click Next.")
    End Sub



    Private Sub LogEvent(ByVal sender As Object, ByVal eventName As String, ByVal items As IEnumerable(Of RadListBoxItem))

        Dim affectedItems As New List(Of String)()

        For Each item As RadListBoxItem In items
            affectedItems.Add(item.Value)
        Next

        Dim message As String = String.Format("{0}", affectedItems.ToArray())
        HF_SelectedItemID.Value = message

    End Sub

    'Protected Sub SelectedBrandsList_Inserted1(sender As Object, e As RadListBoxEventArgs)
    '    Try
    '        'get the brandID
    '        LogEvent(sender, "Inserted", e.Items)

    '        Dim requestedEventID As Integer = Request.QueryString("requestedEventID")
    '        Dim selectedValue As Integer = HF_SelectedItemID.Value

    '        'insert the item
    '        db.InsertRequestedEventBrand(requestedEventID, selectedValue)
    '        db.SubmitChanges()

    '        msgLabel.Text = ""

    '        Dim InsertedBrandName = (From p In db.tblBrands Where p.brandID = selectedValue Select p.brandName).FirstOrDefault

    '        'set the event details with modified = true
    '        Dim NeedRefresh = (From p In db.tblRequestedEvents Where p.requestedEventID = Request.QueryString("requestedEventID") Select p).FirstOrDefault
    '        NeedRefresh.Modified = True
    '        db.SubmitChanges()


    '        Dim insertlog = db.InsertEventLog(Request.QueryString("requestedEventID"), "Brand Inserted", InsertedBrandName & " was added to the event.", Context.User.Identity.GetUserId(), Date.Now())

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try
    'End Sub

    'Protected Sub SelectedBrandsList_Deleted1(sender As Object, e As RadListBoxEventArgs)
    '    Try
    '        'get the brandID
    '        LogEvent(sender, "Deleted", e.Items)

    '        Dim requestedEventID As Integer = Request.QueryString("requestedEventID")
    '        Dim selectedValue As Integer = HF_SelectedItemID.Value

    '        'delete the item
    '        db.DeleteRequestedEventBrand(requestedEventID, selectedValue)
    '        db.SubmitChanges()

    '        msgLabel.Text = ""

    '        Dim DeletedBrandName = (From p In db.tblBrands Where p.brandID = selectedValue Select p.brandName).FirstOrDefault

    '        'remove recap questions for the deleted brand
    '        '  Dim deleteRecap = db.DeleteBrandRecapQuestionsByEvent(eventID, selectedValue)

    '        Dim NeedRefresh = (From p In db.tblRequestedEvents Where p.requestedEventID = Request.QueryString("requestedEventID") Select p).FirstOrDefault
    '        NeedRefresh.Modified = True
    '        db.SubmitChanges()


    '        Dim insertlog = db.InsertEventLog(Request.QueryString("requestedEventID"), "Brand Deleted", DeletedBrandName & " was deleted from the event.", Context.User.Identity.GetUserId(), Date.Now())

    '        Dim AssociatedBrandsList As RadListBox = CType(MainPanel.FindControl("AssociatedBrandsList"), RadListBox)
    '        AssociatedBrandsList.DataBind()

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try
    'End Sub

    Private Sub SelectedBrandsList_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles SelectedBrandsList.ItemDataBound

        Dim s = From p In db.getBrandsInRequestedEvent(Request.QueryString("requestedEventID")) Select p

        For Each p In s


            Dim collection2 As IList(Of RadListBoxItem) = SelectedBrandsList.Items

            For Each item As RadListBoxItem In collection2

                Try
                    Dim itemToSelect As RadListBoxItem = SelectedBrandsList.FindItemByValue(p.brandID)
                    itemToSelect.Checked = True

                Catch ex As Exception

                End Try

            Next


        Next



        'aditional details
        Dim collection As IList(Of RadListBoxItem) = SelectedBrandsList.CheckedItems
        ' get a list of brands
        For Each item As RadListBoxItem In collection

            Dim attire_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDTextBox.SelectedValue Select p.attire).FirstOrDefault

            If attire_Text = "" Then
                'do nothing
            Else
                attireTextEditor.Content = ""
                Dim attireText As String = attireTextEditor.Content & String.Format("<p><b>{0}:</b> {1}</p>", getBrandName(item.Value), attire_Text)
                attireTextEditor.Content = attireText
            End If



            Dim posRequirements_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDTextBox.SelectedValue Select p.pos).FirstOrDefault

            If posRequirements_Text = "" Then
                'do nothing
            Else
                posRequirementsEditor.Content = ""
                Dim posRequirementsText As String = posRequirementsEditor.Content & String.Format("<p><b>{0}</b>: {1}</p>", getBrandName(item.Value), posRequirements_Text)
                posRequirementsEditor.Content = posRequirementsText '.ToString().Replace("<br />", Environment.NewLine)
            End If




            Dim samplingNotes_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDTextBox.SelectedValue Select p.samplingInstructions).FirstOrDefault

            If samplingNotes_Text = "" Then
                'do nothing
            Else
                samplingNotesRadEditor.Content = ""
                Dim samplingNotesText As String = samplingNotesRadEditor.Content & String.Format("<p><b>{0}</b>: {1}</p>", getBrandName(item.Value), samplingNotes_Text)
                samplingNotesRadEditor.Content = samplingNotesText '.ToString().Replace("<br />", Environment.NewLine)
            End If



        Next

    End Sub

    Private Sub CreateLabelControl(id As String, labelText As String)

        Dim div As New HtmlGenericControl("div")

        Dim lbl As New HtmlGenericControl("h3")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateTextboxControl(id As String, labelText As String, description As String, required As Boolean, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        'add required field
        If required = True Then
            labelText = labelText & "<span class='text-danger'>*</span>"
        End If

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        div.Controls.Add(lbl)

        Dim div1 As New HtmlGenericControl("div")
        div1.Attributes.Add("class", "col-sm-5")
        div.Controls.Add(div1)

        ' Create a text box control
        Dim box As New TextBox
        box.CssClass = "form-control"
        box.ID = "text" & id & "result"
        box.Text = answer
        div1.Controls.Add(box)

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div1.Controls.Add(span)

        'If required = True Then
        '    Dim validate As New RequiredFieldValidator
        '    validate.CssClass = "errorlabel"
        '    validate.SetFocusOnError = True
        '    validate.ID = "RequiredField" & "text" & id & "result"
        '    validate.ControlToValidate = "text" & id & "result"
        '    validate.Display = ValidatorDisplay.Dynamic
        '    validate.ErrorMessage = "This is a required field!"
        '    validate.ValidationGroup = "Recap"

        '    div.Controls.Add(validate)
        'End If

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateMultilineTextboxControl(id As String, labelText As String, rows As Integer)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div1 As New HtmlGenericControl("div")
        div1.Attributes.Add("class", "col-sm-6")
        div.Controls.Add(div1)

        ' Create a text box control
        Dim box As New TextBox
        box.CssClass = "form-control"
        box.TextMode = TextBoxMode.MultiLine
        box.Text = ""
        box.Rows = rows
        box.ID = "text" & id & "result"

        div1.Controls.Add(box)

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateNumberboxControl(id As String, labelText As String, defaultValue As String, numberDecimalPlaces As Integer)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)



        Dim div2 As New HtmlGenericControl("div")
        div2.Attributes.Add("class", "col-sm-6")

        ' Create a text box control
        Dim box As New RadNumericTextBox
        box.ShowSpinButtons = "true"
        box.NumberFormat.DecimalDigits = numberDecimalPlaces
        box.Width = 100
        box.ID = "text" & id & "result"
        box.Value = defaultValue
        div2.Controls.Add(box)
        div.Controls.Add(div2)

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateDateControl(id As String, labelText As String, dateValue As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")
        div2.Attributes.Add("class", "col-sm-6")

        ' Create a text box control
        Dim box As New RadDatePicker
        box.Width = 150
        box.ID = "text" & id & "result"

        If dateValue = "None" Then
            'do nothing
        End If

        If dateValue = "Current" Then
            box.DbSelectedDate = Date.Now()
        End If


        div2.Controls.Add(box)
        div.Controls.Add(div2)

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateTimeControl(id As String, labelText As String, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")
        div2.Attributes.Add("class", "col-sm-6")

        ' Create a text box control
        Dim box As New RadTimePicker
        box.Width = 100
        box.ID = "text" & id & "result"


        ' box.DbSelectedDate = ""


        div2.Controls.Add(box)
        div.Controls.Add(div2)

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateCurrencyControl(id As String, labelText As String, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")
        div2.Attributes.Add("class", "col-sm-6")

        ' Create a text box control
        Dim box As New RadNumericTextBox
        box.ShowSpinButtons = "true"
        box.Width = 100
        box.ID = "text" & id & "result"
        box.Type = NumericType.Currency
        box.MinValue = 0
        box.Text = answer
        div2.Controls.Add(box)
        div.Controls.Add(div2)

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateYesNoControl(id As String, labelText As String, questionID As String, description As String, answer As String)

        Try
            Dim div As New HtmlGenericControl("div")
            div.Attributes.Add("class", "form-group")

            Dim lbl As New HtmlGenericControl("label")
            lbl.Attributes.Add("class", "col-sm-3 control-label")
            lbl.InnerHtml = labelText
            div.Controls.Add(lbl)

            Dim div2 As New HtmlGenericControl("div")
            div2.Attributes.Add("class", "col-sm-6")

            ' Create a text box control
            Dim ddl As New RadioButtonList
            ' ddl.CssClass = "form-control combobox"
            ddl.Width = 200
            ddl.ID = "text" & id & "result"
            ddl.Items.Add(New ListItem("Yes", "Yes"))
            ddl.Items.Add(New ListItem("No", "No"))

            If answer = "Yes" Then
                ddl.SelectedIndex = 0
            ElseIf answer = "No" Then
                ddl.SelectedIndex = 1
            Else
                ddl.SelectedIndex = 1
            End If


            div2.Controls.Add(ddl)
            div.Controls.Add(div2)

            Dim span As New HtmlGenericControl("span")
            span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
            div.Controls.Add(span)

            SupplierBudgetPlaceHolder.Controls.Add(div)
        Catch ex As Exception

        End Try

    End Sub



    Private Sub CreateComboboxControl(id As String, labelText As String, answer As String, description As String, required As Boolean, displayOption As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        'add required field
        If required = True Then
            labelText = labelText & "<span class='text-danger'>*</span>"
        End If

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div1 As New HtmlGenericControl("div")
        div1.Attributes.Add("class", "col-sm-6")
        div.Controls.Add(div1)

        Select Case displayOption
            Case "drop"

                ' Create a text box control
                Dim ddl As New RadComboBox
                ' ddl.CssClass = "form-control combobox"
                ddl.ID = "text" & id & "result"
                ddl.Width = 200
                ddl.Items.Add(New RadComboBoxItem("-- Select --", ""))

                Dim q = From a In db.tblSupplierBudgetQuestionOptions Where a.supplierBudgetQuestionID = id Select a Order By a.sortOrder
                For Each a In q
                    ddl.Items.Add(New RadComboBoxItem(a.option, a.optionID))
                Next

                ddl.SelectedValue = answer

                div1.Controls.Add(ddl)

            Case "check"
                Dim clb As New CheckBoxList
                clb.ID = "text" & id & "result"

                Dim q = From a In db.tblSupplierBudgetQuestionOptions Where a.supplierBudgetQuestionID = id Select a Order By a.sortOrder
                For Each a In q
                    ' clb.Items.Add(New ListItem(a.option, a.option))

                    Dim selectedItem As New ListItem(a.option, a.optionID)
                    ' selectedItem.Selected = getanswer(answer, a.option)
                    clb.Items.Add(selectedItem)

                Next

            Case "radio"

                Dim clb As New RadioButtonList
                'clb.CssClass = "form-control combobox"
                ' clb.Width = 200
                clb.ID = "text" & id & "result"
                ' ddl.Items.Add(New RadComboBoxItem("-- Select --", ""))

                Dim q = From a In db.tblSupplierBudgetQuestionOptions Where a.supplierBudgetQuestionID = id Select a Order By a.sortOrder
                For Each a In q
                    clb.Items.Add(New ListItem(a.option, a.optionID))
                Next

                clb.SelectedIndex = answer

                '  clb.SelectedValue = answer

                div1.Controls.Add(clb)

        End Select

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div.Controls.Add(span)

        'If required = True Then
        '    Dim validate As New RequiredFieldValidator
        '    validate.CssClass = "errorlabel"
        '    validate.SetFocusOnError = True
        '    validate.ID = "RequiredField" & "text" & id & "result"
        '    validate.ControlToValidate = "text" & id & "result"
        '    validate.Display = ValidatorDisplay.Dynamic
        '    validate.ErrorMessage = "This is a required field!"
        '    validate.ValidationGroup = "Recap"

        '    div.Controls.Add(validate)
        'End If

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

#Region "Dynamic Methods"
    Public Sub generateDynamicControls()
        'get the fields from the supplierBudget type
        Dim question = From p In db.tblSupplierBudgetQuestionResults Where p.eventID = Request.QueryString("requestedEventID") Select p Order By p.order

        For Each p In question

            Select Case p.fieldType
                Case "label"
                    CreateLabelControl(p.supplierBudgetQuestionResultID, p.question)

                Case "text"
                    CreateTextboxControl(p.supplierBudgetQuestionResultID, p.question, p.description, False, p.answer)

                'Case "choice"
                '    CreateComboboxControl(p.supplierBudgetQuestionResultID, p.question, "", p.description, False, p.displayOption)

                'Case "multiline"
                '    CreateMultilineTextboxControl(p.supplierBudgetQuestionResultID, p.question, p.lines)

                Case "number"
                    CreateNumberboxControl(p.supplierBudgetQuestionResultID, p.question, p.numberDefaultValue, p.numberDecimalPlace)

                Case "date"
                    CreateDateControl(p.supplierBudgetQuestionResultID, p.question, p.dateDefaultValue)

                Case "time"
                    CreateTimeControl(p.supplierBudgetQuestionResultID, p.question, p.timeFormat)

                Case "currency"
                    CreateCurrencyControl(p.supplierBudgetQuestionResultID, p.question, p.numberDefaultValue)

                Case "yes/no"
                    CreateYesNoControl(p.supplierBudgetQuestionResultID, p.question, p.supplierBudgetQuestionResultID, p.description, p.yes_noDefaultValue)
            End Select



        Next

    End Sub
#End Region

End Class