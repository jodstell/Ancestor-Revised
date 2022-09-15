Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class ViewAccounts
    Inherits System.Web.UI.Page

    Private Shared ReadOnly CookieName As String = "AccountListPF"

    Private Sub ViewAccounts_Init(sender As Object, e As EventArgs) Handles Me.Init
        RadPersistenceManager1.StorageProviderKey = CookieName
        RadPersistenceManager1.StorageProvider = New CookieStorageProvider(CookieName)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim state = Request.QueryString("LoadState")

        If state = "Yes" Then
            If Not Page.IsPostBack Then

                If Request.Cookies(CookieName) IsNot Nothing Then
                    RadPersistenceManager1.LoadState()
                    AccountDataGrid.Rebind()
                End If
            End If
        End If


        Dim mapLayer As MapLayer = GetMapLayer()
        RadMap1.LayersCollection.Clear()
        RadMap1.LayersCollection.Add(mapLayer)


        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Then
            Response.Redirect("/AccessDenied")
        End If


    End Sub

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Public Sub ConfigureExport()

        AccountDataGrid.ExportSettings.ExportOnlyData = False
        AccountDataGrid.ExportSettings.IgnorePaging = True
        AccountDataGrid.ExportSettings.OpenInNewWindow = True
        AccountDataGrid.ExportSettings.UseItemStyles = False
        AccountDataGrid.ExportSettings.FileName = "Accounts"

    End Sub

    Private Sub AccountDataGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles AccountDataGrid.ItemCommand

        Select Case e.CommandName
            Case "EditAccount"
                RadPersistenceManager1.SaveState()
                Response.Redirect("AccountDetails?AccountID=" & e.CommandArgument)

            Case "ClearFilters"

                Response.Redirect("/Accounts/ViewAccounts")


            Case "ExportToCSV"

                AccountDataGrid.ExportSettings.ExportOnlyData = False
                AccountDataGrid.ExportSettings.IgnorePaging = True
                AccountDataGrid.ExportSettings.OpenInNewWindow = True
                AccountDataGrid.ExportSettings.UseItemStyles = False
                AccountDataGrid.ExportSettings.FileName = "Accounts"

                'add/remove columns
                AccountDataGrid.MasterTableView.GetColumn("ViewButton").Visible = False

                AccountDataGrid.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx
                AccountDataGrid.MasterTableView.ExportToExcel()

            Case "ViewMap"
                RadMap1.DataSourceID = "GetAccounts"
                MapPanel.Visible = True
        End Select

    End Sub

    Private Function GetMapLayer() As MapLayer

        Dim provider As String = "Bing"
        Dim providerName As String = "Bing"

        Dim mapLayer As MapLayer = New MapLayer

        mapLayer.Type = Map.LayerType.Bing
        mapLayer.Key = ConfigurationManager.AppSettings.Get("BingMapsAPIKey").ToString()



        Return mapLayer

    End Function

    Private Sub btnHideMap_Click(sender As Object, e As EventArgs) Handles btnHideMap.Click
        MapPanel.Visible = False
    End Sub

    Protected Sub AccountDataGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()

    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryViewAccounts order by {0}", field)

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

    Private Sub AccountDataGrid_ItemCreated(sender As Object, e As GridItemEventArgs) Handles AccountDataGrid.ItemCreated
        If TypeOf e.Item Is GridHeaderItem Then
            Dim headerItem As GridHeaderItem = TryCast(e.Item, GridHeaderItem)
            For Each column As GridColumn In AccountDataGrid.MasterTableView.RenderColumns
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

    Private Sub AccountDataGrid_GridExporting(sender As Object, e As GridExportingArgs) Handles AccountDataGrid.GridExporting

    End Sub
End Class