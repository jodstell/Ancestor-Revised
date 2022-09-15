Public Class POSCostControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim posstatus = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.status).FirstOrDefault

        Select Case posstatus
            Case ""
                ShippingStatusLabel.ForeColor = Drawing.Color.Red
                ShippingStatusLabel.Text = "<span class='label label-warning'>A POS Kit has not been requested.</span>"

                MainPanel.Visible = False

            Case "Pending"
                ShippingStatusLabel.ForeColor = Drawing.Color.Red
                ShippingStatusLabel.Text = "<span class='label label-danger'>A POS Kit has not been shipped!</span>"

                MainPanel.Visible = True



            Case "Shipped"

                MainPanel.Visible = True

                Dim kit = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.kitID).FirstOrDefault
                Dim subtotal = (From p In db.qryGetPosKitItems Where p.kitID = kit Select p.Total).Sum
                Dim shipping = (From p In db.qryGetPosShippingCosts Where p.kitID = kit Select p.cost).Sum

                TotalCostLabel.Text = subtotal + shipping

        End Select


    End Sub

End Class