Imports Telerik.Web.UI

Public Class AvailableControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub AvailabelEventsList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles AvailabelEventsList.ItemCommand

        Dim userID As String = Session("CurrentUserID")
        Dim eventID As Integer = Convert.ToInt32(e.CommandArgument)

        Select Case e.CommandName
            Case "RequestEvent"

                ' add to database
                Dim db As New DataClassesDataContext

                Dim q As New tblAmbassadorEventRequest With {.eventID = eventID, .userID = userID, .dateRequested = Date.Now()}

                db.tblAmbassadorEventRequests.InsertOnSubmit(q)
                db.SubmitChanges()

                AvailabelEventsList.DataBind()

        End Select

    End Sub
End Class