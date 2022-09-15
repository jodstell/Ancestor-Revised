Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class EditActivity
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            ViewState("count") = 1
        End If


        Dim mode As String = Request.QueryString("Mode")

        Select Case mode

            Case "View"
                ViewPanel.Visible = True
                EditPanel.Visible = False

                BindViewPanel()

            Case "Edit"
                ViewPanel.Visible = False
                EditPanel.Visible = True

                BindEditPanel()
        End Select
    End Sub

    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)
        generateDynamicControls()
    End Sub

    Protected Property ImageWidth() As Unit

        Get
            Dim state As Object = If(ViewState("ImageWidth"), Unit.Pixel(150))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageWidth") = value
        End Set

    End Property

    Protected Property ImageHeight() As Unit
        Get
            Dim state As Object = If(ViewState("ImageHeight"), Unit.Pixel(150))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageHeight") = value
        End Set

    End Property

    Protected Function CreateWindowScript(ByVal activityID As Integer, ByVal photoID As Integer) As String
        Return String.Format("var win = window.radopen('/Accounts/PhotoActivity.aspx?ActivityID={0}&PhotoID={1}','Details');win.center();", activityID, photoID)
    End Function


    Private Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click
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

            i.accountID = Request.QueryString("AccountID")
            i.activityID = Request.QueryString("ActivityID")
            db.tblAccountActivityPhotos.InsertOnSubmit(i)
            db.SubmitChanges()

        Next

        'PhotoListView.DataBind()


        'show/hide panels
        ViewPhotoPanel.Visible = True
        UploadPanel.Visible = False
        divbuttons.Visible = True


        'Response.Redirect(String.Format("/accounts/editactivity?ActivityID={0}&AccountID={1}&Mode=Edit", Request.QueryString("ActivityID"), Request.QueryString("AccountID")))

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

    Private Sub PhotoListView_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PhotoListView.ItemCommand
        'If e.CommandName = "DeleteImage" Then

        '    Dim id As Integer = e.CommandArgument

        '    Try
        '        Dim deletephoto = db.DeleteAccountActivityPhoto()(id)

        '        PhotoListView.DataBind()
        '    Catch ex As Exception
        '        errorLabel.Text = ex.Message
        '    End Try


        'End If
    End Sub

    Private Sub AddPhotoButton_Click(sender As Object, e As EventArgs) Handles AddPhotoButton.Click
        UploadPanel.Visible = True
        ViewPhotoPanel.Visible = False
        divbuttons.Visible = False
    End Sub

    Private Sub btnCancelUpload_Click(sender As Object, e As EventArgs) Handles btnCancelUpload.Click
        ViewPhotoPanel.Visible = True
        UploadPanel.Visible = False
        divbuttons.Visible = True

        'Response.Redirect(String.Format("/accounts/editactivity?ActivityID={0}&AccountID={1}&Mode=Edit", Request.QueryString("ActivityID"), Request.QueryString("AccountID")))
    End Sub

    Sub BindViewPanel()

        Dim q = From p In db.tblAccountActivities Where p.accountActivityID = Request.QueryString("ActivityID") Select p

        For Each p In q
            activityTypeLabel.Text = getActivityName(p.activityTypeID)
            activityDateLabel.Text = String.Format("{0:D}", p.activityDate)


        Next

        Dim loc = (From p In db.tblAccounts Where p.accountID = Request.QueryString("AccountID") Select p).FirstOrDefault

        accountNameLabel.Text = loc.accountName
        accountlLocationLabel.Text = String.Format("{0}, {1}", loc.city, loc.state)

        AccountNameLabel1.Text = loc.accountName

    End Sub


    Sub BindEditPanel()

        Dim q = From p In db.tblAccountActivities Where p.accountActivityID = Request.QueryString("ActivityID") Select p

        For Each p In q
            activityTypeLabel.Text = getActivityName(p.activityTypeID)
            activityDateLabel.Text = String.Format("{0:D}", p.activityDate)


            ActivityTypeLabel1.Text = getActivityName(p.activityTypeID)
            ActivityDateLabel1.Text = String.Format("{0:D}", p.activityDate)
        Next

        Dim loc = (From p In db.tblAccounts Where p.accountID = Request.QueryString("AccountID") Select p).FirstOrDefault

        AccountNameLabel1.Text = loc.accountName

        ''get the activity fields
        'Dim q = (From p In db.tblAccountActivityResults Where p.accountActivityID = Request.QueryString("ActivityID") Select p).FirstOrDefault

        'For Each p In q

        '    Select Case p.type
        '        Case "text"
        '            Dim txtbox As TextBox = CType(EditPlaceHolder.FindControl("text" & p.fieldID & "result"), TextBox)

        '    End Select

        'Next


    End Sub

    Function getActivityName(id As Integer) As String
        Return (From p In db.tblActivityTypes Where p.activityTypeID = id Select p.activityName).FirstOrDefault
    End Function



    Protected Sub btnBack_Click(sender As Object, e As EventArgs)


    End Sub



    Private Sub btnDelete1_Click(sender As Object, e As EventArgs) Handles btnDelete1.Click

        db.DeleteAccountActivity(Request.QueryString("ActivityID"))

        Response.Redirect("/Accounts/ViewActivities")
    End Sub

#Region "Dynamic Methods"
    Public Sub generateDynamicControls()
        ' If SelectActivityType.SelectedIndex > 0 Then

        Dim ActivityTypeID As Integer = Request.QueryString("ActivityTypeID")
        '  ViewState("activitytypeid") = ActivityTypeID

        Dim activity = From p In db.tblAccountActivityResults Where p.accountActivityID = Request.QueryString("ActivityID") Select p Order By p.order
        'From p In db.tblActivityFields Where p.activityTypeID = ActivityTypeID Select p Order By p.sortOrder

        For Each p In activity
            Try
                Select Case p.fieldType
                    Case "text"
                        CreateTextboxControl(p.fieldID, p.question, p.answer)

                    Case "choice"
                        CreateComboboxControl(p.fieldID, p.question, p.answer, p.description, "False", p.displayOptions)

                    Case "multiline"
                        CreateMultilineTextboxControl(p.fieldID, p.question, p.answer, p.rows)

                    Case "number"
                        CreateNumberboxControl(p.fieldID, p.question, p.answer, p.numberDecimalPlace)

                    Case "date"
                        CreateDateControl(p.fieldID, p.question, p.answer)

                    Case "time"
                        CreateTimeControl(p.fieldID, p.question, p.answer)

                    Case "currency"
                        CreateCurrencyControl(p.fieldID, p.question, p.answer)

                    Case "yes/no"
                        CreateYesNoControl(p.fieldID, p.question, p.answer)

                End Select
            Catch ex As Exception

            End Try

        Next

        '   POSPanel.Visible = True
        ' End If
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

        EditPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateMultilineTextboxControl(id As String, labelText As String, answer As String, rows As Integer)

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

        EditPlaceHolder.Controls.Add(div)

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

        EditPlaceHolder.Controls.Add(div)

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

        EditPlaceHolder.Controls.Add(div)

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

        EditPlaceHolder.Controls.Add(div)

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

        EditPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateYesNoControl(id As String, labelText As String, answer As String)

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

        EditPlaceHolder.Controls.Add(div)

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

        EditPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub btnSaveChanges_Click(sender As Object, e As EventArgs) Handles btnSaveChanges.Click

        'save the form
        Dim activity = (From p In db.tblAccountActivityResults Where p.accountActivityID = Request.QueryString("ActivityID") Select p Order By p.order).FirstOrDefault


        Select Case activity.fieldType
            Case "text"
                Dim txtbox As TextBox = CType(EditPlaceHolder.FindControl("text" & activity.fieldID & "result"), TextBox)
                activity.answer = txtbox.Text

            Case "multiline"
                Dim txtbox As TextBox = CType(EditPlaceHolder.FindControl("text" & activity.fieldID & "result"), TextBox)
                activity.answer = txtbox.Text


            Case "choice"
                '  Dim txtbox As DropDownList = CType(InsertPlaceHolder.FindControl("text" & p.fieldID & "result"), DropDownList)
                ' newActivityResult.answer = txtbox.SelectedValue

                Try
                    Dim myOptions As String = ""

                    Dim txtbox As RadComboBox = CType(EditPlaceHolder.FindControl("text" & activity.fieldID & "result"), RadComboBox)
                    'loop

                    'For Each item As ListItem In txtbox.Items
                    '    If item.Selected Then
                    '        myOptions += item.Text + ","
                    '    End If
                    'Next

                    activity.answer = txtbox.SelectedValue


                Catch ex As Exception
                    activity.answer = "error"
                End Try


            Case "number"
                Dim txtbox As RadNumericTextBox = CType(EditPlaceHolder.FindControl("text" & activity.fieldID & "result"), RadNumericTextBox)
                activity.answer = txtbox.Text

                'Case "date"
                '    Dim txtbox As RadDatePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadDatePicker)
                '    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)


                'Case "time"
                '    Dim txtbox As RadTimePicker = CType(InsertPlaceHolder.FindControl("text" & p.eventRecapQuestionID & "result"), RadTimePicker)
                '    db.InsertRecapAnswer(p.eventRecapQuestionID, txtbox.SelectedDate, currentUser.Id)


            Case "currency"
                Dim txtbox As RadNumericTextBox = CType(EditPlaceHolder.FindControl("text" & activity.fieldID & "result"), RadNumericTextBox)
                activity.answer = txtbox.Text

            Case "yes/no"

                Dim txtbox As RadioButtonList = CType(EditPlaceHolder.FindControl("text" & activity.fieldID & "result"), RadioButtonList)
                activity.answer = txtbox.SelectedItem.Text


        End Select

        db.SubmitChanges()



        Response.Redirect(String.Format("/accounts/editactivity?ActivityID={0}&AccountID={1}&Mode=View#activities", Request.QueryString("ActivityID"), Request.QueryString("AccountID")))

    End Sub

    Private Sub PhotoListViewEdit_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PhotoListViewEdit.ItemCommand

        If e.CommandName = "DeleteImage" Then

            Dim id As Integer = e.CommandArgument

            Try
                Dim deletephoto = db.DeleteAccountActivityPhoto(id)

                PhotoListViewEdit.DataBind()
            Catch ex As Exception
                errorLabel.Text = ex.Message
            End Try


        End If

    End Sub


#End Region
End Class