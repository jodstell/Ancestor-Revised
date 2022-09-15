Public Class Directions
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        bindEvent()
    End Sub

    Sub bindEvent()
        Dim q = (From p In db.tblEvents Where p.eventID = Request.QueryString("EventID") Select p).FirstOrDefault

        'bind account by locationID
        bindAccount(q.locationID)

    End Sub

    Sub bindAccount(ByVal id As String)



        Dim q = (From p In db.tblAccounts Where p.Vpid = id Select p).FirstOrDefault

        'populate labels
        '   Me.AccountNameLabel1.Text = q.accountName
        Me.LatitudeTextBox.Value = q.latitude
        Me.LongtitudeTextBox.Value = q.longitude
        ' Me.CityLabel.Text = q.city & ", " & q.state

        '  Me.AccountAddressLabel1.Text = String.Format("{0} {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)



    End Sub

End Class