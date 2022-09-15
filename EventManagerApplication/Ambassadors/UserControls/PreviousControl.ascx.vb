Imports System.Data.SqlClient
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports Telerik.Web.UI

Public Class PreviousControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getBrandName(id As Integer) As String
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function

    Private Sub PreviousEvents_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PreviousEvents.ItemCommand

        If e.CommandName = "StartRecap" Then


            msgLabel.Text = "Starting PDF"

            ' create pdf

            Try
                Using memoryStream As New System.IO.MemoryStream()

                    Dim eventID = Convert.ToInt32(e.CommandArgument)
                    Dim q = (From p In db.getEventDetails Where p.eventID = eventID Select p).FirstOrDefault

                    'create pdf
                    Dim docName As String = "EventRecap_" & eventID & ".pdf"

                    Dim document As New iTextSharp.text.Document()
                    Dim writer As PdfWriter = PdfWriter.GetInstance(document, memoryStream)



                    writer.PageEvent = New MyFooter(writer)

                    document.Open()

                    Dim bfTimes As iTextSharp.text.pdf.BaseFont = iTextSharp.text.pdf.BaseFont.CreateFont(iTextSharp.text.pdf.BaseFont.HELVETICA, iTextSharp.text.pdf.BaseFont.CP1252, False)

                    Dim mainFont As New iTextSharp.text.Font(bfTimes, 9, iTextSharp.text.Font.NORMAL)
                    Dim boldFont As New iTextSharp.text.Font(bfTimes, 9, iTextSharp.text.Font.BOLD)

                    Dim url As String = "http://events.gigengyn.com/images/ProofMarketingLogo_lg.png"

                    Dim gif As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(New Uri(url))
                    gif.Alignment = iTextSharp.text.Image.ALIGN_LEFT
                    gif.ScalePercent(27.0F)
                    'gif.ScaleAbsolute(100, 100)
                    'document.Add(gif)


                    Dim header As New Paragraph()
                    header.Alignment = Element.ALIGN_LEFT
                    header.SpacingBefore = 12.0F
                    header.Add(New Chunk(q.supplierName & " Event Recap", New iTextSharp.text.Font(bfTimes, 16.5, iTextSharp.text.Font.BOLD)))

                    Dim headerLoc As New Paragraph()
                    headerLoc.Alignment = Element.ALIGN_RIGHT
                    headerLoc.SpacingBefore = 12.0F
                    headerLoc.Add(New iTextSharp.text.Phrase(q.AccountName, New iTextSharp.text.Font(bfTimes, 14.0, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))

                    Dim headerLocAddress As New Paragraph()
                    headerLocAddress.Alignment = Element.ALIGN_RIGHT
                    headerLocAddress.SpacingBefore = 12.0F
                    headerLocAddress.Add(New iTextSharp.text.Phrase(q.streetAddress1, New iTextSharp.text.Font(bfTimes, 11.0, iTextSharp.text.Font.BOLD)))

                    Dim headerLocCity As New Paragraph()
                    headerLocCity.Alignment = Element.ALIGN_RIGHT
                    headerLocCity.SpacingBefore = 12.0F
                    headerLocCity.Add(New iTextSharp.text.Phrase(q.city & ", " & q.state & " " & q.zipCode, New iTextSharp.text.Font(bfTimes, 11.0, iTextSharp.text.Font.BOLD)))

                    Dim EventDateLabel2 As New Paragraph()
                    EventDateLabel2.Alignment = Element.ALIGN_LEFT
                    EventDateLabel2.SpacingBefore = 12.0F
                    EventDateLabel2.Add(New iTextSharp.text.Phrase(String.Format("{0:D}", q.eventDate), New iTextSharp.text.Font(bfTimes, 11.0, iTextSharp.text.Font.BOLD)))

                    Dim timeLabel As New Paragraph()
                    timeLabel.Alignment = Element.ALIGN_LEFT
                    timeLabel.SpacingBefore = 12.0F
                    timeLabel.Add(New iTextSharp.text.Phrase(String.Format("{0:t}", q.startTime) & " " & "-" & " " & String.Format("{0:t}", q.endTime), New iTextSharp.text.Font(bfTimes, 11.0, iTextSharp.text.Font.BOLD)))

                    Dim eventType As New Paragraph()
                    eventType.Alignment = Element.ALIGN_LEFT
                    eventType.SpacingBefore = 12.0F
                    eventType.Add(New iTextSharp.text.Phrase("Event Type :" & "    ", boldFont))
                    eventType.Add(New iTextSharp.text.Phrase(q.eventTypeName, mainFont))

                    Dim market As New Paragraph()
                    market.Alignment = Element.ALIGN_LEFT
                    market.SpacingBefore = 12.0F
                    market.Add(New iTextSharp.text.Phrase("Market :" & "    ", boldFont))
                    market.Add(New iTextSharp.text.Phrase(q.marketName, mainFont))

                    Dim supplier As New Paragraph()
                    supplier.Alignment = Element.ALIGN_LEFT
                    supplier.SpacingBefore = 12.0F
                    supplier.Add(New iTextSharp.text.Phrase("Supplier :" & "    ", boldFont))
                    supplier.Add(New iTextSharp.text.Phrase(q.supplierName, mainFont))



                    Dim cb As PdfContentByte = writer.DirectContent

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, header, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 25), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLoc, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 42), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLocAddress, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 57), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLocCity, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 70), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, EventDateLabel2, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 113), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, timeLabel, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 125), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, eventType, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 160), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, market, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 175), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, supplier, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 190), 0)




                    'Header for Venue
                    Dim header2 As New Paragraph()
                    header2.Alignment = Element.ALIGN_LEFT
                    header2.SpacingBefore = 10.0F
                    header2.Add(New Chunk("Venue Details", New iTextSharp.text.Font(bfTimes, 14.0, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))



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

                    logo_table.WriteSelectedRows(0, -1, 170, 805, cb2)



                    'Event name table
                    Dim eventName_table As New iTextSharp.text.pdf.PdfPTable(2)
                    eventName_table.TotalWidth = 560.0F
                    eventName_table.LockedWidth = True
                    eventName_table.SpacingBefore = 50.0F


                    Dim columnWidths10 As Single() = {75.0F, 485.0F}
                    eventName_table.SetWidths(columnWidths10)



                    eventName_table.DefaultCell.Colspan = 1

                    Dim cellNamea As New PdfPCell(New iTextSharp.text.Phrase("Event Name:", New iTextSharp.text.Font(bfTimes, 11.0, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))
                    cellNamea.Padding = 5
                    cellNamea.Colspan = 1
                    cellNamea.BorderWidth = 0
                    cellNamea.BorderWidthBottom = 0.6
                    cellNamea.HorizontalAlignment = Element.ALIGN_RIGHT
                    eventName_table.AddCell(cellNamea)

                    Dim cellNameb As New PdfPCell(New iTextSharp.text.Phrase(q.eventTitle, New iTextSharp.text.Font(bfTimes, 11.0, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))
                    cellNameb.Padding = 5
                    cellNameb.Colspan = 1
                    cellNameb.BorderWidth = 0
                    cellNameb.BorderWidthBottom = 0.6
                    eventName_table.AddCell(cellNameb)

                    eventName_table.WriteSelectedRows(0, -1, 19, 730, cb2)


                    'Brands Table
                    Dim brands_table As New iTextSharp.text.pdf.PdfPTable(2)
                    brands_table.TotalWidth = 560.0F
                    brands_table.LockedWidth = True
                    brands_table.SpacingBefore = 50.0F


                    Dim columnWidths11 As Single() = {43.0F, 517.0F}
                    brands_table.SetWidths(columnWidths11)

                    brands_table.DefaultCell.Colspan = 1

                    Dim cellbranda As New PdfPCell(New iTextSharp.text.Phrase("Brands:", boldFont))
                    cellbranda.Padding = 5
                    cellbranda.Colspan = 1
                    cellbranda.BorderWidth = 0
                    cellbranda.HorizontalAlignment = Element.ALIGN_RIGHT
                    brands_table.AddCell(cellbranda)

                    Dim cellbrandb As New PdfPCell(New iTextSharp.text.Phrase((From p In db.qryViewEvents Where p.eventID = eventID Select p.brands).FirstOrDefault, mainFont))
                    cellbrandb.Padding = 5
                    cellbrandb.Colspan = 1
                    cellbrandb.BorderWidth = 0
                    brands_table.AddCell(cellbrandb)

                    brands_table.WriteSelectedRows(0, -1, 19, 615, cb2)


                    'start event detail table
                    Dim eventdetail_table As New iTextSharp.text.pdf.PdfPTable(2)
                    eventdetail_table.TotalWidth = 540.0F
                    eventdetail_table.LockedWidth = True
                    eventdetail_table.SpacingBefore = 220.0F


                    Dim columnWidths1 As Single() = {120.0F, 420.0F}
                    eventdetail_table.SetWidths(columnWidths1)

                    eventdetail_table.DefaultCell.Padding = 5
                    eventdetail_table.DefaultCell.Colspan = 1
                    eventdetail_table.DefaultCell.BorderColor = BaseColor.GRAY

                    Dim celleventa As New PdfPCell(New iTextSharp.text.Phrase("Event Description:", boldFont))
                    celleventa.Padding = 5
                    celleventa.Colspan = 1
                    celleventa.BorderWidth = 0
                    celleventa.BorderWidthRight = 0.6
                    celleventa.BorderWidthTop = 0.6
                    celleventa.BorderColor = BaseColor.GRAY
                    eventdetail_table.AddCell(celleventa)

                    Dim celleventb As New PdfPCell(New iTextSharp.text.Phrase(Regex.Replace(q.eventDescription, "<.*?>", String.Empty), mainFont))
                    celleventb.Padding = 5
                    celleventb.Colspan = 1
                    celleventb.BorderWidth = 0
                    celleventb.BorderWidthTop = 0.6
                    celleventb.BorderColor = BaseColor.GRAY
                    eventdetail_table.AddCell(celleventb)

                    Dim celleventc As New PdfPCell(New iTextSharp.text.Phrase("Attire:", boldFont))
                    celleventc.Padding = 5
                    celleventc.Colspan = 1
                    celleventc.BorderWidth = 0
                    celleventc.BorderWidthRight = 0.6
                    celleventc.BorderWidthTop = 0.6
                    celleventc.BorderColor = BaseColor.GRAY
                    eventdetail_table.AddCell(celleventc)

                    Dim celleventd As New PdfPCell(New iTextSharp.text.Phrase(Regex.Replace(q.attire, "<.*?>", String.Empty), mainFont))
                    celleventd.Padding = 5
                    celleventd.Colspan = 1
                    celleventd.BorderWidth = 0
                    celleventd.BorderWidthTop = 0.6
                    celleventd.BorderColor = BaseColor.GRAY
                    eventdetail_table.AddCell(celleventd)

                    Dim cellevente As New PdfPCell(New iTextSharp.text.Phrase("POS:", boldFont))
                    cellevente.Padding = 5
                    cellevente.Colspan = 1
                    cellevente.BorderWidth = 0
                    cellevente.BorderWidthRight = 0.6
                    cellevente.BorderWidthTop = 0.6
                    cellevente.BorderColor = BaseColor.GRAY
                    eventdetail_table.AddCell(cellevente)

                    Dim celleventf As New PdfPCell(New iTextSharp.text.Phrase(Regex.Replace(q.posRequirements, "<.*?>", String.Empty), mainFont))
                    celleventf.Padding = 5
                    celleventf.Colspan = 1
                    celleventf.BorderWidth = 0
                    celleventf.BorderWidthTop = 0.6
                    celleventf.BorderColor = BaseColor.GRAY
                    eventdetail_table.AddCell(celleventf)

                    Dim celleventg As New PdfPCell(New iTextSharp.text.Phrase("Sampling Notes:", boldFont))
                    celleventg.Padding = 5
                    celleventg.Colspan = 1
                    celleventg.BorderWidth = 0
                    celleventg.BorderWidthRight = 0.6
                    celleventg.BorderWidthTop = 0.6
                    celleventg.BorderWidthBottom = 0.6
                    celleventg.BorderColor = BaseColor.GRAY
                    eventdetail_table.AddCell(celleventg)

                    Dim celleventh As New PdfPCell(New iTextSharp.text.Phrase(Regex.Replace(q.samplingNotes, "<.*?>", String.Empty), mainFont))
                    celleventh.Padding = 5
                    celleventh.Colspan = 1
                    celleventh.BorderWidth = 0
                    celleventh.BorderWidthTop = 0.6
                    celleventh.BorderWidthBottom = 0.6
                    celleventh.BorderColor = BaseColor.GRAY
                    eventdetail_table.AddCell(celleventh)

                    'eventdetail_table.WriteSelectedRows(0, -1, 27, 580, cb2)





                    Dim header3 As New Paragraph()
                    header3.Alignment = Element.ALIGN_LEFT
                    header3.SpacingBefore = 270.0F
                    header3.Add(New Chunk(" ", New iTextSharp.text.Font(bfTimes, 14.0, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))


                    Dim boldFont2 As New iTextSharp.text.Font(bfTimes, 11, iTextSharp.text.Font.BOLD)

                    'start recap table
                    Dim recap_table As New iTextSharp.text.pdf.PdfPTable(2)
                    recap_table.TotalWidth = 540.0F
                    recap_table.LockedWidth = True
                    recap_table.SpacingBefore = 60.0F
                    recap_table.SplitLate = False

                    Dim columnWidths2 As Single() = {350.0F, 190.0F}
                    recap_table.SetWidths(columnWidths2)


                    Dim brand = From b In db.tblBrandInEvents Where b.eventID = eventID


                    Dim cellheada As New PdfPCell(New Phrase("Recap Questions", New iTextSharp.text.Font(bfTimes, 16.0, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))
                    cellheada.Padding = 5
                    cellheada.Colspan = 1
                    cellheada.BorderWidth = 0
                    recap_table.AddCell(cellheada)


                    Dim cellheadb As New PdfPCell(New iTextSharp.text.Phrase(""))
                    cellheadb.Padding = 5
                    cellheadb.Colspan = 1
                    cellheadb.BorderWidth = 0
                    recap_table.AddCell(cellheadb)


                    For Each b In brand

                        Dim cella As New PdfPCell(New iTextSharp.text.Phrase(getBrandName(b.brandID) & " Brand Recap", boldFont2))
                        cella.Padding = 5
                        cella.Colspan = 1
                        cella.BorderWidth = 0
                        cella.BorderWidthBottom = 0.6
                        recap_table.AddCell(cella)


                        Dim cellb As New PdfPCell(New iTextSharp.text.Phrase(""))
                        cellb.Padding = 5
                        cellb.Colspan = 1
                        cellb.BorderWidth = 0
                        cellb.BorderWidthBottom = 0.6
                        recap_table.AddCell(cellb)

                        Dim recap = From p In db.tblEventRecapQuestions Where p.eventID = eventID And p.brandID = b.brandID Select p Order By p.eventRecapQuestionID

                        For Each p In recap
                            Dim cellc As New PdfPCell(New iTextSharp.text.Phrase(p.question, mainFont))
                            cellc.Padding = 5
                            cellc.Colspan = 1
                            cellc.BorderWidth = 0
                            cellc.BorderWidthRight = 0.6
                            cellc.BorderWidthBottom = 0.6
                            recap_table.AddCell(cellc)

                            Dim celld As New PdfPCell(New iTextSharp.text.Phrase(p.answer, mainFont))
                            celld.Padding = 5
                            celld.Colspan = 1
                            celld.BorderWidth = 0
                            celld.BorderWidthBottom = 0.6
                            recap_table.AddCell(celld)
                        Next

                        Dim celleee As New PdfPCell(New iTextSharp.text.Phrase("                             "))
                        celleee.Padding = 5
                        celleee.Colspan = 1
                        celleee.BorderWidth = 0
                        recap_table.AddCell(celleee)

                        Dim cellfff As New PdfPCell(New iTextSharp.text.Phrase("                             "))
                        cellfff.Padding = 5
                        cellfff.Colspan = 1
                        cellfff.BorderWidth = 0
                        recap_table.AddCell(cellfff)

                    Next


                    Dim celle As New PdfPCell(New iTextSharp.text.Phrase(q.eventTypeName & " Event Details", boldFont2))
                    celle.Padding = 5
                    celle.Colspan = 1
                    celle.BorderWidth = 0
                    celle.BorderWidthBottom = 0.6
                    recap_table.AddCell(celle)

                    Dim cellf As New PdfPCell(New iTextSharp.text.Phrase(""))
                    cellf.Padding = 5
                    cellf.Colspan = 1
                    cellf.BorderWidth = 0
                    cellf.BorderWidthBottom = 0.6
                    recap_table.AddCell(cellf)

                    Dim recap2 = From p In db.tblEventRecapQuestions Where p.eventID = eventID And p.brandID Is Nothing Select p Order By p.eventRecapQuestionID

                    For Each p In recap2
                        Dim cellg As New PdfPCell(New iTextSharp.text.Phrase(p.question, mainFont))
                        cellg.Padding = 5
                        cellg.Colspan = 1
                        cellg.BorderWidth = 0
                        cellg.BorderWidthRight = 0.6
                        cellg.BorderWidthBottom = 0.6
                        recap_table.AddCell(cellg)

                        Dim cellh As New PdfPCell(New iTextSharp.text.Phrase(p.answer, mainFont))
                        cellh.Padding = 5
                        cellh.Colspan = 1
                        cellh.BorderWidth = 0
                        cellh.BorderWidthBottom = 0.6
                        recap_table.AddCell(cellh)
                    Next

                    'document.NewPage()
                    document.Add(header3)
                    document.Add(eventdetail_table)
                    document.Add(recap_table)




                    'start venue details
                    Dim venuedetail_table As New iTextSharp.text.pdf.PdfPTable(2)
                    venuedetail_table.TotalWidth = 500.0F
                    venuedetail_table.LockedWidth = True
                    venuedetail_table.SpacingBefore = 24.0F

                    Dim columnWidths3 As Single() = {170.0F, 300.0F}
                    venuedetail_table.SetWidths(columnWidths3)

                    venuedetail_table.DefaultCell.Padding = 5
                    venuedetail_table.DefaultCell.Colspan = 1
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase("Account Name", boldFont))
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase(q.AccountName, mainFont))
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase("Address", boldFont))
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase(String.Format("{0} {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode), mainFont))
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase("Market", boldFont))
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase(q.marketName, mainFont))
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase("Contact Name", boldFont))
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase("", mainFont))
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase("Contact Phone", boldFont))
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase("", mainFont))
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase("Contact Email", boldFont))
                    venuedetail_table.AddCell(New iTextSharp.text.Phrase("", mainFont))


                    'add page break
                    document.NewPage()

                    Dim GalleryHeader As New Paragraph()
                    GalleryHeader.Alignment = Element.ALIGN_LEFT
                    GalleryHeader.SpacingBefore = 10.0F
                    GalleryHeader.Add(New Chunk("Photos", New iTextSharp.text.Font(bfTimes, 14.0, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))

                    'add gallery header to document
                    document.Add(GalleryHeader)

                    'create gallery table
                    Dim gallery_table As New iTextSharp.text.pdf.PdfPTable(4)
                    gallery_table.TotalWidth = 500.0F
                    gallery_table.LockedWidth = True
                    gallery_table.SpacingBefore = 24.0F

                    Dim q1 = From p In db.tblPhotos Where p.eventID = eventID Select p

                    Dim count = q1.Count

                    For Each p In q1

                        Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
                            sqlconnection.Open()

                            Dim selectQuery As String = String.Format("SELECT SmallImage FROM tblPhoto WHERE photoID ={0}", p.photoID)

                            Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)
                            Dim reader As SqlDataReader = selectCommand.ExecuteReader()

                            If reader.Read() Then
                                Dim byteData As Byte() = DirectCast(reader(0), Byte())
                                Dim strData As String = Encoding.UTF8.GetString(byteData)

                                Dim image As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(byteData)

                                image.ScalePercent(50.0F)

                                gallery_table.AddCell(image)

                            End If


                            sqlconnection.Close()
                        End Using

                    Next

                    gallery_table.CompleteRow()




                    'add gallery to the document
                    document.Add(gallery_table)



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

                msgLabel.Text = "Creating PDF"

            Catch ex As Exception
                msgLabel.Text = ex.Message
            End Try

        End If

    End Sub

    'Private Sub PreviousEventsList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles PreviousEventsList.ItemDataBound

    '    If PreviousEventsList.Items.Count < 1 Then

    '        If e.Item.ItemType = ListItemType.Footer Then
    '            Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
    '            lblFooter.Visible = True
    '        End If

    '    End If


    'End Sub
End Class