Imports System.Data.SqlClient
Imports System.Drawing
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class EventScheduler
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        EventIDHiddenField.Value = Request.QueryString("ID")

        Dim q = (From p In db.getEventDetails Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        LatitudeTextBox.Value = q.latitude
        LongtitudeTextBox.Value = q.longitude
        LocationTextBox.Value = q.city & ", " & q.state

        AccountNameLabel1.Text = q.AccountName

        EventNameLabel.Text = q.eventTitle
        EventDateLabel.Text = String.Format("{0:D}", q.eventDate)
        EventIDLabel.Text = q.eventID


        '  CityLabel.Text = q.city & ", " & q.state

        AccountHyperLink1.NavigateUrl = "/Accounts/AccountDetails?AccountID=" & q.accountID

        AccountAddressLabel1.Text = String.Format("{0} {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)

        HF_MarketID.Value = q.marketID

        HF_ClientID.Value = Common.GetCurrentClientID()


        HF_PositionID.Value = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Select p.positionID).FirstOrDefault

        TotalSpendLabel.Text = String.Format("${0}", (From p In db.qryEventStaffingRequirementLists Where p.eventID = Request.QueryString("ID") Select p.Total).Sum)

        AvailableAmbassadorList.DataSourceID = "getAvailableAmbassadorList"

        'AvailableAmbassadorList.DataSource = GetAvailableAmbassadorTable()

        LookupAmbassadorText.DataSourceID = "getAvailableAmbassadorNameList"

        PositionList.DataSourceID = "getEventPositions"

        BindPositionCount()

        Dim dv As System.Data.DataView = DirectCast(getAvailableAmbassadorNameList.[Select](DataSourceSelectArguments.Empty), DataView)

        StaffCountLabel.Text = dv.Count.ToString()

        ' Dim i = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.invoiced).FirstOrDefault

        If hasInvoice() = False Then
            msgLabel1.ForeColor = Color.Red
            msgLabel1.Text = "<i class='fa fa-exclamation-triangle' aria-hidden='true'></i> This event has been invoiced.  Editing has been disabled."
            btnSaveChanges.Visible = False
            btnCancelChanges.Visible = False
        End If

        If Not Page.IsPostBack Then
            MarketComboBox.SelectedValue = q.marketID

            PositionComboBox.SelectedValue = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Select p.positionID).FirstOrDefault
        End If

    End Sub

    Private Sub btnSaveChanges_Click(sender As Object, e As EventArgs) Handles btnSaveChanges.Click

        msgLabel1.Text = Common.ShowAlert("success", "Change button clicked")

        Try

            Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

            Dim startTime As New RadDateTimePicker()
            Dim endTime As New RadDateTimePicker()
            Dim rate As New RadNumericTextBox()
            Dim HiddenField1 As New HiddenField

            Dim _eventDate As Date = thisEvent.eventDate

            Dim da = String.Format("{0}/{1}/{2} ", _eventDate.Month, _eventDate.Day, _eventDate.Year)

            For Each dataItem As RepeaterItem In PositionList.Items

                startTime = DirectCast(dataItem.FindControl("startTimeRadTimePicker"), RadDateTimePicker)
                endTime = DirectCast(dataItem.FindControl("endTimeRadTimePicker"), RadDateTimePicker)
                rate = DirectCast(dataItem.FindControl("RateTextBox"), RadNumericTextBox)
                HiddenField1 = DirectCast(dataItem.FindControl("HiddenField1"), HiddenField)

                Dim s As Date = endTime.SelectedDate
                Dim s1 As Date = startTime.SelectedDate

                Dim formatedEndDate = String.Format("{0} {1}: {2}", da, s.Hour, s.Minute)
                Dim formateStartDate = String.Format("{0} {1}:{2}", da, s1.Hour, s1.Minute)

                Dim d = db.UpdateEventStaffRequirement(HiddenField1.Value, startTime.SelectedDate, endTime.SelectedDate, rate.Text)
            Next

            msgLabel1.Text = Common.ShowAlert("success", "Changes saved successfully")

            PositionList.DataBind()

            TotalSpendLabel.Text = String.Format("${0}", (From p In db.qryEventStaffingRequirementLists Where p.eventID = thisEvent.eventID Select p.Total).Sum)


            Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Ambassadors Details", "The details for the ambassadors was changed.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Ambassadors Details", "The details for the ambassadors was changed.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        Catch ex As Exception
            msgLabel1.Text = ex.Message
        End Try

    End Sub
    Private Sub LookupAmbassadorText_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles LookupAmbassadorText.SelectedIndexChanged
        AvailableAmbassadorList.CurrentPageIndex = 0
        AvailableAmbassadorList.FilterExpressions.Clear()
        AvailableAmbassadorList.FilterExpressions.BuildExpression().Contains("userName", LookupAmbassadorText.SelectedValue).Build()
        AvailableAmbassadorList.Rebind()

    End Sub

    Private Sub btnClearFiltersAmbassador_Click(sender As Object, e As EventArgs) Handles btnClearFiltersAmbassador.Click

        AvailableAmbassadorList.CurrentPageIndex = 0
        AvailableAmbassadorList.FilterExpressions.Clear()
        LookupAmbassadorText.SelectedIndex = -1
        AvailableAmbassadorList.Rebind()

        LookupAmbassadorText.ClearSelection()
        LookupAmbassadorText.Text = String.Empty

        'LookupAmbassadorText.Items(0).Selected = True

    End Sub


    Protected Sub AvailableAmbassadorList_ItemDrop(ByVal sender As Object, ByVal e As RadListViewItemDragDropEventArgs) Handles AvailableAmbassadorList.ItemDrop

        Try
            For Each item As RepeaterItem In PositionList.Items

                Dim genreLink As LinkButton = TryCast(item.FindControl("GenreLink"), LinkButton)
                If genreLink IsNot Nothing AndAlso genreLink.ClientID = e.DestinationHtmlElement Then

                    Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

                    Dim userName As String = DirectCast(e.DraggedItem.GetDataKeyValue("userName"), String)
                    Dim title As String = e.DraggedItem.GetDataKeyValue("FirstName").ToString()
                    Dim requirementID As String = genreLink.CommandArgument

                    ResultsPanel.Controls.Add(New LiteralControl([String].Format("<div class='msg'><b>{0}</b> was assigned to the event.</div>", getFullName(userName))))

                    Dim paymentdate As DateTime = (From p In db.qryEventStaffingRequirements Where p.RequirementID = requirementID Select p.startTime).FirstOrDefault

                    Dim a = db.AssignStafftoEvent(requirementID, userName, paymentdate)

                    ' add to the log file
                    Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Ambassador Assigned", getFullName(userName) & " was assigned to the event.", Context.User.Identity.GetUserId(), Date.Now())

                    'add to history log
                    lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Ambassador Assigned", getFullName(userName) & " was assigned to the event.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)


                    'update the event
                    thisEvent.ModifiedDate = Date.Now()
                    db.SubmitChanges()


                    'assign to course
                    Try
                        Dim db1 As New LMSDataClassesDataContext
                        Dim r = From p In db.getCourseForEvents Where p.eventID = Request.QueryString("ID") Select p
                        For Each p In r
                            db1.AddStudentToCourse(userName, p.courseID)
                        Next
                    Catch ex As Exception

                    End Try



                    'send email if is not global admin role
                    Dim manager = New UserManager()
                    Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

                    'show/hide admin panels
                    If manager.IsInRole(currentUser.Id, "GlobalAdmin") Then


                    Else

                        'send email notification to the BA
                        Dim eventDetails = (From p In db.getEventDetails Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault
                        Dim ba = (From b In db.tblAmbassadors Where b.userName = userName Select b).FirstOrDefault

                        Dim m = (From p In db.tblMessages Where p.messageID = 3 Select p).FirstOrDefault

                        Dim myString As String = ""
                        myString = m.messageText
                        myString = myString.Replace("[FirstName]", ba.FirstName)
                        myString = myString.Replace("[LastName]", ba.LastName)
                        myString = myString.Replace("[EventCity]", eventDetails.city)
                        myString = myString.Replace("[EventState]", eventDetails.state)
                        myString = myString.Replace("[EventDate]", eventDetails.eventDate)
                        myString = myString.Replace("[EventStartTime]", String.Format("{0:t}", eventDetails.startTime))
                        myString = myString.Replace("[EventBrands]", (From i In db.qryGetBrandsInEvents Where i.eventID = Request.QueryString("ID") Select i.brands).FirstOrDefault)
                        myString = myString.Replace("[EventSupplier]", getSupplierName(eventDetails.supplierID))
                        myString = myString.Replace("[AssignedPosition]", getPositionName((From i In db.tblEventStaffingRequirements Where i.RequirementID = genreLink.CommandArgument Select i.positionID).FirstOrDefault))
                        myString = myString.Replace("[CheckInTime]", String.Format("{0:t}", (From i In db.tblEventStaffingRequirements Where i.RequirementID = genreLink.CommandArgument Select i.startTime).FirstOrDefault))
                        myString = myString.Replace("[LocationName]", eventDetails.AccountName)
                        myString = myString.Replace("[EventLinkURL]", "http://events.gigengyn.com/Events/EventDetails?ID=" & eventDetails.eventID)

                        Dim recipient = ba.EmailAddress

                        'send email
                        MailHelper.SendEmailMessage(3, recipient, m.fromAddress, m.fromName, m.subject, myString.ToString())

                    End If

                    Exit For
                End If

            Next


            'check if all positions are booked

            Dim thisEvent1 = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

            'get assignment count
            Dim positioncount = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Where p.assigned = True Select p).Count
            Dim assignedcount = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Select p).Count

            Dim status = thisEvent1.statusID
            If status = 2 Then
                'do nothing
                Exit Sub
            End If

            If status = 1 And positioncount > 0 Then
                If positioncount = assignedcount Then
                    'do nothing
                End If
            End If

            If status = 4 And positioncount > 0 Then
                If positioncount = assignedcount Then
                    'update status to booked

                    Try
                        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

                        thisEvent.statusID = 2
                        thisEvent.ModifiedDate = Date.Now()
                        db.SubmitChanges()

                        Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "A brand ambassador was added. The event status was updated to Booked.", Context.User.Identity.GetUserId(), Date.Now())

                        'add to history log
                        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Event Status Updated", "A brand ambassador was added. The event status was updated to Booked.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                        RadNotification1.Text = "The event status was updated to Booked."
                        RadNotification1.Show()
                        '   StatusLabel.Text = "Booked"

                    Catch ex As Exception

                    End Try

                End If
            End If

            If status = 2 And positioncount <> 0 Then
                If positioncount <> assignedcount Then
                    'update status to booked

                    Try
                        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

                        thisEvent.statusID = 4
                        thisEvent.ModifiedDate = Date.Now()
                        db.SubmitChanges()

                        Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "The event status was updated to Scheduled.", Context.User.Identity.GetUserId(), Date.Now())

                        'add to history log
                        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Event Status Updated", "The event status was updated to Scheduled.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                        RadNotification1.Text = "The event status was updated to Scheduled."
                        RadNotification1.Show()
                        ' StatusLabel.Text = "Scheduled"

                    Catch ex As Exception

                    End Try

                End If
            End If

            If status = 7 And positioncount > 0 Then
                If positioncount = assignedcount Then
                    'update status to booked

                    Try
                        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

                        thisEvent.statusID = 2
                        thisEvent.ModifiedDate = Date.Now()
                        db.SubmitChanges()

                        Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "A brand ambassador was added. The event status was updated to Booked.", Context.User.Identity.GetUserId(), Date.Now())

                        'add to history log
                        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Event Status Updated", "A brand ambassador was added. The event status was updated to Booked.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)


                    Catch ex As Exception

                    End Try
                End If
            End If



            'rebind data
            'CheckStatus()
            ' rebindData()


            '  StaffingList.DataBind()
            BindPositionCount()
            '  AvailableAmbassadorList.DataBind()
            PositionList.DataBind()
            ' BrandPositionList.DataBind()

            '  bindEvent()

        Catch ex As Exception
            trackErrorLabel.Text = ex.Message
        End Try

    End Sub

    Private Sub AvailableAmbassadorList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles AvailableAmbassadorList.ItemCommand

        Select Case e.CommandName
            Case "RemoveRequest"
                Try
                    'remove them
                    Dim userID As String = e.CommandArgument
                    Dim q = From p In db.tblAmbassadorEventRequests Where p.eventID = Convert.ToInt32(Request.QueryString("ID")) And p.userID = userID Select p

                    For Each p In q
                        p.requestStatus = 2
                        p.modifiedBy = Context.User.Identity.GetUserId()
                        p.modifiedDate = Date.Now()

                        db.SubmitChanges()
                    Next

                    AvailableAmbassadorList.DataBind()
                Catch ex As Exception
                    MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error", ex.Message & "<br>" & Request.QueryString("ID") & "<br>" & e.CommandArgument)
                End Try


        End Select

    End Sub

    Private Sub PositionList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles PositionList.ItemCommand

        Dim id As Integer = e.CommandArgument

        If e.CommandName = "Remove" Then

            '  RadNotification2.Show(e.CommandArgument)


            'send email if is not global admin role
            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            'show/hide admin panels
            If manager.IsInRole(currentUser.Id, "GlobalAdmin") Then


            Else

                ''send email to BA
                'Dim eventDetails = (From p In db.getEventDetails Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault
                'Dim ba = (From b In db.tblAmbassadors Where b.userName = id Select b).FirstOrDefault

                'Dim m = (From p In db.tblMessages Where p.messageID = 7 Select p).FirstOrDefault

                'Dim myString As String = ""
                'myString = m.messageText
                'myString = myString.Replace("[FirstName]", ba.FirstName)
                'myString = myString.Replace("[LastName]", ba.LastName)
                'myString = myString.Replace("[EventCity]", eventDetails.city)
                'myString = myString.Replace("[EventState]", eventDetails.state)
                'myString = myString.Replace("[EventDate]", eventDetails.eventDate)
                'myString = myString.Replace("[EventStartTime]", String.Format("{0}:t", eventDetails.startTime))
                'myString = myString.Replace("[EventBrands]", (From i In db.qryGetBrandsInEvents Where i.eventID = Request.QueryString("ID") Select i.brands).FirstOrDefault)
                'myString = myString.Replace("[SupplierName]", getSupplierName(eventDetails.supplierID))

                'myString = myString.Replace("[LocationName]", eventDetails.AccountName)
                'myString = myString.Replace("[EventLinkURL]", "http://events.gigengyn.com/Events/EventDetails?ID=" & eventDetails.eventID)

                'Dim recipient = ba.EmailAddress

                ''send email
                'MailHelper.SendEmailMessage(7, recipient, m.fromAddress, m.fromName, m.subject, myString.ToString())


            End If



            Dim q = db.RemoveStaffFromEvent(id)


            'check if all positions are booked

            Dim thisEvent1 = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

            'get assignment count
            Dim positioncount = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Where p.assigned = True Select p).Count
            Dim assignedcount = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Select p).Count

            Dim status = thisEvent1.statusID

            'update ststus to scheduled
            Try
                Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

                thisEvent.statusID = 4
                thisEvent.ModifiedDate = Date.Now()
                thisEvent.ModifiedBy = Context.User.Identity.GetUserId()
                db.SubmitChanges()

                Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "A brand ambassador was removed. The event status was updated to Scheduled.", Context.User.Identity.GetUserId(), Date.Now())

                'add to history log
                lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Event Status Updated", "A brand ambassador was removed. The event status was updated to Scheduled.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                RadNotification2.Text = "The event status was updated to Scheduled."

                RadNotification2.Show()

                ' StatusLabel.Text = "Scheduled"

            Catch ex As Exception

            End Try

            'send email to BA

            ' StaffingList.DataBind()
            BindPositionCount()
            AvailableAmbassadorList.DataBind()
            PositionList.DataBind()
            ' BrandPositionList.DataBind()


        End If
    End Sub
    Protected Sub cmbPageSize_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)

        AvailableAmbassadorList.PageSize = Integer.Parse(e.Value)
        AvailableAmbassadorList.CurrentPageIndex = 0
        AvailableAmbassadorList.Rebind()

    End Sub

    Sub BindPositionCount()
        Dim eventID = Request.QueryString("ID")

        '  positionsStaffedCountLabel.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = True Select p).Count
        ' positionsAvailableCountLabel.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = False Select p).Count

        positionsStaffedCountLabel2.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = True Select p).Count
        positionsAvailableCountLabel2.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = False Select p).Count

        '  positionsStaffedCountLabel3.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = True Select p).Count
        ' positionsAvailableCountLabel3.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = False Select p).Count

        HF_PositionID.Value = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID Select p.positionID).FirstOrDefault


    End Sub

    Protected Function CreateWindowScript(ByVal userID As String, ByVal image As Integer) As String
        Return String.Format("var win = window.radopen('/Profile_Image.aspx?image={1}&UserID={0}','Details');win.center();", userID, image)
    End Function

    Function getSupplierName(ByVal id As Integer) As String

        Return (From p In db.tblSuppliers Where p.supplierID = id Select p.supplierName).FirstOrDefault

    End Function

    Function checkSchedule(userID As String) As String

        'get event date
        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        Dim event_date As Date = thisEvent.eventDate

        Dim q = (From p In db.getScheduleConflicts Where p.userID = userID And p.eventDate = event_date Select p).Count

        Dim IsAssigned = (From p In db.getScheduleConflicts Where p.userID = userID And p.eventDate = event_date And p.eventID = thisEvent.eventID Select p).Count

        If IsAssigned > 0 Then
            Return "<span class='label label-success'>Assigned to this event</span>"
            Exit Function
        End If

        If q = 0 Then
            'return nothing
        Else

            Return "<span class='label label-danger'>There is a potential conflict</span>"
        End If

    End Function

    Function getFullName(username As String) As String
        If username = "Not Staffed" Then
            Return "<span class='label label-danger'>Not Staffed</span>"
        Else
            Dim userid = (From p In lmsdb.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault

            Dim first_name = (From p In db.tblAmbassadors Where p.userID = userid Select p.FirstName).FirstOrDefault
            Dim last_name = (From p In db.tblAmbassadors Where p.userID = userid Select p.LastName).FirstOrDefault

            Return first_name & " " & last_name
        End If

    End Function

    Function getPositionName(ByVal positionID As Integer) As String
        Return (From p In db.tblStaffingPositions Where p.staffingPositionID = positionID Select p.positionTitle).FirstOrDefault
    End Function

    Function getAssigned(assigned As String) As Boolean

        If assigned = "True" Then
            Return True
        End If

        If assigned = "False" Then
            Return False
        End If

#Disable Warning BC42353 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42353 ' Function doesn't return a value on all code paths

    Function getNotAssigned(assigned As String) As Boolean

        If assigned = "False" Then
            Return True
        Else
            Return False
        End If
    End Function

    Function getTotalPay(id As Integer) As String

        Dim db As New DataClassesDataContext

        Return String.Format("{0:C}", (From p In db.viewEventStaffingRequirements Where p.requirementID = id Select p.Total).FirstOrDefault)
    End Function


    Public Function hasInvoice() As Boolean

        Dim i = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.invoiced).FirstOrDefault

        If i = True Then

            Dim _invoiceID = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.invoiceID).FirstOrDefault

            Dim InvoiceStatus = (From p In db.tblInvoices Where p.invoiceID = _invoiceID Select p.status).FirstOrDefault

            If InvoiceStatus = "Open" Or InvoiceStatus = "Draft" Then
                Return True
            Else
                Return False
            End If

        Else
            Return True
        End If

    End Function

    Private Sub MarketComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles MarketComboBox.SelectedIndexChanged

        HF_MarketID.Value = MarketComboBox.SelectedValue
        HF_PositionID.Value = PositionComboBox.SelectedValue


    End Sub

    Private Sub PositionComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles PositionComboBox.SelectedIndexChanged

        HF_MarketID.Value = MarketComboBox.SelectedValue
        HF_PositionID.Value = PositionComboBox.SelectedValue


    End Sub

    Private Sub btnExportExcel_Click(sender As Object, e As EventArgs) Handles btnExportExcel.Click

        AmbassaodrEmailListGrid.DataSource = GetEmailListDataTable()
        AmbassaodrEmailListGrid.DataBind()


        AmbassaodrEmailListGrid.ExportSettings.ExportOnlyData = False
        AmbassaodrEmailListGrid.ExportSettings.IgnorePaging = True
        AmbassaodrEmailListGrid.ExportSettings.OpenInNewWindow = True
        AmbassaodrEmailListGrid.ExportSettings.UseItemStyles = False
        AmbassaodrEmailListGrid.ExportSettings.FileName = "MailingList"
        'EventDataGrid.MasterTableView.GetColumn("ViewButton").Visible = False
        AmbassaodrEmailListGrid.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

        AmbassaodrEmailListGrid.MasterTableView.ExportToExcel()

    End Sub

    Public Function GetEmailListDataTable() As DataTable

        Dim query As String = "getAvailableAmbassadorNameList"

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()
        adapter.SelectCommand = New SqlCommand(query, conn)

        adapter.SelectCommand.CommandType = CommandType.StoredProcedure

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@lat", SqlDbType.NVarChar))
        adapter.SelectCommand.Parameters("@lat").Value = LatitudeTextBox.Value

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@long", SqlDbType.NVarChar))
        adapter.SelectCommand.Parameters("@long").Value = LongtitudeTextBox.Value

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@marketID", SqlDbType.Int))
        adapter.SelectCommand.Parameters("@marketID").Value = MarketComboBox.SelectedValue

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@positionID", SqlDbType.Int))
        adapter.SelectCommand.Parameters("@positionID").Value = PositionComboBox.SelectedValue

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@eventID", SqlDbType.Int))
        adapter.SelectCommand.Parameters("@eventID").Value = Request.QueryString("ID")


        Dim myDataTable As New DataTable()

        conn.Open()
        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function


End Class