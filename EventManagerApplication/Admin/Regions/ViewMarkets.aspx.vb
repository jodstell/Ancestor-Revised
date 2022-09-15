Public Class ViewMarkets
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getAccountsCount(ByVal marketID As Integer) As Integer

        Return (From p In db.tblAccounts Where p.marketID = marketID Select p).Count

    End Function

End Class