Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI
Imports System
Imports System.Web.UI.WebControls

Public Class AmbassadorMapControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Dim mapLayer As MapLayer = GetMapLayer()
        RadMap1.LayersCollection.Clear()
        RadMap1.LayersCollection.Add(mapLayer)

        RadMap1.CenterSettings.Latitude = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p.latitude).FirstOrDefault
        RadMap1.CenterSettings.Longitude = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p.longitude).FirstOrDefault


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

End Class