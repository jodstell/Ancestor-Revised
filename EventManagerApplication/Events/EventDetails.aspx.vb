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
Imports System.Drawing.Imaging

Public Class EventDetails_V3
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim eventID = Request.QueryString("ID")

        Try
            Dim IsDeleted = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.statusID).FirstOrDefault
            If IsDeleted = 8 Then
                Response.Redirect("/Events/ViewEvents?action=3")
            End If
        Catch ex As Exception

        End Try


        Dim IsValid = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).Count
        If IsValid = 0 Then
            'the event does not exist
            Response.Redirect("/Events/ViewEvents?action=3")
        End If

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


        Dim disableIP = Request.ServerVariables("REMOTE_ADDR")
        If disableIP = "78.130.243.230" Then
            LoadMapPanel.Visible = False
        End If


        'bind all the data
        If Not Page.IsPostBack Then

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            If manager.IsInRole(currentUser.Id, "Student") Then
                Response.Redirect("/events/event_details?ID=" & eventID)
            End If

            'show/hide admin panels
            If manager.IsInRole(currentUser.Id, "Client") Then
                logTab.Visible = False
                EditButtonPanel1.Visible = False
                EditRecapLink.Visible = False
                PrintPDFLink.Visible = False
                CreateRecapLink.Visible = False
                InvitationButton.Visible = False
                btnApproveRecap.Visible = False
                btnUnapprove.Visible = False
                budgetTab.Visible = False
                notesTab.Visible = False
                costTab.Visible = False
                btnSavePosKitRequest.Visible = False
                btnAddPhotos.Visible = False
                btnCreateRecap.Visible = False
            End If

            If manager.IsInRole(currentUser.Id, "BrandMarketer") Then
                logTab.Visible = False
                EditButtonPanel1.Visible = False
                EditRecapLink.Visible = True
                PrintPDFLink.Visible = False
                'CreateRecapLink.Visible = True
                InvitationButton.Visible = False
                btnApproveRecap.Visible = False
                btnUnapprove.Visible = False
                budgetTab.Visible = False
                notesTab.Visible = False
                costTab.Visible = False
                btnSavePosKitRequest.Visible = False
                btnAddPhotos.Visible = True
                'btnCreateRecap.Visible = True
            End If

            If manager.IsInRole(currentUser.Id, "Agency") Then
                budgetTab.Visible = False
                notesTab.Visible = False
                costTab.Visible = False
                EditRecapLink.Visible = False
                btnApproveRecap.Visible = False
                btnUnapprove.Visible = False
                btnSavePosKitRequest.Visible = False
            End If

            If manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
                EditRecapLink.Visible = False
                btnApproveRecap.Visible = False
                btnUnapprove.Visible = False
                btnSavePosKitRequest.Visible = False
            End If



            'these sections do not need to reload on postback
            BindPOSKit()
            'CheckStatus()
            bindEvent()

        End If


    End Sub

    Function showHide()

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Client") Then

            Return False

        End If

        Return True
    End Function

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


        Dim r = (From t In lmsdb.baretc_TestResults Where t.UserName = assignedUserName And t.ID = testID Order By t.DateTimeCompleted Descending Select t).Count

        If r = 0 Then

            Return String.Format("<span class='label label-{0}'>{1} {2}</span>", "warning", "No Test Completed", "")

        Else

            Dim _result = (From t In lmsdb.baretc_TestResults Where t.UserName = assignedUserName And t.ID = testID Order By t.DateTimeCompleted Descending Select t.Result).FirstOrDefault

            Dim _score = (From t In lmsdb.baretc_TestResults Where t.UserName = assignedUserName And t.ID = testID Order By t.DateTimeCompleted Descending Select t.Score).FirstOrDefault


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
                    resultlabel = "No Test Completed" & testID
                    scoreLabel = ""
            End Select

            Return String.Format("<span class='label label-{0}'>{1} {2}</span>", testresult, resultlabel, scoreLabel)

        End If

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
        ' Return String.Format("var win = window.radopen('ReceiptHandler?eventExpenseID={0}','Details');win.center();", eventExpenseID)
    End Function

    Protected Function CreateWindowScript2(ByVal userID As String) As String

        Return String.Format("var win = window.radopen('/Events/BrandAmbassadorsDetails.aspx?userID={0}', 'null');win.center();win.setSize(1050, 500);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", userID)

    End Function

    Sub bindEvent()
        ' Try
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


        Dim q = (From p In db.getEventDetails Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        If q.Modified = True Then
            BindCourses()
        End If

        'get the status of the recap
        Dim hasRecap = q.recapStatus
        Dim status = q.statusID

        If status = 1 And (manager.IsInRole(currentUser.Id, "Administrator") Or manager.IsInRole(currentUser.Id, "EventManager") Or manager.IsInRole(currentUser.Id, "GlobalAdmin")) Then
            btnUnapprove.Visible = True
        End If

        If hasRecap <> 0 Then
            EditRecapLink.Visible = True
            PrintPDFLink.Visible = True
            btnApproveRecap.Visible = True
        End If

        If status = 1 Or manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Or manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
            btnApproveRecap.Visible = False
        End If

        If hasRecap = 0 Then
            CreateRecapLink.Visible = True
            EditRecapLink.Visible = False
            PrintPDFLink.Visible = False
        End If


        ' get the logged ambassador

        If manager.IsInRole(currentUser.Id, "Student") Then

            SelectedAmbassadorPanel.Visible = False
            EnterAddressPanel.Visible = True

            Dim a = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p).FirstOrDefault
            txtFromAddress.Text = String.Format("{0}, {1}, {2} {3}", a.Address1, a.City, a.State, a.Zip)
        Else
            SelectedAmbassadorPanel.Visible = True
            EnterAddressPanel.Visible = False

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


        '  HF_Latitude.Value = q.latitude ' (From p In db.tblAccounts Where p.Vpid = account Select p.latitude).FirstOrDefault
        ' HF_Longtitude.Value = q.longitude ' (From p In db.tblAccounts Where p.Vpid = account Select p.longitude).FirstOrDefault

        StartTimeLabel.Text = String.Format("{0:t}", q.startTime)
        EndTimeLabel.Text = String.Format("{0:t}", q.endTime)
        EventDateLabel.Text = String.Format("{0:D}", q.eventDate)


        'labels for the pdf recap for location
        lblStreetAddress.Text = q.streetAddress1
        lblCityAddress.Text = q.city & ", " & q.state & " " & q.zipCode

        If q.billableEvent = True Then
            BillableCheckBoxLabel.Text = "Yes"
        Else
            BillableCheckBoxLabel.Text = "No"
        End If
        ' BillableCheckBox.Checked = q.billableEvent


        Try
            Dim poID = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.purchaseOrderNumber).FirstOrDefault
            PONumberTextBox.Text = getRealPONumber(poID)
        Catch ex As Exception
            PONumberTextBox.Text = ""
        End Try


        DistributorTextBox.Text = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.distributer).FirstOrDefault
        RequestedTextBox.Text = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.requestedBy).FirstOrDefault

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
        NoteCountLabel.Text = (From p In db.tblEventNotes Where p.eventID = q.eventID Select p).Count

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


        'Team Name
        Dim team = (From p In db.tblTeams Where p.teamID = q.teamID Select p).FirstOrDefault()
        Try
            TeamLabel.Text = team.teamName
        Catch ex As Exception

        End Try




        'staffing 

        'show/hide admin panels
        If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Or manager.IsInRole(currentUser.Id, "BrandMarketer") Then
            assignTab.Visible = False
            requirementsTab.Visible = False
            payrollTab.Visible = False
        End If

        'show expenses tab only for the clients
        If manager.IsInRole(currentUser.Id, "Client") Then
            expensesClientTab.Visible = True
        End If


        'bind positions available
        If Not Page.IsPostBack Then
            BindPositionCount()
        End If

        Dim account = q.locationID

        HF_MarketID.Value = q.marketID

        Try

            HF_ClientID.Value = "18"

            TotalSpendLabel.Text = String.Format("${0}", (From p In db.qryEventStaffingRequirementLists Where p.eventID = q.eventID Select p.Total).Sum)

        Catch ex As Exception
            ' Label1.Text = ex.Message
        End Try

        ' SelectedDirectionsName

        Dim hasAmbassadorAssigned As Integer = db.ViewPayrollSummaryByEvent(q.eventID).Count

        If hasAmbassadorAssigned = 0 Then
            ExpensePanel.Visible = False
        End If

        ' Catch ex As Exception

        '  End Try



    End Sub

    Function getRealPONumber(id As String) As String
        Return (From p In db.tblPurchaseOrders Where p.purchaseOrderID = id Select p.purchaseOrderNumber).FirstOrDefault
    End Function
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

    Function getBrandCourseID(groupID As String) As String
        Return (From p In lmsdb.CurriculumGroups Where p.CurriculumGroupID = groupID Select p.CourseID).FirstOrDefault

    End Function

    Function getFileName(fileID As String) As String
        Return (From p In lmsdb.Files Where p.ID = fileID Select p.FileName).FirstOrDefault
    End Function

    Function getFileType(fileID As String) As String
        Return (From p In lmsdb.Files Where p.ID = fileID Select p.ContentType).FirstOrDefault
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

    Private Sub btnCreatePDF_Click(sender As Object, e As EventArgs) Handles btnCreatePDF.Click

        Try

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "PDF File", "The pdf file was opened.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)


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


                'If supplierID.supplierID = 214  Or supplierID.supplierID = 103
                Dim supplierID = (From p In db.tblEvents Where p.eventID = eventID Select p).FirstOrDefault()


                If supplierID.supplierID = 214 Then

                    Dim header123 As New Paragraph()
                    header123.Alignment = Element.ALIGN_LEFT
                    header123.SpacingBefore = 12.0F
                    header123.Add(New Chunk(SupplierLabel.Text, New iTextSharp.text.Font(bfTimes, 16.5, iTextSharp.text.Font.BOLD)))

                    Dim header1232 As New Paragraph()
                    header1232.Alignment = Element.ALIGN_LEFT
                    header1232.SpacingBefore = 12.0F
                    header1232.Add(New Chunk("Event Recap", New iTextSharp.text.Font(bfTimes, 16.5, iTextSharp.text.Font.BOLD)))

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, header123, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 17), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, header1232, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 34), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLoc, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 50), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLocAddress, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 64), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLocCity, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 77), 0)


                Else
                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, header, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 25), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLoc, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 42), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLocAddress, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 57), 0)

                    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLocCity, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 70), 0)

                End If


                'ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, header, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 25), 0)

                'ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLoc, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 42), 0)

                'ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLocAddress, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 57), 0)

                'ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, headerLocCity, (((document.Right - document.Left) / 3) + (document.LeftMargin - 185)), (document.Top - 70), 0)



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


    Private Sub btnCreateRecap_Click(sender As Object, e As EventArgs) Handles btnCreateRecap.Click

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Dim order As Integer = 0
        Dim eventID = Request.QueryString("ID")

        'first delete any recap questions that might exist
        db.DeleteAllEventRecapQuestions(eventID)

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Create Recap", "Create Recap button was clicked.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        ' this might need to be changed!




        'create the recap questions

        ' 1. get the selected brands
        Dim brandlist = From y In db.tblBrandInEvents Where y.eventID = eventID Select y
        For Each y In brandlist

            order = 0

            ' get the default recap questions for each brand
            Dim a = From p In db.tblDefaultRecapQuestions Select p Order By p.QuestionID
            For Each p In a

                Dim recap0 As New tblEventRecapQuestion
                recap0.eventID = eventID
                recap0.brandID = y.brandID
                Dim q1 As String = Replace(p.Question, "[BrandName]", getBrandName(y.brandID))
                recap0.question = Replace(q1, "[PPS]", getPPS(y.brandID))
                recap0.questionType = p.QuestionType
                recap0.recapID = 0
                recap0.recapQuestionID = p.QuestionID
                recap0.sortorder = order + 1
                recap0.createdBy = currentUser.Id
                recap0.createdDate = Date.Now()
                recap0.description = "" ' there is not a description column
                recap0.required = False
                recap0.digit = 0
                recap0.numberDecimalPlace = 0
                recap0.showPercentage = False
                recap0.dateDefaultValue = "None"
                recap0.displayOption = ""
                recap0.lines = 1
                recap0.yes_noDefaultValue = "No"
                recap0.dateFormat = ""
                recap0.dateDisplay = ""

                If p.QuestionType = "currency" Then
                    recap0.answer = 0
                End If

                db.tblEventRecapQuestions.InsertOnSubmit(recap0)
                db.SubmitChanges()

            Next

            ' 2.  get the custom brand questions for each brand
            Dim r = From p In db.tblBrandRecapQuestions Where p.brandID = y.brandID
            For Each p In r

                Dim recap1 As New tblEventRecapQuestion
                recap1.eventID = eventID
                recap1.brandID = y.brandID
                recap1.question = p.question
                recap1.questionType = p.questionType
                recap1.recapID = 1
                recap1.recapQuestionID = p.brandRecapQuestionID
                recap1.sortorder = order + 1
                recap1.description = p.description
                recap1.displayOption = p.displayOption
                recap1.lines = p.lines
                recap1.yes_noDefaultValue = p.yes_noDefaultValue
                recap1.numberDecimalPlace = p.numberDecimalPlace
                recap1.numberDefaultValue = p.numberDefaultValue
                recap1.showPercentage = p.showPercentage
                recap1.dateFormat = p.dateFormat
                recap1.dateDefaultValue = p.dateDefaultValue
                recap1.timeFormat = p.timeFormat
                recap1.dateDisplay = p.dateDisplay
                recap1.required = p.required
                recap1.digit = p.numberDecimalPlace
                recap1.createdBy = currentUser.Id
                recap1.createdDate = Date.Now()

                If p.questionType = "choice" Then
                    recap1.displayOption = p.displayOption
                    If p.displayOption = "check" Then
                        recap1.answer = ""
                    End If

                Else
                    recap1.displayOption = ""
                End If

                If p.questionType = "currency" Then
                    recap1.answer = 0
                End If

                If p.questionType = "number" Then
                    recap1.answer = p.numberDefaultValue
                End If

                db.tblEventRecapQuestions.InsertOnSubmit(recap1)
                db.SubmitChanges()
            Next

        Next

        Dim CurrentClientID = (From p In db.tblEvents Where p.eventID = eventID Select p.clientID).FirstOrDefault
        'end the loop through the brands

        'get the eventtype
        Dim typeid = (From p In db.tblEvents Where p.eventID = eventID And p.clientID = CurrentClientID Select p.eventTypeID).FirstOrDefault

        ' 3. add eventtype recap questions
        Dim i = From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = typeid And p.clientID = CurrentClientID Order By p.sortorder Select p
        For Each p In i
            Dim recap3 As New tblEventRecapQuestion
            recap3.eventID = eventID
            recap3.question = p.question
            recap3.questionType = p.questionType
            recap3.recapID = 2
            recap3.recapQuestionID = p.eventTypeRecapQuestionID
            recap3.sortorder = p.sortorder
            recap3.description = p.description
            recap3.displayOption = p.displayOption
            recap3.lines = p.lines
            recap3.yes_noDefaultValue = p.yes_noDefaultValue
            recap3.numberDecimalPlace = p.numberDecimalPlace
            recap3.numberDefaultValue = p.numberDefaultValue
            recap3.showPercentage = p.showPercentage
            recap3.dateFormat = p.dateFormat
            recap3.dateDefaultValue = p.dateDefaultValue
            recap3.timeFormat = p.timeFormat
            recap3.dateDisplay = p.dateDisplay
            recap3.required = p.required
            recap3.digit = p.numberDecimalPlace
            recap3.createdBy = currentUser.Id
            recap3.createdDate = Date.Now()


            If p.questionType = "choice" Then
                recap3.displayOption = p.displayOption
                If p.displayOption = "check" Then
                    recap3.answer = ""
                End If

            Else
                recap3.displayOption = ""
            End If

            If p.questionType = "currency" Then
                recap3.answer = 0
            End If

            If p.questionType = "number" Then
                recap3.answer = p.numberDefaultValue
            End If


            db.tblEventRecapQuestions.InsertOnSubmit(recap3)
            db.SubmitChanges()
        Next

        Response.Redirect("/Events/EditRecap?action=new&EventID=" & eventID)


    End Sub

    'position functions
    Sub BindPositionCount()
        Dim eventID = Request.QueryString("ID")

        positionsStaffedCountLabel.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = True Select p).Count
        positionsAvailableCountLabel.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = False Select p).Count

        positionsStaffedCountLabel2.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = True Select p).Count
        positionsAvailableCountLabel2.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = False Select p).Count

        positionsStaffedCountLabel3.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = True Select p).Count
        positionsAvailableCountLabel3.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = False Select p).Count

        HF_PositionID.Value = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID Select p.positionID).FirstOrDefault


    End Sub

    Protected Sub AvailableAmbassadorList_ItemDrop(ByVal sender As Object, ByVal e As RadListViewItemDragDropEventArgs) Handles AvailableAmbassadorList.ItemDrop

        Try
            For Each item As RepeaterItem In PositionList.Items

                Dim genreLink As LinkButton = TryCast(item.FindControl("GenreLink"), LinkButton)
                If genreLink IsNot Nothing AndAlso genreLink.ClientID = e.DestinationHtmlElement Then

                    Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

                    Dim userName As String = DirectCast(e.DraggedItem.GetDataKeyValue("userName"), String)
                    Dim title As String = e.DraggedItem.GetDataKeyValue("FirstName").ToString()
                    Dim requirementID As String = genreLink.CommandArgument

                    ResultsPanel.Controls.Add(New LiteralControl([String].Format("<div class='msg'><b>{0}</b> was assigned to the event.</div>", getFullName(userName))))

                    Dim paymentdate As DateTime = (From p In db.qryEventStaffingRequirements Where p.RequirementID = requirementID Select p.startTime).FirstOrDefault

                    Dim a = db.AssignStafftoEvent(requirementID, userName, paymentdate)

                    ' add to the log file
                    Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Ambassador Assigned", getFullName(userName) & " was assigned to the event.", Context.User.Identity.GetUserId(), Date.Now())

                    'add to history log
                    lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Ambassador Assigned", getFullName(userName) & " was assigned to the event.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)


                    'update the event
                    thisEvent.ModifiedDate = Date.Now()
                    db.SubmitChanges()


                    'assign to course
                    Try
                        Dim db1 As New LMSDataClassesDataContext
                        Dim r = From p In db.getCourseForEvents Where p.eventID = Request.QueryString("ID") Select p
                        For Each p In r
                            db1.AddStudentToCourse(userName, p.courseID)
                        Next
                    Catch ex As Exception

                    End Try



                    'send email if is not global admin role
                    Dim manager = New UserManager()
                    Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

                    'show/hide admin panels
                    If manager.IsInRole(currentUser.Id, "GlobalAdmin") Then


                    Else

                        ''send email notification to the BA
                        'Dim eventDetails = (From p In db.getEventDetails Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault
                        'Dim ba = (From b In db.tblAmbassadors Where b.userName = userName Select b).FirstOrDefault

                        'Dim m = (From p In db.tblMessages Where p.messageID = 3 Select p).FirstOrDefault

                        'Dim myString As String = ""
                        'myString = m.messageText
                        'myString = myString.Replace("[FirstName]", ba.FirstName)
                        'myString = myString.Replace("[LastName]", ba.LastName)
                        'myString = myString.Replace("[EventCity]", eventDetails.city)
                        'myString = myString.Replace("[EventState]", eventDetails.state)
                        'myString = myString.Replace("[EventDate]", eventDetails.eventDate)
                        'myString = myString.Replace("[EventStartTime]", String.Format("{0:t}", eventDetails.startTime))
                        'myString = myString.Replace("[EventBrands]", (From i In db.qryGetBrandsInEvents Where i.eventID = Request.QueryString("ID") Select i.brands).FirstOrDefault)
                        'myString = myString.Replace("[EventSupplier]", getSupplierName(eventDetails.supplierID))
                        'myString = myString.Replace("[AssignedPosition]", getPositionName((From i In db.tblEventStaffingRequirements Where i.RequirementID = genreLink.CommandArgument Select i.positionID).FirstOrDefault))
                        'myString = myString.Replace("[CheckInTime]", String.Format("{0:t}", (From i In db.tblEventStaffingRequirements Where i.RequirementID = genreLink.CommandArgument Select i.startTime).FirstOrDefault))
                        'myString = myString.Replace("[LocationName]", eventDetails.AccountName)
                        'myString = myString.Replace("[EventLinkURL]", "http://events.gigengyn.com/Events/EventDetails?ID=" & eventDetails.eventID)

                        'Dim recipient = ba.EmailAddress

                        ''send email
                        'MailHelper.SendEmailMessage(3, recipient, m.fromAddress, m.fromName, m.subject, myString.ToString())

                    End If

                    Exit For
                End If

            Next


            'check if all positions are booked

            Dim thisEvent1 = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

            'get assignment count
            Dim positioncount = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Where p.assigned = True Select p).Count
            Dim assignedcount = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Select p).Count

            Dim status = thisEvent1.statusID
            If status = 2 Then
                'do nothing
                Exit Sub
            End If

            If status = 1 And positioncount > 0 Then
                If positioncount = assignedcount Then
                    'do nothing
                End If
            End If

            If status = 4 And positioncount > 0 Then
                If positioncount = assignedcount Then
                    'update status to booked

                    Try
                        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

                        thisEvent.statusID = 2
                        thisEvent.ModifiedDate = Date.Now()
                        db.SubmitChanges()

                        Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "A brand ambassador was added. The event status was updated to Booked.", Context.User.Identity.GetUserId(), Date.Now())

                        'add to history log
                        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Event Status Updated", "A brand ambassador was added. The event status was updated to Booked.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                        RadNotification1.Text = "The event status was updated to Booked."
                        RadNotification1.Show()
                        StatusLabel.Text = "Booked"

                    Catch ex As Exception

                    End Try

                End If
            End If

            If status = 2 And positioncount <> 0 Then
                If positioncount <> assignedcount Then
                    'update status to booked

                    Try
                        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

                        thisEvent.statusID = 4
                        thisEvent.ModifiedDate = Date.Now()
                        db.SubmitChanges()

                        Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "The event status was updated to Scheduled.", Context.User.Identity.GetUserId(), Date.Now())

                        'add to history log
                        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Event Status Updated", "The event status was updated to Scheduled.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                        RadNotification1.Text = "The event status was updated to Scheduled."
                        RadNotification1.Show()
                        StatusLabel.Text = "Scheduled"

                    Catch ex As Exception

                    End Try

                End If
            End If

            If status = 7 And positioncount > 0 Then
                If positioncount = assignedcount Then
                    'update status to booked

                    Try
                        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

                        thisEvent.statusID = 2
                        thisEvent.ModifiedDate = Date.Now()
                        db.SubmitChanges()

                        Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "A brand ambassador was added. The event status was updated to Booked.", Context.User.Identity.GetUserId(), Date.Now())

                        'add to history log
                        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Event Status Updated", "A brand ambassador was added. The event status was updated to Booked.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)


                    Catch ex As Exception

                    End Try
                End If
            End If



            'rebind data
            'CheckStatus()
            ' rebindData()


            '  StaffingList.DataBind()
            BindPositionCount()
            '  AvailableAmbassadorList.DataBind()
            PositionList.DataBind()
            ' BrandPositionList.DataBind()

            '  bindEvent()

        Catch ex As Exception
            trackErrorLabel.Text = ex.Message
        End Try

    End Sub

    Sub rebindData()

        StaffingList.DataBind()
        BindPositionCount()
        AvailableAmbassadorList.DataBind()
        PositionList.DataBind()
        BrandPositionList.DataBind()

        bindEvent()

    End Sub

    Private Sub LookupAmbassadorText_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles LookupAmbassadorText.SelectedIndexChanged
        AvailableAmbassadorList.CurrentPageIndex = 0
        AvailableAmbassadorList.FilterExpressions.Clear()
        AvailableAmbassadorList.FilterExpressions.BuildExpression().Contains("userName", LookupAmbassadorText.SelectedValue).Build()
        AvailableAmbassadorList.Rebind()


        ' AvailableAmbassadorList.DataSource = "getAvailableAmbassadorListByUserName"

        '  AvailableAmbassadorList.DataSource = GetDataTable()
        ' AvailableAmbassadorList.DataBind()


    End Sub

    'Private Sub AvailableAmbassadorList_NeedDataSource(sender As Object, e As RadListViewNeedDataSourceEventArgs) Handles AvailableAmbassadorList.NeedDataSource
    '    AvailableAmbassadorList.DataSource = GetAvailableAmbassadorTable()
    'End Sub

    Public Function GetAvailableAmbassadorTableByUserName() As DataTable
        ' Dim query As String = "SELECT eventID, supplierName, eventDate, marketName, eventTypeName, statusName FROM qryViewEvents"

        Dim query As String = "getAvailableAmbassadorByUserID"

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()
        adapter.SelectCommand = New SqlCommand(query, conn)

        adapter.SelectCommand.CommandType = CommandType.StoredProcedure

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@lat", SqlDbType.NVarChar))
        adapter.SelectCommand.Parameters("@lat").Value = LatitudeTextBox.Value

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@long", SqlDbType.NVarChar))
        adapter.SelectCommand.Parameters("@long").Value = LongtitudeTextBox.Value

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@marketID", SqlDbType.Int))
        adapter.SelectCommand.Parameters("@marketID").Value = HF_MarketID.Value

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@positionID", SqlDbType.Int))
        adapter.SelectCommand.Parameters("@positionID").Value = HF_PositionID.Value

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@eventID", SqlDbType.Int))
        adapter.SelectCommand.Parameters("@eventID").Value = Request.QueryString("ID")

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@UserName", SqlDbType.NVarChar))
        adapter.SelectCommand.Parameters("@UserName").Value = LookupAmbassadorText.SelectedValue


        Dim myDataTable As New DataTable()

        conn.Open()
        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function

    Public Function GetAvailableAmbassadorTable() As DataTable
        ' Dim query As String = "SELECT eventID, supplierName, eventDate, marketName, eventTypeName, statusName FROM qryViewEvents"

        Dim query As String = "getAvailableAmbassador"

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()
        adapter.SelectCommand = New SqlCommand(query, conn)

        adapter.SelectCommand.CommandType = CommandType.StoredProcedure

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@lat", SqlDbType.NVarChar))
        adapter.SelectCommand.Parameters("@lat").Value = LatitudeTextBox.Value

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@long", SqlDbType.NVarChar))
        adapter.SelectCommand.Parameters("@long").Value = LongtitudeTextBox.Value

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@marketID", SqlDbType.Int))
        adapter.SelectCommand.Parameters("@marketID").Value = HF_MarketID.Value

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@positionID", SqlDbType.Int))
        adapter.SelectCommand.Parameters("@positionID").Value = HF_PositionID.Value

        adapter.SelectCommand.Parameters.Add(New SqlParameter("@eventID", SqlDbType.Int))
        adapter.SelectCommand.Parameters("@eventID").Value = Request.QueryString("ID")


        Dim myDataTable As New DataTable()

        conn.Open()
        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function

    Private Sub btnClearFiltersAmbassador_Click(sender As Object, e As EventArgs) Handles btnClearFiltersAmbassador.Click

        AvailableAmbassadorList.CurrentPageIndex = 0
        AvailableAmbassadorList.FilterExpressions.Clear()
        LookupAmbassadorText.SelectedIndex = -1
        AvailableAmbassadorList.Rebind()

        '   AvailableAmbassadorList.DataSource = GetAvailableAmbassadorTable()

        'AvailableAmbassadorList.DataSourceID = "getAvailableAmbassadorList"

        'AvailableAmbassadorList.DataBind()

    End Sub



    Private Sub getEventPositions_Deleted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getEventPositions.Deleted
        Dim oldPosition As tblEventStaffingRequirement
        oldPosition = CType(e.Result, tblEventStaffingRequirement)

        Dim positionName = (From p In db.tblStaffingPositions Where p.staffingPositionID = oldPosition.positionID Select p.positionTitle).FirstOrDefault

        Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Staffing Deleted", positionName & " was deleted from the event staffing requirements.", Context.User.Identity.GetUserId(), Date.Now())

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Staffing Deleted", positionName & " was deleted from the event staffing requirements.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        rebindData()

    End Sub

    Private Sub getEventPositions_Inserted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getEventPositions.Inserted
        Dim newPosition As tblEventStaffingRequirement
        newPosition = CType(e.Result, tblEventStaffingRequirement)

        Dim positionName = (From p In db.tblStaffingPositions Where p.staffingPositionID = newPosition.positionID Select p.positionTitle).FirstOrDefault

        Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Staffing Inserted", positionName & " was added to the event staffing requirements.", Context.User.Identity.GetUserId(), Date.Now())

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Staffing Inserted", positionName & " was added to the event staffing requirements.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        HF_PositionID.Value = newPosition.positionID

        rebindData()

    End Sub

    Private Sub getEventPositions_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getEventPositions.Inserting

        Try
            Dim l As tblEventStaffingRequirement
            l = CType(e.NewObject, tblEventStaffingRequirement)
            l.eventID = Request.QueryString("ID")
            l.assigned = False
            l.rate = (From p In db.tblStaffingPositions Where p.staffingPositionID = l.positionID Select p.payRate).FirstOrDefault
            l.billingRate = (From p In db.tblStaffingPositions Where p.staffingPositionID = l.positionID Select p.billingRate).FirstOrDefault


        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try

    End Sub

    Private Sub btnSaveChanges_Click(sender As Object, e As EventArgs) Handles btnSaveChanges.Click

        msgLabel1.Text = Common.ShowAlert("success", "Change button clicked")

        Try

            Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

            Dim startTime As New RadDateTimePicker()
            Dim endTime As New RadDateTimePicker()
            Dim rate As New RadNumericTextBox()
            Dim HiddenField1 As New HiddenField

            Dim _eventDate As Date = thisEvent.eventDate

            Dim da = String.Format("{0}/{1}/{2} ", _eventDate.Month, _eventDate.Day, _eventDate.Year)

            For Each dataItem As RepeaterItem In PositionList.Items

                startTime = DirectCast(dataItem.FindControl("startTimeRadTimePicker"), RadDateTimePicker)
                endTime = DirectCast(dataItem.FindControl("endTimeRadTimePicker"), RadDateTimePicker)
                rate = DirectCast(dataItem.FindControl("RateTextBox"), RadNumericTextBox)
                HiddenField1 = DirectCast(dataItem.FindControl("HiddenField1"), HiddenField)

                Dim s As Date = endTime.SelectedDate
                Dim s1 As Date = startTime.SelectedDate

                Dim formatedEndDate = String.Format("{0} {1}: {2}", da, s.Hour, s.Minute)
                Dim formateStartDate = String.Format("{0} {1}:{2}", da, s1.Hour, s1.Minute)

                Dim d = db.UpdateEventStaffRequirement(HiddenField1.Value, startTime.SelectedDate, endTime.SelectedDate, rate.Text)
            Next

            msgLabel1.Text = Common.ShowAlert("success", "Changes saved successfully")

            PositionList.DataBind()

            TotalSpendLabel.Text = String.Format("${0}", (From p In db.qryEventStaffingRequirementLists Where p.eventID = thisEvent.eventID Select p.Total).Sum)


            Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Ambassadors Details", "The details for the ambassadors was changed.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Ambassadors Details", "The details for the ambassadors was changed.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        Catch ex As Exception
            msgLabel1.Text = ex.Message
        End Try

    End Sub

    Protected Sub cmbPageSize_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)

        AvailableAmbassadorList.PageSize = Integer.Parse(e.Value)
        AvailableAmbassadorList.CurrentPageIndex = 0
        AvailableAmbassadorList.Rebind()

    End Sub

    Private Sub PositionList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles PositionList.ItemCommand

        Dim id As Integer = e.CommandArgument

        If e.CommandName = "Remove" Then

            '  RadNotification2.Show(e.CommandArgument)


            'send email if is not global admin role
            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            'show/hide admin panels
            If manager.IsInRole(currentUser.Id, "GlobalAdmin") Then


            Else

                ''send email to BA
                'Dim eventDetails = (From p In db.getEventDetails Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault
                'Dim ba = (From b In db.tblAmbassadors Where b.userName = id Select b).FirstOrDefault

                'Dim m = (From p In db.tblMessages Where p.messageID = 7 Select p).FirstOrDefault

                'Dim myString As String = ""
                'myString = m.messageText
                'myString = myString.Replace("[FirstName]", ba.FirstName)
                'myString = myString.Replace("[LastName]", ba.LastName)
                'myString = myString.Replace("[EventCity]", eventDetails.city)
                'myString = myString.Replace("[EventState]", eventDetails.state)
                'myString = myString.Replace("[EventDate]", eventDetails.eventDate)
                'myString = myString.Replace("[EventStartTime]", String.Format("{0}:t", eventDetails.startTime))
                'myString = myString.Replace("[EventBrands]", (From i In db.qryGetBrandsInEvents Where i.eventID = Request.QueryString("ID") Select i.brands).FirstOrDefault)
                'myString = myString.Replace("[SupplierName]", getSupplierName(eventDetails.supplierID))

                'myString = myString.Replace("[LocationName]", eventDetails.AccountName)
                'myString = myString.Replace("[EventLinkURL]", "http://events.gigengyn.com/Events/EventDetails?ID=" & eventDetails.eventID)

                'Dim recipient = ba.EmailAddress

                ''send email
                'MailHelper.SendEmailMessage(7, recipient, m.fromAddress, m.fromName, m.subject, myString.ToString())


            End If



            Dim q = db.RemoveStaffFromEvent(id)


            'check if all positions are booked

            Dim thisEvent1 = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

            'get assignment count
            Dim positioncount = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Where p.assigned = True Select p).Count
            Dim assignedcount = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Select p).Count

            Dim status = thisEvent1.statusID

            'update ststus to scheduled
            Try
                Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

                thisEvent.statusID = 4
                thisEvent.ModifiedDate = Date.Now()
                thisEvent.ModifiedBy = Context.User.Identity.GetUserId()
                db.SubmitChanges()

                Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "A brand ambassador was removed. The event status was updated to Scheduled.", Context.User.Identity.GetUserId(), Date.Now())

                'add to history log
                lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Event Status Updated", "A brand ambassador was removed. The event status was updated to Scheduled.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                RadNotification2.Text = "The event status was updated to Scheduled."

                RadNotification2.Show()

                StatusLabel.Text = "Scheduled"

            Catch ex As Exception

            End Try

            'send email to BA



            rebindData()
        End If
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
            'return nothing
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

    End Function

    Function getNotAssigned(assigned As String) As Boolean

        If assigned = "False" Then
            Return True
        Else
            Return False
        End If
    End Function

    Function getTotalPay(id As Integer) As String

        Dim db As New DataClassesDataContext

        Return String.Format("{0:C}", (From p In db.viewEventStaffingRequirements Where p.requirementID = id Select p.Total).FirstOrDefault)
    End Function

    Function getDollar(id As Integer) As String
        Return "$"
    End Function

    Private Sub StaffingList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles StaffingList.ItemDataBound
        ' If (e.Item.ItemType = ListItemType.Item) Or
        '(e.Item.ItemType = ListItemType.AlternatingItem) Then

        '     Dim AssignedNameLabel As Label = CType(e.Item.FindControl("AssignedNameLabel"), Label)
        '     Dim AssignedNameLink As HyperLink = CType(e.Item.FindControl("AssignedNameLink"), HyperLink)

        '     Dim manager = New UserManager()
        '     Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        '     Dim HiddenUserID As Label = CType(e.Item.FindControl("HiddenUserID"), Label)

        '     If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Then
        '         AssignedNameLabel.Visible = True
        '         AssignedNameLink.Visible = False
        '     End If

        '     If manager.IsInRole(currentUser.Id, "Accounting") Or manager.IsInRole(currentUser.Id, "Administrator") Or manager.IsInRole(currentUser.Id, "EventManager") Or manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
        '         AssignedNameLabel.Visible = False
        '         AssignedNameLink.Visible = True
        '     End If

        '     If manager.IsInRole(currentUser.Id, "Accounting") Or manager.IsInRole(currentUser.Id, "Administrator") Or manager.IsInRole(currentUser.Id, "EventManager") Or manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
        '         AssignedNameLabel.Visible = False
        '         AssignedNameLink.Visible = True

        '         AssignedNameLink.NavigateUrl = "/ambassadors/ViewAmbassadorDetails?UserID=" & HiddenUserID.Text

        '     End If

        ' End If



        If StaffingList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If
    End Sub

    Private Sub BrandPositionList_ItemCreated(sender As Object, e As RadListViewItemEventArgs) Handles BrandPositionList.ItemCreated
        If TypeOf e.Item Is RadListViewInsertItem AndAlso e.Item.IsInEditMode Then

            'get the event start and finish times
            Dim id As Integer = Request.QueryString("ID")

            Dim i = (From p In db.tblEvents Where p.eventID = id Select p).FirstOrDefault
            Dim _startTime As Date = i.startTime
            Dim _endTime As Date = i.endTime

            Dim RadTimePicker12 As RadDateTimePicker = TryCast(e.Item.FindControl("RadTimePicker12"), RadDateTimePicker)
            Dim RadTimePicker22 As RadDateTimePicker = TryCast(e.Item.FindControl("RadTimePicker22"), RadDateTimePicker)

            RadTimePicker12.DbSelectedDate = _startTime
            RadTimePicker22.DbSelectedDate = _endTime


        End If
    End Sub



    Private Sub btnUpdateStatus_Click(sender As Object, e As EventArgs) Handles btnUpdateStatus.Click

        Try
            Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

            thisEvent.statusID = 2
            thisEvent.ModifiedDate = Date.Now()
            db.SubmitChanges()

            Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "The event status was updated to Booked.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Event Status Updated", "The event status was updated to Booked.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)


        Catch ex As Exception

        End Try

        ' CheckStatus()


    End Sub


    Private Sub btnApproveRecap_Click(sender As Object, e As EventArgs) Handles btnApproveRecap.Click
        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        db.UpdateEventRecapStatus_Approved(thisEvent.eventID, currentUser.Id)

        'Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Approve Event", "The event was approved.", Context.User.Identity.GetUserId(), Date.Now())

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Approve Event", "The event was approved.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        Response.Redirect("/events/eventdetails?ID=" & thisEvent.eventID & "&action=1")
    End Sub

    Private Sub btnUnapprove_Click(sender As Object, e As EventArgs) Handles btnUnapprove.Click

        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        db.UpdateEventRecapStatus_Toplined(thisEvent.eventID, currentUser.Id)

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Unapprove Event", "The event was unapproved.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        Response.Redirect("/events/eventdetails?ID=" & thisEvent.eventID & "&action=1")
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

            Try
                Dim bytes(file.ContentLength - 1) As Byte
                file.InputStream.Read(bytes, 0, file.ContentLength)


                Dim i As New tblPhoto
                i.Image = MakeThumb(bytes, 1200)
                i.LargeImage = MakeThumb(bytes, 500) '1
                i.SmallImage = MakeThumb(bytes, 350) '2
                i.ThumbImage = MakeThumb(bytes, 100) '3

                i.tag = Request.UserAgent.ToString().ToLower()
                i.keywords = "Case Nothing, Not Rotated"

                i.eventID = eventID
                i.photoTitle = getAccountDetails()
                i.dateUploaded = Date.Now()
                i.accountID = getAccountID()
                i.marketID = getMarketID()
                i.uploadedBy = currentUser.Id
                i.fileName = file.GetName

                db.tblPhotos.InsertOnSubmit(i)
                db.SubmitChanges()
            Catch ex As Exception
                'do nothing
            End Try

        Next

        Try
            Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Photo(s) uploaded", "Photos have been uploaded to the events gallery.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Photo(s) uploaded", "Photos have been uploaded to the events gallery.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)
        Catch ex As Exception
            msgLabel.Text = ex.Message.ToString()
        End Try


        PhotoListView.DataBind()

        GalleryPanel.Visible = True
        UploadPanel.Visible = False

    End Sub

    Function getAccountDetails() As String

        Dim i = (From p In db.qryViewEvents Where p.eventID = Request.QueryString("ID") Select p)

        For Each p In i
            Return String.Format("{0}, {1}, {2}", p.accountName, p.city, p.state)
        Next


    End Function

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

    Private Function GetPhoto(photoId As Integer) As Byte()

        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Dim comm As New SqlCommand("SELECT LargeImage FROM tblPhoto WHERE photoID = @photoID", conn)
        comm.Parameters.Add(New SqlParameter("@PhotoID", photoId))

        conn.Open()
        Dim data As Object = comm.ExecuteScalar()
        conn.Close()

        Return DirectCast(data, Byte())
    End Function

    Private Sub PhotoListView_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PhotoListView.ItemCommand

        Select Case e.CommandName

            Case "Download"

                Dim item As RadListViewDataItem = TryCast(e.ListViewItem, RadListViewDataItem)
                Dim photoID As String = item.GetDataKeyValue("photoID").ToString()

                '  Response.Redirect("/gallery/downloadhandler.aspx?photoID=" & id)

                Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault

                Dim data As Byte() = GetPhoto(photoID)

                Response.Clear()
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("content-disposition", Convert.ToString("attachment; filename=") & _fileName)
                Response.BinaryWrite(data)



            Case "DeleteImage"

                Dim item As RadListViewDataItem = TryCast(e.ListViewItem, RadListViewDataItem)
                Dim id As String = item.GetDataKeyValue("photoID").ToString()

                Try
                    Dim deletephoto = db.DeletePhoto(Convert.ToInt32(id))

                    Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Image Deleted", "Image was deleted form the event.", Context.User.Identity.GetUserId(), Date.Now())

                    'add to history log
                    lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Image Deleted", "Image was deleted form the event.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                    PhotoListView.DataBind()
                Catch ex As Exception
                    errorLabel.Text = ex.Message
                End Try

            Case "RotateRight"
                '  Dim photoID As Integer
                Dim _fileName As String

                Dim item As RadListViewDataItem = TryCast(e.ListViewItem, RadListViewDataItem)
                Dim photoID As String = item.GetDataKeyValue("photoID").ToString()


                Try
                    'get the image from sql and save as to disk
                    _fileName = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault
                Catch ex As Exception
                    MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on GigEngyn", "There was an error rotating an image with the Rotate Right command. PhotoID: " & photoID & "<br>" & ex.Message())
                End Try

                Try
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
                Catch ex As Exception
                    MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on GigEngyn", "There was an error rotating an image with the Rotate Right command. PhotoID: " & photoID & "<br>" & ex.Message())
                End Try


                'rotate the image
                ' get the full path of image url

                Dim path As String = Server.MapPath("~/documents/rotator/" & _fileName)
                Dim newpath As String = Server.MapPath("~/documents/rotator/new/" & photoID & ".jpg")

                Dim myImageCodecInfo As ImageCodecInfo
                Dim myEncoder As Encoder
                Dim myEncoderParameter As EncoderParameter
                Dim myEncoderParameters As EncoderParameters

                myImageCodecInfo = GetEncoderInfo(ImageFormat.Jpeg)
                myEncoder = Encoder.Quality
                myEncoderParameters = New EncoderParameters(1)

                Try
                    ' creating image from the image url
                    Dim i As System.Drawing.Image = System.Drawing.Image.FromFile(path)

                    ' rotate Image 90' Degree
                    i.RotateFlip(RotateFlipType.Rotate90FlipNone)

                    ' save it to its actual path
                    myEncoderParameter = New EncoderParameter(myEncoder, CType(75L, Int32))
                    myEncoderParameters.Param(0) = myEncoderParameter

                    i.Save(newpath, myImageCodecInfo, myEncoderParameters)

                    ' release Image File
                    i.Dispose()

                Catch ex As Exception
                    MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on GigEngyn", "There was an error rotating an image with the Rotate Right command. PhotoID: " & photoID & "<br>" & ex.Message())
                End Try

                Try
                    'save image to sql
                    Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
                        sqlconnection.Open()

                        Dim bytes As Byte() = Nothing
                        Dim fs As New FileStream(newpath, FileMode.Open, FileAccess.Read)
                        Dim br As New BinaryReader(fs)
                        bytes = br.ReadBytes(CInt(fs.Length))


                        Dim selectQuery As String = String.Format("UPDATE tblPhoto set Image = @image, ThumbImage = @thumbimage, SmallImage = @smallimage, LargeImage = @largeimage WHERE photoID = @photoID")
                        Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)

                        'selectCommand.CommandTimeout = 60

                        selectCommand.Parameters.Add(New SqlParameter("@photoID", photoID))
                        selectCommand.Parameters.Add(New SqlParameter("@image", bytes))
                        selectCommand.Parameters.Add(New SqlParameter("@thumbimage", MakeThumb(bytes, 100)))
                        selectCommand.Parameters.Add(New SqlParameter("@smallimage", MakeThumb(bytes, 350)))
                        selectCommand.Parameters.Add(New SqlParameter("@largeimage", MakeThumb(bytes, 500)))

                        selectCommand.ExecuteNonQuery()
                        sqlconnection.Close()

                        fs.Close()
                    End Using
                Catch ex As Exception
                    MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on GigEngyn", "There was an error saving an image with the Rotate Right command. PhotoID: " & photoID & "<br>" & ex.Message())
                End Try

                'delete temp image
                Try
                    System.IO.File.Delete(Server.MapPath("~/documents/rotator/" & _fileName))
                Catch ex As Exception

                End Try

                Try
                    System.IO.File.Delete(Server.MapPath("~/documents/rotator/new/" & photoID & ".png"))
                Catch ex As Exception

                End Try

                PhotoListView.DataBind()

            Case "RotateLeft"
                Dim _fileName As String

                Dim item As RadListViewDataItem = TryCast(e.ListViewItem, RadListViewDataItem)
                Dim photoID As String = item.GetDataKeyValue("photoID").ToString()

                'get the image from sql and save as to disk
                Try
                    'get the image from sql and save as to disk
                    _fileName = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault
                Catch ex As Exception
                    MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on GigEngyn", "There was an error rotating an image with the Rotate Left command. PhotoID: " & photoID & "<br>" & ex.Message())
                End Try


                Try
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
                Catch ex As Exception
                    MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on GigEngyn", "There was an error rotating an image with the Rotate Left command. PhotoID: " & photoID & "<br>" & ex.Message())
                End Try



                'rotate the image
                ' get the full path of image url

                Dim path As String = Server.MapPath("~/documents/rotator/" & _fileName)
                Dim newpath As String = Server.MapPath("~/documents/rotator/new/" & photoID & ".jpg")

                Dim myImageCodecInfo As ImageCodecInfo
                Dim myEncoder As Encoder
                Dim myEncoderParameter As EncoderParameter
                Dim myEncoderParameters As EncoderParameters

                myImageCodecInfo = GetEncoderInfo(ImageFormat.Jpeg)
                myEncoder = Encoder.Quality
                myEncoderParameters = New EncoderParameters(1)

                Try
                    ' creating image from the image url
                    Dim i As System.Drawing.Image = System.Drawing.Image.FromFile(path)

                    ' rotate Image 90' Degree
                    i.RotateFlip(RotateFlipType.Rotate270FlipNone)

                    ' save it to its actual path
                    myEncoderParameter = New EncoderParameter(myEncoder, CType(75L, Int32))
                    myEncoderParameters.Param(0) = myEncoderParameter

                    i.Save(newpath, myImageCodecInfo, myEncoderParameters)

                    ' release Image File
                    i.Dispose()
                Catch ex As Exception
                    MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on GigEngyn", "There was an error rotating an image with the Rotate Left command. PhotoID: " & photoID & "<br>" & ex.Message())
                End Try



                Try
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

                        fs.Close()
                    End Using
                Catch ex As Exception
                    MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error on GigEngyn", "There was an error saving an image with the Rotate Left command. PhotoID: " & photoID & "<br>" & ex.Message())
                End Try


                'delete the temp image
                Try
                    System.IO.File.Delete(Server.MapPath("~/documents/rotator/" & _fileName))
                Catch ex As Exception

                End Try

                Try
                    System.IO.File.Delete(Server.MapPath("~/documents/rotator/new/" & photoID & ".png"))
                Catch ex As Exception

                End Try


                PhotoListView.DataBind()

        End Select
    End Sub

    Private Shared Function GetEncoderInfo(ByVal format As ImageFormat) As ImageCodecInfo
        Dim j As Integer
        Dim encoders() As ImageCodecInfo
        encoders = ImageCodecInfo.GetImageEncoders()

        j = 0
        While j < encoders.Length
            If encoders(j).FormatID = format.Guid Then
                Return encoders(j)
            End If
            j += 1
        End While
        Return Nothing

    End Function 'GetEncoderInfo


    Private Sub btnAddPhotos_Click(sender As Object, e As EventArgs) Handles btnAddPhotos.Click

        GalleryPanel.Visible = False
        UploadPanel.Visible = True

    End Sub

    Private Sub btnCancelChanges_Click(sender As Object, e As EventArgs) Handles btnCancelChanges.Click

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

    'Notes Tab Code
    Private Sub getNotes_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getNotes.Inserting

        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Dim i As tblEventNote
        i = CType(e.NewObject, tblEventNote)
        i.eventID = Request.QueryString("ID")
        i.createdBy = currentUser.Id
        i.dateCreated = Date.Now()

        Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Notes", "New note was added.", Context.User.Identity.GetUserId(), Date.Now())

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Notes", "New note was added.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

    End Sub

    Private Sub getNotes_Updating(sender As Object, e As LinqDataSourceUpdateEventArgs) Handles getNotes.Updating

        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Dim originalNote As tblEventNote
        Dim newNote As tblEventNote

        originalNote = CType(e.OriginalObject, tblEventNote)
        newNote = CType(e.NewObject, tblEventNote)

        newNote.dateModified = Date.Now()
        newNote.modifiedBy = currentUser.Id

        Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Notes", "Note was edited.", Context.User.Identity.GetUserId(), Date.Now())

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Notes", "Note was edited.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

    End Sub

    Protected Sub btnInsert_Click(sender As Object, e As EventArgs)

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Requirements", "Add new position button click.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

    End Sub

    Protected Sub DeleteButton_Click(sender As Object, e As EventArgs)

        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Notes", "Note was deleted.", Context.User.Identity.GetUserId(), Date.Now())

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Notes", "Note was deleted.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

    End Sub

    Protected Sub DeleteButton_Click2(sender As Object, e As EventArgs)

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Requirements", "The position was deleted.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

    End Sub

    Protected Sub CancelButton_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub UpdateButton_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub EditButton_Click(sender As Object, e As EventArgs)

    End Sub 'End Notes Tab Code

    Protected Sub btnInsertExpense_Click(sender As Object, e As EventArgs)

        PayrollPanel.Visible = False
        ExpensePanel.Visible = False
        AddNewExpensePanel.Visible = True

    End Sub

    Protected Sub btnCancelExpense_Click(sender As Object, e As EventArgs)

        PayrollPanel.Visible = True
        ExpensePanel.Visible = True
        AddNewExpensePanel.Visible = False

    End Sub

    Protected Sub CancelEditExpenseButton_Click(sender As Object, e As EventArgs)

        PayrollPanel.Visible = True
        ExpensePanel.Visible = True
        EditExpensePanel.Visible = False

    End Sub

    Private Sub btnSaveExpense_Click(sender As Object, e As EventArgs) Handles btnSaveExpense.Click

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Dim expense As New tblEventExpense
        expense.eventStaffingRequirementID = AmbassadorDropDownList.SelectedValue
        expense.expenseTypeID = ddlExpenseType.SelectedValue
        expense.description = descriptionTextBox.Text
        expense.amount = amountTextBox.Text
        expense.submittedDate = Date.Now()
        expense.submittedBy = currentUser.Id

        For Each file As UploadedFile In ReceiptAsyncUpload.UploadedFiles
            Dim bytes(file.ContentLength - 1) As Byte
            file.InputStream.Read(bytes, 0, file.ContentLength)

            expense.receipt = (bytes)
        Next

        db.tblEventExpenses.InsertOnSubmit(expense)
        db.SubmitChanges()


        PayrollPanel.Visible = True
        ExpensePanel.Visible = True
        AddNewExpensePanel.Visible = False


        Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Expense Added", "Expense was added to the event expenses.", Context.User.Identity.GetUserId(), Date.Now())

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Expense Added", "Expense was added to the event expenses.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)


        'rebind the expense list
        ExpenseList.DataBind()

        'clear form
        AmbassadorDropDownList.SelectedIndex = 0
        ddlExpenseType.SelectedIndex = 0
        descriptionTextBox.Text = ""
        amountTextBox.Text = "0"


    End Sub

    Private Sub ExpenseList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles ExpenseList.ItemCommand
        If e.CommandName = "DeleteExpense" Then

            db.DeleteExpense(Convert.ToInt32(e.CommandArgument))

            Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Expense Deleted", "Expense was deleted from the event expenses.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Expense Deleted", "Expense was deleted from the event expenses.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            ExpenseList.DataBind()
        End If

        If e.CommandName = "EditExpense" Then

            'show the edit form
            PayrollPanel.Visible = False
            ExpensePanel.Visible = False
            EditExpensePanel.Visible = True

            HiddenExpenseID.Value = e.CommandArgument

            Dim q = (From p In db.tblEventExpenses Where p.eventExpenseID = Convert.ToInt32(e.CommandArgument) Select p).FirstOrDefault

            EditExpenseTypeDropDownList.SelectedValue = q.expenseTypeID
            descriptionTextBox2.Text = q.description
            amountTextBox2.Text = q.amount

            Dim i = q.eventStaffingRequirementID

            Dim a = (From p In db.tblEventStaffingRequirements Where p.RequirementID = i Select p.assignedUserName).FirstOrDefault

            Dim b = (From p In db.tblAmbassadors Where p.userName = a Select p).FirstOrDefault
            RecieptNameLabel.Text = String.Format("{0} {1}", b.FirstName, b.LastName)
        End If
    End Sub

    Private Sub btnEditExpense_Click(sender As Object, e As EventArgs) Handles btnEditExpense.Click

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        'save the form

        Dim q = (From p In db.tblEventExpenses Where p.eventExpenseID = Convert.ToInt32(HiddenExpenseID.Value) Select p).FirstOrDefault

        q.amount = amountTextBox2.Text
        q.description = descriptionTextBox2.Text
        q.expenseTypeID = EditExpenseTypeDropDownList.SelectedValue

        For Each file As UploadedFile In ReceiptAsyncUpload2.UploadedFiles
            Dim bytes(file.ContentLength - 1) As Byte
            file.InputStream.Read(bytes, 0, file.ContentLength)

            q.receipt = (bytes)
        Next

        q.modifiedBy = currentUser.Id
        q.modifiedDate = Date.Now()

        db.SubmitChanges()

        Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Expense Edited", "Expense was edited.", Context.User.Identity.GetUserId(), Date.Now())

        'add to history log
        lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Expense Edited", "Expense was edited.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

        PayrollPanel.Visible = True
        ExpensePanel.Visible = True
        EditExpensePanel.Visible = False

        'rebind the expense list
        ExpenseList.DataBind()


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
                'KitRequested.SelectedValue = thisEvent.posKitRequested
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
                        'None

                        Case "4"
                            'Other


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

        If SelectYesCheckBox.Checked = False Then
            CustomValidator1.IsValid = False

        Else
            CustomValidator1.IsValid = True


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
            newkit.notes = NotesTextBox.Text

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


            Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "POS Kits", "The POS kit was requested.", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "POS Kits", "The POS kit was requested.", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

            POSItemList.Items.Clear()
            BindPOSKit()


        End If

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

            Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Course Invitation LInk", "Course invitation link was sended to " & recipient & " .", Context.User.Identity.GetUserId(), Date.Now())

            'add to history log
            lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), Request.QueryString("ID"), Date.Now(), "Course Invitation LInk", "Course invitation link was sended to " & recipient & " .", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

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

                        Dim _curriculum = (From l In lmsdb.Curriculums Where l.CurriculumGroupID = a.courseGroupID And l.Enabled = True Select l).Distinct

                        'if there are no Curriculum results
                        'If _curriculum.Count = 0 Then
                        '    Dim div12 As New HtmlGenericControl("div")
                        '    div12.InnerHtml = String.Format("There are no tests online for {0}", "") 'getBrandName(a.brandID)
                        '    div12.Attributes.Add("class", "marginbottom10")
                        '    div12.Attributes.Add("class", "text-danger")

                        '    TestScoresPlaceHolder.Controls.Add(div12)
                        'End If

                        Dim div12 As New HtmlGenericControl("div")
                        div12.InnerHtml = String.Format("{0}", getBrandCourseGroupName(a.courseGroupID))
                        div12.Attributes.Add("class", "marginbottom10")
                        div12.Attributes.Add("class", "text-danger")

                        TestScoresPlaceHolder.Controls.Add(div12)

                        For Each list In _curriculum

                            Dim test = (From u In lmsdb.CurriculumLists Where u.CurriculumID = list.CurriculumID And u.ContentType = 1 Select u).Distinct



                            ' For Each u In test
                            'Dim type = (From y In lmsdb.CurriculumLists Where y.CurriculumID = list.CurriculumID Select y.ContentType).FirstOrDefault
                            'Dim _testID = (From b In lmsdb.CurriculumLists Where b.CurriculumID = list.CurriculumID Select b.TestID).FirstOrDefault

                            'Dim _result = (From t In lmsdb.baretc_TestResults Where t.UserName = p.assignedUserName And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Result).FirstOrDefault
                            'Dim _score = (From t In lmsdb.baretc_TestResults Where t.UserName = p.assignedUserName And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Score).FirstOrDefault


                            'Dim testresult As String
                            'Dim resultlabel As String
                            'Dim scoreLabel As String

                            'Select Case _result
                            '    Case "Passed"
                            '        testresult = "success"
                            '        resultlabel = "Passed"
                            '        scoreLabel = String.Format("{0}%", _score)
                            '    Case "Failed"
                            '        testresult = "danger"
                            '        resultlabel = "Failed"
                            '        scoreLabel = String.Format("{0}%", _score)
                            '    Case Else
                            '        testresult = "warning"
                            '        resultlabel = "Not Started"
                            '        scoreLabel = ""
                            'End Select

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
                            ' lbl4.InnerHtml = String.Format("<h4><span class='label label-{0}'>{1} {2}</span></h4>", testresult, resultlabel, scoreLabel)

                            lbl4.InnerHtml = String.Format("{0}", GetCurriculumStatus(list.CurriculumID, p.assignedUserName, getBrandCourseID(a.courseGroupID)))


                            lbl4.Attributes.Add("class", "pull-right")
                            div2.Controls.Add(lbl4)

                            wrapper.Controls.Add(div2)

                            TestScoresPlaceHolder.Controls.Add(wrapper)

                            '   Next

                        Next

                    Next 'end of brands


                    Dim footer As New HtmlGenericControl("div")
                    Dim lbl11 As New HtmlGenericControl("label")
                    lbl11.InnerHtml = String.Format("{0}", "<hr>")
                    footer.Controls.Add(lbl11)

                    TestScoresPlaceHolder.Controls.Add(footer)

                End If

            Next

        Catch ex As Exception

        End Try



    End Sub

    Function GetCurriculumStatus(id As String, UserName As String, courseID As String) As String
        Try
            Dim _studentInCourseID = (From p In lmsdb.StudentsInCourses Where p.CourseID = courseID And p.UserName = UserName Select p.StudentInCourseID).FirstOrDefault

            Dim CompletedDate As Date = (From p In lmsdb.CurriculumResults Where p.CurriculumID = id And p.StudentInCourseID = _studentInCourseID And p.Completed = True Select p.DateCompleted).FirstOrDefault

            Return String.Format("<span class='text-success'><i class='fa fa-check-square-o' aria-hidden='true'></i> Completed</span>")
        Catch ex As Exception
            Return String.Format("<span class='text-danger'><i class='fa fa-times' aria-hidden='true'></i> Not Started</span>")
            Return Nothing
        End Try
    End Function

    Sub BindDocuments()

        Dim showButton As String = "False"

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Administrator") Then
            showButton = "True"
        End If

        If manager.IsInRole(currentUser.Id, "EventManager") Then
            showButton = "True"
        End If

        If manager.IsInRole(currentUser.Id, "BrandMarketer") Then
            showButton = "True"
        End If

        If manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
            showButton = "True"
        End If

        BtnAttachDocument.Visible = showButton

        'create a list of documents
        Dim myView As New List(Of EventDocumentList)

        'get the event brands
        Dim r = From p In db.getCourseForEvents Where p.eventID = Request.QueryString("ID") Select p

        For Each p In r

            Dim ID = (From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l.CurriculumID).FirstOrDefault
            Dim related = (From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l.CurriculumGroupID).FirstOrDefault

            Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l


            'Dim type = (From u In lmsdb.CurriculumLists Where u.CurriculumID = ID Select u.ContentType).FirstOrDefault
            ' Dim _testID = (From u In lmsdb.CurriculumLists Where u.CurriculumID = ID Select u.TestID).FirstOrDefault


            'get the documents for the brands course
            Dim myFiles = From i In lmsdb.CourseFiles Where i.RelatedID = p.curriculum Select i

            'add the training documents to the list
            For Each i In myFiles
                myView.Add(New EventDocumentList(i.FileID, getFileName(i.FileID), getFileType(i.FileID), "/filehandler?ID=" & i.FileID, showButton, "RemoveFile", disableDocument(i.FileID)))
            Next

        Next

        'get documents attached to the event
        Dim q = From p In db.tblEventDocuments Where p.EventID = Request.QueryString("ID") Select p

        'add the attached documents to the list
        For Each p In q
            myView.Add(New EventDocumentList(p.DocumentID, p.DocumentName, p.FileType, "/events/eventfilehandler?ID=" & p.DocumentID, showButton, "DeleteAttachment", "True"))
        Next

        Dim result = From w In myView Where w.Visible = "True" Select w

        DocumentRepeater.DataSource = result.GroupBy(Function(p) p.FileID).[Select](Function(g) g.First())
        DocumentRepeater.DataBind()

        'RadGrid1.DataSource = result.GroupBy(Function(p) p.FileID).[Select](Function(g) g.First())
        'RadGrid1.DataBind()

    End Sub

    Function disableDocument(fileID As String) As String

        Dim q = From p In db.tblEventDocument_Hiddens Where p.fileID = fileID And p.eventID = Request.QueryString("ID") Select p

        If q.Count = 0 Then
            Return "True"
        Else
            Return "False"
        End If

    End Function

    Public Sub BindCourses()

        'delete all eventCourse records
        db.deleteEventCourse(Convert.ToInt32(Request.QueryString("ID")))

        'get brands
        Dim r = From p In db.getCourseForEvents Where p.eventID = Request.QueryString("ID") Select p

        For Each p In r

            Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum And l.Enabled = True Order By l.SortOrder Select l

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


        EventCourseListView.DataBind()

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

    Public Function hasInvoice() As Boolean

        Dim i = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.invoiced).FirstOrDefault

        If i = True Then

            Dim _invoiceID = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.invoiceID).FirstOrDefault

            Dim InvoiceStatus = (From p In db.tblInvoices Where p.invoiceID = _invoiceID Select p.status).FirstOrDefault

            If InvoiceStatus = "Open" Or InvoiceStatus = "Draft" Then
                Return True
            Else
                Return False
            End If

        Else
            Return True
        End If

    End Function
    Private Sub RadTabStrip1_TabClick(sender As Object, e As RadTabStripEventArgs) Handles RadTabStrip1.TabClick

        Select Case e.Tab.Value
            Case "status"
                BindTestsScores()
                BindDocuments()
                Exit Select

            Case "AssignBA"
                AvailableAmbassadorList.DataSourceID = "getAvailableAmbassadorList"

                'AvailableAmbassadorList.DataSource = GetAvailableAmbassadorTable()

                LookupAmbassadorText.DataSourceID = "getAvailableAmbassadorNameList"

                PositionList.DataSourceID = "getEventPositions"

                Dim dv As System.Data.DataView = DirectCast(getAvailableAmbassadorNameList.[Select](DataSourceSelectArguments.Empty), DataView)

                StaffCountLabel.Text = dv.Count.ToString()

                ' Dim i = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.invoiced).FirstOrDefault

                If hasInvoice() = False Then
                    msgLabel1.ForeColor = Color.Red
                    msgLabel1.Text = "<i class='fa fa-exclamation-triangle' aria-hidden='true'></i> This event has been invoiced.  Editing has been disabled."
                    btnSaveChanges.Visible = False
                    btnCancelChanges.Visible = False
                End If

                Dim bccString As String = ""

                Dim bccList = From p In db.getAvailableAmbassadorEmailString(Convert.ToInt32(HF_MarketID.Value), Convert.ToInt32(HF_PositionID.Value)) Select p

                For Each p In bccList
                    bccString = p.BCC
                Next

                'Dim bccList As String = "invisibledude@gmail.com,ghost@gmail.com"

                'BtnMailBlast.NavigateUrl = "mailto:?subject=Event&bcc=" & bccString


                BindTestsScores()
                BindDocuments()
                Exit Select

            Case "requirement"
                BrandPositionList.DataSourceID = "getEventPositions"

                BindTestsScores()
                BindDocuments()
                Exit Select

            Case "payroll"
                PayrollList.DataSourceID = "getPayrolSummary"
                ExpenseList.DataSourceID = "getExpensesList"

                BindTestsScores()
                BindDocuments()

            Case "clientExpenses"
                ClientExpensesListView.DataSourceID = "getExpensesList"

                BindTestsScores()
                BindDocuments()
                Exit Select
        End Select

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


    Private Sub SupplierBudgetRepeater_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles SupplierBudgetRepeater.ItemDataBound

        'If SupplierBudgetRepeater.Items.Count < 1 Then

        '    If e.Item.ItemType = ListItemType.Footer Then
        '        Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
        '        lblFooter.Visible = True
        '    End If

        'End If

    End Sub

    Private Sub PhotoListView_ItemDataBound(sender As Object, e As RadListViewItemEventArgs) Handles PhotoListView.ItemDataBound

        'If TypeOf e.Item Is RadListViewDataItem Then
        '    Dim manager = New UserManager()
        '    Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        '    Dim btnDownload As HyperLink = TryCast(e.Item.FindControl("btnDownload"), HyperLink)
        '    Dim btnDeleteImage As LinkButton = TryCast(e.Item.FindControl("btnDeleteImage"), LinkButton)
        '    Dim btnRotateImageLeft1 As LinkButton = TryCast(e.Item.FindControl("btnRotateImageLeft1"), LinkButton)
        '    Dim btnRotateImage1 As LinkButton = TryCast(e.Item.FindControl("btnRotateImage1"), LinkButton)

        '    'show/hide buttons
        '    If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Or manager.IsInRole(currentUser.Id, "Accounting") Or manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
        '        btnDownload.Visible = False
        '        btnDeleteImage.Visible = False
        '        btnRotateImageLeft1.Visible = False
        '        btnRotateImage1.Visible = False
        '    End If


        'End If


    End Sub

    'Private Sub getAvailableAmbassadorList_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles getAvailableAmbassadorList.Selecting
    '    If Not IsPostBack Then
    '        e.Cancel = True
    '    End If

    'End Sub

    Private Sub getAvailableAmbassadorNameList_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles getAvailableAmbassadorNameList.Selecting
        If Not IsPostBack Then
            e.Cancel = True
        End If

    End Sub

    Private Sub getPayrolSummary_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles getPayrolSummary.Selecting
        If Not IsPostBack Then
            e.Cancel = True
        End If
    End Sub

    Private Sub AvailableAmbassadorList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles AvailableAmbassadorList.ItemCommand

        Select Case e.CommandName
            Case "RemoveRequest"
                Try
                    'remove them
                    Dim userID As String = e.CommandArgument
                    Dim q = From p In db.tblAmbassadorEventRequests Where p.eventID = Convert.ToInt32(Request.QueryString("ID")) And p.userID = userID Select p

                    For Each p In q
                        p.requestStatus = 2
                        p.modifiedBy = Context.User.Identity.GetUserId()
                        p.modifiedDate = Date.Now()

                        db.SubmitChanges()
                    Next

                    AvailableAmbassadorList.DataBind()
                Catch ex As Exception
                    MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error", ex.Message & "<br>" & Request.QueryString("ID") & "<br>" & e.CommandArgument)
                End Try


        End Select

    End Sub

    Private Sub BtnAdvancedScheduler_Click(sender As Object, e As EventArgs) Handles BtnAdvancedScheduler.Click

        Response.Redirect("/events/eventscheduler?ID=" & Request.QueryString("ID"))
    End Sub

    Private Sub BtnAttachDocument_Click(sender As Object, e As EventArgs) Handles BtnAttachDocument.Click

        NewDocumentPanel.Visible = True
        DocumentPanel.Visible = False
    End Sub

    Private Sub btnExitUpload_Click(sender As Object, e As EventArgs) Handles btnExitUpload.Click

        NewDocumentPanel.Visible = False
        DocumentPanel.Visible = True

    End Sub

    Private Sub btnSubmitFileUpload_Click(sender As Object, e As EventArgs) Handles btnSubmitFileUpload.Click

        'Dim FileName As String = txtFileName.Text.ToString()


        Try
            For Each file As UploadedFile In RadAsyncUpload.UploadedFiles
                Dim uploadID As String = System.Guid.NewGuid().ToString()

                'Dim  As UploadedFile = RadAsyncUpload.UploadedFiles(0)
                Dim s As String = file.FileName
                ' Dim path As String = System.IO.Path.GetFileName(s)

                Dim ThisFile As String = file.GetName
                Dim Contenttype As String = file.ContentType
                Dim fileSize As Integer = file.ContentLength
                Dim length As Single = Single.Parse(fileSize.ToString())
                Dim fileData As Byte() = New Byte(file.InputStream.Length - 1) {}
                file.InputStream.Read(fileData, 0, CInt(file.InputStream.Length))

                Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

                Dim cmd As New SqlCommand()
                cmd.CommandText = "INSERT INTO tblEventDocument(DocumentID,EventID,DocumentName,FileType,ModifiedBy,ModifiedDate,data,size)" & " VALUES (@DocumentID,@EventID,@DocumentName,@FileType,@ModifiedBy,@ModifiedDate,@data,@size)"
                cmd.CommandType = CommandType.Text
                cmd.Connection = conn

                Dim ID As New SqlParameter("@DocumentID", SqlDbType.NVarChar, 50)
                ID.Value = uploadID
                cmd.Parameters.Add(ID)

                Dim EventID As New SqlParameter("@EventID", SqlDbType.NVarChar, 50)
                EventID.Value = Request.QueryString("ID")
                cmd.Parameters.Add(EventID)

                Dim DocumentName As New SqlParameter("@DocumentName", SqlDbType.NVarChar, 100)
                DocumentName.Value = ThisFile
                cmd.Parameters.Add(DocumentName)

                Dim File_Type As New SqlParameter("@FileType", SqlDbType.VarChar, 50)
                File_Type.Value = Contenttype
                cmd.Parameters.Add(File_Type)

                Dim Uploaded_By As New SqlParameter("@ModifiedBy", SqlDbType.NVarChar, 50)
                Uploaded_By.Value = System.Web.HttpContext.Current.User.Identity.GetUserId()
                cmd.Parameters.Add(Uploaded_By)

                Dim Date_Uploaded As New SqlParameter("@ModifiedDate", SqlDbType.SmallDateTime)
                Date_Uploaded.Value = Date.Now()
                cmd.Parameters.Add(Date_Uploaded)


                Dim File_Content As New SqlParameter("@data", SqlDbType.VarBinary)
                File_Content.Value = fileData
                cmd.Parameters.Add(File_Content)

                Dim File_Size As New SqlParameter("@size", SqlDbType.BigInt, 99999)
                File_Size.Value = fileSize
                cmd.Parameters.Add(File_Size)


                conn.Open()
                cmd.ExecuteNonQuery()
                conn.Close()

            Next

        Catch ex As Exception
            msgUploadError.Text = ex.Message()
        End Try


        NewDocumentPanel.Visible = False
        DocumentPanel.Visible = True

        BindDocuments()

    End Sub

    Private Sub DocumentRepeater_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles DocumentRepeater.ItemCommand

        Select Case e.CommandName
            Case "DeleteAttachment"

                Try
                    db.DeleteEventDocument(e.CommandArgument)

                    BindDocuments()
                Catch ex As Exception
                    msgUploadError.Text = ex.Message()
                End Try

            Case "RemoveFile"

                Try
                    Dim doc As New tblEventDocument_Hidden
                    doc.fileID = e.CommandArgument
                    doc.eventID = Request.QueryString("ID")
                    doc.createdBy = Context.User.Identity.GetUserId()
                    doc.createdDate = Date.Now()
                    db.tblEventDocument_Hiddens.InsertOnSubmit(doc)
                    db.SubmitChanges()

                    BindDocuments()
                Catch ex As Exception
                    msgUploadError.Text = ex.Message()
                End Try
        End Select

    End Sub

    Private Sub DocumentRepeater_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles DocumentRepeater.ItemDataBound
        If DocumentRepeater.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If

    End Sub










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

Class MyFooter
    Inherits PdfPageEventHelper


    Private ffont As iTextSharp.text.Font = New iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.UNDEFINED, 9, iTextSharp.text.Font.NORMAL)
    Private writer As PdfWriter

    Public Sub New(writer As PdfWriter)
        Me.writer = writer
    End Sub


    Public Overrides Sub onEndPage(ByVal writer As PdfWriter, ByVal document As Document)


        Dim cb As PdfContentByte = writer.DirectContent
        Dim header As Phrase = New Phrase("", Me.ffont)
        Dim footer As Phrase = New Phrase("", Me.ffont)

        Dim text As Phrase = New Phrase(writer.PageNumber, Me.ffont)

        ColumnText.ShowTextAligned(cb, Element.ALIGN_CENTER, header, (((document.Right - document.Left) / 2) + document.LeftMargin), (document.Top + 10), 0)

        ColumnText.ShowTextAligned(cb, Element.ALIGN_CENTER, footer, (((document.Right - document.Left) / 2) + document.LeftMargin), (document.Bottom - 10), 0)

        ColumnText.ShowTextAligned(cb, Element.ALIGN_RIGHT, text, (((document.Right - document.Left) / 3) + (document.LeftMargin + 350)), (document.Bottom - 10), 0)



    End Sub



End Class