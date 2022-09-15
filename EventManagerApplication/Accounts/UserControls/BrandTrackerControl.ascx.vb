Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports xi = Telerik.Web.UI.ExportInfrastructure
Imports System.Web.UI
Imports System.Web
Imports Telerik.Web.UI.GridExcelBuilder
Imports System.Drawing
Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class BrandTrackerControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.ClientIDHiddenField.Value = "18"

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Then
            Response.Redirect("/AccessDenied")

        End If

    End Sub

    Function formatBoolean(ByVal value As String) As String
        Select Case value
            Case "True"
                Return "Yes"
            Case "False"
                Return "No"
            Case ""
                Return "-"
        End Select
        Return "-"
    End Function

    Function getBrandName(ByVal id As Integer) As String
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function

    Private Sub getAccountsBrandTrcker_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getAccountsBrandTrcker.Inserting
        Dim item As tblAccountBrandTracker
        item = CType(e.NewObject, tblAccountBrandTracker)
        item.accountID = Request.QueryString("AccountID")
    End Sub
End Class