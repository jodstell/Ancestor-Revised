Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class _Default1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub EventDataGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)
        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Private Sub ClientList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ClientList.ItemCommand

        Select Case e.CommandName

            Case "NewClient"

                Response.Redirect("/GlobalAdmin/Clients/NewClient")

            Case "ViewClient"

                'Session("CurrentClientID") = Convert.ToInt32(e.CommandArgument)

                Dim db As New DataClassesDataContext

                Dim manager = New UserManager()
                Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

                Dim result = (From p In db.tblProfiles Where p.userID = currentUser.Id Select p).FirstOrDefault

                result.currentClientID = Convert.ToInt32(e.CommandArgument)

                db.SubmitChanges()

                'ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = Convert.ToInt32(e.CommandArgument) Select p.clientName).FirstOrDefault

                Response.Redirect("/dashboard")

                'Response.Redirect("/Dashboard")

        End Select


    End Sub

    'Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
    '    Response.Redirect("/dashboard")
    'End Sub

    'Private Sub ClientList_ItemCreated(sender As Object, e As GridItemEventArgs) Handles ClientList.ItemCreated

    '    If TypeOf e.Item Is GridDataItem Then
    '        Dim editButton As LinkButton = DirectCast(e.Item.FindControl("btnViewClient"), LinkButton)
    '        editButton.Attributes("href") = "javascript:void(0);"
    '        editButton.Attributes("onclick") = [String].Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex)("clientID"), e.Item.ItemIndex)
    '    End If
    'End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM tblClient order by {0}", field)

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

    'Protected Sub RadAjaxManager1_AjaxRequest(ByVal sender As Object, ByVal e As AjaxRequestEventArgs) Handles RadAjaxManager1.AjaxRequest
    '    If e.Argument = "Rebind" Then
    '        ClientList.MasterTableView.SortExpressions.Clear()
    '        ClientList.MasterTableView.GroupByExpressions.Clear()
    '        ClientList.Rebind()
    '    ElseIf e.Argument = "RebindAndNavigate" Then
    '        ClientList.MasterTableView.SortExpressions.Clear()
    '        ClientList.MasterTableView.GroupByExpressions.Clear()
    '        ClientList.MasterTableView.CurrentPageIndex = ClientList.MasterTableView.PageCount - 1
    '        ClientList.Rebind()
    '    End If
    'End Sub

End Class