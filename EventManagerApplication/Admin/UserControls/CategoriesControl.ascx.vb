Imports System.Data.SqlClient
Imports Telerik.Web.UI

Public Class CategoriesControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub RadGrid1_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles CategoryList.ItemCreated
        If TypeOf e.Item Is GridEditableItem AndAlso e.Item.IsInEditMode Then
            If Not (TypeOf e.Item Is GridEditFormInsertItem) Then
                Dim item As GridEditableItem = TryCast(e.Item, GridEditableItem)
                Dim manager As GridEditManager = item.EditManager
            End If
        End If

        If TypeOf e.Item Is GridEditableItem AndAlso e.Item.IsInEditMode Then
            If Not e.Item.OwnerTableView.IsItemInserted Then
                Dim updateButton As LinkButton = CType(e.Item.FindControl("UpdateButton"), LinkButton)
                updateButton.Text = "Update"
                updateButton.Style("font-size") = "13px"
                updateButton.Style("font-weight") = "bold"
                updateButton.CssClass = "btn btn-xs btn-primary"
                updateButton.Style("color") = "white"
            Else
                Dim insertButton As LinkButton = CType(e.Item.FindControl("PerformInsertButton"), LinkButton)
                insertButton.Text = "Insert"
                insertButton.Style("font-size") = "13px"
                insertButton.Style("font-weight") = "bold"
                insertButton.CssClass = "btn btn-xs btn-primary"
                insertButton.Style("color") = "white"
            End If
            Dim cancelButton As LinkButton = CType(e.Item.FindControl("CancelButton"), LinkButton)
            cancelButton.Text = "Cancel"
            cancelButton.Style("font-size") = "13px"
            cancelButton.Style("font-weight") = "bold"
            cancelButton.CssClass = "btn btn-xs btn-default"
            cancelButton.Style("color") = "black"
        End If
    End Sub

    'Private Sub BrandsList_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles TeamsList.ItemDataBound

    '    If TypeOf e.Item Is GridDataItem Then


    '        Dim dataBoundItem As GridDataItem = TryCast(e.Item, GridDataItem)

    '        'get the keyname
    '        Dim datakey As String = dataBoundItem.GetDataKeyValue("categoryID").ToString()

    '        Dim act = (From p In db.tblBrandCategories Where p.categoryID = datakey Select p.active).FirstOrDefault

    '        Dim label As Label = CType(dataBoundItem.FindControl("ActiveLabel"), Label)
    '        Dim link As LinkButton = CType(dataBoundItem.FindControl("BtnActive"), LinkButton)

    '        If act = True Then
    '            label.Text = "Active"
    '            link.CssClass = "btn btn-xs btn-success"
    '        Else
    '            label.Text = "Inactive"
    '            link.CssClass = "btn btn-xs btn-warning"
    '        End If


    '        Dim EventsCountLabel As Label = CType(dataBoundItem.FindControl("EventsCountLabel"), Label)

    '        EventsCountLabel.Text = (From p In db.tblEvents Where p.teamID = datakey Select p).Count

    '    End If

    'End Sub

    Protected Sub RadGrid1_ItemInserted(source As Object, e As GridInsertedEventArgs) Handles CategoryList.ItemInserted

        If e.Exception IsNot Nothing Then

            e.ExceptionHandled = True

            SetMessage("Group cannot be inserted. Reason: " + e.Exception.Message)
        Else
            SetMessage("New group is inserted!")
        End If
    End Sub

    Private Sub SetMessage(message As String)
        gridMessage = message
    End Sub

    Private gridMessage As String = Nothing

    Protected Sub RadGrid1_PreRender(sender As Object, e As EventArgs) Handles CategoryList.PreRender
        If Not String.IsNullOrEmpty(gridMessage) Then
            DisplayMessage(gridMessage)
        End If
    End Sub

    Private Sub DisplayMessage(text As String)
        CategoryList.Controls.Add(New LiteralControl(String.Format("<span style='color:red'>{0}</span>", text)))
    End Sub

    Protected Sub RadGrid1_InsertCommand(sender As Object, e As GridCommandEventArgs)
        If TypeOf e.Item Is GridEditableItem Then
            Dim editedItem As GridEditableItem = TryCast(e.Item, GridEditableItem)
            'here editedItem.SavedOldValues will be the dictionary which holds the
            'predefined values

            'Prepare new dictionary object
            Dim newValues As New Hashtable()
            'the newValues instance is the new collection of key -> value pairs
            'with the updated ny the user data
            e.Item.OwnerTableView.ExtractValuesFromItem(newValues, editedItem)
        End If
    End Sub



    Public Sub ConfigureExport()

        CategoryList.ExportSettings.ExportOnlyData = False
        CategoryList.ExportSettings.IgnorePaging = True
        CategoryList.ExportSettings.OpenInNewWindow = True
        CategoryList.ExportSettings.UseItemStyles = False
        CategoryList.ExportSettings.FileName = "Teams"

    End Sub

    Private Sub CategoryList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles CategoryList.ItemCommand

        Select Case e.CommandName

            Case "Edit"

                Response.Redirect("/admin/events/editcategory?BrandCategoryID=" & e.CommandArgument & "&ClinetID=" & Common.GetCurrentClientID())

            Case "ClearFilters"
                For Each column As GridColumn In CategoryList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                CategoryList.MasterTableView.FilterExpression = [String].Empty
                CategoryList.MasterTableView.Rebind()

            Case "ExportToCSV"
                ConfigureExport()

                CategoryList.MasterTableView.ExportToCSV()

            Case "InitInsert"
                Response.Redirect("/admin/events/AddNewCategory?ClientID=" & Common.GetCurrentClientID())


        End Select
    End Sub
End Class