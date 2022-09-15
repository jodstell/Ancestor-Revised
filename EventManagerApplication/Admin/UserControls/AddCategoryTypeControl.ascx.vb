Public Class AddCategoryTypeControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            TempCategoryIDHiddenField1.Text = System.Guid.NewGuid.ToString()

            CategoryTypeList.EmptyMessage = "Add a Category Type above"
            SubCategoryTypeList.EmptyMessage = "Select a category type on the left"

        End If
    End Sub

    Private Sub BtnAddCategoryType_Click(sender As Object, e As EventArgs) Handles BtnAddCategoryType.Click

        Dim newItem As New tempBrandCategoryType With {
            .tempBrandCategoryID = TempCategoryIDHiddenField1.Text,
            .categoryTypeName = CategoryTypeTextBox.Text,
            .clientID = Request.QueryString("ClientID")
            }

        db.tempBrandCategoryTypes.InsertOnSubmit(newItem)
        db.SubmitChanges()

        CategoryTypeList.DataBind()
        getTempCategoryTypeList.DataBind()
        CategoryTypeTextBox.Text = ""

    End Sub

    Private Sub BtnAddVariety_Click(sender As Object, e As EventArgs) Handles BtnAddVariety.Click
        'add to tempVariety

        Dim SelectedCategoryTypeID As Integer = CategoryTypeList.SelectedValue

        Dim newItem As New tempBrandCategorySubType With {
        .tempBrandCategorySubTypeID = Convert.ToInt32(SelectedCategoryTypeID),
           .tempSubCategoryName = VarietyTextBox.Text
           }

        db.tempBrandCategorySubTypes.InsertOnSubmit(newItem)
        db.SubmitChanges()

        BindSubCategoryList()
        VarietyTextBox.Text = ""

    End Sub

    Private Sub BindSubCategoryList()

        Dim result = From p In db.tempBrandCategorySubTypes Where p.tempBrandCategorySubTypeID = CategoryTypeList.SelectedValue

        SubCategoryTypeList.DataSource = result

        SubCategoryTypeList.DataBind()

    End Sub

End Class