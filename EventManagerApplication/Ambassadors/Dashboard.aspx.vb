Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class Dashboard2
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim userdb As New LMSDataClassesDataContext


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())


        Session.Add("CurrentUserID", currentUser.Id)
        Dim userid As String = Context.User.Identity.GetUserId()

        Session.Add("CurrentUserName", currentUser.UserName)

        GUID.Value = System.Web.HttpContext.Current.User.Identity.Name

        Dim action = Request.QueryString("action")

        Select Case action
            Case 0
                msgLabel2.Text = Common.ShowAlert("success", "Your recap has been saved and you can return to finish it later.")
            Case 1
                msgLabel2.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
            Case 2
                msgLabel2.Text = Common.ShowAlert("success", "Your recap has been successfully submitted!")
            Case 3
                msgLabel2.Text = Common.ShowAlert("danger", "There was an error saving your recap.  The site administrator has been notified!  Sorry of the inconvience.")

        End Select

        If Not Page.IsPostBack Then

            '  BindCurrentCourses()

            Dim a = From r In userdb.qryGetCourseListByUserIDs Where r.UserID = currentUser.Id And r.CourseID <> "1c6fd977-048c-4550-8dbc-02d73f4f3e77" Select r

            ' TrainingList.DataSource = a
            ' TrainingList.DataBind()

            CourseCountLabel.Text = a.Count


            ' BindForm(userid)
            Try
                FullNameLabel.Text = String.Format("{0} {1}", (From p In db.tblAmbassadors Where p.userID = userid Select p.FirstName).FirstOrDefault, (From p In db.tblAmbassadors Where p.userID = userid Select p.LastName).FirstOrDefault)
                AccountNameLabel.Text = (From p In db.tblAmbassadors Where p.userID = userid Select p.FirstName).FirstOrDefault



                CurrentDateLabel.Text = String.Format("{0:D}", Date.Now)
            Catch ex As Exception

            End Try

            Try
                CountLabel.Text = (From p In db.qryViewPastEventsByAmbassadors Where p.userID = currentUser.Id Select p).Count
            Catch ex As Exception
                CountLabel.Text = "0"
            End Try

            Try
                TotalHoursLabel.Text = (From p In db.qryViewPastEventsByAmbassadors Where p.userID = currentUser.Id Select p.hours).Sum
            Catch ex As Exception
                TotalHoursLabel.Text = "0"
            End Try

            Try
                Label2.Text = String.Format("{0:c}", (From p In db.qryViewPastEventsByAmbassadors Where p.userID = currentUser.Id Select p.Total).Sum)
            Catch ex As Exception
                Label2.Text = "$0.00"
            End Try


            Try
                Dim birthDate As Date
                birthDate = (From p In db.tblAmbassadors Where p.userID = userid Select p.DOB).FirstOrDefault

            Catch ex As Exception

            End Try

        End If

        'get count labels

        'AvailableCountLabel.Text = (From p In db.GetAvailableEventsbyAmbassador(userid) Select p).Count
        RecapCountLabel.Text = (From p In db.qryViewNeedsRecapEventsByAmbassadors Where p.userID = userid Select p).Count
        UpcomingCountLabel.Text = (From p In db.qryViewCurrentEventsByAmbassadors Where p.userID = userid Select p).Count
        PreviousCountLabel.Text = (From p In db.qryViewPastEventsByAmbassadors Where p.userID = userid Select p).Count

    End Sub

    Function getCourseTitle(ByVal courseID As String) As String

        Try
            Return (From p In userdb.Courses Where p.CourseID = courseID Select p.CourseTitle).FirstOrDefault

        Catch ex As Exception
            Return "Error"
        End Try

    End Function

    Function GetPercentCompeted(courseID As String) As String
        Try
            Dim _studentInCourseID = (From p In userdb.StudentsInCourses Where p.CourseID = courseID And p.UserName = Context.User.Identity.Name Select p.StudentInCourseID).FirstOrDefault

            Dim completed = (From p In userdb.CurriculumResults Where p.StudentInCourseID = _studentInCourseID And p.Completed = True Select p).Count
            Dim total = (From p In userdb.Curriculums Where p.CourseID = courseID Select p).Count

            ' Return String.Format("{0:###}%", completed / total * 100)

            Return _studentInCourseID
        Catch ex As Exception
            Return ""
        End Try

    End Function


    Function getRequiredCurriculumCount(ByVal courseID As String) As String
        Dim db As New DataClassesDataContext
        Dim dbUser As New LMSDataClassesDataContext

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Dim userid As String = currentUser.Id

        Dim courseGroup = (From p In db.GetAmbassadorEventsWithBrands(userid) Where p.courseID = courseID Select p.courseGroupID).FirstOrDefault

        Dim trainingLabel As String = ""

        Dim result = (From r In dbUser.Curriculums Where r.CurriculumGroupID = courseGroup Select r)
        For Each r In result

            Dim c = (From p In dbUser.Curriculums Where p.CurriculumGroupID = r.CurriculumGroupID Select p).Count
            Dim t = getResultCount(r.CurriculumID, userid, courseID)

            If c = t Then
                'do nothing
            Else
                Return "<p class='text-danger' style='font-size:x-small'><i class='fa fa-exclamation-triangle' aria-hidden='true'></i> Training Required!</p>"
            End If
            trainingLabel = getResultCount(r.CurriculumID, userid, courseID) & " " & c

        Next

        Return trainingLabel

    End Function

    Function getResult(CurriculumID As String, userID As String, courseID As String) As String
        Try
            Dim db As New DataClassesDataContext
            Dim dbUser As New LMSDataClassesDataContext

            'get userName from the userID
            Dim user As String = (From p In dbUser.AspNetUsers Where p.Id = userID Select p.UserName).FirstOrDefault

            'get the studentincourseID from studentincourse

            Dim i = (From p In dbUser.StudentsInCourses Where p.UserName = user And p.CourseID = courseID Select p.StudentInCourseID).FirstOrDefault

            Dim w = (From p In dbUser.CurriculumResults Where p.CurriculumID = CurriculumID And p.StudentInCourseID = i Select p).FirstOrDefault

            Return w.Completed
        Catch ex As Exception
            Return ""
        End Try


    End Function

    Function getResultCount(CurriculumID As String, userID As String, courseID As String) As String
        Try
            Dim db As New DataClassesDataContext
            Dim dbUser As New LMSDataClassesDataContext

            'get userName from the userID
            Dim user As String = (From p In dbUser.AspNetUsers Where p.Id = userID Select p.UserName).FirstOrDefault

            'get the studentincourseID from studentincourse

            Dim i = (From p In dbUser.StudentsInCourses Where p.UserName = user And p.CourseID = courseID Select p.StudentInCourseID).FirstOrDefault

            Dim w = (From p In dbUser.CurriculumResults Where p.CurriculumID = CurriculumID And p.StudentInCourseID = i Select p).Count

            Return w
        Catch ex As Exception
            Return ""
        End Try


    End Function

    Function calculatPersentComplete(CurriculumCompletedCount As String, CurriculumCount As String) As String

        Dim purchases As Integer = Convert.ToInt32(CurriculumCount)
        Dim visitors As Integer = Convert.ToInt32(CurriculumCompletedCount)
        ' Return (CDbl(purchases) / visitors)

        Dim percent As Double = (CDbl(purchases) / visitors)

        'Dim value = Math.Round(Convert.ToInt32(CurriculumCount) / Convert.ToInt32(CurriculumCompletedCount) * 100)

        Return String.Format("{0:p}", percent)

    End Function

    Function GetInstructorName(ByVal id As String) As String
        Try
            Return (From p In userdb.Instructors Where p.InstructorID = id Select p.InstructorName).FirstOrDefault
        Catch ex As Exception
            Return ""
        End Try

    End Function

    Function GetGroupTitle(ByVal id As String) As String
        Try
            Return (From p In userdb.TestGroups Where p.GroupID = id Select p.GroupTitle).FirstOrDefault
        Catch ex As Exception
            Return ""
        End Try

    End Function

    'Private Sub BindForm(ByVal id As String)

    '    Dim Ambassador = (From p In db.tblAmbassadors Where p.userID = id Select p)

    '    For Each p In Ambassador
    '        Try
    '            FirstName.Text = p.FirstName
    '            LastName.Text = p.LastName
    '            EmailAddress.Text = p.EmailAddress
    '            DateofBirth.Text = p.DOB
    '            Address1.Text = p.Address1
    '            Address2.Text = p.Address2
    '            City.Text = p.City
    '            PhoneNumber.Text = p.Phone
    '            State.Text = p.State
    '            Zip.Text = p.Zip
    '            Gender.Text = p.gender
    '            Citizen.Text = Common.formatBoolean(p.citizen)
    '            Height.Text = p.height
    '            Weight.Text = p.weight
    '            HairColor.Text = p.hairColor
    '            EyeColor.Text = Common.formatBoolean(p.piersings)
    '            Smartphone.Text = Common.formatBoolean(p.smartphone)
    '            SmartphoneOS.Text = p.smartPhoneOS
    '            AvailabilityDate.Text = p.availabilityDate
    '            LGBTAccounts.Text = Common.formatBoolean(p.lgbt)
    '            ReliableTransportation.Text = (p.transportation)
    '            WillingMiles.Text = p.mile

    '            If p.resume = Nothing Then
    '                UploadCurrentResume.Text = "No file uploaded!"
    '            Else
    '                UploadCurrentResume.Text = "Open File"
    '            End If

    '            If p.license = Nothing Then
    '                UploadLicense.Text = "No file uploaded!"
    '            Else
    '                UploadLicense.Text = "Open File"
    '            End If

    '        Catch ex As Exception

    '        End Try

    '    Next


    'End Sub

    Shared Function getCategoryName(ByVal id As Integer) As String
        Dim db As New DataClassesDataContext

        Return (From p In db.tblBrandCategories Where p.brandCategoryID = id Select p.categoryName).FirstOrDefault
    End Function

    Shared Function getEventCategoryName(ByVal id As Integer) As String
        Dim db2 As New DataClassesDataContext

        Return (From p In db2.tblEventTypes Where p.eventTypeID = id Select p.eventTypeName).FirstOrDefault
    End Function

    'Private Sub ActiveCoursesList_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles ActiveCoursesList.ItemCommand
    '    If e.CommandName = "Classroom" Then
    '        Response.Redirect("/application/classroom/lessonplan?CourseID=" & e.CommandArgument)
    '    End If
    'End Sub

    Function getWidgetName(ByVal courseid As String, ByVal name As String) As String

        Return (From p In userdb.CourseWidgets Where p.CourseID = courseid And p.WidgetName = name Select p.Title).FirstOrDefault

    End Function

    Function countTests(ByVal courseid As String) As Integer
        Try
            Return (From p In userdb.TestCount_byCourseIDs Where p.CourseID = courseid Select p.TotalTests).FirstOrDefault

        Catch ex As Exception
            Return 0
        End Try
    End Function


    Function countFiles(ByVal courseid As String) As Integer
        Try
            Return (From p In userdb.CourseFiles_Counts Where p.CourseID = courseid Select p.TotalFiles).FirstOrDefault

        Catch ex As Exception
            Return 0
        End Try
    End Function

    Function countLessons(ByVal courseid As String) As Integer
        Try
            Return (From p In userdb.TotalLessonCount_byCourseIDs Where p.CourseID = courseid Select p.TotalLessons).FirstOrDefault

        Catch ex As Exception
            Return 0
        End Try
    End Function



    'Private Sub ActiveCoursesList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles ActiveCoursesList.ItemDataBound
    '    If ActiveCoursesList.Items.Count < 1 Then

    '        If e.Item.ItemType = ListItemType.Footer Then
    '            Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
    '            lblFooter.Visible = True
    '        End If

    '    End If
    'End Sub

    Function GetTimeAdjustment(ByVal d As Date) As String
        Try
            Dim UserName As String = System.Web.HttpContext.Current.User.Identity.Name
            Dim MyTimeZone As String = (From p In userdb.StudentDetails Where p.UserName = UserName Select p.TimeZone).FirstOrDefault

            Dim cstZone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(MyTimeZone)

            Dim cstTime As DateTime = TimeZoneInfo.ConvertTimeFromUtc(d, cstZone)

            Return String.Format("{0} ({1})", cstTime, ShortTimeZoneFormat(MyTimeZone))
        Catch ex As Exception
            Return d
        End Try

    End Function

    Private Function ShortTimeZoneFormat(timeZoneStandardName As String) As String
        Dim TimeZoneElements As String() = timeZoneStandardName.Split(" "c)
        Dim shortTimeZone As String = [String].Empty
        For Each element As String In TimeZoneElements
            'copies the first element of each word
            shortTimeZone += element(0)
        Next
        Return shortTimeZone
    End Function

    'Private Sub AvailableTestList_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles AvailableTestList.RowDataBound

    '    If e.Row.RowType = DataControlRowType.DataRow Then

    '        Dim Result As String = (DataBinder.Eval(e.Row.DataItem, "TestResult"))
    '        If Result = "Retake Test" Or Result = "Passed" Or Result = "Wait" Or Result = "N/A" Then
    '            e.Row.Visible = False
    '        End If

    '    End If

    'End Sub

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

End Class