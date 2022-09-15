Imports Telerik.Web.UI

Public Class NewEventReport
    Inherits System.Web.UI.Page
    Dim db1 As New ReportDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If RecapCheckBox.Checked = True Then
            RecapListBox.Enabled = True
            EventTypeRecapQuestionsListBox.Enabled = True
            EventTypeComboBox.Enabled = True
            ' EventTypeRadListBox.Enabled = False
        Else
            RecapListBox.Enabled = False
            EventTypeRecapQuestionsListBox.Enabled = False
            EventTypeComboBox.Enabled = False
            ' EventTypeRadListBox.Enabled = True
        End If

    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        'save the report
        Dim newreport As New rptReport
        newreport.reportTitle = ReportNameTextBox.Text
        newreport.reportName = "text"
        newreport.description = ReportDescriptionTextBox.Text
        newreport.startDate = FromDatePicker.SelectedDate
        newreport.endDate = ToDatePicker.SelectedDate
        newreport.supplierID = SupplierRadComboBox.SelectedValue
        newreport.reportGroupID = 1
        newreport.active = ActiveCheckBox.Checked
        newreport.allowFilter = AllowFilteringCheckBox.Checked
        newreport.allowSorting = AllowSortingCheckBox.Checked
        newreport.allowReorder = AllowReorderCheckBox.Checked
        newreport.groupBy = GroupByComboBox.SelectedValue
        newreport.fileName = ExportFileTextBox.Text
        newreport.eventTypeID = EventTypeComboBox.SelectedValue
        newreport.allowGrouping = False
        newreport.exportPDF = False
        newreport.exportExcel = True
        newreport.exportCSV = False
        newreport.exportWord = False
        newreport.showByBrand = RecapCheckBox.Checked

        newreport.createdBy = Session("CurrentUserID")
        newreport.createdDate = Date.Now()

        newreport.modifiedBy = Session("CurrentUserID")
        newreport.modifiedDate = Date.Now()

        db1.rptReports.InsertOnSubmit(newreport)
        db1.SubmitChanges()


        'add items to table MarketFilter
        Dim collection As IList(Of RadListBoxItem) = MarketListBox.CheckedItems

        For Each item As RadListBoxItem In collection

            Dim q As New rptMarketFilter With {.reportID = newreport.reportID, .marketID = item.Value}

            db1.rptMarketFilters.InsertOnSubmit(q)
            db1.SubmitChanges()
        Next

        'add items to table Column
        Dim collection1 As IList(Of RadListBoxItem) = EventListBox.CheckedItems

        For Each item As RadListBoxItem In collection1

            Dim q1 As New rptColumn With {.reportID = newreport.reportID, .dataField = item.Value, .headerText = item.Text, .tableName = "Event"}

            db1.rptColumns.InsertOnSubmit(q1)
            db1.SubmitChanges()
        Next

        'add items to table Column
        Dim collection2 As IList(Of RadListBoxItem) = AccountListBox.CheckedItems

        For Each item As RadListBoxItem In collection2

            Dim q2 As New rptColumn With {.reportID = newreport.reportID, .dataField = item.Value, .headerText = item.Text, .tableName = "Account"}

            db1.rptColumns.InsertOnSubmit(q2)
            db1.SubmitChanges()
        Next

        'add items to table
        Dim collection2a As IList(Of RadListBoxItem) = POTrackingList.CheckedItems

        For Each item As RadListBoxItem In collection2a

            Dim q2a As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "PO"}

            db1.rptColumns.InsertOnSubmit(q2a)
            db1.SubmitChanges()
        Next


        'add items to table
        Dim collection3 As IList(Of RadListBoxItem) = RecapListBox.CheckedItems

        For Each item As RadListBoxItem In collection3

            Dim q3 As New rptColumn With {.reportID = newreport.reportID, .dataField = item.Value, .headerText = item.Text, .tableName = "Recap"}

            db1.rptColumns.InsertOnSubmit(q3)
            db1.SubmitChanges()
        Next


        'EventTypeRecap
        'add items to table
        Dim collection4 As IList(Of RadListBoxItem) = EventTypeRecapQuestionsListBox.CheckedItems

        For Each item As RadListBoxItem In collection4

            Dim q4 As New rptColumn With {.reportID = newreport.reportID, .dataField = item.Value, .headerText = item.Text, .tableName = "EventTypeRecap"}

            db1.rptColumns.InsertOnSubmit(q4)
            db1.SubmitChanges()
        Next

        'add items to table
        Dim collection5 As IList(Of RadListBoxItem) = AmbassadorListBox.CheckedItems

        For Each item As RadListBoxItem In collection5

            Dim q5 As New rptColumn With {.reportID = newreport.reportID, .dataField = item.Value, .headerText = item.Text, .tableName = "Ambassador"}

            db1.rptColumns.InsertOnSubmit(q5)
            db1.SubmitChanges()
        Next

        'Brand Recap Questions
        'add items to table
        Dim collection6 As IList(Of RadListBoxItem) = BrandRecapQuestionListBox.CheckedItems

        For Each item As RadListBoxItem In collection6

            Dim q6 As New rptColumn With {.reportID = newreport.reportID, .dataField = item.Value, .headerText = item.Text, .tableName = "BrandRecap"}

            db1.rptColumns.InsertOnSubmit(q6)
            db1.SubmitChanges()

        Next

        'Brands
        'add items to table
        Dim collection7 As IList(Of RadListBoxItem) = BrandsListBox.CheckedItems

        For Each item As RadListBoxItem In collection7

            Dim q7 As New rptColumn With {.reportID = newreport.reportID, .dataField = item.Value, .headerText = item.Text, .tableName = "Brands"}

            db1.rptColumns.InsertOnSubmit(q7)
            db1.SubmitChanges()
        Next

        'BudgetTracking
        'add items to table
        Dim collection8 As IList(Of RadListBoxItem) = BudgetTrackingListBox.CheckedItems

        For Each item As RadListBoxItem In collection8

            Dim q8 As New rptColumn With {.reportID = newreport.reportID, .dataField = item.Value, .headerText = item.Text, .tableName = "BudgetTracking"}

            db1.rptColumns.InsertOnSubmit(q8)
            db1.SubmitChanges()
        Next



        'add items to table Status
        Dim collections As IList(Of RadListBoxItem) = EventStatusListBox.CheckedItems

        For Each item As RadListBoxItem In collections

            Dim qs As New rptStatusFilter With {.reportID = newreport.reportID, .statusID = item.Value}

            db1.rptStatusFilters.InsertOnSubmit(qs)
            db1.SubmitChanges()
        Next

        'add items to table Event Type
        'Dim collectiont As IList(Of RadListBoxItem) = EventTypeRadListBox.CheckedItems

        'For Each item As RadListBoxItem In collectiont

        '    Dim qt As New rptEventTypeFilter With {.reportID = newreport.reportID, .eventTypeID = item.Value}

        '    db1.rptEventTypeFilters.InsertOnSubmit(qt)
        '    db1.SubmitChanges()
        'Next



        'go to the new report page
        Response.Redirect("/Reports/ReportBuilder/ViewEventReport?ReportID=" & newreport.reportID)

    End Sub


    Private Sub RecapCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles RecapCheckBox.CheckedChanged

        If RecapCheckBox.Checked = True Then

            RecapListBox.Enabled = True
            EventTypeRecapQuestionsListBox.Enabled = True
            EventTypeComboBox.Enabled = True

            ' EventTypeRadListBox.Enabled = False

            'Dim collection5 As IList(Of RadListBoxItem) = EventTypeRadListBox.CheckedItems

            'For Each item As RadListBoxItem In collection5

            '    item.Checked = False
            'Next

        Else

            RecapListBox.Enabled = False

            Dim collection3 As IList(Of RadListBoxItem) = RecapListBox.CheckedItems

            For Each item As RadListBoxItem In collection3

                item.Checked = False
            Next


            EventTypeRecapQuestionsListBox.Enabled = False

            Dim collection4 As IList(Of RadListBoxItem) = EventTypeRecapQuestionsListBox.CheckedItems

            For Each item As RadListBoxItem In collection4

                item.Checked = False
            Next


            EventTypeComboBox.Enabled = False

            '  EventTypeRadListBox.Enabled = True

        End If

    End Sub

    Private Sub SupplierRadComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles SupplierRadComboBox.SelectedIndexChanged

        Dim db As New DataClassesDataContext

        Dim brands = From p In db.getBrandsbySuppliers Where p.supplierID = SupplierRadComboBox.SelectedValue Order By p.brandName Select p

        BrandsListBox.DataSource = brands
        BrandsListBox.DataBind()


        Dim budget = From p In db.tblSupplierBudgetQuestions Where p.supplierID = SupplierRadComboBox.SelectedValue Select p

        BudgetTrackingListBox.DataSource = budget
        BudgetTrackingListBox.DataBind()

    End Sub

    Private Sub BrandsListBox_SelectedIndexChanged(sender As Object, e As EventArgs) Handles BrandsListBox.SelectedIndexChanged

    End Sub
End Class