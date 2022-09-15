Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class EmailMessages
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            Dim myID As Integer = Request.QueryString("messageID")

            'add a new Toolbar dynamically
            Dim dynamicToolbar As New EditorToolGroup()

            MessageEditor.Tools.Add(dynamicToolbar)

            'add a custom dropdown and set its items and dimension attributes
            Dim ddn As New EditorDropDown("DynamicDropdown")
            ddn.Text = "Insert Form Field"

            'Set the popup width and height
            ddn.Attributes("width") = "110px"
            ddn.Attributes("popupwidth") = "220px"
            ' ddn.Attributes("popupheight") = "120px"
            ddn.Attributes("padding-left") = "5px"


            'Add items

            Dim q = From p In db.tblMessageColumns Where p.messageID = myID Select p

            For Each p In q
                ddn.Items.Add(p.columnTitle, p.columnField)
            Next

            'Add tool to toolbar
            dynamicToolbar.Tools.Add(ddn)


            MessageEditor.Content = (From p In db.tblMessages Where p.messageID = myID Select p.messageText).FirstOrDefault
            DescriptionLabel.Text = (From p In db.tblMessages Where p.messageID = myID Select p.description).FirstOrDefault
            FromEmailTextBox.Text = (From p In db.tblMessages Where p.messageID = myID Select p.fromAddress).FirstOrDefault
            FromNameTextBox.Text = (From p In db.tblMessages Where p.messageID = myID Select p.fromName).FirstOrDefault
            SubjectTextBox.Text = (From p In db.tblMessages Where p.messageID = myID Select p.subject).FirstOrDefault

            lblEmail.Text = (From p In db.tblMessages Where p.messageID = myID Select p.messageTitle).FirstOrDefault
        End If



    End Sub



    Private Sub btnBackEmail_Click(sender As Object, e As EventArgs) Handles btnBackEmail.Click
        Response.Redirect("/admin/siteadministration")
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim myID As Integer = Request.QueryString("messageID")
        Dim msg = (From p In db.tblMessages Where p.messageID = myID).FirstOrDefault

        msg.fromAddress = FromEmailTextBox.Text
        msg.fromName = FromNameTextBox.Text
        msg.subject = SubjectTextBox.Text
        msg.messageText = MessageEditor.Content
        msg.modifiedDate = Date.Now()
        msg.modifiedBy = Session("CurrentUserID")

        db.SubmitChanges()


        SuccessRadNotification.Show("Your changes were updated successfully!")

    End Sub


    Private Sub MessageList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles MessageList.ItemCommand
        Select Case e.CommandName
            Case "Change"
                Response.Redirect("/admin/EmailMessages?messageID=" & Convert.ToInt32(e.CommandArgument))

        End Select
    End Sub

    Private Sub BccRepeater_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles BccRepeater.ItemCommand
        Select Case e.CommandName
            Case "RmoveBcc"
                db.DeleteMessageBcc(Convert.ToInt32(e.CommandArgument))
                BccPanel.DataBind()

        End Select
    End Sub

    Private Sub btnAdd_Click(sender As Object, e As EventArgs) Handles btnAdd.Click
        Dim newbcc As New tblMessageBcc
        newbcc.bccAddress = AddBccTextBox.Text
        newbcc.messageID = Request.QueryString("messageID")

        db.tblMessageBccs.InsertOnSubmit(newbcc)
        db.SubmitChanges()

        AddBccTextBox.Text = ""
        BccPanel.DataBind()

    End Sub

    Private Sub btnPreviewEmail_Click(sender As Object, e As EventArgs) Handles btnPreviewEmail.Click

        Try
            'send a email to current user

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            MailHelper.SendMailMessage("no-reply@gigengyn.com", SubjectTextBox.Text, MessageEditor.Content.ToString())


            SuccessRadNotification.Show("A sample message has been sent to your email address")

        Catch ex As Exception

            ErrorRadNotification.Show(ex.Message.ToString())
        End Try




    End Sub
End Class