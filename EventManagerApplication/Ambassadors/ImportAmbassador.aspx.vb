Imports CoreLibrary
Imports LinqToExcel
Imports Microsoft.AspNet.Identity
Public Class ImportAmbassador
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub btnImport_Click(sender As Object, e As EventArgs) Handles btnImport.Click

        Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/Ambassadors.xls"))

        'add asp.net user and roles

        Dim users = From x In excel.Worksheet(Of UserList)("batch1")
                    Select x

        For Each u In users

            Dim userName As String = u.EmailAddress
            Dim manager = New UserManager()
            manager.UserValidator = New UserValidator(Of ApplicationUser)(manager) With {.AllowOnlyAlphanumericUserNames = False}

            manager.PasswordValidator = New PasswordValidator() With {
                    .RequiredLength = 4,
                    .RequireNonLetterOrDigit = False,
                    .RequireDigit = False,
                    .RequireLowercase = False,
                    .RequireUppercase = False
                }

            Dim user = New ApplicationUser() With {.UserName = userName}
            Dim result = manager.Create(user, "slicker2022")

        Next

    End Sub
End Class