Public Class BrandInformationControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' bindform()
    End Sub

    Sub bindInformationForm()

        Dim q = From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p

        For Each p In q
            Me.BrandNameTextBox.Text = p.brandName
            Me.StartDateTextBox.DbSelectedDate = p.brandStartDate
            Me.EndDateTextBox.DbSelectedDate = p.brandEndDate
            Me.DataViewEndDateTextBox.DbSelectedDate = p.brandDataEndDate
            Me.ActiveTextBox.SelectedValue = p.active
        Next
    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        'save the form



    End Sub
End Class