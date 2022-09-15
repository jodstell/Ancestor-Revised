Imports System.Data.SqlClient
Imports Telerik.Web.UI

Public Class SiteActivityLog
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            HistoryLogGrid.MasterTableView.GetColumn("IPAddress").Display = False
            HistoryLogGrid.MasterTableView.GetColumn("UserAgent").Display = False

        End If
    End Sub

    Protected Sub HistoryLogGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Private Sub HistoryLogGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles HistoryLogGrid.ItemCommand
        Select Case e.CommandName
            Case "ClearFilters"
                For Each column As GridColumn In HistoryLogGrid.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                HistoryLogGrid.MasterTableView.FilterExpression = [String].Empty
                HistoryLogGrid.MasterTableView.Rebind()

            Case "ResetGrid"

                For Each column As GridColumn In HistoryLogGrid.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                HistoryLogGrid.MasterTableView.FilterExpression = [String].Empty
                HistoryLogGrid.MasterTableView.Rebind()

                ' Response.Redirect("/admin/siteactivitylog")
        End Select


    End Sub

    Private Sub HistoryLogGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles HistoryLogGrid.NeedDataSource
        TryCast(sender, RadGrid).DataSource = CreateDataTable()
    End Sub

    Public Function CreateDataTable() As DataTable

        Dim query As String = String.Format("SELECT TOP(2000) * FROM qryViewHistoryLog order by LogTime desc")

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("MembershipConnection").ConnectionString

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

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryViewHistoryLog order by {0}", field)

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("MembershipConnection").ConnectionString

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
End Class