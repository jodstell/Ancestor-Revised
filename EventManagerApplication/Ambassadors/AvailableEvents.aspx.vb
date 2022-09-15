Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class AvailableEvents
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            LatitudeHiddenField.Value = (From p In db.tblAmbassadors Where p.userID = Context.User.Identity.GetUserId() Select p.latitude).FirstOrDefault

            LongtitudeHiddenField.Value = (From p In db.tblAmbassadors Where p.userID = Context.User.Identity.GetUserId() Select p.longitude).FirstOrDefault
        Catch ex As Exception

            ErrorLabel.ForeColor = Drawing.Color.Red
            ErrorLabel.Text = Common.ShowAlertNoClose("warning", "<b>There was a problem validating your home address.</b>  Please go to your <a href='/application/profile'>profile</a> to edit your address.")
        End Try


    End Sub

    Private Sub AvailableEventsList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles AvailableEventsList.ItemCommand

        Dim lmsdb As New LMSDataClassesDataContext

        Dim userID As String = Context.User.Identity.GetUserId()
        Dim eventID As Integer = Convert.ToInt32(e.CommandArgument)

        Select Case e.CommandName
            Case "RequestEvent"

                Try
                    Dim db As New DataClassesDataContext

                    Dim r = (From p In db.tblAmbassadorEventRequests Where p.userID = Context.User.Identity.GetUserId() And p.eventID = eventID Select p).Count

                    If r = 0 Then
                        ' add Request

                        Dim q As New tblAmbassadorEventRequest With {.eventID = eventID, .userID = userID, .dateRequested = Date.Now(), .requestStatus = 1}

                        db.tblAmbassadorEventRequests.InsertOnSubmit(q)
                        db.SubmitChanges()

                        AvailableEventsList.DataBind()

                        'add to history log
                        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), eventID, Date.Now(), "Event Requested", "", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                    Else
                        'do nothing

                    End If


                Catch ex As Exception

                End Try


            Case "DeleteRequestEvent"

                db.DeleteAmbassadorEventRequested(eventID, userID)

                'remove them
                'Dim q = (From p In db.tblAmbassadorEventRequests Where p.eventID = eventID And p.userID = userID Select p).FirstOrDefault

                'q.requestStatus = 2
                'q.modifiedBy = userID
                'q.modifiedDate = Date.Now()

                'db.SubmitChanges()

                AvailableEventsList.DataBind()

                'add to history log
                lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), eventID, Date.Now(), "Event Request Deleted", "", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        End Select
    End Sub

    Function getRequestStatus(eventID As String) As String

        Try
            Dim q = (From p In db.tblAmbassadorEventRequests Where p.userID = Context.User.Identity.GetUserId() And p.eventID = eventID Select p).Count

            If q = 0 Then
                Return ""
            Else
                Dim r As DateTime = (From p In db.tblAmbassadorEventRequests Where p.userID = Context.User.Identity.GetUserId() And p.eventID = eventID Select p.dateRequested).FirstOrDefault

                Return String.Format("You requested this event on {0:d}", r)


            End If
        Catch ex As Exception
            Return "There was an error"
        End Try


    End Function

    Function showRequestButton(eventID As String) As String
        Try
            Dim q = (From p In db.tblAmbassadorEventRequests Where p.userID = Context.User.Identity.GetUserId() And p.eventID = eventID Select p).FirstOrDefault

            If q.requestStatus > 1 Then
                Return "False"
            Else
                Return "True"
            End If
        Catch ex As Exception
            Return "True"
        End Try


    End Function


    Function showDeleteRequestButton(eventID As String) As String
        Try
            Dim q = (From p In db.tblAmbassadorEventRequests Where p.userID = Context.User.Identity.GetUserId() And p.eventID = eventID Select p).FirstOrDefault

            If q.requestStatus > 1 Then
                Return "True"
            Else
                Return "False"
            End If
        Catch ex As Exception
            Return "False"
        End Try


    End Function
End Class