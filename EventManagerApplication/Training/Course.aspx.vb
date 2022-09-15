Imports System.Net
Imports System.Web.Script.Serialization
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports iTextSharp.text.pdf
Imports iTextSharp.text
Imports System.IO
Imports Telerik.Web.UI

Public Class CourseTraining
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext
    Dim eventID As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'get the token
        Dim mytoken As String = Request.QueryString("Token")

        'check if email belongs to a BA
        Dim q = (From p In db.tblEventTrainingInvitations Where p.token = mytoken Select p).FirstOrDefault

        If Not q Is Nothing Then
            Dim HasLogin As Integer = (From i In lmsdb.AspNetUsers Where i.Email = q.emailAddress Select i.Id).Count

            If HasLogin > 0 Then
                Response.Redirect("/application/classroom/lessonplan?CourseID=" & getCourseID(q.eventID))
            End If

            eventID = q.eventID

            ' BindCourses()

            'show temp panel
            MainPanel.Visible = False
            NotValidPanel.Visible = True

        Else
            'msgLabel.Text = "The token is not valid"


            'show not valid panel
            MainPanel.Visible = False
            NotValidPanel.Visible = True

        End If


    End Sub

    Function getCourseID(id As String) As String

        Return (From p In db.getCourseForEvents Where p.eventID = id Select p.courseID).FirstOrDefault


    End Function
    Sub BindCourses()

        'get brands
        Dim r = From p In db.getCourseForEvents Where p.eventID = eventID Select p

        For Each p In r
            '   BrandsLabel.Text = BrandsLabel.Text & String.Format("<h3>{0}</h3>", p.brandName)

            Dim div As New HtmlGenericControl("div")

            Dim lbl As New HtmlGenericControl("h3")
            lbl.InnerHtml = getCourseTitle(p.courseID)
            div.Controls.Add(lbl)

            CoursesPlaceHolder.Controls.Add(div)

            'get the curriculum id
            '  Dim curriculum = (From i In db.tblBrands Where i.brandID = p.brandID Select i.courseGroupID).FirstOrDefault

            Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Order By l.SortOrder Select l

            If course.Count = 0 Then

                Dim divb As New HtmlGenericControl("div")
                divb.Attributes.Add("class", "form-group")

                Dim lblb As New HtmlGenericControl("label")
                lblb.InnerHtml = "There are no courses currently available"
                divb.Controls.Add(lblb)

                CoursesPlaceHolder.Controls.Add(divb)
            Else
                For Each l In course
                    Dim div1 As New HtmlGenericControl("div")

                    Dim type = (From u In lmsdb.CurriculumLists Where u.CurriculumID = l.CurriculumID Select u.ContentType).FirstOrDefault
                    Dim _testID = (From u In lmsdb.CurriculumLists Where u.CurriculumID = l.CurriculumID Select u.TestID).FirstOrDefault

                    Dim icon As String = ""

                    Select Case type
                        Case "1"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='True'></i>"

                            Dim lbl1 As New HtmlGenericControl("div")
                            lbl1.Attributes.Add("class", "leftColumn")
                            lbl1.InnerHtml = icon
                            div1.Controls.Add(lbl1)

                            ' Create a text box control
                            Dim box As New HyperLink
                            box.CssClass = "pointer"


                            box.NavigateUrl = String.Format("/training/curriculum?Token={1}&ID={0}&p=1", l.CurriculumID, Request.QueryString("Token"))


                            box.Text = String.Format("{0}", l.CurriculumTitle)
                            div1.Controls.Add(box)
                            div.Controls.Add(div1)

                            CoursesPlaceHolder.Controls.Add(div1)

                        Case "2"
                            icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

                            Dim lbl1 As New HtmlGenericControl("div")
                            lbl1.Attributes.Add("class", "leftColumn")
                            lbl1.InnerHtml = icon
                            div1.Controls.Add(lbl1)

                            ' Create a text box control
                            Dim box As New HyperLink
                            box.CssClass = "pointer"



                            box.NavigateUrl = String.Format("/training/curriculum?Token={1}&ID={0}&p=1", l.CurriculumID, Request.QueryString("Token"))

                            box.Text = String.Format("{0}", l.CurriculumTitle)
                            div1.Controls.Add(box)
                            div.Controls.Add(div1)

                            CoursesPlaceHolder.Controls.Add(div1)

                        Case "3"
                            icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

                            Dim lbl1 As New HtmlGenericControl("div")
                            lbl1.Attributes.Add("class", "leftColumn")
                            lbl1.InnerHtml = icon
                            div1.Controls.Add(lbl1)

                            ' Create a text box control
                            Dim box As New HyperLink
                            box.CssClass = "pointer"



                            box.NavigateUrl = String.Format("/training/curriculum?Token={1}&ID={0}&p=1", l.CurriculumID, Request.QueryString("Token"))



                            box.Text = String.Format("{0}", l.CurriculumTitle)
                            div1.Controls.Add(box)
                            div.Controls.Add(div1)

                            CoursesPlaceHolder.Controls.Add(div1)

                        Case "4"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                            Dim lbl1 As New HtmlGenericControl("div")
                            lbl1.Attributes.Add("class", "leftColumn")
                            lbl1.InnerHtml = icon
                            div1.Controls.Add(lbl1)

                            ' Create a text box control
                            Dim box As New HyperLink
                            box.CssClass = "pointer"

                            ' if student then

                            box.NavigateUrl = String.Format("/training/curriculum?Token={1}&ID={0}&p=1", l.CurriculumID, Request.QueryString("Token"))

                            box.Text = String.Format("{0}", l.CurriculumTitle)
                            div1.Controls.Add(box)
                            div.Controls.Add(div1)

                            CoursesPlaceHolder.Controls.Add(div1)

                        Case "5"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                            Dim lbl1 As New HtmlGenericControl("div")
                            lbl1.Attributes.Add("class", "leftColumn")
                            lbl1.InnerHtml = icon
                            div1.Controls.Add(lbl1)

                            ' Create a text box control
                            Dim box As New HyperLink
                            box.CssClass = "pointer"


                            box.NavigateUrl = String.Format("/training/curriculum?Token={1}&ID={0}&p=1", l.CurriculumID, Request.QueryString("Token"))

                            box.Text = String.Format("{0}", l.CurriculumTitle)
                            div1.Controls.Add(box)
                            div.Controls.Add(div1)

                            CoursesPlaceHolder.Controls.Add(div1)

                        Case "6"
                            icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                            Dim lbl1 As New HtmlGenericControl("div")
                            lbl1.Attributes.Add("class", "leftColumn")
                            lbl1.InnerHtml = icon
                            div1.Controls.Add(lbl1)

                            ' Create a text box control
                            Dim box As New HyperLink
                            box.CssClass = "pointer"


                            box.NavigateUrl = String.Format("/training/curriculum?Token={1}&ID={0}&p=1", l.CurriculumID, Request.QueryString("Token"))


                            box.Text = String.Format("{0}", l.CurriculumTitle)
                            div1.Controls.Add(box)
                            div.Controls.Add(div1)

                            CoursesPlaceHolder.Controls.Add(div1)

                        Case "7"
                            icon = "<i class='fa fa-check-square-o' aria-hidden='true'></i>"

                            Dim lbl1 As New HtmlGenericControl("div")
                            lbl1.Attributes.Add("class", "leftColumn")
                            lbl1.InnerHtml = icon
                            div1.Controls.Add(lbl1)

                            ' Create a text box control
                            Dim box As New HyperLink
                            box.CssClass = "pointer"


                            box.NavigateUrl = String.Format("/training/curriculum?Token={1}&ID={0}&p=1", l.CurriculumID, Request.QueryString("Token"))





                            box.Text = String.Format("{0}", l.CurriculumTitle)
                            div1.Controls.Add(box)
                            div.Controls.Add(div1)

                            CoursesPlaceHolder.Controls.Add(div1)
                    End Select

                Next

            End If

        Next

    End Sub

    Function getCourseTitle(ByVal id As String) As String
        Return (From p In lmsdb.Courses Where p.CourseID = id Select p.CourseTitle).FirstOrDefault
    End Function

End Class