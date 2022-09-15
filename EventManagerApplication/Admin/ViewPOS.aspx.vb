Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class ViewPOS
    Inherits System.Web.UI.Page
    Private Shared ReadOnly CookieName As String = "POSGridPF"

    Private Sub ViewPOS_Init(sender As Object, e As EventArgs) Handles Me.Init
        RadPersistenceManager1.StorageProviderKey = CookieName
        RadPersistenceManager1.StorageProvider = New CookieStorageProvider(CookieName)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.QueryString("LoadState") IsNot Nothing Then

            Dim state = Request.QueryString("LoadState")

            If state = "Yes" Then
                If Not Page.IsPostBack Then

                    If Request.Cookies(CookieName) IsNot Nothing Then
                        RadPersistenceManager1.LoadState()

                        'set the date range from session state
                        '  FromDatePicker.SelectedDate = Session("FromDate_Activity")
                        ' ToDatePicker.SelectedDate = Session("ToDate_Activity")

                        posKitsList.Rebind()
                    End If
                End If
            End If

        End If

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        HiddenUserID.Value = currentUser.Id

    End Sub

    Function getTrackingLink(ByVal id As String) As String
        Dim db As New DataClassesDataContext

        Dim vendor As String = (From p In db.tblPosKits Where p.kitID = id Select p.shippingVendorID).FirstOrDefault
        Dim tracking As String = (From p In db.tblPosKits Where p.kitID = id Select p.trackingNumber).FirstOrDefault

        Select Case vendor
            Case "1"
                'FedEx
                Return String.Format("<a target='_blank' href='http://www.fedex.com/Tracking?language=english&cntry_code=us&tracknumbers={0}'>{0}</a>", tracking)

            Case "2"
                'UPS
                Return (String.Format("<a target='_blank' href='http://wwwapps.ups.com/WebTracking/track?track=yes&trackNums={0}'>{0}</a>", tracking))


            Case "3"
                Return ""      'None

            Case "4"
                Return ""  'Other

            Case Else
                Return ""
        End Select

    End Function


    Function getTrackingLinkNoLinks(ByVal id As String) As String
        Dim db As New DataClassesDataContext

        Dim vendor As String = (From p In db.tblPosKits Where p.kitID = id Select p.shippingVendorID).FirstOrDefault
        Dim tracking As String = (From p In db.tblPosKits Where p.kitID = id Select p.trackingNumber).FirstOrDefault

        Select Case vendor
            Case "1"
                'FedEx
                Return String.Format("{0}", tracking)

            Case "2"
                'UPS
                Return (String.Format("{0}", tracking))


            Case "3"
                Return ""       'None

            Case "4"
                Return "" 'Other
            Case Else
                Return ""


        End Select

    End Function

    Private Sub ViewPOS_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        For Each col As GridColumn In posKitsList.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next


        For Each col As GridColumn In InventoryList.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next
    End Sub

    Private Sub posKitsList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles posKitsList.ItemCommand

        Select Case e.CommandName
            Case "ClearFilters"
                For Each column As GridColumn In posKitsList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                posKitsList.MasterTableView.FilterExpression = [String].Empty
                posKitsList.MasterTableView.Rebind()

            Case "EditKit"
                'add persistence

                Response.Redirect("/admin/EditPosKit?KitID=" & e.CommandArgument)

            Case "ExportToExcel"

                posKitsList.ExportSettings.ExportOnlyData = False
                posKitsList.ExportSettings.IgnorePaging = True
                posKitsList.ExportSettings.OpenInNewWindow = True
                posKitsList.ExportSettings.UseItemStyles = False
                posKitsList.ExportSettings.FileName = "POS Kits"

                'add/remove columns
                posKitsList.MasterTableView.GetColumn("ViewButton").Visible = False
                posKitsList.MasterTableView.GetColumn("eventID").Visible = False
                posKitsList.MasterTableView.GetColumn("eventIDExcel").Visible = True
                posKitsList.MasterTableView.GetColumn("trackingNumber").Visible = False
                posKitsList.MasterTableView.GetColumn("trackingNumberExcel").Visible = True

                posKitsList.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx
                posKitsList.MasterTableView.ExportToExcel()

        End Select

    End Sub

    Protected Sub posKitsList_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)
        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetPoskitDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Public Function GetPoskitDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM tblPosKits", field)

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

    Protected Sub InventoryList_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)
        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetInventoryDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Protected Sub InventoryList_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs)

        If TypeOf e.Item Is GridDataItem Then
            'Dim editLink As HyperLink = DirectCast(e.Item.FindControl("EditLink"), HyperLink)
            Dim editButton As LinkButton = DirectCast(e.Item.FindControl("btnEdit"), LinkButton)
            editButton.Attributes("href") = "javascript:void(0);"
            editButton.Attributes("onclick") = [String].Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex)("itemID"), e.Item.ItemIndex)


            Dim showButton As LinkButton = DirectCast(e.Item.FindControl("btnShowInventory"), LinkButton)
            showButton.Attributes("href") = "javascript:void(0);"
            showButton.Attributes("onclick") = [String].Format("return ShowRecieveForm2('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex)("itemID"), e.Item.ItemIndex)

            Dim btnChangeQty As LinkButton = DirectCast(e.Item.FindControl("btnChangeQty"), LinkButton)
            btnChangeQty.Attributes("href") = "javascript:void(0);"
            btnChangeQty.Attributes("onclick") = [String].Format("return ShowUpdateInventoryCountForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex)("itemID"), e.Item.ItemIndex)

        End If

    End Sub

    Protected Sub RadAjaxManager1_AjaxRequest(ByVal sender As Object, ByVal e As AjaxRequestEventArgs) Handles RadAjaxManager1.AjaxRequest
        If e.Argument = "Rebind" Then
            InventoryList.MasterTableView.SortExpressions.Clear()
            InventoryList.MasterTableView.GroupByExpressions.Clear()
            InventoryList.Rebind()
        ElseIf e.Argument = "RebindAndNavigate" Then
            InventoryList.MasterTableView.SortExpressions.Clear()
            InventoryList.MasterTableView.GroupByExpressions.Clear()
            InventoryList.MasterTableView.CurrentPageIndex = InventoryList.MasterTableView.PageCount - 1
            InventoryList.Rebind()
        End If
    End Sub


    Public Function GetInventoryDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryViewPOSKit_bySupplier", field)

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

    Private Sub InventoryList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles InventoryList.ItemCommand
        Select Case e.CommandName
            Case "ClearFilters"

                For Each column As GridColumn In InventoryList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                InventoryList.MasterTableView.FilterExpression = [String].Empty
                InventoryList.MasterTableView.Rebind()

                InventoryList.DataBind()


            Case "ExportToExcel"

                InventoryList.ExportSettings.ExportOnlyData = False
                InventoryList.ExportSettings.IgnorePaging = True
                InventoryList.ExportSettings.OpenInNewWindow = True
                InventoryList.ExportSettings.UseItemStyles = False
                InventoryList.ExportSettings.FileName = "Inventory"

                'add/remove columns 
                InventoryList.MasterTableView.GetColumn("ViewButton").Visible = False
                InventoryList.MasterTableView.GetColumn("thumbnail").Visible = False
                InventoryList.MasterTableView.GetColumn("DeleteButton").Visible = False
                InventoryList.MasterTableView.GetColumn("QtyonHandTemplate").Visible = False
                InventoryList.MasterTableView.GetColumn("QtyonHand").Visible = True

                InventoryList.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx
                InventoryList.MasterTableView.ExportToExcel()

        End Select


    End Sub
End Class