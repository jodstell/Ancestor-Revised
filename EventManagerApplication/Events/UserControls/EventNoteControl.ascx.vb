Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class EventNoteControl
    Inherits System.Web.UI.UserControl
    Dim db1 As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub getNotes_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getNotes.Inserting

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Dim i As tblEventNote
        i = CType(e.NewObject, tblEventNote)
        i.eventID = Request.QueryString("ID")
        i.createdBy = currentUser.Id
        i.dateCreated = Date.Now()
    End Sub

    Private Sub getNotes_Updating(sender As Object, e As LinqDataSourceUpdateEventArgs) Handles getNotes.Updating

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())


        Dim originalNote As tblEventNote
        Dim newNote As tblEventNote

        originalNote = CType(e.OriginalObject, tblEventNote)
        newNote = CType(e.NewObject, tblEventNote)

        newNote.dateModified = Date.Now()
        newNote.modifiedBy = currentUser.Id


    End Sub

    Function getFullName(ByVal id As String) As String
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(id)

        Dim result = (From p In db1.AspNetUsersProfiles Where p.UserID = currentUser.Id Select p).FirstOrDefault

        Return String.Format("{0} {1}", result.FirstName, result.LastName)

    End Function
    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

End Class