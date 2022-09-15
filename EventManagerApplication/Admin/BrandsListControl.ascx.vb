Imports System.Data.SqlClient
Imports Telerik.Web.UI

Public Class BrandsListControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext
    Private Shared ReadOnly CookieName As String = "BrandsListPF"

    Private Sub BrandsListControl_Init(sender As Object, e As EventArgs) Handles Me.Init
        RadPersistenceManager1.StorageProviderKey = CookieName
        RadPersistenceManager1.StorageProvider = New CookieStorageProvider(CookieName)
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim state = Request.QueryString("LoadState")

        If state = "Yes" Then
            If Not Page.IsPostBack Then

                If Request.Cookies(CookieName) IsNot Nothing Then
                    RadPersistenceManager1.LoadState()
                    BrandsList.Rebind()
                End If
            End If
        End If

    End Sub

    Public Sub ConfigureExport()

        BrandsList.ExportSettings.ExportOnlyData = False
        BrandsList.ExportSettings.IgnorePaging = True
        BrandsList.ExportSettings.OpenInNewWindow = True
        BrandsList.ExportSettings.UseItemStyles = False
        BrandsList.ExportSettings.FileName = "Brands"

    End Sub

    Protected Sub BrandsList_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)
        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryGetBrands where clientid = {1} order by {0}", field, Session("CurrentClientID"))

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


    Private Sub BrandsList_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles BrandsList.ItemDataBound

        If TypeOf e.Item Is GridDataItem Then


            Dim dataBoundItem As GridDataItem = TryCast(e.Item, GridDataItem)

            'get the keyname
            Dim datakey As String = dataBoundItem.GetDataKeyValue("brandID").ToString()

            Dim act = (From p In db.tblBrands Where p.brandID = datakey Select p.active).FirstOrDefault

            Dim label As Label = CType(dataBoundItem.FindControl("ActiveLabel"), Label)
            Dim link As LinkButton = CType(dataBoundItem.FindControl("BtnActive"), LinkButton)

            If act = True Then
                label.Text = "Active"
                link.CssClass = "btn btn-xs btn-success"
            Else
                label.Text = "Inactive"
                link.CssClass = "btn btn-xs btn-warning"
            End If


        End If

    End Sub

    Private Sub BrandsList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles BrandsList.ItemCommand
        Select Case e.CommandName
            Case "EditBrand"

                RadPersistenceManager1.SaveState()
                Response.Redirect("/admin/events/editbrand?ClientID=" & Common.GetCurrentClientID() & "&BrandID=" & e.CommandArgument)


            Case "AddNew"
                If e.CommandName = "AddNew" Then Response.Redirect("/admin/events/newbrand?ClientID=" & Common.GetCurrentClientID())

            Case "ClearFilters"
                'For Each column As GridColumn In BrandsList.MasterTableView.Columns
                '    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                '    column.CurrentFilterValue = [String].Empty
                'Next

                'BrandsList.MasterTableView.FilterExpression = [String].Empty
                'BrandsList.MasterTableView.Rebind()

                Response.Redirect("/admin/ClientDetails?Action=0&ClientID=" & Common.GetCurrentClientID() & "&LoadState=No#eventtab/brands")

            Case "ExportToCSV"
                ConfigureExport()

                BrandsList.MasterTableView.ExportToCSV()

            Case "SetActive"
                Dim dataItem As GridDataItem = CType(e.Item, GridDataItem)

                Dim label As Label = CType(dataItem.FindControl("ActiveLabel"), Label)
                Dim link As LinkButton = CType(dataItem.FindControl("BtnActive"), LinkButton)



                If label.Text = "Active" Then
                    'set to false
                    db.SetActiveBrand(Convert.ToInt32(e.CommandArgument), 0)

                    label.Text = "Inactive"
                    link.CssClass = "btn btn-xs btn-warning"
                Else
                    'set to true
                    db.SetActiveBrand(Convert.ToInt32(e.CommandArgument), 1)

                    label.Text = "Active"
                    link.CssClass = "btn btn-xs btn-success"
                End If

                db.SubmitChanges()

        End Select
    End Sub

    Function getCategory(ByVal id As Integer) As String
        Return (From p In db.tblBrandCategories Where p.brandCategoryID = id Select p.categoryName).FirstOrDefault
    End Function
    Function getEventCount(id As Integer) As String
        Return (From p In db.tblBrandInEvents Where p.brandID = id Select p).Count
    End Function

    Private Sub BrandsList_ItemCreated(sender As Object, e As GridItemEventArgs) Handles BrandsList.ItemCreated

        If TypeOf e.Item Is GridHeaderItem Then
            Dim headerItem As GridHeaderItem = TryCast(e.Item, GridHeaderItem)
            For Each column As GridColumn In BrandsList.MasterTableView.RenderColumns
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
End Class