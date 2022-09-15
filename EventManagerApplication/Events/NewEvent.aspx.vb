Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI
Imports BingGeocoder
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.Xml.Linq

Public Class NewEvent
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
        HiddenClientID.Value = Common.GetCurrentClientID() 'Session("CurrentClientID")

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Or manager.IsInRole(currentUser.Id, "Client") Then
            Response.Redirect("/AccessDenied")
        End If

        If Not Page.IsPostBack Then

            Try
                Dim myReferrer = HttpContext.Current.Request.UrlReferrer.AbsolutePath.ToString()

                If myReferrer <> "/Events/AddNewEvent" Or Nothing Then
                    Response.Redirect("/Events/AddNewEvent")
                End If
            Catch ex As Exception
                Response.Redirect("/Events/AddNewEvent")
            End Try


            'statusIDComboBox.SelectedValue = "4"

            supplierIDComboBox.SelectedValue = Request.QueryString("supplierID")

            eventTitleTextBox.Text = Session("EventName")
            Session.Remove("EventName")

            Try
                EventTypeIDComboBox.SelectedValue = Session("EventTypeID")
                Session.Remove("EventTypeID")
            Catch ex As Exception

            End Try

            Try
                TeamComboBox.SelectedValue = Session("TeamID")
                Session.Remove("TeamID")
            Catch ex As Exception

            End Try



        End If



        If Request.QueryString("AccountID") IsNot Nothing Then

            SearchPanel.Visible = False
            LocationPanel.Visible = True


            'populate the LocationPanel (selected account panel)
            Dim id As Integer = Request.QueryString("AccountID")

            Dim _city As String = (From p In db.tblAccounts Where p.accountID = id Select p.city).FirstOrDefault
            Dim _state As String = (From p In db.tblAccounts Where p.accountID = id Select p.state).FirstOrDefault
            Dim _zip As String = (From p In db.tblAccounts Where p.accountID = id Select p.zipCode).FirstOrDefault

            AccountNameLabel.Text = (From p In db.tblAccounts Where p.accountID = id Select p.accountName).FirstOrDefault
            AccountAddressLabel.Text = (From p In db.tblAccounts Where p.accountID = id Select p.streetAddress1).FirstOrDefault
            AccountCityStateLabel.Text = String.Format("{0}, {1}  {2}", _city, _state, _zip)

            HiddenLocationID.Value = id


            btnRemoveAccount.Visible = False

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



        Catch ex As Exception
            msgLabel.Text = ex.Message()
        End Try


    End Sub

    Protected Sub EventWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.CancelButtonClick

        If Request.QueryString("AccountID") IsNot Nothing Then

            Response.Redirect(String.Format("/Accounts/AccountDetails?AccountID={0}", Request.QueryString("AccountID")))

        Else
            'cancel the wizard and return to the event list
            Response.Redirect("/Events/ViewEvents")
        End If

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


                'add weather for the new event location
                Common.InsertWeather(txtCity.Text, ddlState.SelectedValue, txtCity.Text & ", " & ddlState.SelectedValue)



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
            newevent.supplierID = Request.QueryString("SupplierID")
            newevent.eventTypeID = EventTypeIDComboBox.SelectedValue
            newevent.statusID = 4
            newevent.eventDescription = eventDescriptionTextBox.Content
            newevent.eventDate = EventDatePicker.SelectedDate
            newevent.startTime = StartDateTimePicker.SelectedDate
            newevent.endTime = EndDateTimePicker.SelectedDate
            newevent.attire = attireTextEditor.Content
            newevent.posRequirements = posRequirementsEditor.Content
            newevent.samplingNotes = samplingNotesRadEditor.Content
            'newevent.posShippingAddress = POSShippingAddressTextBox.Text

            Try
                If PONumberComboBox.SelectedIndex = -1 Then
                    'do nothing
                Else
                    newevent.purchaseOrderNumber = PONumberComboBox.SelectedValue
                End If
            Catch ex As Exception

            End Try

            newevent.distributer = DistributorTextBox.Text
            newevent.requestedBy = RequestedTextBox.Text

            Try
                If TeamComboBox.SelectedIndex = -1 Then
                    'do nothing
                Else
                    newevent.teamID = TeamComboBox.SelectedValue
                End If
            Catch ex As Exception

            End Try


            newevent.brandID = 0 'unused
            newevent.billableEvent = True

            Try
                Dim clientID = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault

                newevent.clientID = clientID.clientID
            Catch ex As Exception
                newevent.clientID = Common.GetCurrentClientID()

                MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error", "There was a problen retrieving the client id")

            End Try


            newevent.recapStatus = 0
            newevent.CreatedDate = Date.Now()
            newevent.CreatedBy = Context.User.Identity.GetUserId()
            newevent.Modified = 1

            If txtAccountName.Text IsNot "" Then
                newevent.locationID = vpid
                newevent.marketID = marketIDddl.SelectedValue
            Else
                newevent.marketID = MarketList.SelectedValue
                newevent.locationID = HiddenLocationID.Value

                Try
                    Dim l = (From p In db.tblAccounts Where p.accountID = HiddenLocationID.Value Select p).FirstOrDefault

                    Common.InsertWeather(l.city, l.state, l.city & ", " & l.state)
                Catch ex As Exception

                End Try


            End If

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

                'get the billing rate
                position.billingRate = (From p In db.GetBillingRateBySupplier(newevent.supplierID, newevent.eventTypeID, ddlStaffingPositionID.SelectedValue, newevent.marketID) Select p.billingRate).FirstOrDefault

                position.assigned = False

                db.tblEventStaffingRequirements.InsertOnSubmit(position)
                db.SubmitChanges()


            Next

            'delete all eventCourse records
            db.deleteEventCourse(Convert.ToInt32(newevent.eventID))

            'get brands
            Dim r = From p In db.getCourseForEvents Where p.eventID = newevent.eventID Select p

            For Each p In r

                Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum And l.Enabled = True Order By l.SortOrder Select l

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

            'add SupplierBudgetQuestions


            'get the fields from the supplierBudget type
            Dim question = From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("SupplierID") Select p Order By p.sortOrder

            For Each p In question

                Dim NewSupplierBudgetQuestion As New tblSupplierBudgetQuestionResult

                NewSupplierBudgetQuestion.eventID = newevent.eventID
                NewSupplierBudgetQuestion.order = p.sortOrder
                NewSupplierBudgetQuestion.question = p.question
                NewSupplierBudgetQuestion.fieldType = p.questionType
                NewSupplierBudgetQuestion.fieldID = p.supplierBudgetQuestionID



                Select Case p.questionType
                    Case "text"
                        Dim txtbox As TextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), TextBox)
                        NewSupplierBudgetQuestion.answer = txtbox.Text


                    Case "multiline"
                        Dim txtbox As TextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), TextBox)
                        NewSupplierBudgetQuestion.answer = txtbox.Text
                        NewSupplierBudgetQuestion.rows = p.lines

                    Case "choice"

                        Try
                            Dim txtbox As RadComboBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadComboBox)
                            NewSupplierBudgetQuestion.answer = txtbox.SelectedValue


                        Catch ex As Exception
                            NewSupplierBudgetQuestion.answer = "error"
                        End Try


                    Case "number"
                        Dim txtbox As RadNumericTextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadNumericTextBox)
                        NewSupplierBudgetQuestion.answer = txtbox.Text

                    Case "date"
                        Dim txtbox As RadDatePicker = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadDatePicker)
                        NewSupplierBudgetQuestion.answer = txtbox.SelectedDate


                    Case "time"
                        Dim txtbox As RadTimePicker = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadTimePicker)
                        NewSupplierBudgetQuestion.answer = txtbox.SelectedDate

                    Case "currency"
                        Dim txtbox As RadNumericTextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadNumericTextBox)
                        NewSupplierBudgetQuestion.answer = txtbox.Text

                    Case "yes/no"
                        Try
                            Dim txtbox As RadioButtonList = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadioButtonList)
                            NewSupplierBudgetQuestion.answer = txtbox.SelectedItem.Value
                        Catch ex As Exception

                        End Try


                End Select
                db.tblSupplierBudgetQuestionResults.InsertOnSubmit(NewSupplierBudgetQuestion)
                db.SubmitChanges()

            Next


            Dim insertlog = db.InsertEventLog(newevent.eventID, "Event Created", "The event was created.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), newevent.eventID, Date.Now(), "Event Added", "The event was added.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            'add to xml file
            Try
                Dim result = (From p In db.qryViewEvents Where p.eventID = newevent.eventID Select p).FirstOrDefault

                Dim xmlDoc As XDocument = XDocument.Load(Server.MapPath("\Documents\Events.xml"))

                Dim root As New XElement("Event", New XAttribute("EventID", newevent.eventID),
                                     New XAttribute("CreatedDate", DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss")),
                                     New XAttribute("CreatedBy", Common.GetFullName(newevent.CreatedBy)),
                                     New XAttribute("Source", "Form"),
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

            End Try

            'go to the event page
            Response.Redirect("/Events/EventDetails?ID=" & newevent.eventID & "&action=1")
        Catch ex As Exception

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), 0, Date.Now(), "Error Adding Event", ex.Message.ToString(), Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            msgLabel.Text = ex.Message.ToString()
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

    Private Sub EventTypeIDTextBox_SelectedIndexChanged(sender As Object, e As EventArgs) Handles EventTypeIDComboBox.SelectedIndexChanged

        Dim collection As IList(Of RadListBoxItem) = SelectedBrandsList.CheckedItems
        ' get a list of brands
        For Each item As RadListBoxItem In collection

            Dim attire_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDComboBox.SelectedValue Select p.attire).FirstOrDefault

            If attire_Text = "" Then
                'do nothing
            Else
                Dim attireText As String = attireTextEditor.Content & String.Format("<p><b>{0}:</b> {1}</p>", getBrandName(item.Value), attire_Text)
                attireTextEditor.Content = attireText
            End If



            Dim posRequirements_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDComboBox.SelectedValue Select p.pos).FirstOrDefault

            If posRequirements_Text = "" Then
                'do nothing
            Else
                Dim posRequirementsText As String = posRequirementsEditor.Content & String.Format("<p><b>{0}</b>: {1}</p>", getBrandName(item.Value), posRequirements_Text)
                posRequirementsEditor.Content = posRequirementsText '.ToString().Replace("<br />", Environment.NewLine)
            End If




            Dim samplingNotes_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDComboBox.SelectedValue Select p.samplingInstructions).FirstOrDefault

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

    'Private Sub supplierIDComboBox_SelectedIndexChanged(sender As Object, e As EventArgs) Handles supplierIDComboBox.SelectedIndexChanged



    'End Sub

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
            labelText = labelText & "<span class='text-danger'> *</span>"
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

        If required = True Then
            Dim validate As New RequiredFieldValidator
            validate.CssClass = "errorlabel"
            validate.SetFocusOnError = True
            validate.ID = "RequiredField" & "text" & id & "result"
            validate.ControlToValidate = "text" & id & "result"
            validate.Display = ValidatorDisplay.Dynamic
            validate.ErrorMessage = "This is a required field!"
            validate.ValidationGroup = "details"

            div.Controls.Add(validate)
        End If

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateMultilineTextboxControl(id As String, labelText As String, rows As Integer, description As String, required As Boolean, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        'add required field
        If required = True Then
            labelText = labelText & "<span class='text-danger'> *</span>"
        End If

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

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div1.Controls.Add(span)

        If required = True Then
            Dim validate As New RequiredFieldValidator
            validate.CssClass = "errorlabel"
            validate.SetFocusOnError = True
            validate.ID = "RequiredField" & "text" & id & "result"
            validate.ControlToValidate = "text" & id & "result"
            validate.Display = ValidatorDisplay.Dynamic
            validate.ErrorMessage = "This is a required field!"
            validate.ValidationGroup = "details"

            div.Controls.Add(validate)
        End If

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateNumberboxControl(id As String, labelText As String, defaultValue As String, numberDecimalPlaces As Integer, required As Boolean, description As String, showPercent As Boolean)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        'add required field
        If required = True Then
            labelText = labelText & "<span class='text-danger'> *</span>"
        End If

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

        If showPercent = True Then
            box.Type = NumericType.Percent
        Else
            box.Type = NumericType.Number
        End If

        div2.Controls.Add(box)

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div2.Controls.Add(span)

        If required = True Then
            Dim validate As New RequiredFieldValidator
            validate.CssClass = "errorlabel"
            validate.SetFocusOnError = True
            validate.ID = "RequiredField" & "text" & id & "result"
            validate.ControlToValidate = "text" & id & "result"
            validate.Display = ValidatorDisplay.Dynamic
            validate.ErrorMessage = "This is a required field!"
            validate.ValidationGroup = "details"

            div.Controls.Add(validate)
        End If


        div.Controls.Add(div2)

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateDateControl(id As String, labelText As String, dateValue As String, required As Boolean, description As String, format As String, display As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        'add required field
        If required = True Then
            labelText = labelText & "<span class='text-danger'> *</span>"
        End If

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")
        div2.Attributes.Add("class", "col-sm-2")

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



        div.Controls.Add(div2)

        If required = True Then
            Dim validate As New RequiredFieldValidator
            validate.CssClass = "errorlabel"
            validate.SetFocusOnError = True
            validate.ID = "RequiredField" & "text" & id & "result"
            validate.ControlToValidate = "text" & id & "result"
            validate.Display = ValidatorDisplay.Dynamic
            validate.ErrorMessage = "This is a required field!"
            validate.ValidationGroup = "details"

            div.Controls.Add(validate)
        End If

        div2.Controls.Add(box)

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
        Dim question = From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("SupplierID") Select p Order By p.sortOrder

        For Each p In question

            Select Case p.questionType
                Case "label"
                    CreateLabelControl(p.supplierBudgetQuestionID, p.question)

                Case "text"
                    CreateTextboxControl(p.supplierBudgetQuestionID, p.question, p.description, p.required, "")

                Case "choice"
                    CreateComboboxControl(p.supplierBudgetQuestionID, p.question, "", p.description, p.required, p.displayOption)

                Case "multiline"
                    CreateMultilineTextboxControl(p.supplierBudgetQuestionID, p.question, p.lines, p.description, p.required, "")

                Case "number"
                    CreateNumberboxControl(p.supplierBudgetQuestionID, p.question, p.numberDefaultValue, p.numberDecimalPlace, p.required, p.description, p.showPercentage)

                Case "date"
                    CreateDateControl(p.supplierBudgetQuestionID, p.question, p.dateDefaultValue, p.required, p.description, p.dateFormat, p.dateDisplay)

                Case "time"
                    CreateTimeControl(p.supplierBudgetQuestionID, p.question, p.timeFormat)

                Case "currency"
                    CreateCurrencyControl(p.supplierBudgetQuestionID, p.question, p.numberDefaultValue)

                Case "yes/no"
                    CreateYesNoControl(p.supplierBudgetQuestionID, p.question, p.supplierBudgetQuestionID, p.description, p.yes_noDefaultValue)
            End Select



        Next

    End Sub

    Private Sub SelectedBrandsList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles SelectedBrandsList.SelectedIndexChanged

        Dim collection As IList(Of RadListBoxItem) = SelectedBrandsList.CheckedItems
        ' get a list of brands
        For Each item As RadListBoxItem In collection

            Dim attire_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDComboBox.SelectedValue Select p.attire).FirstOrDefault

            If attire_Text = "" Then
                'do nothing
            Else
                attireTextEditor.Content = ""
                Dim attireText As String = attireTextEditor.Content & String.Format("<p><b>{0}:</b> {1}</p>", getBrandName(item.Value), attire_Text)
                attireTextEditor.Content = attireText
            End If



            Dim posRequirements_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDComboBox.SelectedValue Select p.pos).FirstOrDefault

            If posRequirements_Text = "" Then
                'do nothing
            Else
                posRequirementsEditor.Content = ""
                Dim posRequirementsText As String = posRequirementsEditor.Content & String.Format("<p><b>{0}</b>: {1}</p>", getBrandName(item.Value), posRequirements_Text)
                posRequirementsEditor.Content = posRequirementsText '.ToString().Replace("<br />", Environment.NewLine)
            End If




            Dim samplingNotes_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = EventTypeIDComboBox.SelectedValue Select p.samplingInstructions).FirstOrDefault

            If samplingNotes_Text = "" Then
                'do nothing
            Else
                samplingNotesRadEditor.Content = ""
                Dim samplingNotesText As String = samplingNotesRadEditor.Content & String.Format("<p><b>{0}</b>: {1}</p>", getBrandName(item.Value), samplingNotes_Text)
                samplingNotesRadEditor.Content = samplingNotesText '.ToString().Replace("<br />", Environment.NewLine)
            End If



        Next

    End Sub
#End Region

End Class