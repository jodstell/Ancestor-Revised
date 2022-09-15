Imports Microsoft.AspNet.Identity

Public Class EditActivityType
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            Select Case Request.QueryString("Mode")
                Case "Edit"
                    btnSave.Visible = False
                    bindForm()

                Case "Add"
                    btnAddField.Visible = False
                    btnUpdate.Visible = False

                    ActivityNameLabel.Text = "New"

                Case "AddColumns"
                    btnSave.Visible = False
                    bindForm()

                    'show msgBox
                    msgLabel.Text = Common.ShowAlertNoClose("success", "The new Activity Type has been addedd successfully.  Click on the Add New Column button to add the Activity Questions.")


            End Select


        End If

    End Sub

    Sub bindForm()

        Dim q = From p In db.tblActivityTypes Where p.activityTypeID = Request.QueryString("ActivityTypeID") Select p
        For Each p In q
            ActivityNameLabel.Text = p.activityName
            activityNameTextBox.Text = p.activityName

        Next

    End Sub

    Private Sub ColumnList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles ColumnList.ItemCommand
        If e.CommandName = "EditField" Then
            Response.Redirect("/admin/clientsettings/editfield?FieldID=" & e.CommandArgument & "&ClientID=" & Common.GetCurrentClientID() & "&ActivityTypeID=" & Request.QueryString("ActivityTypeID"))
        End If

        If e.CommandName = "DeleteRow" Then

            db.DeleteActivityField(Convert.ToInt32(e.CommandArgument))
            db.SubmitChanges()

            ColumnList.DataBind()
        End If
    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click

        'save the form
        Dim i = (From p In db.tblActivityTypes Where p.activityTypeID = Request.QueryString("ActivityTypeID") Select p).FirstOrDefault

        i.activityName = activityNameTextBox.Text
        'i.order = OrderTextBox.Text

        'update active

        Dim DataKey As Integer = Request.QueryString("ActivityTypeID")
        Dim clientID As Integer = Convert.ToInt32(Common.GetCurrentClientID())

        If ActiveTextBox.SelectedValue = "True" Then


            Dim inList = (From p In db.tblClientActivityTypes Where p.activityTypeID = DataKey And p.clientID = clientID Select p)

            'check if true in database
            If inList.Count > 0 Then
                'do nothing

            Else
                'add the record
                Dim x As New tblClientActivityType
                x.clientID = clientID
                x.activityTypeID = DataKey

                db.tblClientActivityTypes.InsertOnSubmit(x)
                db.SubmitChanges()

            End If

        End If

        If ActiveTextBox.SelectedValue = "True" Then
            Dim inList = (From p In db.tblClientActivityTypes Where p.activityTypeID = DataKey And p.clientID = clientID Select p)

            'check if true in database
            If inList.Count > 0 Then
                'delete record

                Dim delete = db.DeleteClientActivityType(clientID, DataKey)
            Else
                'do nothing

            End If

        End If


        db.SubmitChanges()

        Response.Redirect("/admin/ClientDetails?ClientID=" & Common.GetCurrentClientID() & "#accounttab/accountactivities")
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Dim i = New tblActivityType With {.activityName = activityNameTextBox.Text, .isDeleted = False, .createdBy = Context.User.Identity.GetUserId(), .createdDate = Date.Now()}
        db.tblActivityTypes.InsertOnSubmit(i)
        db.SubmitChanges()

        If ActiveTextBox.SelectedValue = "True" Then
            Dim n = New tblClientActivityType With {.clientID = Common.GetCurrentClientID(), .activityTypeID = i.activityTypeID}
            db.tblClientActivityTypes.InsertOnSubmit(n)
            db.SubmitChanges()
        End If

        Response.Redirect("/admin/ClientSettings/EditActivityType?ClientID=" & Common.GetCurrentClientID() & "&ActivityTypeID=" & i.activityTypeID & "&Mode=AddColumns")


    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click

        Response.Redirect("/admin/ClientDetails?ClientID=" & Common.GetCurrentClientID() & "#accounttab/accountactivities")
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

    Private Sub btnAddField_Click(sender As Object, e As EventArgs) Handles btnAddField.Click
        AddNewColumnPanel.Visible = True
        MainPanel.Visible = False

        ClearForm()

    End Sub

    Private Sub btnCancelNewQuestion_Click(sender As Object, e As EventArgs) Handles btnCancelNewQuestion.Click

        AddNewColumnPanel.Visible = False
        MainPanel.Visible = True

    End Sub

    Private Sub btnInsertQuestion_Click(sender As Object, e As EventArgs) Handles btnInsertQuestion.Click

        Dim LastRow = (From p In db.tblActivityFields Where p.activityTypeID = Request.QueryString("ActivityTypeID") Order By p.sortOrder Descending Select p.sortOrder).FirstOrDefault

        Dim count = (From p In db.tblActivityFields Where p.activityTypeID = Request.QueryString("ActivityTypeID") Select p).Count
        If count = 0 Then LastRow = 0

        'save form
        Dim Activity As New tblActivityField
        Activity.activityTypeID = Request.QueryString("ActivityTypeID")
        Activity.fieldName = ColumnNameTextBox.Text
        Activity.type = columnTypeList.SelectedValue
        Activity.required = RequiredFieldTextBox.SelectedValue
        Activity.sortOrder = LastRow + 1

        Activity.description = txtDescription.Text
        Activity.yes_noDefaultValue = ckbYesNo.SelectedValue
        Activity.numberDecimalPlace = txtDecimalPlace.Text
        Activity.numberDefaultValue = txtDefaultNumber.Text
        Activity.showPercentage = ckbPercentage.SelectedValue
        Activity.dateFormat = ckbDateFormat.SelectedValue
        Activity.dateDefaultValue = ckbDateDefualtValue.SelectedValue
        Activity.timeFormat = ckbTimeFormat.SelectedValue
        Activity.dateDisplay = ckbDateDisplayFormat.SelectedValue
        Activity.displayOptions = DisplayOptions.SelectedValue
        Activity.choices = txtChioces.Text
        Try
            Activity.rows = txtLines.Text
        Catch ex As Exception

        End Try


        db.tblActivityFields.InsertOnSubmit(Activity)
        db.SubmitChanges()


        'Add choices to activity options
        Dim getLine As [String] = ""

        Dim mylines As String() = txtChioces.Text.Split(vbLf)
        For i As Integer = 0 To mylines.Length - 1
            getLine = mylines(i).ToString()

            Dim o As New tblActivityOption
            o.fieldID = Activity.fieldID
            o.optionName = getLine
            o.optionValue = getLine
            o.optionType = DisplayOptions.SelectedValue
            o.order = i + 1

            db.tblActivityOptions.InsertOnSubmit(o)
            db.SubmitChanges()

        Next

        AddNewColumnPanel.Visible = False
        MainPanel.Visible = True

        ' refresh grid
        ColumnList.DataBind()

    End Sub

    Sub ClearForm()
        ColumnNameTextBox.Text = ""
        columnTypeList.SelectedValue = "text"
        RequiredFieldTextBox.SelectedValue = "False"
        txtDescription.Text = ""

        txtLines.Text = ""

        txtDescription.Text = ""
        ckbYesNo.SelectedValue = "True"
        txtDecimalPlace.SelectedValue = "0"
        txtDefaultNumber.Text = "0"
        ckbPercentage.SelectedValue = "False"
        ckbDateFormat.SelectedValue = "Date"
        ckbDateDefualtValue.SelectedValue = "None"
        ckbTimeFormat.SelectedValue = "12 hours"
        ckbDateDisplayFormat.SelectedValue = "Standard"
        DisplayOptions.SelectedValue = "drop"
        txtChioces.Text = ""




    End Sub

    Function ShowLastButton(ByVal id As Integer) As String
        Dim LastRow = (From p In db.tblActivityFields Where p.activityTypeID = Request.QueryString("ActivityTypeID") Order By p.sortOrder Descending Select p.sortOrder).FirstOrDefault
        Dim ThisRow = (From p In db.tblActivityFields Where p.activityTypeID = Request.QueryString("ActivityTypeID") And p.fieldID = id Select p.sortOrder).FirstOrDefault

        If ThisRow = LastRow Then
            Return "False"
        Else
            Return "True"
        End If

    End Function

    Function ShowFirstButton(ByVal id As Integer) As String
        Dim FirstRow = (From p In db.tblActivityFields Where p.activityTypeID = Request.QueryString("ActivityTypeID") Order By p.sortOrder Ascending Select p.sortOrder).FirstOrDefault
        Dim ThisRow = (From p In db.tblActivityFields Where p.activityTypeID = Request.QueryString("ActivityTypeID") And p.fieldID = id Select p.sortOrder).FirstOrDefault

        If ThisRow = FirstRow Then
            Return "False"
        Else
            Return "True"
        End If
    End Function

    Protected Sub moveup(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim ID As String = CType(sender, LinkButton).CommandArgument
        Dim ActivityTypeID As String = Request.QueryString("ActivityTypeID")

        db.MoveUp_ActivityField(Convert.ToInt32(ActivityTypeID), Convert.ToInt32(ID))
        db.SubmitChanges()

        ColumnList.DataBind()


    End Sub

    Protected Sub movedown(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim ID As String = CType(sender, LinkButton).CommandArgument
        Dim ActivityTypeID As String = Request.QueryString("ActivityTypeID")

        db.MoveDown_ActivityField(Convert.ToInt32(ActivityTypeID), Convert.ToInt32(ID))
        db.SubmitChanges()

        ColumnList.DataBind()

    End Sub

    Private Sub ColumnList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles ColumnList.ItemDataBound

        If ColumnList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If


    End Sub

    Shared Function ShowAlertNoClose(ByVal type As String, ByVal msg As String) As String
        Return String.Format("<div class='alert alert-{0}'>{1}</div>", type, msg)
    End Function


End Class