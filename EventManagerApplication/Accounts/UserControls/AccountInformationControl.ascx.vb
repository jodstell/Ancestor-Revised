Imports BingGeocoder
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

Public Class AccountInformationControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    'Public Sub ReturnHttp(twitter As String)
    '    Dim str = String.Format("http//") + twitter.ToString
    'End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Then
            Response.Redirect("/AccessDenied")
        End If

    End Sub

    Private Sub getAccountInformation_Updating(sender As Object, e As LinqDataSourceUpdateEventArgs) Handles getAccountInformation.Updating

        Dim originalAccount As tblAccount
        Dim newAccount As tblAccount

        originalAccount = CType(e.OriginalObject, tblAccount)
        newAccount = CType(e.NewObject, tblAccount)

        If (originalAccount.streetAddress1 <> newAccount.streetAddress1) Then

            Dim address As String = String.Format("{0}, {1}, {2}, {3}", newAccount.streetAddress1.Replace("#", ""), newAccount.city, newAccount.state, newAccount.zipCode)

            newAccount.latitude = getLatitude(address)
            newAccount.longitude = getLongitude(address)

        End If

        newAccount.modifiedDate = Date.Now()

    End Sub

    Function HasValue(val As String) As String

        If val = "" Or Nothing Then
            Return "False"
        Else
            Return "True"
        End If

    End Function



    Function getLatitude(ByVal address As String) As String

        Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

        Dim geocoder = New BingGeocoderClient(BingKey)
        Dim result = New BingGeocoderResult()
        result = geocoder.Geocode(address)

        Return result.Latitude

    End Function

    Function getLongitude(ByVal address As String) As String

        Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

        Dim geocoder = New BingGeocoderClient(BingKey)
        Dim result = New BingGeocoderResult()
        result = geocoder.Geocode(address)

        Return result.Longitude

    End Function

    Private Sub AccountInformation_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles AccountInformation.ItemCommand

        If e.CommandName = "DeleteAccount" Then

            Dim id = (From p In db.tblAccounts Where p.accountID = Request.QueryString("AccountID") Select p.Vpid).FirstOrDefault

            'check if there are events
            Dim q = (From p In db.tblEvents Where p.locationID = id Select p).Count

            If q <> 0 Then

                msgLabel.Text = Common.ShowAlert("warning", "You can not deleted an account that has events assigned.")

            Else

                db.DeleteAccount(Convert.ToInt32(e.CommandArgument))
                db.SubmitChanges()

                Response.Redirect("/Accounts/ViewAccounts?Action=3&LoadState=Yes")
            End If





        End If



    End Sub
End Class