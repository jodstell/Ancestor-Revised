Imports System.Data.SqlClient
Imports Telerik.Web.UI

Public Class SupplierListControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Public Sub ConfigureExport()

        SupplierList.ExportSettings.ExportOnlyData = False
        SupplierList.ExportSettings.IgnorePaging = True
        SupplierList.ExportSettings.OpenInNewWindow = True
        SupplierList.ExportSettings.UseItemStyles = False
        SupplierList.ExportSettings.FileName = "Suppliers"

    End Sub

    Protected Sub SupplierList_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)
        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryGetSupplierList where clientID = {1} order by {0}", field, Common.GetCurrentClientID())

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

    Private Sub SupplierList_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles SupplierList.ItemDataBound

        If TypeOf e.Item Is GridDataItem Then

            Dim dataBoundItem As GridDataItem = TryCast(e.Item, GridDataItem)

            'get the keyname
            Dim datakey As String = dataBoundItem.GetDataKeyValue("supplierID").ToString()

            Dim act = (From p In db.tblSuppliers Where p.supplierID = datakey Select p.active).FirstOrDefault

            Dim label As Label = CType(dataBoundItem.FindControl("ActiveLabel"), Label)
            Dim link As LinkButton = CType(dataBoundItem.FindControl("BtnActive"), LinkButton)

            If act = True Then
                label.Text = "Active"
                link.CssClass = "btn btn-xs btn-success"
            Else
                label.Text = "Inactive"
                link.CssClass = "btn btn-xs btn-warning"
            End If


            '  Dim btnEdit As LinkButton = CType(dataBoundItem.FindControl("btnEdit"), LinkButton)
            '  btnEdit.PostBackUrl = "/admin/events/editsupplier?ClientID=" & Common.GetCurrentClientID() & "&SupplierID=" & datakey

        End If
    End Sub

    Function getEventBrandsCount(id As Integer) As String
        Return (From p In db.tblSupplierBrands Where p.supplierID = id Select p).Count
    End Function

    Function getEventCount(id As Integer) As String
        Return (From p In db.tblEvents Where p.supplierID = id And p.clientID = Common.GetCurrentClientID() Select p).Count
    End Function

    Private Sub SupplierList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles SupplierList.ItemCommand


        Select Case e.CommandName

            Case "EditSupplier"

                Response.Redirect("/admin/events/editsupplier?ClientID=" & Common.GetCurrentClientID() & "&SupplierID=" & e.CommandArgument)

            Case "AddNew"
                If e.CommandName = "AddNew" Then Response.Redirect("/admin/events/newsupplier?ClientID=" & Common.GetCurrentClientID())

            Case "ClearFilters"
                For Each column As GridColumn In SupplierList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                SupplierList.MasterTableView.FilterExpression = [String].Empty
                SupplierList.MasterTableView.Rebind()

            Case "ExportToExcel"
                SupplierList.ExportSettings.ExportOnlyData = False
                SupplierList.ExportSettings.IgnorePaging = True
                SupplierList.ExportSettings.OpenInNewWindow = True
                SupplierList.ExportSettings.UseItemStyles = False
                SupplierList.ExportSettings.FileName = "Suppliers"

                SupplierList.MasterTableView.GetColumn("ViewButton").Visible = False
                SupplierList.MasterTableView.GetColumn("active").Visible = False

                SupplierList.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

                SupplierList.MasterTableView.ExportToExcel()


            Case "SetActive"
                Dim dataItem As GridDataItem = CType(e.Item, GridDataItem)

                Dim label As Label = CType(dataItem.FindControl("ActiveLabel"), Label)
                Dim link As LinkButton = CType(dataItem.FindControl("BtnActive"), LinkButton)



                If label.Text = "Active" Then
                    'set to false
                    db.SetActiveSupplier(Convert.ToInt32(e.CommandArgument), 0)

                    label.Text = "Inactive"
                    link.CssClass = "btn btn-xs btn-warning"
                Else
                    'set to true
                    db.SetActiveSupplier(Convert.ToInt32(e.CommandArgument), 1)

                    label.Text = "Active"
                    link.CssClass = "btn btn-xs btn-success"
                End If

                db.SubmitChanges()




        End Select
    End Sub


End Class