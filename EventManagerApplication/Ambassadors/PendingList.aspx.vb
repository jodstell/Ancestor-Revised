Imports System.Data.SqlClient
Imports System.Globalization
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class PendingList
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim db1 As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

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

End Class