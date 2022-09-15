Imports Telerik.Web.UI

Public Class NewEventType
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            tempGUID.Text = System.Guid.NewGuid().ToString()
        End If

    End Sub

    Private Sub btnAddNewQuestion_Click(sender As Object, e As EventArgs) Handles btnAddNewQuestion.Click

        NewRecapQuestionPanel.Visible = True
        RecapQuestionList.Visible = False
        btnAddNewQuestion.Visible = False

        showPanel("text")
        clearForm()

    End Sub

    Sub clearForm()
        ColumnNameTextBox.Text = ""
        RequiredFieldTextBox.SelectedValue = "Yes"
        columnTypeList.SelectedValue = "text"

    End Sub

    Sub showPanel(i As String)

        Select Case i
            Case "text"
                DescriptionPanel.Visible = True
                MultilinePanel.Visible = False
                ChoicePanel.Visible = False
                NumberPanel.Visible = False
                DatePanel.Visible = False
                CurrencyPanel.Visible = False
                YesNoPanel.Visible = False
                TimePanel.Visible = False
            Case "multiline"
                DescriptionPanel.Visible = True
                MultilinePanel.Visible = True
                ChoicePanel.Visible = False
                NumberPanel.Visible = False
                DatePanel.Visible = False
                CurrencyPanel.Visible = False
                YesNoPanel.Visible = False
                TimePanel.Visible = False
            Case "choice"
                DescriptionPanel.Visible = True
                MultilinePanel.Visible = False
                ChoicePanel.Visible = True
                NumberPanel.Visible = False
                DatePanel.Visible = False
                CurrencyPanel.Visible = False
                YesNoPanel.Visible = False
                TimePanel.Visible = False
            Case "number"
                DescriptionPanel.Visible = True
                MultilinePanel.Visible = False
                ChoicePanel.Visible = False
                NumberPanel.Visible = True
                DatePanel.Visible = False
                CurrencyPanel.Visible = False
                YesNoPanel.Visible = False
                TimePanel.Visible = False
            Case "date"
                DescriptionPanel.Visible = True
                MultilinePanel.Visible = False
                ChoicePanel.Visible = False
                NumberPanel.Visible = False
                DatePanel.Visible = True
                CurrencyPanel.Visible = False
                YesNoPanel.Visible = False
                TimePanel.Visible = False
            Case "time"
                DescriptionPanel.Visible = True
                MultilinePanel.Visible = False
                ChoicePanel.Visible = False
                NumberPanel.Visible = False
                DatePanel.Visible = False
                CurrencyPanel.Visible = False
                YesNoPanel.Visible = False
                TimePanel.Visible = True
            Case "currency"
                DescriptionPanel.Visible = True
                MultilinePanel.Visible = False
                ChoicePanel.Visible = False
                NumberPanel.Visible = False
                DatePanel.Visible = False
                CurrencyPanel.Visible = True
                YesNoPanel.Visible = False
                TimePanel.Visible = False
            Case "yes/no"
                DescriptionPanel.Visible = True
                MultilinePanel.Visible = False
                ChoicePanel.Visible = False
                NumberPanel.Visible = False
                DatePanel.Visible = False
                CurrencyPanel.Visible = False
                YesNoPanel.Visible = True
                TimePanel.Visible = False
        End Select

    End Sub

    Private Sub NewEventTypeWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles NewEventTypeWizard.CancelButtonClick
        Response.Redirect("/admin/ClientDetails?Action=0&ClientID=" & Common.GetCurrentClientID() & "#eventtab/#eventtype")
    End Sub

    Private Sub columnTypeList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles columnTypeList.SelectedIndexChanged
        Dim i = columnTypeList.SelectedValue
        showPanel(i)
    End Sub

    Private Sub btnCancelNewQuestion_Click(sender As Object, e As EventArgs) Handles btnCancelNewQuestion.Click

        NewRecapQuestionPanel.Visible = False
        RecapQuestionList.Visible = True
        btnAddNewQuestion.Visible = True

        clearForm()

    End Sub

    Private Sub NewEventTypeWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles NewEventTypeWizard.FinishButtonClick

        Try
            ' insert eventtype
            Dim eventtype As New tblEventType
            ' eventtype.eventTypeID = IDTextBox.Text
            eventtype.eventTypeName = EventTypeNameTextBox.Text
            db.tblEventTypes.InsertOnSubmit(eventtype)
            db.SubmitChanges()

            If ActiveTextBox.SelectedValue = "True" Then
                ' insert client event type
                Dim clienteventtype As New tblClientEventType
                clienteventtype.clientID = Common.GetCurrentClientID()
                clienteventtype.eventTypeID = eventtype.eventTypeID

                db.tblClientEventTypes.InsertOnSubmit(clienteventtype)
                db.SubmitChanges()
            End If

            'add tasks
            Dim t = From p In db.tempEventTypeTasks Where p.tempGuid = tempGUID.Text Select p
            For Each p In t
                Dim newTask As New tblEventTypeTask
                newTask.eventTypeID = eventtype.eventTypeID
                newTask.taskTitle = p.taskTitle
                newTask.dateDueOffset = p.dateDueOffset
                newTask.notes = p.notes

                db.tblEventTypeTasks.InsertOnSubmit(newTask)
                db.SubmitChanges()
            Next

            'add recap questions
            Dim r = From p In db.tempEventTypeRecapQuestions Where p.tempGUID = tempGUID.Text Select p
            For Each p In r
                Dim newRecap As New tblEventTypeRecapQuestion
                newRecap.eventTypeID = eventtype.eventTypeID
                newRecap.question = p.question
                newRecap.questionType = p.questionType
                newRecap.choices = p.choices
                newRecap.displayOption = p.displayOption
                newRecap.lines = p.lines
                newRecap.description = p.description
                newRecap.yes_noDefaultValue = p.yes_noDefaultValue
                newRecap.numberDecimalPlace = p.numberDecimalPlace
                newRecap.numberDefaultValue = p.numberDefaultValue
                newRecap.showPercentage = p.showPercentage
                newRecap.dateFormat = p.dateFormat
                newRecap.dateDefaultValue = p.dateDefaultValue
                newRecap.timeFormat = p.timeFormat
                newRecap.dateDisplay = p.dateDisplay
                newRecap.clientID = Common.GetCurrentClientID()

                db.tblEventTypeRecapQuestions.InsertOnSubmit(newRecap)
                db.SubmitChanges()
            Next

            Response.Redirect("/admin/ClientDetails?Action=1&ClientID=" & Common.GetCurrentClientID() & "#eventtab/#eventtype")
        Catch ex As Exception
            msgLabel.Text = ex.Message.ToString()
        End Try


    End Sub

    Private Sub btnInsertQuestion_Click(sender As Object, e As EventArgs) Handles btnInsertQuestion.Click
        Try
            Dim _tempGuid As String = tempGUID.Text

            Dim recap As New tempEventTypeRecapQuestion
            recap.tempGUID = _tempGuid
            recap.question = ColumnNameTextBox.Text
            recap.questionType = columnTypeList.SelectedValue
            recap.displayOption = DisplayOptions.SelectedValue
            recap.choices = txtChioces.Text
            recap.displayOption = DisplayOptions.SelectedValue
            recap.lines = txtLines.Text
            recap.description = txtDescription.Text
            recap.yes_noDefaultValue = ckbYesNo.SelectedValue
            recap.numberDecimalPlace = txtDecimalPlace.Text
            recap.numberDefaultValue = txtDefaultNumber.Text
            recap.showPercentage = ckbPercentage.SelectedValue
            recap.dateFormat = ckbDateFormat.SelectedValue
            recap.dateDefaultValue = ckbDateDefualtValue.SelectedValue
            recap.timeFormat = ckbTimeFormat.SelectedValue
            recap.dateDisplay = ckbDateDisplayFormat.SelectedValue


            db.tempEventTypeRecapQuestions.InsertOnSubmit(recap)
            db.SubmitChanges()

            NewRecapQuestionPanel.Visible = False
            RecapQuestionList.Visible = True
            btnAddNewQuestion.Visible = True

            clearForm()

            RecapQuestionList.DataBind()
        Catch ex As Exception
            Label1.Text = ex.Message()
        End Try


    End Sub


    Shared Function ShowAlertNoClose(ByVal type As String, ByVal msg As String) As String
        Return String.Format("<div class='alert alert-{0}'>{1}</div>", type, msg)
    End Function

    Private Sub RecapQuestionList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles RecapQuestionList.ItemDataBound
        If RecapQuestionList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If
        End If
    End Sub

    Private Sub getTempEventTypeTasks_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getTempEventTypeTasks.Inserting

        Dim l As tempEventTypeTask
        l = CType(e.NewObject, tempEventTypeTask)
        l.tempGuid = tempGUID.Text

    End Sub

    Function formatTimeOffset(ByVal t As String) As String

        Select Case t
            Case "0"
                Return "0 days"
            Case "-1"
                Return "1 day prior"
            Case "-2"
                Return "2 days prior"
            Case "-3"
                Return "3 days prior"
            Case "-4"
                Return "4 days prior"
            Case "-5"
                Return "5 days prior"
            Case "-6"
                Return "6 days prior"
            Case "-7"
                Return "7 days prior"
            Case "-14"
                Return "14 days prior"
            Case "-30"
                Return "30 days prior"
            Case "1"
                Return "1 day after"
            Case "2"
                Return "2 days after"
            Case "3"
                Return "3 days after"
            Case Else
                Return ""
        End Select

    End Function

End Class