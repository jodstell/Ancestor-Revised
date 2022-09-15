Public Class AddNewMarket
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub BtnCancel_Click(sender As Object, e As EventArgs) Handles BtnCancel.Click
        'close the form

        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "Close();", True)

    End Sub

    Private Sub BtnSave_Click(sender As Object, e As EventArgs) Handles BtnSave.Click

        If Page.IsValid Then
            Try
                Dim newMarket As New tblMarket With {
                            .marketID = GetNewMarketID().ToString(),
                            .marketName = MarketNameTextBox.Text,
                            .active = ActiveComboBox.SelectedValue,
                            .regionID = RegionComboBox.SelectedValue,
                            .latitude = LatitudeTextBox.Text,
                            .longitude = LongitudeTextBox.Text,
                            .TimeZone = TimeZoneComboBox.SelectedValue
                        }

                db.tblMarkets.InsertOnSubmit(newMarket)
                db.SubmitChanges()


                'close the form and refresh the gridview



            Catch ex As Exception
                msgLabel.Text = ex.Message()
            End Try


            ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", True)
        End If


    End Sub

    Function GetNewMarketID() As Integer
        Dim q = (From p In db.tblMarkets Order By p.ID Descending Select p.marketID).FirstOrDefault

        Dim result As Integer = Convert.ToInt32(q)


        Return result + 1

    End Function
End Class