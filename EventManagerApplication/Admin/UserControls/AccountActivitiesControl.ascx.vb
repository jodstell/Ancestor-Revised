Imports Telerik.Web.UI

Public Class AccountActivitiesControl
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

        ActivityTypeList.ExportSettings.ExportOnlyData = False
        ActivityTypeList.ExportSettings.IgnorePaging = True
        ActivityTypeList.ExportSettings.OpenInNewWindow = True
        ActivityTypeList.ExportSettings.UseItemStyles = False
        ActivityTypeList.ExportSettings.FileName = "ActivityType"

    End Sub

    Private Sub EventTypeList_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles ActivityTypeList.ItemDataBound

        If TypeOf e.Item Is GridDataItem Then

            Dim dataBoundItem As GridDataItem = TryCast(e.Item, GridDataItem)

            'get the keyname
            Dim datakey As String = dataBoundItem.GetDataKeyValue("activityTypeID").ToString()

            ' Dim act = (From p In db.tblEventTypes Where p.eventTypeID = datakey Select p.active).FirstOrDefault

            Dim inList = (From p In db.tblClientActivityTypes Where p.activityTypeID = datakey And p.clientID = Common.GetCurrentClientID() Select p)

            Dim label As Label = CType(dataBoundItem.FindControl("ActiveLabel"), Label)
            Dim link As LinkButton = CType(dataBoundItem.FindControl("BtnActive"), LinkButton)

            If inList.Count > 0 Then
                label.Text = "Active"
                link.CssClass = "btn btn-xs btn-success"
            Else
                label.Text = "Inactive"
                link.CssClass = "btn btn-xs btn-warning"
            End If

            Dim btnEdit As LinkButton = CType(dataBoundItem.FindControl("btnEdit"), LinkButton)
            btnEdit.PostBackUrl = "/admin/ClientSettings/EditActivityType?ClientID=" & Common.GetCurrentClientID() & "&ActivityTypeID=" & datakey & "&Mode=Edit"

            'Dim EventCountLabel As Label = CType(dataBoundItem.FindControl("EventCountLabel"), Label)

            'EventCountLabel.Text = (From p In db.tblEvents Where p.eventTypeID = datakey Select p).Count


        End If

    End Sub

    Private Sub EventTypeList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles ActivityTypeList.ItemCommand
        Select Case e.CommandName
            Case "AddNew"
                If e.CommandName = "AddNew" Then
                    Response.Redirect("/admin/ClientSettings/EditActivityType?ClientID=" & Common.GetCurrentClientID() & "&Mode=Add")
                End If

            Case "DeleteActivityType"
                db.DeleteActivityType(Convert.ToInt32(e.CommandArgument))
                ActivityTypeList.MasterTableView.Rebind()


            Case "ClearFilters"
                For Each column As GridColumn In ActivityTypeList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                ActivityTypeList.MasterTableView.FilterExpression = [String].Empty
                ActivityTypeList.MasterTableView.Rebind()

            Case "ExportToCSV"
                ConfigureExport()

                ActivityTypeList.MasterTableView.ExportToCSV()

            Case "SetActive"

                Try
                    Dim DataKey As Integer = Convert.ToInt32(e.CommandArgument)
                    Dim clientID As Integer = Convert.ToInt32(Common.GetCurrentClientID())

                    Dim inList = (From p In db.tblClientActivityTypes Where p.activityTypeID = DataKey And p.clientID = clientID Select p)

                    If inList.Count > 0 Then
                        'delete record
                        Dim delete = db.DeleteClientActivityType(clientID, DataKey)
                    Else
                        'add record
                        Dim i As New tblClientActivityType
                        i.clientID = clientID
                        i.activityTypeID = DataKey

                        db.tblClientActivityTypes.InsertOnSubmit(i)
                        db.SubmitChanges()

                    End If

                    ActivityTypeList.DataBind()

                Catch ex As Exception
                    msgLabel.Text = ex.Message.ToString()

                End Try



        End Select
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        AddNewItemPanel.Visible = False
        GridPanel.Visible = True
    End Sub
End Class