Public Class EditCategory
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack Then

        Else
            BindForm()
            ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = Common.GetCurrentClientID() Select p.clientName).FirstOrDefault
            SubCategoryTypeList.EmptyMessage = "Select a category type on the left"
        End If




    End Sub

    Private Sub BtnCancel_Click(sender As Object, e As EventArgs) Handles BtnCancel.Click
        Response.Redirect("/admin/ClientDetails?ClientID=" & Common.GetCurrentClientID() & "&LoadState=Yes#configurationtab/categories")
    End Sub

    Private Sub BindForm()

        Dim result = From p In db.tblBrandCategories Where p.brandCategoryID = Request.QueryString("BrandCategoryID")
        For Each p In result
            CategoryNameLabel.Text = p.categoryName
            CategoryNameTextBox.Text = p.categoryName

            Try
                ModifiedByLabel.Text = String.Format("Last modified by {0} on {1}", Common.GetFullName(p.modifiedBy), Common.GetTimeAdjustment(p.modifiedDate))
            Catch ex As Exception

            End Try
        Next

    End Sub

    Private Sub BindCategorySubType()

        Dim result = From p In db.tblBrandCategorySubTypes Where p.brandCategoryTypeID = SubCategoryTypeList.SelectedValue

        SubCategoryTypeList.DataSource = result

        SubCategoryTypeList.DataBind()


    End Sub


    Protected Sub CategoryTypeList_SelectedIndexChanged(sender As Object, e As EventArgs)
        ' Label1.Text = "You have selected item : " + CategoryTypeList.SelectedItem.Text

        Dim result = From p In db.tblBrandCategorySubTypes Where p.brandCategoryTypeID = CategoryTypeList.SelectedValue

        SubCategoryTypeList.DataSource = result

        SubCategoryTypeList.DataBind()


    End Sub

    Private Sub BtnAddCategoryType_Click(sender As Object, e As EventArgs) Handles BtnAddCategoryType.Click

    End Sub

    Private Sub BtnAddVariety_Click(sender As Object, e As EventArgs) Handles BtnAddVariety.Click

    End Sub
End Class