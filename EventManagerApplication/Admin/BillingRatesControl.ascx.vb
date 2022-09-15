Public Class BillingRatesControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            ManagementFeeNumericTextBox.Text = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p.managementFeePercent).FirstOrDefault
            SamplingFeeNumericTextBox.Text = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p.samplingFeePercent).FirstOrDefault
            POSNumberBox.Text = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p.posStorageFee).FirstOrDefault
        End If
    End Sub

    Function GetEventTypeName(ByVal id As Integer) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblEventTypes Where p.eventTypeID = id Select p.eventTypeName).FirstOrDefault

    End Function

    Function GetAgencyFeeName(ByVal id As Integer) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblAgencyFees Where p.agencyFeeID = id Select p.title).FirstOrDefault
    End Function

    Function GetMarketName(ByVal id As Integer) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblMarkets Where p.marketID = id Select p.marketName).FirstOrDefault
    End Function

    Private Sub GetBillingRates_EventType_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getBillingRates_EventType.Inserting

        Dim billingrate As tblSupplierBillingRate
        billingrate = CType(e.NewObject, tblSupplierBillingRate)
        billingrate.SupplierID = Request.QueryString("SupplierID")
        billingrate.RateType = "1"
        billingrate.BillingRateType = "hr."

    End Sub

    Private Sub GetMarketSurcharge_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getMarketSurcharge.Inserting

        Dim billingrate As tblSupplierBillingRate
        billingrate = CType(e.NewObject, tblSupplierBillingRate)
        billingrate.SupplierID = Request.QueryString("SupplierID")
        billingrate.RateType = "3"
        billingrate.BillingRateType = "hr."

    End Sub

    Function GetAgencyFeeTitle(id As Integer) As String

        Select Case id
            Case 1
                Return "Management Fee"
            Case 2
                Return "Sampling/Product Spend Fee"
            Case 3
                Return "POS Storage"

            Case Else
                Return ""
        End Select


    End Function

    Function GetDollarFormat(id As Integer) As String
        Select Case id
            Case 1
                Return ""
            Case 2
                Return ""
            Case 3
                Return "$"
            Case Else
                Return ""
        End Select

    End Function

    Function GetFeeFormat(id As Integer) As String
        Select Case id
            Case 1
                Return "%"
            Case 2
                Return "%"
            Case 3
                Return "Month"
            Case Else
                Return ""
        End Select

    End Function

    Private Sub BtnUpdateManagementFee_Click(sender As Object, e As EventArgs) Handles btnUpdateManagementFee.Click

        Dim q = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
        q.managementFeePercent = ManagementFeeNumericTextBox.Text
        q.modifiedBy = Session("CurrentUserID")
        q.modifiedDate = Date.Now()

        db.SubmitChanges()

    End Sub

    Private Sub BtnUpdateSamplingFee_Click(sender As Object, e As EventArgs) Handles btnUpdateSamplingFee.Click
        Dim q = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
        q.samplingFeePercent = SamplingFeeNumericTextBox.Text
        q.modifiedBy = Session("CurrentUserID")
        q.modifiedDate = Date.Now()

        db.SubmitChanges()

    End Sub

    Private Sub btnUpdatePOS_Click(sender As Object, e As EventArgs) Handles btnUpdatePOS.Click

        Dim q = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
        q.posStorageFee = POSNumberBox.Text
        q.modifiedBy = Session("CurrentUserID")
        q.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub

    Private Sub getBillingRates_EventType_Inserted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getBillingRates_EventType.Inserted

        Dim q = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
        q.modifiedBy = Session("CurrentUserID")
        q.modifiedDate = Date.Now()

    End Sub

    Private Sub getBillingRates_EventType_Updated(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getBillingRates_EventType.Updated

        Dim q = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
        q.modifiedBy = Session("CurrentUserID")
        q.modifiedDate = Date.Now()

    End Sub

    Private Sub getMarketSurcharge_Inserted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getMarketSurcharge.Inserted

        Dim q = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
        q.modifiedBy = Session("CurrentUserID")
        q.modifiedDate = Date.Now()

    End Sub

    Private Sub getMarketSurcharge_Updated(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getMarketSurcharge.Updated

        Dim q = (From p In db.tblSuppliers Where p.supplierID = Request.QueryString("SupplierID") Select p).FirstOrDefault
        q.modifiedBy = Session("CurrentUserID")
        q.modifiedDate = Date.Now()

    End Sub
End Class