Imports System.Data.SqlClient
Imports System.IO
Imports LinqToExcel
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI
Imports BingGeocoder

Public Class ImportEventsBySupplier
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim count As Integer = 0
    Dim failed As Integer = 0

    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)
        generateDynamicControls()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            BrandListBox.Items.Clear()

            LoadBrands(Request.QueryString("SupplierID"))

            SupplierNameLabel.Text = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p.supplierName).FirstOrDefault

        End If
    End Sub

    Private Sub btnImportExcel_Click(sender As Object, e As EventArgs) Handles btnImportExcel.Click

        If Not Page.IsPostBack Then

        End If
        Dim fileGuid As String = System.Guid.NewGuid.ToString()


        For Each f As UploadedFile In AsyncUpload1.UploadedFiles
            Dim theFileName As String = Path.Combine(Server.MapPath("~/files"), f.FileName)

            f.SaveAs(theFileName)

            Try
                count = 0

                Dim excel = New ExcelQueryFactory(Server.MapPath("~/files/" & f.FileName))

                ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

                Dim events = From x In excel.Worksheet(Of ImportEvent)(WorksheetNameTextBox.Text)
                             Select x



                For Each u In events
                    Try

                        'add the event
                        Dim newevent As New tblRequestedEvent
                        newevent.eventTitle = u.EventName
                        newevent.eventTypeID = EventTypeIDComboBox.SelectedValue
                        newevent.eventDate = u.EventDate

                        Dim dt As Date = Date.Parse(u.EventDate)
                        Dim dateString = dt.ToShortDateString()

                        newevent.requestType = "Import"
                        newevent.startTime = dateString & " " & u.StartTime
                        newevent.endTime = dateString & " " & u.EndTime
                        newevent.locationName = u.LocationName
                        newevent.locationAddress = u.Address
                        newevent.locationCity = u.City
                        newevent.locationState = u.State
                        newevent.locationZip = u.Zip
                        newevent.eventDescription = u.Description
                        newevent.distributer = u.Distributer
                        newevent.CreatedBy = u.RequestedBy
                        newevent.CreatedByEmail = ""
                        newevent.supplierID = Request.QueryString("SupplierID")
                        newevent.BA_Count = PositionsTextBox.Text
                        newevent.importFileID = FileIDTextBox.Text

                        Dim clientID = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault

                        newevent.clientID = clientID.clientID
                        newevent.CreatedDate = DateTime.Now()


                        If TeamComboBox.SelectedIndex = -1 Then
                            'do nothing
                        Else
                            newevent.teamID = TeamComboBox.SelectedValue
                        End If

                        If MatchComboBox.SelectedValue = "0" Then
                            Dim address As String = String.Format("{0}, {1}, {2}, {3}", u.Address, u.City, u.State, u.Zip)

                            newevent.latitude = getLatitude(address.Replace("#", ""))
                            newevent.longitude = getLongitude(address.Replace("#", ""))


                            newevent.matchedLocationID = getMatch(u.LocationName, getLatitude(address.Replace("#", "")), getLongitude(address.Replace("#", "")))
                        End If

                        If MatchComboBox.SelectedValue = "1" Then
                            newevent.matchedLocationID = getLocationNameMatch(u.LocationName)
                        End If


                        db.tblRequestedEvents.InsertOnSubmit(newevent)
                        db.SubmitChanges()

                        count = count + 1

                        'add the brands
                        Dim collection As IList(Of RadListBoxItem) = BrandListBox.CheckedItems

                        For Each item As RadListBoxItem In collection

                            Dim newBrand As New tblBrandsInRequestedEvent With {.requestedEventID = newevent.requestedEventID, .brandID = item.Value}

                            db.tblBrandsInRequestedEvents.InsertOnSubmit(newBrand)
                            db.SubmitChanges()

                        Next

                        Dim question = From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("SupplierID") Select p Order By p.sortOrder

                        For Each p In question

                            Dim NewSupplierBudgetQuestion As New tblSupplierBudgetQuestionResult

                            NewSupplierBudgetQuestion.eventID = newevent.requestedEventID
                            NewSupplierBudgetQuestion.order = p.sortOrder
                            NewSupplierBudgetQuestion.question = p.question
                            NewSupplierBudgetQuestion.fieldType = p.questionType
                            NewSupplierBudgetQuestion.fieldID = p.supplierBudgetQuestionID



                            Select Case p.questionType
                                Case "text"
                                    Dim txtbox As TextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), TextBox)
                                    NewSupplierBudgetQuestion.answer = txtbox.Text


                                Case "multiline"
                                    Dim txtbox As TextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), TextBox)
                                    NewSupplierBudgetQuestion.answer = txtbox.Text
                                    NewSupplierBudgetQuestion.rows = p.lines

                                Case "choice"

                                    Try
                                        Dim txtbox As RadComboBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadComboBox)
                                        NewSupplierBudgetQuestion.answer = txtbox.SelectedValue


                                    Catch ex As Exception
                                        NewSupplierBudgetQuestion.answer = "error"
                                    End Try


                                Case "number"
                                    Dim txtbox As RadNumericTextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadNumericTextBox)
                                    NewSupplierBudgetQuestion.answer = txtbox.Text

                                Case "date"
                                    Dim txtbox As RadDatePicker = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadDatePicker)
                                    NewSupplierBudgetQuestion.answer = txtbox.SelectedDate


                                Case "time"
                                    Dim txtbox As RadTimePicker = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadTimePicker)
                                    NewSupplierBudgetQuestion.answer = txtbox.SelectedDate

                                Case "currency"
                                    Dim txtbox As RadNumericTextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadNumericTextBox)
                                    NewSupplierBudgetQuestion.answer = txtbox.Text

                                Case "yes/no"
                                    Try
                                        Dim txtbox As RadioButtonList = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadioButtonList)
                                        NewSupplierBudgetQuestion.answer = txtbox.SelectedItem.Value
                                    Catch ex As Exception

                                    End Try




                            End Select
                            db.tblSupplierBudgetQuestionResults.InsertOnSubmit(NewSupplierBudgetQuestion)
                            db.SubmitChanges()

                        Next

                    Catch ex As Exception
                        msgLabel.Text = ex.Message
                    End Try

                Next



            Catch ex As Exception
                msgLabel.Text = ex.Message
            End Try


            '  System.IO.File.Delete(Server.MapPath(theFileName))

        Next

        Response.Redirect("/Events/ViewRequestedEvents")

        'RadNotification1.Show()

    End Sub

    Function getLatitude(ByVal address As String) As String

        Try
            Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

            Dim geocoder = New BingGeocoderClient(BingKey)
            Dim result = New BingGeocoderResult()
            result = geocoder.Geocode(address)

            Return result.Latitude
        Catch ex As Exception
            Return "0"
        End Try


    End Function

    Function getLongitude(ByVal address As String) As String
        Try
            Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

            Dim geocoder = New BingGeocoderClient(BingKey)
            Dim result = New BingGeocoderResult()
            result = geocoder.Geocode(address)

            Return result.Longitude
        Catch ex As Exception
            Return "0"
        End Try

    End Function

    Function getLocationNameMatch(ByVal locationname As String)

        Dim q = From p In db.tblAccounts Where p.accountName = locationname Select p

        If q.Count = 0 Then
            Return "0"
        Else
            Return (From p In db.tblAccounts Where p.accountName = locationname Select p.Vpid).FirstOrDefault
        End If

    End Function

    Function getMatch(ByVal locationname As String, ByVal loc1 As String, loc2 As String) As String
        Try
            'Dim q = (From p In db.tblRequestedEvents Where p.requestedEventID = ID Select p).FirstOrDefault
            'Dim address As String = String.Format("{0}, {1}, {2}, {3}", q.locationAddress, q.locationCity, q.locationState, q.locationZip)

            'Dim loc1 = getLatitude(address.Replace("#", ""))
            'Dim loc2 = getLongitude(address.Replace("#", ""))

            Dim b As String = loc1.Substring(0, 5)

            Dim c As String = loc2.Substring(0, 7)

            ' Dim r = (From p In db.getShortGeoLocations Where p.shortLatitude = b And p.shortLongitude = c Select p).Count


            Dim r = (From p In db.getMatchedLocation(locationname, b, c) Select p.Vpid).FirstOrDefault

            If (From p In db.getMatchedLocation(locationname, b, c) Select p.Vpid).Count = 0 Then
                Return 0
            Else
                Return r.ToString()

            End If




        Catch ex As Exception
            Return 0
        End Try


    End Function

    'Private Sub SupplierIDComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles SupplierIDComboBox.SelectedIndexChanged


    'End Sub

    Protected Sub LoadBrands(ByVal supplierID As String)

        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        Dim adapter As New SqlDataAdapter("SELECT * FROM getBrandsbySupplier WHERE supplierID=@supplierID ORDER By brandName", connection)

        adapter.SelectCommand.Parameters.AddWithValue("@supplierID", supplierID)

        Dim dt As New DataTable()
        adapter.Fill(dt)

        BrandListBox.DataSource = dt
        BrandListBox.DataBind()

    End Sub


#Region "Dynamic Methods"
    Public Sub generateDynamicControls()
        'get the fields from the supplierBudget type

        ' Dim shortName As String = Page.RouteData.Values("supplier")

        ' Dim id As Integer = (From p In db.tblSuppliers Where p.shortName = shortName Select p.supplierID).FirstOrDefault

        Dim question = From p In db.tblSupplierBudgetQuestions Where p.supplierID = Request.QueryString("SupplierID") Select p Order By p.sortOrder

        For Each p In question

            Select Case p.questionType
                Case "label"
                    CreateLabelControl(p.supplierBudgetQuestionID, p.question)

                Case "text"
                    CreateTextboxControl(p.supplierBudgetQuestionID, p.question, p.description, p.required, "")

                Case "choice"
                    CreateComboboxControl(p.supplierBudgetQuestionID, p.question, "", p.description, p.required, p.displayOption)

                Case "multiline"
                    CreateMultilineTextboxControl(p.supplierBudgetQuestionID, p.question, p.lines, p.description, p.required, "")

                Case "number"
                    CreateNumberboxControl(p.supplierBudgetQuestionID, p.question, p.numberDefaultValue, p.numberDecimalPlace, p.required, p.description, p.showPercentage)


                Case "date"
                    CreateDateControl(p.supplierBudgetQuestionID, p.question, p.dateDefaultValue, p.description)

                Case "time"
                    CreateTimeControl(p.supplierBudgetQuestionID, p.question, p.timeFormat)

                Case "currency"
                    CreateCurrencyControl(p.supplierBudgetQuestionID, p.question, p.numberDefaultValue)

                Case "yes/no"
                    CreateYesNoControl(p.supplierBudgetQuestionID, p.question, p.supplierBudgetQuestionID, p.description, p.yes_noDefaultValue)
            End Select



        Next

    End Sub

    Private Sub CreateLabelControl(id As String, labelText As String)

        Dim div As New HtmlGenericControl("div")

        Dim lbl As New HtmlGenericControl("h3")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateTextboxControl(id As String, labelText As String, description As String, required As Boolean, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        'add required field
        If required = True Then
            labelText = labelText & "<span class='text-danger'> *</span>"
        End If

        Dim lbl As New HtmlGenericControl("label")
        lbl.InnerHtml = labelText
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        div.Controls.Add(lbl)

        Dim div1 As New HtmlGenericControl("div")
        div1.Attributes.Add("class", "col-sm-5")
        div.Controls.Add(div1)

        ' Create a text box control
        Dim box As New TextBox
        box.CssClass = "form-control"
        box.ID = "text" & id & "result"
        box.Text = answer
        div1.Controls.Add(box)

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div1.Controls.Add(span)

        If required = True Then
            Dim validate As New RequiredFieldValidator
            validate.CssClass = "errorlabel"
            validate.SetFocusOnError = True
            validate.ID = "RequiredField" & "text" & id & "result"
            validate.ControlToValidate = "text" & id & "result"
            validate.Display = ValidatorDisplay.Dynamic
            validate.ErrorMessage = "This is a required field!"
            validate.ValidationGroup = "details"

            div.Controls.Add(validate)
        End If

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateMultilineTextboxControl(id As String, labelText As String, rows As Integer, description As String, required As Boolean, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        'add required field
        If required = True Then
            labelText = labelText & "<span class='text-danger'> *</span>"
        End If

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div1 As New HtmlGenericControl("div")
        div1.Attributes.Add("class", "col-sm-6")
        div.Controls.Add(div1)

        ' Create a text box control
        Dim box As New TextBox
        box.CssClass = "form-control"
        box.TextMode = TextBoxMode.MultiLine
        box.Text = ""
        box.Rows = rows
        box.ID = "text" & id & "result"

        div1.Controls.Add(box)

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div1.Controls.Add(span)

        If required = True Then
            Dim validate As New RequiredFieldValidator
            validate.CssClass = "errorlabel"
            validate.SetFocusOnError = True
            validate.ID = "RequiredField" & "text" & id & "result"
            validate.ControlToValidate = "text" & id & "result"
            validate.Display = ValidatorDisplay.Dynamic
            validate.ErrorMessage = "This is a required field!"
            validate.ValidationGroup = "details"

            div.Controls.Add(validate)
        End If

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateNumberboxControl(id As String, labelText As String, defaultValue As String, numberDecimalPlaces As Integer, required As Boolean, description As String, showPercent As Boolean)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        'add required field
        If required = True Then
            labelText = labelText & "<span class='text-danger'> *</span>"
        End If

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")
        div2.Attributes.Add("class", "col-sm-6")

        ' Create a text box control
        Dim box As New RadNumericTextBox
        box.ShowSpinButtons = "true"
        box.NumberFormat.DecimalDigits = numberDecimalPlaces
        box.Width = 100
        box.ID = "text" & id & "result"
        box.Value = defaultValue

        If showPercent = True Then
            box.Type = NumericType.Percent
        Else
            box.Type = NumericType.Number
        End If

        div2.Controls.Add(box)

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div2.Controls.Add(span)

        If required = True Then
            Dim validate As New RequiredFieldValidator
            validate.CssClass = "errorlabel"
            validate.SetFocusOnError = True
            validate.ID = "RequiredField" & "text" & id & "result"
            validate.ControlToValidate = "text" & id & "result"
            validate.Display = ValidatorDisplay.Dynamic
            validate.ErrorMessage = "This is a required field!"
            validate.ValidationGroup = "details"

            div.Controls.Add(validate)
        End If


        div.Controls.Add(div2)

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateDateControl(id As String, labelText As String, dateValue As String, description As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")
        div2.Attributes.Add("class", "col-sm-6")

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

        Dim span As New HtmlGenericControl("span")
        span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
        div2.Controls.Add(span)
        div.Controls.Add(div2)

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateTimeControl(id As String, labelText As String, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")
        div2.Attributes.Add("class", "col-sm-6")

        ' Create a text box control
        Dim box As New RadTimePicker
        box.Width = 100
        box.ID = "text" & id & "result"


        ' box.DbSelectedDate = ""


        div2.Controls.Add(box)
        div.Controls.Add(div2)

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateCurrencyControl(id As String, labelText As String, answer As String)

        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("class", "form-group")

        Dim lbl As New HtmlGenericControl("label")
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div2 As New HtmlGenericControl("div")
        div2.Attributes.Add("class", "col-sm-6")

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

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateYesNoControl(id As String, labelText As String, questionID As String, description As String, answer As String)

        Try
            Dim div As New HtmlGenericControl("div")
            div.Attributes.Add("class", "form-group")

            Dim lbl As New HtmlGenericControl("label")
            lbl.Attributes.Add("class", "col-sm-3 control-label")
            lbl.InnerHtml = labelText
            div.Controls.Add(lbl)

            Dim div2 As New HtmlGenericControl("div")
            div2.Attributes.Add("class", "col-sm-6")

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


            div2.Controls.Add(ddl)
            div.Controls.Add(div2)

            Dim span As New HtmlGenericControl("span")
            span.InnerHtml = "<span id='helpBlock' class='help-block'>" & description & "</span>"
            div.Controls.Add(span)

            SupplierBudgetPlaceHolder.Controls.Add(div)
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
        lbl.Attributes.Add("class", "col-sm-3 control-label")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim div1 As New HtmlGenericControl("div")
        div1.Attributes.Add("class", "col-sm-6")
        div.Controls.Add(div1)

        Select Case displayOption
            Case "drop"

                ' Create a text box control
                Dim ddl As New RadComboBox
                ' ddl.CssClass = "form-control combobox"
                ddl.ID = "text" & id & "result"
                ddl.Width = 200
                ddl.Items.Add(New RadComboBoxItem("-- Select --", ""))

                Dim q = From a In db.tblSupplierBudgetQuestionOptions Where a.supplierBudgetQuestionID = id Select a Order By a.sortOrder
                For Each a In q
                    ddl.Items.Add(New RadComboBoxItem(a.option, a.optionID))
                Next

                ddl.SelectedValue = answer

                div1.Controls.Add(ddl)

            Case "check"
                Dim clb As New CheckBoxList
                clb.ID = "text" & id & "result"

                Dim q = From a In db.tblSupplierBudgetQuestionOptions Where a.supplierBudgetQuestionID = id Select a Order By a.sortOrder
                For Each a In q
                    ' clb.Items.Add(New ListItem(a.option, a.option))

                    Dim selectedItem As New ListItem(a.option, a.optionID)
                    ' selectedItem.Selected = getanswer(answer, a.option)
                    clb.Items.Add(selectedItem)

                Next

            Case "radio"

                Dim clb As New RadioButtonList
                'clb.CssClass = "form-control combobox"
                ' clb.Width = 200
                clb.ID = "text" & id & "result"
                ' ddl.Items.Add(New RadComboBoxItem("-- Select --", ""))

                Dim q = From a In db.tblSupplierBudgetQuestionOptions Where a.supplierBudgetQuestionID = id Select a Order By a.sortOrder
                For Each a In q
                    clb.Items.Add(New ListItem(a.option, a.optionID))
                Next

                clb.SelectedIndex = answer

                '  clb.SelectedValue = answer

                div1.Controls.Add(clb)

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

        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub
#End Region

End Class



