Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration

Public Class Demogrid
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub EventDataGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles EventDataGrid.NeedDataSource
        TryCast(sender, RadGrid).DataSource = GetDataTable()
    End Sub

    Public Function GetDataTable() As DataTable
        ' Dim query As String = "SELECT eventID, supplierName, eventDate, marketName, eventTypeName, statusName FROM qryViewEvents"

        Dim query As String = "getEvents_ByUserID_withWholesaler"

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()
        adapter.SelectCommand = New SqlCommand(query, conn)

        adapter.SelectCommand.CommandType = CommandType.StoredProcedure

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@UserID", SqlDbType.NVarChar))
        adapter.SelectCommand.Parameters("@UserID").Value = "e1c1dc54-88ad-4c23-b0c5-e8c8023c060e"

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@fromDate", SqlDbType.Date))
        adapter.SelectCommand.Parameters("@fromDate").Value = "7/30/2017"

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@toDate", SqlDbType.Date))
        adapter.SelectCommand.Parameters("@toDate").Value = "8/29/2017"


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

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryViewEvents where eventDate >= '{1}' and eventDate <= '{2}' and clientid = {3} order by {0}", field, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, Common.GetCurrentClientID())

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

End Class