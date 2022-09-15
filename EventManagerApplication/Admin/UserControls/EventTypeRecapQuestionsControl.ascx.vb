Imports Telerik.Web.UI

Public Class EventTypeRecapQuestionsControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub columnTypeList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles columnTypeList.SelectedIndexChanged
        Dim i = columnTypeList.SelectedValue
        showPanel(i)
    End Sub

    Sub clearForm()
        ColumnNameTextBox.Text = ""
        RequiredFieldTextBox.SelectedValue = "False"
        columnTypeList.SelectedValue = "text"
        txtDescription.Text = ""
        txtLines.Text = 4
        txtChioces.Text = ""
        ckbYesNo.SelectedValue = "No"
        DisplayOptions.SelectedValue = "drop"
        txtDecimalPlace.SelectedValue = "0"
        txtDefaultNumber.Text = "0"
        ckbPercentage.SelectedValue = "False"
        ckbDateFormat.SelectedValue = "Date"
        ckbDateDisplayFormat.SelectedValue = "Standard"
        ckbDateDefualtValue.SelectedValue = "None"
        ckbTimeFormat.SelectedValue = "12 hours"
    End Sub

    Private Sub btnInsertQuestion_Click(sender As Object, e As EventArgs) Handles btnInsertQuestion.Click

        Try
            Dim recap As New tblEventTypeRecapQuestion
            'we need to see if this is the first record and assign the sort order to 1
            Dim sort As Integer
            Dim hasItems = (From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = Request.QueryString("EventTypeID") Select p).Count

            If hasItems = 0 Then
                sort = 0
            Else
                sort = (From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = Request.QueryString("EventTypeID") Order By p.sortorder Descending Select p.sortorder).FirstOrDefault
            End If

            recap.eventTypeID = Request.QueryString("EventTypeID")
            recap.clientID = Common.GetCurrentClientID()
            recap.required = RequiredFieldTextBox.SelectedValue

            recap.question = ColumnNameTextBox.Text
            recap.questionType = columnTypeList.SelectedValue
            recap.displayOption = DisplayOptions.SelectedValue
            recap.choices = txtChioces.Text
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

            recap.sortorder = sort + 1

            db.tblEventTypeRecapQuestions.InsertOnSubmit(recap)
            db.SubmitChanges()


            Dim getLine As [String] = ""

            Dim mylines As String() = txtChioces.Text.Split(vbLf)
            For i As Integer = 0 To mylines.Length - 1
                getLine = mylines(i).ToString()

                Dim o As New tblRecapQuestionOption
                o.brandRecapQuestionID = recap.eventTypeRecapQuestionID
                o.option = getLine
                o.optionType = DisplayOptions.SelectedValue
                o.sortOrder = i + 1

                db.tblRecapQuestionOptions.InsertOnSubmit(o)
                db.SubmitChanges()

            Next

            ' Dim newrecap = db.InsertEventTypeRecapQuestion(recap.eventTypeID, recap.question, recap.questionType, 2, recap.sortorder, recap.eventTypeRecapQuestionID)

            RecapListPanel.Visible = True
            NewRecapQuestionPanel.Visible = False

            clearForm()

            RecapList.DataBind()
        Catch ex As Exception
            errLabel.Text = ex.Message
        End Try



    End Sub

    Private Sub btnUpdateQuestion_Click(sender As Object, e As EventArgs) Handles btnUpdateQuestion.Click


        Try
            Dim recap As New tblEventTypeRecapQuestion

            '    Dim sort As Integer = (From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = Request.QueryString("EventTypeID") Order By p.sortorder Descending Select p.sortorder).FirstOrDefault

            recap.eventTypeID = Request.QueryString("EventTypeID")
            recap.clientID = Common.GetCurrentClientID()

            recap.required = RequiredFieldTextBox.SelectedValue
            recap.question = ColumnNameTextBox.Text
            recap.questionType = columnTypeList.SelectedValue
            recap.displayOption = DisplayOptions.SelectedValue
            recap.choices = txtChioces.Text
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
            recap.sortorder = Hidden_SortOrder.Text

            db.tblEventTypeRecapQuestions.InsertOnSubmit(recap)
            db.SubmitChanges()


            Dim getLine As [String] = ""

            Dim mylines As String() = txtChioces.Text.Split(vbLf)
            For i As Integer = 0 To mylines.Length - 1
                getLine = mylines(i).ToString()

                Dim o As New tblRecapQuestionOption
                o.brandRecapQuestionID = recap.eventTypeRecapQuestionID
                o.option = getLine
                o.optionType = DisplayOptions.SelectedValue
                o.sortOrder = i + 1

                db.tblRecapQuestionOptions.InsertOnSubmit(o)
                db.SubmitChanges()

            Next

            'delete the origional recap
            db.DeleteSelectedEventTypeRecapQuestion(Hidden_recapQuestionID.Text)

            '   Dim newrecap = db.InsertEventTypeRecapQuestion(recap.eventTypeID, recap.question, recap.questionType, 2, recap.sortorder, recap.eventTypeRecapQuestionID)

            RecapListPanel.Visible = True
            NewRecapQuestionPanel.Visible = False

            clearForm()

            RecapList.DataBind()
        Catch ex As Exception
            errLabel.Text = ex.Message
        End Try

    End Sub


    Private Sub btnCancelNewQuestion_Click(sender As Object, e As EventArgs) Handles btnCancelNewQuestion.Click

        RecapListPanel.Visible = True
        NewRecapQuestionPanel.Visible = False

        clearForm()

    End Sub

    Sub showPanel(i As String)
        Try
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
        Catch ex As Exception

        End Try
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


    Sub BindForm(questionID As String)

        Dim myform = From recap In db.tblEventTypeRecapQuestions Where recap.eventTypeRecapQuestionID = questionID Select recap

        For Each recap In myform
            Try
                Hidden_recapQuestionID.Text = questionID
            Catch ex As Exception

            End Try

            Try
                Hidden_SortOrder.Text = recap.sortorder
            Catch ex As Exception

            End Try

            Try
                ColumnNameTextBox.Text = recap.question
            Catch ex As Exception

            End Try

            Try
                columnTypeList.SelectedValue = recap.questionType
            Catch ex As Exception

            End Try

            Try
                showPanel(recap.questionType)
            Catch ex As Exception

            End Try

            Try
                DisplayOptions.SelectedValue = recap.displayOption
            Catch ex As Exception

            End Try

            Try
                txtChioces.Text = recap.choices
            Catch ex As Exception

            End Try

            Try
                txtLines.Text = recap.lines
            Catch ex As Exception

            End Try

            Try
                txtDescription.Text = recap.description
            Catch ex As Exception

            End Try

            Try
                ckbYesNo.SelectedValue = recap.yes_noDefaultValue
            Catch ex As Exception

            End Try

            Try
                txtDecimalPlace.Text = recap.numberDecimalPlace
            Catch ex As Exception

            End Try

            Try
                txtDefaultNumber.Text = recap.numberDefaultValue
            Catch ex As Exception

            End Try

            Try
                ckbPercentage.SelectedValue = recap.showPercentage
            Catch ex As Exception

            End Try

            Try
                ckbDateFormat.SelectedValue = recap.dateFormat
            Catch ex As Exception

            End Try

            Try
                ckbDateDefualtValue.SelectedValue = recap.dateDefaultValue
            Catch ex As Exception

            End Try

            Try
                ckbTimeFormat.SelectedValue = recap.timeFormat
            Catch ex As Exception

            End Try

            Try
                ckbDateDisplayFormat.SelectedValue = recap.dateDisplay
            Catch ex As Exception

            End Try

            Try
                RequiredFieldTextBox.SelectedValue = recap.required
            Catch ex As Exception

            End Try


        Next


    End Sub

    Shared Function ShowAlertNoClose(ByVal type As String, ByVal msg As String) As String
        Return String.Format("<div class='alert alert-{0}'>{1}</div>", type, msg)
    End Function

    Private Sub RecapList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles RecapList.ItemCommand
        If e.CommandName = "EditRecapQuestion" Then

            errLabel.Text = ""
            RecapListPanel.Visible = False

            Dim t As String = e.CommandArgument
            BindForm(t)

            NewRecapQuestionPanel.Visible = True

            btnInsertQuestion.Visible = False
            btnUpdateQuestion.Visible = True


        End If

        If e.CommandName = "AddQuestion" Then

            errLabel.Text = ""

            RecapListPanel.Visible = False
            NewRecapQuestionPanel.Visible = True
            btnInsertQuestion.Visible = True
            btnUpdateQuestion.Visible = False

            showPanel("text")
            clearForm()

        End If

    End Sub



    Private Sub getEventTypeRecapQuestionList_Deleting(sender As Object, e As LinqDataSourceDeleteEventArgs) Handles getEventTypeRecapQuestionList.Deleting

        Dim question As tblEventTypeRecapQuestion
        question = CType(e.OriginalObject, tblEventTypeRecapQuestion)

        Dim this = question.eventTypeRecapQuestionID

        Dim deleteRecap = db.DeleteRecapQuestion(this, 2)


    End Sub

    Function ShowLastButton(ByVal id As Integer) As String
        Dim LastRow = (From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = Request.QueryString("EventTypeID") Order By p.sortorder Descending Select p.sortorder).FirstOrDefault
        Dim ThisRow = (From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = Request.QueryString("EventTypeID") And p.eventTypeRecapQuestionID = id Select p.sortorder).FirstOrDefault

        If ThisRow = LastRow Then
            Return "False"
        Else
            Return "True"
        End If

    End Function

    Function ShowFirstButton(ByVal id As Integer) As String
        Dim FirstRow = (From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = Request.QueryString("EventTypeID") Order By p.sortorder Ascending Select p.sortorder).FirstOrDefault
        Dim ThisRow = (From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = Request.QueryString("EventTypeID") And p.eventTypeRecapQuestionID = id Select p.sortorder).FirstOrDefault

        If ThisRow = FirstRow Then
            Return "False"
        Else
            Return "True"
        End If
    End Function

    Protected Sub moveup(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim ID As String = CType(sender, LinkButton).CommandArgument
        Dim EventTypeID As String = Request.QueryString("EventTypeID")

        db.MoveUp_EventTypeRecapQuestion(Convert.ToInt32(EventTypeID), Convert.ToInt32(ID))
        db.SubmitChanges()

        RecapList.DataBind()


    End Sub

    Protected Sub movedown(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim ID As String = CType(sender, LinkButton).CommandArgument
        Dim EventTypeID As String = Request.QueryString("EventTypeID")

        db.MoveDown_EventTypeRecapQuestion(Convert.ToInt32(EventTypeID), Convert.ToInt32(ID))
        db.SubmitChanges()

        RecapList.DataBind()

    End Sub
End Class