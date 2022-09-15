Public Class CourseMaintenance
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub BtnSubmit_Click(sender As Object, e As EventArgs) Handles BtnSubmit.Click

        'loop through the events for selected brand

        Dim q = From i In db.tblEvents Join a In db.tblBrandInEvents On i.eventID Equals a.eventID Where a.brandID = BrandIDTextBox.Text Select i


        RadGrid1.DataSource = q
        RadGrid1.DataBind()

        For Each i In q

            'delete all eventCourse records
            db.deleteEventCourse(Convert.ToInt32(i.eventID))


            'get brands
            Dim r = From p In db.getCourseForEvents Where p.eventID = i.eventID Select p

            Try


                For Each p In r

                    Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Order By l.SortOrder Select l

                    If course.Count = 0 Then

                    Else
                        For Each l In course

                            Dim newCourse As New tblEventCourse
                            newCourse.eventID = i.eventID
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

            Catch ex As Exception

            End Try

        Next


    End Sub

    Function getBrandCourseGroupName(groupID As String) As String
        Return (From p In lmsdb.CurriculumGroups Where p.CurriculumGroupID = groupID Select p.Title).FirstOrDefault

    End Function


End Class