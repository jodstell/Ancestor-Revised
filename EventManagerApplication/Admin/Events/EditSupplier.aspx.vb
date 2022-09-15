Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class EditSupplier
    Inherits System.Web.UI.Page
    Dim order As Integer
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = Common.GetCurrentClientID() Select p.clientName).FirstOrDefault


        BindForm()

        'Dim q1 = (From p In db.tblEvents Where p.supplierID = Request.QueryString("SupplierID") Select p).Count

        'If q1 > 0 Then
        '    BtnDeleteSupplier.Visible = False
        'Else
        '    BtnDeleteSupplier.Visible = True
        'End If





    End Sub

    Private Sub BindForm()

        If Not Page.IsPostBack Then




            Dim result = From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID")
            For Each p In result

                Me.SupplierNameLabel.Text = p.supplierName

                Try
                    ModifiedByLabel.Text = String.Format("Last modified by {0} on {1}", Common.GetFullName(p.modifiedBy), Common.GetTimeAdjustment(p.modifiedDate))
                Catch ex As Exception

                End Try

            Next
        End If



    End Sub

    Private Sub BrandsList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles BrandsList.ItemCommand
        Select Case e.CommandName
            Case "AddNew"

                Panel1.Visible = False
                EditBrandsPanel.Visible = False
                NewBrandsPanel.Visible = True
                BrandNameLabel.Text = "New Brand"

            Case "EditBrand"
                Session.Add("SelectedBrandID", e.CommandArgument)
                BindBrandForm()

                Panel1.Visible = False
                EditBrandsPanel.Visible = True
                BrandNameLabel.Text = "Brand: " & Common.getBrandName(e.CommandArgument)
        End Select
    End Sub

    Private Sub BindBrandForm()
        BrandNameTextBox.Text = Session("SelectedBrandID")

        Dim result = From p In db.tblBrands Where p.brandID = Convert.ToUInt32(Session("SelectedBrandID")) Select p
        For Each p In result
            BrandNameTextBox.Text = p.brandName


            Try
                'ModifiedByLabel.Text = String.Format("Last modified by {0} on {1}", Common.GetFullName(p.modifiedBy), Common.GetTimeAdjustment(p.modifiedDate))
            Catch ex As Exception

            End Try
        Next

    End Sub

    Sub BindBudgetForm(questionID As String)

        Dim myform = From recap In db.tblSupplierBudgetQuestions Where recap.supplierBudgetQuestionID = questionID Select recap

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


    Private Sub getSupplier_Updated(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getSupplier.Updated
        'msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

        Dim result = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()
        db.SubmitChanges()

        RadNotification1.Show()
    End Sub

    Private Sub LogEvent(ByVal sender As Object, ByVal eventName As String, ByVal items As IEnumerable(Of RadListBoxItem))

        Dim affectedItems As New List(Of String)()

        For Each item As RadListBoxItem In items
            affectedItems.Add(item.Value)
        Next

        Dim message As String = String.Format("{0}", affectedItems.ToArray())

    End Sub


    Private Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click

        If RadAsyncUpload1.UploadedFiles.Count = 0 Then
            msgLabel.Text = Common.ShowAlert("danger", "There is no files uploaded!")
        Else

            For Each myFile As UploadedFile In RadAsyncUpload1.UploadedFiles
                Dim resumebytes(myFile.ContentLength - 1) As Byte
                myFile.InputStream.Read(resumebytes, 0, myFile.ContentLength)

                Dim newdocument As New tblSupplierDocument

                newdocument.DocumentID = System.Guid.NewGuid().ToString()
                newdocument.data = resumebytes
                newdocument.SupplierID = Request.QueryString("SupplierID")
                newdocument.FileType = myFile.ContentType
                newdocument.DocumentName = myFile.FileName
                newdocument.ModifiedBy = Context.User.Identity.GetUserId()
                newdocument.ModifiedDate = Date.Now()

                db.tblSupplierDocuments.InsertOnSubmit(newdocument)

                Dim result = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
                result.modifiedBy = Session("CurrentUserID")
                result.modifiedDate = Date.Now()

                db.SubmitChanges()
            Next

            DocumentsGrid.DataBind()

            msgLabel.Text = ""

            'RadNotification1.Show()

        End If


    End Sub

    Private Sub DocumentsGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles DocumentsGrid.ItemCommand

        Select Case e.CommandName
            Case "DeleteFile"
                db.DeleteSupplierDocument(e.CommandArgument)

                msgLabel.Text = ""

                DocumentsGrid.DataBind()

            Case "Download"




        End Select
    End Sub

    Public Function GetFullName(userID As String) As String
        Try
            Dim q = (From p In db.tblProfiles Where p.userID = userID Select p).FirstOrDefault

            Return String.Format("{0} {1}", q.firstName, q.lastName)
        Catch ex As Exception
            Return "Unknown User"
        End Try

    End Function

    Private Sub SupplierBudgetList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles SupplierBudgetList.ItemCommand

        If e.CommandName = "EditQuestion" Then
            RecapListPanel.Visible = False

            Dim supplierBudgetQuestionID As String = e.CommandArgument
            BindBudgetForm(supplierBudgetQuestionID)

            NewQuestionPanel.Visible = True

            btnInsertQuestion.Visible = False
            btnUpdateQuestion.Visible = True
        End If


        If e.CommandName = "AddQuestion" Then
            RecapListPanel.Visible = False
            NewQuestionPanel.Visible = True

            showPanel("text")
            clearForm()

        End If

    End Sub

    Private Sub PurchaseOrdersListView_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PurchaseOrdersListView.ItemCommand

        If e.CommandName = "EditPO" Then

            Dim t As String = e.CommandArgument
            BindBudgetPOForm(t)


            POPanel.Visible = False
            EditPOPanel.Visible = True

        End If

        If e.CommandName = "Delete" Then

            Try
                Dim purchaseID = Convert.ToInt32(e.CommandArgument)

                db.DeletePurchaseOrder(purchaseID)
            Catch ex As Exception

            End Try

            'PurchaseOrdersListView.Rebind()
        End If


        If e.CommandName = "AddPO" Then

            POPanel.Visible = False
            AddNewPOPanel.Visible = True

        End If

    End Sub

    Sub BindBudgetPOForm(purchaseOrderID As String)

        Dim purchase = From p In db.tblPurchaseOrders Where p.purchaseOrderID = purchaseOrderID Select p

        Try

            For Each p In purchase
                lblpurchaseOrderID.Text = p.purchaseOrderID
                EditPONumberTextBox.Text = p.purchaseOrderNumber
                EditPOAmountTextBox.Text = p.poAmount
                EditPOBalanceTextBox.Text = p.poBalance
                EditPORequestorTextBox.Text = p.requestorName
                EditPORequestorEmailTextBox.Text = p.requestorEmail
                EditPODateTextBox.SelectedDate = p.dateIssued
            Next

        Catch ex As Exception

        End Try

    End Sub

    Sub clearForm()
        ColumnNameTextBox.Text = ""
        RequiredFieldTextBox.SelectedValue = False
        txtDescription.Text = ""
        columnTypeList.SelectedValue = "text"

    End Sub

    Private Sub columnTypeList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles columnTypeList.SelectedIndexChanged
        Dim i = columnTypeList.SelectedValue
        showPanel(i)
    End Sub

    Protected Sub moveup(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim ID As String = CType(sender, LinkButton).CommandArgument
        Dim SupplierID As String = Request.QueryString("SupplierID")

        db.MoveUp_SupplierBudgetQuestion(Convert.ToInt32(SupplierID), Convert.ToInt32(ID))
        db.SubmitChanges()

        SupplierBudgetList.DataBind()


    End Sub

    Protected Sub movedown(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim ID As String = CType(sender, LinkButton).CommandArgument
        Dim SupplierID As String = Request.QueryString("SupplierID")

        db.MoveDown_SupplierBudgetQuestion(Convert.ToInt32(SupplierID), Convert.ToInt32(ID))
        db.SubmitChanges()

        SupplierBudgetList.DataBind()

    End Sub

    Function ShowLastButton(ByVal id As Integer) As String
        Dim LastRow = (From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("BrandID") Order By p.sortOrder Descending Select p.sortOrder).FirstOrDefault
        Dim ThisRow = (From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("BrandID") And p.supplierBudgetQuestionID = id Select p.sortOrder).FirstOrDefault

        If ThisRow = LastRow Then
            Return "False"
        Else
            Return "True"
        End If

    End Function

    Function ShowFirstButton(ByVal id As Integer) As String
        Dim FirstRow = (From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("BrandID") Order By p.sortOrder Ascending Select p.sortOrder).FirstOrDefault
        Dim ThisRow = (From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("BrandID") And p.supplierBudgetQuestionID = id Select p.sortOrder).FirstOrDefault

        If ThisRow = FirstRow Then
            Return "False"
        Else
            Return "True"
        End If
    End Function


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

    Private Sub btnCancelNewQuestion_Click(sender As Object, e As EventArgs) Handles btnCancelNewQuestion.Click

        RecapListPanel.Visible = True
        NewQuestionPanel.Visible = False

        clearForm()

    End Sub



    Private Sub getSupplierBudgetQuestions_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getSupplierBudgetQuestions.Inserting

        Dim l As tblSupplierBudgetQuestion
        l = CType(e.NewObject, tblSupplierBudgetQuestion)
        l.supplierID = Request.QueryString("SupplierID")

    End Sub

    Private Sub getSupplierBudgetQuestions_Deleting(sender As Object, e As LinqDataSourceDeleteEventArgs) Handles getSupplierBudgetQuestions.Deleting

        'Dim question As tblSupplierBudgetQuestion
        'question = CType(e.OriginalObject, tblSupplierBudgetQuestion)

        'Dim this = question.supplierBudgetQuestionID

        'Dim deleteRecap = db.DeleteRecapQuestion(this, 1)

    End Sub

    Private Sub btnInsertQuestion_Click(sender As Object, e As EventArgs) Handles btnInsertQuestion.Click

        Try

            Dim neworder = (From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("SupplierID") Order By p.sortOrder Descending Select p.sortOrder).FirstOrDefault

            'we need to see if this is the first record and assign the sort order to 1
            Dim sort As Integer
            Dim hasItems = (From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("SupplierID") Select p).Count

            If hasItems = 0 Then
                sort = 0
            Else
                sort = (From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("SupplierID") Order By p.sortOrder Descending Select p.sortOrder).FirstOrDefault
            End If


            Dim recap As New tblSupplierBudgetQuestion
            recap.supplierID = Request.QueryString("SupplierID")
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

            db.tblSupplierBudgetQuestions.InsertOnSubmit(recap)
            db.SubmitChanges()

            order = 0
            Dim getLine As [String] = ""

            Dim mylines As String() = txtChioces.Text.Split(vbLf)
            For i As Integer = 0 To mylines.Length - 1
                getLine = mylines(i).ToString()

                Dim o As New tblSupplierBudgetQuestionOption
                o.supplierBudgetQuestionID = recap.supplierBudgetQuestionID
                o.option = getLine
                o.optionType = DisplayOptions.SelectedValue
                o.sortOrder = i

                db.tblSupplierBudgetQuestionOptions.InsertOnSubmit(o)

                Dim result = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
                result.modifiedBy = Session("CurrentUserID")
                result.modifiedDate = Date.Now()

                db.SubmitChanges()

            Next

        Catch ex As Exception
            msgLabel1.Text = Common.ShowAlertNoClose("warning", ex.Message)
        End Try

        RecapListPanel.Visible = True
        NewQuestionPanel.Visible = False

        SupplierBudgetList.DataBind()

    End Sub

    Private Sub btnUpdateQuestion_Click(sender As Object, e As EventArgs) Handles btnUpdateQuestion.Click

        'we need to delete the recap question before we add the new one
        '   Dim deleteRecap = db.DeleteRecapQuestion(Hidden_recapQuestionID.Text, 1)

        Try
            Dim recap As New tblSupplierBudgetQuestion
            recap.supplierID = Request.QueryString("SupplierID")
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
            recap.required = RequiredFieldTextBox.SelectedValue
            recap.digit = txtDecimalPlace.Text
            db.tblSupplierBudgetQuestions.InsertOnSubmit(recap)
            db.SubmitChanges()

            order = 0
            Dim getLine As [String] = ""

            Dim mylines As String() = txtChioces.Text.Split(vbLf)
            For i As Integer = 0 To mylines.Length - 1
                getLine = mylines(i).ToString()

                Dim o As New tblSupplierBudgetQuestionOption
                o.supplierBudgetQuestionID = recap.supplierBudgetQuestionID
                o.option = getLine
                o.optionType = DisplayOptions.SelectedValue
                o.sortOrder = i

                db.tblSupplierBudgetQuestionOptions.InsertOnSubmit(o)

                Dim result = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
                result.modifiedBy = Session("CurrentUserID")
                result.modifiedDate = Date.Now()

                db.SubmitChanges()

            Next

            'delete the original recap
            db.DeleteSelectedSupplierBudgetQuestion(Hidden_recapQuestionID.Text)


        Catch ex As Exception
            'msg.Text = ex.Message
        End Try

        RecapListPanel.Visible = True
        NewQuestionPanel.Visible = False

        SupplierBudgetList.DataBind()

    End Sub

    Private Sub getSupplierBudgetQuestions_Deleted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getSupplierBudgetQuestions.Deleted
        Dim result = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub

    Private Sub getSupplierBudgetQuestions_Inserted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getSupplierBudgetQuestions.Inserted
        Dim result = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub

    Private Sub getSupplierBudgetQuestions_Updated(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getSupplierBudgetQuestions.Updated
        Dim result = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub

    Private Sub btnCancelAddPO_Click(sender As Object, e As EventArgs) Handles btnCancelAddPO.Click
        Try
            AddPONumberTextBox.Text = ""
            AddPOAmountTextBox.Value = 0
            AddPOBalanceTextBox.Value = 0
            AddPORequestorTextBox.Text = ""
            AddPORequestorEmailTextBox.Text = ""
            AddPODateTextBox.Clear()
        Catch ex As Exception

        End Try

        POPanel.Visible = True
        AddNewPOPanel.Visible = False
    End Sub

    Private Sub btnCancelEditPO_Click(sender As Object, e As EventArgs) Handles btnCancelEditPO.Click
        POPanel.Visible = True
        EditPOPanel.Visible = False
    End Sub

    Private Sub btnSaveAddPO_Click(sender As Object, e As EventArgs) Handles btnSaveAddPO.Click

        Try
            Dim newBudget As New tblPurchaseOrder
            newBudget.purchaseOrderNumber = AddPONumberTextBox.Text
            newBudget.supplierID = Request.QueryString("SupplierID")
            newBudget.poAmount = AddPOAmountTextBox.Text
            newBudget.poBalance = AddPOBalanceTextBox.Text
            newBudget.requestorName = AddPORequestorTextBox.Text
            newBudget.requestorEmail = AddPORequestorEmailTextBox.Text
            newBudget.dateIssued = AddPODateTextBox.SelectedDate
            newBudget.createdBy = Context.User.Identity.GetUserId()
            newBudget.createdDate = Date.Now()

            db.tblPurchaseOrders.InsertOnSubmit(newBudget)
            db.SubmitChanges()

            AddPONumberTextBox.Text = ""
            AddPOAmountTextBox.Value = 0
            AddPOBalanceTextBox.Value = 0
            AddPORequestorTextBox.Text = ""
            AddPORequestorEmailTextBox.Text = ""
            AddPODateTextBox.Clear()

            PurchaseOrdersListView.Rebind()
            POPanel.Visible = True
            AddNewPOPanel.Visible = False

        Catch ex As Exception

            ErrorLabel.Text = ex.Message()
        End Try

    End Sub

    Private Sub btnSaveEditPO_Click(sender As Object, e As EventArgs) Handles btnSaveEditPO.Click

        Try
            Dim po = (From p In db.tblPurchaseOrders Where p.purchaseOrderID = lblpurchaseOrderID.Text Select p).FirstOrDefault
            po.purchaseOrderNumber = EditPONumberTextBox.Text
            po.supplierID = Request.QueryString("SupplierID")
            po.poAmount = EditPOAmountTextBox.Text
            po.poBalance = EditPOBalanceTextBox.Text
            po.requestorName = EditPORequestorTextBox.Text
            po.requestorEmail = EditPORequestorEmailTextBox.Text
            po.dateIssued = EditPODateTextBox.SelectedDate
            po.modifiedBy = Context.User.Identity.GetUserId()
            po.modifiedDate = Date.Now()

            db.SubmitChanges()
        Catch ex As Exception

        End Try


        PurchaseOrdersListView.Rebind()
        POPanel.Visible = True
        EditPOPanel.Visible = False

    End Sub

    Private Sub btnCancelAddDistributor_Click(sender As Object, e As EventArgs) Handles btnCancelAddDistributor.Click

        Try
            AddDistributorNameTextBox.Text = ""
            AddDistributorCityTextBox.Text = ""
            AddDistributorMarketList.ClearSelection()
        Catch ex As Exception

        End Try

        DistributorsPanel.Visible = True
        AddDistributorsPanel.Visible = False
    End Sub

    Private Sub DistributorsListView_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles DistributorsListView.ItemCommand

        If e.CommandName = "EditDistributor" Then

            Dim t As String = e.CommandArgument
            BindDistributorForm(t)


            DistributorsPanel.Visible = False
            EditDistributorsPanel.Visible = True

        End If

        If e.CommandName = "Delete" Then

            Dim distributorID = Convert.ToInt32(e.CommandArgument)

            db.DeleteDistributor(distributorID)

            'DistributorsListView.Rebind()

        End If


        If e.CommandName = "AddDistributor" Then

            DistributorsPanel.Visible = False
            AddDistributorsPanel.Visible = True

        End If

    End Sub

    Private Sub btnSaveDistributor_Click(sender As Object, e As EventArgs) Handles btnSaveDistributor.Click

        Try
            Dim newDistributor As New tblDistributor
            newDistributor.distributorName = AddDistributorNameTextBox.Text
            newDistributor.marketID = AddDistributorMarketList.SelectedValue
            newDistributor.city = AddDistributorCityTextBox.Text
            newDistributor.supplierID = Request.QueryString("SupplierID")
            newDistributor.createdBy = Context.User.Identity.GetUserId()
            newDistributor.createdDate = Date.Now()

            db.tblDistributors.InsertOnSubmit(newDistributor)
            db.SubmitChanges()

            AddDistributorNameTextBox.Text = ""
            AddDistributorCityTextBox.Text = ""
            AddDistributorMarketList.ClearSelection()
        Catch ex As Exception

        End Try


        DistributorsListView.Rebind()
        DistributorsPanel.Visible = True
        AddDistributorsPanel.Visible = False

    End Sub

    Private Sub btnUpdateDistributor_Click(sender As Object, e As EventArgs) Handles btnUpdateDistributor.Click

        Try
            Dim di = (From p In db.tblDistributors Where p.distributorID = lbldistributor.Text Select p).FirstOrDefault
            di.distributorName = EditDistributorNameTextBox.Text
            di.supplierID = Request.QueryString("SupplierID")
            di.marketID = EditDistributorMarketList.SelectedValue
            di.city = EditDistributorCityTextBox.Text
            di.modifiedBy = Context.User.Identity.GetUserId()
            di.modifiedDate = Date.Now()

            db.SubmitChanges()
        Catch ex As Exception

        End Try


        DistributorsListView.Rebind()
        DistributorsPanel.Visible = True
        EditDistributorsPanel.Visible = False
    End Sub

    Private Sub btnCancelEditDistributor_Click(sender As Object, e As EventArgs) Handles btnCancelEditDistributor.Click
        DistributorsPanel.Visible = True
        EditDistributorsPanel.Visible = False
    End Sub


    Sub BindDistributorForm(distributorID As String)

        Dim distributor = From p In db.tblDistributors Where p.distributorID = distributorID Select p

        Try

            For Each p In distributor
                lbldistributor.Text = p.distributorID
                EditDistributorNameTextBox.Text = p.distributorName
                EditDistributorCityTextBox.Text = p.city
                EditDistributorMarketList.SelectedValue = p.marketID
            Next

        Catch ex As Exception

        End Try

    End Sub

    'Private Sub BtnDeleteSupplier_Click(sender As Object, e As EventArgs) Handles BtnDeleteSupplier.Click

    '    '  DeletePanel.Visible = True


    ' End Sub



    Private Sub btnUpdateBrand_Click(sender As Object, e As EventArgs) Handles btnUpdateBrand.Click
        Panel1.Visible = True
        EditBrandsPanel.Visible = False

        Try
            'save the form
            Dim r = (From p In db.tblBrands Where p.brandID = Convert.ToInt32(Session("SelectedBrandID")) Select p).FirstOrDefault

            r.brandName = BrandNameTextBox.Text
            r.active = ActiveTextBox.Text
            r.brandStartDate = StartDateDatePicker.DbSelectedDate
            r.brandEndDate = EndDateDatePicker.DbSelectedDate
            r.brandDataEndDate = DataViewEndDateDatePicker.DbSelectedDate
            r.modifiedBy = Session("CurrentUserID")
            r.modifiedDate = Date.Now()

            RadNotification1.Show()

            db.SubmitChanges()

            'show the confirmation
            msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

            BindForm()

            ClientScript.RegisterStartupScript(Page.ClientScript.GetType(), Page.ClientID, "resetDotNetScrollPosition();", True)

        Catch ex As Exception
            msgLabel.Text = Common.ShowAlert("warning", "There was an error saving your changes!  <br /> " & ex.Message().ToString())
        End Try

        'rebing brandslist
        BrandsList.DataBind()


    End Sub

    Private Sub btnCancelUpdateBrand_Click(sender As Object, e As EventArgs) Handles btnCancelUpdateBrand.Click
        Panel1.Visible = True
        EditBrandsPanel.Visible = False

    End Sub

    Private Sub btnRetun_Click(sender As Object, e As EventArgs) Handles btnRetun.Click
        Panel1.Visible = True
        EditBrandsPanel.Visible = False
    End Sub
End Class