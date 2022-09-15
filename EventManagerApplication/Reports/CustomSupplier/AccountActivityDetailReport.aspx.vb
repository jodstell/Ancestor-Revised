Imports Telerik.Web.UI

Public Class AccountActivityDetailReport
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Init

        BindResultsGrid()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        selectedDateLabel.Text = String.Format("{0:D} - {1:D}", Session("sDate"), Session("eDate"))
        ActivityTypeLabel.Text = Common.getActivityTypeName(Convert.ToInt32(Session("CurrentActivityTypeID")))

        Dim dv As System.Data.DataView = DirectCast(SqlDataSource1.[Select](DataSourceSelectArguments.Empty), DataView)
        CountLabel.Text = String.Format("Activity Count: {0}", dv.Count.ToString())


    End Sub


    Private Sub BindResultsGrid()

        Dim radGrid1 As RadGrid = New RadGrid
        radGrid1.DataSourceID = "SqlDataSource1"
        radGrid1.MasterTableView.DataKeyNames = New String() {"accountActivityID"}
        radGrid1.Skin = "Bootstrap"
        radGrid1.Width = Unit.Percentage(100)
        radGrid1.Height = Unit.Pixel(600)
        radGrid1.AllowPaging = False
        radGrid1.AutoGenerateColumns = False
        radGrid1.AllowSorting = True

        radGrid1.ClientSettings.Scrolling.AllowScroll = True
        ' RadGrid1.ClientSettings.Scrolling.UseStaticHeaders = True
        ' RadGrid1.ClientSettings.Scrolling.SaveScrollPosition = True
        ' RadGrid1.ClientSettings.Scrolling.FrozenColumnsCount = 1

        radGrid1.ClientSettings.EnableClientPrint = True

        radGrid1.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.Top
        radGrid1.MasterTableView.CommandItemSettings.ShowExportToExcelButton = True
        radGrid1.MasterTableView.CommandItemSettings.ShowAddNewRecordButton = False
        radGrid1.MasterTableView.CommandItemSettings.ShowPrintButton = True
        radGrid1.MasterTableView.CommandItemSettings.ShowExportToPdfButton = False
        radGrid1.MasterTableView.CommandItemSettings.ExportToExcelText = "Export to Excel"

        radGrid1.ExportSettings.OpenInNewWindow = True
        radGrid1.ExportSettings.HideStructureColumns = True
        radGrid1.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx

        'Master table
        'Add columns
        Dim boundColumn As GridBoundColumn
        boundColumn = New GridBoundColumn
        boundColumn.DataField = "marketName"
        boundColumn.HeaderText = "Market"
        boundColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
        boundColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
        boundColumn.HeaderStyle.Width = Unit.Pixel(235)
        radGrid1.MasterTableView.Columns.Add(boundColumn)

        boundColumn = New GridBoundColumn
        boundColumn.DataField = "accountType"
        boundColumn.HeaderText = "Account Type"
        boundColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
        boundColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
        radGrid1.MasterTableView.Columns.Add(boundColumn)

        boundColumn = New GridBoundColumn
        boundColumn.DataField = "status"
        boundColumn.HeaderText = "Account Status"
        boundColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
        boundColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
        radGrid1.MasterTableView.Columns.Add(boundColumn)

        boundColumn = New GridBoundColumn
        boundColumn.DataField = "accountName"
        boundColumn.HeaderText = "Account Name"
        boundColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
        boundColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
        radGrid1.MasterTableView.Columns.Add(boundColumn)

        boundColumn = New GridBoundColumn
        boundColumn.DataField = "activityDate"
        boundColumn.HeaderText = "Activity Date"
        boundColumn.DataFormatString = "{0:D}"
        boundColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
        boundColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
        radGrid1.MasterTableView.Columns.Add(boundColumn)

        'add the dynamic columns
        Dim i = From r In db.tblActivityFields Where r.activityTypeID = Convert.ToInt32(Session("CurrentActivityTypeID")) Order By r.sortOrder Select r
        For Each r In i

            Dim templateColumnName As String = r.fieldID
            Dim templateColumn As New GridTemplateColumn()
            templateColumn.ItemTemplate = New MyTemplate(templateColumnName)
            templateColumn.HeaderText = r.fieldName

            templateColumn.ItemStyle.VerticalAlign = VerticalAlign.Top
            templateColumn.HeaderStyle.VerticalAlign = VerticalAlign.Bottom
            templateColumn.HeaderStyle.Width = Unit.Pixel(235)


            radGrid1.MasterTableView.Columns.Add(templateColumn)

        Next

        'add the grid to the placeholder
        ResultsGridPlaceHolder.Controls.Add(radGrid1)

    End Sub



    Shared Function GetCellResult(ByVal id As Integer, rowID As String) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblAccountActivityResults Where p.fieldID = id And p.accountActivityID = Convert.ToInt32(rowID) Select p.answer).FirstOrDefault

    End Function


    Private Class MyTemplate
        Implements ITemplate
        Protected lControl As LiteralControl
        Private colname As String

        Public Sub New(ByVal cName As String)
            'set the column name
            colname = cName
        End Sub
        Public Sub InstantiateIn(ByVal container As System.Web.UI.Control) Implements ITemplate.InstantiateIn
            lControl = New LiteralControl()
            lControl.ID = "lControl"
            AddHandler lControl.DataBinding, AddressOf LControlDataBinding
            container.Controls.Add(lControl)
        End Sub

        Public Sub LControlDataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim l As LiteralControl = DirectCast(sender, LiteralControl)
            Dim container As GridDataItem = DirectCast(l.NamingContainer, GridDataItem)
            l.Text = GetCellResult(colname, DirectCast(container.DataItem, DataRowView)("accountActivityID").ToString())

        End Sub
    End Class

End Class