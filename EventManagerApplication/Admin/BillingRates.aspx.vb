Public Class BillingRates
    Inherits System.Web.UI.Page

    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getEventTypeName(ByVal id As Integer) As String

        Return ""

        '  Return (From p In db.tblEventTypes Where p.eventTypeID = id Select p.eventTypeName).FirstOrDefault

    End Function

    Function getName(ByVal id As Integer) As String
        Return ""
    End Function

    'Private Sub getBillingRates_EventType_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getBillingRates_EventType.Inserting

    '    Dim billingrate As tblSupplierBillingRate
    '    billingrate = CType(e.NewObject, tblSupplierBillingRate)
    '    billingrate.SupplierID = Request.QueryString("SupplierID")
    '    billingrate.RateType = 1
    '    billingrate.BillingRateType = "%"

    'End Sub
End Class