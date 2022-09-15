Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class AddNewTeam
    Inherits System.Web.UI.Page
    Dim order As Integer
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = Common.GetCurrentClientID() Select p.clientName).FirstOrDefault

    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect("/admin/ClientDetails?ClientID=" & Common.GetCurrentClientID() & "&LoadState=Yes#eventtab/categories")
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim team As New tblTeam With {
            .teamName = TeamNameTextBox.Text,
            .active = ActiveComboBox.SelectedValue,
            .enableAllMarkets = EnableAllMarketsCheckBox.Checked
        }

        db.tblTeams.InsertOnSubmit(team)
        db.SubmitChanges()

        'add markets
        If EnableAllMarketsCheckBox.Checked = True Then
            'do nothing we took care of this above
        Else
            Dim Markets As IList(Of RadListBoxItem) = MarketListBox.CheckedItems
            For Each item As RadListBoxItem In Markets

                Dim market As New tblTeamMarket With {.marketID = item.Value, .teamID = team.teamID}
                db.tblTeamMarkets.InsertOnSubmit(market)
                db.SubmitChanges()

            Next

        End If




        Response.Redirect("/admin/ClientDetails?ClientID=" & Common.GetCurrentClientID() & "&LoadState=Yes#eventtab/teams")
    End Sub

    'Private Sub RadCheckBoxList1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles RadCheckBoxList1.SelectedIndexChanged

    '    Label1.Text = String.Format("Selected index changed. Selected values are <strong>{0}</strong>.", String.Join(",", RadCheckBoxList1.SelectedIndices))

    'End Sub
End Class