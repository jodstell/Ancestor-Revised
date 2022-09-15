Imports System.Globalization
Imports System.Threading
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Telerik.Web.UI

Public Class ViewAmbassadorDetails
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim userdb As New LMSDataClassesDataContext

    Protected Function CreateWindowScript(ByVal userID As String, ByVal image As Integer) As String
        Return String.Format("var win = window.radopen('/Profile_Image.aspx?image={1}&UserID={0}','Details');win.center();", userID, image)
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session.Add("CurrentUserID", Request.QueryString("UserID"))

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(Request.QueryString("UserID"))
            Guid.Value = currentUser.UserName

            Session.Add("CurrentUserName", currentUser.UserName)

            'Administrator, Recruiter/Booking, EventManager
            If Not manager.IsInRole(currentUser.Id, "Administrator") Or manager.IsInRole(currentUser.Id, "Recruiter/Booking") Or manager.IsInRole(currentUser.Id, "EventManager") Then
                ButtonPanel.Visible = True
            End If

        Catch ex As Exception

        End Try

        ' AvailableCountLabel.Text = (From p In db.GetAvailableEventsbyAmbassador(Request.QueryString("UserID")) Select p).Count
        RecapCountLabel.Text = (From p In db.qryViewNeedsRecapEventsByAmbassadors Where p.userID = Request.QueryString("UserID") Select p).Count
        UpcomingCountLabel.Text = (From p In db.qryViewCurrentEventsByAmbassadors Where p.userID = Request.QueryString("UserID") Select p).Count
        PreviousCountLabel.Text = (From p In db.qryViewPastEventsByAmbassadors Where p.userID = Request.QueryString("UserID") Select p).Count


        'team label
        Dim q = (From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault()
        Dim team = (From p In db.tblTeams Where p.teamID = q.teamID Select p).FirstOrDefault()

        Try
            lblTeam.Text = team.teamName
        Catch ex As Exception

        End Try






        Dim action = Request.QueryString("action")

        Select Case action
            Case 0
            Case 1
                msgLabel2.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
        End Select

        If Not Page.IsPostBack Then

            Dim userid As String = Request.QueryString("UserID")
            BindForm(userid)

            Dim ambassador = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault

            If ambassador.Status = "Terminated" Then
                btnReactivate.Visible = True
            Else
                btnReactivate.Visible = False
            End If


            AccountNameLabel.Text = String.Format("{0} {1}", StrConv(ambassador.FirstName, VbStrConv.ProperCase), StrConv(ambassador.LastName, VbStrConv.ProperCase))

            CreatedDateLabel.Text = Common.GetTimeAdjustment(ambassador.LastLoginDate)
            Try
                LastUpdateLabel.Text = Common.GetTimeAdjustment(ambassador.modifiedDate)

            Catch ex As Exception

            End Try

            Try
                Dim birthDate As Date
                birthDate = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p.DOB).FirstOrDefault

            Catch ex As Exception

            End Try

            Try
                ActivityDateLabel.Text = Common.GetTimeAdjustment((From p In db.tblProfiles Where p.userID = Request.QueryString("UserID") Select p.lastActivityDate).FirstOrDefault)

            Catch ex As Exception
                ActivityDateLabel.Text = "Error"
            End Try

        End If







    End Sub

    Function getCourseTitle(ByVal courseID As String) As String

        Try
            Return (From p In userdb.Courses Where p.CourseID = courseID Select p.CourseTitle).FirstOrDefault

        Catch ex As Exception
            Return "Error"
        End Try

    End Function

    Function GetPercentCompeted(courseID As String) As String
        'Try
        '    Dim _studentInCourseID = (From p In userdb.StudentsInCourses Where p.CourseID = courseID And p.UserName = Context.User.Identity.Name Select p.StudentInCourseID).FirstOrDefault

        '    Dim completed = (From p In userdb.CurriculumResults Where p.StudentInCourseID = _studentInCourseID And p.Completed = True Select p).Count
        '    Dim total = (From p In userdb.Curriculums Where p.CourseID = courseID Select p).Count

        '    ' Return String.Format("{0:###}%", completed / total * 100)

        '    Return _studentInCourseID
        'Catch ex As Exception

        'End Try

    End Function

    Function getTestsComplete(courseID) As String
        'Dim result = From p In userdb.baretc_BrandTrainingResultByCourseID(Context.User.Identity.GetUserId(), courseID) Select p

        'For Each p In result
        '    Return "<b>" & p.PassedCount & "</b> out of <b>" & p.TestCount & "</b> Complete"
        'Next


    End Function
    Function calculatPercentComplete(courseID) As String
        'Try
        '    Dim result = From p In userdb.baretc_BrandTrainingResultByCourseID(Context.User.Identity.GetUserId(), courseID) Select p
        '    Dim totalCount As Integer
        '    Dim completeCount As Integer

        '    For Each p In result
        '        totalCount = p.CurriculumCount
        '        completeCount = p.CurriculumCompletedCount
        '    Next

        '    Dim percent As Double = (CDbl(totalCount) / completeCount)

        '    'Return String.Format("{0:p}", totalCount / completeCount * 100)

        '    Return "<b>" & completeCount & "</b> out of <b>" & totalCount & "</b> Complete"

        '    ' Return completeCount

        'Catch ex As Exception
        '    Return "0.00 %"
        'End Try


    End Function


    Private Sub BindForm(ByVal id As String)

        '  btnDownloadResume.NavigateUrl = "/ambassadors/GetResume?UserID=" & Request.QueryString("UserID") & "&file=resume"
        ' btnDownloadLicense.NavigateUrl = "/ambassadors/GetLicense?UserID=" & Request.QueryString("UserID") & "&file=license"

        ' AddressVerifiedCheckBox.Checked = True


        'ambassador password
        Try
            Dim profile = (From r In db.tblProfiles Where r.userID = id Select r).FirstOrDefault

            PasswordLabel.Text = profile.userGUID
        Catch ex As Exception

        End Try

        'ambassador info
        Dim Ambassador = (From p In db.tblAmbassadors Where p.userID = id Select p)

        For Each p In Ambassador
            Try

                FirstName.Text = StrConv(p.FirstName, VbStrConv.ProperCase)
                LastName.Text = StrConv(p.LastName, VbStrConv.ProperCase)

                StatusLabel.Text = p.Status
                PortalLoginLabel.Text = p.userName
                EmailAddress.Text = p.EmailAddress
                DateofBirth.Text = String.Format("{0:d}", p.DOB)
                Address1.Text = p.Address1
                Address2.Text = p.Address2
                City.Text = p.City
                PhoneNumber.Text = Common.FormatPhoneNumber(p.Phone)
                State.Text = p.State
                Zip.Text = p.Zip
                Gender.Text = p.gender
                Citizen.Text = Common.formatBoolean(p.citizen)
                Height.Text = p.height
                Weight.Text = p.weight
                HairColor.Text = p.hairColor
                EyeColor.Text = p.eyeColor
                Piercings.Text = Common.formatBoolean(p.piersings)
                Smartphone.Text = Common.formatBoolean(p.smartphone)
                SmartphoneOS.Text = p.smartPhoneOS
                AvailabilityDate.Text = p.availabilityDate
                LGBTAccounts.Text = Common.formatBoolean(p.lgbt)
                ReliableTransportation.Text = Common.formatBoolean(p.transportation)
                WillingMiles.Text = p.mile

                If p.latitude > 0 Then
                    AddressVerifiedCheckBox.Checked = True
                Else
                    AddressVerifiedCheckBox.Checked = False
                End If


                'If p.resume = Nothing Then
                '    ResumeLabel.Visible = True
                '    btnDownloadResume.Visible = False
                'Else
                '    ResumeLabel.Visible = False
                '    btnDownloadResume.Visible = True
                'End If

                'If p.license = Nothing Then
                '    Licenselabel.Visible = True
                '    btnDownloadLicense.Visible = False
                'Else
                '    Licenselabel.Visible = False
                '    btnDownloadLicense.Visible = True
                'End If

            Catch ex As Exception

            End Try

        Next


    End Sub

    Function getRequiredCurriculumCount(ByVal courseID As String) As String

        Try
            Dim db As New DataClassesDataContext
            Dim dbUser As New LMSDataClassesDataContext

            Dim userID As String = Request.QueryString("UserID")

            Dim courseGroup = (From p In db.GetAmbassadorEventsWithBrands(userID) Where p.courseID = courseID Select p.courseGroupID).FirstOrDefault

            Dim trainingLabel As String = ""

            Dim result = (From r In dbUser.Curriculums Where r.CurriculumGroupID = courseGroup Select r)
            For Each r In result

                Dim c = (From p In dbUser.Curriculums Where p.CurriculumGroupID = r.CurriculumGroupID Select p).Count
                Dim t = getResultCount(r.CurriculumID, userID, courseID)

                If c = t Then
                    'do nothing
                Else
                    Return "<p class='text-danger' style='font-size:x-small'><i class='fa fa-exclamation-triangle' aria-hidden='true'></i> Training Required</p>"
                End If
                trainingLabel = getResultCount(r.CurriculumID, userID, courseID) & " " & c

            Next

            Return trainingLabel
        Catch ex As Exception
            Return "Error"
        End Try


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
            Return "Error"
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
            Return "Error"
        End Try


    End Function


    Shared Function getCategoryName(ByVal id As Integer) As String
        Try
            Dim db As New DataClassesDataContext

            Return (From p In db.tblBrandCategories Where p.brandCategoryID = id Select p.categoryName).FirstOrDefault
        Catch ex As Exception
            Return "Error"
        End Try

    End Function

    Shared Function getEventCategoryName(ByVal id As Integer) As String
        Try
            Dim db2 As New DataClassesDataContext

            Return (From p In db2.tblEventTypes Where p.eventTypeID = id Select p.eventTypeName).FirstOrDefault
        Catch ex As Exception
            Return "Error"
        End Try

    End Function


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

    Function calculatPersentComplete(CurriculumCompletedCount As String, CurriculumCount As String) As String

        Try
            Dim _CurriculumCount As Integer = Convert.ToInt32(CurriculumCount)
            Dim _CurriculumCompletedCount As Integer = Convert.ToInt32(CurriculumCompletedCount)

            Dim percent As Double = (CDbl(_CurriculumCount) / _CurriculumCompletedCount)

            Return String.Format("{0:p}", percent)
        Catch ex As Exception
            Return "Error"
        End Try


    End Function

    Private Sub NeedsRecapEventsList_ItemDataBound(sender As Object, e As RadListViewItemEventArgs) Handles NeedsRecapEventsList.ItemDataBound

    End Sub

    Private Sub ResumeList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles ResumeList.ItemDataBound
        If ResumeList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If
        End If
    End Sub

    Private Sub LicenseList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles LicenseList.ItemDataBound
        If LicenseList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If
    End Sub

    Private Sub btnDeleteAmbassador_Click(sender As Object, e As EventArgs) Handles btnDeleteAmbassador.Click

        db.DeleteAmbassador(Request.QueryString("UserID"))

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Request.QueryString("UserID"))
        manager.Delete(currentUser)

        Response.Redirect("/Ambassadors/ActiveList?action=0")

    End Sub

    Private Sub btnReactivate_Click(sender As Object, e As EventArgs) Handles btnReactivate.Click

        Dim a = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p).FirstOrDefault

        a.Status = "Active"
        db.SubmitChanges()

        Response.Redirect("/ambassadors/ViewAmbassadorDetails?UserID=" & Request.QueryString("UserID"))


    End Sub

    Private Sub btnChangePass_Click(sender As Object, e As EventArgs) Handles btnChangePass.Click

        MainPanel.Visible = False
        ChangePasswordPanel.Visible = True

    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click

        Try
            Dim user As String = Request.QueryString("UserID")

            Dim oldPassword = (From r In db.tblProfiles Where r.userID = user Select r.userGUID).FirstOrDefault
            errorLabel.Text = oldPassword

            ' If IsValid Then
            Dim manager1 = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim signInManager = Context.GetOwinContext().Get(Of ApplicationSignInManager)()
            Dim result As IdentityResult = manager1.ChangePassword(user, oldPassword, NewPasswordTextBox.Text)
            If result.Succeeded Then
                Dim userInfo = manager1.FindById(user)
                ' signInManager.SignIn(userInfo, isPersistent:=False, rememberBrowser:=False)

                Dim q = (From p In db.tblProfiles Where p.userID = user Select p).FirstOrDefault
                q.userGUID = NewPasswordTextBox.Text
                db.SubmitChanges()

                PasswordLabel.Text = NewPasswordTextBox.Text

                msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
            Else

                msgLabel.Text = Common.ShowAlert("warning", result.Errors.FirstOrDefault())
            End If
            ' End If

            NewPasswordTextBox.Text = ""
            ConfirmTextBox.Text = ""

            ChangePasswordPanel.Visible = False
            MainPanel.Visible = True
        Catch ex As Exception
            errorLabel.Text = ex.Message()
        End Try


    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click

        ChangePasswordPanel.Visible = False
        MainPanel.Visible = True

    End Sub

End Class