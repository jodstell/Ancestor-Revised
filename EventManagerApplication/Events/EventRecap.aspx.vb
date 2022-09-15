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

Public Class EventRecap1
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext
    Dim users As New LMSDataClassesDataContext

    Dim thisEvent As tblEvent

#Region "UserManager"
    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        RadClientExportManager1.PdfSettings.Fonts.Add("fontawesome", "http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/fonts/fontawesome-webfont.ttf")
        RadClientExportManager1.PdfSettings.Fonts.Add("Open Sans", "/theme/font/OpenSans-Regular.ttf")


        Dim action = Request.QueryString("action")

        'Select Case action
        '    Case 0
        '        'unused case
        '    Case 1
        '        msgLabel.Text = Common.ShowAlert("success", "The event was updated successfully!")
        '    Case 2
        '        msgLabel.Text = Common.ShowAlert("success", "The event was deleted!")
        '    Case 3
        '        msgLabel.Text = Common.ShowAlert("success", "A POS Kit has been requested.")
        '    Case 4
        '        ReturnLink1.NavigateUrl = "/Events/ViewEvents?Filter=Nothing"
        '        ReturnLink1.Text = "Events (Filtered)"
        'End Select

        thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault


        'bind all the data
        If Not Page.IsPostBack Then

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            'show/hide admin panels
            'If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Then
            '    logTab.Visible = False
            '    EditButtonPanel1.Visible = False
            '    EditRecapLink.Visible = False
            '    PrintPDFLink.Visible = False
            '    CreateRecapLink.Visible = False
            '    InvitationButton.Visible = False
            '    btnApproveRecap.Visible = False
            'End If

            'If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Then
            '    budgetTab.Visible = False
            '    notesTab.Visible = False
            '    costTab.Visible = False
            'End If

            'If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Or manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
            '    EditRecapLink.Visible = False
            '    btnApproveRecap.Visible = False
            '    btnSavePosKitRequest.Visible = False
            'End If

            'If manager.IsInRole(currentUser.Id, "Student") Then
            '    btnAddPhotos.Visible = False
            'End If




            'these sections do not need to reload on postback
            Staffing()
            'BindPOSKit()
            CheckStatus()
            bindEvent()

            'get the status of the recap
            Dim hasRecap = thisEvent.recapStatus '(From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.recapStatus).FirstOrDefault
            Dim status = thisEvent.statusID ' (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.statusID).FirstOrDefault

            'If hasRecap <> 0 Then
            '    EditRecapLink.Visible = True
            '    PrintPDFLink.Visible = True
            '    btnApproveRecap.Visible = True
            'End If

            'If status = 1 Then
            '    btnApproveRecap.Visible = False
            'End If

            'If hasRecap = 0 Then
            '    CreateRecapLink.Visible = True
            '    EditRecapLink.Visible = False
            '    PrintPDFLink.Visible = False
            'End If

            'format date labels
            Dim today As Date = Date.Now()
            Dim tomorrow As Date = Date.Now.AddDays(1)
            Dim day2 As Date = Date.Now.AddDays(2)

            'lblDay0.Text = today.Day
            'lblMonth0.Text = today.ToString("MMM")

            'lblDay1.Text = tomorrow.Day
            'lblMonth1.Text = tomorrow.ToString("MMM")

            'lblDay2.Text = day2.Day
            'lblMonth2.Text = day2.ToString("MMM")
            'lblDayName2.Text = day2.ToString("dddd")

        End If


        'these sections need to reload on postback so they are put here
        'BindCourses()
        'BindTestsScores()
        'BindDocuments()


    End Sub

    Function disableIfNull(id As Integer) As String

        ' Dim q = (From p In db.tblEventExpenses Where p.eventExpenseID = id Select p.receipt).FirstOrDefault

        'If q.Length = 0 Then
        '    Return "There was no file"
        'End If
        Return "There is a file"

    End Function

    Sub CheckStatus()

        'get assignment count
        Dim positioncount = (From p In db.tblEventStaffingRequirements Where p.eventID = thisEvent.eventID Where p.assigned = True Select p).Count
        Dim assignedcount = (From p In db.tblEventStaffingRequirements Where p.eventID = thisEvent.eventID Select p).Count

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
    'Sub BindPOSKit()

    '    'clear the list
    '    POSItemList.Items.Clear()
    '    noPosItemsLabel.Text = ""

    '    Dim eventType_ID = thisEvent.eventTypeID ' (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.eventTypeID).FirstOrDefault

    '    EventTypeName.Text = String.Format("{0} Kit Avaialable:", (From p In db.tblEventTypes Where p.eventTypeID = eventType_ID Select p.eventTypeName).FirstOrDefault)

    '    'OffPremise
    '    If eventType_ID = 261 Then

    '        Dim c1 = (From p In db.getOffPremisePosItemsByBrand(Request.QueryString("ID")) Select p).Count

    '        If c1 = 0 Then
    '            noPosItemsLabel.Text = Common.ShowAlertNoClose("warning", "There are no POS Kits available")
    '            noPosItemsPanel.Visible = True
    '            POSPanel.Visible = False
    '        End If

    '        Dim r = From p In db.getOffPremisePosItemsByBrand(Request.QueryString("ID")) Select p

    '        For Each p In r
    '            Dim mystring = String.Format("{0} ({1})  {2} ({3})", p.unitsInKit, p.packageSize, p.itemName, p.brandName)

    '            'add to the list
    '            Dim newItem As New RadListBoxItem(mystring, p.itemID)
    '            POSItemList.Items.Add(newItem)
    '        Next

    '    End If

    '    'OnPremise
    '    If eventType_ID = 262 Then
    '        Dim c2 = (From p In db.getOnPremisePosItemsByBrand(Request.QueryString("ID")) Select p).Count

    '        If c2 = 0 Then
    '            noPosItemsLabel.Text = Common.ShowAlertNoClose("warning", "There are no POS Kits available")
    '            noPosItemsPanel.Visible = True
    '            POSPanel.Visible = False
    '        End If

    '        Dim r = From p In db.getOnPremisePosItemsByBrand(Request.QueryString("ID")) Select p

    '        For Each p In r
    '            Dim mystring = String.Format("{0} ({1})  {2} ({3})", p.unitsInKit, p.packageSize, p.itemName, p.brandName)

    '            'add to the list
    '            Dim newItem As New RadListBoxItem(mystring, p.itemID)
    '            POSItemList.Items.Add(newItem)
    '        Next

    '    End If

    '    If Not Page.IsPostBack Then
    '        Try
    '            KitRequested.SelectedValue = thisEvent.posKitRequested
    '        Catch ex As Exception
    '            'don't worry about it, the data was null
    '        End Try

    '        NotesTextBox.Text = thisEvent.posKitShippingNote

    '        Dim q = (From p In db.tblPosKits Where p.eventID = thisEvent.eventID Select p).Count

    '        'there is a pos kit already
    '        If q > 0 Then
    '            btnSavePosKitRequest.Visible = False
    '            noPosItemsLabel.Text = ""
    '            POSKitRequestedLabel.Text = Common.ShowAlertNoClose("success", "A POS Kit has been requested.")
    '            noPosItemsPanel.Visible = True
    '            POSPanel.Visible = False
    '        End If

    '    End If
    'End Sub


    'Sub BindTestsScores()

    '    'Show Test Results
    '    Try

    '        'get the list of ambassadors available
    '        Dim i = From p In db.tblEventStaffingRequirements Where p.eventID = thisEvent.eventID Select p

    '        'there are no assignments so we better leave a friendly message
    '        If i.Count = 0 Then
    '            Dim div As New HtmlGenericControl("div")
    '            Dim lbl1 As New HtmlGenericControl("label")
    '            lbl1.InnerHtml = String.Format("{0}", "There are no ambassadors assigned")
    '            div.Controls.Add(lbl1)

    '            TestScoresPlaceHolder.Controls.Add(div)
    '        End If

    '        'there are assignments
    '        For Each p In i

    '            Dim _userID = (From j In db.tblAmbassadors Where j.userName = p.assignedUserName Select j.userID).FirstOrDefault
    '            Dim _firstName = (From m In db.tblAmbassadors Where m.userID = _userID Select m.FirstName).FirstOrDefault
    '            Dim _lastName = (From m In db.tblAmbassadors Where m.userID = _userID Select m.LastName).FirstOrDefault

    '            If p.assigned = True Then

    '                Dim div As New HtmlGenericControl("div")
    '                Dim lbl1 As New HtmlGenericControl("label")
    '                lbl1.InnerHtml = String.Format("{0} {1}", _firstName, _lastName)
    '                div.Controls.Add(lbl1)

    '                TestScoresPlaceHolder.Controls.Add(div)

    '                'get the brands
    '                Dim _brandID = From a In db.getBrandTrainingGroupByEventIDs Where a.eventID = thisEvent.eventID Select a


    '                For Each a In _brandID

    '                    Dim _curriculum = (From l In lmsdb.Curriculums Where l.CurriculumGroupID = a.courseGroupID Select l).Distinct

    '                    'if there are no Curriculum results
    '                    'If _curriculum.Count = 0 Then
    '                    '    Dim div12 As New HtmlGenericControl("div")
    '                    '    div12.InnerHtml = String.Format("There are no tests online for {0}", "") 'getBrandName(a.brandID)
    '                    '    div12.Attributes.Add("class", "marginbottom10")
    '                    '    div12.Attributes.Add("class", "text-danger")

    '                    '    TestScoresPlaceHolder.Controls.Add(div12)
    '                    'End If

    '                    For Each list In _curriculum

    '                        Dim test = (From u In lmsdb.CurriculumLists Where u.CurriculumID = list.CurriculumID And u.ContentType = 7 Select u).Distinct

    '                        For Each u In test
    '                            Dim type = (From y In lmsdb.CurriculumLists Where y.CurriculumID = list.CurriculumID Select y.ContentType).FirstOrDefault
    '                            Dim _testID = (From b In lmsdb.CurriculumLists Where b.CurriculumID = list.CurriculumID Select b.TestID).FirstOrDefault

    '                            Dim _result = (From t In lmsdb.baretc_TestResults Where t.UserName = p.assignedUserName And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Result).FirstOrDefault
    '                            Dim _score = (From t In lmsdb.baretc_TestResults Where t.UserName = p.assignedUserName And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Score).FirstOrDefault


    '                            Dim testresult As String
    '                            Dim resultlabel As String
    '                            Dim scoreLabel As String

    '                            Select Case _result
    '                                Case "Passed"
    '                                    testresult = "success"
    '                                    resultlabel = "Passed"
    '                                    scoreLabel = String.Format("{0}%", _score)
    '                                Case "Failed"
    '                                    testresult = "danger"
    '                                    resultlabel = "Failed"
    '                                    scoreLabel = String.Format("{0}%", _score)
    '                                Case Else
    '                                    testresult = "warning"
    '                                    resultlabel = "Not Started"
    '                                    scoreLabel = ""
    '                            End Select

    '                            'only show for tests
    '                            Dim wrapper As New HtmlGenericControl("div")
    '                            wrapper.Attributes.Add("class", "row")

    '                            Dim div2 As New HtmlGenericControl("div")
    '                            div2.Attributes.Add("class", "col-sm-12")

    '                            Dim lbl3 As New HtmlGenericControl("div")
    '                            lbl3.InnerHtml = String.Format("{0}", list.CurriculumTitle)
    '                            lbl3.Attributes.Add("class", "leftColumn")
    '                            div2.Controls.Add(lbl3)


    '                            Dim lbl4 As New HtmlGenericControl("div")
    '                            lbl4.InnerHtml = String.Format("<h4><span class='label label-{0}'>{1} {2}</span></h4>", testresult, resultlabel, scoreLabel)
    '                            lbl4.Attributes.Add("class", "pull-right")
    '                            div2.Controls.Add(lbl4)

    '                            wrapper.Controls.Add(div2)

    '                            TestScoresPlaceHolder.Controls.Add(wrapper)

    '                        Next

    '                    Next

    '                Next 'end of brands

    '            End If

    '        Next

    '    Catch ex As Exception

    '    End Try

    'End Sub

    Protected Function CreateWindowScript(ByVal userID As String, ByVal image As Integer) As String
        Return String.Format("var win = window.radopen('/Profile_Image.aspx?image={1}&UserID={0}','Details');win.center();", userID, image)
    End Function

    Protected Function CreateReceiptScript(ByVal eventExpenseID As Integer) As String
        Return String.Format("var win = window.radopen('/Receipt_Image.aspx?eventExpenseID={0}','Details');win.center();", eventExpenseID)
    End Function

    Protected Function CreateWindowScript2(ByVal userID As String) As String

        Return String.Format("var win = window.radopen('/Events/BrandAmbassadorsDetails.aspx?userID={0}', 'null');win.center();win.setSize(1050, 500);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", userID)

    End Function

    'Function getAttireText() As String
    '    Return thisEvent.attire
    'End Function

    Sub bindEvent()

        ' get the logged ambassador
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        'If manager.IsInRole(currentUser.Id, "Student") Then

        '    SelectedAmbassadorPanel.Visible = False
        '    EnterAddressPanel.Visible = True

        '    Dim a = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p).FirstOrDefault
        '    txtFromAddress.Text = String.Format("{0}, {1}, {2} {3}", a.Address1, a.City, a.State, a.Zip)
        'Else
        '    SelectedAmbassadorPanel.Visible = True
        '    EnterAddressPanel.Visible = False

        'End If

        'bind account by locationID
        bindAccount(thisEvent.locationID)

        ' Dim l = getEventLocation(thisEvent.locationID)

        'bind the weather control
        'BindWeatherGrid(getEventLocation(thisEvent.locationID))

        'populate labels
        EventNameLabel.Text = thisEvent.eventTitle
        EventDateLabel.Text = String.Format("{0:D}", thisEvent.eventDate)
        EventIDLabel.Text = thisEvent.eventID
        DateLabel.Text = String.Format("{0:d}", thisEvent.eventDate)

        StartTimeLabel.Text = String.Format("{0:t}", thisEvent.startTime)
        EndTimeLabel.Text = String.Format("{0:t}", thisEvent.endTime)
        HoursLabel.Text = (From p In db.qryViewEvents Where p.eventID = thisEvent.eventID Select p.hours).FirstOrDefault

        'event details
        EventTypeLabel.Text = getEventTypeName(thisEvent.eventTypeID)
        SupplierLabel.Text = getSupplierName(thisEvent.supplierID)
        MarketLabel.Text = getMarketName(thisEvent.marketID)

        StatusLabel.Text = getStatusName(thisEvent.statusID)

        'bind the detail information
        AttireLabel.Text = thisEvent.attire
        POSLabel.Text = thisEvent.posRequirements
        SamplingLabel.Text = thisEvent.samplingNotes
        DescriptionLabel.Text = thisEvent.eventDescription

        'NoteCountLabel.Text = (From p In db.tblEventNotes Where p.eventID = thisEvent.eventID Select p).Count

        'format color for status label
        Dim i = thisEvent.statusID

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
        Dim r = From p In db.getBrandsForEvents Where p.eventID = thisEvent.eventID Select p

        For Each p In r
            BrandsLabel.Text = BrandsLabel.Text & String.Format("<span class='label label-default'>{0}</span>  ", p.brandName)

        Next



    End Sub

    Sub repairBrandRecapQuestions()

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

        'populate labels
        AccountNameLabel1.Text = q.accountName
        LatitudeTextBox.Value = q.latitude
        LongtitudeTextBox.Value = q.longitude
        LocationTextBox.Value = q.city & ", " & q.state
        'CityLabel.Text = q.city & ", " & q.state

        AccountHyperLink1.NavigateUrl = "/Accounts/AccountDetails?AccountID=" & q.accountID

        AccountAddressLabel1.Text = String.Format("{0} {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)
        'PhotoCountLabel.Text = (From p In db.tblPhotos Where p.eventID = thisEvent.eventID Select p).Count

        LocationNameMap.Value = String.Format("{0} {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)

    End Sub

    Function getBrandCourseGroupName(groupID As String) As String
        Return (From p In lmsdb.CurriculumGroups Where p.CurriculumGroupID = groupID Select p.Title).FirstOrDefault

    End Function
    'Sub BindDocuments()

    '    'get brands
    '    Dim r = From p In db.getCourseForEvents Where p.eventID = thisEvent.eventID Select p

    '    For Each p In r

    '        Dim div As New HtmlGenericControl("div")

    '        Dim lbl As New HtmlGenericControl("h3")
    '        lbl.InnerHtml = getBrandCourseGroupName(p.CourseTitle)
    '        div.Controls.Add(lbl)

    '        DocumentsPlaceHolder.Controls.Add(div)

    '        Dim ID = (From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l.CurriculumID).FirstOrDefault
    '        Dim related = (From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l.CurriculumGroupID).FirstOrDefault

    '        Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l

    '        ''there are no documents so we will show a friendly message
    '        'If course.Count = 0 Then

    '        '

    '        '    Exit Sub
    '        ' End If

    '        Dim myFiles = From i In lmsdb.CourseFiles Where i.RelatedID = p.curriculum Select i

    '        If myFiles.Count = 0 Then
    '            Dim divb As New HtmlGenericControl("div")
    '            divb.Attributes.Add("class", "form-group")

    '            Dim lblb As New HtmlGenericControl("label")
    '            lblb.InnerHtml = "There are no documents currently available"
    '            divb.Controls.Add(lblb)

    '            DocumentsPlaceHolder.Controls.Add(divb)
    '        Else
    '            Dim type = (From u In lmsdb.CurriculumLists Where u.CurriculumID = ID Select u.ContentType).FirstOrDefault
    '            Dim _testID = (From u In lmsdb.CurriculumLists Where u.CurriculumID = ID Select u.TestID).FirstOrDefault

    '            Dim icon As String = ""

    '            For Each i In myFiles
    '                Dim div1 As New HtmlGenericControl("div")

    '                icon = "<i class='fa fa-file-pdf-o' aria-hidden='True'></i>"

    '                Dim lbl1 As New HtmlGenericControl("div")
    '                lbl1.Attributes.Add("class", "leftColumn")
    '                lbl1.InnerHtml = icon
    '                div1.Controls.Add(lbl1)

    '                ' Create a text box control
    '                Dim box As New HyperLink
    '                box.CssClass = "pointer"
    '                box.NavigateUrl = "/filehandler?ID=" & i.FileID
    '                box.Text = String.Format("{0}", getFileName(i.FileID))
    '                div1.Controls.Add(box)
    '                div.Controls.Add(div1)

    '                DocumentsPlaceHolder.Controls.Add(div1)
    '            Next
    '        End If



    '    Next

    'End Sub

    Function getFileName(fileID As String) As String
        Return (From p In lmsdb.Files Where p.ID = fileID Select p.FileName).FirstOrDefault
    End Function

    'Sub BindCourses()

    '    'get brands
    '    Dim r = From p In db.getCourseForEvents Where p.eventID = thisEvent.eventID Select p

    '    For Each p In r

    '        Dim div As New HtmlGenericControl("div")

    '        Dim lbl As New HtmlGenericControl("h3")
    '        lbl.InnerHtml = getBrandCourseGroupName(p.CourseTitle)
    '        div.Controls.Add(lbl)

    '        CoursesPlaceHolder.Controls.Add(div)

    '        'get the curriculium id
    '        '  Dim curriculum = (From i In db.tblBrands Where i.brandID = p.brandID Select i.courseGroupID).FirstOrDefault

    '        Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Order By l.SortOrder Select l

    '        If course.Count = 0 Then

    '            Dim divb As New HtmlGenericControl("div")
    '            divb.Attributes.Add("class", "form-group")

    '            Dim lblb As New HtmlGenericControl("label")
    '            lblb.InnerHtml = "There are no courses currently available"
    '            divb.Controls.Add(lblb)

    '            CoursesPlaceHolder.Controls.Add(divb)
    '        Else
    '            For Each l In course
    '                Dim div1 As New HtmlGenericControl("div")

    '                Dim type = (From u In lmsdb.CurriculumLists Where u.CurriculumID = l.CurriculumID Select u.ContentType).FirstOrDefault
    '                Dim _testID = (From u In lmsdb.CurriculumLists Where u.CurriculumID = l.CurriculumID Select u.TestID).FirstOrDefault

    '                Dim icon As String = ""

    '                Select Case type
    '                    Case "1"
    '                        icon = "<i class='fa fa-file-text-o' aria-hidden='True'></i>"

    '                        Dim lbl1 As New HtmlGenericControl("div")
    '                        lbl1.Attributes.Add("class", "leftColumn")
    '                        lbl1.InnerHtml = icon
    '                        div1.Controls.Add(lbl1)

    '                        ' Create a text box control
    '                        Dim box As New HyperLink
    '                        box.CssClass = "pointer"

    '                        ' if student then
    '                        Dim manager = New UserManager()
    '                        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '                        If manager.IsInRole(currentUser.Id, "Student") Then
    '                            box.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", l.CurriculumID)

    '                        Else
    '                            box.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", l.CurriculumID)
    '                        End If

    '                        box.Text = String.Format("{0}", l.CurriculumTitle)
    '                        div1.Controls.Add(box)
    '                        div.Controls.Add(div1)

    '                        CoursesPlaceHolder.Controls.Add(div1)

    '                    Case "2"
    '                        icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

    '                        Dim lbl1 As New HtmlGenericControl("div")
    '                        lbl1.Attributes.Add("class", "leftColumn")
    '                        lbl1.InnerHtml = icon
    '                        div1.Controls.Add(lbl1)

    '                        ' Create a text box control
    '                        Dim box As New HyperLink
    '                        box.CssClass = "pointer"

    '                        ' if student then
    '                        Dim manager = New UserManager()
    '                        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '                        If manager.IsInRole(currentUser.Id, "Student") Then
    '                            box.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", l.CurriculumID)

    '                        Else
    '                            box.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", l.CurriculumID)
    '                        End If


    '                        box.Text = String.Format("{0}", l.CurriculumTitle)
    '                        div1.Controls.Add(box)
    '                        div.Controls.Add(div1)

    '                        CoursesPlaceHolder.Controls.Add(div1)

    '                    Case "3"
    '                        icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

    '                        Dim lbl1 As New HtmlGenericControl("div")
    '                        lbl1.Attributes.Add("class", "leftColumn")
    '                        lbl1.InnerHtml = icon
    '                        div1.Controls.Add(lbl1)

    '                        ' Create a text box control
    '                        Dim box As New HyperLink
    '                        box.CssClass = "pointer"

    '                        ' if student then
    '                        Dim manager = New UserManager()
    '                        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '                        If manager.IsInRole(currentUser.Id, "Student") Then
    '                            box.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", l.CurriculumID)

    '                        Else
    '                            box.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", l.CurriculumID)
    '                        End If

    '                        box.Text = String.Format("{0}", l.CurriculumTitle)
    '                        div1.Controls.Add(box)
    '                        div.Controls.Add(div1)

    '                        CoursesPlaceHolder.Controls.Add(div1)

    '                    Case "4"
    '                        icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

    '                        Dim lbl1 As New HtmlGenericControl("div")
    '                        lbl1.Attributes.Add("class", "leftColumn")
    '                        lbl1.InnerHtml = icon
    '                        div1.Controls.Add(lbl1)

    '                        ' Create a text box control
    '                        Dim box As New HyperLink
    '                        box.CssClass = "pointer"

    '                        ' if student then
    '                        Dim manager = New UserManager()
    '                        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '                        If manager.IsInRole(currentUser.Id, "Student") Then
    '                            box.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", l.CurriculumID)

    '                        Else
    '                            box.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", l.CurriculumID)
    '                        End If


    '                        box.Text = String.Format("{0}", l.CurriculumTitle)
    '                        div1.Controls.Add(box)
    '                        div.Controls.Add(div1)

    '                        CoursesPlaceHolder.Controls.Add(div1)

    '                    Case "5"
    '                        icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

    '                        Dim lbl1 As New HtmlGenericControl("div")
    '                        lbl1.Attributes.Add("class", "leftColumn")
    '                        lbl1.InnerHtml = icon
    '                        div1.Controls.Add(lbl1)

    '                        ' Create a text box control
    '                        Dim box As New HyperLink
    '                        box.CssClass = "pointer"

    '                        ' if student then
    '                        Dim manager = New UserManager()
    '                        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '                        If manager.IsInRole(currentUser.Id, "Student") Then
    '                            box.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", l.CurriculumID)

    '                        Else
    '                            box.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", l.CurriculumID)
    '                        End If

    '                        box.Text = String.Format("{0}", l.CurriculumTitle)
    '                        div1.Controls.Add(box)
    '                        div.Controls.Add(div1)

    '                        CoursesPlaceHolder.Controls.Add(div1)

    '                    Case "6"
    '                        icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

    '                        Dim lbl1 As New HtmlGenericControl("div")
    '                        lbl1.Attributes.Add("class", "leftColumn")
    '                        lbl1.InnerHtml = icon
    '                        div1.Controls.Add(lbl1)

    '                        ' Create a text box control
    '                        Dim box As New HyperLink
    '                        box.CssClass = "pointer"

    '                        ' if student then
    '                        Dim manager = New UserManager()
    '                        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '                        If manager.IsInRole(currentUser.Id, "Student") Then
    '                            box.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", l.CurriculumID)

    '                        Else
    '                            box.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewCurriculum.aspx?ID={0}&p=1', 'null');win.center();win.setSize(700, 750);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", l.CurriculumID)
    '                        End If

    '                        box.Text = String.Format("{0}", l.CurriculumTitle)
    '                        div1.Controls.Add(box)
    '                        div.Controls.Add(div1)

    '                        CoursesPlaceHolder.Controls.Add(div1)

    '                    Case "7"
    '                        icon = "<i class='fa fa-check-square-o' aria-hidden='true'></i>"

    '                        Dim lbl1 As New HtmlGenericControl("div")
    '                        lbl1.Attributes.Add("class", "leftColumn")
    '                        lbl1.InnerHtml = icon
    '                        div1.Controls.Add(lbl1)

    '                        ' Create a text box control
    '                        Dim box As New HyperLink
    '                        box.CssClass = "pointer"

    '                        ' if student then
    '                        Dim manager = New UserManager()
    '                        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '                        If manager.IsInRole(currentUser.Id, "Student") Then
    '                            box.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", l.CurriculumID)

    '                        Else
    '                            box.Attributes("onclick") = String.Format("var win = window.radopen('/Training/ViewTestQuestions.aspx?TestID={0}', 'null');win.center();win.setSize(700, 700);win.set_status=' ';win.SetModal(true);win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);", _testID)
    '                        End If

    '                        box.Text = String.Format("{0}", l.CurriculumTitle)
    '                        div1.Controls.Add(box)
    '                        div.Controls.Add(div1)

    '                        CoursesPlaceHolder.Controls.Add(div1)
    '                End Select

    '            Next

    '        End If

    '    Next

    'End Sub


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
    'Sub BindWeatherGrid(location As String)

    '    Dim hasWeather As Integer = (From p In db.tblEventWeathers Where p.eventID = thisEvent.eventID Select p).Count

    '    If hasWeather = 0 Then
    '        'show the current weather from api
    '        Try
    '            WeatherForcastPanel.Visible = True
    '            WeatherHistoryPanel.Visible = False

    '            Dim appId As String = "a77cf9b3936cbf96fecb944778c5718c"
    '            Dim url As String = String.Format("http://api.openweathermap.org/data/2.5/forecast/daily?q={0}&units=imperial&cnt=3&APPID={1}", location, appId)
    '            Using client As New WebClient()
    '                Dim json As String = client.DownloadString(url)

    '                Dim weatherInfo As WeatherInfo = (New JavaScriptSerializer()).Deserialize(Of WeatherInfo)(json)
    '                lblMain0.Text = weatherInfo.list(0).weather(0).main
    '                lblMain1.Text = weatherInfo.list(1).weather(0).main
    '                lblMain2.Text = weatherInfo.list(2).weather(0).main

    '                imgWeatherIcon0.ImageUrl = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(0).weather(0).icon)
    '                imgWeatherIcon1.ImageUrl = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(1).weather(0).icon)
    '                imgWeatherIcon2.ImageUrl = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(2).weather(0).icon)

    '                lblTempMin0.Text = String.Format("{0}°F", Math.Round(weatherInfo.list(0).temp.min, 1))
    '                lblTempMin1.Text = String.Format("{0}°F", Math.Round(weatherInfo.list(1).temp.min, 1))
    '                lblTempMin2.Text = String.Format("{0}°F", Math.Round(weatherInfo.list(2).temp.min, 1))

    '                lblTempMax0.Text = String.Format("{0}°F", Math.Round(weatherInfo.list(0).temp.max, 1))
    '                lblTempMax1.Text = String.Format("{0}°F", Math.Round(weatherInfo.list(1).temp.max, 1))
    '                lblTempMax2.Text = String.Format("{0}°F", Math.Round(weatherInfo.list(2).temp.max, 1))

    '            End Using
    '        Catch ex As Exception

    '        End Try

    '    Else
    '        'show the weather from history
    '        WeatherForcastPanel.Visible = False
    '        WeatherHistoryPanel.Visible = True
    '        InsertWeatherPanel.Visible = False

    '        Dim myWeather = (From p In db.tblEventWeathers Where p.eventID = thisEvent.eventID Select p).FirstOrDefault

    '        Dim d As Date = myWeather.weatherDate

    '        Dim m = d.Month


    '        Label3.Text = d.Day
    '        Label4.Text = d.ToString("MMM")


    '        lblTempMin3.Text = myWeather.lowTemp
    '        lblTempMax3.Text = myWeather.highTemp
    '        Condition9.Text = myWeather.condition
    '        Image1.ImageUrl = String.Format("http://openweathermap.org/img/w/{0}", myWeather.icon)
    '    End If




    'End Sub

    'Private Sub btnSubmitWeather_Click(sender As Object, e As EventArgs) Handles btnSubmitWeather.Click

    '    Dim location = getEventLocation(thisEvent.locationID)
    '    Dim d = thisEvent.eventDate

    '    Dim w As New tblEventWeather With {.weatherDate = d, .cityName = location, .eventID = thisEvent.eventID, .lowTemp = lowTempTextBox.Text, .highTemp = highTempTextBox.Text, .condition = conditionList.SelectedItem.Text, .icon = conditionList.SelectedValue}

    '    db.tblEventWeathers.InsertOnSubmit(w)
    '    db.SubmitChanges()


    'End Sub

    'create the recap pdf
    'Private Sub btnCreatePDF_Click(sender As Object, e As EventArgs) Handles btnCreatePDF.Click

    '    Try
    '        Dim eventID = thisEvent.eventID

    '        'create pdf
    '        Dim docName As String = "EventDetails_" & eventID & ".pdf"

    '        Dim mySavedPDF As New iTextSharp.text.Document()

    '        Dim fs As New FileStream(Server.MapPath("/Documents/" & docName), FileMode.Create)

    '        Dim bfTimes As iTextSharp.text.pdf.BaseFont = iTextSharp.text.pdf.BaseFont.CreateFont(iTextSharp.text.pdf.BaseFont.HELVETICA, iTextSharp.text.pdf.BaseFont.CP1252, False)

    '        Dim mainFont As New iTextSharp.text.Font(bfTimes, 9, iTextSharp.text.Font.NORMAL)
    '        Dim boldFont As New iTextSharp.text.Font(bfTimes, 9, iTextSharp.text.Font.BOLD)


    '        iTextSharp.text.pdf.PdfWriter.GetInstance(mySavedPDF, fs)

    '        mySavedPDF.Open()


    '        Dim header As New Paragraph()
    '        header.Alignment = Element.ALIGN_LEFT
    '        header.SpacingBefore = 10.0F
    '        header.Add(New Chunk("Event Details", New iTextSharp.text.Font(bfTimes, 13.0, iTextSharp.text.Font.BOLD)))

    '        Dim header2 As New Paragraph()
    '        header2.Alignment = Element.ALIGN_LEFT
    '        header2.SpacingBefore = 10.0F
    '        header2.Add(New Chunk("Venue Details", New iTextSharp.text.Font(bfTimes, 13.0, iTextSharp.text.Font.BOLD)))

    '        Dim header3 As New Paragraph()
    '        header3.Alignment = Element.ALIGN_LEFT
    '        header3.SpacingBefore = 10.0F
    '        header3.Add(New Chunk("Recap Questions", New iTextSharp.text.Font(bfTimes, 13.0, iTextSharp.text.Font.BOLD)))


    '        'start event detail table
    '        Dim eventdetail_table As New iTextSharp.text.pdf.PdfPTable(2)
    '        eventdetail_table.TotalWidth = 500.0F
    '        eventdetail_table.LockedWidth = True
    '        eventdetail_table.SpacingBefore = 24.0F


    '        Dim columnWidths1 As Single() = {170.0F, 300.0F}
    '        eventdetail_table.SetWidths(columnWidths1)

    '        eventdetail_table.DefaultCell.Padding = 5
    '        eventdetail_table.DefaultCell.Colspan = 1
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase("Event Name", boldFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase(EventNameLabel.Text, mainFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase("Date", boldFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase(DateLabel.Text, mainFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase("Time", boldFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase(StartTimeLabel.Text & " " & "-" & " " & EndTimeLabel.Text, mainFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase("Current Status", boldFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase(StatusLabel.Text, mainFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase("Event Type", boldFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase(EventTypeLabel.Text, mainFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase("Brands", boldFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase((From p In db.qryViewEvents Where p.eventID = eventID Select p.brands).FirstOrDefault, mainFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase("Attire", boldFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase(Regex.Replace(AttireLabel.Text, "<.*?>", String.Empty), mainFont))

    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase("POS", boldFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase(Regex.Replace(POSLabel.Text, "<.*?>", String.Empty), mainFont))

    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase("Sampling Notes", boldFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase(Regex.Replace(SamplingLabel.Text, "<.*?>", String.Empty), mainFont))


    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase("Event Details", boldFont))
    '        eventdetail_table.AddCell(New iTextSharp.text.Phrase(Regex.Replace(DescriptionLabel.Text, "<.*?>", String.Empty), mainFont))

    '        'start venue details
    '        Dim venuedetail_table As New iTextSharp.text.pdf.PdfPTable(2)
    '        venuedetail_table.TotalWidth = 500.0F
    '        venuedetail_table.LockedWidth = True
    '        venuedetail_table.SpacingBefore = 24.0F

    '        Dim columnWidths3 As Single() = {170.0F, 300.0F}
    '        venuedetail_table.SetWidths(columnWidths3)

    '        venuedetail_table.DefaultCell.Padding = 5
    '        venuedetail_table.DefaultCell.Colspan = 1
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase("Account Name", boldFont))
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase(AccountNameLabel1.Text, mainFont))
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase("Address", boldFont))
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase(AccountAddressLabel1.Text, mainFont))
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase("Market", boldFont))
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase(MarketLabel.Text, mainFont))
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase("Contact Name", boldFont))
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase("", mainFont))
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase("Contact Phone", boldFont))
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase("", mainFont))
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase("Contact Email", boldFont))
    '        venuedetail_table.AddCell(New iTextSharp.text.Phrase("", mainFont))



    '        'start recap table
    '        Dim recap_table As New iTextSharp.text.pdf.PdfPTable(2)
    '        recap_table.TotalWidth = 500.0F
    '        recap_table.LockedWidth = True
    '        recap_table.SpacingBefore = 24.0F
    '        recap_table.SplitLate = False
    '        recap_table.KeepTogether = True

    '        Dim columnWidths2 As Single() = {250.0F, 250.0F}
    '        recap_table.SetWidths(columnWidths2)


    '        Dim brand = From b In db.tblBrandInEvents Where b.eventID = eventID
    '        For Each b In brand

    '            Dim cella As New PdfPCell(New iTextSharp.text.Phrase(getBrandName(b.brandID) & " Brand Recap", boldFont))
    '            cella.Padding = 5
    '            cella.Colspan = 1
    '            recap_table.AddCell(cella)


    '            Dim cellb As New PdfPCell(New iTextSharp.text.Phrase(""))
    '            cellb.Padding = 5
    '            cellb.Colspan = 1
    '            recap_table.AddCell(cellb)

    '            Dim recap = From p In db.tblEventRecapQuestions Where p.eventID = eventID And p.brandID = b.brandID Select p Order By p.eventRecapQuestionID

    '            For Each p In recap
    '                Dim cellc As New PdfPCell(New iTextSharp.text.Phrase(p.question, mainFont))
    '                cellc.Padding = 5
    '                cellc.Colspan = 1
    '                recap_table.AddCell(cellc)

    '                Dim celld As New PdfPCell(New iTextSharp.text.Phrase(p.answer, mainFont))
    '                celld.Padding = 5
    '                celld.Colspan = 1
    '                recap_table.AddCell(celld)
    '            Next

    '        Next

    '        Dim celle As New PdfPCell(New iTextSharp.text.Phrase(EventTypeLabel.Text & " Event Details", boldFont))
    '        celle.Padding = 5
    '        celle.Colspan = 1
    '        recap_table.AddCell(celle)

    '        Dim cellf As New PdfPCell(New iTextSharp.text.Phrase(""))
    '        cellf.Padding = 5
    '        cellf.Colspan = 1
    '        recap_table.AddCell(cellf)

    '        Dim recap2 = From p In db.tblEventRecapQuestions Where p.eventID = eventID And p.brandID Is Nothing Select p Order By p.eventRecapQuestionID

    '        For Each p In recap2
    '            Dim cellg As New PdfPCell(New iTextSharp.text.Phrase(p.question, mainFont))
    '            cellg.Padding = 5
    '            cellg.Colspan = 1
    '            recap_table.AddCell(cellg)

    '            Dim cellh As New PdfPCell(New iTextSharp.text.Phrase(p.answer, mainFont))
    '            cellh.Padding = 5
    '            cellh.Colspan = 1
    '            recap_table.AddCell(cellh)
    '        Next

    '        Dim url As String = "http://events.gigengyn.com/documents/images/baretc.gif"
    '        Dim gif As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(New Uri(url))
    '        gif.Alignment = iTextSharp.text.Image.ALIGN_LEFT
    '        gif.ScalePercent(40.0F)
    '        mySavedPDF.Add(gif)

    '        mySavedPDF.Add(header)
    '        mySavedPDF.Add(eventdetail_table)
    '        mySavedPDF.Add(header2)
    '        mySavedPDF.Add(venuedetail_table)
    '        mySavedPDF.NewPage()
    '        mySavedPDF.Add(header3)
    '        mySavedPDF.Add(recap_table)

    '        mySavedPDF.Close()


    '        Response.Buffer = False
    '        'transmit file self buffers
    '        Response.Clear()
    '        Response.ClearContent()
    '        Response.ClearHeaders()
    '        Response.ContentType = "application/pdf"
    '        Response.AddHeader("Content-Disposition", "attachment; filename=" & docName)
    '        Response.TransmitFile(Server.MapPath("/Documents/" & docName))
    '        Response.[End]()

    '    Catch ex As Exception
    '        msgLabel2.Text = ex.Message
    '    End Try


    'End Sub

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


    'Private Sub btnCreateRecap_Click(sender As Object, e As EventArgs) Handles btnCreateRecap.Click

    '    Dim order As Integer = 0
    '    Dim eventID = thisEvent.eventID

    '    'first delete any recap questions that might exist
    '    db.DeleteAllEventRecapQuestions(eventID)


    '    'create the recap questions
    '    'get the selected brands

    '    Dim brandlist = From y In db.tblBrandInEvents Where y.eventID = thisEvent.eventID Select y
    '    For Each y In brandlist

    '        ' get the default recap quetions for each brand
    '        Dim a = From p In db.tblDefaultRecapQuestions Select p Order By p.QuestionID
    '        For Each p In a

    '            Dim recap0 As New tblEventRecapQuestion
    '            recap0.eventID = eventID
    '            recap0.brandID = y.brandID
    '            Dim q1 As String = Replace(p.Question, "[BrandName]", getBrandName(y.brandID))
    '            recap0.question = Replace(q1, "[PPS]", getPPS(y.brandID))
    '            recap0.questionType = p.QuestionType
    '            recap0.recapID = 0
    '            recap0.recapQuestionID = p.QuestionID
    '            recap0.sortorder = order + 1

    '            db.tblEventRecapQuestions.InsertOnSubmit(recap0)
    '            db.SubmitChanges()

    '        Next

    '        ' get the custom brand questions for each brand
    '        Dim r = From p In db.tblBrandRecapQuestions Where p.brandID = y.brandID
    '        For Each p In r

    '            Dim recap1 As New tblEventRecapQuestion
    '            recap1.eventID = eventID
    '            recap1.brandID = y.brandID
    '            recap1.question = p.question
    '            recap1.questionType = p.questionType
    '            recap1.recapID = 1
    '            recap1.recapQuestionID = p.brandRecapQuestionID
    '            recap1.sortorder = order + 1

    '            db.tblEventRecapQuestions.InsertOnSubmit(recap1)
    '            db.SubmitChanges()
    '        Next

    '    Next

    '    'end the loop through the brands

    '    'get the eventtype
    '    Dim typeid = thisEvent.eventTypeID   ' (From p In db.tblEvents Where p.eventID = eventID Select p.eventTypeID).FirstOrDefault

    '    'add eventtype recap questions
    '    Dim i = From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = typeid Select p
    '    For Each p In i
    '        Dim recap3 As New tblEventRecapQuestion
    '        recap3.eventID = eventID
    '        recap3.question = p.question
    '        recap3.questionType = p.questionType
    '        recap3.recapID = 2
    '        recap3.recapQuestionID = p.eventTypeRecapQuestionID
    '        recap3.sortorder = order + 1

    '        db.tblEventRecapQuestions.InsertOnSubmit(recap3)
    '        db.SubmitChanges()
    '    Next


    '    Response.Redirect("/Events/EditRecap?action=new&EventID=" & thisEvent.eventID)

    'End Sub

    'position funtions
    'Sub BindPositionCount()

    '    positionsStaffedCountLabel.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = thisEvent.eventID And p.assigned = True Select p).Count
    '    positionsAvailableCountLabel.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = thisEvent.eventID And p.assigned = False Select p).Count

    '    positionsStaffedCountLabel2.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = thisEvent.eventID And p.assigned = True Select p).Count
    '    positionsAvailableCountLabel2.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = thisEvent.eventID And p.assigned = False Select p).Count

    '    positionsStaffedCountLabel3.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = thisEvent.eventID And p.assigned = True Select p).Count
    '    positionsAvailableCountLabel3.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = thisEvent.eventID And p.assigned = False Select p).Count

    '    HF_PositionID.Value = (From p In db.tblEventStaffingRequirements Where p.eventID = thisEvent.eventID Select p.positionID).FirstOrDefault

    'End Sub

    'Protected Sub AvailableAmbassadorList_ItemDrop(ByVal sender As Object, ByVal e As RadListViewItemDragDropEventArgs) Handles AvailableAmbassadorList.ItemDrop

    '    'If e.DestinationHtmlElement.IndexOf("GenreLink") < 0 Then

    '    '    Return

    '    'End If
    '    Try
    '        For Each item As RepeaterItem In PositionList.Items

    '            Dim genreLink As LinkButton = TryCast(item.FindControl("GenreLink"), LinkButton)
    '            If genreLink IsNot Nothing AndAlso genreLink.ClientID = e.DestinationHtmlElement Then


    '                Dim userId As String = DirectCast(e.DraggedItem.GetDataKeyValue("userName"), String)
    '                Dim title As String = e.DraggedItem.GetDataKeyValue("FirstName").ToString()
    '                Dim requirementID As String = genreLink.CommandArgument

    '                ResultsPanel.Controls.Add(New LiteralControl([String].Format("<div class='msg'><b>{0}</b> was assigned to the event.</div>", getFullName(userId))))

    '                Dim paymentdate As DateTime = (From p In db.qryEventStaffingRequirements Where p.RequirementID = requirementID Select p.startTime).FirstOrDefault
    '                Dim a = db.AssignStafftoEvent(requirementID, userId, paymentdate)

    '                ' add to the log file
    '                Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Ambassador Assigned", getFullName(userId) & " was assigned to the event.", Context.User.Identity.GetUserId(), Date.Now())

    '                'update the event
    '                thisEvent.ModifiedDate = Date.Now()
    '                db.SubmitChanges()

    '                Exit For
    '            End If

    '        Next

    '        'rebind data
    '        rebindData()

    '    Catch ex As Exception
    '        trackErrorLabel.Text = ex.Message
    '    End Try

    'End Sub

    Sub rebindData()

        StaffingList.DataBind()
        'BindPositionCount()
        'AvailableAmbassadorList.DataBind()
        'PositionList.DataBind()
        'BrandPositionList.DataBind()

        Staffing()
        '  BindCourses()
        '  BindTestsScores()
        '   BindPOSKit()
        ' BindDocuments()
        '  PayrollList.DataBind()
        '   ExpenseList.DataBind()


    End Sub

    'Private Sub LookupAmbassadorText_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles LookupAmbassadorText.SelectedIndexChanged
    '    AvailableAmbassadorList.CurrentPageIndex = 0
    '    AvailableAmbassadorList.FilterExpressions.Clear()
    '    AvailableAmbassadorList.FilterExpressions.BuildExpression().Contains("userName", LookupAmbassadorText.SelectedValue).Build()
    '    AvailableAmbassadorList.Rebind()
    'End Sub


    'Private Sub btnSearchAmbassador_Click(sender As Object, e As EventArgs) Handles btnSearchAmbassador.Click

    '    AvailableAmbassadorList.CurrentPageIndex = 0
    '    AvailableAmbassadorList.FilterExpressions.Clear()
    '    AvailableAmbassadorList.FilterExpressions.BuildExpression().Contains("userName", LookupAmbassadorText.SelectedValue).Build()
    '    AvailableAmbassadorList.Rebind()

    'End Sub

    'Private Sub btnClearFiltersAmbassador_Click(sender As Object, e As EventArgs) Handles btnClearFiltersAmbassador.Click

    '    AvailableAmbassadorList.CurrentPageIndex = 0
    '    AvailableAmbassadorList.FilterExpressions.Clear()
    '    LookupAmbassadorText.SelectedIndex = -1
    '    AvailableAmbassadorList.Rebind()

    'End Sub

    Sub Staffing()
        'show/hide admin panels
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        'If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Then
        '    assignTab.Visible = False
        '    requirementsTab.Visible = False
        '    payrollTab.Visible = False
        'End If

        'bind positions available
        If Not Page.IsPostBack Then
            'BindPositionCount()
        End If

        Dim account = thisEvent.locationID

        'HF_Latitude.Value = (From p In db.tblAccounts Where p.Vpid = account Select p.latitude).FirstOrDefault
        'HF_Longtitude.Value = (From p In db.tblAccounts Where p.Vpid = account Select p.longitude).FirstOrDefault

        StartTimeLabel.Text = String.Format("{0:t}", thisEvent.startTime)
        EndTimeLabel.Text = String.Format("{0:t}", thisEvent.endTime)
        EventDateLabel.Text = String.Format("{0:D}", thisEvent.eventDate)
        Try

            'HF_MarketID.Value = thisEvent.marketID

            'TotalSpendLabel.Text = String.Format("${0}", (From p In db.qryEventStaffingRequirementLists Where p.eventID = thisEvent.eventID Select p.Total).Sum)

            'Dim dv As System.Data.DataView = DirectCast(getAvailableAmbassadorList.[Select](DataSourceSelectArguments.Empty), DataView)
            'StaffCountLabel.Text = dv.Count.ToString()
        Catch ex As Exception

        End Try

        ' SelectedDirectionsName

        Dim hasAmbassadorAssigned As Integer = db.ViewPayrollSummaryByEvent(thisEvent.eventID).Count

        'If hasAmbassadorAssigned = 0 Then
        '    ExpensePanel.Visible = False
        'End If
    End Sub

    'Private Sub getEventPositions_Deleted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getEventPositions.Deleted
    '    rebindData()

    'End Sub

    'Private Sub getEventPositions_Inserted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getEventPositions.Inserted
    '    Dim newPosition As tblEventStaffingRequirement
    '    newPosition = CType(e.Result, tblEventStaffingRequirement)

    '    Dim positionName = (From p In db.tblStaffingPositions Where p.staffingPositionID = newPosition.positionID Select p.positionTitle).FirstOrDefault

    '    Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Staffing Inserted", positionName & " was added to the event staffing requirements.", Context.User.Identity.GetUserId(), Date.Now())

    '    'HF_PositionID.Value = newPosition.positionID

    '    rebindData()

    'End Sub

    'Private Sub getEventPositions_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getEventPositions.Inserting

    '    Try
    '        Dim l As tblEventStaffingRequirement
    '        l = CType(e.NewObject, tblEventStaffingRequirement)
    '        l.eventID = Request.QueryString("ID")
    '        l.assigned = False
    '        l.rate = (From p In db.tblStaffingPositions Where p.staffingPositionID = l.positionID Select p.payRate).FirstOrDefault
    '        l.billingRate = (From p In db.tblStaffingPositions Where p.staffingPositionID = l.positionID Select p.billingRate).FirstOrDefault


    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try

    'End Sub

    'Private Sub btnSaveChanges_Click(sender As Object, e As EventArgs) Handles btnSaveChanges.Click

    '    msgLabel1.Text = Common.ShowAlert("success", "Change button clicked")

    '    Try
    '        Dim startTime As New RadDateTimePicker()
    '        Dim endTime As New RadDateTimePicker()
    '        Dim rate As New RadNumericTextBox()
    '        Dim HiddenField1 As New HiddenField

    '        Dim _eventDate As Date = thisEvent.eventDate

    '        Dim da = String.Format("{0}/{1}/{2} ", _eventDate.Month, _eventDate.Day, _eventDate.Year)

    '        For Each dataItem As RepeaterItem In PositionList.Items

    '            startTime = DirectCast(dataItem.FindControl("startTimeRadTimePicker"), RadDateTimePicker)
    '            endTime = DirectCast(dataItem.FindControl("endTimeRadTimePicker"), RadDateTimePicker)
    '            rate = DirectCast(dataItem.FindControl("RateTextBox"), RadNumericTextBox)
    '            HiddenField1 = DirectCast(dataItem.FindControl("HiddenField1"), HiddenField)

    '            Dim s As Date = endTime.SelectedDate
    '            Dim s1 As Date = startTime.SelectedDate

    '            Dim formatedEndDate = String.Format("{0} {1}:{2}", da, s.Hour, s.Minute)
    '            Dim formateStartDate = String.Format("{0} {1}:{2}", da, s1.Hour, s1.Minute)

    '            Dim d = db.UpdateEventStaffRequirement(HiddenField1.Value, startTime.SelectedDate, endTime.SelectedDate, rate.Text)
    '        Next

    '        msgLabel1.Text = Common.ShowAlert("success", "Changes saved successfully")

    '        PositionList.DataBind()

    '        TotalSpendLabel.Text = String.Format("${0}", (From p In db.qryEventStaffingRequirementLists Where p.eventID = thisEvent.eventID Select p.Total).Sum)

    '    Catch ex As Exception
    '        msgLabel1.Text = ex.Message
    '    End Try

    'End Sub

    'Protected Sub cmbPageSize_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)

    '    AvailableAmbassadorList.PageSize = Integer.Parse(e.Value)
    '    AvailableAmbassadorList.CurrentPageIndex = 0
    '    AvailableAmbassadorList.Rebind()

    'End Sub

    'Private Sub PositionList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles PositionList.ItemCommand

    '    Dim id As Integer = e.CommandArgument

    '    If e.CommandName = "Remove" Then

    '        Dim q = db.RemoveStaffFromEvent(id)

    '        rebindData()
    '    End If
    'End Sub

    'Shared Functions

    Function getFullName(username As String) As String
        If username = "Not Staffed" Then
            Return "<span class='label label-danger'>Not Staffed</span>"
        Else
            Dim userid = (From p In users.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault

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

    'Private Sub BrandPositionList_ItemCreated(sender As Object, e As RadListViewItemEventArgs) Handles BrandPositionList.ItemCreated
    '    If TypeOf e.Item Is RadListViewInsertItem AndAlso e.Item.IsInEditMode Then

    '        'get the event start and finish times
    '        Dim id As Integer = Request.QueryString("ID")

    '        Dim i = (From p In db.tblEvents Where p.eventID = id Select p).FirstOrDefault
    '        Dim _startTime As Date = i.startTime
    '        Dim _endTime As Date = i.endTime

    '        Dim RadTimePicker12 As RadDateTimePicker = TryCast(e.Item.FindControl("RadTimePicker12"), RadDateTimePicker)
    '        Dim RadTimePicker22 As RadDateTimePicker = TryCast(e.Item.FindControl("RadTimePicker22"), RadDateTimePicker)

    '        RadTimePicker12.DbSelectedDate = _startTime
    '        RadTimePicker22.DbSelectedDate = _endTime


    '    End If
    'End Sub

    'Private Sub InvitationButton_Click(sender As Object, e As EventArgs) Handles InvitationButton.Click
    '    CoursesPlaceHolder.Visible = False
    '    InvitationButton.Visible = False
    '    InvitationPanel.Visible = True
    'End Sub

    'Private Sub btnSubmitInvitation_Click(sender As Object, e As EventArgs) Handles btnSubmitInvitation.Click
    '    Dim token As String = System.Guid.NewGuid().ToString()
    '    'add to table
    '    Dim i As New tblEventTrainingInvitation With {.eventID = thisEvent.eventID, .dateSent = Date.Now(), .emailAddress = InvitationEmailTextBox.Text, .token = token}
    '    db.tblEventTrainingInvitations.InsertOnSubmit(i)
    '    db.SubmitChanges()

    '    'send invitation email
    '    Try

    '        'get my html file
    '        Dim reader As New StreamReader(Server.MapPath("~/Files/TrainingInvitation.html"))
    '        Dim readFile As String = reader.ReadToEnd()
    '        Dim myString As String = ""
    '        myString = readFile
    '        myString = myString.Replace("$$token$$", token)
    '        ' myString = myString.Replace("$$password$$", password)

    '        Dim recipient = InvitationEmailTextBox.Text

    '        'send email
    '        MailHelper.SendMailMessage(recipient, "Training Invitation", myString)

    '        msgTrainingLabel.Text = Common.ShowAlertNoClose("success", "Your invitation has been sent to the email you provided.")
    '        InvitationEmailTextBox.Text = ""

    '        reader.Close()

    '    Catch ex As Exception
    '        msgTrainingLabel.Text = Common.ShowAlertNoClose("danger", ex.Message)
    '    End Try



    '    'refresh view
    '    CoursesPlaceHolder.Visible = True
    '    InvitationButton.Visible = True
    '    InvitationPanel.Visible = False

    'End Sub

    'Private Sub btnCancelInvitation_Click(sender As Object, e As EventArgs) Handles btnCancelInvitation.Click
    '    CoursesPlaceHolder.Visible = True
    '    InvitationButton.Visible = True
    '    InvitationPanel.Visible = False

    'End Sub

    Private Sub btnUpdateStatus_Click(sender As Object, e As EventArgs) Handles btnUpdateStatus.Click

        Try

            thisEvent.statusID = 2
            thisEvent.ModifiedDate = Date.Now()
            db.SubmitChanges()

            Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Event Status Updated", "The event status was updated to Booked.", Context.User.Identity.GetUserId(), Date.Now())


        Catch ex As Exception

        End Try

        CheckStatus()


    End Sub

    'Private Sub btnSavePosKitRequest_Click(sender As Object, e As EventArgs) Handles btnSavePosKitRequest.Click

    '    If POSItemList.CheckedItems.Count = 0 Then

    '        errorLabel2.Text = "<h5 style='margin-top:5px'><span class='label label-danger'>You needs to select items to add to the kit</span></h4>"

    '        Exit Sub
    '    End If

    '    'get the event address
    '    Dim q1 = (From p In db.tblAccounts Where p.Vpid = thisEvent.locationID Select p).FirstOrDefault

    '    'create pos kit
    '    Dim newkit As New tblPosKit
    '    newkit.eventID = thisEvent.eventID
    '    newkit.shipTo = SendToList.SelectedValue
    '    newkit.status = "Pending"

    '    'Brand Ambassador
    '    If SendToList.SelectedValue = "1" Then

    '    End If

    '    'Event Location
    '    If SendToList.SelectedValue = "2" Then
    '        newkit.shipTo = q1.accountName
    '        newkit.shippingAddress = q1.streetAddress1
    '        newkit.shippingCity = q1.city
    '        newkit.shippingState = q1.state
    '        newkit.shippingZip = q1.zipCode
    '    End If

    '    'FedEx Office
    '    If SendToList.SelectedValue = "3" Then
    '        newkit.shipTo = "FedEx Location"
    '        newkit.shippingAddress = ""
    '        newkit.shippingCity = q1.city
    '        newkit.shippingState = q1.state
    '        newkit.shippingZip = q1.zipCode
    '    End If

    '    db.tblPosKits.InsertOnSubmit(newkit)
    '    db.SubmitChanges()

    '    Dim collection As IList(Of RadListBoxItem) = POSItemList.CheckedItems

    '    For Each item As RadListBoxItem In collection

    '        Dim newKitItem As New tblPosKitItem With {.kitID = newkit.kitID, .itemID = item.Value, .itemName = item.Text, .qty = getKitItemQTY(item.Value), .price = getKitItemPrice(item.Value)}

    '        db.tblPosKitItems.InsertOnSubmit(newKitItem)
    '        db.SubmitChanges()

    '    Next
    '    SuccessLabel.Visible = True
    '    SuccessLabel.Text = Common.ShowAlertNoClose("success", "The request has been sent.")
    '    btnSavePosKitRequest.Visible = False

    '    POSItemList.Items.Clear()
    '    BindPOSKit()

    'End Sub

    'Private Sub btnApproveRecap_Click(sender As Object, e As EventArgs) Handles btnApproveRecap.Click

    '    Dim manager = New UserManager()
    '    Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '    db.UpdateEventRecapStatus_Approved(thisEvent.eventID, currentUser.Id)

    '    Response.Redirect("/events/eventdetails?ID=" & thisEvent.eventID & "&action=1")
    'End Sub

    Function getKitItemQTY(id As Integer) As String

        Return (From p In db.tblInventoryItems Where p.itemID = id Select p.unitsInKit).FirstOrDefault

    End Function

    Function getKitItemPrice(id As Integer) As String

        Return (From p In db.tblInventoryItems Where p.itemID = id Select p.retailPrice).FirstOrDefault

    End Function



    'Photo Galery Code

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

        ' DataProvider.Update(keyValue, textBox.Text.Trim())

    End Sub

    'Private Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click
    '    Dim manager = New UserManager()
    '    Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '    Dim eventID = thisEvent.eventID

    '    For Each file As UploadedFile In PhotoAsyncUpload.UploadedFiles

    '        Dim bytes(file.ContentLength - 1) As Byte
    '        file.InputStream.Read(bytes, 0, file.ContentLength)


    '        Dim i As New tblPhoto
    '        i.Image = MakeThumb(bytes, 1200)
    '        i.LargeImage = MakeThumb(bytes, 500) '1
    '        i.SmallImage = MakeThumb(bytes, 350) '2
    '        i.ThumbImage = MakeThumb(bytes, 100) '3

    '        i.eventID = eventID
    '        i.photoTitle = getAccountDetails()
    '        i.dateUploaded = Date.Now()
    '        i.accountID = getAccountID()
    '        i.marketID = getMarketID()
    '        i.uploadedBy = currentUser.Id
    '        i.fileName = file.GetName
    '        db.tblPhotos.InsertOnSubmit(i)
    '        db.SubmitChanges()

    '    Next

    '    Try
    '        Dim insertlog = db.InsertEventLog(thisEvent.eventID, "Photo(s) uploaded", "Photos have been uploaded to the events gallery", Context.User.Identity.GetUserId(), Date.Now())
    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message.ToString()
    '    End Try


    '    PhotoListView.DataBind()

    '    GalleryPanel.Visible = True
    '    UploadPanel.Visible = False

    'End Sub

    Function getAccountDetails() As String

        Dim i = (From p In db.qryViewEvents Where p.eventID = thisEvent.eventID Select p)

        For Each p In i
            Return String.Format("{0}, {1}, {2}", p.accountName, p.city, p.state)
        Next


    End Function

    Function getAccountID() As String

        Return (From p In db.qryViewEvents Where p.eventID = thisEvent.eventID Select p.accountID).FirstOrDefault

    End Function

    Function getMarketID() As String

        Return (From p In db.qryViewEvents Where p.eventID = thisEvent.eventID Select p.marketID).FirstOrDefault

    End Function



    'Public Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
    '    RadSkinManager.GetCurrent(Page).Skin = "Bootstrap"
    'End Sub



    'Private Sub btnCancelUpload_Click(sender As Object, e As EventArgs) Handles btnCancelUpload.Click
    '    GalleryPanel.Visible = True
    '    UploadPanel.Visible = False

    'End Sub

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

    'Private Sub btnAddPhotos_Click(sender As Object, e As EventArgs) Handles btnAddPhotos.Click

    '    GalleryPanel.Visible = False
    '    UploadPanel.Visible = True

    'End Sub

    'Private Sub btnCancelChanges_Click(sender As Object, e As EventArgs) Handles btnCancelChanges.Click

    'End Sub


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
    'Private Sub getNotes_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getNotes.Inserting

    '    Dim manager = New UserManager()
    '    Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

    '    Dim i As tblEventNote
    '    i = CType(e.NewObject, tblEventNote)
    '    i.eventID = thisEvent.eventID
    '    i.createdBy = currentUser.Id
    '    i.dateCreated = Date.Now()
    'End Sub

    'Private Sub getNotes_Updating(sender As Object, e As LinqDataSourceUpdateEventArgs) Handles getNotes.Updating

    '    Dim manager = New UserManager()
    '    Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

    '    Dim originalNote As tblEventNote
    '    Dim newNote As tblEventNote

    '    originalNote = CType(e.OriginalObject, tblEventNote)
    '    newNote = CType(e.NewObject, tblEventNote)

    '    newNote.dateModified = Date.Now()
    '    newNote.modifiedBy = currentUser.Id

    'End Sub

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

    'Protected Sub btnInsertExpense_Click(sender As Object, e As EventArgs)

    '    PayrollPanel.Visible = False
    '    ExpensePanel.Visible = False
    '    AddNewExpensePanel.Visible = True

    'End Sub

    'Protected Sub btnCancelExpense_Click(sender As Object, e As EventArgs)

    '    PayrollPanel.Visible = True
    '    ExpensePanel.Visible = True
    '    AddNewExpensePanel.Visible = False

    'End Sub

    'Protected Sub CancelEditExpenseButton_Click(sender As Object, e As EventArgs)

    '    PayrollPanel.Visible = True
    '    ExpensePanel.Visible = True
    '    EditExpensePanel.Visible = False

    'End Sub

    'Private Sub btnSaveExpense_Click(sender As Object, e As EventArgs) Handles btnSaveExpense.Click

    '    Dim manager = New UserManager()
    '    Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '    Dim expense As New tblEventExpense
    '    expense.eventStaffingRequirementID = AmbassadorDropDownList.SelectedValue
    '    expense.expenseTypeID = ddlExpenseType.SelectedValue
    '    expense.description = descriptionTextBox.Text
    '    expense.amount = amountTextBox.Text
    '    expense.submittedDate = Date.Now()
    '    expense.submittedBy = currentUser.Id

    '    For Each file As UploadedFile In ReceiptAsyncUpload.UploadedFiles
    '        Dim bytes(file.ContentLength - 1) As Byte
    '        file.InputStream.Read(bytes, 0, file.ContentLength)

    '        expense.receipt = (bytes)
    '    Next

    '    db.tblEventExpenses.InsertOnSubmit(expense)
    '    db.SubmitChanges()


    '    PayrollPanel.Visible = True
    '    ExpensePanel.Visible = True
    '    AddNewExpensePanel.Visible = False

    '    'rebind the expenselist
    '    ExpenseList.DataBind()

    '    'clear form
    '    AmbassadorDropDownList.SelectedIndex = 0
    '    ddlExpenseType.SelectedIndex = 0
    '    descriptionTextBox.Text = ""
    '    amountTextBox.Text = ""


    'End Sub

    'Private Sub ExpenseList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles ExpenseList.ItemCommand
    '    If e.CommandName = "DeleteExpense" Then

    '        db.DeleteExpense(Convert.ToInt32(e.CommandArgument))

    '        ExpenseList.DataBind()
    '    End If

    '    If e.CommandName = "EditExpense" Then

    '        'show the edit form
    '        PayrollPanel.Visible = False
    '        ExpensePanel.Visible = False
    '        EditExpensePanel.Visible = True

    '        HiddenExpenseID.Value = e.CommandArgument

    '        Dim q = (From p In db.tblEventExpenses Where p.eventExpenseID = Convert.ToInt32(e.CommandArgument) Select p).FirstOrDefault

    '        EditExpenseTypeDropDownList.SelectedValue = q.expenseTypeID
    '        descriptionTextBox2.Text = q.description
    '        amountTextBox2.Text = q.amount

    '        Dim i = q.eventStaffingRequirementID

    '        Dim a = (From p In db.tblEventStaffingRequirements Where p.RequirementID = i Select p.assignedUserName).FirstOrDefault

    '        Dim b = (From p In db.tblAmbassadors Where p.userName = a Select p).FirstOrDefault
    '        RecieptNameLabel.Text = String.Format("{0} {1}", b.FirstName, b.LastName)
    '    End If
    'End Sub

    'Private Sub btnEditExpense_Click(sender As Object, e As EventArgs) Handles btnEditExpense.Click

    '    Dim manager = New UserManager()
    '    Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '    'save the form

    '    Dim q = (From p In db.tblEventExpenses Where p.eventExpenseID = Convert.ToInt32(HiddenExpenseID.Value) Select p).FirstOrDefault

    '    q.amount = amountTextBox2.Text
    '    q.description = descriptionTextBox2.Text
    '    q.expenseTypeID = EditExpenseTypeDropDownList.SelectedValue

    '    For Each file As UploadedFile In ReceiptAsyncUpload2.UploadedFiles
    '        Dim bytes(file.ContentLength - 1) As Byte
    '        file.InputStream.Read(bytes, 0, file.ContentLength)

    '        q.receipt = (bytes)
    '    Next

    '    q.modifiedBy = currentUser.Id
    '    q.modifiedDate = Date.Now()

    '    db.SubmitChanges()

    '    PayrollPanel.Visible = True
    '    ExpensePanel.Visible = True
    '    EditExpensePanel.Visible = False

    '    'rebind the expense list
    '    ExpenseList.DataBind()


    'End Sub

#Region "Make Thumnail"
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
#End Region


#Region "Weather Classess"

    Public Class WeatherInfo
        Public Property city As City
        Public Property list As List(Of List)
    End Class

    Public Class City
        Public Property name As String
        Public Property country As String
    End Class

    Public Class Temp
        Public Property day As Double
        Public Property min As Double
        Public Property max As Double
        Public Property night As Double
    End Class

    Public Class Weather
        Public Property description As String
        Public Property main As String
        Public Property icon As String
    End Class

    Public Class List
        Public Property temp As Temp
        Public Property humidity As Integer
        Public Property weather As List(Of Weather)
    End Class

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