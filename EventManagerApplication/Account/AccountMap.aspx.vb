Imports BingGeocoder

Public Class AccountMap
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim AccountID = Request.QueryString("AccountID")
        Dim q = (From p In db.tblAccounts Where p.accountID = AccountID Select p).FirstOrDefault

        LatitudeTextBox.Value = q.latitude
        LongtitudeTextBox.Value = q.longitude

    End Sub

End Class