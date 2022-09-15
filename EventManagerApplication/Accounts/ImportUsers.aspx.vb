Imports LinqToExcel
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin
Imports BingGeocoder
Imports Microsoft.AspNet.Identity.EntityFramework
Imports CoreLibrary

Public Class ImportUsers
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim count As Integer = 0
    Dim failed As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


    End Sub

    Private Sub btnImport_Click(sender As Object, e As EventArgs) Handles btnImport.Click

        Dim userdb As New LMSDataClassesDataContext

        Try
            count = 0

            Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/client.xls"))

            Dim import = From x In excel.Worksheet(Of UserList)("Staff")
                         Select x

            For Each u In import
                Try

                    Dim userName As String = u.UserName
                    Dim manager = New UserManager()
                    manager.UserValidator = New UserValidator(Of ApplicationUser)(manager) With {.AllowOnlyAlphanumericUserNames = False}

                    Dim user = New ApplicationUser() With {.UserName = userName}
                    Dim result = manager.Create(user, u.Password)
                    If result.Succeeded Then

                        manager.AddToRole(user.Id, "Client")
                        manager.Update(user)

                        Dim newUser As New tblProfile
                        newUser.firstName = u.FirstName
                        newUser.lastName = u.LastName
                        newUser.userID = user.Id
                        newUser.staffID = u.ID
                        newUser.lastLoginDate = "1/1/2000"
                        newUser.lastActivityDate = "1/1/2000"
                        newUser.enableAllClients = True
                        newUser.enableAllMarkets = True
                        newUser.enableAllSuppliers = True
                        newUser.timeZone = "Central Standard Time"
                        newUser.IsOnline = False
                        newUser.IsStaff = True

                        db.tblProfiles.InsertOnSubmit(newUser)
                        db.SubmitChanges()

                        Dim newStaffClient As New tblStaffClient
                        newStaffClient.clientID = u.ClientID
                        newStaffClient.userID = user.Id

                        db.tblStaffClients.InsertOnSubmit(newStaffClient)
                        db.SubmitChanges()


                        Dim newStaffSupplier As New tblStaffSupplier
                        newStaffSupplier.supplierID = u.SupplierID
                        newStaffSupplier.userID = user.Id

                        db.tblStaffSuppliers.InsertOnSubmit(newStaffSupplier)
                        db.SubmitChanges()


                    Else
                        msgLabel.Text = "1. " & result.Errors.FirstOrDefault()

                    End If

                    count = count + 1
                Catch ex As Exception
                    failed = failed + 1
                End Try
            Next

            msgLabel.Text = count & " records have been added.  " & failed & " records failed."
        Catch ex As Exception
            msgLabel.Text = "2. " & ex.Message
        End Try

    End Sub

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

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

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim userdb As New LMSDataClassesDataContext


        Try


            count = 0

            Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/2_people.xls"))

            Dim import = From x In excel.Worksheet(Of AmbassadorList)("ambassador")
                         Select x

            For Each u In import


                Try

                    'insert into applicant

                    Dim applicant As New Applicant
                    applicant.dbGUID = u.UserName
                    applicant.FirstName = u.FirstName
                    applicant.LastName = u.LastName
                    applicant.Address = u.StreetAddress1
                    applicant.City = u.City
                    applicant.State = u.State
                    applicant.Zip = u.Zip
                    applicant.Phone = u.Phone
                    ' applicant.DOB = u.DOB
                    applicant.SiteID = "GigEngyn"
                    ' applicant.RegistrationDate = Date.Now()
                    ' applicant.LastLoginDate = u.LastLogin
                    applicant.EmailAddress = u.Email
                    applicant.IsOnline = False
                    applicant.TimeZone = "Central Standard Time"
                    applicant.CultureInfoCode = "en-US"
                    applicant.Status = "Active"

                    userdb.Applicants.InsertOnSubmit(applicant)
                    userdb.SubmitChanges()


                    Dim newuser As New AspNetUsersProfile With {.UserID = "6a58cab8-9aef-434d-af79-a244e4018c48",
                                                                     .TimeZone = "Central Standard Time",
                                                                      .SiteID = "GigEngyn",
                                                                      .FirstName = u.FirstName,
                                                                      .LastName = u.LastName,
                                                                      .RegistrationDate = Date.Now(),
                                                                      .InvitationCode = "",
                                                                      .DOB = u.DOB,
                                                                      .Address = u.StreetAddress1,
                                                                      .Address2 = u.StreetAddress2,
                                                                      .City = u.City,
                                                                      .State = u.State,
                                                                      .PostCode = u.Zip,
                                                                      .Phone1 = u.Phone,
                                                                      .ChangePasswordRequired = False,
                                                                      .Status = "Active"}

                    userdb.AspNetUsersProfiles.InsertOnSubmit(newuser)
                    userdb.SubmitChanges()

                    msgLabel.Text = "User Added"
                Catch ex As Exception
                    msgLabel.Text = ex.Message
                End Try

            Next

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try

    End Sub
End Class