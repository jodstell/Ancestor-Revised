Imports System.Collections.Generic
Imports Telerik.Web.UI

Public Class BrandsControl
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


    Protected Sub SelectedBrandsList_Inserted1(sender As Object, e As RadListBoxEventArgs)
        Try
            'get the brandID
            LogEvent(sender, "Inserted", e.Items)

            Dim supplierID As Integer = Request.QueryString("SupplierID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'insert the item
            db.InsertSupplierBrand(supplierID, selectedValue)
            db.SubmitChanges()

            'rebind the lists
            '  SelectedBrandsList.DataBind()
            ' AssociatedBrandsList.DataBind()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Protected Sub SelectedBrandsList_Deleted1(sender As Object, e As RadListBoxEventArgs)
        Try
            'get the brandID
            LogEvent(sender, "Deleted", e.Items)

            Dim supplierID As Integer = Request.QueryString("SupplierID")
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'delete the item
            db.DeleteSupplierBrand(supplierID, selectedValue)
            db.SubmitChanges()

            'rebind the grids
            ' SelectedBrandsList.DataBind()
            ' AssociatedBrandsList.DataBind()

            msgLabel.Text = ""

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub
End Class