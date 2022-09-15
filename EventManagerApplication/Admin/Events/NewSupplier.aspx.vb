Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class NewSupplier
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            tempGUID.Text = System.Guid.NewGuid().ToString()
        End If

    End Sub

    Function getEventTypeName(ByVal id As Integer) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblEventTypes Where p.eventTypeID = id Select p.eventTypeName).FirstOrDefault

    End Function

    Function getAgencyFeeName(ByVal id As Integer) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblAgencyFees Where p.agencyFeeID = id Select p.title).FirstOrDefault
    End Function

    Function getMarketName(ByVal id As Integer) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblMarkets Where p.marketID = id Select p.marketName).FirstOrDefault
    End Function

    Private Sub getBillingRates_EventType_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getBillingRates_EventType.Inserting

        Try
            Dim billingrate As tempSupplierBillingRate
            billingrate = CType(e.NewObject, tempSupplierBillingRate)
            billingrate.tempSupplierID = tempGUID.Text
            billingrate.RateType = "1"
            billingrate.BillingRateType = "hr."

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try


    End Sub

    Private Sub getMarketSurcharge_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getMarketSurcharge.Inserting
        Try
            Dim billingrate As tempSupplierBillingRate
            billingrate = CType(e.NewObject, tempSupplierBillingRate)
            billingrate.tempSupplierID = tempGUID.Text
            billingrate.RateType = 3
            billingrate.BillingRateType = "hr."
        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try


    End Sub


    Private Sub NewSupplierWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles NewSupplierWizard.CancelButtonClick

        Response.Redirect("/admin/ClientDetails?ClientID=" & Common.GetCurrentClientID() & "#eventtab/#suppliers")

    End Sub

    Private Sub NewSupplierWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles NewSupplierWizard.FinishButtonClick

        'save the form

        Dim newSupplier As New tblSupplier
        newSupplier.supplierName = SupplierNameTextBox.Text
        newSupplier.supplierAddress1 = SupplierAddress1TextBox.Text
        newSupplier.supplierAddress2 = SupplierAddress2TextBox.Text
        newSupplier.supplierCity = CityTextBox.Text
        newSupplier.supplierState = StateTextBox.SelectedValue
        newSupplier.supplierZip = ZipTextBox.Text
        newSupplier.contactName = ContactNameTextBox.Text
        newSupplier.contactEmail = ContactEmailTextBox.Text
        newSupplier.supplierPhone = PhoneNumberTextBox.Text
        newSupplier.supplierWebSite = SupplierWebSiteTextBox.Text
        newSupplier.billingContactName = billingContactName.Text
        newSupplier.billingContactEmail = BillingContactEmailTextBox.Text
        newSupplier.billingContactPhone = BillingContactPhoneTextBox.Text
        newSupplier.clientID = Common.GetCurrentClientID()
        newSupplier.active = 1
        newSupplier.shortName = BookingRequestURLTextBox.Text
        newSupplier.modifiedBy = Session("CurrentUserID")
        newSupplier.modifiedDate = Date.Now()

        newSupplier.managementFeePercent = ManagementFeeNumericTextBox.Text
        newSupplier.samplingFeePercent = SamplingFeeNumericTextBox.Text
        newSupplier.posStorageFee = POSNumberBox.Text

        db.tblSuppliers.InsertOnSubmit(newSupplier)

        Try
            db.SubmitChanges()

            'add the associated brands
            db.InsertBrandSupplierFromTempTable(tempGUID.Text, newSupplier.supplierID)

            'add roles

            'add billing rates
            db.InsertBillingRatesFromTempTable(tempGUID.Text, newSupplier.supplierID)

            'add documents
            For Each myFile As UploadedFile In RadAsyncUpload1.UploadedFiles
                Dim resumebytes(myFile.ContentLength - 1) As Byte
                myFile.InputStream.Read(resumebytes, 0, myFile.ContentLength)

                Dim newdocument As New tblSupplierDocument

                newdocument.DocumentID = System.Guid.NewGuid().ToString()
                newdocument.data = resumebytes
                newdocument.SupplierID = newSupplier.supplierID
                newdocument.FileType = myFile.ContentType
                newdocument.DocumentName = myFile.FileName
                newdocument.ModifiedBy = Context.User.Identity.GetUserId()
                newdocument.ModifiedDate = Date.Now()

                db.tblSupplierDocuments.InsertOnSubmit(newdocument)
                db.SubmitChanges()
            Next



            Response.Redirect("/admin/ClientDetails?Action=3&ClientID=" & Common.GetCurrentClientID() & "#eventtab/#suppliers")

        Catch ex As Exception
            msgLabel.Text = ex.Message()
        End Try




    End Sub

    Private Sub LogEvent(ByVal sender As Object, ByVal eventName As String, ByVal items As IEnumerable(Of RadListBoxItem))

        Dim affectedItems As New List(Of String)()

        For Each item As RadListBoxItem In items
            affectedItems.Add(item.Value)
        Next

        Dim message As String = String.Format("{0}", affectedItems.ToArray())
        HF_SelectedItemID.Value = message

    End Sub

    Private Sub SelectedBrandsList_Inserted(sender As Object, e As RadListBoxEventArgs) Handles SelectedBrandsList.Inserted

        Try
            'get the brandID
            LogEvent(sender, "Inserted", e.Items)

            Dim tempsupplierID As String = tempGUID.Text
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'insert the item
            db.InsertTempBrandSupplier(tempsupplierID, selectedValue)
            db.SubmitChanges()

            msgLabel.Text = HF_SelectedItemID.Value & " inserted"

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try



    End Sub

    Private Sub SelectedBrandsList_Deleted(sender As Object, e As RadListBoxEventArgs) Handles SelectedBrandsList.Deleted
        Try
            'get the brandID
            LogEvent(sender, "Deleted", e.Items)

            Dim tempsupplierID As String = tempGUID.Text
            Dim selectedValue As Integer = HF_SelectedItemID.Value

            'insert the item
            db.DeleteTempBrandSupplier(selectedValue, tempsupplierID)
            db.SubmitChanges()

            msgLabel.Text = HF_SelectedItemID.Value & " deleted"

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Private Sub getBillingRates_Market_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getBillingRates_Market.Inserting
        Try
            Dim billingrate As tempSupplierBillingRate
            billingrate = CType(e.NewObject, tempSupplierBillingRate)
            billingrate.tempSupplierID = tempGUID.Text
            billingrate.RateType = "3"
            billingrate.BillingRateType = "hr."

        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub
End Class