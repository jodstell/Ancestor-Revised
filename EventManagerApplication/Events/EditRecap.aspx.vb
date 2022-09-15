Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class EditRecap
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim eventID As Integer
    Dim eventTypeID As Integer
    Dim lmsdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            eventID = Request.QueryString("EventID")
            eventTypeID = (From p In db.tblEvents Where p.eventID = eventID Select p.eventTypeID).FirstOrDefault

            EventNameLabel.Text = (From p In db.tblEvents Where p.eventID = eventID Select p.eventTitle).FirstOrDefault
            EventDateLabel.Text = String.Format("{0:D}", (From p In db.tblEvents Where p.eventID = eventID Select p.eventDate).FirstOrDefault)
            EventIDLabel.Text = eventID
        Catch ex As Exception

        End Try


    End Sub

    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)

        'CreateRecap()
        generateDynamicControls()
    End Sub



    Public Sub CreateRecap()

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        If Request.QueryString("action") = "new" Then

            Dim order As Integer = 0
            Dim eventID = Request.QueryString("EventID")

            'first delete any recap questions that might exist
            db.DeleteAllEventRecapQuestions(eventID)


            'create the recap questions
            'get the selected brands

            Dim brandlist = From y In db.tblBrandInEvents Where y.eventID = Request.QueryString("EventID") Select y
            For Each y In brandlist

                ' get the default recap questions for each brand
                Dim a = From p In db.tblDefaultRecapQuestions Select p Order By p.QuestionID
                For Each p In a

                    Dim recap0 As New tblEventRecapQuestion
                    recap0.eventID = eventID
                    recap0.brandID = y.brandID
                    Dim q1 As String = Replace(p.Question, "[BrandName]", getBrandName(y.brandID))
                    recap0.question = Replace(q1, "[PPS]", getPPS(y.brandID))
                    recap0.questionType = p.QuestionType
                    recap0.recapID = 0
                    recap0.recapQuestionID = p.QuestionID
                    recap0.sortorder = order + 1
                    recap0.createdBy = currentUser.Id
                    recap0.createdDate = Date.Now()
                    recap0.description = "" ' there is not a description column
                    recap0.required = False
                    recap0.digit = 0
                    recap0.numberDecimalPlace = 0
                    recap0.showPercentage = False
                    recap0.dateDefaultValue = "None"
                    recap0.displayOption = ""
                    recap0.lines = 1
                    recap0.yes_noDefaultValue = "No"
                    recap0.dateFormat = ""
                    recap0.dateDisplay = ""

                    If p.QuestionType = "currency" Then
                        recap0.answer = 0
                    End If

                    db.tblEventRecapQuestions.InsertOnSubmit(recap0)
                    db.SubmitChanges()

                Next

                ' get the custom brand questions for each brand
                Dim r = From p In db.tblBrandRecapQuestions Where p.brandID = y.brandID
                For Each p In r

                    Dim recap1 As New tblEventRecapQuestion
                    recap1.eventID = eventID
                    recap1.brandID = y.brandID
                    recap1.question = p.question
                    recap1.questionType = p.questionType
                    recap1.recapID = 1
                    recap1.recapQuestionID = p.brandRecapQuestionID
                    recap1.sortorder = order + 1
                    recap1.description = p.description
                    recap1.displayOption = p.displayOption
                    recap1.lines = p.lines
                    recap1.yes_noDefaultValue = p.yes_noDefaultValue
                    recap1.numberDecimalPlace = p.numberDecimalPlace
                    recap1.numberDefaultValue = p.numberDefaultValue
                    recap1.showPercentage = p.showPercentage
                    recap1.dateFormat = p.dateFormat
                    recap1.dateDefaultValue = p.dateDefaultValue
                    recap1.timeFormat = p.timeFormat
                    recap1.dateDisplay = p.dateDisplay
                    recap1.required = p.required
                    recap1.digit = p.numberDecimalPlace
                    recap1.createdBy = currentUser.Id
                    recap1.createdDate = Date.Now()

                    If p.questionType = "choice" Then
                        recap1.displayOption = p.displayOption
                        If p.displayOption = "check" Then
                            recap1.answer = ""
                        End If

                    Else
                        recap1.displayOption = ""
                    End If

                    If p.questionType = "currency" Then
                        recap1.answer = 0
                    End If

                    If p.questionType = "number" Then
                        recap1.answer = p.numberDefaultValue
                    End If

                    db.tblEventRecapQuestions.InsertOnSubmit(recap1)
                    db.SubmitChanges()
                Next

            Next

            'end the loop through the brands
            Dim CurrentClientID = (From p In db.tblEvents Where p.eventID = eventID Select p.clientID).FirstOrDefault
            'end the loop through the brands

            'get the eventtype
            Dim typeid = (From p In db.tblEvents Where p.eventID = eventID And p.clientID = CurrentClientID Select p.eventTypeID).FirstOrDefault

            ' 3. add eventtype recap questions
            Dim i = From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = typeid And p.clientID = CurrentClientID Order By p.sortorder Select p

            For Each p In i
                Dim recap3 As New tblEventRecapQuestion
                recap3.eventID = eventID
                recap3.question = p.question
                recap3.questionType = p.questionType
                recap3.recapID = 2
                recap3.recapQuestionID = p.eventTypeRecapQuestionID
                recap3.sortorder = p.sortorder
                recap3.description = p.description
                recap3.displayOption = p.displayOption
                recap3.lines = p.lines
                recap3.yes_noDefaultValue = p.yes_noDefaultValue
                recap3.numberDecimalPlace = p.numberDecimalPlace
                recap3.numberDefaultValue = p.numberDefaultValue
                recap3.showPercentage = p.showPercentage
                recap3.dateFormat = p.dateFormat
                recap3.dateDefaultValue = p.dateDefaultValue
                recap3.timeFormat = p.timeFormat
                recap3.dateDisplay = p.dateDisplay
                recap3.required = p.required
                recap3.digit = p.numberDecimalPlace
                recap3.createdBy = currentUser.Id
                recap3.createdDate = Date.Now()


                If p.questionType = "choice" Then
                    recap3.displayOption = p.displayOption
                    If p.displayOption = "check" Then
                        recap3.answer = ""
                    End If

                Else
                    recap3.displayOption = ""
                End If

                If p.questionType = "currency" Then
                    recap3.answer = 0
                End If

                If p.questionType = "number" Then
                    recap3.answer = p.numberDefaultValue
                End If

                Dim insertlog = db.InsertEventLog(Request.QueryString("EventID"), "Event Recap", "Recap was added to the event.", Context.User.Identity.GetUserId(), Date.Now())

                'add to history log
                lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Event Recap", "Recap was added to the event.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                db.tblEventRecapQuestions.InsertOnSubmit(recap3)
                db.SubmitChanges()
            Next
        End If


    End Sub

    Function getPPS(id As Integer) As String
        Dim pps = (From p In db.tblBrands Where p.brandID = id Select p.packageSize).FirstOrDefault

        If pps = "" Then
            Return "bottles"
        Else
            Return pps & " bottles"
        End If

    End Function

#Region "Dynamic Methods"
    Public Sub generateDynamicControls()



        ' loop through the brands first

        Dim brand = From b In db.tblBrandInEvents Where b.eventID = eventID
        For Each b In brand

            'create a header label
            CreateLabelControl("", getBrandName(b.brandID) & " Brand Recap")

            'add the controls for each of the brands

            Dim recap = From p In db.tblEventRecapQuestions Where p.eventID = eventID And p.brandID = b.brandID Select p Order By p.eventRecapQuestionID

            For Each p In recap

                'recapid
                '0 = default brand question
                '1 = custom brand question
                '2 = event type question

                'recapquestionID refers to the question

                If p.required Is Nothing Then p.required = False

                Select Case p.questionType

                    Case "label"
                        CreateLabelControl(p.eventRecapQuestionID, p.question)

                    Case "text"
                        CreateTextboxControl(p.eventRecapQuestionID, p.question, p.description, p.required, p.answer)

                    Case "choice"
                        CreateComboboxControl(p.eventRecapQuestionID, p.question, p.recapQuestionID, p.answer, p.description, p.required, p.displayOption)
                    'get the choices


                    Case "multiline"
                        'get the number of lines
                        Dim linecount = (From l In db.tblBrandRecapQuestions Where l.brandRecapQuestionID = l.brandRecapQuestionID Select l.lines).FirstOrDefault

                        CreateMultilineTextboxControl(p.eventRecapQuestionID, p.question, linecount, p.answer, p.description, p.required)

                    Case "number"

                        CreateNumberboxControl(p.eventRecapQuestionID, p.question, p.answer, p.description, p.required, p.digit)

                    Case "date"
                        'dateFormat

                        'dateDefaultValue

                        'dateDisplay

                        CreateDateControl(p.eventRecapQuestionID, p.question, p.answer)

                    Case "time"

                        'timeFormat

                        CreateTimeControl(p.eventRecapQuestionID, p.question, p.answer)

                    Case "currency"
                        CreateCurrencyControl(p.eventRecapQuestionID, p.question, p.answer)

                    Case "yes/no"

                        CreateYesNoControl(p.eventRecapQuestionID, p.question, p.recapQuestionID, p.description, p.answer)

                End Select
            Next

        Next

        ' get the EventType Questions

        'create a header label
        CreateLabelControl("", getEventTypeName(eventTypeID) & " Event Recap")


        Dim recap2 = From p In db.tblEventRecapQuestions Where p.eventID = eventID And p.brandID Is Nothing Select p Order By p.sortorder

        For Each p In recap2

            'recapid
            '0 = default brand question
            '1 = custom brand question
            '2 = event type question

            'recapquestionID refers to the question

            Select Case p.questionType
                Case "label"
                    CreateLabelControl(p.eventRecapQuestionID, p.question)

                Case "text"
                    CreateTextboxControl(p.eventRecapQuestionID, p.question, p.description, p.required, p.answer)

                Case "choice"
                    CreateComboboxControl(p.eventRecapQuestionID, p.question, p.recapQuestionID, p.answer, p.description, p.required, p.displayOption)

                Case "multiline"
                    'get the number of lines
                    Dim linecount = (From l In db.tblEventTypeRecapQuestions Where l.eventTypeRecapQuestionID = l.eventTypeRecapQuestionID Select l.lines).FirstOrDefault

                    CreateMultilineTextboxControl(p.eventRecapQuestionID, p.question, linecount, p.answer, p.description, p.required)

                Case "number"
                    CreateNumberboxControl(p.eventRecapQuestionID, p.question, p.answer, p.description, p.required, p.digit)

                Case "date"
                    CreateDateControl(p.eventRecapQuestionID, p.question, p.answer)

                Case "time"
                    CreateTimeControl(p.eventRecapQuestionID, p.question, p.answer)

                Case "currency"
                    CreateCurrencyControl(p.eventRecapQuestionID, p.question, p.answer)

                Case "yes/no"
                    CreateYesNoControl(p.eventRecapQuestionID, p.question, p.recapQuestionID, p.description, p.answer)

            End Select
        Next

    End Sub

    Private Sub CreateLabelControl(id As String, labelText As String)

        Dim div As New HtmlGenericControl("div")

        Dim lbl As New HtmlGenericControl("h3")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        InsertPlaceHolder.Controls.Add(div)

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
        div.Controls.Add(lbl)

        ' Create a text box control
        Dim box As New TextBox
        box.CssClass = "form-control"
        box.ID = "text" & id & "result"
        box.Text = answer
        div.Controls.Add(box)

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div.Controls.Add(span)

        If required = True Then
            Dim validate As New RequiredFieldValidator
            validate.CssClass = "errorlabel"
            validate.SetFocusOnError = True
            validate.ID = "RequiredField" & "text" & id & "result"
            validate.ControlToValidate = "text" & id & "result"
            validate.Display = ValidatorDisplay.Dynamic
            validate.ErrorMessage = "This is a required field!"
            validate.ValidationGroup = "Recap"

            div.Controls.Add(validate)
        End If

        InsertPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateNumberboxControl(id As String, labelText As String, answer As String, description As String, required As Boolean, digit As Integer)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        'add required field
        If required = True Then
            labelText = labelText & "<span class='text-danger'>*</span>"
        End If

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")
        ' Create a text box control
        Dim box As New RadNumericTextBox
        box.ShowSpinButtons = "true"
        box.NumberFormat.DecimalDigits = digit
        box.Width = 100
        box.ID = "text" & id & "result"
        Try
            box.Value = answer
        Catch ex As Exception

        End Try

        div2.Controls.Add(box)
        div.Controls.Add(div2)

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div.Controls.Add(span)

        If required = True Then
            Dim validate As New RequiredFieldValidator
            validate.CssClass = "errorlabel"
            validate.SetFocusOnError = True
            validate.ID = "RequiredField" & "text" & id & "result"
            validate.ControlToValidate = "text" & id & "result"
            validate.Display = ValidatorDisplay.Dynamic
            validate.ErrorMessage = "This is a required field!"
            validate.ValidationGroup = "Recap"

            div.Controls.Add(validate)
        End If

        InsertPlaceHolder.Controls.Add(div)


    End Sub

    Private Sub CreateTimeControl(id As String, labelText As String, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")

        ' Create a text box control
        Dim box As New RadTimePicker
        box.Width = 100
        box.ID = "text" & id & "result"
        box.DbSelectedDate = answer
        div2.Controls.Add(box)
        div.Controls.Add(div2)

        InsertPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateDateControl(id As String, labelText As String, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")

        ' Create a text box control
        Dim box As New RadDatePicker
        box.Width = 100
        box.ID = "text" & id & "result"
        box.DbSelectedDate = answer
        div2.Controls.Add(box)
        div.Controls.Add(div2)

        InsertPlaceHolder.Controls.Add(div)

    End Sub


    Private Sub CreateCurrencyControl(id As String, labelText As String, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")

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

        InsertPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateMultilineTextboxControl(id As String, labelText As String, rows As Integer, answer As String, description As String, required As Boolean)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        'add required field
        If required = True Then
            labelText = labelText & "<span class='text-danger'>*</span>"
        End If

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        ' Create a text box control
        Dim box As New TextBox
        box.CssClass = "form-control"
        box.TextMode = TextBoxMode.MultiLine
        box.Text = answer
        box.Rows = rows
        box.ID = "text" & id & "result"

        div.Controls.Add(box)

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div.Controls.Add(span)

        If required = True Then
            Dim validate As New RequiredFieldValidator
            validate.CssClass = "errorlabel"
            validate.SetFocusOnError = True
            validate.ID = "RequiredField" & "text" & id & "result"
            validate.ControlToValidate = "text" & id & "result"
            validate.Display = ValidatorDisplay.Dynamic
            validate.ErrorMessage = "This is a required field!"
            validate.ValidationGroup = "Recap"

            div.Controls.Add(validate)
        End If

        InsertPlaceHolder.Controls.Add(div)


    End Sub

    Private Sub CreateComboboxControl(id As String, labelText As String, questionID As String, answer As String, description As String, required As Boolean, displayOption As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        'add required field
        If required = True Then
            labelText = labelText & "<span class='text-danger'>*</span>"
        End If

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div1 As New LiteralControl("<br />")
        div.Controls.Add(div1)

        Select Case displayOption
            Case "drop"
                ' Create a text box control
                Dim ddl As New RadComboBox
                'ddl.CssClass = "form-control combobox"
                ddl.Width = 200
                ddl.ID = "text" & id & "result"
                ddl.Items.Add(New RadComboBoxItem("-- Select --", ""))

                Dim q = From a In db.tblRecapQuestionOptions Where a.brandRecapQuestionID = questionID Select a Order By a.sortOrder
                For Each a In q
                    ddl.Items.Add(New RadComboBoxItem(a.option, a.option))
                Next

                ddl.SelectedValue = answer

                div.Controls.Add(ddl)

            Case "check"
                Dim clb As New CheckBoxList
                clb.ID = "text" & id & "result"

                Dim q = From a In db.tblRecapQuestionOptions Where a.brandRecapQuestionID = questionID Select a Order By a.sortOrder
                For Each a In q
                    ' clb.Items.Add(New ListItem(a.option, a.option))

                    Dim selectedItem As New ListItem(a.option, a.option)
                    selectedItem.Selected = getanswer(answer, a.option)
                    clb.Items.Add(selectedItem)

                Next

                div.Controls.Add(clb)

            Case "radio"

                Dim clb As New RadioButtonList
                'clb.CssClass = "form-control combobox"
                ' clb.Width = 200
                clb.ID = "text" & id & "result"
                ' ddl.Items.Add(New RadComboBoxItem("-- Select --", ""))

                Dim q = From a In db.tblRecapQuestionOptions Where a.brandRecapQuestionID = questionID Select a Order By a.sortOrder
                For Each a In q
                    clb.Items.Add(New ListItem(a.option, a.option))
                Next

                clb.SelectedIndex = answer

                '  clb.SelectedValue = answer

                div.Controls.Add(clb)

        End Select



        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div.Controls.Add(span)

        If required = True Then
            Dim validate As New RequiredFieldValidator
            validate.CssClass = "errorlabel"
            validate.SetFocusOnError = True
            validate.ID = "RequiredField" & "text" & id & "result"
            validate.ControlToValidate = "text" & id & "result"
            validate.Display = ValidatorDisplay.Dynamic
            validate.ErrorMessage = "This is a required field!"
            validate.ValidationGroup = "Recap"

            div.Controls.Add(validate)
        End If

        InsertPlaceHolder.Controls.Add(div)

    End Sub

    Function getanswer(values As String, [option] As String) As Boolean

        Try
            Dim optionList As New List(Of OptionListing)
            Dim answers As String() = Nothing
            answers = values.Split(",")

            Dim s As String

            For Each s In answers
                optionList.Add(New OptionListing(s))
            Next s


            Dim q = (From p In optionList Where p.OptionName = [option] Select p).Count

            If q = 0 Then
                Return False
            Else
                Return True
            End If
        Catch ex As Exception

        End Try


    End Function

    Private Sub CreateYesNoControl(id As String, labelText As String, questionID As String, description As String, answer As String)
        Try
            Dim div As New HtmlGenericControl("div")
            div.Attributes.Add("class", "form-group")

            Dim lbl As New HtmlGenericControl("label")
            lbl.InnerHtml = labelText
            div.Controls.Add(lbl)

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


            div.Controls.Add(ddl)

            Dim span As New HtmlGenericControl("span")
            span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
            div.Controls.Add(span)

            InsertPlaceHolder.Controls.Add(div)
        Catch ex As Exception

        End Try
    End Sub


    Function getBrandName(id As Integer) As String
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function

    Function getEventTypeName(id As Integer) As String
        Return (From p In db.tblEventTypes Where p.eventTypeID = id Select p.eventTypeName).FirstOrDefault
    End Function

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect("/Events/EventDetails?ID=" & Request.QueryString("EventID"))

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Cancel Button Click", "The Recap was canceled.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        ' save the form
        SaveForm()
        Dim insertlog = db.InsertEventLog(Request.QueryString("EventID"), "Event Recap", "Recap was edited.", Context.User.Identity.GetUserId(), Date.Now())

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Event Recap", "Recap was edited.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        If Request.QueryString("action") = "new" Then
            'mark recap as complete & set event status to toplined
            Dim insertlog2 = db.InsertEventLog(Request.QueryString("EventID"), "Event Recap", "Recap was added to the event.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Event Recap", "Recap was added to the event.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            db.UpdateEventRecapStatus(Request.QueryString("EventID"), currentUser.Id)
        End If


        Response.Redirect("/Events/EventDetails?ID=" & Request.QueryString("EventID"))
    End Sub

#End Region

    Sub SaveForm()

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        ' loop through the brands first

        Dim brand = From b In db.tblBrandInEvents Where b.eventID = eventID
        For Each b In brand

            'create a header label
            ' CreateLabelControl("", getBrandName(b.brandID) & " Brand Recap")

            'add the controls for each of the brands

            Dim recap = From p In db.tblEventRecapQuestions Where p.eventID = eventID And p.brandID = b.brandID Select p Order By p.eventRecapQuestionID

            For Each p In recap

                'recapid
                '0 = default brand question
                '1 = custom brand question
                '2 = event type question

                'recapquestionID refers to the question

                Select Case p.questionType
                    Case "text"
                        Dim txtbox As TextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), TextBox)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)

                    Case "choice"

                        If p.displayOption = "drop" Then
                            Try
                                Dim myOptions As String = ""

                                Dim txtbox As CheckBoxList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), CheckBoxList)
                                'loop 

                                For Each item As ListItem In txtbox.Items
                                    If item.Selected Then
                                        myOptions += item.Text + ","
                                    End If
                                Next

                                db.InsertRecapAnswer(p.eventRecapQuestionID, myOptions, currentUser.Id)
                            Catch ex As Exception
                                db.InsertRecapAnswer(p.eventRecapQuestionID, "error", currentUser.Id)
                            End Try
                        End If


                        If p.displayOption = "radio" Then
                            Try
                                Dim txtbox As RadioButtonList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadioButtonList)
                                db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedIndex, currentUser.Id)
                            Catch ex As Exception
                                db.InsertRecapAnswer(p.eventRecapQuestionID, "error", currentUser.Id)
                            End Try

                        End If

                        If p.displayOption = "check" Then
                            Try
                                Dim txtbox As CheckBoxList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), CheckBoxList)

                                db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedItem.Text, currentUser.Id)
                            Catch ex As Exception
                                db.InsertRecapAnswer(p.eventRecapQuestionID, "error", currentUser.Id)
                            End Try
                        End If



                    Case "multiline"
                        Dim txtbox As TextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), TextBox)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)

                    Case "number"
                        Dim txtbox As RadNumericTextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadNumericTextBox)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)

                    Case "date"
                        Dim txtbox As RadDatePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadDatePicker)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)


                    Case "time"
                        Dim txtbox As RadTimePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadTimePicker)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)


                    Case "currency"
                        Dim txtbox As RadNumericTextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadNumericTextBox)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)

                    Case "yes/no"
                        Try
                            Dim txtbox As RadioButtonList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadioButtonList)

                            db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedItem.Text, currentUser.Id)

                        Catch ex As Exception

                        End Try






                End Select
            Next

        Next

        ' get the EventType Questions

        'create a header label
        CreateLabelControl("", getEventTypeName(eventTypeID) & " Event Recap")


        Dim recap2 = From p In db.tblEventRecapQuestions Where p.eventID = eventID And p.brandID Is Nothing Select p Order By p.sortorder

        For Each p In recap2

            'recapid
            '0 = default brand question
            '1 = custom brand question
            '2 = event type question

            'recapquestionID refers to the question

            Select Case p.questionType


                Case "text"
                    Dim txtbox As TextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), TextBox)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)

                Case "choice"

                    If p.displayOption = "drop" Then
                        Try
                            Dim txtbox As RadComboBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadComboBox)
                            db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedValue, currentUser.Id)
                        Catch ex As Exception
                            db.InsertRecapAnswer(p.eventRecapQuestionID, "error", currentUser.Id)
                        End Try
                    End If


                    If p.displayOption = "radio" Then
                        Try
                            Dim txtbox As RadioButtonList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadioButtonList)
                            db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedIndex, currentUser.Id)
                        Catch ex As Exception
                            db.InsertRecapAnswer(p.eventRecapQuestionID, "error", currentUser.Id)
                        End Try

                    End If

                    If p.displayOption = "check" Then
                        Try
                            Dim myOptions As String = ""

                            Dim txtbox As CheckBoxList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), CheckBoxList)
                            'loop 

                            For Each item As ListItem In txtbox.Items
                                If item.Selected Then
                                    myOptions += item.Text + ","
                                End If
                            Next

                            db.InsertRecapAnswer(p.eventRecapQuestionID, myOptions, currentUser.Id)
                        Catch ex As Exception
                            db.InsertRecapAnswer(p.eventRecapQuestionID, "error", currentUser.Id)
                        End Try
                    End If




                Case "multiline"
                    Dim txtbox As TextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), TextBox)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)

                Case "number"
                    Dim txtbox As RadNumericTextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadNumericTextBox)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)

                Case "date"
                    Dim txtbox As RadDatePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadDatePicker)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)


                Case "time"
                    Dim txtbox As RadTimePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadTimePicker)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)


                Case "currency"
                    Dim txtbox As RadNumericTextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadNumericTextBox)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)

                Case "yes/no"
                    Try
                        Dim txtbox As RadioButtonList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadioButtonList)

                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedItem.Text, currentUser.Id)
                    Catch ex As Exception
                        db.InsertRecapAnswer(p.eventRecapQuestionID, "error", currentUser.Id)
                    End Try


            End Select
        Next


    End Sub

End Class