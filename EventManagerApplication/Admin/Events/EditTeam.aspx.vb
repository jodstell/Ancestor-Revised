Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class EditTeam
    Inherits System.Web.UI.Page
    Dim order As Integer
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = Common.GetCurrentClientID() Select p.clientName).FirstOrDefault
        Catch ex As Exception
            ClientNameLabel.Text = ex.Message()
        End Try


        If Not Page.IsPostBack Then

            Try
                Dim q = From p In db.tblTeams Where p.teamID = Request.QueryString("teamID") Select p

                For Each p In q

                    TeamNameTextBox.Text = p.teamName
                    TeamNameLabel.Text = p.teamName
                    EnableAllMarketsCheckBox.Checked = p.enableAllMarkets

                    Try
                        ActiveDropDown.SelectedValue = p.active
                    Catch ex As Exception

                    End Try

                Next
            Catch ex As Exception

            End Try

        End If
    End Sub

    Private Sub BtnSave_Click(sender As Object, e As EventArgs) Handles BtnSave.Click

        'save changes

        Dim q = (From p In db.tblTeams Where p.teamID = Request.QueryString("teamID") Select p).FirstOrDefault

        q.teamName = TeamNameTextBox.Text
        q.active = ActiveDropDown.SelectedValue
        q.enableAllMarkets = ActiveDropDown.SelectedValue

        db.SubmitChanges()


        If EnableAllMarketsCheckBox.Checked = True Then
            'do nothing we took care of this above
        Else


            'delete all from table
            db.DeleteTeamMarkets(Convert.ToInt32(Request.QueryString("teamID")))

            Dim Markets As IList(Of RadListBoxItem) = MarketListBox.CheckedItems
            For Each item As RadListBoxItem In Markets

                Dim market As New tblTeamMarket With {.marketID = item.Value, .teamID = Request.QueryString("teamID")}
                db.tblTeamMarkets.InsertOnSubmit(market)
                db.SubmitChanges()

            Next

        End If


        Response.Redirect("/admin/ClientDetails?ClientID=" & Common.GetCurrentClientID() & "&LoadState=Yes#eventtab/teams")
    End Sub

    Private Sub BtnCancel_Click(sender As Object, e As EventArgs) Handles BtnCancel.Click
        Response.Redirect("/admin/ClientDetails?ClientID=" & Common.GetCurrentClientID() & "&LoadState=Yes#eventtab/teams")
    End Sub

    Private Sub MarketListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles MarketListBox.ItemDataBound


        Dim s = From p In db.tblTeamMarkets Where p.teamID = Request.QueryString("teamID") Select p

        For Each p In s


            Dim collection As IList(Of RadListBoxItem) = MarketListBox.Items

            For Each item As RadListBoxItem In collection

                Try
                    Dim itemToSelect As RadListBoxItem = MarketListBox.FindItemByValue(p.marketID)
                    itemToSelect.Checked = True

                Catch ex As Exception

                End Try

            Next


        Next
    End Sub
End Class