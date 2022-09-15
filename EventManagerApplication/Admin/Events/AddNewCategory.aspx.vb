Public Class AddNewCategory
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Page.IsPostBack Then

        Else
            'BindForm()
            ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = Common.GetCurrentClientID() Select p.clientName).FirstOrDefault
            'SubCategoryTypeList.EmptyMessage = "Select a category type on the left"
        End If

    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect("/admin/ClientDetails?ClientID=" & Common.GetCurrentClientID() & "&LoadState=Yes#configurationtab/categories")
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        'Dim category As New tblBrandCategory With {
        '    .categoryName = CategoryNameTextBox.Text,
        '    .clientID = Request.QueryString("ClientID")
        '}

        'db.tblBrandCategories.InsertOnSubmit(category)
        'db.SubmitChanges()

        CategoryIDLabel.Text = "1" 'category.brandCategoryID

        'Show sub category panel
        AddCategoryPanel.Visible = False
        SubCategoryPanel.Visible = True
        HeaderLabel.Text = "Add Category Type"

        ' Response.Redirect("/admin/ClientDetails?ClientID=" & Common.GetCurrentClientID() & "&LoadState=Yes#configurationtab/categories")
    End Sub

End Class