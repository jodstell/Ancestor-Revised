Imports System.Data.SqlClient
Imports System.Globalization
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class ActiveList
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

    End Sub

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

                Dim query As String

                If MarketComboBox.SelectedValue = "0" Then

                    query = String.Format("Select DISTINCT {0} FROM qryViewActiveAmbassador", field)

                Else
                    query = String.Format("Select DISTINCT {0} FROM qryViewActiveAmbassador_withMarketID where marketID={1}", field, MarketComboBox.SelectedValue)

                End If

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

    Private Sub ActiveAmbassadorList_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles ActiveAmbassadorList.NeedDataSource

        TryCast(sender, RadGrid).DataSource = GetDataTable()

    End Sub

    Public Function GetDataTable() As DataTable
        ' Dim query As String = "SELECT eventID, supplierName, eventDate, marketName, eventTypeName, statusName FROM qryViewEvents"

        Dim query As String = "getActiveAmbassador_byMarketID"

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()
        adapter.SelectCommand = New SqlCommand(query, conn)

        adapter.SelectCommand.CommandType = CommandType.StoredProcedure

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@marketID", SqlDbType.Int))
        adapter.SelectCommand.Parameters("@marketID").Value = Convert.ToInt32(MarketComboBox.SelectedValue)

        Dim myDataTable As New DataTable()

        conn.Open()
        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function

    Private Sub MarketComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles MarketComboBox.SelectedIndexChanged

        ActiveAmbassadorList.Rebind()
    End Sub
End Class