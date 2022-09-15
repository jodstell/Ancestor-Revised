Imports Telerik.Web.UI

Public Class EditEventReport
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim db1 As New ReportDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            'bind form
            Dim q = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p).FirstOrDefault

            SelectedReportLabel.Text = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.reportTitle).FirstOrDefault

            ReportNameTextBox.Text = q.reportTitle
            DescriptionTextBox.Text = q.description
            FromDatePicker.SelectedDate = q.startDate
            ToDatePicker.SelectedDate = q.endDate
            SupplierComboBox.SelectedValue = q.supplierID
            EventTypeComboBox.SelectedValue = q.eventTypeID
            HiddenEventTypeID.Value = q.eventTypeID


            ActiveCheckBox.Checked = q.active


            GroupByComboBox.SelectedValue = q.groupBy
            AllowFilteringCheckBox.Checked = q.allowFilter
            AllowSortingCheckBox.Checked = q.allowSorting
            AllowReorderCheckBox.Checked = q.allowReorder
            ' AllowGroupingCheckBox.Checked = q.allowGrouping

            ExportFileTextBox.Text = q.fileName

            RecapCheckBox.Checked = q.showByBrand


            Dim brands = From p In db.getBrandsbySuppliers Where p.supplierID = q.supplierID Select p

            BrandsListBox.DataSource = brands
            BrandsListBox.DataBind()

            Dim budget = From p In db.tblSupplierBudgetQuestions Where p.supplierID = q.supplierID Select p

            BudgetTrackingListBox.DataSource = budget
            BudgetTrackingListBox.DataBind()

            Dim BrandRecapQuestion = From p In db.GetRecapQuestionsForReportBuilder(Request.QueryString("ReportID")) Select p

            BrandRecapQuestionListBox.DataSource = BrandRecapQuestion
            BrandRecapQuestionListBox.DataBind()

        End If

        If RecapCheckBox.Checked = True Then
            RecapListBox.Enabled = True
            EventTypeRecapQuestionsListBox.Enabled = True
            EventTypeComboBox.Enabled = True
            EventTypeRadListBox.Enabled = False
        Else
            RecapListBox.Enabled = False
            EventTypeRecapQuestionsListBox.Enabled = False
            EventTypeComboBox.Enabled = False
            EventTypeRadListBox.Enabled = True
        End If


    End Sub

    Private Sub AccountListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles AccountListBox.ItemDataBound



        Dim a = From p In db1.rptColumns Where p.reportID = Request.QueryString("ReportID") Select p

        For Each p In a


            Dim collection As IList(Of RadListBoxItem) = AccountListBox.Items

            For Each item As RadListBoxItem In collection

                Try
                    Dim itemToSelect As RadListBoxItem = AccountListBox.FindItemByText(p.headerText)
                    itemToSelect.Checked = True

                Catch ex As Exception

                End Try

            Next


        Next

    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click

        Response.Redirect("/Reports/ReportBuilder/ViewEventReport?ReportID=" & Request.QueryString("ReportID"))

    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        'delete all rows for this report
        db1.DeleteMarketFilter_EventReport(Request.QueryString("ReportID"))

        'add items to table
        Dim collection As IList(Of RadListBoxItem) = MarketListBox.CheckedItems

        For Each item As RadListBoxItem In collection

            Dim q As New rptMarketFilter With {.reportID = Request.QueryString("ReportID"), .marketID = item.Value}

            db1.rptMarketFilters.InsertOnSubmit(q)
            db1.SubmitChanges()
        Next


        'delete all rows for this report
        db1.DeleteStatusFilter_EventReport(Request.QueryString("ReportID"))


        'add items to table
        Dim collections As IList(Of RadListBoxItem) = EventStatusListBox.CheckedItems

        For Each item As RadListBoxItem In collections

            Dim qs As New rptStatusFilter With {.reportID = Request.QueryString("ReportID"), .statusID = item.Value}

            db1.rptStatusFilters.InsertOnSubmit(qs)
            db1.SubmitChanges()
        Next


        'delete all rows for this report
        db1.DeleteEventTypeFilter_EventReport(Request.QueryString("ReportID"))


        'add items to table
        Dim collectiont As IList(Of RadListBoxItem) = EventTypeRadListBox.CheckedItems

        For Each item As RadListBoxItem In collectiont

            Dim qt As New rptEventTypeFilter With {.reportID = Request.QueryString("ReportID"), .eventTypeID = item.Value}

            db1.rptEventTypeFilters.InsertOnSubmit(qt)
            db1.SubmitChanges()
        Next



        'delete all rows for this report
        db1.DeleteFilter_EventReport(Request.QueryString("ReportID"))

        'add items to table
        Dim collection1 As IList(Of RadListBoxItem) = EventListBox.CheckedItems

        For Each item As RadListBoxItem In collection1

            Dim q1 As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "Event"}

            db1.rptColumns.InsertOnSubmit(q1)
            db1.SubmitChanges()
        Next

        'add items to table
        Dim collection2 As IList(Of RadListBoxItem) = AccountListBox.CheckedItems

        For Each item As RadListBoxItem In collection2

            Dim q2 As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "Account"}

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

            Dim q3 As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "Recap"}

            db1.rptColumns.InsertOnSubmit(q3)
            db1.SubmitChanges()
        Next

        'EventTypeRecap
        'add items to table
        Dim collection4 As IList(Of RadListBoxItem) = EventTypeRecapQuestionsListBox.CheckedItems

        For Each item As RadListBoxItem In collection4

            Dim q4 As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "EventTypeRecap"}

            db1.rptColumns.InsertOnSubmit(q4)
            db1.SubmitChanges()
        Next

        'Brand Recap Questions
        'add items to table
        Dim collection6 As IList(Of RadListBoxItem) = BrandRecapQuestionListBox.CheckedItems

        For Each item As RadListBoxItem In collection6

            Dim q6 As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "BrandRecap"}

            db1.rptColumns.InsertOnSubmit(q6)
            db1.SubmitChanges()
        Next

        'add items to table
        Dim collection5 As IList(Of RadListBoxItem) = AmbassadorListBox.CheckedItems

        For Each item As RadListBoxItem In collection5

            Dim q5 As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "Ambassador"}

            db1.rptColumns.InsertOnSubmit(q5)
            db1.SubmitChanges()
        Next

        'Brands
        'add items to table
        Dim collection7 As IList(Of RadListBoxItem) = BrandsListBox.CheckedItems

        For Each item As RadListBoxItem In collection7

            Dim q7 As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "Brands"}

            db1.rptColumns.InsertOnSubmit(q7)
            db1.SubmitChanges()
        Next


        'BudgetTracking
        'add items to table
        Dim collection8 As IList(Of RadListBoxItem) = BudgetTrackingListBox.CheckedItems

        For Each item As RadListBoxItem In collection8

            Dim q8 As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "BudgetTracking"}

            db1.rptColumns.InsertOnSubmit(q8)
            db1.SubmitChanges()
        Next



        'update the report record
        Dim r = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID")).FirstOrDefault

        r.reportTitle = ReportNameTextBox.Text
        r.description = DescriptionTextBox.Text
        r.startDate = FromDatePicker.SelectedDate
        r.endDate = ToDatePicker.SelectedDate
        r.supplierID = SupplierComboBox.SelectedValue
        r.eventTypeID = EventTypeComboBox.SelectedValue
        r.groupBy = GroupByComboBox.SelectedValue
        r.allowFilter = AllowFilteringCheckBox.Checked
        r.allowSorting = AllowSortingCheckBox.Checked
        r.allowReorder = AllowReorderCheckBox.Checked
        ' r.allowGrouping = AllowGroupingCheckBox.Checked
        r.active = ActiveCheckBox.Checked
        r.fileName = ExportFileTextBox.Text
        r.showByBrand = RecapCheckBox.Checked

        r.modifiedBy = Session("CurrentUserID")
        r.modifiedDate = Date.Now()

        db1.SubmitChanges()

        Response.Redirect("/Reports/ReportBuilder/ViewEventReport?ReportID=" & Request.QueryString("ReportID"))

    End Sub

    Private Sub btnSaveAsNew_Click(sender As Object, e As EventArgs) Handles btnSaveAsNew.Click

        'save the report
        Dim newreport As New rptReport
        newreport.reportTitle = ReportNameTextBox.Text
        newreport.reportName = "text"
        newreport.description = DescriptionTextBox.Text
        newreport.startDate = FromDatePicker.SelectedDate
        newreport.endDate = ToDatePicker.SelectedDate
        newreport.supplierID = SupplierComboBox.SelectedValue
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

        'Brand Recap Questions
        'add items to table
        Dim collection6 As IList(Of RadListBoxItem) = BrandRecapQuestionListBox.CheckedItems

        For Each item As RadListBoxItem In collection6

            Dim q6 As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "BrandRecap"}

            db1.rptColumns.InsertOnSubmit(q6)
            db1.SubmitChanges()
        Next

        'add items to table
        Dim collection5 As IList(Of RadListBoxItem) = AmbassadorListBox.CheckedItems

        For Each item As RadListBoxItem In collection5

            Dim q5 As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "Ambassador"}

            db1.rptColumns.InsertOnSubmit(q5)
            db1.SubmitChanges()
        Next

        'Brands
        'add items to table
        Dim collection7 As IList(Of RadListBoxItem) = BrandsListBox.CheckedItems

        For Each item As RadListBoxItem In collection6

            Dim q7 As New rptColumn With {.reportID = Request.QueryString("ReportID"), .dataField = item.Value, .headerText = item.Text, .tableName = "Brands"}

            db1.rptColumns.InsertOnSubmit(q7)
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
        Dim collectiont As IList(Of RadListBoxItem) = EventTypeRadListBox.CheckedItems

        For Each item As RadListBoxItem In collectiont

            Dim qt As New rptEventTypeFilter With {.reportID = newreport.reportID, .eventTypeID = item.Value}

            db1.rptEventTypeFilters.InsertOnSubmit(qt)
            db1.SubmitChanges()
        Next



        'go to the list of reports
        Response.Redirect("/Reports/ReportBuilder/Events")


    End Sub

    Private Sub EventListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles EventListBox.ItemDataBound


        Dim a = From p In db1.rptColumns Where p.reportID = Request.QueryString("ReportID") Select p

        For Each p In a
            Dim collection As IList(Of RadListBoxItem) = EventListBox.Items
            For Each item As RadListBoxItem In collection
                Try
                    Dim itemToSelect As RadListBoxItem = EventListBox.FindItemByText(p.headerText)
                    itemToSelect.Checked = True
                Catch ex As Exception
                End Try
            Next
        Next


    End Sub


    Private Sub EventTypeComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles EventTypeComboBox.SelectedIndexChanged
        HiddenEventTypeID.Value = EventTypeComboBox.SelectedValue
    End Sub

    Private Sub EventTypeRecapQuestionsListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles EventTypeRecapQuestionsListBox.ItemDataBound

        'recap questions list
        Dim q = From p In db1.rptColumns Where p.reportID = Request.QueryString("ReportID") And p.tableName = "EventTypeRecap" Select p
        For Each p In q
            Dim collection As IList(Of RadListBoxItem) = EventTypeRecapQuestionsListBox.Items
            For Each item As RadListBoxItem In collection
                Try
                    Dim itemToSelect As RadListBoxItem = EventTypeRecapQuestionsListBox.FindItemByValue(p.dataField)
                    itemToSelect.Checked = True
                Catch ex As Exception
                End Try
            Next
        Next

    End Sub

    Private Sub EventStatusListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles EventStatusListBox.ItemDataBound

        Dim s = From p In db1.rptStatusFilters Where p.reportID = Request.QueryString("ReportID") Select p

        For Each p In s


            Dim collection As IList(Of RadListBoxItem) = EventStatusListBox.Items

            For Each item As RadListBoxItem In collection

                Try
                    Dim itemToSelect As RadListBoxItem = EventStatusListBox.FindItemByValue(p.statusID)
                    itemToSelect.Checked = True

                Catch ex As Exception

                End Try

            Next


        Next

    End Sub

    Private Sub MarketListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles MarketListBox.ItemDataBound

        Dim a = From p In db1.rptMarketFilters Where p.reportID = Request.QueryString("ReportID") Select p

        For Each p In a


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

    Private Sub RecapListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles RecapListBox.ItemDataBound

        'recap questions list
        Dim q = From p In db1.rptColumns Where p.reportID = Request.QueryString("ReportID") And p.tableName = "Recap" Select p
        For Each p In q
            Dim collection As IList(Of RadListBoxItem) = RecapListBox.Items
            For Each item As RadListBoxItem In collection
                Try
                    Dim itemToSelect As RadListBoxItem = RecapListBox.FindItemByValue(p.dataField)
                    itemToSelect.Checked = True
                Catch ex As Exception
                End Try
            Next
        Next
    End Sub

    Private Sub RecapCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles RecapCheckBox.CheckedChanged

        If RecapCheckBox.Checked = True Then

            RecapListBox.Enabled = True
            EventTypeRecapQuestionsListBox.Enabled = True
            EventTypeComboBox.Enabled = True

            EventTypeRadListBox.Enabled = False

            Dim collection5 As IList(Of RadListBoxItem) = EventTypeRadListBox.CheckedItems

            For Each item As RadListBoxItem In collection5

                item.Checked = False
            Next

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

            EventTypeRadListBox.Enabled = True

        End If

    End Sub

    Private Sub EventTypeRadListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles EventTypeRadListBox.ItemDataBound

        Dim a = From p In db1.rptEventTypeFilters Where p.reportID = Request.QueryString("ReportID") Select p

        For Each p In a


            Dim collection As IList(Of RadListBoxItem) = EventTypeRadListBox.Items

            For Each item As RadListBoxItem In collection

                Try
                    Dim itemToSelect As RadListBoxItem = EventTypeRadListBox.FindItemByValue(p.eventTypeID)
                    itemToSelect.Checked = True

                Catch ex As Exception

                End Try

            Next


        Next

    End Sub

    Private Sub AmbassadorListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles AmbassadorListBox.ItemDataBound
        Dim a = From p In db1.rptColumns Where p.reportID = Request.QueryString("ReportID") Select p

        For Each p In a


            Dim collection As IList(Of RadListBoxItem) = AmbassadorListBox.Items

            For Each item As RadListBoxItem In collection

                Try
                    Dim itemToSelect As RadListBoxItem = AmbassadorListBox.FindItemByText(p.headerText)
                    itemToSelect.Checked = True

                Catch ex As Exception

                End Try

            Next


        Next
    End Sub

    Private Sub BrandRecapQuestionListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles BrandRecapQuestionListBox.ItemDataBound


        Dim a = From p In db1.rptColumns Where p.reportID = Request.QueryString("ReportID") Select p

        For Each p In a


            Dim collection As IList(Of RadListBoxItem) = BrandRecapQuestionListBox.Items

            For Each item As RadListBoxItem In collection

                Try
                    Dim itemToSelect As RadListBoxItem = BrandRecapQuestionListBox.FindItemByText(p.headerText)
                    itemToSelect.Checked = True

                Catch ex As Exception

                End Try

            Next


        Next

    End Sub

    Private Sub BrandsListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles BrandsListBox.ItemDataBound
        Dim a = From p In db1.rptColumns Where p.reportID = Request.QueryString("ReportID") Select p

        For Each p In a


            Dim collection As IList(Of RadListBoxItem) = BrandsListBox.Items

            For Each item As RadListBoxItem In collection

                Try
                    Dim itemToSelect As RadListBoxItem = BrandsListBox.FindItemByText(p.headerText)
                    itemToSelect.Checked = True

                Catch ex As Exception

                End Try

            Next


        Next
    End Sub

    Private Sub BudgetTrackingListBox_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles BudgetTrackingListBox.ItemDataBound
        Dim a = From p In db1.rptColumns Where p.reportID = Request.QueryString("ReportID") Select p

        For Each p In a


            Dim collection As IList(Of RadListBoxItem) = BudgetTrackingListBox.Items

            For Each item As RadListBoxItem In collection

                Try
                    Dim itemToSelect As RadListBoxItem = BudgetTrackingListBox.FindItemByText(p.headerText)
                    itemToSelect.Checked = True

                Catch ex As Exception

                End Try

            Next


        Next
    End Sub


    Private Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
        db.DeleteReport(Convert.ToInt32(Request.QueryString("ReportID")))

        Response.Redirect("/Reports/Dashboard")
    End Sub

    Private Sub POTrackingList_ItemDataBound(sender As Object, e As RadListBoxItemEventArgs) Handles POTrackingList.ItemDataBound

        Dim a = From p In db1.rptColumns Where p.reportID = Request.QueryString("ReportID") Select p

        For Each p In a


            Dim collection As IList(Of RadListBoxItem) = POTrackingList.Items

            For Each item As RadListBoxItem In collection

                Try
                    Dim itemToSelect As RadListBoxItem = POTrackingList.FindItemByText(p.headerText)
                    itemToSelect.Checked = True

                Catch ex As Exception

                End Try

            Next


        Next
    End Sub
End Class