Imports Microsoft.AspNet.Identity

Public Class StaffingRequirementsControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        startTimeLabel.Text = String.Format("{0:t}", (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.startTime).FirstOrDefault)
        endTimeLabel.Text = String.Format("{0:t}", (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.endTime).FirstOrDefault)
        eventDateLabel.Text = String.Format("{0:D}", (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.eventDate).FirstOrDefault)
    End Sub

    Function getPositionName(ByVal positionID As Integer) As String
        Return (From p In db.tblStaffingPositions Where p.staffingPositionID = positionID Select p.positionTitle).FirstOrDefault
    End Function

    Private Sub getEventPositions_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getEventPositions.Inserting

        Try
            Dim l As tblEventStaffingRequirement
            l = CType(e.NewObject, tblEventStaffingRequirement)
            l.eventID = Request.QueryString("ID")
            l.assigned = False
        Catch ex As Exception
            MsgLabel.Text = ex.Message
        End Try

    End Sub

    Private Sub getEventPositions_Inserted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getEventPositions.Inserted
        Dim newPosition As tblEventStaffingRequirement
        newPosition = CType(e.Result, tblEventStaffingRequirement)

        Dim positionName = (From p In db.tblStaffingPositions Where p.staffingPositionID = newPosition.positionID Select p.positionTitle).FirstOrDefault

        Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Staffing Inserted", positionName & " was added to the event staffing requirements.", Context.User.Identity.GetUserId(), Date.Now())

    End Sub
End Class