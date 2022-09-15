Imports Microsoft.AspNet.Identity
Imports System.Data.SqlClient
Imports Telerik.Web.UI

Imports System.Data

Imports System.Net
Imports System.Web.Script.Serialization
Imports Microsoft.AspNet.Identity.EntityFramework
Imports iTextSharp.text.pdf
Imports iTextSharp.text
Imports System.IO

Public Class UserManager
    Inherits UserManager(Of ApplicationUser)
    Public Sub New()
        MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
    End Sub
End Class

Public Class StaffingControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext
    Dim users As New LMSDataClassesDataContext

    Protected Function CreateWindowScript(ByVal userID As String, ByVal image As Integer) As String
        Return String.Format("var win = window.radopen('/Profile_Image.aspx?image={1}&UserID={0}','Details');win.center();", userID, image)
    End Function

    Protected Function CreateReceiptScript(ByVal eventExpenseID As Integer) As String
        Return String.Format("var win = window.radopen('/Receipt_Image.aspx?eventExpenseID={0}','Details');win.center();", eventExpenseID)
    End Function

    Protected Function CreateWindowScript2(ByVal userID As String)

        Return String.Format("var win = window.radopen('/Events/BrandAmbassadorsDetails?UserID={0}', 'RadWindow1');win.center();", userID)

    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim Ambassador = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault


        'show/hide admin panels
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Then
            assignTab.Visible = False
            requirementsTab.Visible = False
            payrollTab.Visible = False
        End If

        'bind positions available
        If Not Page.IsPostBack Then
            BindPositionCount()
        End If

        Dim account = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.locationID).FirstOrDefault

        HF_Latitude.Value = (From p In db.tblAccounts Where p.Vpid = account Select p.latitude).FirstOrDefault
        HF_Longtitude.Value = (From p In db.tblAccounts Where p.Vpid = account Select p.longitude).FirstOrDefault

        RequirementsStartTimeLabel.Text = String.Format("{0:t}", (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.startTime).FirstOrDefault)
        RequirementsEndTimeLabel.Text = String.Format("{0:t}", (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.endTime).FirstOrDefault)
        RequirementsEventDateLabel.Text = String.Format("{0:D}", (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.eventDate).FirstOrDefault)

        startTimeLabel.Text = String.Format("{0:t}", (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.startTime).FirstOrDefault)
        endTimeLabel.Text = String.Format("{0:t}", (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.endTime).FirstOrDefault)
        eventDateLabel.Text = String.Format("{0:D}", (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.eventDate).FirstOrDefault)
        Try

            HF_ClientID.Value = "18"

            HF_MarketID.Value = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.marketID).FirstOrDefault

            TotalSpendLabel.Text = "$" & (From p In db.qryEventStaffingRequirementLists Where p.eventID = Request.QueryString("ID") Select p.Total).Sum


            Dim dv As System.Data.DataView = DirectCast(getAvailableAmbassadorList.[Select](DataSourceSelectArguments.Empty), DataView)
            StaffCountLabel.Text = dv.Count.ToString()
        Catch ex As Exception

        End Try



        Dim hasAmbassadorAssigned As Integer = db.ViewPayrollSummaryByEvent(Request.QueryString("ID")).Count

        If hasAmbassadorAssigned = 0 Then
            ExpensePanel.Visible = False
        End If
    End Sub

    Function setImage(id As String) As Boolean
        If id = "" Then Return False Else Return True
    End Function
    Function checkSchedule(userID As String) As String

        'get event date
        Dim event_date As Date = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.eventDate).FirstOrDefault

        Dim q = (From p In db.getScheduleConflicts Where p.userID = userID And p.eventDate = event_date Select p).Count

        Dim thisevent = (From p In db.getScheduleConflicts Where p.userID = userID And p.eventDate = event_date And p.eventID = Request.QueryString("ID") Select p).Count

        If thisevent > 0 Then
            Return "<span class='label label-success'>Assigned to this event</span>"
            Exit Function
        End If

        If q = 0 Then
            'return nothing
        Else

            Return "<span class='label label-danger'>There is a potential conflict</span>"
        End If




    End Function

    Protected Sub cmbPageSize_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)

        AvailableAmbassadorList.PageSize = Integer.Parse(e.Value)
        AvailableAmbassadorList.CurrentPageIndex = 0
        AvailableAmbassadorList.Rebind()

    End Sub


    Sub BindPositionCount()
        positionsStaffedCountLabel.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") And p.assigned = True Select p).Count
        positionsAvailableCountLabel.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") And p.assigned = False Select p).Count

        positionsStaffedCountLabel2.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") And p.assigned = True Select p).Count
        positionsAvailableCountLabel2.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") And p.assigned = False Select p).Count

        positionsStaffedCountLabel3.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") And p.assigned = True Select p).Count
        positionsAvailableCountLabel3.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") And p.assigned = False Select p).Count

        HF_PositionID.Value = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Select p.positionID).FirstOrDefault

    End Sub

    Function getPositionName(ByVal positionID As Integer) As String
        Return (From p In db.tblStaffingPositions Where p.staffingPositionID = positionID Select p.positionTitle).FirstOrDefault
    End Function

    Private Sub getEventPositions_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getEventPositions.Inserting

        Try
            Dim l As tblEventStaffingRequirement
            l = CType(e.NewObject, tblEventStaffingRequirement)
            l.eventID = Request.QueryString("ID")
            l.assigned = False
            l.rate = (From p In db.tblStaffingPositions Where p.staffingPositionID = l.positionID Select p.payRate).FirstOrDefault
        Catch ex As Exception
            MsgLabel.Text = ex.Message
        End Try


    End Sub

    Private Sub getEventPositions_Inserted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getEventPositions.Inserted
        Dim newPosition As tblEventStaffingRequirement
        newPosition = CType(e.Result, tblEventStaffingRequirement)

        Dim positionName = (From p In db.tblStaffingPositions Where p.staffingPositionID = newPosition.positionID Select p.positionTitle).FirstOrDefault

        Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Staffing Inserted", positionName & " was added to the event staffing requirements.", Context.User.Identity.GetUserId(), Date.Now())

        HF_PositionID.Value = newPosition.positionID

        rebindData()

    End Sub

    Private Sub getEventPositions_Deleted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getEventPositions.Deleted
        rebindData()

    End Sub

    Function getButtonText(id As Integer) As String
        Return (From p In db.qryEventStaffingRequirements Where p.RequirementID = id Select p.buttonText).First
    End Function

    Function getButtonEnabled(id As Integer) As Boolean
        Return (From p In db.qryEventStaffingRequirements Where p.RequirementID = id Select p.buttonEnabled).First
    End Function

    Function getButtonCssClass(id As Integer) As String
        Return (From p In db.qryEventStaffingRequirements Where p.RequirementID = id Select p.buttonCssClass).First
    End Function

    Function getFullName(username As String) As String
        If username = "Not Staffed" Then
            Return "<span class='label label-danger'>Not Staffed</span>"
        Else
            Dim userid = (From p In users.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault

            Dim first_name = (From p In db.tblAmbassadors Where p.userID = userid Select p.FirstName).FirstOrDefault
            Dim last_name = (From p In db.tblAmbassadors Where p.userID = userid Select p.LastName).FirstOrDefault

            Return first_name & " " & last_name
        End If


    End Function

    Function enableThumbnail(username As String) As String
        If username = "Not Staffed" Then
            Return "False"

        Else
            Return "True"
        End If
    End Function

    'Function getProfileImage(username As String) As String
    '    Dim userid = (From p In users.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault

    '    Return (From p In users.AspNetUsersProfiles Where p.UserID = userid Select p.PhotoUrl).FirstOrDefault
    'End Function

    Private Sub StaffingList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles StaffingList.ItemDataBound

        If (e.Item.ItemType = ListItemType.Item) Or
            (e.Item.ItemType = ListItemType.AlternatingItem) Then


            Dim AssignedNameLabel As Label = CType(e.Item.FindControl("AssignedNameLabel"), Label)
            Dim AssignedNameLink As HyperLink = CType(e.Item.FindControl("AssignedNameLink"), HyperLink)

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            Dim HiddenUserID As Label = CType(e.Item.FindControl("HiddenUserID"), Label)

            If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Then
                AssignedNameLabel.Visible = True
                AssignedNameLink.Visible = False
            End If

            If manager.IsInRole(currentUser.Id, "Accounting") Or manager.IsInRole(currentUser.Id, "Administrator") Or manager.IsInRole(currentUser.Id, "EventManager") Or manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
                AssignedNameLabel.Visible = False
                AssignedNameLink.Visible = True

                AssignedNameLink.NavigateUrl = "/ambassadors/ViewAmbassadorDetails?UserID=" & HiddenUserID.Text

            End If

        End If



        If StaffingList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If

    End Sub

    Private Sub btnSaveChanges_Click(sender As Object, e As EventArgs) Handles btnSaveChanges.Click

        Try
            Dim startTime As New RadTimePicker()
            Dim endTime As New RadTimePicker()
            Dim rate As New TextBox()
            Dim HiddenField1 As New HiddenField

            For Each dataItem As RepeaterItem In PositionList.Items

                startTime = DirectCast(dataItem.FindControl("RadTimePicker1"), RadTimePicker)
                endTime = DirectCast(dataItem.FindControl("RadTimePicker2"), RadTimePicker)
                rate = DirectCast(dataItem.FindControl("txtRate"), TextBox)
                HiddenField1 = DirectCast(dataItem.FindControl("HiddenField1"), HiddenField)


                Dim d = db.UpdateEventStaffRequirement(HiddenField1.Value, startTime.SelectedDate, endTime.SelectedDate, rate.Text)
            Next

            MsgLabel.Text = Common.ShowAlert("success", "Changes saved successfully")

            rebindData()

            TotalSpendLabel.Text = "$" & (From p In db.qryEventStaffingRequirementLists Where p.eventID = Request.QueryString("ID") Select p.Total).Sum

        Catch ex As Exception
            MsgLabel.Text = ex.Message
        End Try

    End Sub

    Function getTotalPay(id As Integer) As String

        Dim db As New DataClassesDataContext

        Return "$" & (From p In db.vewEventStaffingRequirements Where p.requirementID = id Select p.Total).FirstOrDefault
    End Function

    Function getTotalDue(id As Integer) As String

    End Function


    Function getUserID(username As String) As String
        Dim userdb As New LMSDataClassesDataContext

        Return (From p In userdb.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault
    End Function

    Protected ReadOnly Property TrackManager() As TrackManager

        Get

            If Session("_trackManager") Is Nothing OrElse Not Page.IsPostBack Then
                Dim manager As New TrackManager()
                manager.LoadTrackData()
                Session("_trackManager") = manager
            End If

            Return DirectCast(Session("_trackManager"), TrackManager)

        End Get

    End Property

    Protected Sub AvailableAmbassadorList_ItemDrop(ByVal sender As Object, ByVal e As RadListViewItemDragDropEventArgs) Handles AvailableAmbassadorList.ItemDrop

        'If e.DestinationHtmlElement.IndexOf("GenreLink") < 0 Then

        '    Return

        'End If
        Try
            For Each item As RepeaterItem In PositionList.Items

                Dim genreLink As LinkButton = TryCast(item.FindControl("GenreLink"), LinkButton)
                If genreLink IsNot Nothing AndAlso genreLink.ClientID = e.DestinationHtmlElement Then


                    Dim userId As String = DirectCast(e.DraggedItem.GetDataKeyValue("userName"), String)
                    Dim title As String = e.DraggedItem.GetDataKeyValue("FirstName").ToString()
                    Dim requirementID As String = genreLink.CommandArgument

                    ResultsPanel.Controls.Add(New LiteralControl([String].Format("<div class='msg'><b>{0}</b> was assigned to the event.</div>", getFullName(userId))))

                    ' If genreLink IsNot Nothing AndAlso genreLink.ClientID = e.DestinationHtmlElement Then

                    Dim paymentdate As DateTime = (From p In db.qryEventStaffingRequirements Where p.RequirementID = requirementID Select p.startTime).FirstOrDefault
                    Dim a = db.AssignStafftoEvent(requirementID, userId, paymentdate)

                    ' add to the log file

                    Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Ambassador Assigned", getFullName(userId) & " was assigned to the event.", Context.User.Identity.GetUserId(), Date.Now())

                    Exit For
                End If

            Next

            'rebind data
            rebindData()

        Catch ex As Exception
            trackErrorLabel.Text = ex.Message
        End Try

    End Sub

    Sub rebindData()

        StaffingList.DataBind()
        BindPositionCount()
        AvailableAmbassadorList.DataBind()
        PositionList.DataBind()
        BrandPositionList.DataBind()
        PayrollList.DataBind()
        ExpenseList.DataBind()


        '  GetEventStaff2.DataBind()
        '  getEventPositions.DataBind()





    End Sub

    Function getAssigned(assigned As String) As Boolean

        If assigned = "True" Then
            Return True
        End If

        If assigned = "False" Then
            Return False
        End If

    End Function

    Function getNotAssigned(assigned As String) As Boolean

        If assigned = "False" Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Sub PositionList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles PositionList.ItemCommand

        Dim id As Integer = e.CommandArgument

        If e.CommandName = "Remove" Then

            Dim q = db.RemoveStaffFromEvent(id)

            rebindData()
        End If
    End Sub

    Protected Sub btnShowAll_Click(ByVal sender As Object, ByVal e As EventArgs)

        AvailableAmbassadorList.FilterExpressions.Clear()
        AvailableAmbassadorList.Rebind()

    End Sub


    Protected Function SetPagerText(ByVal container As RadDataPagerFieldItem) As String

        Dim nextPageStartItemIndex As Integer = container.Owner.StartRowIndex + container.Owner.PageSize



        If container.Owner.TotalRowCount > 0 Then

            If nextPageStartItemIndex > container.Owner.TotalRowCount Then

                nextPageStartItemIndex = container.Owner.TotalRowCount



            End If

        ElseIf container.Owner.TotalRowCount = 0 Then

            nextPageStartItemIndex = 0

        End If



        Return nextPageStartItemIndex.ToString()

    End Function

    Private Sub AvailableAmbassadorList_DataBound(sender As Object, e As EventArgs) Handles AvailableAmbassadorList.DataBound
        'If Not IsPostBack Then

        '    FillFieldCombo(DirectCast(getAvailableAmbassadorList.Select(New System.Web.UI.DataSourceSelectArguments()), DataView))

        'End If
    End Sub

    Private Sub BrandPositionList_ItemCreated(sender As Object, e As RadListViewItemEventArgs) Handles BrandPositionList.ItemCreated

        If TypeOf e.Item Is RadListViewInsertItem AndAlso e.Item.IsInEditMode Then

            'get the event start and finish times
            Dim eventid As Integer = Request.QueryString("ID")

            Dim _startTime As Date = (From p In db.tblEvents Where p.eventID = eventid Select p.startTime).FirstOrDefault
            Dim _endTime As Date = (From p In db.tblEvents Where p.eventID = eventid Select p.endTime).FirstOrDefault

            Dim RadTimePicker12 As RadTimePicker = TryCast(e.Item.FindControl("RadTimePicker12"), RadTimePicker)
            Dim RadTimePicker22 As RadTimePicker = TryCast(e.Item.FindControl("RadTimePicker22"), RadTimePicker)

            RadTimePicker12.DbSelectedDate = _startTime
            RadTimePicker22.DbSelectedDate = _endTime
        End If

    End Sub

    Private Sub btnSearchAmbassador_Click(sender As Object, e As EventArgs) Handles btnSearchAmbassador.Click

        AvailableAmbassadorList.CurrentPageIndex = 0
        AvailableAmbassadorList.FilterExpressions.Clear()
        AvailableAmbassadorList.FilterExpressions.BuildExpression().Contains("FullName", txtSearchBox.Text).Build()
        AvailableAmbassadorList.Rebind()
    End Sub

    Private Sub btnClearFiltersAmbassador_Click(sender As Object, e As EventArgs) Handles btnClearFiltersAmbassador.Click

        AvailableAmbassadorList.CurrentPageIndex = 0
        AvailableAmbassadorList.FilterExpressions.Clear()
        txtSearchBox.Text = ""
        AvailableAmbassadorList.Rebind()

    End Sub

    'Protected Sub btnDetails_Click(sender As Object, e As EventArgs)
    '    String.Format("var win = window.open('/Events/BrandAmbassadorsDetails?UserID={0}.aspx', '_blank', 'location=0,menubar=0,status=0,scrollbars=0,resizable=yes,width=650px,height=650px');", Request.QueryString("UserID"))
    'End Sub

    Protected Function btnDetails_Click(sender As Object, e As EventArgs) As String
        Return String.Format("javascript:void(window.open('/Events/BrandAmbassadorsDetails?UserID={0}.aspx', '_blank', 'location=0,menubar=0,status=0,scrollbars=0,resizable=yes,width=650px,height=650px'));", Request.QueryString("UserID"))
    End Function
End Class
