Public Class EditMarket1
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            'bind form

            Dim q = (From p In db.tblMarkets Where p.marketID = Request.QueryString("MarketID") Select p).FirstOrDefault

            MarketNameTextBox.Text = q.marketName
            ActiveComboBox.SelectedValue = q.active
            RegionComboBox.SelectedValue = q.regionID

            Try
                LatitudeTextBox.Text = q.latitude
            Catch ex As Exception

            End Try

            Try
                LongitudeTextBox.Text = q.longitude
            Catch ex As Exception

            End Try

            Try
                TimeZoneComboBox.SelectedValue = q.TimeZone
            Catch ex As Exception

            End Try


        End If
    End Sub

    Private Sub BtnCancel_Click(sender As Object, e As EventArgs) Handles BtnCancel.Click
        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "Close();", True)
    End Sub

    Private Sub BtnEdit_Click(sender As Object, e As EventArgs) Handles BtnEdit.Click
        'save the changes
        Dim q = (From p In db.tblMarkets Where p.marketID = Request.QueryString("MarketID") Select p).FirstOrDefault
        q.marketName = MarketNameTextBox.Text
        q.active = ActiveComboBox.SelectedValue
        q.regionID = RegionComboBox.SelectedValue
        q.latitude = LatitudeTextBox.Text
        q.longitude = LongitudeTextBox.Text
        q.TimeZone = TimeZoneComboBox.SelectedValue

        db.SubmitChanges()

        'close and rebind
        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", True)
    End Sub
End Class