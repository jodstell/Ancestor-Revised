Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.Reflection

Public Class Curriculum2
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim currentPage As String
    Dim totalPages As Integer
    Dim listid As String
    Dim studentGuid As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim c = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p).Count

        Session.Add("CurrentCurriculumID", Request.QueryString("ID"))

        GetCurriculum()
        listid = getlistID()



        'studentGuid = currentUser.UserName

        'If Not Page.IsPostBack Then
        '    'check the self assessment
        '    Try
        '        Dim q = (From p In db.CurruculumAssessments Where p.CurruculumListID = listid And p.StudentID = studentGuid Select p.Assessment).FirstOrDefault

        '        If q = 1 Then
        '            RadioButton1.Checked = True
        '        End If

        '        If q = 2 Then
        '            RadioButton2.Checked = True
        '        End If

        '        If q = 3 Then
        '            RadioButton3.Checked = True
        '        End If
        '    Catch ex As Exception
        '        'do nothing
        '        Response.Write(ex.Message())
        '    End Try
        'End If

        currentPage = Request.QueryString("p")
        totalPages = (From r In db.CurriculumLists Where r.CurriculumID = Request.QueryString("ID") Select r).Count

        PageNumberLabel.Text = currentPage
        TotalPagesLabel.Text = totalPages

        If currentPage = totalPages Then
            buttonNext.Text = "Mark As Read & Continue >>"
            buttonNext3.Text = "Mark As Read & Continue >>"
            btnContinue.Text = "Mark As Read & Continue >>"
            buttonNext2.Text = "Finish"
        End If

        If currentPage = "1" Then
            buttonPrev.Visible = False
            buttonPrev3.Visible = False
            buttonPrev4.Visible = False
        End If

        'show Questions
        Dim type As Integer = (From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p.ContentType).FirstOrDefault

        If Not Page.IsPostBack Then
            If type = "4" Then

                'RadioButtonList1

                AnswerPanel1.Visible = True
                AssessmentPanel.Visible = False
                AssignmentPanel.Visible = False

                'get Questions
                Anwser1.Text = "&nbsp;" & (From r In db.CurriculumLists Where r.CurriculumID = Request.QueryString("ID") And r.Order = Request.QueryString("p") Select r.Answer1).FirstOrDefault
                Anwser2.Text = "&nbsp;" & (From r In db.CurriculumLists Where r.CurriculumID = Request.QueryString("ID") And r.Order = Request.QueryString("p") Select r.Answer2).FirstOrDefault
                Anwser3.Text = "&nbsp;" & (From r In db.CurriculumLists Where r.CurriculumID = Request.QueryString("ID") And r.Order = Request.QueryString("p") Select r.Answer3).FirstOrDefault
                Anwser4.Text = "&nbsp;" & (From r In db.CurriculumLists Where r.CurriculumID = Request.QueryString("ID") And r.Order = Request.QueryString("p") Select r.Answer4).FirstOrDefault

            Else
                AnswerPanel1.Visible = False
                AssessmentPanel.Visible = True
            End If
        End If

        If Not Page.IsPostBack Then
            If type = "5" Then
                AnswerPanel1.Visible = False
                AssessmentPanel.Visible = False
                AssignmentPanel.Visible = True
            End If

        End If


        If Not Page.IsPostBack Then
            If type = "7" Then

                Dim _testID = (From r In db.CurriculumLists Where r.CurriculumID = Request.QueryString("ID") Select r.TestID).FirstOrDefault

                Response.Redirect("/start?id=" & _testID & "&return=1")
            End If

        End If




    End Sub

    Function getDueDate(ByVal id As String) As String
        Try
            Return (From p In db.CourseAssignments Where p.AssignmentID = id Select p.DateDue).FirstOrDefault
        Catch ex As Exception
            Return ""
        End Try

    End Function

    Function GetContentType(ByVal id As String, ByVal number As String) As Boolean

        Dim type = (From p In db.CurriculumLists Where p.CurriculumListID = id Select p.ContentType).FirstOrDefault

        Select Case number
            Case "1"
                If type = number Then
                    Return True
                Else
                    Return False
                End If
            Case "2"
                If type = number Then
                    Return True
                Else
                    Return False
                End If
            Case "3"
                If type = number Then
                    Return True
                Else
                    Return False
                End If

            Case "4"
                If type = number Then
                    Return True
                Else
                    Return False
                End If

            Case "5"
                If type = number Then
                    Return True
                Else
                    Return False
                End If

            Case "6"
                If type = number Then
                    Return True
                Else
                    Return False
                End If

            Case "7"
                If type = number Then
                    Return True
                Else
                    Return False
                End If
            Case Else
                Return False

        End Select


    End Function
    Function GetText(id As String) As String

        Dim type = (From p In db.CurriculumLists Where p.CurriculumListID = id Select p.ContentType).FirstOrDefault

        Select Case type
            Case "1"
                Return (From p In db.CurriculumLists Where p.CurriculumListID = id Select p.Text).FirstOrDefault
            Case "2"
                Return (From p In db.CurriculumLists Where p.CurriculumListID = id Select p.VideoURL).FirstOrDefault
            Case Else
                Return ""
        End Select

    End Function
    Function GetCourseName() As String

        Dim id = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CourseID).FirstOrDefault

        Return (From p In db.Courses Where p.CourseID = id Select p.CourseTitle).FirstOrDefault

    End Function

    Function GetCurriculumName() As String

        Return (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CurriculumTitle).FirstOrDefault

    End Function

    Sub GetCurriculum()

        Dim q = From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p Order By p.Order

        CurriculumFormView.DataSource = q
        CurriculumFormView.DataBind()
    End Sub

    Function getlistID() As String
        Return (From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p.CurriculumListID).FirstOrDefault

    End Function

    Public Sub buttonNext_Click()

        If currentPage = totalPages Then

            'mark complete and return to 
            'get courseID
            Dim id = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CourseID).FirstOrDefault

            Dim InCourseID As String = (From p In db.StudentsInCourses Where p.CourseID = id And p.UserName = Context.User.Identity.Name
                                        Select p.StudentInCourseID).FirstOrDefault

            'check if record exists in curruculumresult
            Dim r = (From p In db.CurriculumResults Where p.StudentInCourseID = InCourseID And p.CurriculumID = Request.QueryString("ID") Select p).Count

            If r = 0 Then
                Dim result As New CurriculumResult With {.CurriculumID = Request.QueryString("ID"),
                                                    .DateCompleted = Date.Now(),
                                                    .StudentInCourseID = InCourseID,
                                                    .Completed = True}

                db.CurriculumResults.InsertOnSubmit(result)
                db.SubmitChanges()

                'create activity log

                Dim log As New ActivityLog
                log.Activity = "Lesson Completed"
                log.ActivityID = 2
                log.LogTime = Date.Now()
                log.UserName = studentGuid
                log.SiteID = ""
                log.IPAddress = Request.UserHostAddress.ToString()
                log.Details = "Lesson Completed"
                log.SessionID = ""
                log.RelatedItemID = listid
                log.RelatedItemType = 2
                log.CourseID = id

                db.ActivityLogs.InsertOnSubmit(log)
                db.SubmitChanges()

            End If



            'update assessment value
            Dim a = (From p In db.CurruculumAssessments Where p.CurruculumListID = listid And p.StudentID = studentGuid Select p).Count

            If a = 0 Then
                'insert
                Dim assessment As New CurruculumAssessment
                assessment.CurruculumListID = listid
                assessment.StudentID = studentGuid
                assessment.DateStamp = Date.Now()
                If RadioButton1.Checked = True Then
                    assessment.Assessment = 1
                End If
                If RadioButton2.Checked = True Then
                    assessment.Assessment = 2
                End If
                If RadioButton3.Checked = True Then
                    assessment.Assessment = 3
                End If

                db.CurruculumAssessments.InsertOnSubmit(assessment)
                db.SubmitChanges()
            End If

            Try
                'update
                Dim assessment = From p In db.CurruculumAssessments Where p.CurruculumListID = listid And p.StudentID = studentGuid Select p

                For Each p In assessment


                    If RadioButton1.Checked = True Then
                        p.Assessment = 1
                        p.DateStamp = Date.Now()
                    End If
                    If RadioButton2.Checked = True Then
                        p.Assessment = 2
                        p.DateStamp = Date.Now()
                    End If
                    If RadioButton3.Checked = True Then
                        p.Assessment = 3
                        p.DateStamp = Date.Now()
                    End If
                Next
                db.SubmitChanges()

            Catch ex As Exception
                Response.Write(ex.Message())
            End Try

            'lookup student in course


            Dim s = (From p In db.StudentsInCourses Where p.UserName = User.Identity.Name And p.StudentInCourseID = InCourseID Select p).FirstOrDefault

            s.PercentComplete = GetPercentCompeted()

            If GetPercentCompeted() = "100" Then
                s.DateCompleted = Date.Now()
                s.Status = 2
            Else
                s.Status = 1
            End If
            db.SubmitChanges()


            Response.Redirect("/application/classroom/lessonplan?CourseID=" & id)

        Else

            'update assessment value
            Dim a = (From p In db.CurruculumAssessments Where p.CurruculumListID = listid And p.StudentID = studentGuid Select p).Count

            If a = 0 Then
                'insert
                Dim assessment As New CurruculumAssessment
                assessment.CurruculumListID = listid
                assessment.StudentID = studentGuid
                assessment.DateStamp = Date.Now()
                If RadioButton1.Checked = True Then
                    assessment.Assessment = 1
                End If
                If RadioButton2.Checked = True Then
                    assessment.Assessment = 2
                End If
                If RadioButton3.Checked = True Then
                    assessment.Assessment = 3
                End If

                db.CurruculumAssessments.InsertOnSubmit(assessment)
                db.SubmitChanges()

            Else


            End If

            Try
                'update
                Dim assessment = From p In db.CurruculumAssessments Where p.CurruculumListID = listid And p.StudentID = studentGuid Select p

                For Each p In assessment


                    If RadioButton1.Checked = True Then
                        p.Assessment = 1
                        p.DateStamp = Date.Now()
                    End If
                    If RadioButton2.Checked = True Then
                        p.Assessment = 2
                        p.DateStamp = Date.Now()
                    End If
                    If RadioButton3.Checked = True Then
                        p.Assessment = 3
                        p.DateStamp = Date.Now()
                    End If
                Next
                db.SubmitChanges()

            Catch ex As Exception
                Response.Write(ex.Message())

                Exit Sub
            End Try

            Dim newPage = Request.QueryString("p") + 1
            Response.Redirect("curriculum?ID=" & Request.QueryString("ID") & "&p=" & newPage)
        End If


    End Sub

    Public Sub buttonPrev_Click()

        Dim newPage = Request.QueryString("p") - 1

        Response.Redirect("curriculum?ID=" & Request.QueryString("ID") & "&p=" & newPage)

    End Sub

    Function CurrentPageNumber() As String

        Dim i = Request.QueryString("p")

        Dim o = (From r In db.CurriculumLists Where r.CurriculumID = Request.QueryString("ID") Select r).Count


        Return i / o * 100

    End Function

    Function CurrentTotalNumber() As String
        Dim i = Request.QueryString("p")

        Dim o = (From r In db.CurriculumLists Where r.CurriculumID = Request.QueryString("ID") Select r).Count

        Dim l = i / o * 100

        Return String.Format("width: {0}%", l)


    End Function

    'Sub Anwser1_CheckedChanged(sender As Object, e As EventArgs) Handles Anwser1.CheckedChanged

    '    ResultLabel.Text = ""

    '    Dim thisvalue As Integer = 1

    '    Dim correctValue As Integer = (From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p.CorrectAnswer).FirstOrDefault

    '    If thisvalue = correctValue Then
    '        ResultLabel.Text = Common.ShowAlert("success", "Yes, that's the correct answer.")
    '    Else
    '        ResultLabel.Text = Common.ShowAlert("warning", "Your answer is incorrect.  Try again.")
    '    End If

    'End Sub

    'Private Sub Anwser2_CheckedChanged(sender As Object, e As EventArgs) Handles Anwser2.CheckedChanged

    '    ResultLabel.Text = ""

    '    Dim thisvalue As Integer = 2

    '    Dim correctValue As Integer = (From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p.CorrectAnswer).FirstOrDefault

    '    If thisvalue = correctValue Then
    '        ResultLabel.Text = Common.ShowAlert("success", "Yes, that's the correct answer.")
    '    Else
    '        ResultLabel.Text = Common.ShowAlert("warning", "Your answer is incorrect.  Try again.")
    '    End If
    'End Sub

    'Private Sub Anwser3_CheckedChanged(sender As Object, e As EventArgs) Handles Anwser3.CheckedChanged

    '    ResultLabel.Text = ""

    '    Dim thisvalue As Integer = 3

    '    Dim correctValue As Integer = (From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p.CorrectAnswer).FirstOrDefault

    '    If thisvalue = correctValue Then
    '        ResultLabel.Text = Common.ShowAlert("success", "Yes, that's the correct answer.")
    '    Else
    '        ResultLabel.Text = Common.ShowAlert("warning", "Your answer is incorrect.  Try again.")
    '    End If
    'End Sub

    'Private Sub Anwser4_CheckedChanged(sender As Object, e As EventArgs) Handles Anwser4.CheckedChanged

    '    ResultLabel.Text = ""

    '    Dim thisvalue As Integer = 4

    '    Dim correctValue As Integer = (From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p.CorrectAnswer).FirstOrDefault

    '    If thisvalue = correctValue Then
    '        ResultLabel.Text = Common.ShowAlert("success", "Yes, that's the correct answer.")
    '    Else
    '        ResultLabel.Text = Common.ShowAlert("warning", "Your answer is incorrect.  Try again.")
    '    End If
    'End Sub



    Private Sub btnFindAnswer_Click(sender As Object, e As EventArgs) Handles btnFindAnswer.Click

        If Anwser1.Checked = True Then
            Dim thisvalue As Integer = 1

            Dim correctValue As Integer = (From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p.CorrectAnswer).FirstOrDefault

            If thisvalue = correctValue Then
                ResultLabel.Text = Common.ShowAlert("success", "Yes, that's the correct answer.")
                btnContinue.Visible = True
                btnFindAnswer.Visible = False
            Else
                ResultLabel.Text = Common.ShowAlert("warning", "Your answer is incorrect.  Try again.")
            End If
        End If

        If Anwser2.Checked = True Then
            Dim thisvalue As Integer = 2

            Dim correctValue As Integer = (From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p.CorrectAnswer).FirstOrDefault

            If thisvalue = correctValue Then
                ResultLabel.Text = Common.ShowAlert("success", "Yes, that's the correct answer.")
                btnContinue.Visible = True
                btnFindAnswer.Visible = False
            Else
                ResultLabel.Text = Common.ShowAlert("warning", "Your answer is incorrect.  Try again.")
            End If
        End If

        If Anwser3.Checked = True Then
            Dim thisvalue As Integer = 3

            Dim correctValue As Integer = (From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p.CorrectAnswer).FirstOrDefault

            If thisvalue = correctValue Then
                ResultLabel.Text = Common.ShowAlert("success", "Yes, that's the correct answer.")
                btnContinue.Visible = True
                btnFindAnswer.Visible = False
            Else
                ResultLabel.Text = Common.ShowAlert("warning", "Your answer is incorrect.  Try again.")
            End If
        End If

        If Anwser4.Checked = True Then
            Dim thisvalue As Integer = 4

            Dim correctValue As Integer = (From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p.CorrectAnswer).FirstOrDefault

            If thisvalue = correctValue Then
                ResultLabel.Text = Common.ShowAlert("success", "Yes, that's the correct answer.")
                btnContinue.Visible = True
                btnFindAnswer.Visible = False
            Else
                ResultLabel.Text = Common.ShowAlert("warning", "Your answer is incorrect.  Try again.")
            End If
        End If



    End Sub

    Private Sub btnContinue_Click(sender As Object, e As EventArgs) Handles btnContinue.Click

        If currentPage = totalPages Then

            'mark complete and return to 
            'get courseID
            Dim id = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CourseID).FirstOrDefault

            ' Dim InCourseID As Integer = (From p In db.StudentsInCourses Where p.CourseID = Request.QueryString("ID") And p.UserName = Context.User.Identity.Name
            '    Select p.StudentInCourseID).FirstOrDefault

            ' Dim id = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CourseID).FirstOrDefault




            Dim InCourseID As String = (From p In db.StudentsInCourses Where p.CourseID = id And p.UserName = Context.User.Identity.Name
                                        Select p.StudentInCourseID).FirstOrDefault

            'check if record exists in curruculumresult
            Dim r = (From p In db.CurriculumResults Where p.StudentInCourseID = InCourseID And p.CurriculumID = Request.QueryString("ID") Select p).Count

            If r = 0 Then
                Dim result As New CurriculumResult With {.CurriculumID = Request.QueryString("ID"),
                                                                    .DateCompleted = Date.Now(),
                                                                    .StudentInCourseID = InCourseID,
                                                                    .Completed = True}

                db.CurriculumResults.InsertOnSubmit(result)
                db.SubmitChanges()

                'create activity log

                Dim log As New ActivityLog
                log.Activity = "Lesson Completed"
                log.ActivityID = 2
                log.LogTime = Date.Now()
                log.UserName = studentGuid
                log.SiteID = ""
                log.IPAddress = Request.UserHostAddress.ToString()
                log.Details = "Lesson Completed"
                log.SessionID = ""
                log.RelatedItemID = listid
                log.RelatedItemType = 2
                log.CourseID = id

                db.ActivityLogs.InsertOnSubmit(log)
                db.SubmitChanges()

            End If



            Dim s = (From p In db.StudentsInCourses Where p.UserName = User.Identity.Name And p.StudentInCourseID = InCourseID Select p).FirstOrDefault

            s.PercentComplete = GetPercentCompeted()

            If GetPercentCompeted() = "100" Then
                s.DateCompleted = Date.Now()
                s.Status = 2
            Else
                s.Status = 1
            End If
            db.SubmitChanges()

            Response.Redirect("/application/classroom/lessonplan?CourseID=" & id)

        Else

            Dim newPage = Request.QueryString("p") + 1
            Response.Redirect("curriculum?ID=" & Request.QueryString("ID") & "&p=" & newPage)
        End If

    End Sub

    Function GetPercentCompeted() As String

        Dim id = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CourseID).FirstOrDefault

        Dim _studentInCourseID = (From p In db.StudentsInCourses Where p.CourseID = id And p.UserName = Context.User.Identity.Name Select p.StudentInCourseID).FirstOrDefault
        Dim completed = (From p In db.CurriculumResults Where p.StudentInCourseID = _studentInCourseID And p.Completed = True Select p).Count
        Dim total = (From p In db.Curriculums Where p.CourseID = id Select p).Count

        Return completed / total * 100
    End Function

    Public Sub btnCancel_Click()
        Dim id = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CourseID).FirstOrDefault

        Response.Redirect("/application/classroom/lessonplan?CourseID=" & id)
    End Sub

    Private Sub btnCancel2_Click(sender As Object, e As EventArgs) Handles btnCancel2.Click
        Dim id = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CourseID).FirstOrDefault

        Response.Redirect("/application/classroom/lessonplan?CourseID=" & id)
    End Sub

End Class