

Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class EditPosKit
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim _eventid = (From p In db.tblPosKits Where p.kitID = Request.QueryString("KitID") Select p.eventID).FirstOrDefault

        ' Dim _eventid = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault
        EventNameLabel.Text = (From p In db.tblEvents Where p.eventID = _eventid Select p.eventTitle).FirstOrDefault

        EventDateLabel.Text = String.Format("{0:D}", (From p In db.tblEvents Where p.eventID = _eventid Select p.eventDate).FirstOrDefault)
        EventIDLabel.Text = _eventid

        Try
            Dim userID = (From p In db.tblPosKits Where p.kitID = Request.QueryString("KitID") Select p.createdBy).FirstOrDefault
            Dim RequestedBy = (From p In db.tblProfiles Where p.userID = userID Select p).FirstOrDefault

            RequestedByLabel.Text = String.Format("{0} {1}", RequestedBy.firstName, RequestedBy.lastName)
        Catch ex As Exception

        End Try

        OnLabel.Text = Common.GetTimeAdjustment((From p In db.tblPosKits Where p.kitID = Request.QueryString("KitID") Select p.createdDate).FirstOrDefault)

        If Not Page.IsPostBack Then
            'populate shipto
            Dim q = (From p In db.tblPosKits Where p.kitID = Request.QueryString("KitID") Select p).FirstOrDefault
            NameTextBox.Text = q.shipTo
            AddressTextBox.Text = q.shippingAddress
            CityTextBox.Text = q.shippingCity
            StateDropDownList.SelectedValue = q.shippingState
            ZipTextBox.Text = q.shippingZip
            DatePicker.DbSelectedDate = q.shippedDate
            ShippingStatusComboBox.SelectedValue = q.status
            NotesLabel.Text = q.notes

            TrackingTextBox.Text = q.trackingNumber
            ReturnTrackingTextBox.Text = q.returnTrackingNumber

            Try
                ShippingMethodComboBox.SelectedValue = q.shippingMethodID
            Catch ex As Exception

            End Try

            Try

                'Dim l = (From p In db.tblShippingMethods Where p.shippingVendorID = q.shippingVendorID Select p)
                'ShippingVendorComboBox.DataSource = l
                'ShippingVendorComboBox.DataBind()

                ShippingVendorComboBox.SelectedValue = q.shippingVendorID
            Catch ex As Exception
                ' ShippingVendorComboBox.SelectedValue = q.shippingVendorID
            End Try

            Try
                PriceNumericTextBox.Text = q.shippingCost
                HandlingFeeNumericTextBox.Text = q.handlingFee
            Catch ex As Exception
                PriceNumericTextBox.Text = "0"
                HandlingFeeNumericTextBox.Text = "0"
            End Try
        End If



    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect("/admin/viewPOS")
    End Sub

    Function getTotal(id As String) As String
        Return (From p In db.getPOSKitItems Where p.PosKitItemID = id Select p.Total).FirstOrDefault
    End Function
    Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        Dim q = (From p In db.tblPosKits Where p.kitID = Request.QueryString("KitID") Select p).FirstOrDefault

        q.shipTo = NameTextBox.Text
        q.shippingAddress = AddressTextBox.Text
        q.shippingCity = CityTextBox.Text
        q.shippingState = StateDropDownList.SelectedValue
        q.shippingZip = ZipTextBox.Text
        q.shippingMethodID = ShippingMethodComboBox.SelectedValue
        q.shippedDate = DatePicker.DbSelectedDate
        q.trackingNumber = TrackingTextBox.Text
        q.shippedBy = Context.User.Identity.GetUserId()
        q.shippingVendorID = ShippingVendorComboBox.SelectedValue
        q.shippingMethodID = ShippingMethodComboBox.SelectedValue
        q.shippingCost = PriceNumericTextBox.Text
        q.handlingFee = HandlingFeeNumericTextBox.Text
        q.returnTrackingNumber = ReturnTrackingTextBox.Text
        q.status = ShippingStatusComboBox.SelectedValue
        q.modifiedBy = Context.User.Identity.GetUserId()
        q.modifiedDate = Date.Now()


        'Dim newshippingcost As New tblPosShippingCost
        'newshippingcost.kitID = Request.QueryString("KitID")
        'newshippingcost.category = "Shipping"
        'newshippingcost.cost = PriceNumericTextBox.Text
        'newshippingcost.description = ShippingMethodComboBox.SelectedValue


        'db.tblPosShippingCosts.InsertOnSubmit(newshippingcost)

        ' Handling
        'Dim newhandlingcost As New tblPosShippingCost
        'newhandlingcost.kitID = Request.QueryString("KitID")
        'newhandlingcost.category = "Handling"
        'newhandlingcost.cost = HandlingFeeNumericTextBox.Text
        'newhandlingcost.description = "Material and Handling for 1 kit(s)"

        'db.tblPosShippingCosts.InsertOnSubmit(newhandlingcost)

        db.SubmitChanges()

        Response.Redirect("/admin/viewPOS")

    End Sub

    Private Sub ShippingVendorComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles ShippingVendorComboBox.SelectedIndexChanged

        ShippingMethodComboBox.Text = ""

        ShippingMethodComboBox.Items.Clear()

        ShippingMethodComboBox.Text = ""

        '    LoadItems(e.Value)


    End Sub

    Protected Sub LoadItems(ByVal shippingVendorID As String)

        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        Dim adapter As New SqlDataAdapter("SELECT * FROM [tblShippingMethod] where shippingVendorID = @shippingVendorID", connection)

        adapter.SelectCommand.Parameters.AddWithValue("@shippingVendorID", shippingVendorID)



        Dim dt As New DataTable()

        adapter.Fill(dt)


        ShippingMethodComboBox.DataSource = dt

        ShippingMethodComboBox.DataBind()

    End Sub

    Private Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click

        Dim kitID = Request.QueryString("KitID")

        db.DeletePOSKit(Convert.ToInt32(kitID))

        Response.Redirect("/admin/viewPOS")


    End Sub
End Class