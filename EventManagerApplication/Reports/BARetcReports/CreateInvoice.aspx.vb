Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class CreateInvoice
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 6 - dtNow.DayOfWeek, dtNow)

            Dim dtFirst As New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
            Dim endDate As DateTime = dtFirst.AddMonths(1).AddDays(-1)

            FromDate.SelectedDate = dtFirst
            ToDate.SelectedDate = endDate

            'Displays first day of the week
            ' selectedDateLabel.Text = dtFirst.ToString("dddd, MMMM dd") & " - " & endDate.ToString("dddd, MMMM dd")
        End If
    End Sub

    Private Sub btnFindEvents_Click(sender As Object, e As EventArgs) Handles btnFindEvents.Click

        ' add a bit a a timer for effect
        '  System.Threading.Thread.Sleep("10000")

        ' check if market is filtered
        'Dim marketSelected As Integer = 0
        'For Each li As ListItem In MarketList.Items
        '    If li.Selected Then
        '        marketSelected = marketSelected + 1
        '    End If
        'Next

        ' check if brand is filtered
        'Dim supplierSelected As Integer = 0

        'Dim collection As IList(Of RadListBoxItem) = SupplierList.CheckedItems

        'For Each item As RadListBoxItem In collection
        '    supplierSelected = supplierSelected + 1
        'Next

        ''both brand and market are filtered
        'If supplierSelected > 0 And marketSelected > 0 Then

        ' Create the list to store.



        ' Create the list to store.

        Dim sb As New StringBuilder()

        Dim SupplierCollection As IList(Of RadListBoxItem) = SupplierList.CheckedItems

        For Each item As RadListBoxItem In SupplierCollection
            sb.Append(item.Value + ",")
        Next

        HF_SelectedSuppliers.Value = sb.ToString()


        Dim sb1 As New StringBuilder()

        Dim MarketCollection As IList(Of RadListBoxItem) = MarketList.CheckedItems

        For Each item As RadListBoxItem In MarketCollection
            sb1.Append(item.Value + ",")
        Next

        HF_SelectedMarkets.Value = sb1.ToString()



        Dim q = db.getNeedInvoiceListByDate(HF_SelectedSuppliers.Value, HF_SelectedMarkets.Value, 18, FromDate.SelectedDate, ToDate.SelectedDate)

        ResultsGrid.DataSource = q
        ResultsGrid.DataBind()

        '   End If

        ' found results

        SearchPanel.Visible = False
        ResultPanel.Visible = True

        ResultPanelCountLabel.Text = ""

        ' no results found
        ResultsLabel.Text = "<i class='fa fa-exclamation-triangle' aria-hidden=True></i> We didn't find any invoices to create.  Please try again."
        ResultsLabel.Visible = True

    End Sub

    Protected Sub ToggleRowSelection(ByVal sender As Object, ByVal e As EventArgs)

        TryCast(TryCast(sender, CheckBox).NamingContainer, GridItem).Selected = TryCast(sender, CheckBox).Checked
        Dim checkHeader As Boolean = True
        For Each dataItem As GridDataItem In ResultsGrid.MasterTableView.Items
            If Not TryCast(dataItem.FindControl("CheckBox1"), CheckBox).Checked Then
                checkHeader = False
                Exit For
            End If
        Next
        Dim headerItem As GridHeaderItem = TryCast(ResultsGrid.MasterTableView.GetItems(GridItemType.Header)(0), GridHeaderItem)
        TryCast(headerItem.FindControl("headerChkbox"), CheckBox).Checked = checkHeader
    End Sub

    Protected Sub ToggleSelectedState(ByVal sender As Object, ByVal e As EventArgs)
        Dim headerCheckBox As CheckBox = TryCast(sender, CheckBox)
        For Each dataItem As GridDataItem In ResultsGrid.MasterTableView.Items
            TryCast(dataItem.FindControl("CheckBox1"), CheckBox).Checked = headerCheckBox.Checked
            dataItem.Selected = headerCheckBox.Checked
        Next
    End Sub

    Private Sub MarketList_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles MarketList.ItemDataBound

        ' Check Count
        If MarketList.Items.Count > 0 Then
            For i As Integer = 0 To MarketList.Items.Count - 1
                MarketList.Items(i).Checked = True
            Next
        End If


    End Sub

    Private Sub SupplierList_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles SupplierList.ItemDataBound

        ' Check Count
        If SupplierList.Items.Count > 0 Then
            For i As Integer = 0 To SupplierList.Items.Count - 1
                SupplierList.Items(i).Checked = True
            Next
        End If
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If ResultsGrid.SelectedItems.Count = 0 Then
            topMsgLabel.Text = "You must select at least one event."

            MessageLabel.Text = "You must select at least one event."

        Else
            'we need to create an invoice for each supplier in the selected grid
            For Each item As GridDataItem In ResultsGrid.SelectedItems
                Dim name As String = item("eventID").Text

                'find all the suppliers



                'Dim sb1 As New StringBuilder()

                'Dim SupplierCollection As IList(Of RadListBoxItem) = SupplierList.CheckedItems

                'For Each item As RadListBoxItem In SupplierCollection

                '    sb.Append(item.Value + ",")

                'Next

                'HF_SelectedSuppliers.Value = sb.ToString()



            Next


            Dim sb As New StringBuilder()

            'get GetInvoiceBatchID

            Dim invoiceBatchID = (From p In db.GetInvoiceBatchID() Select p.Column1).FirstOrDefault




            'db.tblInvoices.InsertOnSubmit(newInvoice)
            'db.SubmitChanges()


            For Each item As GridDataItem In ResultsGrid.SelectedItems
                ' loop through each selected row

                ' get each cell value using ColumnUniqueName
                Dim name As String = item("eventID").Text

                Dim id As Integer = Convert.ToInt32(item("eventID").Text)

                'update billing rate
                Dim i = From p In db.tblEventStaffingRequirements Where p.eventID = id Select p
                For Each p In i
                    db.UpdateBillingRate(id, p.RequirementID)

                Next

                db.CreateInvoice(Convert.ToInt32(item("eventID").Text), invoiceBatchID, currentUser.Id)

                ' thisEvent.invoiced = True
                ' thisEvent.invoiceID = newInvoice.invoiceID

                ' db.SubmitChanges()
            Next

            'redirect

            Response.Redirect("/Reports/BARetcReports/Invoicing")

        End If




    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If ResultsGrid.SelectedItems.Count = 0 Then
            topMsgLabel.Text = "You must select at least one event."

            MessageLabel.ForeColor = Drawing.Color.Red
            MessageLabel.Text = "You must select at least one event."

        Else
            'we need to create an invoice for each supplier in the selected grid
            For Each item As GridDataItem In ResultsGrid.SelectedItems
                Dim name As String = item("eventID").Text

                'find all the suppliers



                'Dim sb1 As New StringBuilder()

                'Dim SupplierCollection As IList(Of RadListBoxItem) = SupplierList.CheckedItems

                'For Each item As RadListBoxItem In SupplierCollection

                '    sb.Append(item.Value + ",")

                'Next

                'HF_SelectedSuppliers.Value = sb.ToString()



            Next


            Dim sb As New StringBuilder()

            'get GetInvoiceBatchID

            Dim invoiceBatchID = (From p In db.GetInvoiceBatchID() Select p.Column1).FirstOrDefault




            'db.tblInvoices.InsertOnSubmit(newInvoice)
            'db.SubmitChanges()


            For Each item As GridDataItem In ResultsGrid.SelectedItems
                ' loop through each selected row

                ' get each cell value using ColumnUniqueName
                Dim name As String = item("eventID").Text
                Dim id As Integer = Convert.ToInt32(item("eventID").Text)

                'update billing rate
                Dim i = From p In db.tblEventStaffingRequirements Where p.eventID = id Select p
                For Each p In i
                    db.UpdateBillingRate(id, p.RequirementID)


                Next

                'create invoice
                db.CreateInvoice(Convert.ToInt32(item("eventID").Text), invoiceBatchID, currentUser.Id)


            Next

            'redirect

            Response.Redirect("/Reports/BARetcReports/Invoicing")

        End If

    End Sub

    Private Sub ResultsGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles ResultsGrid.NeedDataSource

        Dim q = db.getNeedInvoiceListByDate(HF_SelectedSuppliers.Value, HF_SelectedMarkets.Value, 18, FromDate.SelectedDate, ToDate.SelectedDate)

        ResultsGrid.DataSource = q

    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect("/Reports/BARetcReports/Invoicing")
    End Sub

    Private Sub btnCancelInvoice_Click(sender As Object, e As EventArgs) Handles btnCancelInvoice.Click
        SearchPanel.Visible = True
        ResultPanel.Visible = False
    End Sub

    Protected Sub ResultsGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String

        ' Select Case field
        'Case "Status"
        query = String.Format("SELECT statusName FROM tblStatus")
        ' End Select

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