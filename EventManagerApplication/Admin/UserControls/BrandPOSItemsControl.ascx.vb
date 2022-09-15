Imports Telerik.Web.UI

Public Class BrandPOSItemsControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim q = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p.brandGroupID).FirstOrDefault

        If q Is Nothing Then
            HiddenBrandGroupID.Value = 0
        Else
            HiddenBrandGroupID.Value = q
        End If


    End Sub

    Private Sub BrandEventTaskList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles BrandPOSList.ItemCommand
        If e.CommandName = "AddNewItem" Then
            Response.Redirect("AddNewItem.aspx?ClientID=" & Request.QueryString("ClientID") & "&BrandID=" & Request.QueryString("BrandID"))
        End If
    End Sub

    Private Sub getInventoryList_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles getInventoryList.Deleted
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()

        RadNotification1.Show()
    End Sub

    Private Sub getInventoryList_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles getInventoryList.Inserted
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()

        RadNotification1.Show()
    End Sub

    Private Sub getInventoryList_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles getInventoryList.Updated
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()

        RadNotification1.Show()
    End Sub

    Function getOnHandQuantity(id As Integer) As String
        Try
            Return (From p In db.qryInventoryLists Where p.itemID = id Select p.balance).FirstOrDefault

        Catch ex As Exception
            Return "0"
        End Try
    End Function
End Class