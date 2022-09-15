Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI
Imports System
Imports System.Web.UI.WebControls

Public Class AmbassadorCalendar
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim mapLayer As MapLayer = GetMapLayer()
        RadMap1.LayersCollection.Clear()
        RadMap1.LayersCollection.Add(mapLayer)

    End Sub

    Private Function GetMapLayer() As MapLayer

        Dim provider As String = "Bing"
        Dim providerName As String = "Bing"

        Dim mapLayer As MapLayer = New MapLayer

        If Not provider = "Bing" Then
            mapLayer.Type = Map.LayerType.Tile
            mapLayer.UrlTemplate = provider

            Select Case providerName
                Case "OpenStreetMap"
                    mapLayer.Attribution = "&copy; <a href='http://www.openstreetmap.org' title='OpenStreetMap contributors' target='_blank'>OpenStreetMap contributors</a>."

                Case "OpenCycleMap"
                    mapLayer.Attribution = "&copy; <a href='http://www.opencyclemap.org/' title='OpenCycleMap contributors' target='_blank'>OpenCycleMap contributors</a>."

                Case "ThunderForest"
                    mapLayer.Attribution = "&copy; <a href='http://www.thunderforest.com/' title='ThunderForest contributors' target='_blank'>ThunderForest contributors</a>."

                Case Else

                    Exit Select

            End Select

        Else

            mapLayer.Type = Map.LayerType.Bing
            mapLayer.Key = ConfigurationManager.AppSettings.Get("BingMapsAPIKey").ToString() ' The key used for a local demo on your end should be provided by Microsoft as described in the description of this demo

        End If

        Return mapLayer

    End Function

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