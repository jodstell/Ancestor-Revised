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

Public Class Event_Details
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim eventID = Request.QueryString("ID")

        If Not Page.IsPostBack Then

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            If manager.IsInRole(currentUser.Id, "Student") Then

            Else
                Response.Redirect("/events/eventdetails?ID=" & eventID)
            End If

            bindEvent()

            BindCourses()
            'BindTestsScores()
            'BindDocuments()

            BindPOSKit()
            'BindShipping()


        End If


    End Sub

    Function getStatusName(ByVal id As Integer) As String

        Return (From p In db.tblStatus Where p.statusID = id Select p.statusName).FirstOrDefault

    End Function

    Private Sub WeatherListRepeater_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles WeatherListRepeater.ItemDataBound
        If WeatherListRepeater.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If
    End Sub

    Sub bindEvent()

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


        Dim q = (From p In db.getEventDetails Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        'If q.Modified = True Then
        '    BindCourses()
        'End If

        ''get the status of the recap
        'Dim hasRecap = q.recapStatus
        'Dim status = q.statusID

        'If hasRecap <> 0 Then
        '    EditRecapLink.Visible = True
        '    PrintPDFLink.Visible = True
        '    btnApproveRecap.Visible = True
        'End If

        'If status = 1 Or manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Or manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
        '    btnApproveRecap.Visible = False
        'End If

        'If hasRecap = 0 Then
        '    CreateRecapLink.Visible = True
        '    EditRecapLink.Visible = False
        '    PrintPDFLink.Visible = False
        'End If


        ' get the logged ambassador

        'If manager.IsInRole(currentUser.Id, "Student") Then

        '    SelectedAmbassadorPanel.Visible = False
        '    EnterAddressPanel.Visible = True

        Dim a = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p).FirstOrDefault
        txtFromAddress.Text = String.Format("{0}, {1}, {2} {3}", a.Address1, a.City, a.State, a.Zip)
        'Else
        '    SelectedAmbassadorPanel.Visible = True
        '    EnterAddressPanel.Visible = False

        'End If

        ''bind account by locationID

        AccountNameLabel1.Text = q.AccountName
        LatitudeTextBox.Value = q.latitude
        LongtitudeTextBox.Value = q.longitude
        LocationTextBox.Value = q.city & ", " & q.state
        CityLabel.Text = q.city & ", " & q.state

        AccountHyperLink1.NavigateUrl = "/Accounts/AccountDetails?AccountID=" & q.accountID

        AccountAddressLabel1.Text = String.Format("{0} {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)

        'PhotoCountLabel.Text = (From p In db.tblPhotos Where p.eventID = q.eventID Select p).Count

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


        'Team Name
        Dim team = (From p In db.tblTeams Where p.teamID = q.teamID Select p).FirstOrDefault()
        Try
            TeamLabel.Text = team.teamName
        Catch ex As Exception

        End Try


        'staffing

        ''show/hide admin panels
        'If manager.IsInRole(currentUser.Id, "Client") Or manager.IsInRole(currentUser.Id, "Student") Or manager.IsInRole(currentUser.Id, "Agency") Then
        '    assignTab.Visible = False
        '    requirementsTab.Visible = False
        '    payrollTab.Visible = False
        'End If

        'bind positions available
        If Not Page.IsPostBack Then
            BindPositionCount()
        End If

        'Dim account = q.locationID


        'Try

        '    HF_ClientID.Value = "18"

        '    HF_MarketID.Value = q.marketID

        '    TotalSpendLabel.Text = String.Format("${0}", (From p In db.qryEventStaffingRequirementLists Where p.eventID = q.eventID Select p.Total).Sum)

        '    Dim dv As System.Data.DataView = DirectCast(getAvailableAmbassadorList.[Select](DataSourceSelectArguments.Empty), DataView)
        '    StaffCountLabel.Text = dv.Count.ToString()
        'Catch ex As Exception

        'End Try

        '' SelectedDirectionsName

        'Dim hasAmbassadorAssigned As Integer = db.ViewPayrollSummaryByEvent(q.eventID).Count

        'If hasAmbassadorAssigned = 0 Then
        '    ExpensePanel.Visible = False
        'End If



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



    'Staffing section
    Private Sub RadTabStrip1_TabClick(sender As Object, e As RadTabStripEventArgs) Handles RadTabStrip1.TabClick

        Select Case e.Tab.Value
            Case "status"
                BindTestsScores()
                BindDocuments()
                Exit Select

                'Case "AssignBA"
                '    AvailableAmbassadorList.DataSourceID = "getAvailableAmbassadorList"
                '    LookupAmbassadorText.DataSourceID = "getAvailableAmbassadorNameList"

                '    BindTestsScores()
                '    BindDocuments()
                '    Exit Select

                'Case "requirement"
                '    BrandPositionList.DataSourceID = "getEventPositions"

                '    BindTestsScores()
                '    BindDocuments()
                '    Exit Select

                'Case "payroll"
                '    PayrollList.DataSourceID = "getPayrolSummary"

                '    BindTestsScores()
                '    BindDocuments()
                Exit Select
        End Select

    End Sub

    'Staffing section
    'First Tab
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

    Function setImage(id As String) As Boolean
        If id = "" Then Return False Else Return True
    End Function

    Protected Function CreateWindowScript(ByVal userID As String, ByVal image As Integer) As String
        Return String.Format("var win = window.radopen('/Profile_Image.aspx?image={1}&UserID={0}','Details');win.center();", userID, image)
    End Function

    Function getUserID(username As String) As String
        Dim userdb As New LMSDataClassesDataContext

        Return (From p In userdb.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault
    End Function


    'position functions
    Sub BindPositionCount()
        Dim eventID = Request.QueryString("ID")

        positionsStaffedCountLabel.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = True Select p).Count
        positionsAvailableCountLabel.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = eventID And p.assigned = False Select p).Count

    End Sub
    'end first tab

    'Product Training
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

#Region "Courses"

    Sub BindTestsScores()

        'Show Test Results
        Try

            Dim _userName = (From profile In db.tblProfiles Where profile.userID = Context.User.Identity.GetUserId() Select profile.userName).FirstOrDefault

            'get the list of ambassadors available
            Dim i = From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") And p.assignedUserName = _userName Select p

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

    Function getBrandCourseID(groupID As String) As String
        Return (From p In lmsdb.CurriculumGroups Where p.CurriculumGroupID = groupID Select p.CourseID).FirstOrDefault

    End Function

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
                myView.Add(New EventDocumentList(i.FileID, getFileName(i.FileID), getFileType(i.FileID), "/filehandler?ID=" & i.FileID, "True", "RemoveFile", disableDocument(i.FileID)))
            Next

        Next

        'get documents attached to the event
        Dim q = From p In db.tblEventDocuments Where p.EventID = Request.QueryString("ID") Select p

        'add the attached documents to the list
        For Each p In q
            myView.Add(New EventDocumentList(p.DocumentID, p.DocumentName, p.FileType, "/events/eventfilehandler?ID=" & p.DocumentID, "True", "DeleteAttachment", "True"))
        Next

        Dim result = From w In myView Where w.Visible = "True" Select w

        DocumentRepeater.DataSource = result.GroupBy(Function(p) p.FileID).[Select](Function(g) g.First())
        DocumentRepeater.DataBind()

        ''get brands
        'Dim r = From p In db.getCourseForEvents Where p.eventID = Request.QueryString("ID") Select p

        'For Each p In r

        '    Dim div As New HtmlGenericControl("div")

        '    Dim lbl As New HtmlGenericControl("h3")
        '    lbl.InnerHtml = getBrandCourseGroupName(p.CourseTitle)
        '    div.Controls.Add(lbl)

        '    DocumentsPlaceHolder.Controls.Add(div)

        '    Dim ID = (From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l.CurriculumID).FirstOrDefault
        '    Dim related = (From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l.CurriculumGroupID).FirstOrDefault

        '    Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Select l

        '    ''there are no documents so we will show a friendly message
        '    'If course.Count = 0 Then

        '    '

        '    '    Exit Sub
        '    ' End If

        '    Dim myFiles = From i In lmsdb.CourseFiles Where i.RelatedID = p.curriculum Select i

        '    If myFiles.Count = 0 Then
        '        Dim divb As New HtmlGenericControl("div")
        '        divb.Attributes.Add("class", "form-group")

        '        Dim lblb As New HtmlGenericControl("label")
        '        lblb.InnerHtml = "There are no documents currently available"
        '        divb.Controls.Add(lblb)

        '        DocumentsPlaceHolder.Controls.Add(divb)
        '    Else
        '        Dim type = (From u In lmsdb.CurriculumLists Where u.CurriculumID = ID Select u.ContentType).FirstOrDefault
        '        Dim _testID = (From u In lmsdb.CurriculumLists Where u.CurriculumID = ID Select u.TestID).FirstOrDefault

        '        Dim icon As String = ""

        '        For Each i In myFiles
        '            Dim div1 As New HtmlGenericControl("div")

        '            icon = "<i class='fa fa-file-pdf-o' aria-hidden='True'></i>"

        '            Dim lbl1 As New HtmlGenericControl("div")
        '            lbl1.Attributes.Add("class", "leftColumn")
        '            lbl1.InnerHtml = icon
        '            div1.Controls.Add(lbl1)

        '            ' Create a text box control
        '            Dim box As New HyperLink
        '            box.CssClass = "pointer"
        '            box.NavigateUrl = "/filehandler?ID=" & i.FileID
        '            box.Text = String.Format("{0}", getFileName(i.FileID))
        '            div1.Controls.Add(box)
        '            div.Controls.Add(div1)

        '            DocumentsPlaceHolder.Controls.Add(div1)
        '        Next
        '    End If



        'Next

    End Sub

    Function disableDocument(fileID As String) As String

        Dim q = From p In db.tblEventDocument_Hiddens Where p.fileID = fileID And p.eventID = Request.QueryString("ID") Select p

        If q.Count = 0 Then
            Return "True"
        Else
            Return "False"
        End If

    End Function

    Function getFileType(fileID As String) As String
        Return (From p In lmsdb.Files Where p.ID = fileID Select p.ContentType).FirstOrDefault
    End Function

    Public Sub BindCourses()

        Try
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
        Catch ex As Exception

        End Try


    End Sub

    Function getBrandCourseGroupName(groupID As String) As String
        Return (From p In lmsdb.CurriculumGroups Where p.CurriculumGroupID = groupID Select p.Title).FirstOrDefault

    End Function

    Function getFileName(fileID As String) As String
        Return (From p In lmsdb.Files Where p.ID = fileID Select p.FileName).FirstOrDefault
    End Function

#End Region

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
                    CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                Case "2"
                    CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                Case "3"
                    CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                Case "4"
                    CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                Case "5"
                    CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                Case "6"
                    CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

                Case "7"
                    CurriculumLink.NavigateUrl = String.Format("/application/course/curriculum?ID={0}&p=1", CurriculumID.Text)

            End Select





        End If

    End Sub
    'End training


    'POS tab
    Private Sub POSRadTabStrip_TabClick(sender As Object, e As RadTabStripEventArgs) Handles POSRadTabStrip.TabClick
        Select Case e.Tab.Value
            Case "kits"
                BindTestsScores()
                BindDocuments()

            Case "shippinglocation"
                BindShipping()

                BindTestsScores()
                BindDocuments()

                Exit Select
        End Select
    End Sub


#Region "POS"

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

                    'btnSavePosKitRequest.Visible = False
                    noPosItemsLabel.Text = ""
                    POSKitRequestedLabel.Text = Common.ShowAlertNoClose("success", "A POS Kit has been requested. <a target='_blank' href=" & trackingString & ">Check status here!</a>")
                    noPosItemsPanel.Visible = True
                    POSPanel.Visible = False
                End If


            Catch ex As Exception

            End Try

        End If
    End Sub


    Function getKitItemQTY(id As Integer) As String

        Return (From p In db.tblInventoryItems Where p.itemID = id Select p.unitsInKit).FirstOrDefault

    End Function

    Function getKitItemPrice(id As Integer) As String

        Return (From p In db.tblInventoryItems Where p.itemID = id Select p.retailPrice).FirstOrDefault

    End Function

#End Region

    'end POS



    'event recap section
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

    Private Sub recapTab_TabClick(sender As Object, e As RadTabStripEventArgs) Handles recapTab.TabClick
        Select Case e.Tab.Value
            Case "Questionnaire"
                BindTestsScores()
                BindDocuments()
                Exit Select

            Case "PhotoGallery"
                PhotoListView.DataSourceID = "getImageList"

                BindTestsScores()
                BindDocuments()
                Exit Select

        End Select
    End Sub

    'end recap section
End Class
