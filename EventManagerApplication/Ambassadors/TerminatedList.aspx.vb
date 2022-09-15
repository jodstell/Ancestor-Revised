Imports System.Data.SqlClient
Imports System.Globalization
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class TerminatedList
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim db1 As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

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

    Protected Sub TreminatedAmbassadorList_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetTerminatedAmbassadorDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()

    End Sub

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

End Class