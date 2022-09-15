Public Class AddInventoyControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim q = (From p In db.qryInventoryLists Where p.brandID = Request.QueryString("BrandID") And p.itemID = Request.QueryString("ItemID") Select p)

        For Each p In q
            ItemTitleLabel.Text = p.itemName
            BalanceLabel.Text = p.balance
            ItemNameLabel.Text = p.itemName
            ItemNameLabel2.Text = p.itemName
        Next

        Try
            BrandNameLabel.Text = getBrandName(Convert.ToInt32(Request.QueryString("BrandID")))
            BrandNameLabel2.Text = getBrandName(Convert.ToInt32(Request.QueryString("BrandID")))
        Catch ex As Exception

        End Try


        RecievedDateTextBox.SelectedDate = Date.Now()

    End Sub

    Private Sub btnAdd_Click(sender As Object, e As EventArgs) Handles btnAdd.Click
        AddNewPanel.Visible = True
        ViewPanel.Visible = False
    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        AddNewPanel.Visible = False
        ViewPanel.Visible = True
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        'save item
        Dim item As New tblInventory
        item.itemID = Request.QueryString("ItemID")
        item.quantity = QtyTextBox.Text
        item.action = "Received"
        item.location = "Plano, TX"
        item.date = RecievedDateTextBox.SelectedDate
        item.note = NotesTextBox.Text

        db.tblInventories.InsertOnSubmit(item)
        db.SubmitChanges()


        AddNewPanel.Visible = False
        ViewPanel.Visible = True

    End Sub

    Private Sub btnUpdateCount_Click(sender As Object, e As EventArgs) Handles btnUpdateCount.Click

        ViewPanel.Visible = False
        UpdateInventoryPanel.Visible = True

    End Sub

    Private Sub btnCancelUpdateInventory_Click(sender As Object, e As EventArgs) Handles btnCancelUpdateInventory.Click

        ViewPanel.Visible = True
        UpdateInventoryPanel.Visible = False

    End Sub

    Private Sub btnSubmitInventory_Click(sender As Object, e As EventArgs) Handles btnSubmitInventory.Click

        Dim itemID = Request.QueryString("itemID")

        Try
            db.UpdateInventoryItemCount(itemID, NewInventoryCountTextBox.Text, NotesTextBox.Text)

            ViewPanel.Visible = True
            UpdateInventoryPanel.Visible = False

        Catch ex As Exception
            ' msgLabel.Text = ex.Message()
        End Try



    End Sub

    Function getBrandName(brandID As Integer) As String

        Return (From p In db.tblBrands Where p.brandID = brandID Select p.brandName).FirstOrDefault
    End Function
End Class