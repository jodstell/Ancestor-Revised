Imports Telerik.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.IO
Imports CuteWebUI
Imports System.Data.SqlClient
Imports System.Drawing

Public Class EventRecap
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext

    Dim eventID As Integer
    Dim eventTypeID As Integer
    Dim count As Integer

    Const MaxTotalBytes As Integer = 1048576
    ' 1 MB
    Private totalBytes As Long


    Protected Function CreateRecapReceiptScript(ByVal eventExpenseID As Integer) As String
        Return String.Format("var win = window.radopen('/Receipt_Image.aspx?eventExpenseID={0}','Details');win.center();", eventExpenseID)
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        '  RadAsyncUpload1.PostbackTriggers = New String() {"btnUpload", "btnCancelUpload"}

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


        eventID = Request.QueryString("EventID")
        eventTypeID = (From p In db.tblEvents Where p.eventID = eventID Select p.eventTypeID).FirstOrDefault

        EventNameLabel.Text = (From p In db.tblEvents Where p.eventID = eventID Select p.eventTitle).FirstOrDefault
        EventDateLabel.Text = String.Format("{0:D}", (From p In db.tblEvents Where p.eventID = eventID Select p.eventDate).FirstOrDefault)
        EventIDLabel.Text = eventID

        Dim username As String = currentUser.UserName.ToString()

        Hidden_EventRequirementStaffingID.Value = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("EventID") And p.assignedUserName = username Select p.RequirementID).FirstOrDefault

        If Not Page.IsPostBack Then
            AddNewExpensePanel.Visible = False

        End If


        Dim photo = (From p In db.tblPhotos Where p.eventID = Request.QueryString("EventID") Select p)
        If photo.Count = 0 Then
            MissingPhotoPanel.Visible = True
        Else
            MissingPhotoPanel.Visible = False
        End If




    End Sub

    Public Sub RadAsyncUpload1_FileUploaded(sender As Object, e As FileUploadedEventArgs)
        ' BtnSubmit.Visible = False
        ' RefreshButton.Visible = True
        'RadAsyncUpload1.Visible = False

        Dim liItem = New HtmlGenericControl("li")
        liItem.InnerText = e.File.FileName


        If totalBytes < MaxTotalBytes Then
            ' Total bytes limit has not been reached, accept the file
            e.IsValid = True
            totalBytes += e.File.ContentLength
        Else
            ' Limit reached, discard the file
            e.IsValid = False
        End If

        If e.IsValid Then

            'ValidFiles.Visible = True

            ValidFilesList.Controls.AddAt(0, liItem)
        Else

            InvalidFiles.Visible = True
            InValidFilesList.Controls.AddAt(0, liItem)
        End If
    End Sub

    Function getAccountDetails() As String

        Dim i = (From p In db.qryViewEvents Where p.eventID = Request.QueryString("EventID") Select p)

        For Each p In i
            Return String.Format("{0}, {1}, {2}", p.accountName, p.city, p.state)
        Next


#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths

    Function getAccountID() As String

        Return (From p In db.qryViewEvents Where p.eventID = Request.QueryString("EventID") Select p.accountID).FirstOrDefault

    End Function

    Function getMarketID() As String

        Return (From p In db.qryViewEvents Where p.eventID = Request.QueryString("EventID") Select p.marketID).FirstOrDefault

    End Function


    Protected Property ImageWidth() As Unit

        Get
            Dim state As Object = If(ViewState("ImageWidth"), Unit.Pixel(200))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageWidth") = value
        End Set

    End Property

    Protected Property ImageHeight() As Unit
        Get
            Dim state As Object = If(ViewState("ImageHeight"), Unit.Pixel(200))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageHeight") = value
        End Set

    End Property

    Protected Function CreateWindowScript(ByVal eventID As Integer, ByVal photoID As Integer) As String
        Return String.Format("var win = window.radopen('/PhotoGallery.aspx?ID={0}&PhotoID={1}','Details');win.center();", eventID, photoID)
    End Function

    Function getExpenseType(id As Integer) As String
        Return (From p In db.tblExpenseTypes Where p.expenseTypeID = id Select p.expenseTypeTitle).FirstOrDefault
    End Function

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

        ' 1. loop through the brands first

        Dim brand = From b In db.tblBrandInEvents Where b.eventID = eventID
        For Each b In brand

            'create a header label
            CreateLabelControl("", getBrandName(b.brandID) & " Brand Recap")

            'add the controls for each of the brands

            Dim recap = From p In db.tblEventRecapQuestions Where p.eventID = eventID And p.brandID = b.brandID Select p Order By p.eventRecapQuestionID

            For Each p In recap

                If p.required Is Nothing Then p.required = False

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
                    'get the choices


                    Case "multiline"
                        'get the number of lines
                        Dim linecount = (From l In db.tblBrandRecapQuestions Where l.brandRecapQuestionID = l.brandRecapQuestionID Select l.lines).FirstOrDefault

                        CreateMultilineTextboxControl(p.eventRecapQuestionID, p.question, p.lines, p.answer, p.description, p.required)

                    Case "number"

                        CreateNumberboxControl(p.eventRecapQuestionID, p.question, p.answer, p.description, p.required, p.digit)

                    Case "date"

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

        ' 2. get the EventType Questions

        'create a header label
        CreateLabelControl("", getEventTypeName(eventTypeID) & " Event Recap")


        Dim recap2 = From p In db.tblEventRecapQuestions Where p.eventID = eventID And p.brandID Is Nothing Select p Order By p.sortorder

        For Each p In recap2

            If p.required Is Nothing Then p.required = False

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

                    CreateMultilineTextboxControl(p.eventRecapQuestionID, p.question, p.lines, p.answer, p.description, p.required)

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
        Try
            box.Rows = rows
        Catch ex As Exception

        End Try

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
            Return ""
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

    Private Sub EventExpenseList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles EventExpenseList.ItemCommand
        If e.CommandName = "AddNewExpense" Then

            'ReceiptUploadAttachments.InsertButton.Enabled = True
            'ReceiptUploadAttachments.DeleteAllAttachments()

            AddNewExpensePanel.Visible = True
            RecapWizard.Visible = False
        End If
    End Sub


    Protected Sub UploadAttachments1_Photo(ByVal sender As Object, ByVal args As UploaderEventArgs)

        Try

            If lblPath.Text = "" Then
                'Get the full path of file that will be saved.
                Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
                lblPath.Text = virpath

                'Map the path to to a physical path.
                Dim savepath As String = Server.MapPath(virpath)

                'Do not overwrite an existing file
                If System.IO.File.Exists(savepath) Then
                    Return
                End If

                'Move the uploaded file to the target location
                args.MoveTo(savepath)

                PhotoPanel.Visible = True
                Image1.ImageUrl = virpath
                Image1.DataBind()

            Else

                Try
                    Dim filePath2 As String = Server.MapPath(lblPath.Text)
                    System.IO.File.Delete(filePath2)
                    lblPath.Text = ""
                Catch ex As Exception
                    'do nothing
                End Try

                'Get the full path of file that will be saved.
                Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
                lblPath.Text = virpath

                'Map the path to to a physical path.
                Dim savepath As String = Server.MapPath(virpath)

                'Do not overwrite an existing file
                If System.IO.File.Exists(savepath) Then
                    Return
                End If

                'Move the uploaded file to the target location
                args.MoveTo(savepath)

                PhotoPanel.Visible = True
                Image1.ImageUrl = virpath
                Image1.DataBind()


            End If

        Catch ex As Exception
            msgLabel.Text = Common.ShowAlertNoClose("warning", ex.Message())
        End Try

    End Sub


    Private Sub btnSaveExpense_Click(sender As Object, e As EventArgs) Handles btnSaveExpense.Click

        Try

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            Dim expense As New tblEventExpense
            expense.eventStaffingRequirementID = Hidden_EventRequirementStaffingID.Value
            expense.expenseTypeID = ddlExpenseType.SelectedValue
            expense.description = descriptionTextBox.Text
            expense.amount = amountTextBox.Text
            expense.submittedDate = Date.Now()
            expense.submittedBy = currentUser.Id


            'upload the receipt
            If lblPath.Text = "" Then

            Else

                Dim filePath As String = Server.MapPath(lblPath.Text)

                Dim filename As String = Path.GetFileName(filePath)


                Dim fs As FileStream = New FileStream(filePath, FileMode.Open, FileAccess.Read)

                Dim br As BinaryReader = New BinaryReader(fs)

                Dim bytes As Byte() = br.ReadBytes(Convert.ToInt32(fs.Length))

                expense.receipt = (bytes)

                br.Close()

                fs.Close()

            End If




            db.tblEventExpenses.InsertOnSubmit(expense)
            db.SubmitChanges()

            Try
                'add to history log
                lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Expense Added", "An expense has been added to an event", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)
            Catch ex1 As Exception
                ' do nothing
            End Try


            EventExpenseList.DataBind()

            'clear the form
            ddlExpenseType.SelectedIndex = 0
            descriptionTextBox.Text = ""
            amountTextBox.Text = ""

            'delete the photo from the temp folder
            Try
                Dim filePath2 As String = Server.MapPath(lblPath.Text)
                System.IO.File.Delete(filePath2)
                lblPath.Text = ""

            Catch ex As Exception
                'do nothing
            End Try

            AddNewExpensePanel.Visible = False
            RecapWizard.Visible = True
            PhotoPanel.Visible = False

        Catch ex As Exception

            ErrorLabel1.Text = Common.ShowAlertNoClose("danger", "There was a problem saving your expense.  Please try again.")

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Error adding Expense", ex.Message, Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)


            EventExpenseList.DataBind()

            'clear the form
            ddlExpenseType.SelectedIndex = 0
            descriptionTextBox.Text = ""
            amountTextBox.Text = ""

            AddNewExpensePanel.Visible = False
            RecapWizard.Visible = True

        End Try

    End Sub

    Private Sub btnCancelExpense_Click(sender As Object, e As EventArgs) Handles btnCancelExpense.Click

        'clear the form
        ddlExpenseType.SelectedIndex = 0
        descriptionTextBox.Text = ""
        amountTextBox.Text = ""

        Try
            Dim filePath2 As String = Server.MapPath(lblPath.Text)
            System.IO.File.Delete(filePath2)
            lblPath.Text = ""
        Catch ex As Exception
            'do nothing
        End Try

        'ReceiptUploadAttachments.DeleteAllAttachments()

        'ReceiptUploadAttachments.InsertButton.Enabled = True

        AddNewExpensePanel.Visible = False
        RecapWizard.Visible = True
        PhotoPanel.Visible = False

    End Sub

    'Private Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click

    '    Dim manager = New UserManager()
    '    Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '    Dim eventID = Request.QueryString("EventID")

    '    Try

    '        For Each file As UploadedFile In RadAsyncUpload1.UploadedFiles

    '            Dim bytes(file.ContentLength - 1) As Byte
    '            file.InputStream.Read(bytes, 0, file.ContentLength)


    '            Dim i As New tblPhoto
    '            i.Image = MakeThumb(bytes, 1200)
    '            i.LargeImage = MakeThumb(bytes, 500) '1
    '            i.SmallImage = MakeThumb(bytes, 350) '2
    '            i.ThumbImage = MakeThumb(bytes, 100) '3

    '            i.eventID = eventID
    '            i.photoTitle = getAccountDetails()
    '            i.dateUploaded = Date.Now()
    '            i.accountID = getAccountID()
    '            i.marketID = getMarketID()
    '            i.uploadedBy = currentUser.Id
    '            i.fileName = file.GetName
    '            db.tblPhotos.InsertOnSubmit(i)
    '            db.SubmitChanges()

    '            Dim brands = (From p In db.tblBrandInEvents Where p.eventID = eventID Select p)
    '            For Each p In brands

    '                Dim newBrandPhoto As New tblBrandPhoto With {.photoID = i.photoID, .brandID = p.brandID}
    '                db.tblBrandPhotos.InsertOnSubmit(newBrandPhoto)
    '                db.SubmitChanges()
    '            Next

    '        Next

    '    Catch ex As Exception
    '        ErrorPanel.Visible = True

    '        PhotoListView.DataBind()

    '        UploadPanel.Visible = False
    '        ViewPanel.Visible = True
    '        ButtonPanel.Visible = True

    '        Dim photo2 = (From p In db.tblPhotos Where p.eventID = Request.QueryString("EventID") Select p)
    '        If photo2.Count = 0 Then
    '            MissingPhotoPanel.Visible = True
    '        Else
    '            MissingPhotoPanel.Visible = False
    '        End If

    '        RecapWizard.DisplayNavigationButtons = True
    '    End Try




    '    Try
    '        Dim insertlog = db.InsertEventLog(Request.QueryString("EventID"), "Photo(s) uploaded", "Photos have been uploaded to the events gallery", Context.User.Identity.GetUserId(), Date.Now())

    '        'add to history log
    '        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Photo(s) uploaded", "Photos have been uploaded to the events gallery", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message.ToString()
    '    End Try


    '    PhotoListView.DataBind()

    '    UploadPanel.Visible = False
    '    ViewPanel.Visible = True
    '    ButtonPanel.Visible = True

    '    Dim photo = (From p In db.tblPhotos Where p.eventID = Request.QueryString("EventID") Select p)
    '    If photo.Count = 0 Then
    '        MissingPhotoPanel.Visible = True
    '    Else
    '        MissingPhotoPanel.Visible = False
    '    End If

    '    RecapWizard.DisplayNavigationButtons = True
    'End Sub

    Protected Sub UploadAttachments1_FileUploaded(ByVal sender As Object, ByVal args As UploaderEventArgs)

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        Dim eventID = Request.QueryString("EventID")

        Try

            ' Read the file and convert it to Byte Array
            Dim data() As Byte = New Byte((args.FileSize) - 1) {}

            'get file extension
            Dim extensioin As String = args.FileName.Substring((args.FileName.LastIndexOf(".") + 1))
            Dim fileType As String = ""

            'set the file type based on File Extension
            Select Case (extensioin)
                Case "doc"
                    fileType = "application/vnd.ms-word"
                Case "docx"
                    fileType = "application/vnd.ms-word"
                Case "xls"
                    fileType = "application/vnd.ms-excel"
                Case "xlsx"
                    fileType = "application/vnd.ms-excel"
                Case "jpg"
                    fileType = "image/jpg"
                Case "png"
                    fileType = "image/png"
                Case "gif"
                    fileType = "image/gif"
                Case "pdf"
                    fileType = "application/pdf"
            End Select

            Dim stream As Stream = args.OpenStream

            'read the file as stream
            stream.Read(data, 0, data.Length)

            ' Dim bytes(file.ContentLength - 1) As Byte
            ' File.InputStream.Read(bytes, 0, file.ContentLength)


            Dim i As New tblPhoto
            i.Image = MakeThumb(data, 1200)
            i.LargeImage = MakeThumb(data, 500) '1
            i.SmallImage = MakeThumb(data, 350) '2
            i.ThumbImage = MakeThumb(data, 100) '3

            i.tag = Request.UserAgent.ToString().ToLower()
            i.keywords = "Case 0, Not Rotated"

            i.eventID = eventID
            i.photoTitle = getAccountDetails()
            i.dateUploaded = Date.Now()
            i.accountID = getAccountID()
            i.marketID = getMarketID()
            i.uploadedBy = currentUser.Id
            i.fileName = args.FileName


            Dim ms As New MemoryStream(data)
            Dim originalImage As System.Drawing.Image = System.Drawing.Image.FromStream(ms)


            If originalImage.PropertyIdList.Contains(&H112) Then
                Dim rotationValue As Integer = originalImage.GetPropertyItem(&H112).Value(0)
                Select Case rotationValue
                    Case 1
                        'landscape, do nothing
                        i.Image = MakeThumb(data, 1200)
                        i.LargeImage = MakeThumb(data, 500) '1
                        i.SmallImage = MakeThumb(data, 350) '2
                        i.ThumbImage = MakeThumb(data, 100) '3

                        i.tag = Request.UserAgent.ToString().ToLower()
                        i.keywords = "Case 1, Not Rotated"

                        Exit Select

                    Case 2
                        originalImage.RotateFlip(RotateFlipType.RotateNoneFlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        i.Image = MakeThumb(m.GetBuffer(), 1200)
                        i.LargeImage = MakeThumb(m.GetBuffer(), 500) '1
                        i.SmallImage = MakeThumb(m.GetBuffer(), 350) '2
                        i.ThumbImage = MakeThumb(m.GetBuffer(), 100) '3

                        i.tag = Request.UserAgent.ToString().ToLower()
                        i.keywords = "Case 2, Rotated"

                        Exit Select

                    Case 3
                        ' bottoms up
                        originalImage.RotateFlip(RotateFlipType.Rotate180FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        i.Image = MakeThumb(m.GetBuffer(), 1200)
                        i.LargeImage = MakeThumb(m.GetBuffer(), 500) '1
                        i.SmallImage = MakeThumb(m.GetBuffer(), 350) '2
                        i.ThumbImage = MakeThumb(m.GetBuffer(), 100) '3

                        i.tag = Request.UserAgent.ToString().ToLower()
                        i.keywords = "Case 3, Rotated"

                        Exit Select

                    Case 4
                        originalImage.RotateFlip(RotateFlipType.Rotate180FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        i.Image = MakeThumb(m.GetBuffer(), 1200)
                        i.LargeImage = MakeThumb(m.GetBuffer(), 500) '1
                        i.SmallImage = MakeThumb(m.GetBuffer(), 350) '2
                        i.ThumbImage = MakeThumb(m.GetBuffer(), 100) '3

                        i.tag = Request.UserAgent.ToString().ToLower()
                        i.keywords = "Case 4, Rotated"

                        Exit Select

                    Case 5
                        originalImage.RotateFlip(RotateFlipType.Rotate90FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        i.Image = MakeThumb(m.GetBuffer(), 1200)
                        i.LargeImage = MakeThumb(m.GetBuffer(), 500) '1
                        i.SmallImage = MakeThumb(m.GetBuffer(), 350) '2
                        i.ThumbImage = MakeThumb(m.GetBuffer(), 100) '3

                        i.tag = Request.UserAgent.ToString().ToLower()
                        i.keywords = "Case 5, Rotated"

                        Exit Select

                    Case 6
                        ' rotated 90 left
                        originalImage.RotateFlip(RotateFlipType.Rotate90FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        i.Image = MakeThumb(m.GetBuffer(), 1200)
                        i.LargeImage = MakeThumb(m.GetBuffer(), 500) '1
                        i.SmallImage = MakeThumb(m.GetBuffer(), 350) '2
                        i.ThumbImage = MakeThumb(m.GetBuffer(), 100) '3

                        i.tag = Request.UserAgent.ToString().ToLower()
                        i.keywords = "Case 6, Rotated"

                        Exit Select

                    Case 7
                        originalImage.RotateFlip(RotateFlipType.Rotate270FlipX)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        i.Image = MakeThumb(m.GetBuffer(), 1200)
                        i.LargeImage = MakeThumb(m.GetBuffer(), 500) '1
                        i.SmallImage = MakeThumb(m.GetBuffer(), 350) '2
                        i.ThumbImage = MakeThumb(m.GetBuffer(), 100) '3

                        i.tag = Request.UserAgent.ToString().ToLower()
                        i.keywords = "Case 7, Rotated"

                        Exit Select

                    Case 8
                        ' rotated 90 right
                        ' de-rotate:
                        originalImage.RotateFlip(RotateFlipType.Rotate270FlipNone)

                        Dim bmp As New Bitmap(originalImage)
                        Dim m As New IO.MemoryStream()
                        bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

                        i.Image = MakeThumb(m.GetBuffer(), 1200)
                        i.LargeImage = MakeThumb(m.GetBuffer(), 500) '1
                        i.SmallImage = MakeThumb(m.GetBuffer(), 350) '2
                        i.ThumbImage = MakeThumb(m.GetBuffer(), 100) '3

                        i.tag = Request.UserAgent.ToString().ToLower()
                        i.keywords = "Case 8, Rotated"

                        Exit Select

                End Select

            Else
                i.Image = MakeThumb(data, 1200)
                i.LargeImage = MakeThumb(data, 500) '1
                i.SmallImage = MakeThumb(data, 350) '2
                i.ThumbImage = MakeThumb(data, 100) '3

                i.tag = Request.UserAgent.ToString().ToLower()
                i.keywords = "Case Nothing, Not Rotated"
            End If


            db.tblPhotos.InsertOnSubmit(i)
            db.SubmitChanges()

            Dim brands = (From p In db.tblBrandInEvents Where p.eventID = eventID Select p)
            For Each p In brands

                Dim newBrandPhoto As New tblBrandPhoto With {.photoID = i.photoID, .brandID = p.brandID}
                db.tblBrandPhotos.InsertOnSubmit(newBrandPhoto)
                db.SubmitChanges()
            Next

            stream.Close()

        Catch ex As Exception
            ErrorPanel.Visible = True

            PhotoListView.DataBind()

            UploadPanel.Visible = False
            ViewPanel.Visible = True
            ButtonPanel.Visible = True

            Dim photo2 = (From p In db.tblPhotos Where p.eventID = Request.QueryString("EventID") Select p)
            If photo2.Count = 0 Then
                MissingPhotoPanel.Visible = True
            Else
                MissingPhotoPanel.Visible = False
            End If

            RecapWizard.DisplayNavigationButtons = True

        End Try




        Try
            Dim insertlog = db.InsertEventLog(Request.QueryString("EventID"), "Photo(s) uploaded", "Photos have been uploaded to the events gallery", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Photo(s) uploaded", "Photos have been uploaded to the events gallery", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        Catch ex As Exception
            msgLabel.Text = ex.Message.ToString()
        End Try


        PhotoListView.DataBind()

        UploadPanel.Visible = False
        ViewPanel.Visible = True
        ButtonPanel.Visible = True

        Dim photo = (From p In db.tblPhotos Where p.eventID = Request.QueryString("EventID") Select p)
        If photo.Count = 0 Then
            MissingPhotoPanel.Visible = True
        Else
            MissingPhotoPanel.Visible = False
        End If

        RecapWizard.DisplayNavigationButtons = True


    End Sub



    Private Sub PhotoListView_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PhotoListView.ItemCommand
        If e.CommandName = "DeleteImage" Then

            Dim id As Integer = e.CommandArgument

            Try
                Dim deletephoto = db.DeletePhoto(id)

                PhotoListView.DataBind()
            Catch ex As Exception
                errorLabel.Text = ex.Message
            End Try


            Dim photo = (From p In db.tblPhotos Where p.eventID = Request.QueryString("EventID") Select p)
            If photo.Count = 0 Then
                MissingPhotoPanel.Visible = True
            Else
                MissingPhotoPanel.Visible = False
            End If


        End If
    End Sub


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

    Private Sub RecapWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles RecapWizard.CancelButtonClick

        Response.Redirect("/ambassadors/dashboard?Action=0")

    End Sub

    Private Sub RecapWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RecapWizard.FinishButtonClick

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        'upload photos
        Dim eventID2 = Request.QueryString("EventID")

        Try
            'save the form
            SaveForm()

            'Dim insertlog = db.InsertEventLog(eventID2, "Event Recap", "Recap was added to the event.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Recap Completed", "The recap was completed and the event status has been updated to Toplined", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            'mark recap as complete & set event status to toplined
            db.UpdateEventRecapStatus(eventID, currentUser.Id)

            Response.Redirect("/ambassadors/dashboard?Action=2")

        Catch ex As Exception
            'prevent the opps page, sometimes we get this error because of the Response.Redirect
            If ex.Message = "Thread was being aborted." Then

                'ignor this error
                'not sure why we get this error. maybe one day we will learn more abaout it

                Response.Redirect("/ambassadors/dashboard?Action=2")
            Else

                'add to history log
                lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Recap Error", ex.Message(), Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                Response.Redirect("/ambassadors/dashboard?Action=2")
            End If

        End Try



    End Sub

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

    Private Sub btnCancelUpload_Click(sender As Object, e As EventArgs) Handles btnCancelUpload.Click
        UploadPanel.Visible = False
        ViewPanel.Visible = True
        ButtonPanel.Visible = True

        Dim photo = (From p In db.tblPhotos Where p.eventID = Request.QueryString("EventID") Select p)
        If photo.Count = 0 Then
            MissingPhotoPanel.Visible = True
        Else
            MissingPhotoPanel.Visible = False
        End If

        RecapWizard.DisplayNavigationButtons = True
    End Sub

    Private Sub AddPhotoButton_Click(sender As Object, e As EventArgs) Handles AddPhotoButton.Click
        UploadPanel.Visible = True
        ViewPanel.Visible = False
        ButtonPanel.Visible = False
        MissingPhotoPanel.Visible = False

        RecapWizard.DisplayNavigationButtons = False
    End Sub

#End Region

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    'Protected Sub ReceiptUploadAttachments_AttachmentRemoveClicked(sender As Object, args As AttachmentItemEventArgs)
    '    ReceiptUploadAttachments.InsertButton.Enabled = True
    'End Sub

    'Protected Sub ReceiptUploadAttachments_FileUploaded(sender As Object, args As UploaderEventArgs)
    '    ReceiptUploadAttachments.InsertButton.Enabled = False
    '    ReceiptUploadAttachments.TableStyle.CssClass = "showTable"
    'End Sub
End Class