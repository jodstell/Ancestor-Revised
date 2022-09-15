Public Class SupplierDetails
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = Common.GetCurrentClientID() Select p.clientName).FirstOrDefault

        BindForm()


        If Me.IsPostBack Then

            '  TabName.Value = Request.Form(TabName.UniqueID)

        End If

    End Sub

    Private Sub BindForm()

        Dim result = From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID")
        For Each p In result
            Me.SupplierNameTextBox.Text = p.supplierName
            Me.SupplierNameLabel.Text = p.supplierName
        Next

    End Sub

   
    Private Sub getSupplier_Updated(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getSupplier.Updated
        msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
    End Sub
   

   

   
End Class