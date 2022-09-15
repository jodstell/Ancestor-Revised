Imports Telerik.Web.UI

Public Class EventTypeControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' BindGrid()

        Dim t As Integer = (From p In db.tblEventTypes Select p).Count
        Dim c As Integer = (From p In db.tblClientEventTypes Where p.clientID = Common.GetCurrentClientID() Select p).Count

        '   Me.TotalCountLabel.Text = String.Format("{0} of {1} Active Event Types", c, t)
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

        EventTypeList.ExportSettings.ExportOnlyData = False
        EventTypeList.ExportSettings.IgnorePaging = True
        EventTypeList.ExportSettings.OpenInNewWindow = True
        EventTypeList.ExportSettings.UseItemStyles = False
        EventTypeList.ExportSettings.FileName = "EventType"

    End Sub

    Private Sub EventTypeList_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles EventTypeList.ItemDataBound

        If TypeOf e.Item Is GridDataItem Then

            Dim dataBoundItem As GridDataItem = TryCast(e.Item, GridDataItem)

            'get the keyname
            Dim datakey As String = dataBoundItem.GetDataKeyValue("eventTypeID").ToString()

            ' Dim act = (From p In db.tblEventTypes Where p.eventTypeID = datakey Select p.active).FirstOrDefault

            Dim inList = (From p In db.tblClientEventTypes Where p.eventTypeID = datakey And p.clientID = Common.GetCurrentClientID() Select p)

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
            btnEdit.PostBackUrl = "/admin/eventtypes/editeventtype?ClientID=" & Common.GetCurrentClientID() & "&EventTypeID=" & datakey

            Dim EventCountLabel As Label = CType(dataBoundItem.FindControl("EventCountLabel"), Label)

            EventCountLabel.Text = (From p In db.tblEvents Where p.eventTypeID = datakey And p.clientID = Convert.ToInt32(Session("CurrentClientID")) Select p).Count


        End If

    End Sub

    Private Sub EventTypeList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles EventTypeList.ItemCommand
        Select Case e.CommandName
            Case "AddNew"
                If e.CommandName = "AddNew" Then Response.Redirect("/admin/events/neweventtype?ClientID=" & Common.GetCurrentClientID())

            Case "ClearFilters"
                For Each column As GridColumn In EventTypeList.MasterTableView.Columns
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                    column.CurrentFilterValue = [String].Empty
                Next

                EventTypeList.MasterTableView.FilterExpression = [String].Empty
                EventTypeList.MasterTableView.Rebind()

            Case "ExportToCSV"
                ConfigureExport()

                EventTypeList.MasterTableView.ExportToCSV()

            Case "SetActive"

                Try
                    Dim DataKey As Integer = Convert.ToInt32(e.CommandArgument)
                    Dim clientID As Integer = Convert.ToInt32(Common.GetCurrentClientID())

                    Dim inList = (From p In db.tblClientEventTypes Where p.eventTypeID = DataKey And p.clientID = clientID Select p)

                    If inList.Count > 0 Then
                        'delete record
                        Dim delete = db.DeleteClientEventType(clientID, DataKey)
                    Else
                        'add record
                        Dim i As New tblClientEventType
                        i.clientID = clientID
                        i.eventTypeID = DataKey

                        db.tblClientEventTypes.InsertOnSubmit(i)
                        db.SubmitChanges()

                    End If

                    EventTypeList.DataBind()

                Catch ex As Exception
                    msgLabel.Text = ex.Message.ToString()

                End Try



        End Select
    End Sub
End Class