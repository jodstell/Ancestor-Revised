Imports System.Net
Imports System.Web.Script.Serialization
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports iTextSharp.text.pdf
Imports iTextSharp.text
Imports System.IO

Public Class ShippingLocationControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault
            Dim thisPOSKit = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

            Dim eventType_ID = thisEvent.eventTypeID

            EventTypeName.Text = String.Format("{0} Kit:", (From p In db.tblEventTypes Where p.eventTypeID = eventType_ID Select p.eventTypeName).FirstOrDefault)

            Dim posstatus = thisPOSKit.status

            Select Case posstatus
                Case ""
                    ShippingStatusLabel.ForeColor = Drawing.Color.Red
                    ShippingStatusLabel.Text = "<span class='label label-warning'>A POS Kit has not been requested.</span>"

                    ShippingPanel.Visible = False

                Case "Pending"
                    ShippingStatusLabel.ForeColor = Drawing.Color.Red
                    ShippingStatusLabel.Text = "<span class='label label-danger'>A POS Kit has not been shipped!</span>"

                    ShippingPanel.Visible = True
                Case "Shipped"
                    Dim shipped = thisPOSKit.shippedDate


                    ShippingStatusLabel.ForeColor = Drawing.Color.Green
                    ShippingStatusLabel.Text = String.Format("The following items were shipped on {0:d}", shipped)

                    ShippingPanel.Visible = True
            End Select

            'we need to have a hidden field for the latitude and longitude of the shipping location
            Hidden_POSLatitude.Value = thisEvent.posShippingLatitude
            HIdden_POSLongtitude.Value = thisEvent.posShippingLongtitude


            ' The following items were shipped on
            Dim address = thisEvent.posShippingAddress1
            Dim city = thisEvent.posShippingCity
            Dim state = thisEvent.posShippingState
            Dim zip = thisEvent.posShippingZip

            ShippingAddressLabel.Text = String.Format("{0}<br>{1}, {2}  {3}", address, city, state, zip)

            AttLabel.Text = String.Format("Att: {0}", (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.shippingAttName).FirstOrDefault)

            ShippedViaLabel.Text = String.Format("Via: {0}", thisPOSKit.shippedBy)
            ShippedTypeLabel.Text = String.Format("Type: {0}", thisPOSKit.shippedType)
            TrackingLabel.Text = String.Format("Tracking: <a href='{0}' target='_blank'>{0}</a>", thisPOSKit.trackingNumber)
        Catch ex As Exception

        End Try

    End Sub



End Class