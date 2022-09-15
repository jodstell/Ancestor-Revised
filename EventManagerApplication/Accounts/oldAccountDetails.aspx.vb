Public Class AccountDetails
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        bindAccount(Request.QueryString("AccountID"))

    End Sub

    Sub bindAccount(ByVal id As String)
        Dim q = (From p In db.tblAccounts Where p.accountID = id Select p).FirstOrDefault

        'populate labels
        Me.AccountNameLabel.Text = q.accountName
        Me.LatitudeTextBox.Value = q.latitude
        Me.LongtitudeTextBox.Value = q.longitude
        Me.LocationTextBox.Value = q.city & ", " & q.state
        ' Me.CityLabel.Text = q.city & ", " & q.state

        ' Me.AccountHyperLink1.NavigateUrl = "/Accounts/AccountDetails?AccountID=" & q.accountID

        Me.LocationLabel.Text = String.Format("{0} {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)



    End Sub



End Class