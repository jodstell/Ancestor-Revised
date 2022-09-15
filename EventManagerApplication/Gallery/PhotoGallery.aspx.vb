Imports System.Data.SqlClient
Imports System.IO
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI

Public Class PhotoGallery1
    Inherits System.Web.UI.Page

    Dim db As New DataClassesDataContext
    Dim userdb As New LMSDataClassesDataContext

    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime
    Dim folder As String

    Shared filter As Boolean = False
    Shared numberofrows As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            HiddenSessionGUID.Value = Guid.NewGuid().ToString()
            btnDownloadBin.NavigateUrl = "DownLoadZipHandler.aspx?sessionID=" & HiddenSessionGUID.Value

            HiddenUserID.Value = Context.User.Identity.GetUserId()

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", -7 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 6 - dtNow.DayOfWeek, dtNow)

            'Displays first day of the week 
            lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")

            FromDatePicker.SelectedDate = weekStartDate
            ToDatePicker.SelectedDate = weekEndDate

        End If


    End Sub

    Protected Sub RadAjaxManager1_AjaxRequest(ByVal sender As Object, ByVal e As AjaxRequestEventArgs) Handles RadAjaxManager1.AjaxRequest

        If e.Argument = "Rebind" Then

            EventDataGrid.MasterTableView.SortExpressions.Clear()

            EventDataGrid.MasterTableView.GroupByExpressions.Clear()

            EventDataGrid.Rebind()

        End If

    End Sub


    Private Sub photoGallery_ItemCommand(source As Object, e As GridCommandEventArgs)


    End Sub

    Function getPhotoBinCount()
        Dim userid = Context.User.Identity.GetUserId()

        Return (From p In db.tblPhotoBins Where p.userID = userid And p.sessionID = HiddenSessionGUID.Value Select p).Count

    End Function

    Function getImage(status As String) As String
        Select Case status
            Case "Booked"
                Return "/images/StatusIcons/Green.png"
            Case "Requested"
                Return "/images/StatusIcons/Blue.png"
                Exit Select
            Case "Scheduled"
                Return "/images/StatusIcons/Yellow.png"
                Exit Select
            Case "Cancelled"
                Return "/images/StatusIcons/Red.png"
                Exit Select
            Case "Cancelled Last Minute"
                Return "/images/StatusIcons/Red.png"
                Exit Select
            Case "Toplined"
                Return "/images/StatusIcons/Purple.png"
                Exit Select
            Case "Approved"
                Return "/images/StatusIcons/Light Blue.png"
                Exit Select
            Case Else
                Return ""
                Exit Select

        End Select

    End Function

    Private Sub Events_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        For Each col As GridColumn In EventDataGrid.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next

    End Sub

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click

        Dim _startDate As Date = FromDatePicker.SelectedDate
        Dim _endDate As Date = ToDatePicker.SelectedDate

        lblWeek.Text = _startDate.ToString("dddd, MMMM dd") & " - " & _endDate.ToString("dddd, MMMM dd")

        Try

            Dim myView As New List(Of GalleryList)()

            Dim a = From p In db.getGalleryEvents_ByUserID(Context.User.Identity.GetUserId(), 18, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate) Select p

            For Each p In a
                myView.Add(New GalleryList(p.eventID, p.supplierName, p.brands, p.eventDate, p.statusName, p.statusID, p.marketName, p.eventTypeName, p.accountName, p.locationID, p.address, p.city, p.state, p.Vpid, p.labelText))
            Next

            EventDataGrid.DataSource = myView
            EventDataGrid.DataBind()

        Catch ex As Exception
            errorLabel.Text = Common.ShowAlertNoClose("warning", "There was an error on loading the gallery.  Try changing your date range to return less results.")

            Dim body =
         <body>
             <style type="text/css">
                            .style1 {
                                width: 110px;
                            }
                            .style2 {
                                width: 682px;
                            }
                        </style>
             <p>There was an error on loading the gallery.</p>
                        <table class="style2">
                 <tr>
                     <td class="style1">User Name:</td>
                     <td><%= Common.GetFullName(Context.User.Identity.GetUserId()) %></td>

                 </tr>
                 <tr>
                     <td class="style1">User Agent:</td>
                     <td><%= Request.UserAgent.ToString().ToLower() %></td>
                 </tr>

                 <tr>
                     <td class="style1">Error:</td>
                     <td><%= ex.Message() %></td>
                 </tr>
             </table>
                      </body>

            MailHelper.SendMailMessage("support@bletsianlms.com", "There was an error on loading the gallery.", body.ToString())
        End Try


    End Sub

    Protected Function AddPhotoBin(photoID As String) As String

        'create folder
        Dim folder As String = HiddenSessionGUID.Value 'Context.User.Identity.GetUserId()
        Dim path = Server.MapPath(Convert.ToString("~/documents/photobin/") & folder)
        Dim directory = New DirectoryInfo(path)
        If directory.Exists = False Then
            directory.Create()
        End If


        Try

            Dim addtobin = db.InsertPhotoBin(photoID, Context.User.Identity.GetUserId(), HiddenSessionGUID.Value)

            '  PhotoBinCountLabel.Text = getPhotoBinCount()

        Catch ex As Exception
            '  errorLabel.Text = ex.Message
        End Try

        Try
            Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault

            Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
                sqlconnection.Open()

                Dim selectQuery As String = String.Format("SELECT Image FROM tblPhoto WHERE photoID ={0}", photoID)

                Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)
                Dim reader As SqlDataReader = selectCommand.ExecuteReader()
                If reader.Read() Then
                    Dim byteData As Byte() = DirectCast(reader(0), Byte())
                    Dim strData As String = Encoding.UTF8.GetString(byteData)

                    System.IO.File.WriteAllBytes(Server.MapPath(Convert.ToString("~/documents/photobin/" & folder & "/" & _fileName)), byteData)

                End If
                sqlconnection.Close()
            End Using
        Catch ex As Exception
            '  errorLabel.Text = ex.Message
        End Try

#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths

    Protected Property ImageWidth() As Unit

        Get
            Dim state As Object = If(ViewState("ImageWidth"), Unit.Pixel(150))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageWidth") = value
        End Set

    End Property

    Protected Property ImageHeight() As Unit

        Get
            Dim state As Object = If(ViewState("ImageHeight"), Unit.Pixel(150))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageHeight") = value
        End Set

    End Property


    Protected Sub EventDataGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)
        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryViewEvents where eventDate >= '{2}' and eventDate <= '{3}' and clientid = {1} order by {0}", field, Common.GetCurrentClientID(), FromDatePicker.SelectedDate, ToDatePicker.SelectedDate)

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()

        adapter.SelectCommand = New SqlCommand(query, conn)

        Dim myDataTable As New DataTable()

        conn.Open()

        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function

    Protected Function DownloadSingleImage(ByVal photoID As Integer) As String

        Try

            Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault

            Dim data As Byte() = GetPhoto(photoID)

            Response.Clear()
            Response.ContentType = "application/octet-stream"
            Response.AddHeader("content-disposition", Convert.ToString("attachment; filename=") & _fileName)
            Response.BinaryWrite(data)


        Catch ex As Exception
            ' FilterLabel.Text = ex.Message
        End Try

    End Function

    Private Function GetPhoto(photoId As Integer) As Byte()

        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Dim comm As New SqlCommand("SELECT LargeImage FROM tblPhoto WHERE photoID = @photoID", conn)
        comm.Parameters.Add(New SqlParameter("@PhotoID", photoId))

        conn.Open()
        Dim data As Object = comm.ExecuteScalar()
        conn.Close()

        Return DirectCast(data, Byte())
    End Function

    Protected Function CreateWindowScript2(ByVal eventID As Integer) As String
        Return String.Format("window.open('/Events/EventDetails?ID={0}','_blank');return false;", eventID)
    End Function
    Protected Function CreateWindowScript3(ByVal eventID As Integer, ByVal photoID As Integer) As String
        Return String.Format("var win = window.radopen('/PhotoGallery.aspx?ID={0}&PhotoID={1}','Details');win.center();", eventID, photoID)
    End Function

    Private Sub btnDeleteBin_Click(sender As Object, e As EventArgs) Handles btnDeleteBin.Click
        Dim delete = db.DeletePhotoBin(Context.User.Identity.GetUserId())

        Dim userid = Context.User.Identity.GetUserId()

        Dim q = (From p In db.tblPhotoBins Where p.userID = userid Select p).Count
        If q = 0 Then
            folder = Context.User.Identity.GetUserId()

            Dim path = Server.MapPath(Convert.ToString("~/documents/photobin/") & folder)
            Dim directory = New DirectoryInfo(path)
            If directory.Exists = True Then
                directory.Delete(True)
            End If
        End If

        ' Response.Redirect("/gallery/photogallery")
    End Sub

    Private Sub EventDataGrid_PreRender(sender As Object, e As EventArgs) Handles EventDataGrid.PreRender
        For Each col As GridColumn In EventDataGrid.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next

    End Sub

    Private Sub EventDataGrid_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles EventDataGrid.NeedDataSource
        ' TryCast(sender, RadGrid).DataSource = GetDataTable()

        Try

            Dim myView As New List(Of GalleryList)()

            Dim a = From p In db.getGalleryEvents_ByUserID(Context.User.Identity.GetUserId(), Common.GetCurrentClientID(), FromDatePicker.SelectedDate, ToDatePicker.SelectedDate) Select p

            For Each p In a
                myView.Add(New GalleryList(p.eventID, p.supplierName, p.brands, p.eventDate, p.statusName, p.statusID, p.marketName, p.eventTypeName, p.accountName, p.locationID, p.address, p.city, p.state, p.Vpid, p.labelText))
            Next

            EventDataGrid.DataSource = myView

        Catch ex As Exception
            errorLabel.Text = Common.ShowAlertNoClose("warning", "There was an error on loading the gallery.  Try changing your date range to return less results.")

            Dim body =
                     <body>
                         <style type="text/css">
                            .style1 {
                                width: 110px;
                            }
                            .style2 {
                                width: 682px;
                            }
                        </style>
                         <p>There was an error on loading the gallery.</p>
                        <table class="style2">
                             <tr>
                                 <td class="style1">User Name:</td>
                                 <td><%= Common.GetFullName(Context.User.Identity.GetUserId()) %></td>

                             </tr>
                             <tr>
                                 <td class="style1">User Agent:</td>
                                 <td><%= Request.UserAgent.ToString().ToLower() %></td>
                             </tr>

                             <tr>
                                 <td class="style1">Error:</td>
                                 <td><%= ex.Message() %></td>
                             </tr>
                         </table>
                      </body>

            MailHelper.SendMailMessage("support@bletsianlms.com", "There was an error on loading the gallery.", body.ToString())

        End Try

    End Sub

    'Public Function GetDataTable() As DataTable
    '    ' Dim query As String = "SELECT eventID, supplierName, eventDate, marketName, eventTypeName, statusName FROM qryViewEvents"

    '    Dim query As String = "getGalleryEventsByUserID"

    '    Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
    '    Dim conn As New SqlConnection(ConnString)
    '    Dim adapter As New SqlDataAdapter()
    '    adapter.SelectCommand = New SqlCommand(query, conn)

    '    adapter.SelectCommand.CommandType = CommandType.StoredProcedure

    '    adapter.SelectCommand.Parameters.Add(New SqlParameter("@UserID", SqlDbType.NVarChar))
    '    adapter.SelectCommand.Parameters("@UserID").Value = Context.User.Identity.GetUserId()

    '    adapter.SelectCommand.Parameters.Add(New SqlParameter("@clientID", SqlDbType.Int))
    '    adapter.SelectCommand.Parameters("@clientID").Value = Session("CurrentClientID")

    '    adapter.SelectCommand.Parameters.Add(New SqlParameter("@fromDate", SqlDbType.Date))
    '    adapter.SelectCommand.Parameters("@fromDate").Value = FromDatePicker.SelectedDate

    '    adapter.SelectCommand.Parameters.Add(New SqlParameter("@toDate", SqlDbType.Date))
    '    adapter.SelectCommand.Parameters("@toDate").Value = ToDatePicker.SelectedDate


    '    Dim myDataTable As New DataTable()

    '    conn.Open()
    '    Try
    '        adapter.Fill(myDataTable)
    '    Finally
    '        conn.Close()
    '    End Try

    '    Return myDataTable


    'End Function

    Private Sub EventDataGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles EventDataGrid.ItemCommand

        Select Case e.CommandName
            Case "ClearFilters"

                Response.Redirect("/gallery/photogallery")

                'For Each column As GridColumn In EventDataGrid.MasterTableView.Columns
                '    column.CurrentFilterFunction = GridKnownFunction.NoFilter
                '    column.CurrentFilterValue = [String].Empty
                'Next

                'EventDataGrid.MasterTableView.FilterExpression = [String].Empty
                'EventDataGrid.MasterTableView.Rebind()
        End Select
    End Sub

    Private Sub EventDataGrid_ItemCreated(sender As Object, e As GridItemEventArgs) Handles EventDataGrid.ItemCreated

        If TypeOf e.Item Is GridHeaderItem Then
            Dim headerItem As GridHeaderItem = TryCast(e.Item, GridHeaderItem)
            For Each column As GridColumn In EventDataGrid.MasterTableView.RenderColumns
                Dim isFiltered As Boolean = Not String.IsNullOrEmpty(column.EvaluateFilterExpression())
                If isFiltered Then
                    Dim button As New ImageButton()
                    button.AlternateText = "Clear filters"
                    button.ImageUrl = "~/filter.png"
                    button.ImageAlign = ImageAlign.Right
                    button.OnClientClick = "clearColumnFilter('" + column.UniqueName + "'); return false;"
                    button.Enabled = False

                    headerItem(column.UniqueName).Controls.Add(button)
                End If
            Next
        End If

    End Sub
End Class