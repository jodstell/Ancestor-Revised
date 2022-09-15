Imports Telerik.Web.UI

Public Class ViewEventReport
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim db1 As New ReportDataClassesDataContext
    Dim db2 As New LMSDataClassesDataContext

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Init
        'the page must load the datagrid on page_init
        BindResultsGrid()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'show report name
        SelectedReportLabel.Text = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.reportTitle).FirstOrDefault

        If Not Page.IsPostBack Then
            FromDatePicker.SelectedDate = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.startDate).FirstOrDefault

            'the ToDatePicker is not populated to allow report page to load fast
            ' ToDatePicker.SelectedDate = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.endDate).FirstOrDefault
        End If


        'load the date fields
    End Sub

    Private Sub BindResultsGrid()

        Dim radGrid1 As RadGrid = New RadGrid
        radGrid1.DataSourceID = "SqlDataSource1"
        radGrid1.MasterTableView.DataKeyNames = New String() {"eventID"}
        radGrid1.Skin = "Bootstrap"
        radGrid1.Width = Unit.Percentage(100)
        radGrid1.Height = Unit.Pixel(600)
        radGrid1.AllowPaging = False
        radGrid1.AutoGenerateColumns = False
        radGrid1.AllowSorting = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.allowSorting).FirstOrDefault

        '  radGrid1.GroupingEnabled = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.allowGrouping).FirstOrDefault
        '  radGrid1.ShowGroupPanel = True


        Dim group As String = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.groupBy).FirstOrDefault

        Select Case group
            Case "0"

            Case "Event"
                Dim expression As GridGroupByExpression = New GridGroupByExpression
                Dim gridGroupByField As GridGroupByField = New GridGroupByField
                'SelectFields values(appear In header)
                gridGroupByField = New GridGroupByField
                gridGroupByField.FieldName = "eventTitle"
                gridGroupByField.HeaderText = "Event"
                gridGroupByField.HeaderValueSeparator = " Name: "
                gridGroupByField.FormatString = "<strong>{0}</strong>"
                expression.SelectFields.Add(gridGroupByField)


                'GroupByFields values (group data)
                gridGroupByField = New GridGroupByField
                gridGroupByField.FieldName = "eventID"
                expression.GroupByFields.Add(gridGroupByField)
                radGrid1.MasterTableView.GroupByExpressions.Add(expression)

            Case "Account"
                Dim expression As GridGroupByExpression = New GridGroupByExpression
                Dim gridGroupByField As GridGroupByField = New GridGroupByField
                'SelectFields values(appear In header)
                gridGroupByField = New GridGroupByField
                gridGroupByField.FieldName = "accountName"
                gridGroupByField.HeaderText = "Account"
                gridGroupByField.HeaderValueSeparator = " Name: "
                gridGroupByField.FormatString = "<strong>{0}</strong>"
                expression.SelectFields.Add(gridGroupByField)


                'GroupByFields values (group data)
                gridGroupByField = New GridGroupByField
                gridGroupByField.FieldName = "accountID"
                expression.GroupByFields.Add(gridGroupByField)
                radGrid1.MasterTableView.GroupByExpressions.Add(expression)

            Case "Brand"
                Try
                    Dim expression As GridGroupByExpression = New GridGroupByExpression
                    Dim gridGroupByField As GridGroupByField = New GridGroupByField
                    'SelectFields values(appear In header)
                    gridGroupByField = New GridGroupByField
                    gridGroupByField.FieldName = "brandName"
                    gridGroupByField.HeaderText = "Brand"
                    gridGroupByField.HeaderValueSeparator = " Name: "
                    gridGroupByField.FormatString = "<strong>{0}</strong>"
                    expression.SelectFields.Add(gridGroupByField)


                    'GroupByFields values (group data)
                    gridGroupByField = New GridGroupByField
                    gridGroupByField.FieldName = "brandID"
                    expression.GroupByFields.Add(gridGroupByField)
                    radGrid1.MasterTableView.GroupByExpressions.Add(expression)
                Catch ex As Exception

                End Try

        End Select


        radGrid1.MasterTableView.EnableColumnsViewState = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.allowReorder).FirstOrDefault
        radGrid1.ClientSettings.AllowColumnsReorder = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.allowReorder).FirstOrDefault
        radGrid1.ClientSettings.ReorderColumnsOnClient = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.allowReorder).FirstOrDefault
        radGrid1.ClientSettings.ColumnsReorderMethod = GridClientSettings.GridColumnsReorderMethod.Reorder



        radGrid1.AllowFilteringByColumn = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.allowFilter).FirstOrDefault
        radGrid1.FilterType = GridFilterType.HeaderContext
        radGrid1.EnableHeaderContextMenu = "true"
        radGrid1.EnableHeaderContextFilterMenu = "true"

        radGrid1.ClientSettings.Scrolling.AllowScroll = True
        ' RadGrid1.ClientSettings.Scrolling.UseStaticHeaders = True
        ' RadGrid1.ClientSettings.Scrolling.SaveScrollPosition = True
        ' RadGrid1.ClientSettings.Scrolling.FrozenColumnsCount = 1


        'put command row on top
        radGrid1.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.Top

        'show export buttons
        radGrid1.MasterTableView.CommandItemSettings.ShowExportToExcelButton = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.exportExcel).FirstOrDefault
        ' radGrid1.MasterTableView.CommandItemSettings.ShowExportToPdfButton = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.exportPDF).FirstOrDefault
        '  radGrid1.MasterTableView.CommandItemSettings.ShowExportToWordButton = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.exportWord).FirstOrDefault
        '  radGrid1.MasterTableView.CommandItemSettings.ShowExportToCsvButton = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.exportCSV).FirstOrDefault

        radGrid1.MasterTableView.CommandItemSettings.ShowExportToCsvButton = True


        radGrid1.MasterTableView.CommandItemSettings.ShowAddNewRecordButton = False
        ' radGrid1.MasterTableView.CommandItemSettings.ShowPrintButton = True
        ' radGrid1.ClientSettings.EnableClientPrint = True

        radGrid1.MasterTableView.CommandItemSettings.ExportToExcelText = "Export to Excel"

        radGrid1.ExportSettings.ExportOnlyData = True

        radGrid1.ExportSettings.OpenInNewWindow = True
        radGrid1.ExportSettings.HideStructureColumns = True
        radGrid1.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx
        radGrid1.ExportSettings.FileName = (From p In db1.rptReports Where p.reportID = Request.QueryString("ReportID") Select p.fileName).FirstOrDefault



        Dim q = From p In db1.rptColumns Where p.reportID = Request.QueryString("ReportID") Select p

        For Each p In q

            Select Case p.tableName
                Case "Event"
                    Dim boundColumn As GridBoundColumn
                    boundColumn = New GridBoundColumn
                    boundColumn.DataField = p.dataField
                    boundColumn.HeaderText = p.headerText
                    boundColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
                    boundColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
                    ' boundColumn.HeaderStyle.Width = Unit.Pixel(235)
                    radGrid1.MasterTableView.Columns.Add(boundColumn)

                Case "Account"
                    Dim boundColumn As GridBoundColumn
                    boundColumn = New GridBoundColumn
                    boundColumn.DataField = p.dataField
                    boundColumn.HeaderText = p.headerText
                    boundColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
                    boundColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
                    ' boundColumn.HeaderStyle.Width = Unit.Pixel(235)
                    radGrid1.MasterTableView.Columns.Add(boundColumn)

                Case "PO"
                    Dim boundColumn As GridBoundColumn
                    boundColumn = New GridBoundColumn
                    boundColumn.DataField = p.dataField
                    boundColumn.HeaderText = p.headerText
                    boundColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
                    boundColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
                    ' boundColumn.HeaderStyle.Width = Unit.Pixel(235)
                    radGrid1.MasterTableView.Columns.Add(boundColumn)

                Case "Recap"
                    Try
                        Dim brands = From b In db1.rptColumns Where b.reportID = Request.QueryString("ReportID") And b.tableName = "Brands" Select b

                        For Each b In brands

                            Dim MyChar() As Char = {"-", "+", "=", "/", " "}

                            Dim templateColumnName As String = p.dataField.TrimStart(MyChar)
                            Dim templateColumn As New GridTemplateColumn()
                            templateColumn.ItemTemplate = New MyTemplate(templateColumnName, b.dataField.TrimStart(MyChar))
                            templateColumn.HeaderText = p.headerText & "(" & getBrandName(b.dataField.TrimStart(MyChar)) & ")"

                            templateColumn.AllowFiltering = False
                            templateColumn.AllowSorting = False
                            templateColumn.Groupable = False

                            templateColumn.EnableHeaderContextMenu = False

                            templateColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
                            templateColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
                            ' templateColumn.HeaderStyle.Width = Unit.Pixel(235)


                            radGrid1.MasterTableView.Columns.Add(templateColumn)
                        Next


                    Catch ex As Exception

                    End Try


                Case "EventTypeRecap"
                    Try
                        Dim MyChar() As Char = {"-", "+", "=", "/", " "}

                        Dim templateColumnName1 As String = p.dataField.TrimStart(MyChar)
                        Dim templateColumn1 As New GridTemplateColumn()
                        templateColumn1.ItemTemplate = New EventTypeTemplate(templateColumnName1)
                        templateColumn1.HeaderText = p.headerText

                        templateColumn1.AllowFiltering = False
                        templateColumn1.AllowSorting = False
                        templateColumn1.Groupable = False

                        templateColumn1.EnableHeaderContextMenu = False

                        templateColumn1.ItemStyle.VerticalAlign = VerticalAlign.Top
                        templateColumn1.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
                        ' templateColumn.HeaderStyle.Width = Unit.Pixel(235)


                        radGrid1.MasterTableView.Columns.Add(templateColumn1)

                    Catch ex As Exception

                    End Try


                Case "BrandRecap"
                    Try
                        Dim MyChar() As Char = {"-", "+", "=", "/", " "}

                        Dim templateColumnName3 As String = p.dataField.TrimStart(MyChar)
                        Dim templateColumn3 As New GridTemplateColumn()
                        templateColumn3.ItemTemplate = New BrandRecapTemplate(templateColumnName3)
                        templateColumn3.HeaderText = p.headerText

                        templateColumn3.AllowFiltering = False
                        templateColumn3.AllowSorting = False
                        templateColumn3.Groupable = False

                        templateColumn3.EnableHeaderContextMenu = False

                        templateColumn3.ItemStyle.VerticalAlign = VerticalAlign.Top
                        templateColumn3.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
                        ' templateColumn.HeaderStyle.Width = Unit.Pixel(235)


                        radGrid1.MasterTableView.Columns.Add(templateColumn3)

                    Catch ex As Exception

                    End Try


                Case "Ambassador"


                    Try
                        Dim templateColumnName2 As String = p.dataField
                        Dim templateColumn2 As New GridTemplateColumn()
                        templateColumn2.ItemTemplate = New AmbassadorTemplate(templateColumnName2)
                        templateColumn2.HeaderText = p.headerText

                        templateColumn2.AllowFiltering = False
                        templateColumn2.AllowSorting = False
                        templateColumn2.Groupable = False

                        templateColumn2.EnableHeaderContextMenu = False

                        templateColumn2.ItemStyle.VerticalAlign = VerticalAlign.Top
                        templateColumn2.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
                        ' templateColumn.HeaderStyle.Width = Unit.Pixel(235)

                        radGrid1.MasterTableView.Columns.Add(templateColumn2)

                    Catch ex As Exception

                    End Try


                Case "BudgetTracking"
                    Try
                        Dim MyChar() As Char = {"-", "+", "=", "/", " "}

                        'changed the query to filter on question not id to fix report
                        'Dim templateColumnName4 As String = p.dataField.TrimStart(MyChar)

                        Dim templateColumnName4 As String = p.headerText
                        Dim templateColumn4 As New GridTemplateColumn()
                        templateColumn4.ItemTemplate = New BudgetTrackingTemplate(templateColumnName4)
                        templateColumn4.HeaderText = p.headerText

                        templateColumn4.AllowFiltering = False
                        templateColumn4.AllowSorting = False
                        templateColumn4.Groupable = False

                        templateColumn4.EnableHeaderContextMenu = False

                        templateColumn4.ItemStyle.VerticalAlign = VerticalAlign.Top
                        templateColumn4.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
                        ' templateColumn.HeaderStyle.Width = Unit.Pixel(235)


                        radGrid1.MasterTableView.Columns.Add(templateColumn4)

                    Catch ex As Exception

                    End Try

            End Select

        Next

        'add the grid to the placeholder
        ResultsGridPlaceHolder.Controls.Add(radGrid1)

    End Sub

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click

        ' BindResultsGrid()

    End Sub

    Shared Function getBrandName(ByVal id As String) As String
        Try
            Dim db As New DataClassesDataContext
            Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
        Catch ex As Exception
            Return ""
        End Try


    End Function

    Shared Function GetCellResult(ByVal id As Integer, rowID As String, brandID As String) As String
        Try
            Dim db As New DataClassesDataContext
            Dim MyChar() As Char = {"-", "+", "=", "/", " "}
            Dim result = (From p In db.tblEventRecapQuestions Where p.recapQuestionID = id And p.eventID = Convert.ToInt32(rowID) And p.brandID = Convert.ToInt32(brandID) Select p.answer.TrimStart(MyChar)).FirstOrDefault
            Return result
        Catch ex As Exception
            Return ""
        End Try


    End Function

    'GetEventTypeRecapResult
    Shared Function GetEventTypeRecapResult(ByVal id As Integer, rowID As String) As String
        Try
            Dim db As New DataClassesDataContext

            Dim MyChar() As Char = {"-", "+", "=", "/", " "}

            Return (From p In db.tblEventRecapQuestions Where p.recapQuestionID = id And p.eventID = Convert.ToInt32(rowID) Select p.answer.TrimStart(MyChar)).FirstOrDefault
        Catch ex As Exception
            Return ""
        End Try


    End Function

    'GetBrandRecapResult
    Shared Function GetBrandRecapResult(ByVal id As Integer, rowID As String) As String
        Try
            Dim db As New DataClassesDataContext

            Dim MyChar() As Char = {"-", "+", "=", "/", " "}

            Return (From p In db.tblEventRecapQuestions Where p.recapQuestionID = id And p.eventID = Convert.ToInt32(rowID) Select p.answer.TrimStart(MyChar)).FirstOrDefault
        Catch ex As Exception
            Return ""
        End Try


    End Function

    Shared Function GetBudgetTrackingResult(ByVal id As String, rowID As String) As String
        'changed id from int to string on 8/23/2017
        Try
            Dim db As New DataClassesDataContext

            Dim MyChar() As Char = {"-", "+", "=", "/", " "}

            'altered query to fix the report on 8/23/2017

            ' Return (From p In db.qryGetBudgetTrackingResults Where p.fieldID = id And p.eventID = Convert.ToInt32(rowID) Select p.answer.TrimStart(MyChar)).FirstOrDefault

            Return (From p In db.qryGetBudgetTrackingResults Where p.question = id And p.eventID = Convert.ToInt32(rowID) Select p.answer.TrimStart(MyChar)).FirstOrDefault

        Catch ex As Exception
            Return ""
        End Try


    End Function



    Shared Function GetAmbassadorResult(ByVal id As String, rowID As String) As String
        Dim db As New DataClassesDataContext
        Dim db2 As New LMSDataClassesDataContext

        Select Case id
            Case "AmbassadorName"
                Dim userName = (From p In db.tblEventStaffingRequirements Where p.eventID = Convert.ToInt32(rowID) Select p.assignedUserName).FirstOrDefault
                Return String.Format("{0} {1}", (From p In db.tblAmbassadors Where p.userName = userName Select p.FirstName).FirstOrDefault, (From p In db.tblAmbassadors Where p.userName = userName Select p.LastName).FirstOrDefault)

            Case "Phone"
                Dim userName = (From p In db.tblEventStaffingRequirements Where p.eventID = Convert.ToInt32(rowID) Select p.assignedUserName).FirstOrDefault
                Return Common.FormatPhoneNumber((From p In db.tblAmbassadors Where p.userName = userName Select p.Phone).FirstOrDefault)

            Case "Email"
                Dim userName = (From p In db.tblEventStaffingRequirements Where p.eventID = Convert.ToInt32(rowID) Select p.assignedUserName).FirstOrDefault
                Return (From p In db2.AspNetUsers Where p.UserName = userName Select p.Email).FirstOrDefault
            Case Else
                Return ""
        End Select


    End Function


    Private Class MyTemplate
        Implements ITemplate
        Protected lControl As LiteralControl
        Private colname As String
        Private brandID As String

        Public Sub New(ByVal cName As String, ByVal cbrandID As String)
            'set the column name
            colname = cName
            brandID = cbrandID
        End Sub
        Public Sub InstantiateIn(ByVal container As System.Web.UI.Control) Implements ITemplate.InstantiateIn
            lControl = New LiteralControl()
            lControl.ID = "lControl"
            AddHandler lControl.DataBinding, AddressOf LControlDataBinding
            container.Controls.Add(lControl)
        End Sub

        Public Sub LControlDataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim l As LiteralControl = DirectCast(sender, LiteralControl)
            Dim container As GridDataItem = DirectCast(l.NamingContainer, GridDataItem)
            l.Text = GetCellResult(colname, DirectCast(container.DataItem, DataRowView)("eventID").ToString(), brandID)

        End Sub
    End Class

    Private Class EventTypeTemplate
        Implements ITemplate
        Protected lControl As LiteralControl
        Private colname As String

        Public Sub New(ByVal cName As String)
            'set the column name
            colname = cName
        End Sub
        Public Sub InstantiateIn(ByVal container As System.Web.UI.Control) Implements ITemplate.InstantiateIn
            lControl = New LiteralControl()
            lControl.ID = "lControl"
            AddHandler lControl.DataBinding, AddressOf LControlDataBinding
            container.Controls.Add(lControl)
        End Sub

        Public Sub LControlDataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim l As LiteralControl = DirectCast(sender, LiteralControl)
            Dim container As GridDataItem = DirectCast(l.NamingContainer, GridDataItem)
            l.Text = GetEventTypeRecapResult(colname, DirectCast(container.DataItem, DataRowView)("eventID").ToString())

        End Sub
    End Class

    Private Class BrandRecapTemplate
        Implements ITemplate
        Protected lControl As LiteralControl
        Private colname As String

        Public Sub New(ByVal cName As String)
            'set the column name
            colname = cName
        End Sub
        Public Sub InstantiateIn(ByVal container As System.Web.UI.Control) Implements ITemplate.InstantiateIn
            lControl = New LiteralControl()
            lControl.ID = "lControl"
            AddHandler lControl.DataBinding, AddressOf LControlDataBinding
            container.Controls.Add(lControl)
        End Sub

        Public Sub LControlDataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim l As LiteralControl = DirectCast(sender, LiteralControl)
            Dim container As GridDataItem = DirectCast(l.NamingContainer, GridDataItem)
            l.Text = GetBrandRecapResult(colname, DirectCast(container.DataItem, DataRowView)("eventID").ToString())

        End Sub
    End Class

    Private Class BudgetTrackingTemplate
        Implements ITemplate
        Protected lControl As LiteralControl
        Private colname As String

        Public Sub New(ByVal cName As String)
            'set the column name
            colname = cName
        End Sub
        Public Sub InstantiateIn(ByVal container As System.Web.UI.Control) Implements ITemplate.InstantiateIn
            lControl = New LiteralControl()
            lControl.ID = "lControl"
            AddHandler lControl.DataBinding, AddressOf LControlDataBinding
            container.Controls.Add(lControl)
        End Sub

        Public Sub LControlDataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim l As LiteralControl = DirectCast(sender, LiteralControl)
            Dim container As GridDataItem = DirectCast(l.NamingContainer, GridDataItem)
            l.Text = GetBudgetTrackingResult(colname, DirectCast(container.DataItem, DataRowView)("eventID").ToString())

        End Sub
    End Class

    ' AmbassadorTemplate

    Private Class AmbassadorTemplate
        Implements ITemplate
        Protected lControl As LiteralControl
        Private colname As String

        Public Sub New(ByVal cName As String)
            'set the column name
            colname = cName
        End Sub
        Public Sub InstantiateIn(ByVal container As System.Web.UI.Control) Implements ITemplate.InstantiateIn
            lControl = New LiteralControl()
            lControl.ID = "lControl"
            AddHandler lControl.DataBinding, AddressOf LControlDataBinding
            container.Controls.Add(lControl)
        End Sub

        Public Sub LControlDataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim l As LiteralControl = DirectCast(sender, LiteralControl)
            Dim container As GridDataItem = DirectCast(l.NamingContainer, GridDataItem)

            l.Text = GetAmbassadorResult(colname, DirectCast(container.DataItem, DataRowView)("eventID").ToString())

        End Sub
    End Class


End Class