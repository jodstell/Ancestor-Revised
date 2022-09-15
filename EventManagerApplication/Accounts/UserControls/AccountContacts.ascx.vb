Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class AccountContacts
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext
    Dim currentUser


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim manager = New UserManager()
        currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
    End Sub

    Private Sub getContacts_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getContacts.Inserting
        Try

            Dim l As tblAccountContact
            l = CType(e.NewObject, tblAccountContact)
            l.accountID = Request.QueryString("AccountID")
            l.dateCreated = Date.Now()
            l.createdBy = currentUser.Id


            db.UpdateAccountModifiedDate(l.accountID, currentUser.id)

        Catch ex As Exception

        End Try



    End Sub

    Private Sub getContacts_Updating(sender As Object, e As LinqDataSourceUpdateEventArgs) Handles getContacts.Updating

        Dim originalContact As tblAccountContact
        Dim newContact As tblAccountContact

        originalContact = CType(e.OriginalObject, tblAccountContact)
        newContact = CType(e.NewObject, tblAccountContact)

        newContact.dateModified = Date.Now()
        newContact.modifiedBy = currentUser.Id

        db.UpdateAccountModifiedDate(originalContact.accountID, currentUser.id)


    End Sub

    Private Sub getContacts_Deleting(sender As Object, e As LinqDataSourceDeleteEventArgs) Handles getContacts.Deleting

        Dim originalContact As tblAccountContact
        originalContact = CType(e.OriginalObject, tblAccountContact)

        db.UpdateAccountModifiedDate(originalContact.accountID, currentUser.id)

    End Sub

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class
End Class