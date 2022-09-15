Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class CreateRecap
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim eventID As Integer
    Dim eventTypeID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        eventID = Request.QueryString("EventID")
        eventTypeID = (From p In db.tblEvents Where p.eventID = eventID Select p.eventTypeID).FirstOrDefault

        EventNameLabel.Text = (From p In db.tblEvents Where p.eventID = eventID Select p.eventTitle).FirstOrDefault
        EventDateLabel.Text = String.Format("{0:D}", (From p In db.tblEvents Where p.eventID = eventID Select p.eventDate).FirstOrDefault)
        EventIDLabel.Text = eventID

    End Sub

    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)
        generateDynamicControls()
    End Sub

    Sub BuildForm()

        'get the eventID

        'get the recap question list

        Dim recap = From p In db.tblEventRecapQuestions Where p.eventID = eventID Select p

        For Each p In recap

            Select Case p.questionType
                Case "text"
                    Dim txtbox As TextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), TextBox)

                Case "multiline"
                    Dim txtbox As TextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), TextBox)

                Case "choice"
                    Dim txtbox As DropDownList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), DropDownList)

            End Select


        Next

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


        Dim order As Integer = 0
        Dim eventID = Request.QueryString("EventID")

        'first delete any recap questions that might exist
        db.DeleteAllEventRecapQuestions(eventID)


        'create the recap questions
        'get the selected brands

        Dim brandlist = From y In db.tblBrandInEvents Where y.eventID = Request.QueryString("EventID") Select y
        For Each y In brandlist

            ' get the default recap quetions for each brand
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

                db.tblEventRecapQuestions.InsertOnSubmit(recap1)
                db.SubmitChanges()
            Next

        Next

        'end the loop through the brands

        'get the eventtype
        Dim typeid = (From p In db.tblEvents Where p.eventID = eventID Select p.eventTypeID).FirstOrDefault

        'add eventtype recap questions
        Dim i = From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = typeid Select p
        For Each p In i
            Dim recap3 As New tblEventRecapQuestion
            recap3.eventID = eventID
            recap3.question = p.question
            recap3.questionType = p.questionType
            recap3.recapID = 2
            recap3.recapQuestionID = p.eventTypeRecapQuestionID
            recap3.sortorder = order + 1

            db.tblEventRecapQuestions.InsertOnSubmit(recap3)
            db.SubmitChanges()
        Next




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

                Select Case p.questionType
                    Case "text"
                        CreateTextboxControl(p.eventRecapQuestionID, p.question, p.answer)

                    Case "choice"
                        CreateComboboxControl(p.eventRecapQuestionID, p.question, p.recapQuestionID, p.answer)
                    'get the choices


                    Case "multiline"
                        'get the number of lines
                        Dim linecount = (From l In db.tblBrandRecapQuestions Where l.brandRecapQuestionID = l.brandRecapQuestionID Select l.lines).FirstOrDefault

                        CreateMultilineTextboxControl(p.eventRecapQuestionID, p.question, linecount, p.answer)

                    Case "number"
                        'numberDecimalPlace

                        'numberDefaultValue

                        'showPercentage

                        CreateNumberboxControl(p.eventRecapQuestionID, p.question, p.answer)

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

                        CreateYesNoControl(p.eventRecapQuestionID, p.question, p.recapQuestionID, p.answer)

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
                    CreateTextboxControl(p.eventRecapQuestionID, p.question, p.answer)

                Case "choice"
                    CreateComboboxControl(p.eventRecapQuestionID, p.question, p.recapQuestionID, p.answer)

                Case "multiline"
                    'get the number of lines
                    Dim linecount = (From l In db.tblEventTypeRecapQuestions Where l.eventTypeRecapQuestionID = l.eventTypeRecapQuestionID Select l.lines).FirstOrDefault

                    CreateMultilineTextboxControl(p.eventRecapQuestionID, p.question, linecount, p.answer)

                Case "number"
                    CreateNumberboxControl(p.eventRecapQuestionID, p.question, p.answer)

                Case "date"
                    CreateDateControl(p.eventRecapQuestionID, p.question, p.answer)

                Case "time"
                    CreateTimeControl(p.eventRecapQuestionID, p.question, p.answer)

                Case "currency"
                    CreateCurrencyControl(p.eventRecapQuestionID, p.question, p.answer)

                Case "yes/no"
                    CreateYesNoControl(p.eventRecapQuestionID, p.question, p.recapQuestionID, p.answer)

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

    Private Sub CreateTextboxControl(id As String, labelText As String, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        ' Create a text box control
        Dim box As New TextBox
        box.CssClass = "form-control"
        box.ID = "text" & id & "result"
        box.Text = answer
        div.Controls.Add(box)

        InsertPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateNumberboxControl(id As String, labelText As String, defaultValue As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")
        ' Create a text box control
        Dim box As New RadNumericTextBox
        box.ShowSpinButtons = "true"
        box.NumberFormat.DecimalDigits = 0
        box.Width = 100
        box.ID = "text" & id & "result"
        box.Value = defaultValue
        div2.Controls.Add(box)
        div.Controls.Add(div2)

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

    Private Sub CreateMultilineTextboxControl(id As String, labelText As String, rows As Integer, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

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

        InsertPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateComboboxControl(id As String, labelText As String, questionID As String, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        ' Create a text box control
        Dim ddl As New DropDownList
        ddl.CssClass = "form-control combobox"
        ddl.Width = 200
        ddl.ID = "text" & id & "result"
        ddl.Items.Add(New ListItem("-- Select --", ""))

        Dim q = From a In db.tblRecapQuestionOptions Where a.brandRecapQuestionID = questionID Select a Order By a.sortOrder
        For Each a In q
            ddl.Items.Add(New ListItem(a.option, a.option))
        Next

        ddl.SelectedValue = answer

        div.Controls.Add(ddl)

        InsertPlaceHolder.Controls.Add(div)

    End Sub
    Private Sub CreateYesNoControl(id As String, labelText As String, questionID As String, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        ' Create a text box control
        Dim ddl As New DropDownList
        ddl.CssClass = "form-control combobox"
        ddl.Width = 200
        ddl.ID = "text" & id & "result"
        ddl.Items.Add(New ListItem("-- Select --", ""))
        ddl.Items.Add(New ListItem("Yes", "Yes"))
        ddl.Items.Add(New ListItem("No", "No"))
        ddl.SelectedValue = answer

        Dim q = From a In db.tblRecapQuestionOptions Where a.brandRecapQuestionID = questionID Select a Order By a.sortOrder
        For Each a In q
            ddl.Items.Add(New ListItem(a.option, a.option))
        Next

        div.Controls.Add(ddl)

        InsertPlaceHolder.Controls.Add(div)

    End Sub


    Function getBrandName(id As Integer) As String
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function

    Function getEventTypeName(id As Integer) As String
        Return (From p In db.tblEventTypes Where p.eventTypeID = id Select p.eventTypeName).FirstOrDefault
    End Function

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click

        'first delete any recap questions that might exist
        db.DeleteAllEventRecapQuestions(eventID)

        Response.Redirect("/Events/EventDetails?ID=" & Request.QueryString("EventID"))
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        ' save the form
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        'save the form
        SaveForm()

        'mark recap as complete & set event status to toplined
        db.UpdateEventRecapStatus(eventID, currentUser.Id)

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
                        Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")

                    Case "choice"
                        Dim txtbox As DropDownList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), DropDownList)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedValue, currentUser.Id)
                        Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")


                    Case "multiline"
                        Dim txtbox As TextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), TextBox)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)
                        Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")

                    Case "number"
                        Dim txtbox As RadNumericTextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadNumericTextBox)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)
                        Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")

                    Case "date"
                        Dim txtbox As RadDatePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadDatePicker)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)
                        Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")


                    Case "time"
                        Dim txtbox As RadTimePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadTimePicker)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)
                        Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")


                    Case "currency"
                        Dim txtbox As RadNumericTextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadNumericTextBox)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)
                        Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")

                    Case "yes/no"
                        Dim txtbox As DropDownList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), DropDownList)
                        db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedValue, currentUser.Id)
                        Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")

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
                    Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")

                Case "choice"
                    Dim txtbox As DropDownList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), DropDownList)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedValue, currentUser.Id)
                    Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")


                Case "multiline"
                    Dim txtbox As TextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), TextBox)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)
                    Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")

                Case "number"
                    Dim txtbox As RadNumericTextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadNumericTextBox)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)
                    Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")

                Case "date"
                    Dim txtbox As RadDatePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadDatePicker)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)
                    Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")


                Case "time"
                    Dim txtbox As RadTimePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadTimePicker)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)
                    Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")


                Case "currency"
                    Dim txtbox As RadNumericTextBox = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadNumericTextBox)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.Text, currentUser.Id)
                    Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")

                Case "yes/no"
                    Dim txtbox As DropDownList = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), DropDownList)
                    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedValue, currentUser.Id)
                    Response.Write("<script>alert(p.eventRecapQuestionID + ': ' + txtbox.Text );</script>")

            End Select
        Next

    End Sub
End Class