Imports Telerik.Web.UI

Public Class ClientAccountTypeControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getActiveStyle(ByVal active As Boolean) As String

        Select Case active
            Case True
                Return "btn btn-xs btn-success"
            Case False
                Return "btn btn-xs btn-warning"
        End Select

        Return "btn btn-xs btn-default"
    End Function

    Function getActiveText(ByVal active As String) As String

        Select Case active
            Case True
                Return "Active"
            Case False
                Return "Inactive"
        End Select

        Return "Error"
    End Function

    Public Sub ConfigureExport()

        AccountTypeList.ExportSettings.ExportOnlyData = False
        AccountTypeList.ExportSettings.IgnorePaging = True
        AccountTypeList.ExportSettings.OpenInNewWindow = True
        AccountTypeList.ExportSettings.UseItemStyles = False
        AccountTypeList.ExportSettings.FileName = "ActivityType"

    End Sub

    Private Sub AccountTypeList_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles AccountTypeList.ItemDataBound

        If TypeOf e.Item Is GridDataItem Then

            Dim dataBoundItem As GridDataItem = TryCast(e.Item, GridDataItem)

            'get the keyname
            Dim datakey As String = dataBoundItem.GetDataKeyValue("accountTypeID").ToString()

            ' Dim act = (From p In db.tblEventTypes Where p.eventTypeID = datakey Select p.active).FirstOrDefault

            Dim inList = (From p In db.tblClientAccountTypes Where p.accountTypeID = datakey And p.clientID = Common.GetCurrentClientID() Select p)

            Dim label As Label = CType(dataBoundItem.FindControl("ActiveLabel"), Label)
            Dim link As LinkButton = CType(dataBoundItem.FindControl("BtnActive"), LinkButton)
            Dim count As Label = CType(dataBoundItem.FindControl("AccountCountLabel"), Label)

            If inList.Count > 0 Then
                label.Text = "Active"
                link.CssClass = "btn btn-xs btn-success"
            Else
                label.Text = "Inactive"
                link.CssClass = "btn btn-xs btn-warning"
            End If

            'Dim btnEdit As LinkButton = CType(dataBoundItem.FindControl("btnEdit"), LinkButton)
            'btnEdit.PostBackUrl = "/admin/ClientSettings/EditAccountType?ClientID=" & Common.GetCurrentClientID() & "&AccountTypeID=" & datakey

            count.Text = (From p In db.tblAccounts Where p.accountTypeID = datakey Select p).Count

        End If

    End Sub

    Protected Sub AccountTypeList_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs)

        If TypeOf e.Item Is GridDataItem Then
            Dim editButton As LinkButton = DirectCast(e.Item.FindControl("btnEdit"), LinkButton)
            editButton.Attributes("href") = "javascript:void(0);"
            editButton.Attributes("onclick") = [String].Format("return ShowEditForm2('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex)("itemID"), e.Item.ItemIndex)
        End If

    End Sub

    Private Sub AccountTypeList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles AccountTypeList.ItemCommand
        Select Case e.CommandName
            Case "AddNew"
                If e.CommandName = "AddNew" Then Response.Redirect("/admin/events/newaccounttype?ClientID=" & Common.GetCurrentClientID())

            Case "ClearFilters"
                For Each column As GridColumn In AccountTypeList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                AccountTypeList.MasterTableView.FilterExpression = [String].Empty
                AccountTypeList.MasterTableView.Rebind()

            Case "ExportToCSV"
                ConfigureExport()

                AccountTypeList.MasterTableView.ExportToCSV()

            Case "SetActive"

                Try
                    Dim DataKey As Integer = Convert.ToInt32(e.CommandArgument)
                    Dim clientID As Integer = Convert.ToInt32(Common.GetCurrentClientID())

                    Dim inList = (From p In db.tblClientAccountTypes Where p.accountTypeID = DataKey And p.clientID = clientID Select p)

                    If inList.Count > 0 Then
                        'delete record
                        Dim delete = db.DeleteClientAccountType(clientID, DataKey)
                    Else
                        'add record
                        Dim i As New tblClientActivityType
                        i.clientID = clientID
                        i.activityTypeID = DataKey

                        db.tblClientActivityTypes.InsertOnSubmit(i)
                        db.SubmitChanges()

                    End If

                    AccountTypeList.DataBind()

                Catch ex As Exception
                    msgLabel.Text = ex.Message.ToString()

                End Try



        End Select
    End Sub
End Class