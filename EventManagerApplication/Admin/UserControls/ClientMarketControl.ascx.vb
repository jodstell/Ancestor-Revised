Imports System.Collections.Generic
Imports Telerik.Web.UI

Public Class ClientMarketControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Private Sub BrandGroupList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles MarketList.ItemCommand
        Dim marketID = e.CommandArgument
        Dim clientID = Common.GetCurrentClientID()

        Select Case e.CommandName

            Case "AddNew"
                If e.CommandName = "AddNew" Then Response.Redirect("/admin/AddNewMarket.aspx")

            Case "ClearFilters"
                For Each column As GridColumn In MarketList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                MarketList.MasterTableView.FilterExpression = [String].Empty
                MarketList.MasterTableView.Rebind()

            Case "ExportToCSV"
                ConfigureExport()

                MarketList.MasterTableView.ExportToCSV()

            Case "DeleteRow"
                Try
                    db.DeleteInsertClientMarket(Convert.ToInt32(clientID), Convert.ToInt32(marketID))
                    db.SubmitChanges()
                Catch ex As Exception
                    msgLabel.Text = Common.ShowAlertNoClose("warning", ex.Message)
                End Try


                MarketList.DataBind()


        End Select

    End Sub

    Protected Sub MarketList_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs)

        If TypeOf e.Item Is GridDataItem Then
            Dim editButton As LinkButton = DirectCast(e.Item.FindControl("btnEdit"), LinkButton)
            editButton.Attributes("href") = "javascript:void(0);"
            editButton.Attributes("onclick") = [String].Format("return ShowEditForm('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex)("marketID"), e.Item.ItemIndex)
        End If

    End Sub

    Public Sub ConfigureExport()

        MarketList.ExportSettings.ExportOnlyData = False
        MarketList.ExportSettings.IgnorePaging = True
        MarketList.ExportSettings.OpenInNewWindow = True
        MarketList.ExportSettings.UseItemStyles = False
        MarketList.ExportSettings.FileName = "Markets"

    End Sub

    'Protected Sub RadGrid1_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles MarketList.ItemCreated
    '    If TypeOf e.Item Is GridEditableItem AndAlso e.Item.IsInEditMode Then
    '        If Not (TypeOf e.Item Is GridEditFormInsertItem) Then
    '            Dim item As GridEditableItem = TryCast(e.Item, GridEditableItem)
    '            Dim manager As GridEditManager = item.EditManager
    '        End If
    '    End If

    '    If TypeOf e.Item Is GridEditableItem AndAlso e.Item.IsInEditMode Then
    '        If Not e.Item.OwnerTableView.IsItemInserted Then
    '            Dim updateButton As LinkButton = CType(e.Item.FindControl("UpdateButton"), LinkButton)
    '            updateButton.Text = "Update"
    '            updateButton.Style("font-size") = "13px"
    '            updateButton.Style("font-weight") = "bold"
    '            updateButton.CssClass = "btn btn-xs btn-primary"
    '            updateButton.Style("color") = "white"
    '        Else
    '            Dim insertButton As LinkButton = CType(e.Item.FindControl("PerformInsertButton"), LinkButton)
    '            insertButton.Text = "Insert"
    '            insertButton.Style("font-size") = "13px"
    '            insertButton.Style("font-weight") = "bold"
    '            insertButton.CssClass = "btn btn-xs btn-primary"
    '            insertButton.Style("color") = "white"
    '        End If
    '        Dim cancelButton As LinkButton = CType(e.Item.FindControl("CancelButton"), LinkButton)
    '        cancelButton.Text = "Cancel"
    '        cancelButton.Style("font-size") = "13px"
    '        cancelButton.Style("font-weight") = "bold"
    '        cancelButton.CssClass = "btn btn-xs btn-default"
    '        cancelButton.Style("color") = "black"
    '    End If
    'End Sub

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

    Protected Sub RadGrid1_ItemInserted(source As Object, e As GridInsertedEventArgs) Handles MarketList.ItemInserted

        If e.Exception IsNot Nothing Then

            e.ExceptionHandled = True

            SetMessage("Market cannot be inserted. Reason: " + e.Exception.Message)
        Else
            SetMessage("New Market is inserted!")
        End If
    End Sub
    Private Sub DisplayMessage(text As String)
        MarketList.Controls.Add(New LiteralControl(String.Format("<span style='color:red'>{0}</span>", text)))
    End Sub

    Private Sub SetMessage(message As String)
        gridMessage = message
    End Sub

    Private gridMessage As String = Nothing




    'Private Sub LogEvent(ByVal sender As Object, ByVal eventName As String, ByVal items As IEnumerable(Of RadListBoxItem))

    '    Dim affectedItems As New List(Of String)()

    '    For Each item As RadListBoxItem In items
    '        affectedItems.Add(item.Value)
    '    Next

    '    Dim message As String = String.Format("{0}", affectedItems.ToArray())
    '    HF_SelectedItemID.Value = message

    'End Sub

    'Protected Sub ClientMarketList_Inserted(sender As Object, e As RadListBoxEventArgs)
    '    Try
    '        'get the brandID
    '        LogEvent(sender, "Inserted", e.Items)

    '        Dim clientID As Integer = Common.GetCurrentClientID()
    '        Dim selectedValue As Integer = HF_SelectedItemID.Value

    '        'insert the item
    '        db.InsertClientMarket(clientID, selectedValue)
    '        db.SubmitChanges()

    '        'rebind the lists
    '        '  SelectedBrandsList.DataBind()
    '        ' AssociatedBrandsList.DataBind()

    '        msgLabel.Text = ""

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try
    'End Sub

    'Protected Sub ClientMarketList_Deleted(sender As Object, e As RadListBoxEventArgs)
    '    Try
    '        'get the brandID
    '        LogEvent(sender, "Deleted", e.Items)

    '        Dim clientID As Integer = Common.GetCurrentClientID()
    '        Dim selectedValue As Integer = HF_SelectedItemID.Value

    '        'delete the item
    '        db.DeleteClientMarket(clientID, selectedValue)
    '        db.SubmitChanges()

    '        'rebind the grids
    '        '  AvailableMarketsList.DataBind()
    '        '  ClientMarketList.DataBind()

    '        msgLabel.Text = ""

    '    Catch ex As Exception
    '        msgLabel.Text = ex.Message
    '    End Try
    'End Sub


    Protected Sub RadAjaxManager1_AjaxRequest(ByVal sender As Object, ByVal e As AjaxRequestEventArgs)
        If e.Argument = "Rebind" Then
            MarketList.MasterTableView.SortExpressions.Clear()
            MarketList.MasterTableView.GroupByExpressions.Clear()
            MarketList.Rebind()
        ElseIf e.Argument = "RebindAndNavigate" Then
            MarketList.MasterTableView.SortExpressions.Clear()
            MarketList.MasterTableView.GroupByExpressions.Clear()
            MarketList.MasterTableView.CurrentPageIndex = MarketList.MasterTableView.PageCount - 1
            MarketList.Rebind()
        End If
    End Sub

    Private Sub MarketList_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles MarketList.ItemDataBound

        Try
            If TypeOf e.Item Is GridDataItem Then

                Dim dataBoundItem As GridDataItem = TryCast(e.Item, GridDataItem)

                'get the keyname
                Dim datakey As String = dataBoundItem.GetDataKeyValue("marketID").ToString()

                ' Dim act = (From p In db.tblEventTypes Where p.eventTypeID = datakey Select p.active).FirstOrDefault

                Dim inList = (From p In db.tblClientMarkets Where p.marketID = datakey And p.clientID = Common.GetCurrentClientID() Select p.clientMarketID).FirstOrDefault

                Dim label As Label = CType(dataBoundItem.FindControl("ActiveLabel"), Label)
                Dim link As LinkButton = CType(dataBoundItem.FindControl("BtnActive"), LinkButton)

                If inList > 0 Then
                    label.Text = "Active"
                    link.CssClass = "btn btn-xs btn-success"
                Else
                    label.Text = "Inactive"
                    link.CssClass = "btn btn-xs btn-warning"
                End If

            End If
        Catch ex As Exception

        End Try





    End Sub
End Class