Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.IO
Imports System.Globalization
Imports System.Web.Script.Serialization
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports System.Net

Public Class ViewUsersList
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim db2 As New LMSDataClassesDataContext
    Dim siteid As String = "GigEngyn"

    Private Sub UserManagerControl_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        For Each col As GridColumn In StaffList.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getRoles(id As String) As String
        Dim myline As String

        Dim q = From p In db2.qryUserRoles Where p.UserId = id Select p

        For Each p In q
            'myline = p.Name
            Return myline.Join(",", p.Name).ToString()
        Next

#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths

    Private Function ShortTimeZoneFormat(timeZoneStandardName As String) As String
        Dim TimeZoneElements As String() = timeZoneStandardName.Split(" "c)
        Dim shortTimeZone As String = [String].Empty
        For Each element As String In TimeZoneElements
            'copies the first element of each word
            shortTimeZone += element(0)
        Next
        Return shortTimeZone
    End Function

    Function GetTimeAdjustment(ByVal d As Date) As String

        Try

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            Dim MyTimeZone As String

            Dim currentuser_TimeZone = (From p In db2.AspNetUsersProfiles Where p.UserID = currentUser.Id Select p.TimeZone).FirstOrDefault

            If currentuser_TimeZone = "" Or Nothing Then
                MyTimeZone = (From p In db2.Sites Where p.SiteID = siteid Select p.DefaultTimeZone).FirstOrDefault
            Else
                MyTimeZone = currentuser_TimeZone
            End If

            Dim MyCulture As String = (From p In db2.Sites Where p.SiteID = siteid Select p.CultureInfoCode).FirstOrDefault

            Dim cstZone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(MyTimeZone)

            Dim cstTime As DateTime = TimeZoneInfo.ConvertTimeFromUtc(d, cstZone)

            'add culture
            Dim culture As CultureInfo = CultureInfo.CreateSpecificCulture(MyCulture)


            Return String.Format("{0} ({1})", cstTime.ToString(culture.DateTimeFormat), ShortTimeZoneFormat(MyTimeZone))
        Catch ex As Exception
            'Return d
        End Try

#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths


    Function getOnlineStatus(id As String) As String

        Dim q = (From p In db.qryGetLoggedInUsers Where p.userID = id Select p).Count

        If q = 0 Then Return "No" Else Return "Yes"
    End Function

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM tblProfiles where IsStaff = true order by {0}", field)

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

    Protected Sub EventDataGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)
        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Protected Sub btnCancelFilter2_Click(sender As Object, e As EventArgs)
        Response.Redirect("/admin/siteadministration#_" & "users")
    End Sub

    Public Sub ConfigureExport()

        StaffList.ExportSettings.ExportOnlyData = False
        StaffList.ExportSettings.IgnorePaging = True
        StaffList.ExportSettings.OpenInNewWindow = True
        StaffList.ExportSettings.UseItemStyles = False
        StaffList.ExportSettings.FileName = "Users"

    End Sub

    Private Sub StaffList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles StaffList.ItemCommand

        Select Case e.CommandName

            Case "ExportToExcel"

                StaffList.ExportSettings.ExportOnlyData = False
                StaffList.ExportSettings.IgnorePaging = True
                StaffList.ExportSettings.OpenInNewWindow = True
                StaffList.ExportSettings.UseItemStyles = False
                StaffList.ExportSettings.FileName = "Staff"

                StaffList.MasterTableView.GetColumn("ViewButton").Visible = False
                StaffList.MasterTableView.GetColumn("DeleteButton").Visible = False
                'EventDataGrid.MasterTableView.GetColumn("status").Visible = True
                'EventDataGrid.MasterTableView.GetColumn("accountName").Visible = False
                'EventDataGrid.MasterTableView.GetColumn("accountName1").Visible = True
                'EventDataGrid.MasterTableView.GetColumn("address").Visible = True
                'EventDataGrid.MasterTableView.GetColumn("city").Visible = True
                'EventDataGrid.MasterTableView.GetColumn("state").Visible = True

                'EventDataGrid.MasterTableView.GetColumn("marketName").HeaderText = "Market"

                StaffList.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

                StaffList.MasterTableView.ExportToExcel()

            Case "NewUser"

                'RadPersistenceManager1.SaveState()

                Response.Redirect("/admin/users/newuser")

            'Case "ViewProfile"

                '    'RadPersistenceManager1.SaveState()

                ''    Response.Redirect("/admin/users/userprofile?UserID=" & e.CommandArgument)

                'Dim editButton As LinkButton = DirectCast(e.Item.FindControl("btnViewProfile"), LinkButton)
                'editButton.Attributes("href") = "javascript:void(0);"
                'editButton.Attributes("onclick") = [String].Format("return ShowEditForm('{0}','{1}');", e.CommandArgument, e.Item.ItemIndex)

            Case "DeleteProfile"
                ' delete the tblProfile
                db.deleteUserProfile(e.CommandArgument)


                ' delete the asp.net user
                db2.DeleteStaffLogin(e.CommandArgument)

                StaffList.DataBind()


            Case "ClearFilters"

                For Each column As GridColumn In StaffList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                StaffList.MasterTableView.FilterExpression = [String].Empty
                StaffList.MasterTableView.Rebind()
        End Select


    End Sub


    'Private Sub btnUsers_Click(sender As Object, e As EventArgs) Handles btnUsers.Click
    '    row1.Visible = False
    '    UsersPanel.Visible = True
    'End Sub

    Private Sub btnBackUsers_Click(sender As Object, e As EventArgs) Handles btnBackUsers.Click
        Response.Redirect("/admin/siteadministration")
    End Sub

    Private Sub StaffList_ItemCreated(sender As Object, e As GridItemEventArgs) Handles StaffList.ItemCreated
        If TypeOf e.Item Is GridHeaderItem Then
            Dim headerItem As GridHeaderItem = TryCast(e.Item, GridHeaderItem)
            For Each column As GridColumn In StaffList.MasterTableView.RenderColumns
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


        If TypeOf e.Item Is GridDataItem Then
            Dim editButton As LinkButton = DirectCast(e.Item.FindControl("btnViewProfile"), LinkButton)
            editButton.Attributes("href") = "javascript:void(0);"
            editButton.Attributes("onclick") = [String].Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex)("userID"), e.Item.ItemIndex)
        End If

    End Sub

    Protected Sub RadAjaxManager1_AjaxRequest(ByVal sender As Object, ByVal e As AjaxRequestEventArgs) Handles RadAjaxManager1.AjaxRequest
        If e.Argument = "Rebind" Then
            StaffList.MasterTableView.SortExpressions.Clear()
            StaffList.MasterTableView.GroupByExpressions.Clear()
            StaffList.Rebind()
        ElseIf e.Argument = "RebindAndNavigate" Then
            StaffList.MasterTableView.SortExpressions.Clear()
            StaffList.MasterTableView.GroupByExpressions.Clear()
            StaffList.MasterTableView.CurrentPageIndex = StaffList.MasterTableView.PageCount - 1
            StaffList.Rebind()
        End If
    End Sub

End Class