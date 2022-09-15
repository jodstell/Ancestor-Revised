Public Class BrandEventTasksControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub getBrandEventTasks_Deleted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getBrandEventTasks.Deleted
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub

    Private Sub getBrandEventTasks_Inserted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getBrandEventTasks.Inserted
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub

    Private Sub getBrandEventTasks_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getBrandEventTasks.Inserting
        Dim task As tblBrandEventTask
        task = CType(e.NewObject, tblBrandEventTask)
        task.brandID = Request.QueryString("BrandID")

    End Sub

    Private Sub getBrandEventTasks_Updated(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getBrandEventTasks.Updated
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub
End Class