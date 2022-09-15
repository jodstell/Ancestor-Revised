Public Class CoursesControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'get brands
        Dim r = From p In db.getBrandsForEvents Where p.eventID = Request.QueryString("ID") Select p

        For Each p In r
            '   BrandsLabel.Text = BrandsLabel.Text & String.Format("<h3>{0}</h3>", p.brandName)


            Dim div As New HtmlGenericControl("div")

            Dim lbl As New HtmlGenericControl("h3")
            lbl.InnerHtml = p.brandName
            div.Controls.Add(lbl)

            InsertPlaceHolder.Controls.Add(div)

            'get the curriculium id
            Dim curriculum = (From i In db.tblBrands Where i.brandID = p.brandID Select i.courseGroupID).FirstOrDefault

            Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = curriculum Select l

            If course.Count = 0 Then

                Dim divb As New HtmlGenericControl("div")
                divb.Attributes.Add("class", "form-group")

                Dim lblb As New HtmlGenericControl("label")
                lblb.InnerHtml = "There are no courses currently available"
                divb.Controls.Add(lblb)

                InsertPlaceHolder.Controls.Add(divb)
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

                            box.Attributes("onclick") = String.Format("javascript:void(window.open('/Training/ViewCurriculum.aspx?ID=" & l.CurriculumID & "&p=1','_blank','location=0,menubar=0,status=0,scrollbars=0,resizable=yes,width=650px,height=650px'));")

                            box.Text = String.Format("{0}", l.CurriculumTitle)
                            div1.Controls.Add(box)
                            div.Controls.Add(div1)

                            InsertPlaceHolder.Controls.Add(div1)

                        Case "7"
                            icon = "<i class='fa fa-check-square-o' aria-hidden='true'></i>"

                            Dim lbl1 As New HtmlGenericControl("div")
                            lbl1.Attributes.Add("class", "leftColumn")
                            lbl1.InnerHtml = icon
                            div1.Controls.Add(lbl1)

                            ' Create a text box control
                            Dim box As New HyperLink
                            box.CssClass = "pointer"

                            box.Attributes("onclick") = String.Format("javascript:void(window.open('/Training/ViewTestQuestions.aspx?TestID=" & _testID & "&p=1','_blank','location=0,menubar=0,status=0,scrollbars=0,resizable=yes,width=650px,height=650px'));")

                            box.Text = String.Format("{0}", l.CurriculumTitle)
                            div1.Controls.Add(box)
                            div.Controls.Add(div1)

                            InsertPlaceHolder.Controls.Add(div1)
                    End Select



                Next


            End If








            HiddenBrandID.Value = p.brandID
        Next

        If Not Page.IsPostBack() Then



        End If


    End Sub

    Function getBrandName(id As Integer) As String

        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault & " Brand Recap"
    End Function

    Function getCourseName(id As String) As String



        Return (From p In lmsdb.Curriculums Where p.CurriculumID = id Select p.CurriculumTitle).FirstOrDefault
    End Function

End Class