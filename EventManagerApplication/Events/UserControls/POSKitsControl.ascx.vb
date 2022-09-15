Imports Telerik.Web.UI

Public Class POSKitsControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim eventType_ID = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.eventTypeID).FirstOrDefault

        EventTypeName.Text = String.Format("{0} Kit Avaialable:", (From p In db.tblEventTypes Where p.eventTypeID = eventType_ID Select p.eventTypeName).FirstOrDefault)

        If eventType_ID = 261 Then

            Dim r = From p In db.getOffPremisePosItemsByBrand(Request.QueryString("ID")) Select p

            For Each p In r
                Dim mystring = String.Format("{0} ({1})  {2} ({3})", p.unitsInKit, p.packageSize, p.itemName, p.brandName)

                Dim newItem As New RadListBoxItem(mystring, p.itemID)
                POSItemList.Items.Add(newItem)
            Next

        End If

        If eventType_ID = 262 Then
            ' POSItems.DataSource = db.getOnPremisePosItemsByBrand(Request.QueryString("ID"))
            ' POSItems.DataBind()
        End If

        If Not Page.IsPostBack Then
            Try
                KitRequested.SelectedValue = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.posKitRequested).FirstOrDefault
            Catch ex As Exception
                'do worry about it, the data was null
            End Try

            NotesTextBox.Text = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.posKitShippingNote).FirstOrDefault

        End If

    End Sub

    Private Sub btnSavePosKitRequest_Click(sender As Object, e As EventArgs) Handles btnSavePosKitRequest.Click

        'update the event
        Dim thisevent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault
        thisevent.posKitRequested = KitRequested.SelectedValue
        thisevent.posKitShippingNote = NotesTextBox.Text
        thisevent.posShipTo = SendToList.SelectedValue

        db.SubmitChanges()

        'create the posKit
        Dim kit As New tblPosKit With {.eventID = Request.QueryString("ID"), .status = "Pending"}
        db.tblPosKits.InsertOnSubmit(kit)
        db.SubmitChanges()

        'insert the checked items into the kit
        Dim collection As IList(Of RadListBoxItem) = POSItemList.CheckedItems

        For Each item As RadListBoxItem In collection

            db.InsertPosKitItems(Request.QueryString("ID"), kit.kitID, item.Value)
            db.SubmitChanges()

        Next

        SuccessLabel.Text = Common.ShowAlertNoClose("success", "Your request has been sent!")

    End Sub
End Class