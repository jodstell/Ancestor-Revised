Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class LessonPlan
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim StudentisInCourse As Boolean = False
    Dim pageName As String
    Dim pageTitle As String

    Private Sub LessonPlan_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit

        pageName = System.IO.Path.GetFileName(Request.Url.ToString())
        pageTitle = pageName.Substring(0, pageName.IndexOf("?"))

        Page.Title = GetWidgetName() & " | " & GetCourseName()

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load




        ' CourseDescriptionLabel.Text = (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.Description).FirstOrDefault
        ' CurriculumTitleLabel.Text = GetCourseName()

        If Not Page.IsPostBack Then

            'check if in School
            Dim inSchool = (From p In db.StudentsInGroups Where p.TestGoupID = "6d0c6b78-ea5b-4e03-b1ef-70240ff66e64" And p.UserName = Context.User.Identity.Name Select p).Count
            If inSchool = 0 Then
                'add to the group
                Dim i As New StudentsInGroup With {.TestGoupID = "6d0c6b78-ea5b-4e03-b1ef-70240ff66e64", .UserName = Context.User.Identity.Name}
                db.StudentsInGroups.InsertOnSubmit(i)
                db.SubmitChanges()
            End If

            'check if in course
            Dim inCourse = (From p In db.StudentsInCourses Where p.CourseID = "1c6fd977-048c-4550-8dbc-02d73f4f3e77" And p.UserName = Context.User.Identity.Name Select p).Count

            If inCourse = 0 Then
                'add to the course
                Dim x As New StudentsInCourse With {.StudentInCourseID = System.Guid.NewGuid().ToString(), .CourseID = "1c6fd977-048c-4550-8dbc-02d73f4f3e77", .UserName = Context.User.Identity.Name, .Status = 1, .PercentComplete = 0, .DateStarted = Date.Now()}
                db.StudentsInCourses.InsertOnSubmit(x)
                db.SubmitChanges()
            End If


            'check if in selected course
            Dim inThisCourse = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = Context.User.Identity.Name Select p).Count

            If inCourse = 0 Then
                'add to the course
                Dim x As New StudentsInCourse With {.StudentInCourseID = System.Guid.NewGuid().ToString(), .CourseID = Request.QueryString("CourseID"), .UserName = Context.User.Identity.Name, .Status = 1, .PercentComplete = 0, .DateStarted = Date.Now()}
                db.StudentsInCourses.InsertOnSubmit(x)
                db.SubmitChanges()
            End If



            'bind the curriculum groups
            Dim b = db.getCurriculumItems(Request.QueryString("CourseID"))

            CurriculumGroupList.DataSource = b
            CurriculumGroupList.DataBind()

            Try
                Dim isInCourse As Integer = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = Context.User.Identity.Name Select p).Count

                If isInCourse = 0 Then
                    'BtnStartCourse.Visible = True
                    StudentisInCourse = False
                    StartTestPanel.Visible = False
                    ResultsPanel.Visible = False
                    '  StatsPanel.Visible = False
                Else
                    'BtnStartCourse.Visible = False
                    StudentisInCourse = True
                End If

                Dim _status As Integer = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = Context.User.Identity.Name Select p.Status).FirstOrDefault

                If _status = 0 Then
                    StartTestPanel.Visible = False
                    ResultsPanel.Visible = False
                    '   StatsPanel.Visible = False
                End If

                If _status = 1 Then
                    StartTestPanel.Visible = False
                    ResultsPanel.Visible = False
                    '  StatsPanel.Visible = True
                End If

                If _status = 2 Then
                    StartTestPanel.Visible = False ' changed from true to false  not sure if this panel is needed
                    ResultsPanel.Visible = False
                    '   StatsPanel.Visible = True
                End If

                'check if there is a test

                ' Dim q = (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.TestID).FirstOrDefault

                'If q = "" Or q Is Nothing Then
                '    StartTestPanel.Visible = False
                'End If

            Catch ex As Exception

            End Try

        End If

        '  CourseDescriptionLabel.Text = (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.Description).FirstOrDefault


        'get the documents

        Dim q = From p In db.CourseFiles
                Join c In db.Files
                On c.ID Equals p.FileID
                Where p.CourseID = Request.QueryString("CourseID")
                Select c.FileName, c.ID, c.Size, c.DateUploaded, c.UploadedBy, c.ContentType, p.FileID

        LibraryFileList.DataSource = q
        LibraryFileList.DataBind()


        Dim l = From p In db.CourseLinks
                Join c In db.Links
                On c.ID Equals p.LinkID
                Where p.CourseID = Request.QueryString("CourseID")
                Select c.LinkTitle, c.ID, c.LinkURL, p.LinkID

        CourseLinksList.DataSource = l
        CourseLinksList.DataBind()

    End Sub

    Function getFileType(type As String) As String

        Select Case type
            Case "application/pdf"
                Return ".pdf"
            Case "image/png"
                Return ".png"

        End Select
    End Function

    Function GetWidgetName() As String

        Return (From p In db.CourseWidgets Where p.WidgetName = pageTitle And p.CourseID = Request.QueryString("CourseID") Select p.Title).FirstOrDefault

    End Function

    Function GetWidgetDescription() As String

        Return (From p In db.CourseWidgets Where p.WidgetName = pageTitle And p.CourseID = Request.QueryString("CourseID") Select p.DescriptionText).FirstOrDefault

    End Function

    Function GetSiteID() As String

        Return "GigEngyn"

    End Function

    Private Sub CurriculumGroupList_ItemDataBound(sender As Object, e As RadListViewItemEventArgs) Handles CurriculumGroupList.ItemDataBound

        If e.Item.ItemType = RadListViewItemType.DataItem OrElse e.Item.ItemType = RadListViewItemType.AlternatingItem Then

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

            'Find controls
            Dim lblThreadID As Label = DirectCast(e.Item.FindControl("lblCurriculumGroupID"), Label)


            Dim CurriculumItems As Repeater = DirectCast(e.Item.FindControl("CurriculumGrid"), Repeater)

            'Populate nested grid
            Dim data = From p In db.Curriculums Where p.CurriculumGroupID = lblThreadID.Text Order By p.SortOrder Select p

            CurriculumItems.DataSource = db.getCurriculumListByGRoup(currentUser.Id, Request.QueryString("CourseID"), lblThreadID.Text)
            CurriculumItems.DataBind()


        End If


    End Sub

    Function GetGroupName()
        Dim group As String = (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.GroupID).FirstOrDefault
        Return (From p In db.TestGroups Where p.GroupID = group Select p.GroupTitle).FirstOrDefault
    End Function

    Function GetCourseName() As String

        Return (From p In db.Courses Where p.CourseID = Request.QueryString("CourseID") Select p.CourseTitle).FirstOrDefault

    End Function

    Function GetCurriculumCount() As String

        Return (From p In db.Curriculums Where p.CourseID = Request.QueryString("CourseID") Select p).Count

    End Function

    Function GetCurriculumCountByGroup() As String

        Return (From p In db.Curriculums Where p.CourseID = Request.QueryString("CourseID") Select p).Count

    End Function

    Function GetCurriculumStatus(id As String) As String
        Try
            Dim _studentInCourseID = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = Context.User.Identity.Name Select p.StudentInCourseID).FirstOrDefault

            Dim CompletedDate As Date = (From p In db.CurriculumResults Where p.CurriculumID = id And p.StudentInCourseID = _studentInCourseID And p.Completed = True Select p.DateCompleted).FirstOrDefault

            Return String.Format("Completed on {0:d}", CompletedDate)
        Catch ex As Exception
            Return Nothing
        End Try


        '  _studentInCourseID

        '(From p In db.CurriculumResults Where p.CurriculumID = id And p.StudentInCourseID = _studentInCourseID And p.Completed = True Select p.DateCompleted).FirstOrDefault
    End Function

    Function GetCompletedCount() As String

        Dim _studentInCourseID = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = Context.User.Identity.Name Select p.StudentInCourseID).FirstOrDefault

        Return (From p In db.CurriculumResults Where p.StudentInCourseID = _studentInCourseID And p.Completed = True Select p).Count

        Return ""
    End Function

    Function GetRemainingCountByGroup(id As String) As String

        Try

            Dim _studentInCourseID = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = Context.User.Identity.Name Select p.StudentInCourseID).FirstOrDefault

            Dim r = (From p In db.getDistinctCurriculumResults Where p.UserName = Context.User.Identity.Name And p.CurriculumGroupID = id Select p).Count

            Dim total = (From p In db.Curriculums Where p.CurriculumGroupID = id And p.CourseID = Request.QueryString("CourseID") And p.Enabled = True Select p).Count

            Return String.Format("{0} out of {1} Completed", r, total)
            ' Return completed ' total  '- completed
        Catch ex As Exception
            Return Nothing
        End Try

    End Function

    Function HideTrophy(id As String) As String

        Try

            Dim _studentInCourseID = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = Context.User.Identity.Name Select p.StudentInCourseID).FirstOrDefault

            Dim r = (From p In db.getDistinctCurriculumResults Where p.UserName = Context.User.Identity.Name And p.CurriculumGroupID = id Select p).Count

            Dim total = (From p In db.Curriculums Where p.CurriculumGroupID = id And p.CourseID = Request.QueryString("CourseID") And p.Enabled = True Select p).Count

            If r = total Then
                Return "true"
            Else
                Return "false"
            End If

            'Return String.Format("{0} out of {1} Completed", r, total)
            ' Return completed ' total  '- completed
        Catch ex As Exception
            Return Nothing
        End Try

    End Function



    Function HideRequiredText(id As String) As String

        Try

            Dim _studentInCourseID = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = Context.User.Identity.Name Select p.StudentInCourseID).FirstOrDefault

            Dim r = (From p In db.getDistinctCurriculumResults Where p.UserName = Context.User.Identity.Name And p.CurriculumGroupID = id Select p).Count

            Dim total = (From p In db.Curriculums Where p.CurriculumGroupID = id And p.CourseID = Request.QueryString("CourseID") Select p).Count

            If r = total Then
                Return "False"
            Else
                Return "True"
            End If

            'Return String.Format("{0} out of {1} Completed", r, total)
            ' Return completed ' total  '- completed
        Catch ex As Exception
            Return Nothing
        End Try

    End Function


    Function GetIsCompleted(curriculumID As String) As Boolean

        Try
            Dim _curriculumGroupID = (From p In db.Curriculums Where p.CurriculumID = curriculumID Select p.CurriculumGroupID).FirstOrDefault
            ' _curriculumGroupID

            Dim q = (From p In db.CurriculumGroups Where p.CurriculumGroupID = _curriculumGroupID Select p).FirstOrDefault

            If q.PreRequisiteRequired = True Then



                Dim _studentInCourseID = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = Context.User.Identity.Name Select p.StudentInCourseID).FirstOrDefault

                Dim r = (From p In db.getCurriculumResults Where p.StudentInCourseID = _studentInCourseID And p.CurriculumGroupID = ID Select p).Count

                Dim total = (From p In db.Curriculums Where p.CurriculumGroupID = _curriculumGroupID And p.CourseID = Request.QueryString("CourseID") Select p).Count

                Dim z = r - total

                If z = total Then
                    Return True
                Else
                    Return False
                End If

            End If



            '  Return String.Format("{0} out of {1} Completed", z, total)
            ' Return completed ' total  '- completed
        Catch ex As Exception
            Return True
        End Try



    End Function

    Function GetRequiredGroupName(id As String) As String

        Try
            Dim q = (From p In db.CurriculumGroups Where p.CurriculumGroupID = id Select p).FirstOrDefault

            If q.PreRequisiteRequired = True Then
                Return Nothing

            Else

                Return String.Format("<span class='label label-warning'> You must complete <b>{0}</b> before you can take this course.</span>", q.Title)

            End If
        Catch ex As Exception
            Return Nothing
        End Try



    End Function

    Function GetRemainingCount() As String
        Try
            Dim _studentInCourseID = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = Context.User.Identity.Name Select p.StudentInCourseID).FirstOrDefault
            Dim completed = (From p In db.CurriculumResults Where p.StudentInCourseID = _studentInCourseID And p.Completed = True Select p).Count
            Dim total = (From p In db.Curriculums Where p.CourseID = Request.QueryString("CourseID") Select p).Count

            Return total - completed
        Catch ex As Exception

        End Try

    End Function

    Function GetPercentCompeted() As String
        Try
            Dim _studentInCourseID = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = Context.User.Identity.Name Select p.StudentInCourseID).FirstOrDefault

            Dim completed = (From p In db.CurriculumResults Where p.StudentInCourseID = _studentInCourseID And p.Completed = True Select p).Count
            Dim total = (From p In db.Curriculums Where p.CourseID = Request.QueryString("CourseID") And p.Enabled = True Select p).Count

            Return String.Format("{0:###}%", completed / total * 100)
        Catch ex As Exception

        End Try

    End Function

    Function TestResult() As String



        Return ""

    End Function

    Function GetCompletedDate(ByVal id As String) As String

        Try
            Dim username As String = System.Web.HttpContext.Current.User.Identity.Name
            Dim s = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("CourseID") And p.UserName = username Select p.StudentInCourseID).FirstOrDefault

            Dim status As Boolean = (From p In db.CurriculumResults Where p.CurriculumID = id And p.StudentInCourseID = s Select p.Completed).FirstOrDefault

            If status = True Then
                Return "<i class='fa fa-check-circle fa-2x pull-left fa-border'></i>"
            End If

        Catch ex As Exception
            Return ""
        End Try


    End Function

    'Private Sub AvailableCoarseListing_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles AvailableCoarseListing.ItemDataBound





    '    If e.Item.ItemType = ListItemType.Item Or _
    '        (e.Item.ItemType = ListItemType.AlternatingItem) Then

    '        Dim btnAction As HyperLink = CType(e.Item.FindControl("btnAction"), HyperLink)

    '        If StudentisInCourse = False Then
    '            btnAction.Visible = False
    '        Else
    '            btnAction.Visible = True

    '        End If



    ''Select Case q
    '    Case "0"
    'Return "View Course &nbsp;&nbsp;<i class='fa fa-chevron-right'></i>"
    '    Case "1"
    'Return "View Course &nbsp;&nbsp;<i class='fa fa-chevron-right'></i>"
    'End Select

    '    End If

    'End Sub

    Function getIcon(ByVal id As String) As String

        Try
            Dim username As String = User.Identity.Name
            Dim c = (From p In db.Curriculums Where p.CurriculumID = id Select p.CourseID).FirstOrDefault

            Dim s = (From p In db.StudentsInCourses Where p.CourseID = c And p.UserName = username Select p.StudentInCourseID).FirstOrDefault

            Dim status As Boolean = (From p In db.CurriculumResults Where p.CurriculumID = id And p.StudentInCourseID = s Select p.Completed).FirstOrDefault

            If status = True Then
                Return "fa fa-check-square fa-2x"
            End If

            Return "fa fa-square fa-2x"
        Catch ex As Exception

            Dim type As Integer = (From p In db.CurriculumLists Where p.CurriculumID = id And p.Order = p.Order Select p.ContentType).FirstOrDefault

            Select Case type
                Case "1"
                    Return "fa fa-file-text-o fa-2x"
                Case "2"
                    Return "fa fa-file-video-o fa-2x"
                Case "3"
                    Return "fa fa-file-video-o fa-2x"
                Case "4"
                    Return "fa fa-file-text-o fa-2x"
                Case "5"
                    Return "fa fa-file-text-o fa-2x"
                Case "6"
                    Return "fa fa-file-text-o fa-2x"
                Case "7"
                    Return "fa fa-check-square-o fa-2x"

            End Select

        End Try


    End Function

    Function getBackground(ByVal id As String, isComplete As String) As String


        Try

            If isComplete = "False" Then
                Return "rlv0"

            Else

                Dim username As String = User.Identity.Name
                Dim c = (From p In db.Curriculums Where p.CurriculumID = id Select p.CourseID).FirstOrDefault

                Dim s = (From p In db.StudentsInCourses Where p.CourseID = c And p.UserName = username Select p.StudentInCourseID).FirstOrDefault

                Dim status As Boolean = (From p In db.CurriculumResults Where p.CurriculumID = id And p.StudentInCourseID = s Select p.Completed).FirstOrDefault

                If status = True Then
                    'completed
                    Return "rlvII"

                End If



                Dim type As Integer = (From p In db.CurriculumLists Where p.CurriculumID = id And p.Order = p.Order Select p.ContentType).FirstOrDefault
                If type = "7" Then
                    Return "rlvIII"
                End If

                Return "rlvIII"

            End If
        Catch ex As Exception

            Dim type As Integer = (From p In db.CurriculumLists Where p.CurriculumID = id And p.Order = p.Order Select p.ContentType).FirstOrDefault
            If type = "7" Then
                Return "rlvIII"

            Else
                Return "rlvI"
            End If



        End Try




    End Function

    Function getTestResult(ByVal id As String) As String

        Try
            Dim username As String = User.Identity.Name
            Dim c = (From p In db.Curriculums Where p.CurriculumID = id Select p.CourseID).FirstOrDefault

            Dim s = (From p In db.StudentsInCourses Where p.CourseID = c And p.UserName = username Select p.StudentInCourseID).FirstOrDefault

            ' Dim status As Boolean = (From p In db.CurriculumResults Where p.CurriculumID = id And p.StudentInCourseID = s Select p.Completed).FirstOrDefault

            '  If status = True Then
            'get the test result

            Dim type = (From y In db.CurriculumLists Where y.CurriculumID = id Select y.ContentType).FirstOrDefault
            Dim _testID = (From b In db.CurriculumLists Where b.CurriculumID = id Select b.TestID).FirstOrDefault

            Dim _result = (From t In db.baretc_TestResults Where t.UserName = username And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Result).FirstOrDefault
            Dim _score = (From t In db.baretc_TestResults Where t.UserName = username And t.ID = _testID Order By t.DateTimeCompleted Descending Select t.Score).FirstOrDefault

            Dim testresult As String
            Dim resultlabel As String
            Dim scoreLabel As String

            Select Case _result
                Case "Passed"
                    testresult = "success"
                    resultlabel = "Passed"
                    scoreLabel = String.Format("{0}%", _score)

                    Return String.Format("<h4><span class='label label-{0}'>{1} {2}</span></h4>", testresult, resultlabel, scoreLabel)

                Case "Failed"
                    testresult = "danger"
                    resultlabel = "Failed"
                    scoreLabel = String.Format("{0}%", _score)

                    Return String.Format("<h4><span class='label label-{0}'>{1} {2}</span></h4>", testresult, resultlabel, scoreLabel)

            End Select



            '  End If

            '  Return ""
        Catch ex As Exception
            Return ""
        End Try
    End Function


    Private Sub btnTakeTest_Click(sender As Object, e As EventArgs) Handles btnTakeTest.Click
        Response.Redirect("start?id=" & Request.QueryString("id"))
    End Sub


End Class