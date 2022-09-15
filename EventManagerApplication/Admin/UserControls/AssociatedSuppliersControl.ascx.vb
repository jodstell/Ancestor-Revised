Imports Telerik.Web.UI

Public Class AssociatedSuppliersControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



    End Sub

    Private Sub LogEvent(ByVal sender As Object, ByVal eventName As String, ByVal items As IEnumerable(Of RadListBoxItem))

        Dim affectedItems As New List(Of String)()

        For Each item As RadListBoxItem In items
            affectedItems.Add(item.Value)
        Next

        Dim message As String = String.Format("{0}", affectedItems.ToArray())
        HF_SelectedItemID.Value = message

    End Sub



    Protected Sub SelectedSuppliers_Inserted1(sender As Object, e As RadListBoxEventArgs)
        Try
            'get the brandID
            LogEvent(sender, "Inserted", e.Items)

            Dim brandID As Integer = Request.QueryString("BrandID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'insert the item
            db.InsertSupplierBrand(selectedValue, brandID)


            Dim r = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
            r.modifiedBy = Session("CurrentUserID")
            r.modifiedDate = Date.Now()

            db.SubmitChanges()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Protected Sub SelectedSuppliers_Deleted1(sender As Object, e As RadListBoxEventArgs)
        Try
            'get the supplierID
            LogEvent(sender, "Deleted", e.Items)

            Dim brandID As Integer = Request.QueryString("BrandID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'delete the item
            db.DeleteSupplierBrand(selectedValue, brandID)

            Dim r = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
            r.modifiedBy = Session("CurrentUserID")
            r.modifiedDate = Date.Now()

            db.SubmitChanges()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub
End Class