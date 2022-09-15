Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class EventImport
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            HiddenUserID.Value = currentUser.Id
        Catch ex As Exception
            MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on ViewEvents", "Could not find user")

        End Try

        Dim _supplierID = (From p In db.tblEventImports Where p.eventImportID = Request.QueryString("ImportID") Select p.supplierID).FirstOrDefault
        SupplierNameLabel.Text = getSupplierName(_supplierID)

        FileNameLabel.Text = (From p In db.tblEventImports Where p.eventImportID = Request.QueryString("ImportID") Select p.fileName).FirstOrDefault

        FileNameHyperLink.NavigateUrl = String.Format("https://bletsianstor01.blob.core.windows.net:443/baretc/ImportFiles/{0}.xlsx", (From p In db.tblEventImports Where p.eventImportID = Request.QueryString("ImportID") Select p.fileName).FirstOrDefault)

    End Sub
    Function getSupplierName(id As Integer) As String

        Return (From p In db.tblSuppliers Where p.supplierID = id Select p.supplierName).FirstOrDefault

    End Function
    Private Sub EventDataGrid_ItemCreated(sender As Object, e As GridItemEventArgs) Handles EventDataGrid.ItemCreated
        If TypeOf e.Item Is GridHeaderItem Then
            Dim headerItem As GridHeaderItem = TryCast(e.Item, GridHeaderItem)
            For Each column As GridColumn In EventDataGrid.MasterTableView.RenderColumns
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

    Protected Sub EventDataGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryViewEvents where clientid = {1} and importFileID = {2} order by {0}", field, Common.GetCurrentClientID(), Request.QueryString("ImportID"))

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

    Private Sub EventImport_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        For Each col As GridColumn In EventDataGrid.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next

    End Sub
End Class