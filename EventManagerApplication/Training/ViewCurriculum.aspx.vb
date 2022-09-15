Public Class ViewCurriculum
    Inherits System.Web.UI.Page
    Dim currentPage As String
    Dim totalPages As Integer
    Dim db As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim c = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p).Count

        GetCurriculum()

        currentPage = Request.QueryString("p")
        totalPages = (From r In db.CurriculumLists Where r.CurriculumID = Request.QueryString("ID") Select r).Count

        PageNumberLabel.Text = currentPage
        TotalPagesLabel.Text = totalPages


        If currentPage = 1 Then
            btnPrev.Visible = False
        End If

        If currentPage = totalPages Then
            btnNext.Visible = False
        End If

    End Sub

    Sub GetCurriculum()

        Dim q = From p In db.CurriculumLists Where p.CurriculumID = Request.QueryString("ID") And p.Order = Request.QueryString("p") Select p Order By p.Order

        CurriculumFormView.DataSource = q
        CurriculumFormView.DataBind()
    End Sub


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

    Public Sub buttonNext_Click()


        'If currentPage = totalPages Then

        '    'mark complete and return to 
        '    'get courseID
        '    Dim id = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CourseID).FirstOrDefault

        '    Dim InCourseID As String = (From p In db.StudentsInCourses Where p.CourseID = id And p.UserName = Context.User.Identity.Name
        '                                Select p.StudentInCourseID).FirstOrDefault

        '    'check if record exists in curruculumresult
        '    Dim r = (From p In db.CurriculumResults Where p.StudentInCourseID = InCourseID And p.CurriculumID = Request.QueryString("ID") Select p).Count

        '    If r = 0 Then
        '        Dim result As New CurriculumResult With {.CurriculumID = Request.QueryString("ID"),
        '                                            .DateCompleted = Date.Now(),
        '                                            .StudentInCourseID = InCourseID,
        '                                            .Completed = True}

        '        db.CurriculumResults.InsertOnSubmit(result)
        '        db.SubmitChanges()

        '        'create activity log

        '        Dim log As New ActivityLog
        '        log.Activity = "Lesson Completed"
        '        log.ActivityID = 2
        '        log.LogTime = Date.Now()
        '        log.UserName = studentGuid
        '        log.SiteID = ""
        '        log.IPAddress = Request.UserHostAddress.ToString()
        '        log.Details = "Lesson Completed"
        '        log.SessionID = ""
        '        log.RelatedItemID = listid
        '        log.RelatedItemType = 2
        '        log.CourseID = id

        '        db.ActivityLogs.InsertOnSubmit(log)
        '        db.SubmitChanges()

        '    End If



        '    'update assessment value
        '    Dim a = (From p In db.CurruculumAssessments Where p.CurruculumListID = listid And p.StudentID = studentGuid Select p).Count

        '    If a = 0 Then
        '        'insert
        '        Dim assessment As New CurruculumAssessment
        '        assessment.CurruculumListID = listid
        '        assessment.StudentID = studentGuid
        '        assessment.DateStamp = Date.Now()
        '        If RadioButton1.Checked = True Then
        '            assessment.Assessment = 1
        '        End If
        '        If RadioButton2.Checked = True Then
        '            assessment.Assessment = 2
        '        End If
        '        If RadioButton3.Checked = True Then
        '            assessment.Assessment = 3
        '        End If

        '        db.CurruculumAssessments.InsertOnSubmit(assessment)
        '        db.SubmitChanges()
        '    End If

        '    Try
        '        'update
        '        Dim assessment = From p In db.CurruculumAssessments Where p.CurruculumListID = listid And p.StudentID = studentGuid Select p

        '        For Each p In assessment


        '            If RadioButton1.Checked = True Then
        '                p.Assessment = 1
        '                p.DateStamp = Date.Now()
        '            End If
        '            If RadioButton2.Checked = True Then
        '                p.Assessment = 2
        '                p.DateStamp = Date.Now()
        '            End If
        '            If RadioButton3.Checked = True Then
        '                p.Assessment = 3
        '                p.DateStamp = Date.Now()
        '            End If
        '        Next
        '        db.SubmitChanges()

        '    Catch ex As Exception
        '        Response.Write(ex.Message())
        '    End Try

        '    'lookup student in course


        '    Dim s = (From p In db.StudentsInCourses Where p.UserName = User.Identity.Name And p.StudentInCourseID = InCourseID Select p).FirstOrDefault

        '    s.PercentComplete = GetPercentCompeted()

        '    If GetPercentCompeted() = "100" Then
        '        s.DateCompleted = Date.Now()
        '        s.Status = 2
        '    Else
        '        s.Status = 1
        '    End If
        '    db.SubmitChanges()


        '    Response.Redirect("/application/classroom/lessonplan?CourseID=" & id)

        'Else

        '    'update assessment value
        '    Dim a = (From p In db.CurruculumAssessments Where p.CurruculumListID = listid And p.StudentID = studentGuid Select p).Count

        '    If a = 0 Then
        '        'insert
        '        Dim assessment As New CurruculumAssessment
        '        assessment.CurruculumListID = listid
        '        assessment.StudentID = studentGuid
        '        assessment.DateStamp = Date.Now()
        '        If RadioButton1.Checked = True Then
        '            assessment.Assessment = 1
        '        End If
        '        If RadioButton2.Checked = True Then
        '            assessment.Assessment = 2
        '        End If
        '        If RadioButton3.Checked = True Then
        '            assessment.Assessment = 3
        '        End If

        '        db.CurruculumAssessments.InsertOnSubmit(assessment)
        '        db.SubmitChanges()

        '    Else


        '    End If

        '    Try
        '        'update
        '        Dim assessment = From p In db.CurruculumAssessments Where p.CurruculumListID = listid And p.StudentID = studentGuid Select p

        '        For Each p In assessment


        '            If RadioButton1.Checked = True Then
        '                p.Assessment = 1
        '                p.DateStamp = Date.Now()
        '            End If
        '            If RadioButton2.Checked = True Then
        '                p.Assessment = 2
        '                p.DateStamp = Date.Now()
        '            End If
        '            If RadioButton3.Checked = True Then
        '                p.Assessment = 3
        '                p.DateStamp = Date.Now()
        '            End If
        '        Next
        '        db.SubmitChanges()

        '    Catch ex As Exception
        '        Response.Write(ex.Message())

        '        Exit Sub
        '    End Try

        'Dim newPage = Request.QueryString("p") + 1
        'Response.Redirect("ViewCurriculum?ID=" & Request.QueryString("ID") & "&p=" & newPage)
        '   End If


    End Sub

    Public Sub buttonPrev_Click()

        '    Dim newPage = Request.QueryString("p") - 1

        '    Response.Redirect("ViewCurriculum?ID=" & Request.QueryString("ID") & "&p=" & newPage)

    End Sub


    'Public Sub btnCancel_Click()
    '    Dim id = (From p In db.Curriculums Where p.CurriculumID = Request.QueryString("ID") Select p.CourseID).FirstOrDefault

    '    Response.Redirect("/application/classroom/lessonplan?CourseID=" & id)
    'End Sub

    Private Sub btnNext_Click(sender As Object, e As EventArgs) Handles btnNext.Click
        Dim newPage = Request.QueryString("p") + 1
        Response.Redirect("ViewCurriculum?ID=" & Request.QueryString("ID") & "&p=" & newPage)

    End Sub

    Private Sub btnPrev_Click(sender As Object, e As EventArgs) Handles btnPrev.Click
        Dim newPage = Request.QueryString("p") - 1

        Response.Redirect("ViewCurriculum?ID=" & Request.QueryString("ID") & "&p=" & newPage)

    End Sub

End Class