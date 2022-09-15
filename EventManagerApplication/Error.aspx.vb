Imports Microsoft.AspNet.Identity

Public Class ErrorPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Request.QueryString("aspxerrorpath") = "/Events/ViewEvents" Then
                Response.Redirect("/Events/ViewEvents")
            End If

            SendEmail()

        End If



    End Sub


    Protected Sub LoadError(objError As Exception)
        If objError IsNot Nothing Then
            Dim lasterror As New StringBuilder()

            If objError.Message IsNot Nothing Then
                lasterror.AppendLine("Message:")
                lasterror.AppendLine(objError.Message)
                lasterror.AppendLine()
            End If

            If objError.InnerException IsNot Nothing Then
                lasterror.AppendLine("InnerException:")
                lasterror.AppendLine(objError.InnerException.ToString())
                lasterror.AppendLine()
            End If

            If objError.Source IsNot Nothing Then
                lasterror.AppendLine("Source:")
                lasterror.AppendLine(objError.Source)
                lasterror.AppendLine()
            End If

            If objError.StackTrace IsNot Nothing Then
                lasterror.AppendLine("StackTrace:")
                lasterror.AppendLine(objError.StackTrace)
                lasterror.AppendLine()
            End If

            ViewState.Add("LastError", lasterror.ToString())
        End If
    End Sub

    Protected Sub btnReportError_Click(sender As Object, e As EventArgs)
        SendEmail()
    End Sub

    Public Sub SendEmail()
        Try

            Dim ErrMessage As New StringBuilder()


            ErrMessage.AppendLine("There was an error on:")
            ErrMessage.AppendLine(Request.QueryString("aspxerrorpath"))
            ErrMessage.AppendLine("<br>")

            ErrMessage.AppendLine("UserID:")
            ErrMessage.AppendLine(Context.User.Identity.GetUserId())
            ErrMessage.AppendLine("<br>")

            ErrMessage.AppendLine("UserAgent:")
            ErrMessage.AppendLine(Request.UserAgent.ToString().ToLower())
            ErrMessage.AppendLine("<br>")

            Try
                ErrMessage.AppendLine("User Name:")
                ErrMessage.AppendLine(Common.GetFullName(Context.User.Identity.GetUserId()))
                ErrMessage.AppendLine("<br>")
            Catch ex As Exception

            End Try


            MailHelper.SendMailMessage("no-reply@gigengyn.com", "There was an Opps event on GigEngyn", ErrMessage.ToString())

        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnSendReport_Click(sender As Object, e As EventArgs) Handles btnSendReport.Click

        Try

            Dim ErrMessage As New StringBuilder()


            ErrMessage.AppendLine("There was an error on:")
            ErrMessage.AppendLine(Request.QueryString("aspxerrorpath"))
            ErrMessage.AppendLine()

            ErrMessage.AppendLine("UserID:")
            ErrMessage.AppendLine(Context.User.Identity.GetUserId())
            ErrMessage.AppendLine()

            Try
                ErrMessage.AppendLine("User Name:")
                ErrMessage.AppendLine(Common.GetFullName(Context.User.Identity.GetUserId()))
                ErrMessage.AppendLine()
            Catch ex As Exception

            End Try


            If commentTextBox.Text = "" Then

            Else

                Dim body =
                     <body>There was an Opps event on ProofMktg
                        <table cellspacing='1' cellpadding='1'>
                          <tr>
                                 <td>User Name:</td>
                                 <td><%= Common.GetFullName(Context.User.Identity.GetUserId()) %></td>

                          </tr>
                             <tr>
                                 <td>Error Page:</td>
                                 <td><%= Request.QueryString("aspxerrorpath") %></td>
                             </tr>

                             <tr>
                                 <td>Comment:</td>
                                 <td><%= commentTextBox.Text %></td>
                             </tr> 
                        </table>
                      </body>
                MailHelper.SendMailMessage("support@bletsianlms.com", "There was an Opps event on ProofMktg", body.ToString())

                MainPanel.Visible = False
                SuccessPanel.Visible = True
            End If


        Catch ex As Exception

        End Try

    End Sub
End Class