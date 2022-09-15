Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class Dashboard1
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim db1 As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Client") Then
            ' students.Visible = False

            'get courseID
            Dim thisCourseID = (From p In db.UserInCourses Where p.UserID = currentUser.Id Select p.CourseID).FirstOrDefault

            CourseTitleLabel.Text = (From p In db.Courses Where p.CourseID = thisCourseID Select p.CourseTitle).FirstOrDefault
            ReqisteredLabel.Text = (From p In db.StudentsInCourses Where p.CourseID = thisCourseID Select p).Count
            CourseGroupCountLabel.Text = (From p In db.CurriculumGroups Where p.CourseID = thisCourseID Select p).Count
            TestCountLabel.Text = (From p In db.Tests Where p.CourseID = thisCourseID Select p).Count


            'Bind CurriculumGroupList
            Dim b = From p In db.CurriculumGroups Where p.CourseID = thisCourseID And p.Enabled = True Order By p.SortOrder Select p

            CurriculumGroupList.DataSource = b
            CurriculumGroupList.DataBind()

            'get the documents

            Dim q = From p In db.CourseFiles
                    Join c In db.Files
                    On c.ID Equals p.FileID
                    Where p.CourseID = thisCourseID
                    Select c.FileName, c.ID, c.Size, c.DateUploaded, c.UploadedBy, c.ContentType, p.FileID

            LibraryFileList.DataSource = q
            LibraryFileList.DataBind()


            Dim l = From p In db.CourseLinks
                    Join c In db.Links
                    On c.ID Equals p.LinkID
                    Where p.CourseID = thisCourseID
                    Select c.LinkTitle, c.ID, c.LinkURL, p.LinkID

            CourseLinksList.DataSource = l
            CourseLinksList.DataBind()

        Else

            MainPanel.Visible = False
            ''get courseID
            '' Dim thisCourseID = supplierIDComboBox.SelectedValue

            'Dim thisCourseID = (From p In db1.tblSuppliers Where p.supplierID = supplierIDComboBox.SelectedValue Select p.CourseID).FirstOrDefault

            'CourseTitleLabel.Text = (From p In db.Courses Where p.CourseID = thisCourseID Select p.CourseTitle).FirstOrDefault
            'ReqisteredLabel.Text = (From p In db.StudentsInCourses Where p.CourseID = thisCourseID Select p).Count
            'CourseGroupCountLabel.Text = (From p In db.CurriculumGroups Where p.CourseID = thisCourseID Select p).Count
            'TestCountLabel.Text = (From p In db.Tests Where p.CourseID = thisCourseID Select p).Count


            ''Bind CurriculumGroupList
            'Dim b = From p In db.CurriculumGroups Where p.CourseID = thisCourseID Order By p.SortOrder Select p

            'CurriculumGroupList.DataSource = b
            'CurriculumGroupList.DataBind()

        End If

    End Sub

    Private Sub CurriculumGroupList_ItemDataBound(sender As Object, e As Telerik.Web.UI.RadListViewItemEventArgs) Handles CurriculumGroupList.ItemDataBound

        If e.Item.ItemType = RadListViewItemType.DataItem OrElse e.Item.ItemType = RadListViewItemType.AlternatingItem Then

            'Find controls
            Dim lblThreadID As Label = DirectCast(e.Item.FindControl("lblCurriculumGroupID"), Label)
            Dim rlvItems As Repeater = DirectCast(e.Item.FindControl("CurriculumGrid"), Repeater)

            'Dim data = From p In db.Curriculums Where p.CurriculumGroupID = lblThreadID.Text And p.Enabled = True Order By p.SortOrder Select p

            'Populate nested grid, filtered by enabled
            Dim result = From p In db.GetCurriculumByCurriculumGroupID(lblThreadID.Text) Where p.Enabled = True Select p

            rlvItems.DataSource = result
            rlvItems.DataBind()


        End If

        'If CurriculumGrid.Items.Count < 1 Then

        '    If e.Item.ItemType = ListItemType.Footer Then
        '        Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
        '        lblFooter.Visible = True
        '    End If

        'End If



    End Sub

    Private Sub BtnSelectSupplier_Click(sender As Object, e As EventArgs) Handles BtnSelectSupplier.Click
        'get courseID
        Dim thisCourseID = (From p In db1.tblSuppliers Where p.supplierID = supplierIDComboBox.SelectedValue Select p.CourseID).FirstOrDefault

        CourseTitleLabel.Text = (From p In db.Courses Where p.CourseID = thisCourseID Select p.CourseTitle).FirstOrDefault
        ReqisteredLabel.Text = (From p In db.StudentsInCourses Where p.CourseID = thisCourseID Select p).Count
        CourseGroupCountLabel.Text = (From p In db.CurriculumGroups Where p.CourseID = thisCourseID Select p).Count
        TestCountLabel.Text = (From p In db.Tests Where p.CourseID = thisCourseID And p.Enabled = True Select p).Count


        'Bind CurriculumGroupList
        Dim b = From p In db.CurriculumGroups Where p.CourseID = thisCourseID And p.Enabled = True Order By p.SortOrder Select p

        CurriculumGroupList.DataSource = b
        CurriculumGroupList.DataBind()

        MainPanel.Visible = True

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        'get the courseID

        Dim i = (From p In db1.tblSuppliers Where p.supplierID = supplierIDComboBox.SelectedValue Select p.CourseID).FirstOrDefault

        BtnEditCourse.NavigateUrl = "http://dashboard.gigengyn.com/account/clientlogin?TokenID=" & currentUser.Id & "&CourseID=" & i

        ' BtnToggleEnabled.Text = ""

        'get the documents

        Dim q = From p In db.CourseFiles
                Join c In db.Files
                On c.ID Equals p.FileID
                Where p.CourseID = i
                Select c.FileName, c.ID, c.Size, c.DateUploaded, c.UploadedBy, c.ContentType, p.FileID

        LibraryFileList.DataSource = q
        LibraryFileList.DataBind()


        Dim l = From p In db.CourseLinks
                Join c In db.Links
                On c.ID Equals p.LinkID
                Where p.CourseID = i
                Select c.LinkTitle, c.ID, c.LinkURL, p.LinkID

        CourseLinksList.DataSource = l
        CourseLinksList.DataBind()

    End Sub

    'Private Sub BtnEdit_Click(sender As Object, e As EventArgs) Handles BtnEdit.Click

    '    Dim manager = New UserManager()
    '    Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

    '    'get the courseID

    '    Dim i = (From p In db1.tblSuppliers Where p.supplierID = supplierIDComboBox.SelectedValue Select p.CourseID).FirstOrDefault

    '    Response.Redirect("http://dashboard.gigengyn.com/account/clientlogin?TokenID=" & currentUser.Id & "&CourseID=" & i)

    '    'courses/brandtraining?CourseID=
    'End Sub
End Class