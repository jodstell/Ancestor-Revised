Public Class ViewRegions
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getMarketCount(ByVal regionID As Integer) As Integer

        Return (From p In db.tblMarkets Where p.regionID = regionID Select p).Count

    End Function

End Class