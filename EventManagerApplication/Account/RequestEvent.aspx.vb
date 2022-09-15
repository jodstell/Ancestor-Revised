Imports System.IO
Imports Telerik.Web.UI
Imports Telerik.Web.UI.Calendar
Imports BingGeocoder


Public Class RequestEvent
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)
        generateDynamicControls()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'check if the supplier is valid
        Dim supplier As String = Page.RouteData.Values("supplier")

        Try
            SupplierNameLabel.Text = (From p In db.tblSuppliers Where p.shortName = supplier Select p.supplierName).FirstOrDefault
            supplierID.Value = (From p In db.tblSuppliers Where p.shortName = supplier Select p.supplierID).FirstOrDefault
            clientID.Value = (From p In db.tblSuppliers Where p.shortName = supplier Select p.clientID).FirstOrDefault
        Catch ex As Exception
            'show friendly message that this account is not correct
            IntroductionPanel.Visible = False
            NotBelongHerePanel.Visible = True

        End Try

        Dim action As String = Page.RouteData.Values("action")
        If action = "success" Then
            welcomeLabel.Text = Common.ShowAlertNoClose("success", "Your request has been sent successfully. You will be notified by a company representative.")
        Else
            welcomeLabel.Text = ""
        End If

    End Sub

    Private Sub EventDatePicker_SelectedDateChanged(sender As Object, e As SelectedDateChangedEventArgs) Handles EventDatePicker.SelectedDateChanged

        StartDateTimePicker.DbSelectedDate = EventDatePicker.SelectedDate
        EndDateTimePicker.DbSelectedDate = EventDatePicker.SelectedDate

        Dim today As Date = Date.Now()

        If today.AddDays(14) > EventDatePicker.SelectedDate Then

            AlertPanel.Visible = True

        Else
            AlertPanel.Visible = False

        End If






    End Sub


    Private Sub EventWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.FinishButtonClick


        'get the location
        Dim q = (From p In db.LookupAccount(LocationNameTextBox.Text, txtCity.Text, txtZip.Text, ddlState.SelectedValue, txtAddress1.Text) Select p.Vpid).FirstOrDefault


        'get market ID



        'add the event
        Dim newevent As New tblRequestedEvent
        newevent.eventTitle = eventTitleTextBox.Text
        newevent.eventTypeID = RadDropDownList1.SelectedValue
        newevent.eventDate = EventDatePicker.SelectedDate
        newevent.startTime = StartDateTimePicker.SelectedDate
        newevent.endTime = EndDateTimePicker.SelectedDate
        newevent.locationName = LocationNameTextBox.Text
        newevent.locationAddress = txtAddress1.Text
        newevent.locationCity = txtCity.Text
        newevent.locationState = ddlState.SelectedValue
        newevent.locationZip = txtZip.Text
        newevent.CreatedBy = fullNameTextBox.Text
        newevent.CreatedByEmail = userEmailAddressTextBox.Text
        newevent.supplierID = supplierID.Value
        newevent.clientID = clientID.Value
        newevent.CreatedDate = DateTime.Now()

        Dim address As String = String.Format("{0}, {1}, {2}, {3}", txtAddress1.Text, txtCity.Text, ddlState.SelectedValue, txtZip.Text)

        newevent.latitude = getLatitude(address.Replace("#", ""))
        newevent.longitude = getLongitude(address.Replace("#", ""))

        newevent.matchedLocationID = getMatch(LocationNameTextBox.Text, getLatitude(address.Replace("#", "")), getLongitude(address.Replace("#", "")))

        newevent.requestType = "Online"

        If DescriptionTextBox.Text IsNot "" Then
            newevent.eventDescription = DescriptionTextBox.Text
        End If

        db.tblRequestedEvents.InsertOnSubmit(newevent)
        db.SubmitChanges()



        'add the brands
        Dim collection As IList(Of RadListBoxItem) = BrandListBox.CheckedItems

        For Each item As RadListBoxItem In collection

            Dim newBrand As New tblBrandsInRequestedEvent With {.requestedEventID = newevent.requestedEventID, .brandID = item.Value}
            'newBrand.requestedEventID = newevent.requestedEventID
            'newBrand.brandID = item.Value

            db.tblBrandsInRequestedEvents.InsertOnSubmit(newBrand)
            db.SubmitChanges()

        Next


        'get the fields from the supplierBudget type

        Dim shortName As String = Page.RouteData.Values("supplier")

        Dim id As Integer = (From p In db.tblSuppliers Where p.shortName = shortName Select p.supplierID).FirstOrDefault

        Dim question = From p In db.tblSupplierBudgetQuestions Where p.supplierID = id Select p Order By p.sortOrder

        For Each p In question

            Dim NewSupplierBudgetQuestion As New tblSupplierBudgetQuestionResult

            NewSupplierBudgetQuestion.eventID = newevent.requestedEventID
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

        'email confirmation
        'get my html file

        Dim m = (From p In db.tblMessages Where p.messageID = 2 Select p).FirstOrDefault

        Dim myString As String = ""
        myString = m.messageText
        myString = myString.Replace("[RequestedByName]", fullNameTextBox.Text)
        myString = myString.Replace("[EventName]", eventTitleTextBox.Text)
        myString = myString.Replace("[Where]", LocationNameTextBox.Text)
        myString = myString.Replace("[EventType]", RadDropDownList1.SelectedText)
        myString = myString.Replace("[City]", txtCity.Text)
        myString = myString.Replace("[Date]", EventDateLabel.Text)
        myString = myString.Replace("[State]", ddlState.SelectedItem.Text)
        myString = myString.Replace("[Brands]", lblBrands.Text)
        myString = myString.Replace("[Description]", DescriptionTextBox.Text)

        Dim recipient = userEmailAddressTextBox.Text

        'send email
        MailHelper.SendEmailMessage(2, recipient, m.fromAddress, m.fromName, m.subject, myString.ToString())


        'show success page
        Response.Redirect("/Event_Request/" & Page.RouteData.Values("supplier") & "/success")



    End Sub

    Protected Sub RadWizard1_ActiveStepChanged(sender As Object, e As EventArgs)

        EventNameLabel.Text = eventTitleTextBox.Text
        EventTypeLabel.Text = RadDropDownList1.SelectedText
        EventDateLabel.Text = String.Format(" {0:MM/dd/yy}     <strong>From:</strong> {1:h:mm tt}     <strong>To:</strong> {2:h:mm tt}",
                                            EventDatePicker.DbSelectedDate, StartDateTimePicker.DbSelectedDate, EndDateTimePicker.DbSelectedDate)

        If DescriptionTextBox.Text IsNot "" Then
            EventDescriptionLabel.Text = DescriptionTextBox.Text
            lblDescription.Visible = True
        Else
            lblDescription.Visible = False
            EventDescriptionLabel.Text = ""
        End If


        Dim sb As New StringBuilder()

        Dim collection As IList(Of RadListBoxItem) = BrandListBox.CheckedItems

        For Each item As RadListBoxItem In collection

            sb.Append(item.Text + ", ")

        Next

        lblBrands.Text = sb.ToString().TrimEnd(" ").TrimEnd(",")



        AccountNameLabel.Text = LocationNameTextBox.Text
        AccountCityLabel.Text = txtCity.Text
        AccountStateLabel.Text = ddlState.SelectedItem.Text

        AccountAddressLabel.Text = txtAddress1.Text
        AccountCityStateLabel.Text = String.Format("{0}, {1}  {2}", txtCity.Text, ddlState.SelectedValue, txtZip.Text)



        'Dim historyIndex As Integer = EventWizard.GetHistory().Count

        '' RadListBox1.Items.Clear()

        'For Each [step] As RadWizardStep In EventWizard.GetHistory()

        '    Dim listBoxItem As New RadListBoxItem()

        '    listBoxItem.Text = historyIndex.ToString() + ". " + [step].Title

        '    '  RadListBox1.Items.Add(listBoxItem)

        '    historyIndex -= 1

        '    If historyIndex = 3 Then
        '        EventNameLabel.Text = eventTitleTextBox.Text
        '    End If

        'Next



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

#Region "Dynamic Methods"
    Public Sub generateDynamicControls()
        'get the fields from the supplierBudget type

        Dim shortName As String = Page.RouteData.Values("supplier")

        Dim id As Integer = (From p In db.tblSuppliers Where p.shortName = shortName Select p.supplierID).FirstOrDefault

        Dim question = From p In db.tblSupplierBudgetQuestions Where p.supplierID = id Select p Order By p.sortOrder

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
                    CreateDateControl(p.supplierBudgetQuestionID, p.question, p.dateDefaultValue, p.description)

                Case "time"
                    CreateTimeControl(p.supplierBudgetQuestionID, p.question, p.timeFormat)

                Case "currency"
                    CreateCurrencyControl(p.supplierBudgetQuestionID, p.question, p.numberDefaultValue)

                Case "yes/no"
                    CreateYesNoControl(p.supplierBudgetQuestionID, p.question, p.supplierBudgetQuestionID, p.description, p.yes_noDefaultValue)
            End Select



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

    Private Sub CreateDateControl(id As String, labelText As String, dateValue As String, description As String)

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

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div2.Controls.Add(span)
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
#End Region

    Private Sub btnBookEvent_Click(sender As Object, e As EventArgs) Handles btnBookEvent.Click
        IntroductionPanel.Visible = False
        FormPanel.Visible = True
    End Sub

    Private Sub EventWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles EventWizard.CancelButtonClick

        ' IntroductionPanel.Visible = True
        ' FormPanel.Visible = False

        Response.Redirect("/Event_Request/" & Page.RouteData.Values("supplier"))

    End Sub


End Class