Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class NewActivity
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

#Region "Events"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' ViewState("count") = 1
            dateText.Text = String.Format("{0:d}", Date.Now)

            HiddenTempID.Value = Guid.NewGuid().ToString()

            ActivityNameLabel.Text = (From p In db.tblActivityTypes Where p.activityTypeID = Request.QueryString("ActivityTypeID") Select p.activityName).FirstOrDefault

            '  SelectActivityType.SelectedIndex = 1

        End If
    End Sub

    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)
        generateDynamicControls()
    End Sub

    Protected Sub BtnAddActivity_Click1(sender As Object, e As EventArgs)


        Dim ActivityTypeID As Integer = Request.QueryString("ActivityTypeID") ' SelectActivityType.SelectedValue

        Try
            ' add Account Activity
            Dim newActivity As New tblAccountActivity
            newActivity.accountID = Request.QueryString("AccountID")
            newActivity.activityDate = dateText.Text
            newActivity.activityType = getActivityName(ActivityTypeID)
            newActivity.activityTypeID = ActivityTypeID
            newActivity.status = "Complete"

            db.tblAccountActivities.InsertOnSubmit(newActivity)
            db.SubmitChanges()


            'get the fields from the activity type and form
            Dim activity = From p In db.tblActivityFields Where p.activityTypeID = ActivityTypeID Select p Order By p.sortOrder

            For Each p In activity

                'add results
                Dim newActivityResult As New tblAccountActivityResult
                newActivityResult.accountActivityResultsID = Guid.NewGuid.ToString()
                newActivityResult.accountActivityID = newActivity.accountActivityID

                newActivityResult.order = p.sortOrder
                newActivityResult.question = p.fieldName
                newActivityResult.fieldType = p.type
                newActivityResult.fieldID = p.fieldID


                Select Case p.type
                    Case "text"
                        Dim txtbox As TextBox = CType(InsertPlaceHolder.FindControl("text" & p.fieldID & "result"), TextBox)
                        newActivityResult.answer = txtbox.Text


                    Case "multiline"
                        Dim txtbox As TextBox = CType(InsertPlaceHolder.FindControl("text" & p.fieldID & "result"), TextBox)
                        newActivityResult.answer = txtbox.Text
                        newActivityResult.rows = p.rows

                    Case "choice"
                        '  Dim txtbox As DropDownList = CType(InsertPlaceHolder.FindControl("text" & p.fieldID & "result"), DropDownList)
                        ' newActivityResult.answer = txtbox.SelectedValue

                        Try
                            Dim myOptions As String = ""

                            Dim txtbox As RadComboBox = CType(InsertPlaceHolder.FindControl("text" & p.fieldID & "result"), RadComboBox)
                            'loop 

                            'For Each item As ListItem In txtbox.Items
                            '    If item.Selected Then
                            '        myOptions += item.Text + ","
                            '    End If
                            'Next

                            newActivityResult.answer = txtbox.SelectedValue


                        Catch ex As Exception
                            newActivityResult.answer = "error"
                        End Try


                    Case "number"
                        Dim txtbox As RadNumericTextBox = CType(InsertPlaceHolder.FindControl("text" & p.fieldID & "result"), RadNumericTextBox)
                        newActivityResult.answer = txtbox.Text

                'Case "date"
                '    Dim txtbox As RadDatePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadDatePicker)
                '    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)


                'Case "time"
                '    Dim txtbox As RadTimePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadTimePicker)
                '    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)


                    Case "currency"
                        Dim txtbox As RadNumericTextBox = CType(InsertPlaceHolder.FindControl("text" & p.fieldID & "result"), RadNumericTextBox)
                        newActivityResult.answer = txtbox.Text

                    Case "yes/no"

                        Dim txtbox As RadioButtonList = CType(InsertPlaceHolder.FindControl("text" & p.fieldID & "result"), RadioButtonList)
                        newActivityResult.answer = txtbox.SelectedItem.Text



                End Select


                db.tblAccountActivityResults.InsertOnSubmit(newActivityResult)
                db.SubmitChanges()

            Next



            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


            For Each file As UploadedFile In RadAsyncUpload1.UploadedFiles

                Dim bytes(file.ContentLength - 1) As Byte
                file.InputStream.Read(bytes, 0, file.ContentLength)


                Dim i As New tblAccountActivityPhoto
                i.Image = MakeThumb(bytes, 1200)
                i.LargeImage = MakeThumb(bytes, 500) '1
                i.SmallImage = MakeThumb(bytes, 350) '2
                i.ThumbImage = MakeThumb(bytes, 100) '3

                i.photoTitle = ""
                i.dateUploaded = Date.Now()
                i.uploadedBy = currentUser.Id
                i.fileName = file.GetName
                i.activityID = newActivity.accountActivityID

                i.accountID = Request.QueryString("AccountID")
                db.tblAccountActivityPhotos.InsertOnSubmit(i)
                db.SubmitChanges()

            Next




            Response.Redirect("/Accounts/AccountDetails?AccountID=" & Request.QueryString("AccountID") & "#activities")
        Catch ex As Exception
            msgLabel.Text = ex.Message()
        End Try



        '  Dim txt As TextBox = DirectCast(InsertPlaceHolder.FindControl("text2result"), TextBox)
        '  Dim txt2 As TextBox = DirectCast(InsertPlaceHolder.FindControl("text3result"), TextBox)
        ' lblValue.Text = txt.Text & " | " & txt2.Text

    End Sub

    Function getActivityName(id As Integer) As String
        Return (From p In db.tblAccountTypes Where p.accountTypeID = id Select p.accountTypeName).FirstOrDefault
    End Function

    Const sizeThumb As Integer = 100

    Public Shared Function MakeThumb(ByVal fullsize As Byte()) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim targetH, targetW As Integer

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image
        If (iOriginal.Height > iOriginal.Width) Then
            targetH = sizeThumb
            targetW = CInt(iOriginal.Width * (sizeThumb / iOriginal.Height))
        Else
            targetW = sizeThumb
            targetH = CInt(iOriginal.Height * (sizeThumb / iOriginal.Width))
        End If
        iThumb = iOriginal.GetThumbnailImage(targetW, targetH, Nothing, System.IntPtr.Zero)
        Dim m As New IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function


    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal newwidth As Integer, ByVal newheight As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scaleH, scaleW As Double
        Dim srcRect As Drawing.Rectangle


        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image

        scaleH = iOriginal.Height / newheight
        scaleW = iOriginal.Width / newwidth
        If scaleH = scaleW Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = iOriginal.Height
            srcRect.X = 0
            srcRect.Y = 0
        ElseIf (scaleH) > (scaleW) Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = CInt(newheight * scaleW)
            srcRect.X = 0
            srcRect.Y = CInt((iOriginal.Height - srcRect.Height) / 2)
        Else
            srcRect.Width = CInt(newwidth * scaleH)
            srcRect.Height = iOriginal.Height
            srcRect.X = CInt((iOriginal.Width - srcRect.Width) / 2)
            srcRect.Y = 0
        End If

        iThumb = New System.Drawing.Bitmap(newwidth, newheight)
        Dim g As Drawing.Graphics = Drawing.Graphics.FromImage(iThumb)
        g.DrawImage(iOriginal, New Drawing.Rectangle(0, 0, newwidth, newheight), srcRect, Drawing.GraphicsUnit.Pixel)

        Dim m As New IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function

    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal maxwidth As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scale As Double

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))

        If iOriginal.Width > maxwidth Then

            scale = iOriginal.Width / maxwidth
            Dim newheight As Integer = CInt(iOriginal.Height / scale)

            iThumb = New System.Drawing.Bitmap(iOriginal, maxwidth, newheight)
            Dim m As New IO.MemoryStream()
            iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
            Return m.GetBuffer()
        Else
            Return fullsize
        End If
    End Function
#End Region


#Region "Dynamic Methods"
    Public Sub generateDynamicControls()
        ' If SelectActivityType.SelectedIndex > 0 Then

        Dim ActivityTypeID As Integer = Request.QueryString("ActivityTypeID")
        '  ViewState("activitytypeid") = ActivityTypeID

        Dim activity = From p In db.tblActivityFields Where p.activityTypeID = ActivityTypeID Select p Order By p.sortOrder

        For Each p In activity

            Select Case p.type
                Case "text"
                    CreateTextboxControl(p.fieldID, p.fieldName, p.description, p.required, "")

                Case "choice"
                    CreateComboboxControl(p.fieldID, p.fieldName, "", p.description, p.required, p.displayOptions)

                Case "multiline"
                    CreateMultilineTextboxControl(p.fieldID, p.fieldName, p.rows)

                Case "number"
                    CreateNumberboxControl(p.fieldID, p.fieldName, p.numberDefaultValue, p.numberDecimalPlace)

                Case "date"
                    CreateDateControl(p.fieldID, p.fieldName, p.dateDefaultValue)

                Case "time"
                    CreateTimeControl(p.fieldID, p.fieldName, p.timeFormat)

                Case "currency"
                    CreateCurrencyControl(p.fieldID, p.fieldName, p.numberDefaultValue)

                Case "yes/no"
                    CreateYesNoControl(p.fieldID, p.fieldName, p.fieldID, p.description, p.yes_noDefaultValue)

            End Select
        Next

        '   POSPanel.Visible = True
        ' End If
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

        InsertPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateMultilineTextboxControl(id As String, labelText As String, rows As Integer)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        ' Create a text box control
        Dim box As New TextBox
        box.CssClass = "form-control"
        box.TextMode = TextBoxMode.MultiLine
        box.Text = ""
        box.Rows = rows
        box.ID = "text" & id & "result"

        div.Controls.Add(box)

        InsertPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateNumberboxControl(id As String, labelText As String, defaultValue As String, numberDecimalPlaces As Integer)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")
        ' Create a text box control
        Dim box As New RadNumericTextBox
        box.ShowSpinButtons = "true"
        box.NumberFormat.DecimalDigits = numberDecimalPlaces
        box.Width = 100
        box.ID = "text" & id & "result"
        box.Value = defaultValue
        div2.Controls.Add(box)
        div.Controls.Add(div2)

        InsertPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateDateControl(id As String, labelText As String, dateValue As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")

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


        ' box.DbSelectedDate = ""


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



    Private Sub CreateComboboxControl(id As String, labelText As String, answer As String, description As String, required As Boolean, displayOption As String)

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
                ' ddl.CssClass = "form-control combobox"
                ddl.ID = "text" & id & "result"
                ddl.Width = 200
                ddl.Items.Add(New RadComboBoxItem("-- Select --", ""))

                Dim q = From a In db.tblActivityOptions Where a.fieldID = id Select a Order By a.order
                For Each a In q
                    ddl.Items.Add(New RadComboBoxItem(a.optionName, a.optionValue))
                Next

                ddl.SelectedValue = answer

                div.Controls.Add(ddl)

            Case "check"
                Dim clb As New CheckBoxList
                clb.ID = "text" & id & "result"

                Dim q = From a In db.tblActivityOptions Where a.fieldID = id Select a Order By a.order
                For Each a In q
                    ' clb.Items.Add(New ListItem(a.option, a.option))

                    Dim selectedItem As New ListItem(a.optionName, a.optionName)
                    ' selectedItem.Selected = getanswer(answer, a.option)
                    clb.Items.Add(selectedItem)

                Next

            Case "radio"

                Dim clb As New RadioButtonList
                'clb.CssClass = "form-control combobox"
                ' clb.Width = 200
                clb.ID = "text" & id & "result"
                ' ddl.Items.Add(New RadComboBoxItem("-- Select --", ""))

                Dim q = From a In db.tblActivityOptions Where a.fieldID = id Select a Order By a.order
                For Each a In q
                    clb.Items.Add(New ListItem(a.optionName, a.optionValue))
                Next

                clb.SelectedIndex = answer

                '  clb.SelectedValue = answer

                div.Controls.Add(clb)

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

        InsertPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub btnInsertItem_Click(sender As Object, e As EventArgs) Handles btnInsertItem.Click

        Dim newPOSDistribution As New tempAccountPosDistribution

        Dim Price = (From p In db.GetInventoryItemsbySupplier(SupplierComboBox.SelectedValue) Where p.itemID = PosItemComboBox.SelectedValue Select p.retailPrice).FirstOrDefault
        Dim Qty = Convert.ToInt32(qtyTextBox.Text)


        newPOSDistribution.tempID = HiddenTempID.Value
        newPOSDistribution.accountActivityID = Request.QueryString("ActivityTypeID")
        newPOSDistribution.itemName = (From p In db.GetInventoryItemsbySupplier(SupplierComboBox.SelectedValue) Where p.itemID = PosItemComboBox.SelectedValue Select p.FullName).FirstOrDefault
        newPOSDistribution.posItemID = PosItemComboBox.SelectedValue
        newPOSDistribution.retailPrice = (From p In db.GetInventoryItemsbySupplier(SupplierComboBox.SelectedValue) Where p.itemID = PosItemComboBox.SelectedValue Select p.retailPrice).FirstOrDefault
        newPOSDistribution.qty = qtyTextBox.Text
        newPOSDistribution.units = (From p In db.GetInventoryItemsbySupplier(SupplierComboBox.SelectedValue) Where p.itemID = PosItemComboBox.SelectedValue Select p.unitsInKit).FirstOrDefault
        newPOSDistribution.package = (From p In db.GetInventoryItemsbySupplier(SupplierComboBox.SelectedValue) Where p.itemID = PosItemComboBox.SelectedValue Select p.packageSize).FirstOrDefault

        newPOSDistribution.total = Price * Qty


        db.tempAccountPosDistributions.InsertOnSubmit(newPOSDistribution)
        db.SubmitChanges()


        'clear form
        SupplierComboBox.ClearSelection()
        SupplierComboBox.DataBind()
        PosItemComboBox.ClearSelection()
        PosItemComboBox.DataBind()
        qtyTextBox.Text = 0

        BrandEventTaskList.DataBind()

    End Sub





    'Private Sub SelectActivityType_SelectedIndexChanged(sender As Object, e As EventArgs) Handles SelectActivityType.SelectedIndexChanged

    '    Dim ActivityTypeID As Integer = SelectActivityType.SelectedValue
    '    ViewState("activitytypeid") = ActivityTypeID

    '    Dim activity = From p In db.tblActivityFields Where p.activityTypeID = ActivityTypeID Select p Order By p.sortOrder

    '    For Each p In activity

    '        Select Case p.type
    '            Case "text"
    '                CreateTextboxControl(p.fieldID, p.fieldName)

    '            Case "choice"
    '                CreateComboboxControl(p.fieldID, p.fieldName)

    '            Case "multiline"
    '                CreateMultilineTextboxControl(p.fieldID, p.fieldName, p.rows)

    '            Case "number"
    '                CreateNumberboxControl(p.fieldID, p.fieldName, p.numberDefaultValue, p.numberDecimalPlace)

    '            Case "date"
    '                CreateDateControl(p.fieldID, p.fieldName, p.dateDefaultValue)

    '            Case "time"
    '                CreateTimeControl(p.fieldID, p.fieldName, p.timeFormat)

    '            Case "currency"
    '                CreateCurrencyControl(p.fieldID, p.fieldName, p.numberDefaultValue)

    '            Case "yes/no"
    '                CreateYesNoControl(p.fieldID, p.fieldName, p.yes_noDefaultValue)

    '        End Select
    '    Next

    '    'POSPanel.Visible = True
    'End Sub

#End Region


End Class