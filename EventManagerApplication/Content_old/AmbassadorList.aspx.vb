Imports System.Data.SqlClient
Imports System.Globalization
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class AmbassadorList1
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim db1 As New DataClassesDataContext
    Private Shared ReadOnly CookieName As String = "AmbassadorsListPF"

    Private Sub AmbassadorList1_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        For Each col As GridColumn In ActiveAmbassadorList.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next
    End Sub

    Private Sub AmbassadorList1_Init(sender As Object, e As EventArgs) Handles Me.Init
        RadPersistenceManager1.StorageProviderKey = CookieName
        RadPersistenceManager1.StorageProvider = New CookieStorageProvider(CookieName)
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim state = Request.QueryString("LoadState")

        If state = "Yes" Then
            If Not Page.IsPostBack Then

                If Request.Cookies(CookieName) IsNot Nothing Then
                    RadPersistenceManager1.LoadState()
                    ActiveAmbassadorList.Rebind()
                End If
            End If
        End If


        Dim action = Request.QueryString("action")

        Select Case action
            Case 0
                msgLabel.Text = Common.ShowAlert("success", "The ambassador was deleted successfully!")
            Case 1
                msgLabel.Text = Common.ShowAlert("success", "The ambassador was added successfully!")

        End Select



        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Agency") Then
            Response.Redirect("/AccessDenied")
        End If

    End Sub

    Protected Sub ActiveAmbassadorList_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()

    End Sub

    Protected Sub TreminatedAmbassadorList_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetTerminatedAmbassadorDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()

    End Sub


    Protected Sub PendingAmbassadorList_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetPendingAmbassadorDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()

    End Sub

    Public Function GetPendingAmbassadorDataTable(field As String) As DataTable
        Dim query As String = String.Format("Select DISTINCT {0} FROM qryViewPendingAmbassador", field)

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

    End Function
    Public Function GetTerminatedAmbassadorDataTable(field As String) As DataTable
        Dim query As String = String.Format("Select DISTINCT {0} FROM qryViewTerminatedAmbassador", field)

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

    End Function
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
            'Return d
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

    Private Sub ActiveAmbassadorList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ActiveAmbassadorList.ItemCommand
        Select Case e.CommandName
            Case "ViewAmbassador"

                RadPersistenceManager1.SaveState()
                Response.Redirect("ViewAmbassadorDetails.aspx?UserID=" & e.CommandArgument)

            Case "ClearFilters"
                For Each column As GridColumn In ActiveAmbassadorList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                ActiveAmbassadorList.MasterTableView.FilterExpression = [String].Empty
                ActiveAmbassadorList.MasterTableView.Rebind()
                ActiveAmbassadorList.Rebind()

            Case "ResetGrid"
                Response.Redirect("/ambassadors/ActiveList")

            Case "ExportExcel"

                ActiveAmbassadorList.ExportSettings.ExportOnlyData = False
                ActiveAmbassadorList.ExportSettings.IgnorePaging = True
                ActiveAmbassadorList.ExportSettings.OpenInNewWindow = True
                ActiveAmbassadorList.ExportSettings.UseItemStyles = False
                ActiveAmbassadorList.ExportSettings.FileName = "Ambassadors"

                ActiveAmbassadorList.MasterTableView.GetColumn("ViewButton").Visible = False


                ActiveAmbassadorList.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

                ActiveAmbassadorList.MasterTableView.ExportToExcel()

        End Select

    End Sub

    Private Sub ActiveAmbassadorList_ItemCreated(sender As Object, e As GridItemEventArgs) Handles ActiveAmbassadorList.ItemCreated
        If TypeOf e.Item Is GridHeaderItem Then
            Dim headerItem As GridHeaderItem = TryCast(e.Item, GridHeaderItem)
            For Each column As GridColumn In ActiveAmbassadorList.MasterTableView.RenderColumns
                Dim isFiltered As Boolean = Not String.IsNullOrEmpty(column.EvaluateFilterExpression())
                If isFiltered Then
                    Dim button As New ImageButton()
                    button.AlternateText = "Clear filters"
                    button.ImageUrl = "~/filter.png"
                    button.ImageAlign = ImageAlign.Right
                    button.OnClientClick = "clearColumnFilter('" + column.UniqueName + "'); return false;"
                    button.Enabled = False

                    headerItem(column.UniqueName).Controls.Add(button)
                End If
            Next
        End If
    End Sub

    Private Sub PendingAmbassadorsList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles PendingAmbassadorsList.ItemCommand

        Select Case e.CommandName
            Case "ExportToExcel"
                PendingAmbassadorsList.ExportSettings.ExportOnlyData = False
                PendingAmbassadorsList.ExportSettings.IgnorePaging = True
                PendingAmbassadorsList.ExportSettings.OpenInNewWindow = True
                PendingAmbassadorsList.ExportSettings.UseItemStyles = False
                PendingAmbassadorsList.ExportSettings.FileName = "Prospects"

                'add/remove columns
                PendingAmbassadorsList.MasterTableView.GetColumn("ViewButton").Visible = False
                ' PendingAmbassadorsList.MasterTableView.GetColumn("DeleteButton").Visible = False

                PendingAmbassadorsList.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx
                PendingAmbassadorsList.MasterTableView.ExportToExcel()

            Case "ClearFilters"

                For Each column As GridColumn In PendingAmbassadorsList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                PendingAmbassadorsList.MasterTableView.FilterExpression = [String].Empty
                PendingAmbassadorsList.MasterTableView.Rebind()

            Case "View"

                RadPersistenceManager1.SaveState()
                Response.Redirect("ViewProspectAmbassador?UserID=" & e.CommandArgument)
        End Select

    End Sub

    Private Sub RejectedAmbassadorsList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RejectedAmbassadorsList.ItemCommand

        Select Case e.CommandName
            Case "ExportToExcel"
                RejectedAmbassadorsList.ExportSettings.ExportOnlyData = False
                RejectedAmbassadorsList.ExportSettings.IgnorePaging = True
                RejectedAmbassadorsList.ExportSettings.OpenInNewWindow = True
                RejectedAmbassadorsList.ExportSettings.UseItemStyles = False
                RejectedAmbassadorsList.ExportSettings.FileName = "Prospects"

                'add/remove columns
                RejectedAmbassadorsList.MasterTableView.GetColumn("ViewButton").Visible = False
                ' RejectedAmbassadorsList.MasterTableView.GetColumn("DeleteButton").Visible = False

                RejectedAmbassadorsList.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx
                RejectedAmbassadorsList.MasterTableView.ExportToExcel()

            Case "ClearFilters"

                For Each column As GridColumn In RejectedAmbassadorsList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                RejectedAmbassadorsList.MasterTableView.FilterExpression = [String].Empty
                RejectedAmbassadorsList.MasterTableView.Rebind()

            Case "View"

                RadPersistenceManager1.SaveState()
                Response.Redirect("ViewRejectedAmbassador?UserID=" & e.CommandArgument)
        End Select

    End Sub

    Private Sub TerminatedAmbassadorList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles TerminatedAmbassadorList.ItemCommand


        Select Case e.CommandName
            Case "ExportExcel"

                TerminatedAmbassadorList.ExportSettings.ExportOnlyData = False
                TerminatedAmbassadorList.ExportSettings.IgnorePaging = True
                TerminatedAmbassadorList.ExportSettings.OpenInNewWindow = True
                TerminatedAmbassadorList.ExportSettings.UseItemStyles = False
                TerminatedAmbassadorList.ExportSettings.FileName = "TerminatedAmbassadors"

                TerminatedAmbassadorList.MasterTableView.GetColumn("ViewButton").Visible = False


                TerminatedAmbassadorList.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

                TerminatedAmbassadorList.MasterTableView.ExportToExcel()

            Case "ClearFilters"

                For Each column As GridColumn In TerminatedAmbassadorList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                TerminatedAmbassadorList.MasterTableView.FilterExpression = [String].Empty
                TerminatedAmbassadorList.MasterTableView.Rebind()

        End Select
    End Sub

End Class