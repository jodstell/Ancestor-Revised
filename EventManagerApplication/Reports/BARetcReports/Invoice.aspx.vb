Imports Microsoft.AspNet.Identity
Imports iTextSharp.text.pdf
Imports iTextSharp.text
Imports System.IO
Imports Telerik.Web.UI

Imports System.Web.UI.WebControls
Imports xi = Telerik.Web.UI.ExportInfrastructure
Imports System.Web.UI
Imports System.Web
Imports Telerik.Web.UI.GridExcelBuilder
Imports System.Drawing
Imports System.Data.SqlClient

Public Class Invoice
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim AgencyFee As Double
    Dim expense As Double
    Dim SumExpense As Double
    Dim SumBonus As Double

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            BindInvoice()
        End If

    End Sub

    Sub BindInvoice()

        Dim i = (From p In db.tblInvoices Where p.invoiceID = Request.QueryString("ID") Select p).FirstOrDefault

        BillToTextBox.Text = i.BillTo

        InvoiceTextBox.Text = i.billingInvoiceID
        DatePicker.SelectedDate = i.invoiceDate

        TermsTextBox.Text = i.terms
        POTextBox.Text = i.PO
        LateFeeTextBox.Text = i.LateFee

        Try
            'get the invoice
            Dim invoice = (From p In db.tblInvoices Where p.invoiceID = Request.QueryString("ID") Select p).FirstOrDefault

            If invoice.status = "Draft" Then
                'btnDownLoad.Visible = False
                btnProcess.Visible = True
                btnProcess2.Visible = True
                BtnDeleteInvoice.Visible = True
            End If

            If invoice.status = "Processed" Then
                'btnDownLoad.Visible = True
                btnProcess.Visible = False
                btnProcess2.Visible = False


                Dim dv0 As System.Data.DataView = DirectCast(getInvoiceItems.[Select](DataSourceSelectArguments.Empty), DataView)

                If dv0.Count = 0 Then
                    BtnDeleteInvoice.Visible = True
                Else
                    BtnDeleteInvoice.Visible = False
                End If

            End If




            Try
                'check if there is a fee assigned to supplier
                Dim ManagementFee = (From p In db.tblSuppliers Where p.supplierID = invoice.supplierID Select p.managementFeePercent).FirstOrDefault

                AgencyFee = ManagementFee

                AgencyFeeLabel.Text = String.Format("{0}%", AgencyFee)
            Catch ex As Exception
                AgencyFeeLabel.Text = ex.Message
            End Try


            'InvoiceTextBox.Text = invoice.billingInvoiceID
            'DatePicker.SelectedDate = invoice.invoiceDate

            Dim Supplier = (From p In db.tblSuppliers Where p.supplierID = invoice.supplierID Select p).FirstOrDefault

            BillToTextBox.Text = Supplier.supplierName & Environment.NewLine & Supplier.invoiceHeader

            ' BillToTextBox.Text = invoice.BillTo

            Try
                expense = (From p In db.getTotalExpensesByInvoiceID(invoice.invoiceID) Select p.totalexpense).FirstOrDefault
            Catch ex As Exception
                expense = 0
            End Try

            Try
                SumExpense = (From p In db.getTotalExpensesByInvoiceID(invoice.invoiceID) Select p.totalexpense).Sum
            Catch ex As Exception
                SumExpense = 0
            End Try

            Try
                SumBonus = (From p In db.getTotalBonusByInvoiceID(invoice.invoiceID) Select p.totalexpense).Sum
            Catch ex As Exception
                SumBonus = 0
            End Try


            Dim t = (From p In db.getInvoiceItems(Request.QueryString("ID")) Select p.TotalLabor).Sum

            'Dim total_labor As Double = (From p In db.getTotalLaborByInvoiceID(invoice.invoiceID) Select p.Labor).FirstOrDefault

            Dim subTotal As Double = SumExpense + SumBonus + t

            Dim subTotalwithoutBonus As Double = SumExpense + t

            Dim fee As Double = subTotalwithoutBonus / 100 * AgencyFee

            Dim total As Double = subTotal + fee

            SubTotalLabel.Text = String.Format("{0:c}", subTotal)

            AgencyFeeTotalLabel.Text = String.Format("{0:c}", fee)

            TotalLabel.Text = String.Format("{0:c}", total)

        Catch ex As Exception

        End Try

    End Sub


    Private Sub btnProcess_Click(sender As Object, e As EventArgs) Handles btnProcess.Click
        Dim invoice = (From p In db.tblInvoices Where p.invoiceID = Request.QueryString("ID") Select p).FirstOrDefault

        invoice.billingInvoiceID = InvoiceTextBox.Text
        invoice.terms = TermsTextBox.Text
        invoice.PO = POTextBox.Text
        invoice.LateFee = LateFeeTextBox.Text
        invoice.AdditionalTerms = AdditionalTermsTextBox.Text
        invoice.modifiedBy = User.Identity.GetUserId()
        invoice.modifiedDate = Date.Now()
        invoice.status = "Processed"
        invoice.amount = TotalLabel.Text

        'btnDownLoad.Visible = True
        btnProcess.Visible = False
        btnProcess2.Visible = False

        db.SubmitChanges()

        db.UpdateInvoiceStatus(Convert.ToInt32(Request.QueryString("ID")))

        Response.Redirect("/Reports/BARetcReports/Invoicing")



    End Sub

    Protected Function CreateReceiptScript(ByVal eventExpenseID As Integer) As String
        Return String.Format("var win = window.radopen('/Receipt_Image.aspx?eventExpenseID={0}','Details');win.center();", eventExpenseID)
    End Function

    Private Sub Invoice_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        Dim invoice = (From p In db.tblInvoices Where p.invoiceID = Request.QueryString("ID") Select p).FirstOrDefault

        If invoice.status = "Processed" Then
            InvoiceGrid.MasterTableView.GetColumn("ViewEvent").Display = False

        End If
    End Sub

    Private Sub btnProcess2_Click(sender As Object, e As EventArgs) Handles btnProcess2.Click
        Dim invoice = (From p In db.tblInvoices Where p.invoiceID = Request.QueryString("ID") Select p).FirstOrDefault

        invoice.billingInvoiceID = InvoiceTextBox.Text
        invoice.terms = TermsTextBox.Text
        invoice.PO = POTextBox.Text
        invoice.LateFee = LateFeeTextBox.Text
        invoice.AdditionalTerms = AdditionalTermsTextBox.Text
        invoice.modifiedBy = User.Identity.GetUserId()
        invoice.modifiedDate = Date.Now()
        invoice.status = "Processed"
        invoice.amount = TotalLabel.Text

        'btnDownLoad.Visible = True
        btnProcess2.Visible = False
        btnProcess.Visible = False

        db.SubmitChanges()

        db.UpdateInvoiceStatus(Convert.ToInt32(Request.QueryString("ID")))



        Response.Redirect("/Reports/BARetcReports/Invoicing")
    End Sub


    Private Sub btnCreatePDF_Click(sender As Object, e As EventArgs) Handles btnCreatePDF.Click

        Try
            Using memoryStream As New System.IO.MemoryStream()


                Dim docName As String = "InvoicePDF.pdf"

                Dim document As New iTextSharp.text.Document()
                Dim writer As PdfWriter = PdfWriter.GetInstance(document, memoryStream)

                writer.PageEvent = New MyFooter(writer)

                document.Open()


                Dim bfTimes As iTextSharp.text.pdf.BaseFont = iTextSharp.text.pdf.BaseFont.CreateFont(iTextSharp.text.pdf.BaseFont.HELVETICA, iTextSharp.text.pdf.BaseFont.CP1252, False)

                Dim mainFont As New iTextSharp.text.Font(bfTimes, 7.5, iTextSharp.text.Font.NORMAL)
                Dim mainFont2 As New iTextSharp.text.Font(bfTimes, 6, iTextSharp.text.Font.NORMAL)
                Dim boldFont As New iTextSharp.text.Font(bfTimes, 7.5, iTextSharp.text.Font.BOLD)
                Dim boldFont2 As New iTextSharp.text.Font(bfTimes, 6, iTextSharp.text.Font.BOLD, New BaseColor(255, 255, 255))
                Dim boldFont3 As New iTextSharp.text.Font(bfTimes, 6.5, iTextSharp.text.Font.BOLD)
                Dim headerpay As New iTextSharp.text.Font(bfTimes, 10.5, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))



                Dim ReportHeader As New Paragraph()
                ReportHeader.Alignment = Element.ALIGN_LEFT
                ReportHeader.SpacingBefore = 12.0F
                ReportHeader.Add(New Chunk("Bill to:", New iTextSharp.text.Font(bfTimes, 10.5, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))

                'add report header to document
                'document.Add(ReportHeader)

                Dim cb As PdfContentByte = writer.DirectContent

                ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, ReportHeader, (((document.Right - document.Left) / 3) + (document.LeftMargin - 180)), (document.Top - 60), 0)


                Dim url As String = "http://events.gigengyn.com/images/BARetc.png"

                Dim gif As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(New Uri(url))
                gif.Alignment = iTextSharp.text.Image.ALIGN_LEFT
                gif.ScalePercent(55.0F)


                Dim cb2 As PdfContentByte = writer.DirectContent

                'Logo table
                Dim logo_table As New iTextSharp.text.pdf.PdfPTable(1)
                logo_table.TotalWidth = 400.0F
                logo_table.LockedWidth = True
                logo_table.SpacingBefore = 50.0F


                Dim columnWidths15 As Single() = {400.0F}
                logo_table.SetWidths(columnWidths15)


                logo_table.DefaultCell.Colspan = 1

                Dim cellLogoa As New PdfPCell(gif)
                cellLogoa.Padding = 5
                cellLogoa.Colspan = 1
                cellLogoa.BorderWidth = 0
                cellLogoa.HorizontalAlignment = Element.ALIGN_RIGHT
                logo_table.AddCell(cellLogoa)

                logo_table.WriteSelectedRows(0, -1, 170, 800, cb2)


                'bill to table
                Dim billto_table As New iTextSharp.text.pdf.PdfPTable(1)
                billto_table.TotalWidth = 180.0F
                billto_table.LockedWidth = True
                billto_table.SpacingBefore = 220.0F


                Dim columnWidths1 As Single() = {180.0F}
                billto_table.SetWidths(columnWidths1)


                billto_table.DefaultCell.Colspan = 1


                'Dim cellbilla As New PdfPCell(New iTextSharp.text.Phrase("Bill To", boldFont))
                'cellbilla.Padding = 5
                'cellbilla.Colspan = 1
                'cellbilla.BorderColor = BaseColor.GRAY
                'billto_table.AddCell(cellbilla)

                Dim cellbillb As New PdfPCell(New iTextSharp.text.Phrase(Regex.Replace(BillToTextBox.Text, "<.*?>", String.Empty), mainFont))
                cellbillb.Padding = 5
                cellbillb.Colspan = 1
                cellbillb.HorizontalAlignment = 1
                cellbillb.BorderColor = BaseColor.GRAY
                billto_table.AddCell(cellbillb)

                billto_table.WriteSelectedRows(0, -1, 30, 740, cb2)



                'details to table
                Dim details_table As New iTextSharp.text.pdf.PdfPTable(2)
                details_table.TotalWidth = 230.0F
                details_table.LockedWidth = True
                details_table.SpacingBefore = 220.0F


                Dim columnWidths12 As Single() = {50.0F, 180.0F}
                details_table.SetWidths(columnWidths12)


                details_table.DefaultCell.Colspan = 1


                Dim celldetailsa As New PdfPCell(New iTextSharp.text.Phrase("Date", boldFont))
                celldetailsa.Padding = 5
                celldetailsa.Colspan = 1
                celldetailsa.BorderColor = BaseColor.GRAY
                details_table.AddCell(celldetailsa)

                Dim celldetailsb As New PdfPCell(New iTextSharp.text.Phrase(DatePicker.SelectedDate, mainFont))
                celldetailsb.Padding = 5
                celldetailsb.Colspan = 1
                celldetailsb.BorderColor = BaseColor.GRAY
                details_table.AddCell(celldetailsb)

                Dim celldetailsc As New PdfPCell(New iTextSharp.text.Phrase("Invoice #", boldFont))
                celldetailsc.Padding = 5
                celldetailsc.Colspan = 1
                celldetailsc.BorderColor = BaseColor.GRAY
                details_table.AddCell(celldetailsc)

                Dim celldetailsd As New PdfPCell(New iTextSharp.text.Phrase(InvoiceTextBox.Text, mainFont))
                celldetailsd.Padding = 5
                celldetailsd.Colspan = 1
                celldetailsd.BorderColor = BaseColor.GRAY
                details_table.AddCell(celldetailsd)

                Dim celldetailse As New PdfPCell(New iTextSharp.text.Phrase("Terms", boldFont))
                celldetailse.Padding = 5
                celldetailse.Colspan = 1
                celldetailse.BorderColor = BaseColor.GRAY
                details_table.AddCell(celldetailse)

                Dim celldetailsf As New PdfPCell(New iTextSharp.text.Phrase(TermsTextBox.Text, mainFont))
                celldetailsf.Padding = 5
                celldetailsf.Colspan = 1
                celldetailsf.BorderColor = BaseColor.GRAY
                details_table.AddCell(celldetailsf)

                Dim celldetailsg As New PdfPCell(New iTextSharp.text.Phrase("PO", boldFont))
                celldetailsg.Padding = 5
                celldetailsg.Colspan = 1
                celldetailsg.BorderColor = BaseColor.GRAY
                details_table.AddCell(celldetailsg)

                Dim celldetailsh As New PdfPCell(New iTextSharp.text.Phrase(POTextBox.Text, mainFont))
                celldetailsh.Padding = 5
                celldetailsh.Colspan = 1
                celldetailsh.BorderColor = BaseColor.GRAY
                details_table.AddCell(celldetailsh)

                Dim celldetailsk As New PdfPCell(New iTextSharp.text.Phrase("Late Fee", boldFont))
                celldetailsk.Padding = 5
                celldetailsk.Colspan = 1
                celldetailsk.BorderColor = BaseColor.GRAY
                details_table.AddCell(celldetailsk)

                Dim celldetailsj As New PdfPCell(New iTextSharp.text.Phrase(LateFeeTextBox.Text, mainFont))
                celldetailsj.Padding = 5
                celldetailsj.Colspan = 1
                celldetailsj.BorderColor = BaseColor.GRAY
                details_table.AddCell(celldetailsj)

                details_table.WriteSelectedRows(0, -1, 30, 660, cb2)



                'payment table
                Dim payment_table As New iTextSharp.text.pdf.PdfPTable(2)
                payment_table.TotalWidth = 290.0F
                payment_table.LockedWidth = True
                payment_table.SpacingBefore = 220.0F


                Dim columnWidths3 As Single() = {175.0F, 115.0F}
                payment_table.SetWidths(columnWidths3)

                payment_table.DefaultCell.Colspan = 1

                'header
                Dim cellpayh As New PdfPCell(New iTextSharp.text.Phrase("Please remit payment for all invoices to:", headerpay))
                cellpayh.Padding = 5
                cellpayh.Colspan = 2
                cellpayh.BorderColor = BaseColor.GRAY
                cellpayh.HorizontalAlignment = 1
                payment_table.AddCell(cellpayh)

                Dim cellpaya As New PdfPCell(New iTextSharp.text.Phrase("First Republic Bank
    CapFlow Funding Group Managers, LLC
    for the account of BARetc LLC
    Routing # 321081669
    Account # 80000377656", mainFont))
                cellpaya.Padding = 5
                cellpaya.Colspan = 1
                cellpaya.HorizontalAlignment = 1
                cellpaya.BorderColor = BaseColor.GRAY
                payment_table.AddCell(cellpaya)

                Dim cellpayb As New PdfPCell(New iTextSharp.text.Phrase("
    BARetc LLC
    DEPT CH 16642
PALATINE, IL 60055-6642", mainFont))
                cellpayb.Padding = 5
                cellpayb.Colspan = 1
                cellpayb.HorizontalAlignment = 1
                cellpayb.BorderColor = BaseColor.GRAY
                payment_table.AddCell(cellpayb)


                payment_table.WriteSelectedRows(0, -1, 275, 660, cb2)



                Dim header3 As New Paragraph()
                header3.Alignment = Element.ALIGN_LEFT
                header3.SpacingBefore = 240.0F
                header3.Add(New Chunk(" ", New iTextSharp.text.Font(bfTimes, 14.0, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))



                'add page break
                'document.NewPage()

                Dim TableHeader As New Paragraph()
                TableHeader.Alignment = Element.ALIGN_LEFT
                TableHeader.SpacingBefore = 10.0F
                TableHeader.Add(New Chunk(" ", New iTextSharp.text.Font(bfTimes, 14.0, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))




                'create info table
                Dim info_table As New iTextSharp.text.pdf.PdfPTable(13)
                info_table.TotalWidth = 560.0F
                info_table.LockedWidth = True
                info_table.SpacingBefore = 24.0F

                Dim columnWidths2 As Single() = {45.0F, 60.0F, 50.0F, 39.0F, 39.0F, 40.0F, 65.0F, 42.0F, 30.0F, 30.0F, 35.0F, 42.0F, 43.0F}
                info_table.SetWidths(columnWidths2)



                Dim invoiceID = Request.QueryString("ID")

                Dim q = From p In db.getInvoiceItems(invoiceID) Select p

                'color for the cells
                Dim cellcolor As New BaseColor(70, 130, 180)

                Dim cellaa As New PdfPCell(New iTextSharp.text.Phrase("Date", boldFont2))
                cellaa.Padding = 5
                cellaa.Colspan = 1
                cellaa.BackgroundColor = cellcolor
                info_table.AddCell(cellaa)


                Dim cellbb As New PdfPCell(New iTextSharp.text.Phrase("Market", boldFont2))
                cellbb.Padding = 5
                cellbb.Colspan = 1
                cellbb.BackgroundColor = cellcolor
                info_table.AddCell(cellbb)


                Dim cellcc As New PdfPCell(New iTextSharp.text.Phrase("Event Type", boldFont2))
                cellcc.Padding = 5
                cellcc.Colspan = 1
                cellcc.BackgroundColor = cellcolor
                info_table.AddCell(cellcc)


                Dim celldd As New PdfPCell(New iTextSharp.text.Phrase("Start", boldFont2))
                celldd.Padding = 5
                celldd.Colspan = 1
                celldd.BackgroundColor = cellcolor
                info_table.AddCell(celldd)


                Dim cellee As New PdfPCell(New iTextSharp.text.Phrase("End", boldFont2))
                cellee.Padding = 5
                cellee.Colspan = 1
                cellee.BackgroundColor = cellcolor
                info_table.AddCell(cellee)


                Dim cellff As New PdfPCell(New iTextSharp.text.Phrase("Suplier", boldFont2))
                cellff.Padding = 5
                cellff.Colspan = 1
                cellff.BackgroundColor = cellcolor
                info_table.AddCell(cellff)


                Dim cellgg As New PdfPCell(New iTextSharp.text.Phrase("Brands", boldFont2))
                cellgg.Padding = 5
                cellgg.Colspan = 1
                cellgg.BackgroundColor = cellcolor
                info_table.AddCell(cellgg)


                Dim cellhh As New PdfPCell(New iTextSharp.text.Phrase("Account", boldFont2))
                cellhh.Padding = 5
                cellhh.Colspan = 1
                cellhh.BackgroundColor = cellcolor
                info_table.AddCell(cellhh)


                Dim celljj As New PdfPCell(New iTextSharp.text.Phrase("Hours", boldFont2))
                celljj.Padding = 5
                celljj.Colspan = 1
                celljj.BackgroundColor = cellcolor
                info_table.AddCell(celljj)


                Dim cellkk As New PdfPCell(New iTextSharp.text.Phrase("Bonus", boldFont2))
                cellkk.Padding = 5
                cellkk.Colspan = 1
                cellkk.BackgroundColor = cellcolor
                info_table.AddCell(cellkk)


                Dim cellll As New PdfPCell(New iTextSharp.text.Phrase("Parking", boldFont2))
                cellll.Padding = 5
                cellll.Colspan = 1
                cellll.BackgroundColor = cellcolor
                info_table.AddCell(cellll)


                Dim cellmm As New PdfPCell(New iTextSharp.text.Phrase("Sampling", boldFont2))
                cellmm.Padding = 5
                cellmm.Colspan = 1
                cellmm.BackgroundColor = cellcolor
                info_table.AddCell(cellmm)


                Dim cellnn As New PdfPCell(New iTextSharp.text.Phrase("Total Labor", boldFont2))
                cellnn.Padding = 5
                cellnn.Colspan = 1
                cellnn.BackgroundColor = cellcolor
                info_table.AddCell(cellnn)



                For Each p In q

                    Dim cella As New PdfPCell(New iTextSharp.text.Phrase(p.eventDate, mainFont2))
                    cella.Padding = 5
                    cella.Colspan = 1
                    info_table.AddCell(cella)


                    Dim cellb As New PdfPCell(New iTextSharp.text.Phrase(p.Location, mainFont2))
                    cellb.Padding = 5
                    cellb.Colspan = 1
                    info_table.AddCell(cellb)


                    Dim cellc As New PdfPCell(New iTextSharp.text.Phrase(p.EventType, mainFont2))
                    cellc.Padding = 5
                    cellc.Colspan = 1
                    info_table.AddCell(cellc)


                    Dim celld As New PdfPCell(New iTextSharp.text.Phrase(String.Format("{0:t}", p.startTime), mainFont2))
                    celld.Padding = 5
                    celld.Colspan = 1
                    info_table.AddCell(celld)


                    Dim celle As New PdfPCell(New iTextSharp.text.Phrase(String.Format("{0:t}", p.EndTime), mainFont2))
                    celle.Padding = 5
                    celle.Colspan = 1
                    info_table.AddCell(celle)


                    Dim cellf As New PdfPCell(New iTextSharp.text.Phrase(p.Suplier, mainFont2))
                    cellf.Padding = 5
                    cellf.Colspan = 1
                    info_table.AddCell(cellf)


                    Dim cellg As New PdfPCell(New iTextSharp.text.Phrase(p.Brands, mainFont2))
                    cellg.Padding = 5
                    cellg.Colspan = 1
                    info_table.AddCell(cellg)


                    Dim cellh As New PdfPCell(New iTextSharp.text.Phrase(p.Account, mainFont2))
                    cellh.Padding = 5
                    cellh.Colspan = 1
                    info_table.AddCell(cellh)


                    Dim cellj As New PdfPCell(New iTextSharp.text.Phrase(p.Hours, mainFont2))
                    cellj.Padding = 5
                    cellj.Colspan = 1
                    info_table.AddCell(cellj)


                    Dim cellk As New PdfPCell(New iTextSharp.text.Phrase(FormatCurrency(p.Bonus, , , TriState.True, TriState.True), mainFont2))
                    cellk.Padding = 5
                    cellk.Colspan = 1
                    info_table.AddCell(cellk)


                    Dim celll As New PdfPCell(New iTextSharp.text.Phrase(FormatCurrency(p.Parking, , , TriState.True, TriState.True), mainFont2))
                    celll.Padding = 5
                    celll.Colspan = 1
                    info_table.AddCell(celll)


                    Dim cellm As New PdfPCell(New iTextSharp.text.Phrase(FormatCurrency(p.Sampling, , , TriState.True, TriState.True), mainFont2))
                    cellm.Padding = 5
                    cellm.Colspan = 1
                    info_table.AddCell(cellm)


                    Dim celln As New PdfPCell(New iTextSharp.text.Phrase(FormatCurrency(p.TotalLabor, , , TriState.True, TriState.True), mainFont2))
                    celln.Padding = 5
                    celln.Colspan = 1
                    info_table.AddCell(celln)


                Next



                Dim sumBonus = (From p In db.getInvoiceItems(invoiceID) Select p.Bonus).Sum
                Dim sumParking = (From p In db.getInvoiceItems(invoiceID) Select p.Parking).Sum
                Dim sumSampling = (From p In db.getInvoiceItems(invoiceID) Select p.Sampling).Sum
                Dim sumLabor = (From p In db.getInvoiceItems(invoiceID) Select p.TotalLabor).Sum

                'add the final sum row
                Dim cellaa2 As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                cellaa2.Padding = 5
                cellaa2.Colspan = 1
                info_table.AddCell(cellaa2)


                Dim cellbb2 As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                cellbb2.Padding = 5
                cellbb2.Colspan = 1
                info_table.AddCell(cellbb2)


                Dim cellcc2 As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                cellcc2.Padding = 5
                cellcc2.Colspan = 1
                info_table.AddCell(cellcc2)


                Dim celldd2 As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                celldd2.Padding = 5
                celldd2.Colspan = 1
                info_table.AddCell(celldd2)


                Dim cellee2 As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                cellee2.Padding = 5
                cellee2.Colspan = 1
                info_table.AddCell(cellee2)


                Dim cellff2 As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                cellff2.Padding = 5
                cellff2.Colspan = 1
                info_table.AddCell(cellff2)


                Dim cellgg2 As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                cellgg2.Padding = 5
                cellgg2.Colspan = 1
                info_table.AddCell(cellgg2)


                Dim cellhh2 As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                cellhh2.Padding = 5
                cellhh2.Colspan = 1
                info_table.AddCell(cellhh2)


                Dim celljj2 As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                celljj2.Padding = 5
                celljj2.Colspan = 1
                info_table.AddCell(celljj2)


                Dim cellkk2 As New PdfPCell(New iTextSharp.text.Phrase(FormatCurrency(sumBonus, , , TriState.True, TriState.True), mainFont2))
                cellkk2.Padding = 5
                cellkk2.Colspan = 1
                info_table.AddCell(cellkk2)


                Dim cellll2 As New PdfPCell(New iTextSharp.text.Phrase(FormatCurrency(sumParking, , , TriState.True, TriState.True), mainFont2))
                cellll2.Padding = 5
                cellll2.Colspan = 1
                info_table.AddCell(cellll2)


                Dim cellmm2 As New PdfPCell(New iTextSharp.text.Phrase(FormatCurrency(sumSampling, , , TriState.True, TriState.True), mainFont2))
                cellmm2.Padding = 5
                cellmm2.Colspan = 1
                info_table.AddCell(cellmm2)


                Dim cellnn2 As New PdfPCell(New iTextSharp.text.Phrase(FormatCurrency(sumLabor, , , TriState.True, TriState.True), mainFont2))
                cellnn2.Padding = 5
                cellnn2.Colspan = 1
                info_table.AddCell(cellnn2)





                'final to table
                Dim final_table As New iTextSharp.text.pdf.PdfPTable(3)
                final_table.TotalWidth = 560.0F
                final_table.LockedWidth = True
                final_table.SpacingBefore = 15.0F
                'final_table.HorizontalAlignment = 3


                Dim columnWidths13 As Single() = {410.0F, 100.0F, 50.0F}
                final_table.SetWidths(columnWidths13)

                final_table.DefaultCell.Colspan = 1

                Dim cellfinala As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                cellfinala.Padding = 5
                cellfinala.Colspan = 1
                cellfinala.BorderWidth = 0
                cellfinala.BorderColor = BaseColor.GRAY
                final_table.AddCell(cellfinala)

                Dim cellfinaler As New PdfPCell(New iTextSharp.text.Phrase("Sub Total", mainFont2))
                cellfinaler.Padding = 5
                cellfinaler.Colspan = 1
                cellfinaler.BorderColor = BaseColor.GRAY
                final_table.AddCell(cellfinaler)

                Dim cellfinalb As New PdfPCell(New iTextSharp.text.Phrase(SubTotalLabel.Text, mainFont2))
                cellfinalb.Padding = 5
                cellfinalb.Colspan = 1
                cellfinalb.BorderColor = BaseColor.GRAY
                final_table.AddCell(cellfinalb)

                Dim cellfinalhjk As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                cellfinalhjk.Padding = 5
                cellfinalhjk.Colspan = 1
                cellfinalhjk.BorderWidth = 0
                cellfinalhjk.BorderColor = BaseColor.GRAY
                final_table.AddCell(cellfinalhjk)

                Dim cellfinalc As New PdfPCell(New iTextSharp.text.Phrase("Agency Fee 15%", mainFont2))
                cellfinalc.Padding = 5
                cellfinalc.Colspan = 1
                cellfinalc.BorderColor = BaseColor.GRAY
                final_table.AddCell(cellfinalc)

                Dim cellfinald As New PdfPCell(New iTextSharp.text.Phrase(AgencyFeeTotalLabel.Text, mainFont2))
                cellfinald.Padding = 5
                cellfinald.Colspan = 1
                cellfinald.BorderColor = BaseColor.GRAY
                final_table.AddCell(cellfinald)

                Dim cellfinalcv As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                cellfinalcv.Padding = 5
                cellfinalcv.Colspan = 1
                cellfinalcv.BorderWidth = 0
                cellfinalcv.BorderColor = BaseColor.GRAY
                final_table.AddCell(cellfinalcv)

                Dim cellfinale As New PdfPCell(New iTextSharp.text.Phrase("Total Due", mainFont2))
                cellfinale.Padding = 5
                cellfinale.Colspan = 1
                cellfinale.BorderColor = BaseColor.GRAY
                final_table.AddCell(cellfinale)

                Dim cellfinalf As New PdfPCell(New iTextSharp.text.Phrase(TotalLabel.Text, boldFont3))
                cellfinalf.Padding = 5
                cellfinalf.Colspan = 1
                cellfinalf.BorderColor = BaseColor.GRAY
                final_table.AddCell(cellfinalf)



                'final to table
                Dim terms_table As New iTextSharp.text.pdf.PdfPTable(3)
                terms_table.TotalWidth = 560.0F
                terms_table.LockedWidth = True
                terms_table.SpacingBefore = 25.0F


                Dim columnWidths133 As Single() = {50.0F, 310.0F, 200.0F}
                terms_table.SetWidths(columnWidths133)

                terms_table.DefaultCell.Colspan = 1

                Dim cellterma As New PdfPCell(New iTextSharp.text.Phrase("Terms", boldFont))
                cellterma.Padding = 5
                cellterma.Colspan = 1
                cellterma.BorderWidth = 0
                cellterma.BorderWidthRight = 0.6
                cellterma.BorderColor = BaseColor.GRAY
                terms_table.AddCell(cellterma)

                Dim celltermb As New PdfPCell(New iTextSharp.text.Phrase(AdditionalTermsTextBox.Text, mainFont))
                celltermb.Padding = 5
                celltermb.Colspan = 1
                celltermb.BorderColor = BaseColor.GRAY
                terms_table.AddCell(celltermb)

                Dim celltermc As New PdfPCell(New iTextSharp.text.Phrase(" ", mainFont2))
                celltermc.Padding = 5
                celltermc.Colspan = 1
                celltermc.BorderWidth = 0
                celltermc.BorderColor = BaseColor.GRAY
                terms_table.AddCell(celltermc)



                document.Add(TableHeader)

                document.Add(header3)
                document.Add(info_table)
                document.Add(final_table)
                document.Add(terms_table)


                document.Close()


                Dim bytes As Byte() = memoryStream.ToArray()

                memoryStream.Close()

                Response.Clear()
                Response.ContentType = "application/pdf"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & docName)
                Response.ContentType = "application/pdf"
                Response.Buffer = True
                Response.Cache.SetCacheability(HttpCacheability.NoCache)
                Response.BinaryWrite(bytes)
                Response.[End]()

            End Using
        Catch ex As Exception
            'MailHelper.SendMailMessage("ivans@bletsiansolutions.com", "Error", ex.Message)
        End Try

    End Sub

    Private Sub btnSaveChages_Click(sender As Object, e As EventArgs) Handles btnSaveChages.Click

        Dim invoice = (From p In db.tblInvoices Where p.invoiceID = Request.QueryString("ID") Select p).FirstOrDefault

        invoice.billingInvoiceID = InvoiceTextBox.Text
        invoice.terms = TermsTextBox.Text
        invoice.PO = POTextBox.Text
        invoice.LateFee = LateFeeTextBox.Text
        invoice.AdditionalTerms = AdditionalTermsTextBox.Text
        invoice.modifiedBy = User.Identity.GetUserId()
        invoice.modifiedDate = Date.Now()
        ' invoice.amount = TotalLabel.Text

        db.SubmitChanges()

        Response.Redirect("/Reports/BARetcReports/Invoicing")

    End Sub

    Private Sub BtnDeleteInvoice_Click(sender As Object, e As EventArgs) Handles BtnDeleteInvoice.Click

        'Dim invoice = (From p In db.tblInvoices Where p.invoiceID = Request.QueryString("ID") Select p).FirstOrDefault

        'invoice.status = "Deleted"
        'invoice.modifiedBy = User.Identity.GetUserId()
        'invoice.modifiedDate = Date.Now()

        'db.SubmitChanges()

        db.DeleteInvoice(Convert.ToInt32(Request.QueryString("ID")))

        Response.Redirect("/Reports/BARetcReports/Invoicing")

    End Sub

    Private Sub BtnReturn1_Click(sender As Object, e As EventArgs) Handles BtnReturn1.Click

        'Dim invoice = (From p In db.tblInvoices Where p.invoiceID = Request.QueryString("ID") Select p).FirstOrDefault

        'invoice.amount = TotalLabel.Text

        'db.SubmitChanges()

        Response.Redirect("/Reports/BARetcReports/Invoicing?LoadState=Yes")

    End Sub

    Private Sub btnExportExcel_Click(sender As Object, e As EventArgs) Handles btnExportExcel.Click

        Dim thisSupplierID = (From p In db.tblInvoices Where p.invoiceID = Request.QueryString("ID") Select p.supplierID).FirstOrDefault
        Dim thisInvoiceNumber = (From p In db.tblInvoices Where p.invoiceID = Request.QueryString("ID") Select p.billingInvoiceID).FirstOrDefault
        ' Dim query As String

        ' If thisSupplierID = 219 Or thisSupplierID = 175 Then

        RadGrid1.DataSource = GetDataTable()
            RadGrid1.DataBind()

            RadGrid1.ExportSettings.ExportOnlyData = False
            RadGrid1.ExportSettings.IgnorePaging = True
            RadGrid1.ExportSettings.OpenInNewWindow = True
            RadGrid1.ExportSettings.UseItemStyles = False
            RadGrid1.ExportSettings.FileName = "Invoice" & thisInvoiceNumber

            'EventDataGrid.MasterTableView.GetColumn("ViewButton").Visible = False
            RadGrid1.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

            RadGrid1.MasterTableView.ExportToExcel()

        'query = "SELECT * FROM qryGetInvoiceItems_Wholesaler where invoiceID = " & Request.QueryString("ID")
        'Else

        '    InvoiceGrid.ExportSettings.ExportOnlyData = False
        '    InvoiceGrid.ExportSettings.IgnorePaging = True
        '    InvoiceGrid.ExportSettings.OpenInNewWindow = True
        '    InvoiceGrid.ExportSettings.UseItemStyles = False
        '    InvoiceGrid.ExportSettings.FileName = "Invoice" & thisInvoiceNumber

        '    'EventDataGrid.MasterTableView.GetColumn("ViewButton").Visible = False
        '    InvoiceGrid.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

        '    InvoiceGrid.MasterTableView.ExportToExcel()

        '    ' query = "SELECT * FROM qryGetInvoiceItems where invoiceID = " & Request.QueryString("ID")
        'End If


        'Dim constr As String = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

        'Using con As New SqlConnection(constr)

        '    'add new qry filtered by Processing
        '    Using cmd As New SqlCommand(query)
        '        Using sda As New SqlDataAdapter()
        '            cmd.Connection = con
        '            sda.SelectCommand = cmd

        '            Dim myWriter As New System.IO.StreamWriter(MapPath("~/documents/invoiceID" & thisInvoiceNumber & ".csv"))

        '            Using dt As New DataTable()
        '                sda.Fill(dt)

        '                'Build the CSV file data as a Comma separated string.
        '                Dim csv As String = String.Empty

        '                For Each column As DataColumn In dt.Columns

        '                    'Add the Header row for CSV file.
        '                    csv += column.ColumnName + ","c
        '                Next

        '                'Add new line.
        '                csv += vbCr & vbLf

        '                For Each row As DataRow In dt.Rows

        '                    For Each column As DataColumn In dt.Columns

        '                        'Add the Data rows.
        '                        csv += row(column.ColumnName).ToString().Replace(",", ";") + ","c
        '                    Next

        '                    'Add new line.
        '                    csv += vbCr & vbLf
        '                Next

        '                myWriter.WriteLine(csv)

        '                'Clean up
        '                myWriter.Close()

        '            End Using

        '        End Using

        '    End Using

        'End Using

        'Response.Redirect("~/documents/invoiceID" & thisInvoiceNumber & ".csv")

    End Sub

    Public Function GetDataTable() As DataTable

        Dim query As String = "SELECT * FROM qryGetInvoiceItems_Wholesaler where invoiceID = " & Request.QueryString("ID")

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()
        adapter.SelectCommand = New SqlCommand(query, conn)

        Dim myDataTable As New DataTable()

        conn.Open()
        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function


End Class