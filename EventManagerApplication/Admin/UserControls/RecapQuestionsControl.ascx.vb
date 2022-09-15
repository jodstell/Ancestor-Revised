Imports Telerik.Web.UI

Public Class RecapQuestionsControl
    Inherits System.Web.UI.UserControl
    Dim order As Integer
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim _brandName = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p.brandName).FirstOrDefault

        Dim _pps = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p.packageSize).FirstOrDefault

        Dim questions = From p In db.tblDefaultRecapQuestions Select p Order By p.QuestionID


    End Sub

    Private Sub BrandRecapList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles BrandRecapList.ItemCommand

        If e.CommandName = "EditRecapQuestion" Then
            RecapListPanel.Visible = False

            Dim t As String = e.CommandArgument
            BindForm(t)

            NewRecapQuestionPanel.Visible = True

            btnInsertQuestion.Visible = False
            btnUpdateQuestion.Visible = True
        End If


        If e.CommandName = "AddQuestion" Then
            RecapListPanel.Visible = False
            NewRecapQuestionPanel.Visible = True

            showPanel("text")
            clearForm()

        End If
    End Sub

    Private Sub getBrandRecapQuestionList_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getBrandRecapQuestionList.Inserting

        Dim l As tblBrandRecapQuestion
        l = CType(e.NewObject, tblBrandRecapQuestion)
        l.brandID = Request.QueryString("BrandID")

        db.UpdateEventModifiedFlag(l.brandID)

    End Sub

    Sub BindForm(questionID As String)

        Dim myform = From recap In db.tblBrandRecapQuestions Where recap.brandRecapQuestionID = questionID Select recap

        For Each recap In myform
            Hidden_recapQuestionID.Text = questionID

            Hidden_SortOrder.Text = recap.sortOrder


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

            Catch ex As Exception
                ckbPercentage.SelectedValue = recap.showPercentage
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

    Protected Sub moveup(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim ID As String = CType(sender, LinkButton).CommandArgument
        Dim BrandID As String = Request.QueryString("BrandID")

        db.MoveUp_BrandRecapQuestion(Convert.ToInt32(BrandID), Convert.ToInt32(ID))
        db.SubmitChanges()

        BrandRecapList.DataBind()


    End Sub

    Protected Sub movedown(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim ID As String = CType(sender, LinkButton).CommandArgument
        Dim BrandID As String = Request.QueryString("BrandID")

        db.MoveDown_BrandRecapQuestion(Convert.ToInt32(BrandID), Convert.ToInt32(ID))
        db.SubmitChanges()

        BrandRecapList.DataBind()

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

    Private Sub columnTypeList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles columnTypeList.SelectedIndexChanged
        Dim i = columnTypeList.SelectedValue
        showPanel(i)
    End Sub


    Private Sub btnInsertQuestion_Click(sender As Object, e As EventArgs) Handles btnInsertQuestion.Click

        Try

            Dim neworder = (From p In db.tblBrandRecapQuestions Where p.brandID = Request.QueryString("BrandID") Order By p.sortOrder Descending Select p.sortOrder).FirstOrDefault

            'we need to see if this is the first record and assign the sort order to 1
            Dim sort As Integer
            Dim hasItems = (From p In db.tblBrandRecapQuestions Where p.brandID = Request.QueryString("BrandID") Select p).Count

            If hasItems = 0 Then
                sort = 0
            Else
                sort = (From p In db.tblBrandRecapQuestions Where p.brandID = Request.QueryString("BrandID") Order By p.sortOrder Descending Select p.sortOrder).FirstOrDefault
            End If

            Dim recap As New tblBrandRecapQuestion
            recap.brandID = Request.QueryString("BrandID")
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
            recap.sortOrder = sort + 1
            recap.required = RequiredFieldTextBox.SelectedValue
            recap.digit = txtDecimalPlace.Text

            db.tblBrandRecapQuestions.InsertOnSubmit(recap)
            db.SubmitChanges()

            order = 0
            Dim getLine As [String] = ""

            Dim mylines As String() = txtChioces.Text.Split(vbLf)
            For i As Integer = 0 To mylines.Length - 1
                getLine = mylines(i).ToString()

                Dim o As New tblRecapQuestionOption
                o.brandRecapQuestionID = recap.brandRecapQuestionID
                o.option = getLine
                o.optionType = DisplayOptions.SelectedValue
                o.sortOrder = i

                db.tblRecapQuestionOptions.InsertOnSubmit(o)

                Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
                result.modifiedBy = Session("CurrentUserID")
                result.modifiedDate = Date.Now()

                db.SubmitChanges()

            Next

            ' Dim newrecap = db.InsertRecapQuestion(Request.QueryString("BrandID"), recap.question, recap.questionType, 1, recap.sortOrder, recap.brandRecapQuestionID)

        Catch ex As Exception
            'msg.Text = ex.Message
        End Try

        RecapListPanel.Visible = True
        NewRecapQuestionPanel.Visible = False

        BrandRecapList.DataBind()

        db.UpdateEventModifiedFlag(Convert.ToInt32(Request.QueryString("BrandID")))

    End Sub

    Private Sub btnCancelNewQuestion_Click(sender As Object, e As EventArgs) Handles btnCancelNewQuestion.Click

        RecapListPanel.Visible = True
        NewRecapQuestionPanel.Visible = False

        clearForm()

    End Sub

    Sub clearForm()
        ColumnNameTextBox.Text = ""
        RequiredFieldTextBox.SelectedValue = True
        columnTypeList.SelectedValue = "text"

    End Sub

    Private Sub getBrandRecapQuestionList_Deleting(sender As Object, e As LinqDataSourceDeleteEventArgs) Handles getBrandRecapQuestionList.Deleting

        Dim question As tblBrandRecapQuestion
        question = CType(e.OriginalObject, tblBrandRecapQuestion)

        Dim this = question.brandRecapQuestionID

        Dim deleteRecap = db.DeleteRecapQuestion(this, 1)

    End Sub

    Private Sub btnUpdateQuestion_Click(sender As Object, e As EventArgs) Handles btnUpdateQuestion.Click

        'we need to delete the recap question before we add the new one
        Dim deleteRecap = db.DeleteRecapQuestion(Hidden_recapQuestionID.Text, 1)

        Try
            Dim recap As New tblBrandRecapQuestion
            recap.brandID = Request.QueryString("BrandID")
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
            recap.sortOrder = Hidden_SortOrder.Text
            db.tblBrandRecapQuestions.InsertOnSubmit(recap)
            db.SubmitChanges()

            order = 0
            Dim getLine As [String] = ""

            Dim mylines As String() = txtChioces.Text.Split(vbLf)
            For i As Integer = 0 To mylines.Length - 1
                getLine = mylines(i).ToString()

                Dim o As New tblRecapQuestionOption
                o.brandRecapQuestionID = recap.brandRecapQuestionID
                o.option = getLine
                o.optionType = DisplayOptions.SelectedValue
                o.sortOrder = i

                db.tblRecapQuestionOptions.InsertOnSubmit(o)

                Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
                result.modifiedBy = Session("CurrentUserID")
                result.modifiedDate = Date.Now()

                db.SubmitChanges()

            Next

            'delete the origional recap
            db.DeleteSelectedBrandRecapQuestion(Hidden_recapQuestionID.Text)

            'add new recap to list
            ' Dim newrecap = db.InsertRecapQuestion(Request.QueryString("BrandID"), recap.question, recap.questionType, 1, recap.sortOrder, recap.brandRecapQuestionID)

        Catch ex As Exception
            'msg.Text = ex.Message
        End Try

        RecapListPanel.Visible = True
        NewRecapQuestionPanel.Visible = False

        BrandRecapList.DataBind()

        db.UpdateEventModifiedFlag(Convert.ToInt32(Request.QueryString("BrandID")))

    End Sub

    Function ShowLastButton(ByVal id As Integer) As String
        Dim LastRow = (From p In db.tblBrandRecapQuestions Where p.brandID = Request.QueryString("BrandID") Order By p.sortOrder Descending Select p.sortOrder).FirstOrDefault
        Dim ThisRow = (From p In db.tblBrandRecapQuestions Where p.brandID = Request.QueryString("BrandID") And p.brandRecapQuestionID = id Select p.sortOrder).FirstOrDefault

        If ThisRow = LastRow Then
            Return "False"
        Else
            Return "True"
        End If

    End Function

    Function ShowFirstButton(ByVal id As Integer) As String
        Dim FirstRow = (From p In db.tblBrandRecapQuestions Where p.brandID = Request.QueryString("BrandID") Order By p.sortOrder Ascending Select p.sortOrder).FirstOrDefault
        Dim ThisRow = (From p In db.tblBrandRecapQuestions Where p.brandID = Request.QueryString("BrandID") And p.brandRecapQuestionID = id Select p.sortOrder).FirstOrDefault

        If ThisRow = FirstRow Then
            Return "False"
        Else
            Return "True"
        End If
    End Function

    Private Sub getBrandRecapQuestionList_Deleted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getBrandRecapQuestionList.Deleted
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()


        db.SubmitChanges()

        'update all events
        db.UpdateEventModifiedFlag(result.brandID)
    End Sub

    Private Sub getBrandRecapQuestionList_Inserted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getBrandRecapQuestionList.Inserted

        db.UpdateEventModifiedFlag(Convert.ToInt32(Request.QueryString("BrandID")))

        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()
        db.SubmitChanges()

    End Sub

    Private Sub getBrandRecapQuestionList_Updated(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getBrandRecapQuestionList.Updated

        db.UpdateEventModifiedFlag(Convert.ToInt32(Request.QueryString("BrandID")))

        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()

    End Sub


End Class