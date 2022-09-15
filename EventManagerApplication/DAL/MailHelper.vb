Imports System.Net.Mail
Imports SendGrid
Imports SendGrid.Helpers.Mail
Imports System.Threading.Tasks

Public Class MailHelper

    Public Shared Sub SendEmailMessage(ByVal messageID As Integer, ByVal recepient As String, ByVal fromAddress As String, fromName As String, ByVal subject As String, ByVal body As String)

        Try
            Dim db As New DataClassesDataContext

            Dim oMail As New System.Net.Mail.MailMessage()

            oMail.From = New System.Net.Mail.MailAddress(fromAddress, fromName)

            oMail.To.Add(recepient) 'Send to user

            Dim bcc = (From p In db.tblMessageBccs Where p.messageID = messageID Select p)
            For Each p In bcc
                oMail.Bcc.Add(p.bccAddress)
            Next

            oMail.Subject = subject
            oMail.IsBodyHtml = True
            oMail.Body = body.ToString()

            ' Instantiate a new instance of SmtpClient
            Dim smtpClient As New SmtpClient("smtp.sendgrid.net", Convert.ToInt32(587))
            Dim credentials As New System.Net.NetworkCredential("apikey", "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")
            smtpClient.Credentials = credentials

            smtpClient.Send(oMail)

            oMail = Nothing 'free up resources
        Catch ex As Exception

        End Try

    End Sub

    Public Shared Sub SendMailMessage(ByVal recepient As String, ByVal subject As String, ByVal body As String)
        Try
            Dim oMail As New System.Net.Mail.MailMessage()

            oMail.From = New System.Net.Mail.MailAddress("no-reply@gigengyn.com", "GigEngyn")

            oMail.To.Add(recepient) 'Send to user

            oMail.Subject = subject
            oMail.IsBodyHtml = True
            oMail.Body = body.ToString()

            ' Instantiate a new instance of SmtpClient
            Dim smtpClient As New SmtpClient("smtp.sendgrid.net", Convert.ToInt32(587))
            Dim credentials As New System.Net.NetworkCredential("apikey", "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")
            smtpClient.Credentials = credentials

            smtpClient.Send(oMail)

            oMail = Nothing 'free up resources
        Catch ex As Exception

        End Try

    End Sub

    Public Shared Sub SendMailMessageBehalf(ByVal from As String, ByVal recepient As String, ByVal subject As String, ByVal body As String)
        Try
            Dim oMail As New System.Net.Mail.MailMessage()

            oMail.Sender = New System.Net.Mail.MailAddress("no-reply@gigengyn.com")
            oMail.From = New System.Net.Mail.MailAddress(from)
            oMail.ReplyToList.Add(New System.Net.Mail.MailAddress(from))

            oMail.To.Add(recepient) 'Send to user

            oMail.Subject = subject
            oMail.IsBodyHtml = True
            oMail.Body = body.ToString()

            ' Instantiate a new instance of SmtpClient

            Dim smtpClient As New SmtpClient("smtp.sendgrid.net", Convert.ToInt32(587))
            Dim credentials As New System.Net.NetworkCredential("apikey", "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")
            smtpClient.Credentials = credentials

            smtpClient.Send(oMail)


            oMail = Nothing 'free up resources
        Catch ex As Exception

        End Try




    End Sub




End Class
