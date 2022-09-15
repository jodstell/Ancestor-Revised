Public Class updateInvoice
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim db As New DataClassesDataContext

        Dim q = From p In db.tblInvoices

        For Each p In q
            Dim Supplier = (From r In db.tblSuppliers Where r.supplierID = p.supplierID Select r).FirstOrDefault

            Dim BillTo As String = Supplier.supplierName & Environment.NewLine & Supplier.invoiceHeader


            Dim a = (From z In db.tblInvoices Where z.invoiceID = p.invoiceID Select z).FirstOrDefault

            a.BillTo = BillTo
            db.SubmitChanges()

        Next


    End Sub
End Class