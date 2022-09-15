Public Class EditField
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            bindForm()
        End If
    End Sub

    Sub bindForm()
        Dim q = From p In db.tblActivityFields Where p.fieldID = Request.QueryString("FieldID") Select p
        For Each p In q
            Me.ColumnNameTextBox.Text = p.fieldName


            'RequiredFieldTextBox
            RequiredFieldTextBox.SelectedValue = p.required

            Dim t As String = p.type

            Me.columnTypeList.SelectedValue = t
            showPanel(t)

            Try
                txtDescription.Text = p.description
            Catch ex As Exception

            End Try

            Try
                DisplayOptions.SelectedValue = p.displayOptions
            Catch ex As Exception

            End Try

            Try
                txtChioces.Text = p.choices
            Catch ex As Exception

            End Try

            Try
                ckbYesNo.SelectedValue = p.yes_noDefaultValue
            Catch ex As Exception

            End Try

            Try
                txtDecimalPlace.Text = p.numberDecimalPlace
            Catch ex As Exception

            End Try

            Try
                txtDefaultNumber.Text = p.numberDefaultValue
            Catch ex As Exception

            End Try

            Try
                ckbPercentage.SelectedValue = p.showPercentage
            Catch ex As Exception

            End Try

            Try
                ckbDateFormat.SelectedValue = p.dateFormat
            Catch ex As Exception

            End Try

            Try
                ckbDateDefualtValue.SelectedValue = p.dateDefaultValue
            Catch ex As Exception

            End Try

            Try
                ckbTimeFormat.SelectedValue = p.timeFormat
            Catch ex As Exception

            End Try

            Try
                ckbDateDisplayFormat.SelectedValue = p.dateDisplay
            Catch ex As Exception

            End Try

        Next

        ActivityTypeNameLabel.Text = (From p In db.tblActivityTypes Where p.activityTypeID = Request.QueryString("ActivityTypeID") Select p.activityName).FirstOrDefault


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

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect("/admin/ClientSettings/EditActivityType?ClientID=" & Common.GetCurrentClientID() & "&ActivityTypeID=" & Request.QueryString("ActivityTypeID") & "&Mode=Edit")
    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click

        'add the update stuff here

        Dim q = (From p In db.tblActivityFields Where p.fieldID = Request.QueryString("FieldID") Select p).FirstOrDefault

        q.fieldName = ColumnNameTextBox.Text
        q.type = columnTypeList.SelectedValue

        q.required = RequiredFieldTextBox.SelectedValue


        q.displayOptions = DisplayOptions.SelectedValue
        q.choices = txtChioces.Text
        q.rows = txtLines.Text
        q.description = txtDescription.Text
        q.yes_noDefaultValue = ckbYesNo.SelectedValue
        q.numberDecimalPlace = txtDecimalPlace.Text
        q.numberDefaultValue = txtDefaultNumber.Text
        q.showPercentage = ckbPercentage.SelectedValue
        q.dateFormat = ckbDateFormat.SelectedValue
        q.dateDefaultValue = ckbDateDefualtValue.SelectedValue
        q.timeFormat = ckbTimeFormat.SelectedValue
        q.dateDisplay = ckbDateDisplayFormat.SelectedValue

        db.SubmitChanges()

        Response.Redirect("/admin/ClientSettings/EditActivityType?ClientID=" & Common.GetCurrentClientID() & "&ActivityTypeID=" & Request.QueryString("ActivityTypeID") & "&Mode=Edit")

    End Sub
End Class