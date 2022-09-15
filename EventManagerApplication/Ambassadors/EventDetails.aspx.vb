Imports System.Net
Imports System.Web.Script.Serialization
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports iTextSharp.text.pdf
Imports iTextSharp.text
Imports System.IO
Imports Telerik.Web.UI
Imports System.Drawing
Imports System.Data.SqlClient


Public Class EventDetails_Ambassador
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext

    ' Dim thisEvent As tblEvent

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim action = Request.QueryString("action")

        Select Case action
            Case 0
                'unused case
            Case 1
                msgLabel.Text = Common.ShowAlert("success", "The event was updated successfully!")
            Case 2
                msgLabel.Text = Common.ShowAlert("success", "The event was deleted!")
            Case 3
                msgLabel.Text = Common.ShowAlert("success", "A POS Kit has been requested.")
            Case 4
                ReturnLink1.NavigateUrl = "/Events/ViewEvents?Filter=Nothing"
                ReturnLink1.Text = "Events (Filtered)"
        End Select


        'bind all the data
        If Not Page.IsPostBack Then

            'these sections do not need to reload on postback
            BindPOSKit()
            CheckStatus()
            bindEvent()

        End If

        'these sections need to reload on postback so they are put here
        'BindTestsScores()
        'BindDocuments()


    End Sub


    Private Sub btnCreatePDF_Click(sender As Object, e As EventArgs) Handles btnCreatePDF.Click

        Try
            Using memoryStream As New System.IO.MemoryStream()


                Dim eventID = Request.QueryString("ID")

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
                header.Add(New Chunk(SupplierLabel.Text & " Event Recap", New iTextSharp.text.Font(bfTimes, 16.5, iTextSharp.text.Font.BOLD)))

                Dim headerLoc As New Paragraph()
                headerLoc.Alignment = Element.ALIGN_RIGHT
                headerLoc.SpacingBefore = 12.0F
                headerLoc.Add(New iTextSharp.text.Phrase(AccountNameLabel1.Text, New iTextSharp.text.Font(bfTimes, 14.0, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))

                Dim headerLocAddress As New Paragraph()
                headerLocAddress.Alignment = Element.ALIGN_RIGHT
                headerLocAddress.SpacingBefore = 12.0F
                headerLocAddress.Add(New iTextSharp.text.Phrase(lblStreetAddress.Text, New iTextSharp.text.Font(bfTimes, 11.0, iTextSharp.text.Font.BOLD)))

                Dim headerLocCity As New Paragraph()
                headerLocCity.Alignment = Element.ALIGN_RIGHT
                headerLocCity.SpacingBefore = 12.0F
                headerLocCity.Add(New iTextSharp.text.Phrase(lblCityAddress.Text, New iTextSharp.text.Font(bfTimes, 11.0, iTextSharp.text.Font.BOLD)))

                Dim EventDateLabel2 As New Paragraph()
                EventDateLabel2.Alignment = Element.ALIGN_LEFT
                EventDateLabel2.SpacingBefore = 12.0F
                EventDateLabel2.Add(New iTextSharp.text.Phrase(EventDateLabel.Text, New iTextSharp.text.Font(bfTimes, 11.0, iTextSharp.text.Font.BOLD)))

                Dim timeLabel As New Paragraph()
                timeLabel.Alignment = Element.ALIGN_LEFT
                timeLabel.SpacingBefore = 12.0F
                timeLabel.Add(New iTextSharp.text.Phrase(StartTimeLabel.Text & " " & "-" & " " & EndTimeLabel.Text, New iTextSharp.text.Font(bfTimes, 11.0, iTextSharp.text.Font.BOLD)))

                Dim eventType As New Paragraph()
                eventType.Alignment = Element.ALIGN_LEFT
                eventType.SpacingBefore = 12.0F
                eventType.Add(New iTextSharp.text.Phrase("Event Type :" & "    ", boldFont))
                eventType.Add(New iTextSharp.text.Phrase(EventTypeLabel.Text, mainFont))

                Dim market As New Paragraph()
                market.Alignment = Element.ALIGN_LEFT
                market.SpacingBefore = 12.0F
                market.Add(New iTextSharp.text.Phrase("Market :" & "    ", boldFont))
                market.Add(New iTextSharp.text.Phrase(MarketLabel.Text, mainFont))

                Dim supplier As New Paragraph()
                supplier.Alignment = Element.ALIGN_LEFT
                supplier.SpacingBefore = 12.0F
                supplier.Add(New iTextSharp.text.Phrase("Supplier :" & "    ", boldFont))
                supplier.Add(New iTextSharp.text.Phrase(SupplierLabel.Text, mainFont))



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

                Dim cellNameb As New PdfPCell(New iTextSharp.text.Phrase(EventNameLabel.Text, New iTextSharp.text.Font(bfTimes, 11.0, iTextSharp.text.Font.BOLD, New BaseColor(234, 97, 9))))
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

                Dim celleventb As New PdfPCell(New iTextSharp.text.Phrase(Regex.Replace(DescriptionLabel.Text, "<.*?>", String.Empty), mainFont))
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

                Dim celleventd As New PdfPCell(New iTextSharp.text.Phrase(Regex.Replace(AttireLabel.Text, "<.*?>", String.Empty), mainFont))
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

                Dim celleventf As New PdfPCell(New iTextSharp.text.Phrase(Regex.Replace(POSLabel.Text, "<.*?>", String.Empty), mainFont))
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

                Dim celleventh As New PdfPCell(New iTextSharp.text.Phrase(Regex.Replace(SamplingLabel.Text, "<.*?>", String.Empty), mainFont))
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


                Dim celle As New PdfPCell(New iTextSharp.text.Phrase(EventTypeLabel.Text & " Event Details", boldFont2))
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
                venuedetail_table.AddCell(New iTextSharp.text.Phrase(AccountNameLabel1.Text, mainFont))
                venuedetail_table.AddCell(New iTextSharp.text.Phrase("Address", boldFont))
                venuedetail_table.AddCell(New iTextSharp.text.Phrase(AccountAddressLabel1.Text, mainFont))
                venuedetail_table.AddCell(New iTextSharp.text.Phrase("Market", boldFont))
                venuedetail_table.AddCell(New iTextSharp.text.Phrase(MarketLabel.Text, mainFont))
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

                Dim q = From p In db.tblPhotos Where p.eventID = Request.QueryString("ID") Select p

                Dim count = q.Count

                For Each p In q

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

        Catch ex As Exception
            msgLabel2.Text = ex.Message
        End Try




    End Sub

    Function disableIfNull(id As Integer) As String

        ' Dim q = (From p In db.tblEventExpenses Where p.eventExpenseID = id Select p.receipt).FirstOrDefault

        'If q.Length = 0 Then
        '    Return "There was no file"
        'End If
        Return "There is a file"

    End Function

    Sub CheckStatus()

        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        'get assignment count
        Dim positioncount = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Where p.assigned = True Select p).Count
        Dim assignedcount = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Select p).Count

        Dim status = thisEvent.statusID
        If status = 2 Then
            StatusPanel.Visible = False
            Exit Sub
        End If

        If status = 1 And positioncount > 0 Then
            If positioncount = assignedcount Then
                StatusPanel.Visible = False
            End If
        End If

        If status = 4 And positioncount > 0 Then
            If positioncount = assignedcount Then
                StatusPanel.Visible = True
            End If
        End If

        If status = 7 And positioncount > 0 Then
            If positioncount = assignedcount Then
                StatusPanel.Visible = True
            End If
        End If


    End Sub
    Function getTrainingResults(userID As String) As String

        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        Dim builder As New StringBuilder()

        Dim selectUserName = (From p In db.tblAmbassadors Where p.userID = userID Select p.userName).FirstOrDefault

        'get the list of TrainingGroups

        Dim q = From p In db.getBrandTrainingGroupByEventIDs Where p.eventID = thisEvent.eventID Select p
        For Each p In q
            Dim list = From i In lmsdb.Curriculums Where i.CurriculumGroupID = p.courseGroupID



            For Each i In list
                Dim test = From u In lmsdb.CurriculumLists Where u.CurriculumID = i.CurriculumID And u.ContentType = 7 Select u
                Dim _testID = (From b In lmsdb.CurriculumLists Where b.CurriculumID = i.CurriculumID Select b.TestID).FirstOrDefault

                For Each u In test
                    builder.Append(i.CurriculumTitle)
                    builder.Append("<div class='pull-right'>")
                    builder.Append(getTestResult(selectUserName, _testID))
                    builder.Append("</div>")
                    builder.Append("<br />")
                Next

            Next

        Next

        Return builder.ToString()

    End Function

    Function getTestResult(assignedUserName As String, testID As String) As String


        'Dim r = (From t In lmsdb.baretc_TestResults Where t.UserName = assignedUserName And t.ID = testID Order By t.DateTimeCompleted Descending Select t).Count

        'If r = 0 Then

        '    Return String.Format("<span class='label label-{0}'>{1} {2}</span>", "warning", "No Test Completed", "")

        'Else

        '    Dim _result = (From t In lmsdb.baretc_TestResults Where t.UserName = assignedUserName And t.ID = testID Order By t.DateTimeCompleted Descending Select t.Result).FirstOrDefault

        '    Dim _score = (From t In lmsdb.baretc_TestResults Where t.UserName = assignedUserName And t.ID = testID Order By t.DateTimeCompleted Descending Select t.Score).FirstOrDefault


        '    Dim testresult As String
        '    Dim resultlabel As String
        '    Dim scoreLabel As String

        '    Select Case _result
        '        Case "Passed"
        '            testresult = "success"
        '            resultlabel = "Passed"
        '            scoreLabel = String.Format("{0}%", _score)
        '        Case "Failed"
        '            testresult = "danger"
        '            resultlabel = "Failed"
        '            scoreLabel = String.Format("{0}%", _score)
        '        Case Else
        '            testresult = "warning"
        '            resultlabel = "No Test Completed" & testID
        '            scoreLabel = ""
        '    End Select

        '    Return String.Format("<span class='label label-{0}'>{1} {2}</span>", testresult, resultlabel, scoreLabel)

        'End If

    End Function
    Function getCourseName(curriculumID As String) As String

        Dim test = (From u In lmsdb.CurriculumLists Where u.CurriculumID = curriculumID And u.ContentType = 7 Select u).FirstOrDefault

        Return ""

    End Function

    Protected Function CreateWindowScript(ByVal userID As String, ByVal image As Integer) As String
        Return String.Format("var win = window.radopen('/Profile_Image.aspx?image={1}&UserID={0}','Details');win.center();", userID, image)
    End Function

    Protected Function CreateReceiptScript(ByVal eventExpenseID As Integer) As String
        Return String.Format("var win = window.radopen('/Receipt_Image.aspx?eventExpenseID={0}','Details');win.center();", eventExpenseID)
    End Function

    Protected Function CreateWindowScript2(ByVal userID As String) As String

        Return String.Format("var win = window.radopen('/Events/BrandAmbassadorsDetails.aspx?userID={0}', 'null');win.center();win.setSize(1050, 500);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", userID)

    End Function

    Sub bindEvent()
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


        Dim q = (From p In db.getEventDetails Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault


        'get the status of the recap
        Dim hasRecap = q.recapStatus
        Dim status = q.statusID

        If hasRecap <> 0 Then
            PrintPDFLink.Visible = True
        End If

        If hasRecap = 0 Then
            PrintPDFLink.Visible = False
        End If


        'bind account by locationID

        AccountNameLabel1.Text = q.AccountName
        LatitudeTextBox.Value = q.latitude
        LongtitudeTextBox.Value = q.longitude
        LocationTextBox.Value = q.city & ", " & q.state
        CityLabel.Text = q.city & ", " & q.state

        AccountHyperLink1.NavigateUrl = "/Accounts/AccountDetails?AccountID=" & q.accountID

        AccountAddressLabel1.Text = String.Format("{0} {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)

        PhotoCountLabel.Text = (From p In db.tblPhotos Where p.eventID = q.eventID Select p).Count

        LocationNameMap.Value = String.Format("{0} {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)


        'HF_Latitude.Value = q.latitude ' (From p In db.tblAccounts Where p.Vpid = account Select p.latitude).FirstOrDefault
        'HF_Longtitude.Value = q.longitude ' (From p In db.tblAccounts Where p.Vpid = account Select p.longitude).FirstOrDefault

        StartTimeLabel.Text = String.Format("{0:t}", q.startTime)
        EndTimeLabel.Text = String.Format("{0:t}", q.endTime)
        EventDateLabel.Text = String.Format("{0:D}", q.eventDate)


        'labels for the pdf recap for location
        lblStreetAddress.Text = q.streetAddress1
        lblCityAddress.Text = q.city & ", " & q.state & " " & q.zipCode



        'bind the weather control
        ' BindWeatherGrid(String.Format("{0},{1}", q.city, q.state))


        'populate labels
        EventNameLabel.Text = q.eventTitle
        EventDateLabel.Text = String.Format("{0:D}", q.eventDate)
        EventIDLabel.Text = q.eventID
        DateLabel.Text = String.Format("{0:d}", q.eventDate)

        StartTimeLabel.Text = String.Format("{0:t}", q.startTime)
        EndTimeLabel.Text = String.Format("{0:t}", q.endTime)

        HoursLabel.Text = (From p In db.qryViewEvents Where p.eventID = q.eventID Select p.hours).FirstOrDefault

        'event details
        EventTypeLabel.Text = q.eventTypeName ' getEventTypeName(q.eventTypeID)
        SupplierLabel.Text = q.supplierName ' getSupplierName(q.supplierID)
        MarketLabel.Text = q.marketName ' getMarketName(q.marketID)

        StatusLabel.Text = getStatusName(q.statusID)

        'bind the detail information
        AttireLabel.Text = q.attire
        POSLabel.Text = q.posRequirements
        SamplingLabel.Text = q.samplingNotes
        DescriptionLabel.Text = q.eventDescription

        'NoteCountLabel.Text = (From p In db.tblEventNotes Where p.eventID = q.eventID Select p).Count

        'format color for status label
        Dim i = q.statusID

        Select Case i
            Case "1"
                StatusLabel.ForeColor = Drawing.Color.Green

            Case "2"
                StatusLabel.ForeColor = Drawing.Color.Green
            Case "3"
                StatusLabel.ForeColor = Drawing.Color.Red
            Case "4"
                StatusLabel.ForeColor = Drawing.Color.Green
            Case "5"
                StatusLabel.ForeColor = Drawing.Color.Orange
            Case "6"
                StatusLabel.ForeColor = Drawing.Color.Red

        End Select

        'get brands
        Dim r = From p In db.getBrandsForEvents Where p.eventID = q.eventID Select p

        For Each p In r
            BrandsLabel.Text = BrandsLabel.Text & String.Format("<span class='label label-default'>{0}</span>  ", p.brandName)

        Next


        'staffing

        Dim account = q.locationID


        Try

            'HF_ClientID.Value = "18"

            'HF_MarketID.Value = q.marketID

            'TotalSpendLabel.Text = String.Format("${0}", (From p In db.qryEventStaffingRequirementLists Where p.eventID = q.eventID Select p.Total).Sum)

            'Dim dv As System.Data.DataView = DirectCast(getAvailableAmbassadorList.[Select](DataSourceSelectArguments.Empty), DataView)
            'StaffCountLabel.Text = dv.Count.ToString()
        Catch ex As Exception

        End Try

        ' SelectedDirectionsName

        Dim hasAmbassadorAssigned As Integer = db.ViewPayrollSummaryByEvent(q.eventID).Count

        If hasAmbassadorAssigned = 0 Then
            'ExpensePanel.Visible = False
        End If



    End Sub

    Sub repairBrandRecapQuestions()

        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        Dim eventID As Integer = thisEvent.eventID

        Dim order As Integer = 0

        'get the brands
        Dim brandlist = From p In db.tblBrandInEvents Where p.eventID = eventID Select p
        For Each p In brandlist
            'remove recap questions for the brand
            Dim deleteRecap = db.DeleteBrandRecapQuestionsByEvent(eventID, p.brandID)


            'create new recap list

            'get the custom brand questions for each brand
            Dim r = From w In db.tblBrandRecapQuestions Where w.brandID = p.brandID
            For Each w In r

                Dim recap1 As New tblEventRecapQuestion
                recap1.eventID = eventID
                recap1.brandID = p.brandID
                recap1.question = w.question
                recap1.questionType = w.questionType
                recap1.recapID = 1
                recap1.recapQuestionID = w.brandRecapQuestionID
                recap1.sortorder = order + 1

                db.tblEventRecapQuestions.InsertOnSubmit(recap1)
                db.SubmitChanges()
            Next
        Next

    End Sub

    Sub bindAccount(ByVal id As String)
        Dim q = (From p In db.tblAccounts Where p.Vpid = id Select p).FirstOrDefault

    End Sub

    Function getBrandCourseGroupName(groupID As String) As String
        Return (From p In lmsdb.CurriculumGroups Where p.CurriculumGroupID = groupID Select p.Title).FirstOrDefault

    End Function


    Function getFileName(fileID As String) As String
        Return (From p In lmsdb.Files Where p.ID = fileID Select p.FileName).FirstOrDefault
    End Function

    Function getStatusName(ByVal id As Integer) As String

        Return (From p In db.tblStatus Where p.statusID = id Select p.statusName).FirstOrDefault

    End Function

    Function getSupplierName(ByVal id As Integer) As String

        Return (From p In db.tblSuppliers Where p.supplierID = id Select p.supplierName).FirstOrDefault

    End Function

    Function getEventTypeName(ByVal id As Integer) As String
        Return (From p In db.tblEventTypes Where p.eventTypeID = id Select p.eventTypeName).FirstOrDefault
    End Function

    Function getMarketName(ByVal id As Integer) As String
        Return (From p In db.tblMarkets Where p.marketID = id Select p.marketName).FirstOrDefault
    End Function

    Function getEventLocation(id As String) As String

        Dim q = (From p In db.tblAccounts Where p.Vpid = id Select p).FirstOrDefault

        Return String.Format("{0},{1}", q.city, q.state)
    End Function


    Function getBrandName(id As Integer) As String
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function

    Function getPPS(id As Integer) As String
        Dim pps = (From p In db.tblBrands Where p.brandID = id Select p.packageSize).FirstOrDefault

        If pps = "" Then
            Return "bottles"
        Else
            Return pps & " bottles"
        End If

    End Function

    Sub rebindData()

        StaffingList.DataBind()

        bindEvent()

    End Sub


    Protected Sub cmbPageSize_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)

    End Sub



    'Shared Functions

    Function getFullName(username As String) As String
        If username = "Not Staffed" Then
            Return "<span class='label label-danger'>Not Staffed</span>"
        Else
            Dim userid = (From p In lmsdb.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault

            Dim first_name = (From p In db.tblAmbassadors Where p.userID = userid Select p.FirstName).FirstOrDefault
            Dim last_name = (From p In db.tblAmbassadors Where p.userID = userid Select p.LastName).FirstOrDefault

            Return first_name & " " & last_name
        End If

    End Function


    Function getUserID(username As String) As String
        Dim userdb As New LMSDataClassesDataContext

        Return (From p In userdb.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault
    End Function

    Function setImage(id As String) As Boolean
        If id = "" Then Return False Else Return True
    End Function

    Function checkSchedule(userID As String) As String

        'get event date
        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        Dim event_date As Date = thisEvent.eventDate

        Dim q = (From p In db.getScheduleConflicts Where p.userID = userID And p.eventDate = event_date Select p).Count

        Dim IsAssigned = (From p In db.getScheduleConflicts Where p.userID = userID And p.eventDate = event_date And p.eventID = thisEvent.eventID Select p).Count

        If IsAssigned > 0 Then
            Return "<span class='label label-success'>Assigned to this event</span>"
            Exit Function
        End If

        If q = 0 Then
            Return ""
        Else

            Return "<span class='label label-danger'>There is a potential conflict</span>"
        End If

    End Function

    Function getButtonText(id As Integer) As String
        Return (From p In db.qryEventStaffingRequirements Where p.RequirementID = id Select p.buttonText).First
    End Function

    Function getButtonEnabled(id As Integer) As Boolean
        Return (From p In db.qryEventStaffingRequirements Where p.RequirementID = id Select p.buttonEnabled).First
    End Function

    Function getButtonCssClass(id As Integer) As String
        Return (From p In db.qryEventStaffingRequirements Where p.RequirementID = id Select p.buttonCssClass).First
    End Function

    Function getPositionName(ByVal positionID As Integer) As String
        Return (From p In db.tblStaffingPositions Where p.staffingPositionID = positionID Select p.positionTitle).FirstOrDefault
    End Function

    Function getAssigned(assigned As String) As Boolean

        If assigned = "True" Then
            Return True
        End If

        If assigned = "False" Then
            Return False
        End If

#Disable Warning BC42353 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42353 ' Function doesn't return a value on all code paths

    Function getNotAssigned(assigned As String) As Boolean

        If assigned = "False" Then
            Return True
        Else
            Return False
        End If
    End Function

    Function getTotalPay(id As Integer) As String

        Dim db As New DataClassesDataContext

        Return String.Format("${0}", (From p In db.vewEventStaffingRequirements Where p.requirementID = id Select p.Total).FirstOrDefault)
    End Function

    Function getDollar(id As Integer) As String
        Return "$"
    End Function

    Private Sub StaffingList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles StaffingList.ItemDataBound
        If (e.Item.ItemType = ListItemType.Item) Or
       (e.Item.ItemType = ListItemType.AlternatingItem) Then

            Dim AssignedNameLabel As Label = CType(e.Item.FindControl("AssignedNameLabel"), Label)
            Dim AssignedNameLink As HyperLink = CType(e.Item.FindControl("AssignedNameLink"), HyperLink)

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            Dim HiddenUserID As Label = CType(e.Item.FindControl("HiddenUserID"), Label)

            If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Then
                AssignedNameLabel.Visible = True
                AssignedNameLink.Visible = False
            End If

            If manager.IsInRole(currentUser.Id, "Accounting") Or manager.IsInRole(currentUser.Id, "Administrator") Or manager.IsInRole(currentUser.Id, "EventManager") Or manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
                AssignedNameLabel.Visible = False
                AssignedNameLink.Visible = True
            End If

            If manager.IsInRole(currentUser.Id, "Accounting") Or manager.IsInRole(currentUser.Id, "Administrator") Or manager.IsInRole(currentUser.Id, "EventManager") Or manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
                AssignedNameLabel.Visible = False
                AssignedNameLink.Visible = True

                AssignedNameLink.NavigateUrl = "/ambassadors/ViewAmbassadorDetails?UserID=" & HiddenUserID.Text

            End If

        End If



        If StaffingList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If
    End Sub



    Private Sub btnUpdateStatus_Click(sender As Object, e As EventArgs) Handles btnUpdateStatus.Click

        Try
            Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

            thisEvent.statusID = 2
            thisEvent.ModifiedDate = Date.Now()
            db.SubmitChanges()

            Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "The event status was updated to Booked.", Context.User.Identity.GetUserId(), Date.Now())


        Catch ex As Exception

        End Try

        CheckStatus()


    End Sub

    Function getKitItemQTY(id As Integer) As String

        Return (From p In db.tblInventoryItems Where p.itemID = id Select p.unitsInKit).FirstOrDefault

    End Function

    Function getKitItemPrice(id As Integer) As String

        Return (From p In db.tblInventoryItems Where p.itemID = id Select p.retailPrice).FirstOrDefault

    End Function



    'Photo Gallery Code

    Protected Sub RadSlider1_ValueChanged(ByVal sender As Object, ByVal e As EventArgs)


        Dim selectedValue = DirectCast(sender, RadSlider).Value

        If selectedValue = 1D Then
            ImageHeight = Unit.Pixel(150)
            ImageWidth = Unit.Pixel(150)
            PhotoListView.PageSize = 20

        ElseIf selectedValue = 2D Then
            ImageHeight = Unit.Pixel(200)
            ImageWidth = Unit.Pixel(200)
            PhotoListView.PageSize = 10

        ElseIf selectedValue = 3D Then
            ImageHeight = Unit.Pixel(350)
            ImageWidth = Unit.Pixel(350)
            PhotoListView.PageSize = 6

        End If

        PhotoListView.CurrentPageIndex = 0
        PhotoListView.Rebind()

    End Sub

    Protected Property ImageWidth() As Unit

        Get
            Dim state As Object = If(ViewState("ImageWidth"), Unit.Pixel(200))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageWidth") = value
        End Set

    End Property



    Protected Property ImageHeight() As Unit

        Get
            Dim state As Object = If(ViewState("ImageHeight"), Unit.Pixel(200))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageHeight") = value
        End Set

    End Property

    Protected Function CreateWindowScript3(ByVal eventID As Integer, ByVal photoID As Integer) As String
        Return String.Format("var win = window.radopen('/PhotoGallery.aspx?ID={0}&PhotoID={1}','Details');win.center();", eventID, photoID)
    End Function


    Protected Sub TextBox1_TextChanged(ByVal sender As Object, ByVal e As EventArgs)

        Dim textBox = DirectCast(sender, TextBox)
        Dim keyValue = CInt(DirectCast(textBox.NamingContainer, RadListViewDataItem).GetDataKeyValue("photoID"))

    End Sub

    Private Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        Dim eventID = thisEvent.eventID

        For Each file As UploadedFile In PhotoAsyncUpload.UploadedFiles

            Dim bytes(file.ContentLength - 1) As Byte
            file.InputStream.Read(bytes, 0, file.ContentLength)


            Dim i As New tblPhoto
            i.Image = MakeThumb(bytes, 1200)
            i.LargeImage = MakeThumb(bytes, 500) '1
            i.SmallImage = MakeThumb(bytes, 350) '2
            i.ThumbImage = MakeThumb(bytes, 100) '3

            i.eventID = eventID
            i.photoTitle = getAccountDetails()
            i.dateUploaded = Date.Now()
            i.accountID = getAccountID()
            i.marketID = getMarketID()
            i.uploadedBy = currentUser.Id
            i.fileName = file.GetName
            db.tblPhotos.InsertOnSubmit(i)
            db.SubmitChanges()

        Next

        Try
            Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Photo(s) uploaded", "Photos have been uploaded to the events gallery", Context.User.Identity.GetUserId(), Date.Now())
        Catch ex As Exception
            msgLabel.Text = ex.Message.ToString()
        End Try


        PhotoListView.DataBind()

        GalleryPanel.Visible = True
        UploadPanel.Visible = False

    End Sub

    Function getAccountDetails() As String
        Try
            Dim i = (From p In db.qryViewEvents Where p.eventID = Request.QueryString("ID") Select p)

            For Each p In i
                Return String.Format("{0}, {1}, {2}", p.accountName, p.city, p.state)
            Next
        Catch ex As Exception
            Return ""
        End Try


#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths

    Function getAccountID() As String

        Return (From p In db.qryViewEvents Where p.eventID = Request.QueryString("ID") Select p.accountID).FirstOrDefault

    End Function

    Function getMarketID() As String

        Return (From p In db.qryViewEvents Where p.eventID = Request.QueryString("ID") Select p.marketID).FirstOrDefault

    End Function

    Private Sub btnCancelUpload_Click(sender As Object, e As EventArgs) Handles btnCancelUpload.Click
        GalleryPanel.Visible = True
        UploadPanel.Visible = False

    End Sub

    Private Sub PhotoListView_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PhotoListView.ItemCommand

        Select Case e.CommandName
            Case "DeleteImage"
                Dim id As Integer = e.CommandArgument

                Try
                    Dim deletephoto = db.DeletePhoto(id)

                    PhotoListView.DataBind()
                Catch ex As Exception
                    errorLabel.Text = ex.Message
                End Try

            Case "RotateRight"

                'Response.Redirect(e.CommandArgument)

                Dim photoID = Convert.ToInt32(e.CommandArgument)

                'get the image from sql and save as to disk
                Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault

                Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
                    sqlconnection.Open()

                    Dim selectQuery As String = String.Format("SELECT Image FROM tblPhoto WHERE photoID ={0}", photoID)

                    Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)
                    Dim reader As SqlDataReader = selectCommand.ExecuteReader()
                    If reader.Read() Then
                        Dim byteData As Byte() = DirectCast(reader(0), Byte())
                        Dim strData As String = Encoding.UTF8.GetString(byteData)

                        System.IO.File.WriteAllBytes(Server.MapPath(Convert.ToString("~/documents/rotator/" & _fileName)), byteData)

                    End If
                    sqlconnection.Close()
                End Using

                'rotate the image
                ' get the full path of image url

                Dim path As String = Server.MapPath("~/documents/rotator/" & _fileName)
                Dim newpath As String = Server.MapPath("~/documents/rotator/new/" & photoID & ".png")

                ' creating image from the image url
                Dim i As System.Drawing.Image = System.Drawing.Image.FromFile(path)

                ' rotate Image 90' Degree
                i.RotateFlip(RotateFlipType.Rotate90FlipNone)

                ' save it to its actual path
                i.Save(newpath)

                ' release Image File
                i.Dispose()


                'save image to sql
                Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
                    sqlconnection.Open()

                    Dim bytes As Byte() = Nothing
                    Dim fs As New FileStream(newpath, FileMode.Open, FileAccess.Read)
                    Dim br As New BinaryReader(fs)
                    bytes = br.ReadBytes(CInt(fs.Length))


                    Dim selectQuery As String = String.Format("UPDATE tblPhoto set Image = @image, ThumbImage = @thumbimage, SmallImage = @smallimage, LargeImage = @largeimage WHERE photoID = @photoID")
                    Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)


                    selectCommand.Parameters.Add(New SqlParameter("@photoID", photoID))
                    selectCommand.Parameters.Add(New SqlParameter("@image", MakeThumb(bytes, 1200)))
                    selectCommand.Parameters.Add(New SqlParameter("@thumbimage", MakeThumb(bytes, 100)))
                    selectCommand.Parameters.Add(New SqlParameter("@smallimage", MakeThumb(bytes, 350)))
                    selectCommand.Parameters.Add(New SqlParameter("@largeimage", MakeThumb(bytes, 500)))

                    selectCommand.ExecuteNonQuery()
                    sqlconnection.Close()

                End Using

                PhotoListView.DataBind()

            Case "RotateLeft"

                'Response.Redirect(e.CommandArgument)

                Dim photoID = Convert.ToInt32(e.CommandArgument)

                'get the image from sql and save as to disk
                Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault

                Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
                    sqlconnection.Open()

                    Dim selectQuery As String = String.Format("SELECT Image FROM tblPhoto WHERE photoID ={0}", photoID)

                    Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)
                    Dim reader As SqlDataReader = selectCommand.ExecuteReader()
                    If reader.Read() Then
                        Dim byteData As Byte() = DirectCast(reader(0), Byte())
                        Dim strData As String = Encoding.UTF8.GetString(byteData)

                        System.IO.File.WriteAllBytes(Server.MapPath(Convert.ToString("~/documents/rotator/" & _fileName)), byteData)

                    End If
                    sqlconnection.Close()
                End Using

                'rotate the image
                ' get the full path of image url

                Dim path As String = Server.MapPath("~/documents/rotator/" & _fileName)
                Dim newpath As String = Server.MapPath("~/documents/rotator/new/" & photoID & ".png")

                ' creating image from the image url
                Dim i As System.Drawing.Image = System.Drawing.Image.FromFile(path)

                ' rotate Image 90' Degree
                i.RotateFlip(RotateFlipType.Rotate270FlipNone)

                ' save it to its actual path
                i.Save(newpath)

                ' release Image File
                i.Dispose()


                'save image to sql
                Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
                    sqlconnection.Open()

                    Dim bytes As Byte() = Nothing
                    Dim fs As New FileStream(newpath, FileMode.Open, FileAccess.Read)
                    Dim br As New BinaryReader(fs)
                    bytes = br.ReadBytes(CInt(fs.Length))


                    Dim selectQuery As String = String.Format("UPDATE tblPhoto set Image = @image, ThumbImage = @thumbimage, SmallImage = @smallimage, LargeImage = @largeimage WHERE photoID = @photoID")
                    Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)


                    selectCommand.Parameters.Add(New SqlParameter("@photoID", photoID))
                    selectCommand.Parameters.Add(New SqlParameter("@image", MakeThumb(bytes, 1200)))
                    selectCommand.Parameters.Add(New SqlParameter("@thumbimage", MakeThumb(bytes, 100)))
                    selectCommand.Parameters.Add(New SqlParameter("@smallimage", MakeThumb(bytes, 350)))
                    selectCommand.Parameters.Add(New SqlParameter("@largeimage", MakeThumb(bytes, 500)))

                    selectCommand.ExecuteNonQuery()
                    sqlconnection.Close()

                End Using

                PhotoListView.DataBind()

        End Select
    End Sub

    Private Sub btnAddPhotos_Click(sender As Object, e As EventArgs) Handles btnAddPhotos.Click

        GalleryPanel.Visible = False
        UploadPanel.Visible = True

    End Sub



    Protected Sub btnDetails_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub btnPrev_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub btnFirst_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub btnNext_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub btnLast_Click(sender As Object, e As EventArgs)

    End Sub



    Function getFullName2(ByVal id As String) As String
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(id)

        Dim result = (From p In lmsdb.AspNetUsersProfiles Where p.UserID = currentUser.Id Select p).FirstOrDefault

        Return String.Format("{0} {1}", result.FirstName, result.LastName)

    End Function

    Protected Sub btnInsert_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub DeleteButton_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub CancelButton_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub UpdateButton_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub EditButton_Click(sender As Object, e As EventArgs)

    End Sub 'End Notes Tab Code

    Protected Sub btnInsertExpense_Click(sender As Object, e As EventArgs)


    End Sub

    Protected Sub btnCancelExpense_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub CancelEditExpenseButton_Click(sender As Object, e As EventArgs)

    End Sub


#Region "POS"

    Sub BindPOSKit()

        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        'clear the list
        POSItemList.Items.Clear()
        noPosItemsLabel.Text = ""

        Dim eventType_ID = thisEvent.eventTypeID ' (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.eventTypeID).FirstOrDefault

        EventTypeName.Text = String.Format("{0} Kit Available:", (From p In db.tblEventTypes Where p.eventTypeID = eventType_ID Select p.eventTypeName).FirstOrDefault)

        'OffPremise
        If eventType_ID = 261 Then

            Dim c1 = (From p In db.getOffPremisePosItemsByBrand(Request.QueryString("ID")) Select p).Count

            If c1 = 0 Then
                noPosItemsLabel.Text = Common.ShowAlertNoClose("warning", "There are no POS Kits available")
                noPosItemsPanel.Visible = True
                POSPanel.Visible = False
            End If

            Dim r = From p In db.getOffPremisePosItemsByBrand(Request.QueryString("ID")) Select p

            For Each p In r
                Dim mystring = String.Format("{0} ({1})  {2} ({3})", p.unitsInKit, p.packageSize, p.itemName, p.brandName)

                'add to the list
                Dim newItem As New RadListBoxItem(mystring, p.itemID)
                POSItemList.Items.Add(newItem)
            Next

        End If

        'OnPremise
        If eventType_ID = 262 Then
            Dim c2 = (From p In db.getOnPremisePosItemsByBrand(Request.QueryString("ID")) Select p).Count

            If c2 = 0 Then
                noPosItemsLabel.Text = Common.ShowAlertNoClose("warning", "There are no POS Kits available")
                noPosItemsPanel.Visible = True
                POSPanel.Visible = False
            End If

            Dim r = From p In db.getOnPremisePosItemsByBrand(Request.QueryString("ID")) Select p

            For Each p In r
                Dim mystring = String.Format("{0} ({1})  {2} ({3})", p.unitsInKit, p.packageSize, p.itemName, p.brandName)

                'add to the list
                Dim newItem As New RadListBoxItem(mystring, p.itemID)
                POSItemList.Items.Add(newItem)
            Next

        End If

        If Not Page.IsPostBack Then
            Try
                KitRequested.SelectedValue = thisEvent.posKitRequested
            Catch ex As Exception
                'don't worry about it, the data was null
            End Try

            NotesTextBox.Text = thisEvent.posKitShippingNote

            Dim q = (From p In db.tblPosKits Where p.eventID = thisEvent.eventID Select p).Count

            Try


                Dim tracking As String = (From p In db.tblPosKits Where p.eventID = thisEvent.eventID Select p.trackingNumber).FirstOrDefault

                Dim vendor As String = (From p In db.tblPosKits Where p.eventID = thisEvent.eventID Select p.shippingVendorID).FirstOrDefault

                Dim trackingString As String

                If tracking = "" Then
                    'do nothing
                    trackingString = ""
                Else

                    'get the shipping vendor

                    Select Case vendor
                        Case "1"
                            'FedEx
                            trackingString = String.Format("http://www.fedex.com/Tracking?language=english&cntry_code=us&tracknumbers={0}", tracking)

                        Case "2"
                            'UPS
                            trackingString = String.Format("http://wwwapps.ups.com/WebTracking/track?track=yes&trackNums={0}", tracking)


                        Case "3"
                            trackingString = "" 'None

                        Case "4"
                            trackingString = ""  'Other
                        Case Else
                            trackingString = ""


                    End Select


                End If

                'there is a pos kit already
                If q > 0 Then

                    btnSavePosKitRequest.Visible = False
                    noPosItemsLabel.Text = ""
                    POSKitRequestedLabel.Text = Common.ShowAlertNoClose("success", "A POS Kit has been requested. <a target='_blank' href=" & trackingString & ">Check status here!</a>")
                    noPosItemsPanel.Visible = True
                    POSPanel.Visible = False
                End If


            Catch ex As Exception

            End Try






        End If
    End Sub

    Private Sub btnSavePosKitRequest_Click(sender As Object, e As EventArgs) Handles btnSavePosKitRequest.Click

        If POSItemList.CheckedItems.Count = 0 Then

            errorLabel2.Text = "<h5 style='margin-top:5px'><span class='label label-danger'>You needs to select items to add to the kit</span></h4>"

            Exit Sub
        End If

        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        'get the event address
        Dim q1 = (From p In db.tblAccounts Where p.Vpid = thisEvent.locationID Select p).FirstOrDefault

        'get the ambassador address
        Dim q2 = (From p In db.tblAmbassadors Where p.userName = "" Select p)

        'create pos kit
        Dim newkit As New tblPosKit
        newkit.eventID = thisEvent.eventID
        newkit.shipTo = SendToList.SelectedValue
        newkit.status = "Pending"
        newkit.shippingVendorID = 1
        newkit.shippingMethodID = 2
        newkit.createdBy = Context.User.Identity.GetUserId()
        newkit.createdDate = Date.Now()

        'Brand Ambassador
        If SendToList.SelectedValue = "1" Then

            newkit.shipTo = ""
            newkit.shippingAddress = ""
            newkit.shippingCity = ""
            newkit.shippingState = ""
            newkit.shippingZip = ""



        End If

        'Event Location
        If SendToList.SelectedValue = "2" Then
            newkit.shipTo = q1.accountName
            newkit.shippingAddress = q1.streetAddress1
            newkit.shippingCity = q1.city
            newkit.shippingState = q1.state
            newkit.shippingZip = q1.zipCode
        End If

        'FedEx Office
        If SendToList.SelectedValue = "3" Then
            newkit.shipTo = "FedEx Location"
            newkit.shippingAddress = ""
            newkit.shippingCity = q1.city
            newkit.shippingState = q1.state
            newkit.shippingZip = q1.zipCode
        End If

        db.tblPosKits.InsertOnSubmit(newkit)
        db.SubmitChanges()

        Dim collection As IList(Of RadListBoxItem) = POSItemList.CheckedItems

        For Each item As RadListBoxItem In collection

            Dim newKitItem As New tblPosKitItem With {.kitID = newkit.kitID, .itemID = item.Value, .itemName = item.Text, .qty = getKitItemQTY(item.Value), .price = getKitItemPrice(item.Value)}

            db.tblPosKitItems.InsertOnSubmit(newKitItem)
            db.SubmitChanges()

        Next
        SuccessLabel.Visible = True
        SuccessLabel.Text = Common.ShowAlertNoClose("success", "The request has been sent.")
        btnSavePosKitRequest.Visible = False

        POSItemList.Items.Clear()
        BindPOSKit()

    End Sub

#End Region

#Region "Courses"
    Private Sub InvitationButton_Click(sender As Object, e As EventArgs) Handles InvitationButton.Click
        EventCourseListView.Visible = False
        InvitationButton.Visible = False
        InvitationPanel.Visible = True
    End Sub

    Private Sub btnSubmitInvitation_Click(sender As Object, e As EventArgs) Handles btnSubmitInvitation.Click
        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        Dim token As String = System.Guid.NewGuid().ToString()
        'add to table
        Dim i As New tblEventTrainingInvitation With {.eventID = thisEvent.eventID, .dateSent = Date.Now(), .emailAddress = InvitationEmailTextBox.Text, .token = token}
        db.tblEventTrainingInvitations.InsertOnSubmit(i)
        db.SubmitChanges()

        'send invitation email
        Try

            'get my html file
            Dim reader As New StreamReader(Server.MapPath("~/Files/TrainingInvitation.html"))
            Dim readFile As String = reader.ReadToEnd()
            Dim myString As String = ""
            myString = readFile
            myString = myString.Replace("$$token$$", token)
            ' myString = myString.Replace("$$password$$", password)

            Dim recipient = InvitationEmailTextBox.Text

            'send email
            MailHelper.SendMailMessage(recipient, "Training Invitation", myString)

            msgTrainingLabel.Text = Common.ShowAlertNoClose("success", "Your invitation has been sent to the email you provided.")
            InvitationEmailTextBox.Text = ""

            reader.Close()

        Catch ex As Exception
            msgTrainingLabel.Text = Common.ShowAlertNoClose("danger", ex.Message)
        End Try



        'refresh view
        EventCourseListView.Visible = True
        InvitationButton.Visible = True
        InvitationPanel.Visible = False

    End Sub

    Private Sub btnCancelInvitation_Click(sender As Object, e As EventArgs) Handles btnCancelInvitation.Click
        EventCourseListView.Visible = True
        InvitationButton.Visible = True
        InvitationPanel.Visible = False

    End Sub

    Sub BindTestsScores()

        'Show Test Results
        Try

            'get the list of ambassadors available
            Dim i = From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Select p

            'there are no assignments so we better leave a friendly message
            If i.Count = 0 Then
                Dim div As New HtmlGenericControl("div")
                Dim lbl1 As New HtmlGenericControl("label")
                lbl1.InnerHtml = String.Format("{0}", "There are no ambassadors assigned")
                div.Controls.Add(lbl1)

                TestScoresPlaceHolder.Controls.Add(div)
            End If

            'there are assignments
            For Each p In i

                Dim _userID = (From j In db.tblAmbassadors Where j.userName = p.assignedUserName Select j.userID).FirstOrDefault
                Dim _firstName = (From m In db.tblAmbassadors Where m.userID = _userID Select m.FirstName).FirstOrDefault
                Dim _lastName = (From m In db.tblAmbassadors Where m.userID = _userID Select m.LastName).FirstOrDefault

                If p.assigned = True Then

                    Dim div As New HtmlGenericControl("div")
                    Dim lbl1 As New HtmlGenericControl("label")
                    lbl1.InnerHtml = String.Format("{0} {1}", _firstName, _lastName)
                    div.Controls.Add(lbl1)

                    TestScoresPlaceHolder.Controls.Add(div)

                    'get the brands
                    Dim _brandID = From a In db.getBrandTrainingGroupByEventIDs Where a.eventID = Request.QueryString("ID") Select a


                    For Each a In _brandID

                        Dim _curriculum = (From l In lmsdb.Curriculums Where l.CurriculumGroupID = a.courseGroupID Select l).Distinct

                        'if there are no Curriculum results
                        'If _curriculum.Count = 0 Then
                        '    Dim div12 As New HtmlGenericControl("div")
                        '    div12.InnerHtml = String.Format("There are no tests online for {0}", "") 'getBrandName(a.brandID)
                        '    div12.Attributes.Add("class", "marginbottom10")
                        '    div12.Attributes.Add("class", "text-danger")

                        '    TestScoresPlaceHolder.Controls.Add(div12)
                        'End If

                        For Each list In _curriculum

                            Dim test = (From u In lmsdb.CurriculumLists Where u.CurriculumID = list.CurriculumID And u.ContentType = 7 Select u).Distinct

                            For Each u In test
                                Dim type = (From y In lmsdb.CurriculumLists Where y.CurriculumID = list.CurriculumID Select y.ContentType).FirstOrDefault
                                Dim _testID = (From b In lmsdb.CurriculumLists Where b.CurriculumID = list.CurriculumID Select b.TestID).FirstOrDefault

                                Dim _result = (From t In lmsdb.baretc_TestResults Where t.UserName = p.assignedUserName And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Result).FirstOrDefault
                                Dim _score = (From t In lmsdb.baretc_TestResults Where t.UserName = p.assignedUserName And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Score).FirstOrDefault


                                Dim testresult As String
                                Dim resultlabel As String
                                Dim scoreLabel As String

                                Select Case _result
                                    Case "Passed"
                                        testresult = "success"
                                        resultlabel = "Passed"
                                        scoreLabel = String.Format("{0}%", _score)
                                    Case "Failed"
                                        testresult = "danger"
                                        resultlabel = "Failed"
                                        scoreLabel = String.Format("{0}%", _score)
                                    Case Else
                                        testresult = "warning"
                                        resultlabel = "Not Started"
                                        scoreLabel = ""
                                End Select

                                'only show for tests
                                Dim wrapper As New HtmlGenericControl("div")
                                wrapper.Attributes.Add("class", "row")

                                Dim div2 As New HtmlGenericControl("div")
                                div2.Attributes.Add("class", "col-sm-12")

                                Dim lbl3 As New HtmlGenericControl("div")
                                lbl3.InnerHtml = String.Format("{0}", list.CurriculumTitle)
                                lbl3.Attributes.Add("class", "leftColumn")
                                div2.Controls.Add(lbl3)


                                Dim lbl4 As New HtmlGenericControl("div")
                                lbl4.InnerHtml = String.Format("<h4><span class='label label-{0}'>{1} {2}</span></h4>", testresult, resultlabel, scoreLabel)
                                lbl4.Attributes.Add("class", "pull-right")
                                div2.Controls.Add(lbl4)

                                wrapper.Controls.Add(div2)

                                TestScoresPlaceHolder.Controls.Add(wrapper)

                            Next

                        Next

                    Next 'end of brands

                End If

            Next

        Catch ex As Exception

        End Try

    End Sub

    Sub BindDocuments()

        'get brands
        Dim r = From p In db.getCourseForEvents Where p.eventID = Request.QueryString("ID") Select p

        For Each p In r

            Dim div As New HtmlGenericControl("div")

            Dim lbl As New HtmlGenericControl("h3")
            lbl.InnerHtml = getBrandCourseGroupName(p.CourseTitle)
            div.Controls.Add(lbl)

            DocumentsPlaceHolder.Controls.Add(div)

            Dim ID = (From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l.CurriculumID).FirstOrDefault
            Dim related = (From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l.CurriculumGroupID).FirstOrDefault

            Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l

            ''there are no documents so we will show a friendly message
            'If course.Count = 0 Then

            '

            '    Exit Sub
            ' End If

            Dim myFiles = From i In lmsdb.CourseFiles Where i.RelatedID = p.curriculum Select i

            If myFiles.Count = 0 Then
                Dim divb As New HtmlGenericControl("div")
                divb.Attributes.Add("class", "form-group")

                Dim lblb As New HtmlGenericControl("label")
                lblb.InnerHtml = "There are no documents currently available"
                divb.Controls.Add(lblb)

                DocumentsPlaceHolder.Controls.Add(divb)
            Else
                Dim type = (From u In lmsdb.CurriculumLists Where u.CurriculumID = ID Select u.ContentType).FirstOrDefault
                Dim _testID = (From u In lmsdb.CurriculumLists Where u.CurriculumID = ID Select u.TestID).FirstOrDefault

                Dim icon As String = ""

                For Each i In myFiles
                    Dim div1 As New HtmlGenericControl("div")

                    icon = "<i class='fa fa-file-pdf-o' aria-hidden='True'></i>"

                    Dim lbl1 As New HtmlGenericControl("div")
                    lbl1.Attributes.Add("class", "leftColumn")
                    lbl1.InnerHtml = icon
                    div1.Controls.Add(lbl1)

                    ' Create a text box control
                    Dim box As New HyperLink
                    box.CssClass = "pointer"
                    box.NavigateUrl = "/filehandler?ID=" & i.FileID
                    box.Text = String.Format("{0}", getFileName(i.FileID))
                    div1.Controls.Add(box)
                    div.Controls.Add(div1)

                    DocumentsPlaceHolder.Controls.Add(div1)
                Next
            End If



        Next

    End Sub

    Public Sub BindCourses()

        'delete all eventCourse records
        db.deleteEventCourse(Convert.ToInt32(Request.QueryString("ID")))

        'get brands
        Dim r = From p In db.getCourseForEvents Where p.eventID = Request.QueryString("ID") Select p

        For Each p In r

            Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Order By l.SortOrder Select l

            If course.Count = 0 Then

            Else
                For Each l In course

                    Dim newCourse As New tblEventCourse
                    newCourse.eventID = Request.QueryString("ID")
                    newCourse.CourseTitle = getBrandCourseGroupName(p.CourseTitle)

                    Dim _CurriculumLists = (From u In lmsdb.CurriculumLists Where u.CurriculumID = l.CurriculumID Select u).FirstOrDefault

                    Dim type = _CurriculumLists.ContentType
                    Dim _testID = _CurriculumLists.TestID

                    newCourse.contentID = _CurriculumLists.ContentType
                    newCourse.testID = _CurriculumLists.TestID

                    Dim icon As String = ""

                    Select Case type
                        Case "1"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='True'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "2"
                            icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "3"
                            icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "4"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "5"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "6"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                        Case "7"
                            icon = "<i class='fa fa-check-square-o' aria-hidden='true'></i>"

                            newCourse.icon = icon
                            newCourse.curriculumTitle = l.CurriculumTitle
                            newCourse.curriculumID = l.CurriculumID

                    End Select

                    db.tblEventCourses.InsertOnSubmit(newCourse)
                    db.SubmitChanges()

                Next

            End If


        Next




    End Sub

#End Region

#Region "Make Thumbnail"
    Const sizeThumb As Integer = 100

    Public Shared Function MakeThumb(ByVal fullsize As Byte()) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim targetH, targetW As Integer

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New System.IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image
        If (iOriginal.Height > iOriginal.Width) Then
            targetH = sizeThumb
            targetW = CInt(iOriginal.Width * (sizeThumb / iOriginal.Height))
        Else
            targetW = sizeThumb
            targetH = CInt(iOriginal.Height * (sizeThumb / iOriginal.Width))
        End If
        iThumb = iOriginal.GetThumbnailImage(targetW, targetH, Nothing, System.IntPtr.Zero)
        Dim m As New System.IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function


    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal newwidth As Integer, ByVal newheight As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scaleH, scaleW As Double
        Dim srcRect As Drawing.Rectangle


        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New System.IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image

        scaleH = iOriginal.Height / newheight
        scaleW = iOriginal.Width / newwidth
        If scaleH = scaleW Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = iOriginal.Height
            srcRect.X = 0
            srcRect.Y = 0
        ElseIf (scaleH) > (scaleW) Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = CInt(newheight * scaleW)
            srcRect.X = 0
            srcRect.Y = CInt((iOriginal.Height - srcRect.Height) / 2)
        Else
            srcRect.Width = CInt(newwidth * scaleH)
            srcRect.Height = iOriginal.Height
            srcRect.X = CInt((iOriginal.Width - srcRect.Width) / 2)
            srcRect.Y = 0
        End If

        iThumb = New System.Drawing.Bitmap(newwidth, newheight)
        Dim g As Drawing.Graphics = Drawing.Graphics.FromImage(iThumb)
        g.DrawImage(iOriginal, New Drawing.Rectangle(0, 0, newwidth, newheight), srcRect, Drawing.GraphicsUnit.Pixel)

        Dim m As New System.IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function

    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal maxwidth As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scale As Double

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New System.IO.MemoryStream(fullsize))

        If iOriginal.Width > maxwidth Then

            scale = iOriginal.Width / maxwidth
            Dim newheight As Integer = CInt(iOriginal.Height / scale)

            iThumb = New System.Drawing.Bitmap(iOriginal, maxwidth, newheight)
            Dim m As New System.IO.MemoryStream()
            iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
            Return m.GetBuffer()
        Else
            Return fullsize
        End If

    End Function

    Sub BindShipping()
        Try
            Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault
            Dim thisPOSKit = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

            Dim eventType_ID = thisEvent.eventTypeID

            ShippingEventTypeName.Text = String.Format("{0} Kit:", (From p In db.tblEventTypes Where p.eventTypeID = eventType_ID Select p.eventTypeName).FirstOrDefault)

            Dim posstatus = thisPOSKit.status

            Select Case posstatus
                Case ""
                    ShippingStatusLabel.ForeColor = Drawing.Color.Red
                    ShippingStatusLabel.Text = "<span class='label label-warning'>A POS Kit has not been requested.</span>"

                    ShippingPanel.Visible = False

                Case "Pending"
                    ShippingStatusLabel.ForeColor = Drawing.Color.Red
                    ShippingStatusLabel.Text = "<span class='label label-danger'>A POS Kit has not been shipped!</span>"

                    ShippingPanel.Visible = True
                Case "Shipped"
                    Dim shipped = thisPOSKit.shippedDate


                    ShippingStatusLabel.ForeColor = Drawing.Color.Green
                    ShippingStatusLabel.Text = String.Format("The following items were shipped on {0:d}", shipped)

                    ShippingPanel.Visible = True

                    ' The following items were shipped on
                    Dim address = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.shippingAddress).FirstOrDefault
                    Dim city = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.shippingCity).FirstOrDefault
                    Dim state = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.shippingState).FirstOrDefault
                    Dim zip = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.shippingZip).FirstOrDefault

                    ShippingAddressLabel.Text = String.Format("{0}<br>{1}, {2}  {3}", address, city, state, zip)


                    AttLabel.Text = String.Format("Att: {0}", (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.shippingAttName).FirstOrDefault)

                    ShippedViaLabel.Text = String.Format("Via: {0}", Common.getShippingVendorName(thisPOSKit.shippingVendorID))
                    ShippedTypeLabel.Text = String.Format("Type: {0}", Common.getShippingMethodTitle(thisPOSKit.shippingMethodID))

                    TrackingLabel.Text = String.Format("Tracking: <a href='{0}' target='_blank'>{0}</a>", thisPOSKit.trackingNumber)


            End Select

            'we need to have a hidden field for the latitude and longitude of the shipping location
            Hidden_POSLatitude.Value = thisEvent.posShippingLatitude
            HIdden_POSLongtitude.Value = thisEvent.posShippingLongtitude


            '' The following items were shipped on
            'Dim address = thisEvent.posShippingAddress1
            'Dim city = thisEvent.posShippingCity
            'Dim state = thisEvent.posShippingState
            'Dim zip = thisEvent.posShippingZip

            ''  ShippingAddressLabel.Text = String.Format("{0}<br>{1}, {2}  {3}", address, city, state, zip)

            'ShippingAddressLabel.Text = "Hello"

            'AttLabel.Text = String.Format("Att: {0}", (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.shippingAttName).FirstOrDefault)

            'ShippedViaLabel.Text = String.Format("Via: {0}", thisPOSKit.shippedBy)
            'ShippedTypeLabel.Text = String.Format("Type: {0}", thisPOSKit.shippedType)
            'TrackingLabel.Text = String.Format("Tracking: <a href='{0}' target='_blank'>{0}</a>", thisPOSKit.trackingNumber)
        Catch ex As Exception

        End Try
    End Sub

    Sub BindCost()
        Dim posstatus = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.status).FirstOrDefault

        Select Case posstatus
            Case ""
                CostShippingStatusLabel.ForeColor = Drawing.Color.Red
                CostShippingStatusLabel.Text = "<span class='label label-warning'>A POS Kit has not been requested.</span>"

                CostPanel.Visible = False

            Case "Pending"
                CostShippingStatusLabel.ForeColor = Drawing.Color.Red
                CostShippingStatusLabel.Text = "<span class='label label-danger'>A POS Kit has not been shipped!</span>"

                CostPanel.Visible = True



            Case "Shipped"

                CostPanel.Visible = True

                Dim kit = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.kitID).FirstOrDefault
                Dim subtotal = (From p In db.qryGetPosKitItems Where p.kitID = kit Select p.Total).Sum
                Dim shipping = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.shippingCost).FirstOrDefault
                Dim handling = (From p In db.tblPosKits Where p.eventID = Request.QueryString("ID") Select p.handlingFee).FirstOrDefault

                TotalCostLabel.Text = subtotal + shipping + handling

        End Select
    End Sub


    Private Sub EventCourseListView_ItemCreated(sender As Object, e As RadListViewItemEventArgs) Handles EventCourseListView.ItemCreated
        If TypeOf e.Item Is RadListViewDataItem Then
            Dim CurriculumLink As HyperLink = TryCast(e.Item.FindControl("CurriculumLink"), HyperLink)

            CurriculumLink.Font.Bold = True
        End If

    End Sub

    Private Sub EventCourseListView_ItemDataBound(sender As Object, e As RadListViewItemEventArgs) Handles EventCourseListView.ItemDataBound

        If TypeOf e.Item Is RadListViewDataItem Then
            Dim CurriculumLink As HyperLink = TryCast(e.Item.FindControl("CurriculumLink"), HyperLink)
            Dim testID As Label = TryCast(e.Item.FindControl("testID"), Label)
            Dim TypeLabel As Label = TryCast(e.Item.FindControl("TypeLabel"), Label)

            ' if student then
            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            Dim CurriculumID As Label = TryCast(e.Item.FindControl("CurriculumID"), Label)

            Select Case TypeLabel.Text
                Case "1"
                    If manager.IsInRole(currentUser.Id, "Student") Then
                        CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                    Else
                        CurriculumLink.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", CurriculumID.Text)
                    End If

                Case "2"
                    If manager.IsInRole(currentUser.Id, "Student") Then
                        CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                    Else
                        CurriculumLink.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", CurriculumID.Text)
                    End If

                Case "3"
                    If manager.IsInRole(currentUser.Id, "Student") Then
                        CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                    Else
                        CurriculumLink.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", CurriculumID.Text)
                    End If

                Case "4"
                    If manager.IsInRole(currentUser.Id, "Student") Then
                        CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                    Else
                        CurriculumLink.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", CurriculumID.Text)
                    End If

                Case "5"
                    If manager.IsInRole(currentUser.Id, "Student") Then
                        CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                    Else
                        CurriculumLink.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", CurriculumID.Text)
                    End If

                Case "6"
                    If manager.IsInRole(currentUser.Id, "Student") Then
                        CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                    Else
                        CurriculumLink.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", CurriculumID.Text)
                    End If

                Case "7"
                    If manager.IsInRole(currentUser.Id, "Student") Then
                        CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                    Else
                        CurriculumLink.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewTestQuestions.aspx?TestID={0}', 'null');win.center();win.setSize(700, 700);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", testID.Text)
                    End If
            End Select





        End If

    End Sub


    Private Sub WeatherListRepeater_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles WeatherListRepeater.ItemDataBound
        If WeatherListRepeater.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If
    End Sub

    Shared Function ShowAlertNoClose(ByVal type As String, ByVal msg As String) As String
        Return String.Format("<div class='alert alert-{0}'>{1}</div>", type, msg)
    End Function

    Private Sub TrainingRadTabStrip_TabClick(sender As Object, e As RadTabStripEventArgs) Handles TrainingRadTabStrip.TabClick
        Select Case e.Tab.Value
            Case "courses"
            Case "scores"
                BindTestsScores()
            Case "documents"
                BindDocuments()
                Exit Select
        End Select
    End Sub

    Private Sub POSRadTabStrip_TabClick(sender As Object, e As RadTabStripEventArgs) Handles POSRadTabStrip.TabClick
        Select Case e.Tab.Value
            Case "kits"
                BindTestsScores()
                BindDocuments()

            Case "shippinglocation"
                BindShipping()

                BindTestsScores()
                BindDocuments()

            Case "cost"
                BindCost()

                BindTestsScores()
                BindDocuments()
                Exit Select
        End Select
    End Sub


#End Region


#Region "Photo"
    Public Class Photo
        Private Shared ReadOnly _key As New Object()
        <ThreadStatic()> Private Shared _counter As Integer

        Public Sub New()
            Id = GetId()
        End Sub

        Public Property Name() As String
            Get
                Return m_Name
            End Get
            Set(ByVal value As String)
                m_Name = value
            End Set
        End Property

        Private m_Name As String
        Public Property Data() As Byte()
            Get
                Return m_Data
            End Get
            Set(ByVal value As Byte())
                m_Data = value
            End Set
        End Property

        Private m_Data As Byte()
        Public Property Id() As Integer

            Get
                Return m_Id
            End Get
            Private Set(ByVal value As Integer)
                m_Id = value
            End Set

        End Property

        Private m_Id As Integer
        Protected Shared Function GetId() As Integer
            SyncLock _key
                _counter += 1
            End SyncLock
            Return _counter

        End Function

    End Class
    'End Photo Galery Code

#End Region
End Class

