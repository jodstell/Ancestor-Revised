Imports Telerik.Web.UI

Public Class RegionsAndMarkets
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Private Sub BrandGroupList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles MarketList.ItemCommand
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

            Case "SetActive"
                Dim marketID As String = e.CommandArgument

                db.UpdateMarketActiveStatus(marketID)
                db.SubmitChanges()
                MarketList.DataBind()

        End Select

    End Sub

    Public Sub ConfigureExport()

        MarketList.ExportSettings.ExportOnlyData = False
        MarketList.ExportSettings.IgnorePaging = True
        MarketList.ExportSettings.OpenInNewWindow = True
        MarketList.ExportSettings.UseItemStyles = False
        MarketList.ExportSettings.FileName = "Markets"

    End Sub

    Protected Sub RadGrid1_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles MarketList.ItemCreated
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

    Private Sub EventTypeList_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles MarketList.ItemDataBound

        If TypeOf e.Item Is GridDataItem Then

            Dim dataBoundItem As GridDataItem = TryCast(e.Item, GridDataItem)

            'get the keyname
            Dim datakey As String = dataBoundItem.GetDataKeyValue("marketID").ToString()

            ' Dim act = (From p In db.tblEventTypes Where p.eventTypeID = datakey Select p.active).FirstOrDefault

            Dim inList = (From p In db.tblMarkets Where p.marketID = datakey Select p.active).FirstOrDefault

            Dim label As Label = CType(dataBoundItem.FindControl("ActiveLabel"), Label)
            Dim link As LinkButton = CType(dataBoundItem.FindControl("BtnActive"), LinkButton)

            If inList = True Then
                label.Text = "Active"
                link.CssClass = "btn btn-xs btn-success"
            Else
                label.Text = "Inactive"
                link.CssClass = "btn btn-xs btn-warning"
            End If


        End If

    End Sub

    Protected Sub RadGrid1_PreRender(sender As Object, e As EventArgs) Handles MarketList.PreRender
        If Not String.IsNullOrEmpty(gridMessage) Then
            DisplayMessage(gridMessage)
        End If
    End Sub

    Function getAccountsCount(ByVal marketID As Integer) As Integer

        Return (From p In db.tblAccounts Where p.marketID = marketID Select p).Count

    End Function

End Class