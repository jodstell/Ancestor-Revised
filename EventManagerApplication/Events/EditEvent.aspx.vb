Imports Telerik.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.Net
Imports System.Web.Script.Serialization
Imports System.IO

Public Class EditEventaspx
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext

    Dim order As Integer = 0

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)
        generateDynamicControls()
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim action = Request.QueryString("action")

        Select Case action
            Case 0
                'unused case
            Case 1
                RadNotification1.Show()
        End Select


        'show/hide admin panels
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Client") Then

        End If

        HiddenClientID.Value = Session("CurrentClientID")
        bindEvent()

        If Not Page.IsPostBack Then
            Try
                db.UpdateEventDuration(Convert.ToInt32(Request.QueryString("EventID")))
            Catch ex As Exception

            End Try


            Dim AccountNameLabel As Label = CType(EditEventForm.FindControl("AccountNameLabel"), Label)
            Dim AccountAddressLabel As Label = CType(EditEventForm.FindControl("AccountAddressLabel"), Label)
            Dim AccountCityStateLabel As Label = CType(EditEventForm.FindControl("AccountCityStateLabel"), Label)

            'Dim LocationPanel As Panel = CType(EditEventForm.FindControl("LocationPanel"), Panel)
            'Dim ResultsPanel As Panel = CType(EditEventForm.FindControl("ResultsPanel"), Panel)
            'Dim SearchPanel As Panel = CType(EditEventForm.FindControl("SearchPanel"), Panel)

            Dim id As Integer = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p.locationID).FirstOrDefault


            Dim _city As String = (From p In db.tblAccounts Where p.Vpid = id Select p.city).FirstOrDefault
            Dim _state As String = (From p In db.tblAccounts Where p.Vpid = id Select p.state).FirstOrDefault
            Dim _zip As String = (From p In db.tblAccounts Where p.Vpid = id Select p.zipCode).FirstOrDefault

            'LocationPanel.Visible = True
            'ResultsPanel.Visible = False
            'SearchPanel.Visible = False

            AccountNameLabel.Text = (From p In db.tblAccounts Where p.Vpid = id Select p.accountName).FirstOrDefault
            AccountAddressLabel.Text = (From p In db.tblAccounts Where p.Vpid = id Select p.streetAddress1).FirstOrDefault
            AccountCityStateLabel.Text = String.Format("{0}, {1}  {2}", _city, _state, _zip)

            'Try
            '    'set duration
            '    Dim result = From p In db.qryGetEventDurationMinutes Where p.eventID = Request.QueryString("EventID") Select p

            '    For Each p In result

            '        Dim HoursDropDownList As RadDropDownList = CType(EditEventForm.FindControl("HoursDropDownList"), RadDropDownList)
            '        Dim MinutesDropDownList As RadDropDownList = CType(EditEventForm.FindControl("MinutesDropDownList"), RadDropDownList)

            '        HoursDropDownList.SelectedValue = p.Hours.ToString()
            '        MinutesDropDownList.SelectedValue = p.Minutes.ToString()
            '    Next




            'Catch ex As Exception

            'End Try


        End If

    End Sub

    Function showEnable()

        'check status id
        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p).FirstOrDefault

        If thisEvent.statusID = 3 Then

            Return True
        End If

        If thisEvent.statusID = 6 Then

            Return True
        End If

        Return False
    End Function

    Function showCancel()

        'chek status id
        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p).FirstOrDefault

        If thisEvent.statusID = 3 Then

            Return False
        End If

        If thisEvent.statusID = 6 Then

            Return False
        End If

        Return True
    End Function

    Sub bindEvent()
        Dim q = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p).FirstOrDefault

        'populate labels
        Me.EventNameLabel.Text = q.eventTitle
        Me.EventDateLabel.Text = String.Format("{0:D}", q.eventDate)
        Me.EventIDLabel.Text = q.eventID

    End Sub

    Private Sub GetEvent_Updated(sender As Object, e As LinqDataSourceStatusEventArgs) Handles GetEvent.Updated

        Dim insertlog = db.InsertEventLog(Request.QueryString("EventID"), "Event Details Updated", "The event details was updated.", Context.User.Identity.GetUserId(), Date.Now())

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Event Details Updated", "The event details was updated.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        'delete all eventCourse records
        db.deleteEventCourse(Convert.ToInt32(Request.QueryString("ID")))

        'get brands
        Dim r = From p In db.getCourseForEvents Where p.eventID = Request.QueryString("EventID") Select p

        For Each p In r

            Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Order By l.SortOrder Select l

            If course.Count = 0 Then

            Else
                For Each l In course

                    Dim newCourse As New tblEventCourse
                    newCourse.eventID = Request.QueryString("ID")
                    newCourse.CourseTitle = getBrandCourseGroupName(p.CourseTitle)

                    Dim _CurriculumLists = (From u In lmsdb.CurriculumLists Where u.CurriculumID = l.CurriculumID Select u).FirstOrDefault

                    Dim type = _CurriculumLists.ContentType
                    Dim _testID = _CurriculumLists.TestID

                    newCourse.contentID = _CurriculumLists.ContentType
                    newCourse.testID = _CurriculumLists.TestID

                    Dim icon As String = ""

                    Select Case type
                        Case "1"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='True'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "2"
                            icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "3"
                            icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "4"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "5"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "6"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "7"
                            icon = "<i class='fa fa-check-square-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                    End Select

                    db.tblEventCourses.InsertOnSubmit(newCourse)
                    db.SubmitChanges()

                Next

            End If


        Next


        'Add update budget tracking results here
        Dim supplierIDTextBox As DropDownList = CType(EditEventForm.FindControl("supplierIDTextBox"), DropDownList)
        Dim SupplierBudgetPlaceHolder As PlaceHolder = CType(EditEventForm.FindControl("SupplierBudgetPlaceHolder"), PlaceHolder)

        Dim question = From p In db.qryGetSupplierBudgetQuestion_Answers Where p.supplierID = supplierIDTextBox.SelectedValue And p.eventID = Request.QueryString("EventID") Select p Order By p.sortOrder

        For Each p In question
            Select Case p.questionType
                Case "text"

                    Dim txtbox As TextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), TextBox)

                    db.UpdateBudgetQuestionAnswer(p.supplierBudgetQuestionID, txtbox.Text, Request.QueryString("EventID"))


                Case "multiline"
                    Dim txtbox As TextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), TextBox)

                    db.UpdateBudgetQuestionAnswer(p.supplierBudgetQuestionID, txtbox.Text, Request.QueryString("EventID"))

                Case "choice"

                    Try
                        Dim txtbox As RadComboBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadComboBox)
                        db.UpdateBudgetQuestionAnswer(p.supplierBudgetQuestionID, txtbox.SelectedValue, Request.QueryString("EventID"))


                    Catch ex As Exception
                        db.UpdateBudgetQuestionAnswer(p.supplierBudgetQuestionID, "error", Request.QueryString("EventID"))
                    End Try


                Case "number"
                    Dim txtbox As RadNumericTextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadNumericTextBox)
                    db.UpdateBudgetQuestionAnswer(p.supplierBudgetQuestionID, txtbox.Text, Request.QueryString("EventID"))


                Case "date"
                    Dim txtbox As RadDatePicker = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadDatePicker)

                    db.UpdateBudgetQuestionAnswer(p.supplierBudgetQuestionID, txtbox.SelectedDate, Request.QueryString("EventID"))



                Case "time"
                    Dim txtbox As RadTimePicker = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadTimePicker)
                    db.UpdateBudgetQuestionAnswer(p.supplierBudgetQuestionID, txtbox.SelectedDate, Request.QueryString("EventID"))


                Case "currency"
                    Dim txtbox As RadNumericTextBox = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadNumericTextBox)
                    db.UpdateBudgetQuestionAnswer(p.supplierBudgetQuestionID, txtbox.Text, Request.QueryString("EventID"))


                Case "yes/no"
                    Try
                        Dim txtbox As RadioButtonList = CType(SupplierBudgetPlaceHolder.FindControl("text" & p.supplierBudgetQuestionID & "result"), RadioButtonList)
                        db.UpdateBudgetQuestionAnswer(p.supplierBudgetQuestionID, txtbox.SelectedItem.Value, Request.QueryString("EventID"))

                    Catch ex As Exception

                    End Try

            End Select

        Next






        Response.Redirect("/Events/EventDetails?ID=" & Request.QueryString("EventID") & "&Action=1")
    End Sub

    Function getBrandCourseGroupName(groupID As String) As String
        Return (From p In lmsdb.CurriculumGroups Where p.CurriculumGroupID = groupID Select p.Title).FirstOrDefault

    End Function


    Private Sub GetEvent_Updating(sender As Object, e As LinqDataSourceUpdateEventArgs) Handles GetEvent.Updating

        Dim UpdateEventDates As Boolean = False

        Dim originalEvent As tblEvent
        Dim newEvent As tblEvent

        originalEvent = CType(e.OriginalObject, tblEvent)
        newEvent = CType(e.NewObject, tblEvent)

        If (originalEvent.eventTypeID <> newEvent.eventTypeID) Then
            Dim order As Integer = 0

        End If

        If (originalEvent.eventDate <> newEvent.eventDate) Then

            Dim insertlog = db.InsertEventLog(originalEvent.eventID, "Event Date Updated", "The event date was changed from " & originalEvent.eventDate & " to " & newEvent.eventDate, Context.User.Identity.GetUserId(), Date.Now())

            UpdateEventDates = True

        End If

        If (originalEvent.startTime <> newEvent.startTime) Then

            Dim insertlog = db.InsertEventLog(originalEvent.eventID, "Event Start Time Updated", "The event start time was changed from " & String.Format("{0:T}", originalEvent.startTime) & " to " & String.Format("{0:T}", newEvent.startTime), Context.User.Identity.GetUserId(), Date.Now())

            UpdateEventDates = True
        End If

        If (originalEvent.eventHours <> newEvent.eventHours) Then

            ' Dim insertlog = db.InsertEventLog(originalEvent.eventID, "Event Start Time Updated", "The event start time was changed from " & originalEvent.startTime & " to " & newEvent.startTime, Context.User.Identity.GetUserId(), Date.Now())

            UpdateEventDates = True
        End If

        If (originalEvent.eventMinutes <> newEvent.eventMinutes) Then

            ' Dim insertlog = db.InsertEventLog(originalEvent.eventID, "Event Start Time Updated", "The event start time was changed from " & originalEvent.startTime & " to " & newEvent.startTime, Context.User.Identity.GetUserId(), Date.Now())

            UpdateEventDates = True
        End If


        If UpdateEventDates = True Then

            Dim StartTimeDatePicker As RadTimePicker = CType(EditEventForm.FindControl("StartTimeDatePicker"), RadTimePicker)
            Dim HoursDropDownList As DropDownList = CType(EditEventForm.FindControl("HoursDropDownList1"), DropDownList)
            Dim MinutesDropDownList As DropDownList = CType(EditEventForm.FindControl("MinutesDropDownList1"), DropDownList)

            Dim duration As Integer = Convert.ToInt32(HoursDropDownList.SelectedValue) * 60 + Convert.ToInt32(MinutesDropDownList.SelectedValue)

            'update the assignments and event dates
            db.UpdateEventDateTime(originalEvent.eventID, newEvent.eventDate, StartTimeDatePicker.SelectedDate, duration, Convert.ToInt32(HoursDropDownList.SelectedValue), Convert.ToInt32(MinutesDropDownList.SelectedValue))

        End If


    End Sub


    Private Sub EditEventForm_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles EditEventForm.ItemCommand
        If e.CommandName = "Cancel" Then
            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Cancel Changes", "The cancel event changes button was clicked.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            Response.Redirect("/Events/EventDetails?ID=" & Request.QueryString("EventID") & "&Action=0")
        End If

        If e.CommandName = "DeleteEvent" Then

            db.DeleteEvent(Convert.ToInt32(Request.QueryString("EventID")), Context.User.Identity.GetUserId())


            Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p).FirstOrDefault

            Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Deleted", "The event was deleted.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Event Deleted", "The event was deleted.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            Response.Redirect("/Events/ViewEvents?&Action=2&")

        End If

        If e.CommandName = "ChangeAccount" Then
            FormPanel.Visible = False
            LocationPanel.Visible = True

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Change Account", "The change account button was clicked.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)
        End If

        If e.CommandName = "CancelEvent" Then
            FormPanel.Visible = False
            CancelEventPanel.Visible = True

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Cancel Event", "The Yellow Cancel Event button was clecked.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)
        End If

        If e.CommandName = "EnableEvent" Then

            Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p).FirstOrDefault

            thisEvent.statusID = 4
            thisEvent.ModifiedDate = Date.Now()
            thisEvent.ModifiedBy = Context.User.Identity.GetUserId()
            db.SubmitChanges()

            Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "The event status was updated to Scheduled.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Event Status Updated", "The event status was updated to Scheduled.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            Response.Redirect("/Events/EventDetails?ID=" & Request.QueryString("EventID") & "&Action=1")
        End If

    End Sub

    Private Sub LogEvent(ByVal sender As Object, ByVal eventName As String, ByVal items As IEnumerable(Of RadListBoxItem))

        Dim affectedItems As New List(Of String)()

        For Each item As RadListBoxItem In items
            affectedItems.Add(item.Value)
        Next

        Dim message As String = String.Format("{0}", affectedItems.ToArray())
        HF_SelectedItemID.Value = message

    End Sub

    Protected Sub SelectedBrandsList_Inserted1(sender As Object, e As RadListBoxEventArgs)
        Try
            'get the brandID
            LogEvent(sender, "Inserted", e.Items)

            Dim eventID As Integer = Request.QueryString("EventID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'insert the item
            db.InsertEventBrand(eventID, selectedValue)
            db.SubmitChanges()

            msgLabel.Text = ""

            Dim InsertedBrandName = (From p In db.tblBrands Where p.brandID = selectedValue Select p.brandName).FirstOrDefault

            'set the event details with modified = true
            Dim NeedRefresh = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p).FirstOrDefault
            NeedRefresh.Modified = True
            db.SubmitChanges()


            Dim insertlog = db.InsertEventLog(Request.QueryString("EventID"), "Brand Inserted", InsertedBrandName & " was added to the event.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Brand Inserted", InsertedBrandName & " was added to the event.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub


    Protected Sub SelectedBrandsList_Deleted1(sender As Object, e As RadListBoxEventArgs)
        Try
            'get the brandID
            LogEvent(sender, "Deleted", e.Items)

            Dim eventID As Integer = Request.QueryString("EventID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'delete the item
            db.DeleteEventBrand(eventID, selectedValue)
            db.SubmitChanges()

            msgLabel.Text = ""

            Dim DeletedBrandName = (From p In db.tblBrands Where p.brandID = selectedValue Select p.brandName).FirstOrDefault

            'remove recap questions for the deleted brand
            '  Dim deleteRecap = db.DeleteBrandRecapQuestionsByEvent(eventID, selectedValue)

            Dim NeedRefresh = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p).FirstOrDefault
            NeedRefresh.Modified = True
            db.SubmitChanges()


            Dim insertlog = db.InsertEventLog(Request.QueryString("EventID"), "Brand Deleted", DeletedBrandName & " was deleted from the event.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Brand Deleted", DeletedBrandName & " was deleted from the event.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            Dim AssociatedBrandsList As RadListBox = CType(EditEventForm.FindControl("AssociatedBrandsList"), RadListBox)
            AssociatedBrandsList.DataBind()

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Function getBrandName(id As Integer) As String
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function

    Function getPPS(id As Integer) As String
        Dim pps = (From p In db.tblBrands Where p.brandID = id Select p.packageSize).FirstOrDefault

        If pps = "" Then
            Return "bottles"
        Else
            Return pps & " bottles"
        End If

    End Function

    Private Sub btnCancelLocation_Click(sender As Object, e As EventArgs) Handles btnCancelLocation.Click
        FormPanel.Visible = True
        LocationPanel.Visible = False
        ResultsPanel.Visible = False

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Change Account", "The cancel location button was clicked.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        MarketList.ClearSelection()
    End Sub

    Private Sub MarketList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles MarketList.SelectedIndexChanged

        Try

            For Each column As GridColumn In ResultsGrid.MasterTableView.Columns
                column.CurrentFilterFunction = GridKnownFunction.NoFilter
                column.CurrentFilterValue = [String].Empty
            Next

            ResultsGrid.MasterTableView.FilterExpression = [String].Empty
            ResultsGrid.MasterTableView.Rebind()

            ResultsGrid.Visible = True
            ResultsPanel.Visible = True


        Catch ex As Exception
            msgLabel.Text = ex.Message()
        End Try

    End Sub

    Private Sub ResultsGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ResultsGrid.ItemCommand
        If e.CommandName = "SelectAccount" Then

            Dim id As Integer = e.CommandArgument

            Dim newlocation = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p).FirstOrDefault

            newlocation.marketID = MarketList.SelectedValue
            newlocation.locationID = id

            db.SubmitChanges()


            Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p).FirstOrDefault

            Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Location", "The event location was changed.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Change Account", "The event location was changed.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            Response.Redirect("/Events/EditEvent?EventID=" & Request.QueryString("EventID") & "&Action=1" & "&#location")

        End If
    End Sub

    Private Sub btnConfirmCancel_Click(sender As Object, e As EventArgs) Handles btnConfirmCancel.Click

        Try
            If LastMinuteCheckBox.Checked Then

                db.sp_CancelEventLastMinute(Convert.ToInt32(Request.QueryString("EventID")), Context.User.Identity.GetUserId())

                'add to history log
                lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Cancel Event", "Cancel last minute check box was checked. Event status equal 6.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                'add to event log
                Dim insertlog = db.InsertEventLog(Request.QueryString("EventID"), "Event Status Updated", "The event status was updated to Cancelled Last Minute.", Context.User.Identity.GetUserId(), Date.Now())

            Else

                db.sp_CancelEvent(Convert.ToInt32(Request.QueryString("EventID")), Context.User.Identity.GetUserId())

                'add to history log
                lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Cancel Event", "Cancel last minute check box was NOT checked. Event status equal 3.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                'add to event log
                Dim insertlog = db.InsertEventLog(Request.QueryString("EventID"), "Event Status Updated", "The event status was updated to Cancelled.", Context.User.Identity.GetUserId(), Date.Now())

            End If

        Catch ex As Exception

            msgLabel2.Text = "There was a problem saving your changes.  Please try again."

            Exit Sub

        End Try



        Try
            If ExplainationTextBox.Text = "" Then

            Else

                Dim manager = New UserManager()
                Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

                Dim note As New tblEventNote

                note.eventID = Request.QueryString("EventID")
                note.note = ExplainationTextBox.Text
                note.createdBy = currentUser.Id
                note.dateCreated = Date.Now()

                db.tblEventNotes.InsertOnSubmit(note)
                db.SubmitChanges()


                Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p).FirstOrDefault

                Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Explaination Note", "The event status was updated to Cancelled and a note has been added.", Context.User.Identity.GetUserId(), Date.Now())

                'add to history log
                lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Cancel Event", "An Explaination Note has been added.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            End If


        Catch ex As Exception


        End Try


        Response.Redirect("/Events/EventDetails?ID=" & Request.QueryString("EventID") & "&Action=1")

    End Sub

    Private Sub btnCancelCancel_Click(sender As Object, e As EventArgs) Handles btnCancelCancel.Click

        FormPanel.Visible = True
        CancelEventPanel.Visible = False

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("EventID"), Date.Now(), "Cancel Event", "The cancel button was clicked.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

    End Sub

    'Private Sub LastMinuteCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles LastMinuteCheckBox.CheckedChanged

    '    If LastMinuteCheckBox.Checked Then
    '        WarningPanel.Visible = False
    '        DonePanel.Visible = True
    '    Else
    '        WarningPanel.Visible = True
    '        DonePanel.Visible = False
    '    End If

    'End Sub


    Public Sub generateDynamicControls()
        'get the fields from the supplierBudget type

        Dim supplierIDTextBox As DropDownList = CType(EditEventForm.FindControl("supplierIDTextBox"), DropDownList)

        Dim question = From p In db.qryGetSupplierBudgetQuestion_Answers Where p.supplierID = supplierIDTextBox.SelectedValue And p.eventID = Request.QueryString("EventID") Select p Order By p.sortOrder

        For Each p In question

            Select Case p.questionType
                Case "label"
                    CreateLabelControl(p.supplierBudgetQuestionID, p.question)

                Case "text"
                    CreateTextboxControl(p.supplierBudgetQuestionID, p.question, p.description, p.required, p.answer)

                Case "choice"
                    CreateComboboxControl(p.supplierBudgetQuestionID, p.question, p.answer, p.description, p.required, p.displayOption)

                Case "multiline"
                    CreateMultilineTextboxControl(p.supplierBudgetQuestionID, p.question, p.lines, p.description, p.required, p.answer)

                Case "number"
                    CreateNumberboxControl(p.supplierBudgetQuestionID, p.question, p.answer, p.numberDecimalPlace, p.required, p.description, p.showPercentage)

                Case "date"
                    CreateDateControl(p.supplierBudgetQuestionID, p.question, p.answer, p.required, p.description, p.dateFormat, p.dateDisplay)

                Case "time"
                    CreateTimeControl(p.supplierBudgetQuestionID, p.question, p.timeFormat)

                Case "currency"
                    CreateCurrencyControl(p.supplierBudgetQuestionID, p.question, p.answer)

                Case "yes/no"
                    CreateYesNoControl(p.supplierBudgetQuestionID, p.question, p.supplierBudgetQuestionID, p.description, p.answer)
            End Select



        Next

    End Sub

    Private Sub CreateLabelControl(id As String, labelText As String)

        Dim div As New HtmlGenericControl("div")

        Dim lbl As New HtmlGenericControl("h3")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        Dim SupplierBudgetPlaceHolder As PlaceHolder = CType(EditEventForm.FindControl("SupplierBudgetPlaceHolder"), PlaceHolder)

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

        Dim SupplierBudgetPlaceHolder As PlaceHolder = CType(EditEventForm.FindControl("SupplierBudgetPlaceHolder"), PlaceHolder)
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

        Dim SupplierBudgetPlaceHolder As PlaceHolder = CType(EditEventForm.FindControl("SupplierBudgetPlaceHolder"), PlaceHolder)
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

        Dim SupplierBudgetPlaceHolder As PlaceHolder = CType(EditEventForm.FindControl("SupplierBudgetPlaceHolder"), PlaceHolder)
        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateDateControl(id As String, labelText As String, dateValue As String, required As Boolean, description As String, format As String, display As String)

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
        div2.Attributes.Add("class", "col-sm-2")

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



        div.Controls.Add(div2)

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

        div2.Controls.Add(box)

        Dim SupplierBudgetPlaceHolder As PlaceHolder = CType(EditEventForm.FindControl("SupplierBudgetPlaceHolder"), PlaceHolder)
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

        Dim SupplierBudgetPlaceHolder As PlaceHolder = CType(EditEventForm.FindControl("SupplierBudgetPlaceHolder"), PlaceHolder)
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

        Dim SupplierBudgetPlaceHolder As PlaceHolder = CType(EditEventForm.FindControl("SupplierBudgetPlaceHolder"), PlaceHolder)
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

            Dim SupplierBudgetPlaceHolder As PlaceHolder = CType(EditEventForm.FindControl("SupplierBudgetPlaceHolder"), PlaceHolder)
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

        Dim SupplierBudgetPlaceHolder As PlaceHolder = CType(EditEventForm.FindControl("SupplierBudgetPlaceHolder"), PlaceHolder)
        SupplierBudgetPlaceHolder.Controls.Add(div)

    End Sub


End Class