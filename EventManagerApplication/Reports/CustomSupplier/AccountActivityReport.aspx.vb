Imports Telerik.Web.UI
Public Class AccountActivityReport
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime

    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)
        '  generateDynamicControls()


    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Init

        '  BindResultsGrid()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 6 - dtNow.DayOfWeek, dtNow)

            Dim dtFirst As New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
            Dim endDate As DateTime = dtFirst.AddMonths(1).AddDays(-1)

            FromDatePicker.SelectedDate = dtFirst
            ToDatePicker.SelectedDate = endDate

            'Displays first day of the week 
            selectedDateLabel.Text = dtFirst.ToString("dddd, MMMM dd") & " - " & endDate.ToString("dddd, MMMM dd")

            'select first item
            SelectedActivity.SelectedIndex = 0
            ' BindConsumersSampled()



            Dim i = From r In db.tblActivityFields Where r.activityTypeID = 2 Order By r.sortOrder Select r

            Dim myList As New List(Of ActivityList)
            Dim myResultList As New List(Of ActivityResultList)

            For Each r In i
                myList.Add(New ActivityList(r.fieldID, r.fieldName, r.sortOrder, r.type))
            Next

            For Each l In myList
                myResultList.Add(New ActivityResultList(l.SortOrder, l.ActivityID, "result", 0, 0))
            Next


            '  RadGrid1.DataSource = MyList
            '  RadGrid1.DataBind()




        End If

    End Sub

    'Private Sub btnViewDetails_Click(sender As Object, e As EventArgs) Handles btnViewDetails.Click

    '    Session.Add("CurrentActivityTypeID", SelectedActivity.SelectedValue)
    '    Session.Add("sDate", FromDatePicker.SelectedDate)
    '    Session.Add("eDate", ToDatePicker.SelectedDate)

    '    Response.Redirect("AccountActivityDetailReport")
    'End Sub



#Region "Dynamic Methods"


    Public Sub generateDynamicControls()

        Dim myActivity = From p In db.Activities Select p
        For Each p In myActivity

            'create a header label
            CreateLabelControl(p.activityID, p.activityName)

            Dim result = From x In db.ActivityResults Where x.activityID = p.activityID Select x




            For Each x In result

                CreateTableControl(x.activityResultID, x.result, x.count, x.percent)


            Next

            'add a spacer here
            CreateSpaceControl()

        Next


        '  BindResultsGrid()

    End Sub

    Private Sub CreateLabelControl(id As String, labelText As String)

        Dim div As New HtmlGenericControl("div")

        Dim lbl As New HtmlGenericControl("h4")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        '   InsertPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateTableControl(id As String, result As String, count As String, percent As String)

        Dim table As New HtmlGenericControl("table")
        table.Attributes.Add("class", "table table-bordered")

        Dim tr As New HtmlGenericControl("tr")
        table.Controls.Add(tr)

        Dim col1 As New HtmlGenericControl("td")
        Dim col1Label As New HtmlGenericControl("label")
        col1.Attributes.Add("style", "width:30%")
        col1Label.InnerHtml = result
        col1.Controls.Add(col1Label)

        tr.Controls.Add(col1)

        Dim col2 As New HtmlGenericControl("td")
        col2.Attributes.Add("style", "width:50%")

        'add progress bar
        Dim progress As New RadProgressBar
        progress.ID = id
        progress.BarType = ProgressBarType.Percent
        progress.Value = percent
        progress.MinValue = 0
        progress.MaxValue = 100

        col2.Controls.Add(progress)
        tr.Controls.Add(col2)

        Dim col3 As New HtmlGenericControl("td")
        Dim col3Label As New HtmlGenericControl("label")
        col3.Attributes.Add("style", "width:20%")
        col3Label.InnerHtml = String.Format("{0} out of 20", count)
        col3.Controls.Add(col3Label)
        tr.Controls.Add(col3)

        'Dim col4 As New HtmlGenericControl("td")
        'Dim col4Label As New HtmlGenericControl("label")
        'col4.Attributes.Add("style", "width:10%")
        'col4Label.InnerHtml = String.Format("{0}%", percent)
        'col4.Controls.Add(col4Label)
        'tr.Controls.Add(col4)


        '    InsertPlaceHolder.Controls.Add(table)
    End Sub

    Private Sub CreateSpaceControl()
        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("style", "margin-top:35px;")
        '     InsertPlaceHolder.Controls.Add(div)
    End Sub




#End Region


    Private Sub BindResultsGrid()

        ' Dim q = From p In db.tblAccountActivities Where p.activityTypeID = Convert.ToInt32(SelectedActivity.SelectedValue) Select p

        Dim RadGrid1 As RadGrid = New RadGrid
        RadGrid1.DataSourceID = "SqlDataSource1"
        RadGrid1.MasterTableView.DataKeyNames = New String() {"accountActivityID"}
        RadGrid1.Skin = "Bootstrap"
        RadGrid1.Width = Unit.Percentage(100)
        RadGrid1.Height = Unit.Pixel(1535)
        RadGrid1.AllowPaging = False
        RadGrid1.AutoGenerateColumns = False
        RadGrid1.AllowSorting = True


        RadGrid1.ClientSettings.Scrolling.AllowScroll = True
        'RadGrid1.ClientSettings.Scrolling.UseStaticHeaders = True
        'RadGrid1.ClientSettings.Scrolling.SaveScrollPosition = True
        'RadGrid1.ClientSettings.Scrolling.FrozenColumnsCount = 1



        'Master table - Customers (I in hierarchy level)
        'Add columnsn
        Dim boundColumn As GridBoundColumn
        boundColumn = New GridBoundColumn
        boundColumn.DataField = "accountActivityID"
        boundColumn.HeaderText = "accountActivityID"

        boundColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
        boundColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
        RadGrid1.MasterTableView.Columns.Add(boundColumn)

        boundColumn = New GridBoundColumn
        boundColumn.DataField = "accountID"
        boundColumn.HeaderText = "accountID"

        boundColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
        boundColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
        RadGrid1.MasterTableView.Columns.Add(boundColumn)

        'get first column
        Dim i = From r In db.tblActivityFields Where r.activityTypeID = Request.QueryString("ActivityTypeID") Order By r.sortOrder Select r
        For Each r In i


            'boundColumn = New GridBoundColumn
            'boundColumn.DataField = "accountActivityID"
            'boundColumn.HeaderText = p.fieldName
            'boundColumn.ItemStyle.Width = 150
            'RadGrid1.MasterTableView.Columns.Add(boundColumn)

            Dim templateColumnName As String = r.fieldID
            Dim templateColumn As New GridTemplateColumn()
            templateColumn.ItemTemplate = New MyTemplate(templateColumnName)
            templateColumn.HeaderText = r.fieldName


            templateColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
            templateColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
            templateColumn.HeaderStyle.Width = 200
            templateColumn.ItemStyle.Width = 200

            RadGrid1.MasterTableView.Columns.Add(templateColumn)

        Next






        '  ResultsGridPlaceHolder.Controls.Add(RadGrid1)

    End Sub

    Shared Function getGridResult(ByVal id As Integer, rowID As String) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblAccountActivityResults Where p.fieldID = id And p.accountActivityID = Convert.ToInt32(rowID) Select p.answer).FirstOrDefault


    End Function

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click
        Session.Add("CurrentActivityTypeID", SelectedActivity.SelectedValue)
        Session.Add("sDate", FromDatePicker.SelectedDate)
        Session.Add("eDate", ToDatePicker.SelectedDate)

        Response.Redirect("AccountActivityDetailReport")
    End Sub

    Private Class MyTemplate
        Implements ITemplate
        Protected lControl As LiteralControl
        Protected validatorTextBox As RequiredFieldValidator
        Protected searchGoogle As HyperLink
        Protected textBox As TextBox
        Protected boolValue As CheckBox
        Private colname As String
        Public Sub New(ByVal cName As String)

            colname = cName
        End Sub
        Public Sub InstantiateIn(ByVal container As System.Web.UI.Control) Implements ITemplate.InstantiateIn
            lControl = New LiteralControl()
            lControl.ID = "lControl"
            AddHandler lControl.DataBinding, AddressOf lControl_DataBinding
            ' textBox = New TextBox()
            ' textBox.ID = "templateColumnTextBox"
            ' validatorTextBox = New RequiredFieldValidator()
            ' validatorTextBox.ControlToValidate = "templateColumnTextBox"
            ' validatorTextBox.ErrorMessage = "*"
            '  searchGoogle = New HyperLink()
            '  searchGoogle.ID = "searchGoogle"
            ' AddHandler searchGoogle.DataBinding,
            '  AddressOf searchGoogle_DataBinding
            ' boolValue = New CheckBox()
            ' boolValue.ID = "boolValue"
            ' AddHandler boolValue.DataBinding,
            ' AddressOf boolValue_DataBinding
            '   boolValue.Enabled = False
            Dim table As New Table()
            Dim row1 As New TableRow()
            Dim row2 As New TableRow()
            Dim cell11 As New TableCell()
            Dim cell12 As New TableCell()
            Dim cell21 As New TableCell()
            Dim cell22 As New TableCell()
            row1.Cells.Add(cell11)
            row1.Cells.Add(cell12)
            row2.Cells.Add(cell21)
            row2.Cells.Add(cell22)
            table.Rows.Add(row1)
            table.Rows.Add(row2)
            ' cell11.Text = getGridResult(colname)
            cell12.Controls.Add(lControl)
            ' cell21.Text = "Search Google for: "
            ' cell22.Controls.Add(searchGoogle)
            ' container.Controls.Add(textBox)
            ' container.Controls.Add(validatorTextBox)
            container.Controls.Add(table)
            ' container.Controls.Add(New LiteralControl("<br />"))
            ' container.Controls.Add(boolValue)
        End Sub
        Sub boolValue_DataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim cBox As CheckBox = DirectCast(sender, CheckBox)
            Dim container As GridDataItem = DirectCast(cBox.NamingContainer, GridDataItem)
            cBox.Checked = DirectCast((DirectCast(container.DataItem, DataRowView))("Bool"), Boolean)
        End Sub
        Sub searchGoogle_DataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim link As HyperLink = DirectCast(sender, HyperLink)
            Dim container As GridDataItem = DirectCast(link.NamingContainer, GridDataItem)
            link.Text = (DirectCast(container.DataItem, DataRowView))("accountActivityID").ToString()
            link.NavigateUrl = "http://www.google.com/search?hl=en&q="
        End Sub
        Public Sub lControl_DataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim l As LiteralControl = DirectCast(sender, LiteralControl)
            Dim container As GridDataItem = DirectCast(l.NamingContainer, GridDataItem)
            l.Text = getGridResult(colname, DirectCast(container.DataItem, DataRowView)("accountActivityID").ToString())
        End Sub
    End Class

End Class