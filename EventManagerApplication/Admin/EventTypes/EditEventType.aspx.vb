Public Class EditEventType
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = Common.GetCurrentClientID() Select p.clientName).FirstOrDefault

        If Not IsPostBack Then
            BindForm()
        End If

    End Sub

    Private Sub BindForm()

        Dim result = From p In db.tblEventTypes Where p.eventTypeID = Request.QueryString("EventTypeID")
        For Each p In result

            Me.EventTypeNameLabel.Text = p.eventTypeName
            Me.EventTypeNameTextBox.Text = p.eventTypeName

            '   Profile.SelectedValue = p.allowScheduledEvents

        Next

        Dim inList = (From p In db.tblClientEventTypes Where p.eventTypeID = Request.QueryString("EventTypeID") And p.clientID = Common.GetCurrentClientID() Select p)

        If inList.Count > 0 Then
            Me.ActiveTextBox.SelectedValue = "True"
        Else
            Me.ActiveTextBox.SelectedValue = "False"
        End If

    End Sub

    Private Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click

        Dim id As Integer = Request.QueryString("EventTypeID")

        Dim d = db.DeleteEventType(id)

        Response.Redirect("/admin/ClientDetails?Action=1&ClientID=" & Common.GetCurrentClientID() & "#eventtab/#eventtype")

    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click

        'update event type name
        Dim eventtype = (From p In db.tblEventTypes Where p.eventTypeID = Request.QueryString("EventTypeID") Select p).FirstOrDefault
        eventtype.eventTypeName = EventTypeNameTextBox.Text

        db.SubmitChanges()


        'update active
        If Me.ActiveTextBox.SelectedValue = "True" Then
            'check if it is already in the list
            Dim inList = (From p In db.tblClientEventTypes Where p.eventTypeID = Request.QueryString("EventTypeID") And p.clientID = Common.GetCurrentClientID() Select p)

            If inList.Count > 0 Then
                'do nothing
            Else
                'add to list
                Dim i As New tblClientEventType
                i.clientID = Common.GetCurrentClientID()
                i.eventTypeID = Request.QueryString("EventTypeID")

                db.tblClientEventTypes.InsertOnSubmit(i)
                db.SubmitChanges()
            End If
        End If

        If Me.ActiveTextBox.SelectedValue = "False" Then
            'check if it is already in the list
            Dim inList = (From p In db.tblClientEventTypes Where p.eventTypeID = Request.QueryString("EventTypeID") And p.clientID = Common.GetCurrentClientID() Select p)

            If inList.Count > 0 Then
                'delete it
                db.DeleteClientEventType(Common.GetCurrentClientID(), Request.QueryString("EventTypeID"))
            Else
                'do nothing

            End If
        End If

        'msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

        RadNotification1.Show()

    End Sub
End Class