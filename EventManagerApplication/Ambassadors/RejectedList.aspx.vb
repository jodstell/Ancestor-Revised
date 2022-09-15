Imports System.Data.SqlClient
Imports System.Globalization
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class RejectedList
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim db1 As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

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

    Protected Sub RejectedAmbassadorList_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetRejectedAmbassadorDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()

    End Sub

    Public Function GetRejectedAmbassadorDataTable(field As String) As DataTable
        Dim query As String = String.Format("Select DISTINCT {0} FROM qryViewRejectedAmbassador", field)

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