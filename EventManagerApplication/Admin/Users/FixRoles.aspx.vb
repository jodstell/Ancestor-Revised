Public Class FixRoles
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim db As New DataClassesDataContext
        Dim usersdb As New LMSDataClassesDataContext

        Dim q = From p In usersdb.AspNetUserRoles Where p.RoleId = TextBox1.Text Select p

        For Each p In q
            Try
                ' add to profile
                Dim i = (From r In db.tblProfiles Where r.userID = p.UserId Select r).FirstOrDefault
                i.role = TextBox2.Text
                db.SubmitChanges()
            Catch ex As Exception

            End Try


        Next


    End Sub
End Class