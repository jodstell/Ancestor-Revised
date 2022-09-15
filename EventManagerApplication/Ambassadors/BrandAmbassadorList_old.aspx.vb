Imports Telerik.Web.UI
Imports System.Globalization
Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.IO
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Public Class BrandAmbassadorList
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim db1 As New DataClassesDataContext


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            'Dim mapLayer As MapLayer = GetMapLayer()
            'RadMap1.LayersCollection.Clear()
            'RadMap1.LayersCollection.Add(mapLayer)

            'Dim q = From p In db1.GetAmbassadorMaps Select p

            'RadMap1.DataSource = q
            'RadMap1.CenterSettings.Latitude = "39.639537564366705"
            'RadMap1.CenterSettings.Longitude = "-92.548828125"
            'RadMap1.Zoom = "4"

            'RadMap1.DataBind()

            AmbassadorCountLabel.Text = String.Format("Ambassador Count: {0}", (From p In db1.GetAmbassadorMaps Select p).Count)

        End If



        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Agency") Then
            Response.Redirect("/AccessDenied")
        End If

        Dim action = Request.QueryString("action")

        Select Case action
            Case 0
            Case 1
                msgLabel.Text = Common.ShowAlert("success", "The ambassador was added successfully!")
        End Select

    End Sub

    Private Sub MarketRadComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles MarketRadComboBox.SelectedIndexChanged

        RadioButtonLayers.ClearSelection()

        If MarketRadComboBox.SelectedValue = "0" And PositionRadComboBox.SelectedValue = "0" Then

            Dim q = From p In db1.GetAmbassadorMaps Select p

            RadMap1.DataSource = q
            RadMap1.CenterSettings.Latitude = "39.639537564366705"
            RadMap1.CenterSettings.Longitude = "-92.548828125"
            RadMap1.Zoom = "4"

            RadMap1.DataBind()

            AmbassadorCountLabel.Text = String.Format("Ambassador Count: {0}", (From p In db1.GetAmbassadorMaps Select p).Count)

            Exit Sub
        End If


        If PositionRadComboBox.SelectedValue = "0" Then
            Dim pid As System.Nullable(Of Integer)
            Dim q1 = From p In db1.GetAmbassadorForAmbassadorMap(MarketRadComboBox.SelectedValue, pid)

            RadMap1.DataSource = q1
            RadMap1.CenterSettings.Latitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.latitude).FirstOrDefault
            RadMap1.CenterSettings.Longitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.longitude).FirstOrDefault
            RadMap1.Zoom = "7"
            RadMap1.DataBind()

            AmbassadorCountLabel.Text = String.Format("Ambassador Count: {0}", (From p In db1.GetAmbassadorForAmbassadorMap(MarketRadComboBox.SelectedValue, pid) Select p).Count)

            Exit Sub
        End If

        If MarketRadComboBox.SelectedValue = "0" Then
            Dim pid As System.Nullable(Of Integer)
            Dim q2 = From p In db1.GetAmbassadorForAmbassadorMap(pid, PositionRadComboBox.SelectedValue)

            RadMap1.DataSource = q2
            RadMap1.CenterSettings.Latitude = "39.639537564366705"
            RadMap1.CenterSettings.Longitude = "-92.548828125"
            RadMap1.Zoom = "4"
            RadMap1.DataBind()

            Exit Sub
        End If

        Dim q3 = From p In db1.GetAmbassadorForAmbassadorMap(MarketRadComboBox.SelectedValue, PositionRadComboBox.SelectedValue)

        RadMap1.DataSource = q3

        RadMap1.CenterSettings.Latitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.latitude).FirstOrDefault
        RadMap1.CenterSettings.Longitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.longitude).FirstOrDefault
        RadMap1.Zoom = "7"
        RadMap1.DataBind()

        AmbassadorCountLabel.Text = String.Format("Ambassador Count: {0}", (From p In db1.GetAmbassadorForAmbassadorMap(MarketRadComboBox.SelectedValue, PositionRadComboBox.SelectedValue) Select p).Count)

    End Sub

    Private Sub PositionRadComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles PositionRadComboBox.SelectedIndexChanged

        RadioButtonLayers.ClearSelection()

        If MarketRadComboBox.SelectedValue = "0" And PositionRadComboBox.SelectedValue = "0" Then

            Dim q = From p In db1.GetAmbassadorMaps Select p

            RadMap1.DataSource = q
            RadMap1.CenterSettings.Latitude = "39.639537564366705"
            RadMap1.CenterSettings.Longitude = "-92.548828125"
            RadMap1.Zoom = "4"

            RadMap1.DataBind()

            AmbassadorCountLabel.Text = String.Format("Ambassador Count: {0}", (From p In db1.GetAmbassadorMaps Select p).Count)

            Exit Sub

        End If

        If MarketRadComboBox.SelectedValue = "0" Then
            Dim pid As System.Nullable(Of Integer)
            Dim q = From p In db1.GetAmbassadorForAmbassadorMap(pid, PositionRadComboBox.SelectedValue)

            RadMap1.DataSource = q
            RadMap1.CenterSettings.Latitude = "39.639537564366705"
            RadMap1.CenterSettings.Longitude = "-92.548828125"
            RadMap1.Zoom = "4"
            RadMap1.DataBind()

            AmbassadorCountLabel.Text = String.Format("Ambassador Count: {0}", (From p In db1.GetAmbassadorForAmbassadorMap(pid, PositionRadComboBox.SelectedValue) Select p).Count)

            Exit Sub
        End If

        If PositionRadComboBox.SelectedValue = "0" Then
            Dim pid As System.Nullable(Of Integer)
            Dim q1 = From p In db1.GetAmbassadorForAmbassadorMap(MarketRadComboBox.SelectedValue, pid)

            RadMap1.DataSource = q1
            RadMap1.CenterSettings.Latitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.latitude).FirstOrDefault
            RadMap1.CenterSettings.Longitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.longitude).FirstOrDefault
            RadMap1.Zoom = "7"
            RadMap1.DataBind()

            AmbassadorCountLabel.Text = String.Format("Ambassador Count: {0}", (From p In db1.GetAmbassadorForAmbassadorMap(MarketRadComboBox.SelectedValue, pid) Select p).Count)


            Exit Sub
        End If

        Dim q3 = From p In db1.GetAmbassadorForAmbassadorMap(MarketRadComboBox.SelectedValue, PositionRadComboBox.SelectedValue)

        RadMap1.DataSource = q3

        RadMap1.CenterSettings.Latitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.latitude).FirstOrDefault
        RadMap1.CenterSettings.Longitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.longitude).FirstOrDefault
        RadMap1.Zoom = "7"
        RadMap1.DataBind()

        AmbassadorCountLabel.Text = String.Format("Ambassador Count: {0}", (From p In db1.GetAmbassadorForAmbassadorMap(MarketRadComboBox.SelectedValue, PositionRadComboBox.SelectedValue) Select p).Count)



    End Sub



    Protected Sub RadioButtonLayers_SelectedIndexChanged(sender As Object, e As EventArgs)

        Select Case RadioButtonLayers.SelectedValue
            Case "accounts"
                Dim q = From p In db1.GetAmbassadorbyMarketID_withAccounts(MarketRadComboBox.SelectedValue)

                RadMap1.DataSource = q
                RadMap1.CenterSettings.Latitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.latitude).FirstOrDefault
                RadMap1.CenterSettings.Longitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.longitude).FirstOrDefault
                RadMap1.Zoom = "7"
                RadMap1.DataBind()

            Case "scheduledEvents"
                Dim q = From p In db1.GetAmbassadorbyMarketID_withScheduledEvents(MarketRadComboBox.SelectedValue)

                RadMap1.DataSource = q
                RadMap1.CenterSettings.Latitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.latitude).FirstOrDefault
                RadMap1.CenterSettings.Longitude = (From p In db1.tblMarkets Where p.marketID = MarketRadComboBox.SelectedValue Select p.longitude).FirstOrDefault
                RadMap1.Zoom = "7"
                RadMap1.DataBind()
        End Select


    End Sub



    Private Function GetMapLayer() As MapLayer

        Dim provider As String = "Bing"
        Dim providerName As String = "Bing"

        Dim mapLayer As MapLayer = New MapLayer

        If Not provider = "Bing" Then
            mapLayer.Type = Map.LayerType.Tile
            mapLayer.UrlTemplate = provider

            Select Case providerName
                Case "OpenStreetMap"
                    mapLayer.Attribution = "&copy; <a href='http://www.openstreetmap.org' title='OpenStreetMap contributors' target='_blank'>OpenStreetMap contributors</a>."

                Case "OpenCycleMap"
                    mapLayer.Attribution = "&copy; <a href='http://www.opencyclemap.org/' title='OpenCycleMap contributors' target='_blank'>OpenCycleMap contributors</a>."

                Case "ThunderForest"
                    mapLayer.Attribution = "&copy; <a href='http://www.thunderforest.com/' title='ThunderForest contributors' target='_blank'>ThunderForest contributors</a>."

                Case Else

                    Exit Select

            End Select

        Else

            mapLayer.Type = Map.LayerType.Bing

            mapLayer.Key = ConfigurationManager.AppSettings.Get("BingMapsAPIKey").ToString() ' The key used for a local demo on your end should be provided by Microsoft as described in the description of this demo

        End If

        Return mapLayer

    End Function

    Function CountPending() As String

        Dim q = (From p In db.AspNetUsersProfiles Where p.SiteID = getSiteID() And p.Status = "Invitation Sent" Select p).Count

        Return q
    End Function

    Function CountActive() As String

        Dim q = (From p In db.StudentDetails Where p.SiteID = getSiteID() And p.Status = "Active" Select p).Count

        Return q
    End Function

    Function CountLocked() As String

        Dim q = (From p In db.StudentDetails Where p.SiteID = getSiteID() And p.Status = "Locked" Select p).Count

        Return q
    End Function


    Private Sub RadScheduler1_AppointmentDataBound(sender As Object, e As SchedulerEventArgs) Handles RadScheduler1.AppointmentDataBound
        If e.Appointment.Resources.GetResourceByType("StatusName") <> Nothing Then
            Select Case e.Appointment.Resources.GetResourceByType("StatusName").Text
                Case "Requested"
                    e.Appointment.CssClass = "rsRequested"
                    Exit Select
                Case "Scheduled"
                    e.Appointment.CssClass = "rsScheduled"
                    Exit Select
                Case "Booked"
                    e.Appointment.CssClass = "rsBooked"
                    Exit Select
                Case "Cancelled"
                    e.Appointment.CssClass = "rsCancelled"
                    Exit Select
                Case "Toplined"
                    e.Appointment.CssClass = "rsToplined"
                    Exit Select
                Case "Approved"
                    e.Appointment.CssClass = "rsApproved"
                    Exit Select
                Case Else
                    Exit Select
            End Select
        End If

        e.Appointment.Visible = False
        FilterAppointment(e.Appointment, ApprovedCheckBox, 1)
        FilterAppointment(e.Appointment, ScheduledCheckBox, 4)
        FilterAppointment(e.Appointment, BookedCheckBox, 2)
        FilterAppointment(e.Appointment, RequestedCheckBox, 7)
        FilterAppointment(e.Appointment, CancelledCheckBox, 3)
        FilterAppointment(e.Appointment, ToplinedCheckBox, 5)

        e.Appointment.ToolTip = e.Appointment.Description

    End Sub

    Private Shared Sub FilterAppointment(appointment As Appointment, checkBox As ICheckBoxControl, resourceId As Integer)
        If appointment.Resources.GetResource("Status", resourceId) IsNot Nothing AndAlso checkBox.Checked Then
            appointment.Visible = True
        End If
    End Sub

    Protected Sub btnToggle_Click(sender As Object, e As EventArgs)
        RadScheduler1.Rebind()
    End Sub

    Protected Sub OnClientAppointmentClick(sender As Object, e As SchedulerEventArgs)
        Dim StrID As String = e.Appointment.ID.ToString()
    End Sub

    Function getLastLoginDate(ByVal guid As String) As String

        Dim q = (From p In db.StudentDetails Where p.UserName = guid Select p).FirstOrDefault

        If q.LastLoginDate Is Nothing Then
            Return ""
        Else
            Return GetTimeAdjustment(q.LastLoginDate)
        End If



    End Function

    Function GetTimeAdjustment(ByVal d As Date) As String

        Try

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            Dim MyTimeZone As String

            Dim currentuser_TimeZone = (From p In db.AspNetUsersProfiles Where p.UserID = currentUser.Id Select p.TimeZone).FirstOrDefault

            If currentuser_TimeZone = "" Or Nothing Then
                MyTimeZone = (From p In db.Sites Where p.SiteID = getSiteID() Select p.DefaultTimeZone).FirstOrDefault
            Else
                MyTimeZone = currentuser_TimeZone
            End If

            Dim MyCulture As String = (From p In db.Sites Where p.SiteID = getSiteID() Select p.CultureInfoCode).FirstOrDefault

            Dim cstZone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(MyTimeZone)

            Dim cstTime As DateTime = TimeZoneInfo.ConvertTimeFromUtc(d, cstZone)

            'add culture
            Dim culture As CultureInfo = CultureInfo.CreateSpecificCulture(MyCulture)

            Dim loginTime As String = String.Format("{0:t}", ShortTimeZoneFormat(MyTimeZone))

            Return String.Format("{0} ({1})", cstTime.ToString(culture.DateTimeFormat), loginTime)
        Catch ex As Exception
            Return ""

        End Try

    End Function

    Private Function ShortTimeZoneFormat(timeZoneStandardName As String) As String
        Dim TimeZoneElements As String() = timeZoneStandardName.Split(" "c)
        Dim shortTimeZone As String = [String].Empty
        For Each element As String In TimeZoneElements
            'copies the first element of each word
            shortTimeZone += element(0)
        Next
        Return shortTimeZone
    End Function

    Function getSiteID() As String

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        Return (From p In db.AspNetUsersProfiles Where p.UserID = currentUser.Id Select p.SiteID).FirstOrDefault

        'db.prGetUserSiteID(currentUser.Id).ToString()

    End Function

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Protected Sub ActiveAmbassadorList_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()

    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Select Case field
            Case "Positions"
                Dim query As String = String.Format("Select DISTINCT positionTitle as 'Positions' FROM tblStaffingPosition")

                Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

                Dim conn As New SqlConnection(ConnString)
                Dim adapter As New SqlDataAdapter()

                adapter.SelectCommand = New SqlCommand(query, conn)

                Dim myDataTable As New DataTable()

                conn.Open()

                Try
                    adapter.Fill(myDataTable)
                Finally
                    conn.Close()
                End Try

                Return myDataTable

            Case "Markets"
                Dim query As String = String.Format("Select DISTINCT marketName as 'Markets' FROM tblMarket")

                Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

                Dim conn As New SqlConnection(ConnString)
                Dim adapter As New SqlDataAdapter()

                adapter.SelectCommand = New SqlCommand(query, conn)

                Dim myDataTable As New DataTable()

                conn.Open()

                Try
                    adapter.Fill(myDataTable)
                Finally
                    conn.Close()
                End Try

                Return myDataTable

            Case Else
                Dim query As String = String.Format("Select DISTINCT {0} FROM qryViewActiveAmbassador", field)

                Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

                Dim conn As New SqlConnection(ConnString)
                Dim adapter As New SqlDataAdapter()

                adapter.SelectCommand = New SqlCommand(query, conn)

                Dim myDataTable As New DataTable()

                conn.Open()

                Try
                    adapter.Fill(myDataTable)
                Finally
                    conn.Close()
                End Try

                Return myDataTable
        End Select




    End Function

    Protected Sub btnMapView1_Click(sender As Object, e As EventArgs)
        MapPanel.Visible = True
        ActiveGridPanel.Visible = False
    End Sub

    Private Sub btnHideMap_Click(sender As Object, e As EventArgs) Handles btnHideMap.Click
        MapPanel.Visible = False
        ActiveGridPanel.Visible = True
    End Sub

    Private Sub BrandAmbassadorList_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        For Each col As GridColumn In ActiveAmbassadorList.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next
    End Sub

    Private Sub ScehduledPaymentsGrid_PreRender(sender As Object, e As EventArgs) Handles ScehduledPaymentsGrid.PreRender
        For Each col As GridColumn In ScehduledPaymentsGrid.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next
    End Sub

    Private Sub PendingPaymentsRadGrid_PreRender(sender As Object, e As EventArgs) Handles PendingPaymentsRadGrid.PreRender
        For Each col As GridColumn In PendingPaymentsRadGrid.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next
    End Sub
End Class