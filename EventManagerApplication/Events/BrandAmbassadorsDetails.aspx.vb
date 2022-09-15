Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class BrandAmbassadorsDetails
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim userdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim q = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault
        bindAccount(q.locationID)

        Dim a = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault

        FromAddressLatitude.Text = a.latitude
        FromAddressLongtitude.Text = a.longitude
        'txtFromAddress.Text = String.Format("{0}, {1}, {2} {3}", a.Address1, a.City, a.State, a.Zip)
        LocationName.Text = String.Format("{0}, {1}, {2} {3}", a.Address1, a.City, a.State, a.Zip)
        LocationName2.Text = String.Format("{0}, {1}, {2} {3}", a.Address1, a.City, a.State, a.Zip)

        Dim Ambassador = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault

        AmbassadorNameLabel.Text = String.Format("{0} {1}", Ambassador.FirstName, Ambassador.LastName)

        'FirstName.Text = Ambassador.FirstName
        'LastName.Text = Ambassador.LastName
        'EmailAddress.Text = Ambassador.EmailAddress
        'DateofBirth.Text = Ambassador.DOB
        'Phone.Text = Ambassador.Phone

    End Sub

    Sub bindAccount(ByVal id As String)
        Dim q = (From p In db.tblAccounts Where p.Vpid = id Select p).FirstOrDefault

        'populate labels
        LatitudeTextBox.Text = q.latitude
        LongtitudeTextBox.Text = q.longitude
        ToAdress.Text = String.Format("{0}, {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)
        ToAdress2.Text = String.Format("{0}, {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)
        AccountNameLabel1.Text = q.accountName

    End Sub

End Class