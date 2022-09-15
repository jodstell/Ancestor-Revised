Imports Telerik.Web.UI

Public Class CategoryControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ClientID.Text = Common.GetCurrentClientID()
        ClientID.Visible = False

    End Sub

    'Private Sub BtnAddNew_Click(sender As Object, e As EventArgs) Handles BtnAddNew.Click



    '    'Try
    '    '    Dim newCategory As New tblCategory With {
    '    '                .Name = TitleTextBox.Text,
    '    '                .ParentID = 37,'Convert.ToInt32(RadDropDownTree1.SelectedValue),
    '    '                .ClientID = 19 'Convert.ToInt32(Common.GetCurrentClientID())
    '    '            }

    '    '    db.tblCategories.InsertOnSubmit(newCategory)
    '    '    db.SubmitChanges()

    '    '    CategoryRadTreeView.DataBind()
    '    '    RadDropDownTree1.DataBind()
    '    '    TitleTextBox.Text = ""

    '    '    msgLabel.Text = "Category Added"

    '    'Catch ex As Exception
    '    '    msgLabel.Text = ex.Message()
    '    'End Try


    '    'ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", True)

    'End Sub

    Protected Sub CategoryRadTreeView_NodeClick(sender As Object, e As Telerik.Web.UI.RadTreeNodeEventArgs)




        SelectedCategoryLabel.Text = e.Node.Value
        'e.Node.Text = "NodeClick fired for this node"

    End Sub

    Protected Sub CategoryRadTreeView_ContextMenuItemClick(sender As Object, e As Telerik.Web.UI.RadTreeViewContextMenuEventArgs)
        'Dim clickedNode As RadTreeNode = e.Node

        Select Case e.MenuItem.Value
            Case "Add"
                SelectedCategoryLabel.Text = e.Node.Value
                NewCategoryPanel.Visible = True
                RadDropDownTree1.SelectedValue = e.Node.Value
                Exit Select

            Case "Delete"
                'If e.Node.Level = 1 Then
                e.Node.Remove()

                    'delete node from database
                    db.DeleteCategory(e.Node.Value)
                msgLabel.Text = "Category Deleted"
                msgLabel.CssClass = "label label-danger"

                ' End If
                Exit Select

                'Case "Edit"
                '    Dim node As RadTreeNode = New RadTreeNode()
                '    node.s
                '    node.Text = "Text"
                '    node.Value = "Value"
                '    Me.CategoryRadTreeView.Nodes.Add(node)
                '    Me.CategoryRadTreeView.AllowNodeEditing = True
                '    Me.CategoryRadTreeView.TreeViewElement.EditMode = TreeNodeEditMode.Value


        End Select
    End Sub

    Protected Sub CategoryRadTreeView_NodeEdit(sender As Object, e As RadTreeNodeEditEventArgs)

        Dim nodeEdited As RadTreeNode = e.Node
        Dim newText As String = e.Text

        nodeEdited.Text = newText
        db.UpdateCategory(e.Node.Value, e.Text)

    End Sub

    Private Sub BtnAddNew_Click(sender As Object, e As EventArgs) Handles BtnAddNew.Click



        Try
            SelectedCategoryLabel.Text = RadDropDownTree1.SelectedValue

            SelectedCategoryLabel.Visible = True
        Catch ex As Exception
            SelectedCategoryLabel.Text = "error"
            SelectedCategoryLabel.Visible = True
        End Try
    End Sub
End Class