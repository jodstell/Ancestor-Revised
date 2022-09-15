Imports System.Web
Imports System.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Microsoft.Owin.Security
Imports Owin
Imports System.Reflection
Imports System.IO

Public Class Login1
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'RegisterHyperLink.NavigateUrl = "Register"
        '' Enable this once you have account confirmation enabled for password reset functionality
        '' ForgotPasswordHyperLink.NavigateUrl = "Forgot"
        'OpenAuthLogin.ReturnUrl = Request.QueryString("ReturnUrl")
        'Dim returnUrl = HttpUtility.UrlEncode(Request.QueryString("ReturnUrl"))
        'If Not [String].IsNullOrEmpty(returnUrl) Then
        '    RegisterHyperLink.NavigateUrl += "?ReturnUrl=" & returnUrl
        'End If

        lblASPVersion.Text = String.Format("Build: {0} ", System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString())



    End Sub

    Protected Sub LogIn(sender As Object, e As EventArgs)
        If IsValid Then
            ' Validate the user password
            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim signinManager = Context.GetOwinContext().GetUserManager(Of ApplicationSignInManager)()

            ' This doen't count login failures towards account lockout
            ' To enable password failures to trigger lockout, change to shouldLockout := True
            Dim result = signinManager.PasswordSignIn(frmUserName.Text, frmPassword.Text, RememberMe.Checked, shouldLockout:=False)

            Select Case result
                Case SignInStatus.Success
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
                    Exit Select

                Case SignInStatus.LockedOut
                    Response.Redirect("/Account/Lockout")
                    Exit Select

                Case SignInStatus.RequiresVerification
                    Response.Redirect(String.Format("/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}",
                                                    Request.QueryString("ReturnUrl"),
                                                    RememberMe.Checked),
                                      True)
                    Exit Select

                Case Else
                    errLabel.Text = "<div class='alert alert-warning'><strong>Warning!</strong> You must enter your registered email address and password to access this site.</div>"
                    Exit Select
            End Select
        End If
    End Sub

    Private Sub LoginButton_Click(sender As Object, e As EventArgs) Handles LoginButton.Click
        If IsValid Then
            ' Validate the user password
            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim signinManager = Context.GetOwinContext().GetUserManager(Of ApplicationSignInManager)()

            ' This doen't count login failures towards account lockout
            ' To enable password failures to trigger lockout, change to shouldLockout := True
            Dim result = signinManager.PasswordSignIn(frmUserName.Text, frmPassword.Text, RememberMe.Checked, shouldLockout:=False)

            Select Case result
                Case SignInStatus.Success

                    Dim user As ApplicationUser = manager.Find(frmUserName.Text, frmPassword.Text)

                    Try
                        'update the lastLoginDate

                        Dim isFirstLogin = (From p In db.tblProfiles Where p.userID = user.Id Select p.hasLoggedIn).FirstOrDefault
                        If isFirstLogin = True Then
                            isFirstLogin = False
                        Else
                            isFirstLogin = True
                        End If

                        db.UpdateLastLoggedInDate(user.Id, isFirstLogin, HttpContext.Current.Request.UserHostAddress, "Windows 10")


                    Catch ex As Exception
                        'something bad happened.
                    End Try

                    'If manager.IsInRole(currentUser.Id, "GlobalAdmin") Then

                    'Else

                    'End If

                    IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
                    Exit Select

                Case SignInStatus.LockedOut
                    Response.Redirect("/Account/Lockout")
                    Exit Select

                Case SignInStatus.RequiresVerification
                    Response.Redirect(String.Format("/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}",
                                                    Request.QueryString("ReturnUrl"),
                                                    RememberMe.Checked),
                                      True)
                    Exit Select

                Case Else
                    errLabel.Text = "<div class='alert alert-warning'><strong>Warning!</strong> The username or password you entered is incorrect.</div>"
                    Exit Select

            End Select
            errLabel.Text = "<div class='alert alert-warning'><strong>Warning!</strong> The username or password you entered is incorrect.</div>"
        Else

        End If
    End Sub

    Protected Sub PassordLink_Click(sender As Object, e As EventArgs)
        LoginPanel.Visible = False
        ForgotPasswordPanel.Visible = True
    End Sub


    Private Sub btnRequestPassword_Click(sender As Object, e As EventArgs) Handles btnRequestPassword.Click

        'check if valid username
        Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
        Dim user As ApplicationUser = manager.FindByName(UserNameTextBox.Text)

        If user Is Nothing Then
            errorLabel.Text = Common.ShowAlertNoClose("warning", "The user either does not exist or is not confirmed.")
            Return
        End If

        'send email
        Try
            Dim password As String = (From p In db.tblProfiles Where p.userID = user.Id Select p.userGUID).FirstOrDefault

            Dim q = (From p In db.tblMessages Where p.messageID = 1 Select p).FirstOrDefault

            'get my html file
            ' Dim reader As New StreamReader(Server.MapPath("~/Files/PasswordRequest.html"))
            ' Dim readFile As String = reader.ReadToEnd()
            Dim myString As String = ""
            myString = q.messageText
            myString = myString.Replace("[AmbassadorFirstName]", (From p In db.tblProfiles Where p.userID = user.Id Select p.firstName).FirstOrDefault)
            myString = myString.Replace("[AmbassadorLastName]", (From p In db.tblProfiles Where p.userID = user.Id Select p.lastName).FirstOrDefault)
            myString = myString.Replace("[Password]", (From p In db.tblProfiles Where p.userID = user.Id Select p.userGUID).FirstOrDefault)
            myString = myString.Replace("[LoginURL]", "http://events.gigengyn.com/")

            Dim recipient = user.Email

            'send email
            MailHelper.SendEmailMessage(1, recipient, q.fromAddress, q.fromName, q.subject, myString.ToString())

            LoginPanel.Visible = True
            ForgotPasswordPanel.Visible = False

            msgLabel.Text = Common.ShowAlertNoClose("success", "Your request has been sent to the email on file.  Check your email for your password.")

            '  reader.Close()

        Catch ex As Exception
            errorLabel.Text = ex.Message
        End Try



    End Sub

    Private Sub btnGoBack_Click(sender As Object, e As EventArgs) Handles btnGoBack.Click
        LoginPanel.Visible = True
        ForgotPasswordPanel.Visible = False
    End Sub
End Class