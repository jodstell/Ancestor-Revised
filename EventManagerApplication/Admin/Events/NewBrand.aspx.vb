Imports System.IO
Imports CuteWebUI
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class NewBrand
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            tempGUID.Text = System.Guid.NewGuid().ToString()
        End If
    End Sub

    Function getEventTypeTitle(ByVal eventtypeid As Integer) As String

        Return (From p In db.tblEventTypes Where p.eventTypeID = eventtypeid Select p.eventTypeName).FirstOrDefault
    End Function

    Private Sub getBrandExecutionList_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getBrandExecutionList.Inserting

        Dim l As tempBrandEventExecution
        l = CType(e.NewObject, tempBrandEventExecution)
        l.tempBrandID = tempGUID.Text


    End Sub

    'Private Sub ddlCategory_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCategory.SelectedIndexChanged
    '    ddlCategoryType.SelectedIndex = -1
    '    ddlCategorySubType.SelectedIndex = -1
    'End Sub

    'Private Sub ddlCategoryType_SelectedIndexChanged(sender As Object, e As DropDownListEventArgs) Handles ddlCategoryType.SelectedIndexChanged
    ''    ddlCategorySubType.SelectedIndex = -1
    ''End Sub

    Private Sub NewBrandWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles NewBrandWizard.CancelButtonClick
        ' add delete scripts for temp tables

        'Response.Redirect("/admin/ClientDetails?Action=0&ClientID=" & Common.GetCurrentClientID() & "#eventtab/brands")
        Response.Redirect("/admin/events/editsupplier?ClientID=" & Request.QueryString("ClientID") & "&SupplierID=" & Request.QueryString("SupplierID") & "&Tab=Brands")

        '/admin/events/editsupplier?ClientID=18&SupplierID=232
    End Sub

    Private Sub NewBrandWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles NewBrandWizard.FinishButtonClick
        Try
            'save the form

            Dim newBrand As New tblBrand
            newBrand.brandName = BrandNameTextBox.Text
            newBrand.active = ActiveTextBox.SelectedValue
            newBrand.brandStartDate = StartDateDatePicker.SelectedDate
            newBrand.brandEndDate = EndDateDatePicker.SelectedDate
            newBrand.brandDataEndDate = DataViewEndDateDatePicker.SelectedDate
            newBrand.modifiedBy = Context.User.Identity.GetUserId()
            newBrand.modifiedDate = Date.Now()

            Try
                'newBrand.categoryID = ddlCategory.SelectedValue
            Catch ex As Exception

            End Try


            Try
                ' newBrand.brandGroupID = BrandGroupList.SelectedValue
            Catch ex As Exception

            End Try


            Try
                ' newBrand.typeID = ddlCategoryType.SelectedValue
            Catch ex As Exception

            End Try

            Try
                ' newBrand.varietyID = ddlCategorySubType.SelectedValue
            Catch ex As Exception

            End Try

            ' newBrand.abv = ABVRadNumericTextBox.Text

            Try
                ' newBrand.avaeragePrice = AveragePriceRadNumericTextBox.Text
            Catch ex As Exception

            End Try

            'newBrand.countryOrigin = ddlCountry.SelectedValue
            'newBrand.packageSize = ddlPackageSize.SelectedValue
            'newBrand.clientID = Common.GetCurrentClientID()

            'newBrand.courseID = CourseList.SelectedValue
            'newBrand.courseGroupID = CurriculumList.SelectedValue

            db.tblBrands.InsertOnSubmit(newBrand)
            db.SubmitChanges()


            'add event execution
            db.InsertBrandEventExecution(tempGUID.Text, newBrand.brandID)

            'add assoiciated suppliers
            db.InsertSupplierBrandFromTempTable(tempGUID.Text, newBrand.brandID)

            'add staffing
            db.InsertBrandStaffingPosition(tempGUID.Text, newBrand.brandID)

            'add tasks
            db.InsertBrandEventTask(tempGUID.Text, newBrand.brandID)

            'add recap questions
            db.InsertBrandRecapQuestion(tempGUID.Text, newBrand.brandID)

            'add photo

            Dim newBrandImage As New tblBrandImage

            newBrandImage.brandID = newBrand.brandID

            'For Each file As UploadedFile In RadAsyncUpload1.UploadedFiles
            '    Dim bytes(file.ContentLength - 1) As Byte
            '    file.InputStream.Read(bytes, 0, file.ContentLength)

            '    newBrandImage.photo = bytes
            'Next


            'upload the photo
            'If lblPath.Text = "" Then

            'Else

            '    Dim filePath As String = Server.MapPath(lblPath.Text)

            '    Dim filename As String = Path.GetFileName(filePath)


            '    Dim fs As FileStream = New FileStream(filePath, FileMode.Open, FileAccess.Read)

            '    Dim br As BinaryReader = New BinaryReader(fs)

            '    Dim bytes As Byte() = br.ReadBytes(Convert.ToInt32(fs.Length))

            '    newBrandImage.photo = bytes


            '    br.Close()

            '    fs.Close()

            'End If


            'db.tblBrandImages.InsertOnSubmit(newBrandImage)
            'db.SubmitChanges()



            'delete the photo
            'Try
            '    Dim filePath2 As String = Server.MapPath(lblPath.Text)
            '    System.IO.File.Delete(filePath2)
            'Catch ex As Exception
            '    'do nothing
            'End Try


            Response.Redirect("/admin/ClientDetails?Action=2&ClientID=" & Common.GetCurrentClientID() & "#eventtab/brands")


        Catch ex As Exception
            msgLabel.Text = ex.Message()
        End Try



    End Sub


    'Protected Sub UploadAttachments1_Photo(ByVal sender As Object, ByVal args As UploaderEventArgs)

    '    Try

    '        If lblPath.Text = "" Then

    '            'Get the full path of file that will be saved.
    '            Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
    '            lblPath.Text = virpath


    '            'Map the path to to a physical path.
    '            Dim savepath As String = Server.MapPath(virpath)

    '            'Do not overwrite an existing file
    '            If System.IO.File.Exists(savepath) Then
    '                Return
    '            End If

    '            'Move the uploaded file to the target location
    '            args.MoveTo(savepath)


    '            'Get the data of uploaded file		
    '            'Dim link As New HyperLink()
    '            'link.Text = Convert.ToString("Open " + args.FileName + " : ") & virpath
    '            'link.NavigateUrl = virpath
    '            'link.Target = "_blank"
    '            'link.Style(HtmlTextWriterStyle.Display) = "block"

    '            'PhotoList.Visible = False
    '            PhotoPanel.Visible = True
    '            'lblInfoPhoto.Visible = True
    '            Image1.ImageUrl = virpath
    '            Image1.DataBind()

    '        Else

    '            'delete the photo
    '            Try
    '                Dim filePath2 As String = Server.MapPath(lblPath.Text)
    '                System.IO.File.Delete(filePath2)
    '                lblPath.Text = ""
    '            Catch ex As Exception
    '                'do nothing
    '            End Try


    '            'Get the full path of file that will be saved.
    '            Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
    '            lblPath.Text = virpath


    '            'Map the path to to a physical path.
    '            Dim savepath As String = Server.MapPath(virpath)

    '            'Do not overwrite an existing file
    '            If System.IO.File.Exists(savepath) Then
    '                Return
    '            End If

    '            'Move the uploaded file to the target location
    '            args.MoveTo(savepath)


    '            'Get the data of uploaded file		
    '            'Dim link As New HyperLink()
    '            'link.Text = Convert.ToString("Open " + args.FileName + " : ") & virpath
    '            'link.NavigateUrl = virpath
    '            'link.Target = "_blank"
    '            'link.Style(HtmlTextWriterStyle.Display) = "block"

    '            'PhotoList.Visible = False
    '            PhotoPanel.Visible = True
    '            'lblInfoPhoto.Visible = True
    '            Image1.ImageUrl = virpath
    '            Image1.DataBind()

    '        End If


    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message()
    '    End Try


    'End Sub


    Function getPositionName(ByVal positionID As Integer) As String
        Return (From p In db.tblStaffingPositions Where p.staffingPositionID = positionID Select p.positionTitle).FirstOrDefault
    End Function

    Function formatTimeOffset(ByVal t As String) As String

        Select Case t
            Case "0"
                Return "0 minutes"
            Case "-120"
                Return "120 minutes prior"
            Case "-90"
                Return "90 minutes prior"
            Case "-60"
                Return "60 minutes prior"
            Case "-45"
                Return "45 minutes prior"
            Case "-30"
                Return "30 minutes prior"
            Case "-15"
                Return "15 minutes prior"
            Case "15"
                Return "15 minutes after"
            Case "30"
                Return "30 minutes after"
            Case "45"
                Return "45 minutes after"
            Case "60"
                Return "60 minutes after"
            Case "90"
                Return "90 minutes after"
            Case "120"
                Return "120 minutes after"
            Case Else
                Return ""
        End Select

    End Function

    'Private Sub getStaffingPositions_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getStaffingPositions.Inserting

    '    Dim position As tempBrandStaffingPosition
    '    position = CType(e.NewObject, tempBrandStaffingPosition)
    '    position.tempBrandID = tempGUID.Text

    'End Sub

    Private Sub getBrandEventTasks_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getBrandEventTasks.Inserting

        Dim task As tempBrandEventTask
        task = CType(e.NewObject, tempBrandEventTask)
        task.tempBrandID = tempGUID.Text

    End Sub

    Private Sub BrandRecapList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles BrandRecapList.ItemCommand

        'If e.CommandName = "EditRecapQuestion" Then
        '    RecapListPanel.Visible = False

        '    Dim t As String = e.CommandArgument
        '    BindForm(t)

        '    NewRecapQuestionPanel.Visible = True

        '    btnInsertQuestion.Visible = False
        '    btnUpdateQuestion.Visible = True
        'End If


        If e.CommandName = "AddQuestion" Then
            RecapListPanel.Visible = False
            NewRecapQuestionPanel.Visible = True

            showPanel("text")
            clearForm()

        End If
    End Sub

    Private Sub columnTypeList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles columnTypeList.SelectedIndexChanged
        Dim i = columnTypeList.SelectedValue
        showPanel(i)
    End Sub

    Sub clearForm()
        ColumnNameTextBox.Text = ""
        RequiredFieldTextBox.SelectedValue = "False"
        columnTypeList.SelectedValue = "text"

    End Sub

    Private Sub btnInsertQuestion_Click(sender As Object, e As EventArgs) Handles btnInsertQuestion.Click

        Dim order As Integer = 0
        Dim sort_order = (From p In db.tempBrandRecapQuestions Where p.tempBrandID = tempGUID.Text Select p).Count

        Try
            Dim recap As New tempBrandRecapQuestion
            recap.tempBrandID = tempGUID.Text
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
            recap.sortOrder = sort_order + 1
            recap.required = RequiredFieldTextBox.SelectedValue
            recap.digit = txtDecimalPlace.Text

            db.tempBrandRecapQuestions.InsertOnSubmit(recap)
            db.SubmitChanges()

            order = 0
            Dim getLine As [String] = ""

            Dim mylines As String() = txtChioces.Text.Split(vbLf)
            For i As Integer = 0 To mylines.Length - 1
                getLine = mylines(i).ToString()

                Dim o As New tempRecapQuestionOption
                o.brandRecapQuestionID = recap.tempBrandRecapQuestionID
                o.option = getLine
                o.optionType = DisplayOptions.SelectedValue
                o.sortOrder = i

                db.tempRecapQuestionOptions.InsertOnSubmit(o)
                db.SubmitChanges()

            Next

        Catch ex As Exception
            msg.Text = ex.Message
        End Try

        RecapListPanel.Visible = True
        NewRecapQuestionPanel.Visible = False

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

    Private Sub btnCancelNewQuestion_Click(sender As Object, e As EventArgs) Handles btnCancelNewQuestion.Click

        RecapListPanel.Visible = True
        NewRecapQuestionPanel.Visible = False

        clearForm()

        BrandRecapList.DataBind()

    End Sub

    'Private Sub SelectedSuppliers_Inserted(sender As Object, e As RadListBoxEventArgs) Handles SelectedSuppliers.Inserted

    '    Try
    '        'get the brandID
    '        LogEvent(sender, "Inserted", e.Items)

    '        Dim brandID As String = tempGUID.Text
    '        Dim selectedValue As Integer = HF_SelectedItemID.Value

    '        'insert the item
    '        db.InsertTempSupplierBrand(selectedValue, brandID)
    '        db.SubmitChanges()

    '        msgLabel.Text = ""

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try

    'End Sub

    'Private Sub LogEvent(ByVal sender As Object, ByVal eventName As String, ByVal items As IEnumerable(Of RadListBoxItem))

    '    Dim affectedItems As New List(Of String)()

    '    For Each item As RadListBoxItem In items
    '        affectedItems.Add(item.Value)
    '    Next

    '    Dim message As String = String.Format("{0}", affectedItems.ToArray())
    '    HF_SelectedItemID.Value = message

    'End Sub

    'Private Sub SelectedSuppliers_Deleted(sender As Object, e As RadListBoxEventArgs) Handles SelectedSuppliers.Deleted

    '    Try
    '        'get the supplierID
    '        LogEvent(sender, "Deleted", e.Items)

    '        Dim brandID As String = tempGUID.Text
    '        Dim selectedValue As Integer = HF_SelectedItemID.Value

    '        'delete the item
    '        db.DeleteTempSupplierBrand(selectedValue, brandID)
    '        db.SubmitChanges()


    '        msgLabel.Text = ""

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try

    'End Sub

    'Protected Sub btnAddBrandGroup_Click(sender As Object, e As EventArgs)

    '    Dim txt As TextBox = DirectCast(BrandGroupList.Footer.FindControl("NewBrandGroupTextBox"), TextBox)

    '    If (Not [String].IsNullOrEmpty(txt.Text)) AndAlso (BrandGroupList.FindItemByText(txt.Text) Is Nothing) Then

    '        Dim newGroup As New tblBrandGroup With {.brandGroupName = txt.Text}
    '        db.tblBrandGroups.InsertOnSubmit(newGroup)
    '        db.SubmitChanges()

    '        'HiddenBrandGroupID.Value = 

    '        'BrandGroupList.Items.Insert(0, New RadComboBoxItem(txt.Text))
    '        'BrandGroupList.SelectedIndex = 0
    '        'txt.Text = [String].Empty

    '        BrandGroupList.DataBind()
    '        BrandGroupList.SelectedValue = newGroup.brandGroupID

    '    End If


    'End Sub
End Class