Imports Telerik.Web.UI

Public Class NewPage
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim collection As IList(Of RadListBoxItem) = SelectedBrandsList.CheckedItems
        ' get a list of brands
        For Each item As RadListBoxItem In collection
            Dim attire_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = 261 Select p.attire).FirstOrDefault

            If attire_Text = "" Then
                'do nothing
            Else
                Dim attireText As String = attireTextEditor.Content & String.Format("<p><b>{0}:</b> {1}</p>", getBrandName(item.Value), attire_Text)
                attireTextEditor.Content = attireText
            End If
        Next



    End Sub

    Private Sub SelectedBrandsList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles SelectedBrandsList.SelectedIndexChanged

        attireTextEditor.Content = ""

        Dim collection As IList(Of RadListBoxItem) = SelectedBrandsList.CheckedItems
        ' get a list of brands
        For Each item As RadListBoxItem In collection
            Dim attire_Text = (From p In db.tblBrandEventExecutions Where p.brandID = item.Value And p.eventTypeID = 261 Select p.attire).FirstOrDefault

            If attire_Text = "" Then
                'do nothing
            Else
                Dim attireText As String = attireTextEditor.Content & String.Format("<p><b>{0}:</b> {1}</p>", getBrandName(item.Value), attire_Text)
                attireTextEditor.Content = attireText
            End If
        Next

    End Sub

    Function getBrandName(id As Integer) As String
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function
End Class