
Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI
Imports System
Imports System.Web.UI.WebControls
Public Class AmbassadorCalendarControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub RadScheduler1_AppointmentDataBound(sender As Object, e As SchedulerEventArgs) Handles RadScheduler1.AppointmentDataBound
        If e.Appointment.Resources.GetResourceByType("StatusName") <> Nothing Then
            Select Case e.Appointment.Resources.GetResourceByType("StatusName").Text
                Case "Requested"
                    e.Appointment.CssClass = "rsRequested"
                    Exit Select
                Case "Scheduled"
                    e.Appointment.CssClass = "rsScheduled"
                    Exit Select
                Case "Booked"
                    e.Appointment.CssClass = "rsBooked"
                    Exit Select
                Case "Cancelled"
                    e.Appointment.CssClass = "rsCancelled"
                    Exit Select
                Case "Toplined"
                    e.Appointment.CssClass = "rsToplined"
                    Exit Select
                Case "Approved"
                    e.Appointment.CssClass = "rsApproved"
                    Exit Select
                Case Else
                    Exit Select
            End Select
        End If

        e.Appointment.ToolTip = e.Appointment.Description


    End Sub

    Protected Sub OnClientAppointmentClick(sender As Object, e As SchedulerEventArgs)
        Dim StrID As String = e.Appointment.ID.ToString()
    End Sub

End Class