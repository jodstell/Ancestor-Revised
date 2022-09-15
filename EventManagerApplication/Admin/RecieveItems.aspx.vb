Imports System.Data.SqlClient
Imports Telerik.Web.UI

Public Class RecieveItems
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Page.Title = "Receive Inventory Item"

        RecievedDateTextBox.SelectedDate = Date.Now()


        If Not Page.IsPostBack Then

            If Request.QueryString("itemID") IsNot Nothing Then

                Dim itemID = Request.QueryString("itemID")

                Dim q = (From p In db.tblInventoryItems Where itemID = p.itemID Select p).FirstOrDefault

                LoadItems(q.brandID)

                SupplierComboBox.SelectedValue = q.brandID
                ItemComboBox.SelectedValue = q.itemID

                LoadPhoto(itemID)

            End If

        End If


    End Sub

    Private Sub btnSubmitInventory_Click(sender As Object, e As EventArgs) Handles btnSubmitInventory.Click

        'save item
        Dim item As New tblInventory
        item.itemID = ItemComboBox.SelectedValue
        item.quantity = QtyTextBox.Text
        item.action = "Received"
        item.location = "Plano, TX"
        item.date = RecievedDateTextBox.SelectedDate
        item.note = NotesTextBox.Text

        db.tblInventories.InsertOnSubmit(item)
        db.SubmitChanges()

        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", True)

    End Sub

    Private Sub SupplierComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles SupplierComboBox.SelectedIndexChanged

        ItemComboBox.Text = ""

        ItemComboBox.Items.Clear()

        ItemComboBox.Text = ""

        LoadItems(e.Value)


    End Sub

    Protected Sub LoadItems(ByVal brandID As String)

        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        ' Select a country based on the continentID.

        Dim adapter As New SqlDataAdapter("SELECT * FROM [tblInventoryItem] where brandID = @brandID", connection)

        adapter.SelectCommand.Parameters.AddWithValue("@brandID", brandID)


        Dim dt As New DataTable()

        adapter.Fill(dt)


        ItemComboBox.DataSource = dt

        ItemComboBox.DataBind()

    End Sub

    Private Sub btnCancelEditExpense_Click(sender As Object, e As EventArgs) Handles btnCancelEditExpense.Click

        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", True)

    End Sub


    Private Sub ItemComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles ItemComboBox.SelectedIndexChanged

        LoadPhoto(e.Value)


    End Sub

    Protected Sub LoadPhoto(ByVal itemID As String)

        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        ' Select a country based on the continentID.

        Dim adapter As New SqlDataAdapter("SELECT * FROM [tblInventoryItem] where itemID = @itemID", connection)

        adapter.SelectCommand.Parameters.AddWithValue("@itemID", itemID)


        Dim dt As New DataTable()

        adapter.Fill(dt)


        PhotoItemRepeater.DataSource = dt

        PhotoItemRepeater.DataBind()

    End Sub

End Class