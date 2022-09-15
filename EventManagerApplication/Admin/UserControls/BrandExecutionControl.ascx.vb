Public Class BrandExecutionControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getEventTypeTitle(ByVal eventtypeid As Integer) As String

        Return (From p In db.tblEventTypes Where p.eventTypeID = eventtypeid Select p.eventTypeName).FirstOrDefault
    End Function

    Private Sub getBrandExecutionList_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getBrandExecutionList.Inserting

        Dim l As tblBrandEventExecution
        l = CType(e.NewObject, tblBrandEventExecution)
        l.brandID = Request.QueryString("BrandID")


    End Sub

    Private Sub getBrandExecutionList_Inserted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getBrandExecutionList.Inserted
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub

    Private Sub getBrandExecutionList_Updated(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getBrandExecutionList.Updated
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub

    Private Sub getBrandExecutionList_Deleted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getBrandExecutionList.Deleted
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub
End Class