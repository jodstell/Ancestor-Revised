Imports System
Imports System.Collections.Generic
Imports System.IO
Imports Telerik.Windows.Documents.Spreadsheet.FormatProviders
Imports Telerik.Windows.Documents.Spreadsheet.FormatProviders.OpenXml.Xlsx
Imports Telerik.Windows.Documents.Spreadsheet.FormatProviders.Pdf
Imports Telerik.Windows.Documents.Spreadsheet.FormatProviders.TextBased.Csv
Imports Telerik.Windows.Documents.Spreadsheet.FormatProviders.TextBased.Txt
Imports Telerik.Windows.Documents.Spreadsheet.Model
Imports Telerik.Windows.Documents.Spreadsheet.Utilities
Imports System.Linq
Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity

Public Class ExportDemo
    Inherits System.Web.UI.Page

    Dim db As New DataClassesDataContext
    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime
    Dim userdb As New LMSDataClassesDataContext

    Shared filter As Boolean = False
    Shared numberofrows As Integer


    Private Shared ReadOnly IndexColumnEventID As Integer = 0
    Private Shared ReadOnly IndexColumnAmbassadorName As Integer = 1
    Private Shared ReadOnly IndexColumnAmbassadorEmail As Integer = 2
    Private Shared ReadOnly IndexColumnAmbassadorPhone As Integer = 3
    Private Shared ReadOnly IndexColumnSupplierName As Integer = 4
    Private Shared ReadOnly IndexRowItemStart As Integer = 1

    Private Shared ReadOnly EnUSCultureAccountFormatString As String = "_($ #,##0.00_);_($ (#,##0.00);_(@_)"
    ' Private Shared ReadOnly InvoiceBackground As ThemableColor = ThemableColor.FromArgb(255, 44, 62, 80)
    '  Private Shared ReadOnly InvoiceHeaderForeground As ThemableColor = ThemableColor.FromArgb(255, 255, 255, 255)



    Private ReadOnly Property Assignments() As List(Of AssignmentList)
        Get
            Using db As New DataClassesDataContext

                Dim list = db.getAssignments_ByUserID(Context.User.Identity.GetUserId(), FromDatePicker.SelectedDate, ToDatePicker.SelectedDate).[Select](Function(p) New AssignmentList() With {
                .EventID = p.eventID,
                .AmbassadorName = p.AmbassadorName,
                .AmbassadorEmail = p.EmailAddress,
                .AmbassadorPhone = p.Phone,
                .SupplierName = p.supplierName
                })

                Return list.ToList()
            End Using
        End Get
    End Property

    Protected Sub RadGrid1_NeedDataSource(sender As Object, e As Telerik.Web.UI.GridNeedDataSourceEventArgs)
        'RadGrid1.DataSource = Products

    End Sub

    Private Sub AssignmentsGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles AssignmentsGrid.NeedDataSource
        TryCast(sender, RadGrid).DataSource = GetDataTable()
    End Sub

    Public Function GetDataTable() As DataTable
        ' Dim query As String = "SELECT eventID, supplierName, eventDate, marketName, eventTypeName, statusName FROM qryViewEvents"

        Dim query As String = "getAssignments_ByUserID"

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()
        adapter.SelectCommand = New SqlCommand(query, conn)

        adapter.SelectCommand.CommandType = CommandType.StoredProcedure

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@UserID", SqlDbType.NVarChar))
        adapter.SelectCommand.Parameters("@UserID").Value = Context.User.Identity.GetUserId()

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@fromDate", SqlDbType.Date))
        adapter.SelectCommand.Parameters("@fromDate").Value = FromDatePicker.SelectedDate

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@toDate", SqlDbType.Date))
        adapter.SelectCommand.Parameters("@toDate").Value = ToDatePicker.SelectedDate


        Dim myDataTable As New DataTable()

        conn.Open()
        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function

    Private Function GetMimeType(fileExt As String) As String
        Dim mimeType As String = [String].Empty
        Select Case fileExt.ToLower()
            Case ".xlsx"
                mimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Exit Select
            Case ".pdf"
                mimeType = "application/pdf"
                Exit Select
            Case ".txt"
                mimeType = "text/plain"
                Exit Select
            Case ".csv"
                mimeType = "text/csv"
                Exit Select
        End Select
        Return mimeType
    End Function

    Public Shared Function GetFormatProvider(extension As String) As IWorkbookFormatProvider
        Dim formatProvider As IWorkbookFormatProvider
        Select Case extension
            Case ".xlsx"
                formatProvider = New XlsxFormatProvider()
                Exit Select
            Case ".csv"
                formatProvider = New CsvFormatProvider()
                DirectCast(formatProvider, CsvFormatProvider).Settings.HasHeaderRow = True
                Exit Select
            Case ".txt"
                formatProvider = New TxtFormatProvider()
                Exit Select
            Case ".pdf"
                formatProvider = New PdfFormatProvider()
                Exit Select
            Case Else
                formatProvider = Nothing
                Exit Select
        End Select

        Return formatProvider
    End Function

    Private Function CreateWorkbook() As Workbook
        Dim workbook As New Workbook()
        workbook.Sheets.Add(SheetType.Worksheet)

        Dim worksheet As Worksheet = workbook.ActiveWorksheet

        Me.PrepareInvoiceDocument(worksheet, Assignments.Count)

        Dim currentRow As Integer = IndexRowItemStart + 1
        For Each item As AssignmentList In Assignments
            worksheet.Cells(currentRow, 0).SetValue(item.EventID)
            worksheet.Cells(currentRow, IndexColumnAmbassadorName).SetValue(item.AmbassadorName)
            worksheet.Cells(currentRow, IndexColumnAmbassadorEmail).SetValue(item.AmbassadorEmail)
            worksheet.Cells(currentRow, IndexColumnAmbassadorPhone).SetValue(item.AmbassadorPhone)
            worksheet.Cells(currentRow, IndexColumnSupplierName).SetValue(item.SupplierName)

            currentRow += 1
        Next

        For i As Integer = 0 To worksheet.Columns.Count - 1
            worksheet.Columns(i).AutoFitWidth()

        Next

        Return workbook
    End Function

    Private Sub PrepareInvoiceDocument(worksheet As Worksheet, itemsCount As Integer)
        Dim lastItemIndexRow As Integer = IndexRowItemStart + itemsCount

        Dim firstRowFirstCellIndex As New CellIndex(0, 0)
        Dim firstRowLastCellIndex As New CellIndex(0, 4)
        Dim lastRowFirstCellIndex As New CellIndex(lastItemIndexRow + 1, IndexColumnEventID)
        Dim lastRowLastCellIndex As New CellIndex(lastItemIndexRow + 1, IndexColumnSupplierName)
        worksheet.Cells(firstRowFirstCellIndex, firstRowLastCellIndex).MergeAcross()
        ' Dim border As New CellBorder(CellBorderStyle.DashDot, InvoiceBackground)
        '  worksheet.Cells(firstRowFirstCellIndex, lastRowLastCellIndex).SetBorders(New CellBorders(border, border, border, border, Nothing, Nothing,
        '  Nothing, Nothing))
        ' worksheet.Cells(lastRowFirstCellIndex, lastRowLastCellIndex).SetBorders(New CellBorders(border, border, border, border, Nothing, Nothing,
        ' Nothing, Nothing))
        worksheet.Cells(firstRowFirstCellIndex).SetValue("Event Assignments")
        worksheet.Cells(firstRowFirstCellIndex).SetFontSize(20)

        worksheet.Cells(IndexRowItemStart, IndexColumnEventID).SetValue("EventID")
        worksheet.Cells(IndexRowItemStart, IndexColumnAmbassadorName).SetValue("Ambassador Name")
        worksheet.Cells(IndexRowItemStart, IndexColumnAmbassadorEmail).SetValue("Ambassador Email")
        ' worksheet.Cells(IndexRowItemStart, IndexColumnUnitPrice).SetHorizontalAlignment(RadHorizontalAlignment.Right)
        worksheet.Cells(IndexRowItemStart, IndexColumnAmbassadorPhone).SetValue("Phone")
        ' worksheet.Cells(IndexRowItemStart, IndexColumnUnitsInStock).SetHorizontalAlignment(RadHorizontalAlignment.Right)
        worksheet.Cells(IndexRowItemStart, IndexColumnSupplierName).SetValue("SupplierName")
        ' worksheet.Cells(IndexRowItemStart, IndexColumnSubTotal).SetHorizontalAlignment(RadHorizontalAlignment.Right)

        'worksheet.Cells(IndexRowItemStart, IndexColumnProductID, IndexRowItemStart, IndexColumnSubTotal).SetFill(New GradientFill(GradientType.Horizontal, InvoiceBackground, InvoiceBackground))
        ' worksheet.Cells(IndexRowItemStart, IndexColumnProductID, IndexRowItemStart, IndexColumnSubTotal).SetForeColor(InvoiceHeaderForeground)
        'worksheet.Cells(IndexRowItemStart, IndexColumnUnitPrice, lastItemIndexRow, IndexColumnUnitPrice).SetFormat(New CellValueFormat(EnUSCultureAccountFormatString))
        'worksheet.Cells(IndexRowItemStart, IndexColumnSubTotal, lastItemIndexRow, IndexColumnSubTotal).SetFormat(New CellValueFormat(EnUSCultureAccountFormatString))

        'worksheet.Cells(lastItemIndexRow + 1, IndexColumnUnitPrice).SetValue("TOTAL: ")
        'worksheet.Cells(lastItemIndexRow + 1, IndexColumnSubTotal).SetFormat(New CellValueFormat(EnUSCultureAccountFormatString))

        'Dim subTotalColumnCellRange As String = NameConverter.ConvertCellRangeToName(New CellIndex(IndexRowItemStart + 1, IndexColumnSubTotal), New CellIndex(lastItemIndexRow, IndexColumnSubTotal))

        'worksheet.Cells(lastItemIndexRow + 1, IndexColumnSubTotal).SetValue(String.Format("=SUM({0})", subTotalColumnCellRange))

        'worksheet.Cells(lastItemIndexRow + 1, IndexColumnUnitPrice, lastItemIndexRow + 1, IndexColumnSubTotal).SetFontSize(20)
    End Sub

    Protected Sub Download_Click(sender As Object, e As EventArgs)
        Dim formatProvider As IWorkbookFormatProvider = GetFormatProvider(".xlsx")
        If formatProvider Is Nothing Then
            Return
        End If

        Dim workbook As Workbook = Me.CreateWorkbook()
        Dim renderedBytes As Byte() = Nothing

        Using ms As New MemoryStream()
            formatProvider.Export(workbook, ms)
            renderedBytes = ms.ToArray()
        End Using

        Response.ClearHeaders()
        Response.ClearContent()
        Response.AppendHeader("content-disposition", "attachment; filename=ExportedFile" + ".xlsx")
        Response.ContentType = GetMimeType(".xlsx")
        Response.BinaryWrite(renderedBytes)
        Response.[End]()

    End Sub

    Private Sub ExportDemo_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            'Enter any Date in MDY format

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 13 - dtNow.DayOfWeek, dtNow)

            'Displays first day of the week
            ' lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")

            FromDatePicker.SelectedDate = weekStartDate
            ToDatePicker.SelectedDate = weekEndDate

            ' PopulateCountLabels()

        End If
    End Sub


End Class

