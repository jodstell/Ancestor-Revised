Partial Class PayRoll

    'NOTE: The following procedure is required by the telerik Reporting Designer
    'It can be modified using the telerik Reporting Designer.  
    'Do not modify it using the code editor.
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(PayRoll))
        Dim TableGroup1 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup2 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup3 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup4 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup5 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup6 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup7 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup8 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup9 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup10 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup11 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup12 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup13 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup14 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim TableGroup15 As Telerik.Reporting.TableGroup = New Telerik.Reporting.TableGroup()
        Dim StyleRule1 As Telerik.Reporting.Drawing.StyleRule = New Telerik.Reporting.Drawing.StyleRule()
        Dim StyleRule2 As Telerik.Reporting.Drawing.StyleRule = New Telerik.Reporting.Drawing.StyleRule()
        Dim StyleRule3 As Telerik.Reporting.Drawing.StyleRule = New Telerik.Reporting.Drawing.StyleRule()
        Dim StyleRule4 As Telerik.Reporting.Drawing.StyleRule = New Telerik.Reporting.Drawing.StyleRule()
        Dim DescendantSelector1 As Telerik.Reporting.Drawing.DescendantSelector = New Telerik.Reporting.Drawing.DescendantSelector()
        Dim StyleRule5 As Telerik.Reporting.Drawing.StyleRule = New Telerik.Reporting.Drawing.StyleRule()
        Dim DescendantSelector2 As Telerik.Reporting.Drawing.DescendantSelector = New Telerik.Reporting.Drawing.DescendantSelector()
        Me.textBox3 = New Telerik.Reporting.TextBox()
        Me.textBox5 = New Telerik.Reporting.TextBox()
        Me.textBox7 = New Telerik.Reporting.TextBox()
        Me.textBox8 = New Telerik.Reporting.TextBox()
        Me.textBox9 = New Telerik.Reporting.TextBox()
        Me.textBox10 = New Telerik.Reporting.TextBox()
        Me.textBox11 = New Telerik.Reporting.TextBox()
        Me.textBox2 = New Telerik.Reporting.TextBox()
        Me.textBox39 = New Telerik.Reporting.TextBox()
        Me.textBox1 = New Telerik.Reporting.TextBox()
        Me.EventManagerDB = New Telerik.Reporting.SqlDataSource()
        Me.detailSection1 = New Telerik.Reporting.DetailSection()
        Me.table1 = New Telerik.Reporting.Table()
        Me.textBox14 = New Telerik.Reporting.TextBox()
        Me.textBox16 = New Telerik.Reporting.TextBox()
        Me.textBox18 = New Telerik.Reporting.TextBox()
        Me.textBox19 = New Telerik.Reporting.TextBox()
        Me.textBox20 = New Telerik.Reporting.TextBox()
        Me.textBox21 = New Telerik.Reporting.TextBox()
        Me.textBox22 = New Telerik.Reporting.TextBox()
        Me.textBox13 = New Telerik.Reporting.TextBox()
        Me.textBox15 = New Telerik.Reporting.TextBox()
        Me.textBox17 = New Telerik.Reporting.TextBox()
        Me.textBox23 = New Telerik.Reporting.TextBox()
        Me.textBox24 = New Telerik.Reporting.TextBox()
        Me.textBox25 = New Telerik.Reporting.TextBox()
        Me.textBox26 = New Telerik.Reporting.TextBox()
        Me.textBox28 = New Telerik.Reporting.TextBox()
        Me.textBox29 = New Telerik.Reporting.TextBox()
        Me.textBox30 = New Telerik.Reporting.TextBox()
        Me.textBox31 = New Telerik.Reporting.TextBox()
        Me.textBox32 = New Telerik.Reporting.TextBox()
        Me.textBox33 = New Telerik.Reporting.TextBox()
        Me.textBox34 = New Telerik.Reporting.TextBox()
        Me.textBox6 = New Telerik.Reporting.TextBox()
        Me.textBox12 = New Telerik.Reporting.TextBox()
        Me.textBox27 = New Telerik.Reporting.TextBox()
        Me.textBox35 = New Telerik.Reporting.TextBox()
        Me.textBox36 = New Telerik.Reporting.TextBox()
        Me.textBox37 = New Telerik.Reporting.TextBox()
        Me.textBox38 = New Telerik.Reporting.TextBox()
        Me.textBox40 = New Telerik.Reporting.TextBox()
        Me.textBox41 = New Telerik.Reporting.TextBox()
        Me.textBox42 = New Telerik.Reporting.TextBox()
        Me.textBox43 = New Telerik.Reporting.TextBox()
        Me.textBox44 = New Telerik.Reporting.TextBox()
        Me.textBox45 = New Telerik.Reporting.TextBox()
        Me.textBox46 = New Telerik.Reporting.TextBox()
        Me.textBox4 = New Telerik.Reporting.TextBox()
        Me.pageHeaderSection1 = New Telerik.Reporting.PageHeaderSection()
        Me.ReportNameTextBox = New Telerik.Reporting.TextBox()
        Me.textBox47 = New Telerik.Reporting.TextBox()
        Me.textBox48 = New Telerik.Reporting.TextBox()
        Me.textBox49 = New Telerik.Reporting.TextBox()
        Me.textBox50 = New Telerik.Reporting.TextBox()
        Me.textBox51 = New Telerik.Reporting.TextBox()
        Me.pageFooterSection1 = New Telerik.Reporting.PageFooterSection()
        Me.ReportPageNumberTextBox = New Telerik.Reporting.TextBox()
        CType(Me, System.ComponentModel.ISupportInitialize).BeginInit()
        '
        'textBox3
        '
        Me.textBox3.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox3.Name = "textBox3"
        Me.textBox3.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.6183280944824219R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox3.StyleName = "Corporate.TableHeader"
        Me.textBox3.Value = "Full Name"
        '
        'textBox5
        '
        Me.textBox5.Action = Nothing
        Me.textBox5.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox5.Name = "textBox5"
        Me.textBox5.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.88499516248703R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox5.StyleName = "Corporate.TableHeader"
        Me.textBox5.Value = "Date"
        '
        'textBox7
        '
        Me.textBox7.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox7.Name = "textBox7"
        Me.textBox7.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.77666211128234863R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox7.StyleName = "Corporate.TableHeader"
        Me.textBox7.Value = "Rate"
        '
        'textBox8
        '
        Me.textBox8.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox8.Name = "textBox8"
        Me.textBox8.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.68499499559402466R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox8.StyleName = "Corporate.TableHeader"
        Me.textBox8.Value = "Hours"
        '
        'textBox9
        '
        Me.textBox9.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox9.Name = "textBox9"
        Me.textBox9.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.9599950909614563R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox9.StyleName = "Corporate.TableHeader"
        Me.textBox9.Value = "Total"
        '
        'textBox10
        '
        Me.textBox10.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox10.Name = "textBox10"
        Me.textBox10.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.78499519824981689R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox10.StyleName = "Corporate.TableHeader"
        Me.textBox10.Value = "Expenses"
        '
        'textBox11
        '
        Me.textBox11.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox11.Name = "textBox11"
        Me.textBox11.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0766621828079224R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox11.StyleName = "Corporate.TableHeader"
        Me.textBox11.Value = "Total Amount"
        '
        'textBox2
        '
        Me.textBox2.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox2.Name = "textBox2"
        Me.textBox2.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.88333326578140259R), Telerik.Reporting.Drawing.Unit.Inch(0.60000002384185791R))
        Me.textBox2.StyleName = ""
        Me.textBox2.Value = "= Fields.eventID"
        '
        'textBox39
        '
        Me.textBox39.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox39.Name = "textBox39"
        Me.textBox39.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.88333326578140259R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox39.StyleName = ""
        '
        'textBox1
        '
        Me.textBox1.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox1.Name = "textBox1"
        Me.textBox1.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.88333326578140259R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox1.StyleName = ""
        Me.textBox1.Value = "Total"
        '
        'EventManagerDB
        '
        Me.EventManagerDB.ConnectionString = "Data Source=dovt9hxyqo.database.windows.net;Initial Catalog=EventManagerData;Pers" &
    "ist Security Info=True;User ID=Pappy;Password=jps1216!B"
        Me.EventManagerDB.Name = "EventManagerDB"
        Me.EventManagerDB.Parameters.AddRange(New Telerik.Reporting.SqlDataSourceParameter() {New Telerik.Reporting.SqlDataSourceParameter("@startDate", System.Data.DbType.[String], "7/1/2016"), New Telerik.Reporting.SqlDataSourceParameter("@endDate", System.Data.DbType.[String], "7/31/2016")})
        Me.EventManagerDB.ProviderName = "System.Data.SqlClient"
        Me.EventManagerDB.SelectCommand = resources.GetString("EventManagerDB.SelectCommand")
        '
        'detailSection1
        '
        Me.detailSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(1.0R)
        Me.detailSection1.Items.AddRange(New Telerik.Reporting.ReportItemBase() {Me.table1})
        Me.detailSection1.Name = "detailSection1"
        '
        'table1
        '
        Me.table1.Body.Columns.Add(New Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Inch(1.6183279752731323R)))
        Me.table1.Body.Columns.Add(New Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Inch(0.88499504327774048R)))
        Me.table1.Body.Columns.Add(New Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Inch(0.77666234970092773R)))
        Me.table1.Body.Columns.Add(New Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Inch(0.68499445915222168R)))
        Me.table1.Body.Columns.Add(New Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Inch(0.9599948525428772R)))
        Me.table1.Body.Columns.Add(New Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Inch(0.78499495983123779R)))
        Me.table1.Body.Columns.Add(New Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Inch(1.076662540435791R)))
        Me.table1.Body.Rows.Add(New Telerik.Reporting.TableBodyRow(Telerik.Reporting.Drawing.Unit.Inch(0.20000001788139343R)))
        Me.table1.Body.Rows.Add(New Telerik.Reporting.TableBodyRow(Telerik.Reporting.Drawing.Unit.Inch(0.20000001788139343R)))
        Me.table1.Body.Rows.Add(New Telerik.Reporting.TableBodyRow(Telerik.Reporting.Drawing.Unit.Inch(0.20000001788139343R)))
        Me.table1.Body.Rows.Add(New Telerik.Reporting.TableBodyRow(Telerik.Reporting.Drawing.Unit.Inch(0.20000001788139343R)))
        Me.table1.Body.Rows.Add(New Telerik.Reporting.TableBodyRow(Telerik.Reporting.Drawing.Unit.Inch(0.20000001788139343R)))
        Me.table1.Body.SetCellContent(1, 0, Me.textBox14)
        Me.table1.Body.SetCellContent(1, 1, Me.textBox16)
        Me.table1.Body.SetCellContent(1, 2, Me.textBox18)
        Me.table1.Body.SetCellContent(1, 3, Me.textBox19)
        Me.table1.Body.SetCellContent(1, 4, Me.textBox20)
        Me.table1.Body.SetCellContent(1, 5, Me.textBox21)
        Me.table1.Body.SetCellContent(1, 6, Me.textBox22)
        Me.table1.Body.SetCellContent(0, 0, Me.textBox13)
        Me.table1.Body.SetCellContent(0, 1, Me.textBox15)
        Me.table1.Body.SetCellContent(0, 2, Me.textBox17)
        Me.table1.Body.SetCellContent(0, 3, Me.textBox23)
        Me.table1.Body.SetCellContent(0, 4, Me.textBox24)
        Me.table1.Body.SetCellContent(0, 5, Me.textBox25)
        Me.table1.Body.SetCellContent(0, 6, Me.textBox26)
        Me.table1.Body.SetCellContent(2, 0, Me.textBox28)
        Me.table1.Body.SetCellContent(2, 1, Me.textBox29)
        Me.table1.Body.SetCellContent(2, 2, Me.textBox30)
        Me.table1.Body.SetCellContent(2, 3, Me.textBox31)
        Me.table1.Body.SetCellContent(2, 4, Me.textBox32)
        Me.table1.Body.SetCellContent(2, 5, Me.textBox33)
        Me.table1.Body.SetCellContent(2, 6, Me.textBox34)
        Me.table1.Body.SetCellContent(4, 0, Me.textBox6)
        Me.table1.Body.SetCellContent(4, 1, Me.textBox12)
        Me.table1.Body.SetCellContent(4, 2, Me.textBox27)
        Me.table1.Body.SetCellContent(4, 3, Me.textBox35)
        Me.table1.Body.SetCellContent(4, 4, Me.textBox36)
        Me.table1.Body.SetCellContent(4, 5, Me.textBox37)
        Me.table1.Body.SetCellContent(4, 6, Me.textBox38)
        Me.table1.Body.SetCellContent(3, 0, Me.textBox40)
        Me.table1.Body.SetCellContent(3, 1, Me.textBox41)
        Me.table1.Body.SetCellContent(3, 2, Me.textBox42)
        Me.table1.Body.SetCellContent(3, 3, Me.textBox43)
        Me.table1.Body.SetCellContent(3, 4, Me.textBox44)
        Me.table1.Body.SetCellContent(3, 5, Me.textBox45)
        Me.table1.Body.SetCellContent(3, 6, Me.textBox46)
        TableGroup1.Name = "fullName"
        TableGroup1.ReportItem = Me.textBox3
        TableGroup2.Name = "paymentDate"
        TableGroup2.ReportItem = Me.textBox5
        TableGroup3.Name = "rate"
        TableGroup3.ReportItem = Me.textBox7
        TableGroup4.Name = "hours"
        TableGroup4.ReportItem = Me.textBox8
        TableGroup5.Name = "total"
        TableGroup5.ReportItem = Me.textBox9
        TableGroup6.Name = "expenses"
        TableGroup6.ReportItem = Me.textBox10
        TableGroup7.Name = "totalAmount"
        TableGroup7.ReportItem = Me.textBox11
        Me.table1.ColumnGroups.Add(TableGroup1)
        Me.table1.ColumnGroups.Add(TableGroup2)
        Me.table1.ColumnGroups.Add(TableGroup3)
        Me.table1.ColumnGroups.Add(TableGroup4)
        Me.table1.ColumnGroups.Add(TableGroup5)
        Me.table1.ColumnGroups.Add(TableGroup6)
        Me.table1.ColumnGroups.Add(TableGroup7)
        Me.table1.Corner.SetCellContent(0, 0, Me.textBox4)
        Me.table1.DataSource = Me.EventManagerDB
        Me.table1.Filters.Add(New Telerik.Reporting.Filter("= Fields.paymentDate", Telerik.Reporting.FilterOperator.GreaterOrEqual, "= Parameters.startDate.Value"))
        Me.table1.Filters.Add(New Telerik.Reporting.Filter("= Fields.paymentDate", Telerik.Reporting.FilterOperator.LessOrEqual, "= Parameters.endDate.Value"))
        Me.table1.Items.AddRange(New Telerik.Reporting.ReportItemBase() {Me.textBox4, Me.textBox13, Me.textBox15, Me.textBox17, Me.textBox23, Me.textBox24, Me.textBox25, Me.textBox26, Me.textBox14, Me.textBox16, Me.textBox18, Me.textBox19, Me.textBox20, Me.textBox21, Me.textBox22, Me.textBox28, Me.textBox29, Me.textBox30, Me.textBox31, Me.textBox32, Me.textBox33, Me.textBox34, Me.textBox40, Me.textBox41, Me.textBox42, Me.textBox43, Me.textBox44, Me.textBox45, Me.textBox46, Me.textBox6, Me.textBox12, Me.textBox27, Me.textBox35, Me.textBox36, Me.textBox37, Me.textBox38, Me.textBox3, Me.textBox5, Me.textBox7, Me.textBox8, Me.textBox9, Me.textBox10, Me.textBox11, Me.textBox2, Me.textBox39, Me.textBox1})
        Me.table1.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.table1.Name = "table1"
        TableGroup9.Name = "group"
        TableGroup10.Groupings.Add(New Telerik.Reporting.Grouping(Nothing))
        TableGroup10.Name = "detail"
        TableGroup11.Name = "group1"
        TableGroup8.ChildGroups.Add(TableGroup9)
        TableGroup8.ChildGroups.Add(TableGroup10)
        TableGroup8.ChildGroups.Add(TableGroup11)
        TableGroup8.Groupings.Add(New Telerik.Reporting.Grouping("= Fields.eventID"))
        TableGroup8.Name = "eventID1"
        TableGroup8.ReportItem = Me.textBox2
        TableGroup8.Sortings.Add(New Telerik.Reporting.Sorting("= Fields.eventID", Telerik.Reporting.SortDirection.Asc))
        TableGroup13.Name = "group5"
        TableGroup12.ChildGroups.Add(TableGroup13)
        TableGroup12.Name = "group4"
        TableGroup12.ReportItem = Me.textBox39
        TableGroup15.Name = "group3"
        TableGroup14.ChildGroups.Add(TableGroup15)
        TableGroup14.Name = "group2"
        TableGroup14.ReportItem = Me.textBox1
        Me.table1.RowGroups.Add(TableGroup8)
        Me.table1.RowGroups.Add(TableGroup12)
        Me.table1.RowGroups.Add(TableGroup14)
        Me.table1.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(7.6699652671813965R), Telerik.Reporting.Drawing.Unit.Inch(1.2000000476837158R))
        Me.table1.Style.Font.Bold = True
        Me.table1.StyleName = "Corporate.TableNormal"
        '
        'textBox14
        '
        Me.textBox14.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox14.Name = "textBox14"
        Me.textBox14.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.6183280944824219R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox14.Style.Font.Bold = False
        Me.textBox14.StyleName = "Corporate.TableBody"
        Me.textBox14.Value = "= Fields.FullName"
        '
        'textBox16
        '
        Me.textBox16.Format = "{0:d}"
        Me.textBox16.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox16.Name = "textBox16"
        Me.textBox16.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.88499516248703R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox16.Style.BackgroundColor = System.Drawing.Color.Ivory
        Me.textBox16.Style.Font.Bold = False
        Me.textBox16.StyleName = "Corporate.TableBody"
        Me.textBox16.Value = "= Fields.paymentDate"
        '
        'textBox18
        '
        Me.textBox18.Format = "{0:C2}"
        Me.textBox18.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox18.Name = "textBox18"
        Me.textBox18.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.77666211128234863R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox18.Style.BackgroundColor = System.Drawing.Color.Ivory
        Me.textBox18.Style.Font.Bold = False
        Me.textBox18.StyleName = "Corporate.TableBody"
        Me.textBox18.Value = "= Fields.rate"
        '
        'textBox19
        '
        Me.textBox19.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox19.Name = "textBox19"
        Me.textBox19.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.68499499559402466R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox19.Style.BackgroundColor = System.Drawing.Color.Ivory
        Me.textBox19.Style.Font.Bold = False
        Me.textBox19.StyleName = "Corporate.TableBody"
        Me.textBox19.Value = "= Fields.hours"
        '
        'textBox20
        '
        Me.textBox20.Format = "{0:C2}"
        Me.textBox20.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox20.Name = "textBox20"
        Me.textBox20.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.9599950909614563R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox20.Style.BackgroundColor = System.Drawing.Color.Ivory
        Me.textBox20.Style.Font.Bold = False
        Me.textBox20.StyleName = "Corporate.TableBody"
        Me.textBox20.Value = "= Fields.Total"
        '
        'textBox21
        '
        Me.textBox21.Format = "{0:C2}"
        Me.textBox21.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox21.Name = "textBox21"
        Me.textBox21.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.78499519824981689R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox21.Style.BackgroundColor = System.Drawing.Color.Ivory
        Me.textBox21.Style.Font.Bold = False
        Me.textBox21.StyleName = "Corporate.TableBody"
        Me.textBox21.Value = "= Fields.expenses"
        '
        'textBox22
        '
        Me.textBox22.Format = "{0:C2}"
        Me.textBox22.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox22.Name = "textBox22"
        Me.textBox22.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0766621828079224R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox22.Style.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(248, Byte), Integer), CType(CType(219, Byte), Integer))
        Me.textBox22.Style.Font.Bold = False
        Me.textBox22.StyleName = "Corporate.TableBody"
        Me.textBox22.Value = "= Fields.TotalAmount"
        '
        'textBox13
        '
        Me.textBox13.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox13.Name = "textBox13"
        Me.textBox13.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.6183280944824219R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox13.StyleName = "Corporate.TableBody"
        '
        'textBox15
        '
        Me.textBox15.Name = "textBox15"
        Me.textBox15.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.88499516248703R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox15.StyleName = "Corporate.TableBody"
        '
        'textBox17
        '
        Me.textBox17.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox17.Name = "textBox17"
        Me.textBox17.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.77666205167770386R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox17.StyleName = "Corporate.TableBody"
        '
        'textBox23
        '
        Me.textBox23.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox23.Name = "textBox23"
        Me.textBox23.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.68499493598937988R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox23.StyleName = "Corporate.TableBody"
        '
        'textBox24
        '
        Me.textBox24.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox24.Name = "textBox24"
        Me.textBox24.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.95999521017074585R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox24.StyleName = "Corporate.TableBody"
        '
        'textBox25
        '
        Me.textBox25.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox25.Name = "textBox25"
        Me.textBox25.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.78499513864517212R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox25.StyleName = "Corporate.TableBody"
        '
        'textBox26
        '
        Me.textBox26.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox26.Name = "textBox26"
        Me.textBox26.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0766621828079224R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox26.StyleName = "Corporate.TableBody"
        '
        'textBox28
        '
        Me.textBox28.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox28.Name = "textBox28"
        Me.textBox28.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.6183280944824219R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox28.StyleName = "Corporate.TableBody"
        '
        'textBox29
        '
        Me.textBox29.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox29.Name = "textBox29"
        Me.textBox29.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.88499516248703R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox29.StyleName = "Corporate.TableBody"
        '
        'textBox30
        '
        Me.textBox30.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox30.Name = "textBox30"
        Me.textBox30.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.77666205167770386R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox30.StyleName = "Corporate.TableBody"
        '
        'textBox31
        '
        Me.textBox31.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox31.Name = "textBox31"
        Me.textBox31.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.68499481678009033R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox31.StyleName = "Corporate.TableBody"
        '
        'textBox32
        '
        Me.textBox32.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox32.Name = "textBox32"
        Me.textBox32.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.95999521017074585R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox32.StyleName = "Corporate.TableBody"
        '
        'textBox33
        '
        Me.textBox33.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox33.Name = "textBox33"
        Me.textBox33.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.78499507904052734R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox33.StyleName = "Corporate.TableBody"
        '
        'textBox34
        '
        Me.textBox34.Format = "{0:C2}"
        Me.textBox34.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox34.Name = "textBox34"
        Me.textBox34.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0766621828079224R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox34.Style.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(248, Byte), Integer), CType(CType(219, Byte), Integer))
        Me.textBox34.StyleName = "Corporate.TableBody"
        Me.textBox34.Value = "= SUM(Fields.TotalAmount)"
        '
        'textBox6
        '
        Me.textBox6.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox6.Name = "textBox6"
        Me.textBox6.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.6183279752731323R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox6.StyleName = "Corporate.TableBody"
        '
        'textBox12
        '
        Me.textBox12.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox12.Name = "textBox12"
        Me.textBox12.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.88499492406845093R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox12.StyleName = "Corporate.TableBody"
        '
        'textBox27
        '
        Me.textBox27.Format = "{0:C2}"
        Me.textBox27.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox27.Name = "textBox27"
        Me.textBox27.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.776662290096283R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox27.StyleName = "Corporate.TableBody"
        Me.textBox27.Value = "=Sum(Fields.rate)"
        '
        'textBox35
        '
        Me.textBox35.Format = ""
        Me.textBox35.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox35.Name = "textBox35"
        Me.textBox35.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.68499457836151123R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox35.StyleName = "Corporate.TableBody"
        Me.textBox35.Value = "=Sum(Fields.hours)"
        '
        'textBox36
        '
        Me.textBox36.Format = "{0:C2}"
        Me.textBox36.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox36.Name = "textBox36"
        Me.textBox36.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.9599948525428772R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox36.StyleName = "Corporate.TableBody"
        Me.textBox36.Value = "=Sum(Fields.Total)"
        '
        'textBox37
        '
        Me.textBox37.Format = "{0:C2}"
        Me.textBox37.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox37.Name = "textBox37"
        Me.textBox37.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.78499513864517212R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox37.StyleName = "Corporate.TableBody"
        Me.textBox37.Value = "=Sum(Fields.expenses)"
        '
        'textBox38
        '
        Me.textBox38.Format = "{0:C2}"
        Me.textBox38.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox38.Name = "textBox38"
        Me.textBox38.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0766621828079224R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox38.StyleName = "Corporate.TableBody"
        Me.textBox38.Value = "=Sum(Fields.TotalAmount)"
        '
        'textBox40
        '
        Me.textBox40.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox40.Name = "textBox40"
        Me.textBox40.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.6183279752731323R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox40.StyleName = "Corporate.TableBody"
        '
        'textBox41
        '
        Me.textBox41.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox41.Name = "textBox41"
        Me.textBox41.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.88499492406845093R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox41.StyleName = "Corporate.TableBody"
        '
        'textBox42
        '
        Me.textBox42.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox42.Name = "textBox42"
        Me.textBox42.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.77666234970092773R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox42.StyleName = "Corporate.TableBody"
        '
        'textBox43
        '
        Me.textBox43.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox43.Name = "textBox43"
        Me.textBox43.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.68499457836151123R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox43.StyleName = "Corporate.TableBody"
        '
        'textBox44
        '
        Me.textBox44.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox44.Name = "textBox44"
        Me.textBox44.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.9599948525428772R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox44.StyleName = "Corporate.TableBody"
        '
        'textBox45
        '
        Me.textBox45.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox45.Name = "textBox45"
        Me.textBox45.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.78499513864517212R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox45.StyleName = "Corporate.TableBody"
        '
        'textBox46
        '
        Me.textBox46.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox46.Name = "textBox46"
        Me.textBox46.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.0766623020172119R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox46.StyleName = "Corporate.TableBody"
        '
        'textBox4
        '
        Me.textBox4.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox4.Name = "textBox4"
        Me.textBox4.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.88333326578140259R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox4.StyleName = "Corporate.TableHeader"
        Me.textBox4.Value = "Event ID"
        '
        'pageHeaderSection1
        '
        Me.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(1.1000000238418579R)
        Me.pageHeaderSection1.Items.AddRange(New Telerik.Reporting.ReportItemBase() {Me.ReportNameTextBox, Me.textBox47, Me.textBox48, Me.textBox49, Me.textBox50, Me.textBox51})
        Me.pageHeaderSection1.Name = "pageHeaderSection1"
        '
        'ReportNameTextBox
        '
        Me.ReportNameTextBox.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.ReportNameTextBox.Name = "ReportNameTextBox"
        Me.ReportNameTextBox.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.9999215602874756R), Telerik.Reporting.Drawing.Unit.Inch(0.39992129802703857R))
        Me.ReportNameTextBox.Style.Font.Bold = True
        Me.ReportNameTextBox.Style.Font.Name = "Segoe UI"
        Me.ReportNameTextBox.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(18.0R)
        Me.ReportNameTextBox.Value = "Payroll Report"
        '
        'textBox47
        '
        Me.textBox47.Format = "{0:D}"
        Me.textBox47.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.500078558921814R), Telerik.Reporting.Drawing.Unit.Inch(0.40000000596046448R))
        Me.textBox47.Name = "textBox47"
        Me.textBox47.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.4998428821563721R), Telerik.Reporting.Drawing.Unit.Inch(0.20000000298023224R))
        Me.textBox47.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9.0R)
        Me.textBox47.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left
        Me.textBox47.Value = "= Parameters.startDate.Value "
        '
        'textBox48
        '
        Me.textBox48.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.000039418537198798731R), Telerik.Reporting.Drawing.Unit.Inch(0.40000000596046448R))
        Me.textBox48.Name = "textBox48"
        Me.textBox48.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.49996057152748108R), Telerik.Reporting.Drawing.Unit.Inch(0.19999994337558746R))
        Me.textBox48.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9.0R)
        Me.textBox48.Value = "From:"
        '
        'textBox49
        '
        Me.textBox49.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.000039418537198798731R), Telerik.Reporting.Drawing.Unit.Inch(0.60007870197296143R))
        Me.textBox49.Name = "textBox49"
        Me.textBox49.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.49996057152748108R), Telerik.Reporting.Drawing.Unit.Inch(0.19999994337558746R))
        Me.textBox49.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9.0R)
        Me.textBox49.Value = "To:"
        '
        'textBox50
        '
        Me.textBox50.Format = "{0:D}"
        Me.textBox50.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.50007885694503784R), Telerik.Reporting.Drawing.Unit.Inch(0.60007870197296143R))
        Me.textBox50.Name = "textBox50"
        Me.textBox50.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(3.4998428821563721R), Telerik.Reporting.Drawing.Unit.Inch(0.19999994337558746R))
        Me.textBox50.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9.0R)
        Me.textBox50.Value = "= Parameters.endDate.Value"
        '
        'textBox51
        '
        Me.textBox51.Format = "{0:g}"
        Me.textBox51.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(5.9000000953674316R), Telerik.Reporting.Drawing.Unit.Inch(0R))
        Me.textBox51.Name = "textBox51"
        Me.textBox51.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.7799606323242188R), Telerik.Reporting.Drawing.Unit.Inch(0.19999994337558746R))
        Me.textBox51.Style.Font.Name = "Segoe UI"
        Me.textBox51.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9.0R)
        Me.textBox51.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right
        Me.textBox51.Value = "= Now()"
        '
        'pageFooterSection1
        '
        Me.pageFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(1.0R)
        Me.pageFooterSection1.Items.AddRange(New Telerik.Reporting.ReportItemBase() {Me.ReportPageNumberTextBox})
        Me.pageFooterSection1.Name = "pageFooterSection1"
        '
        'ReportPageNumberTextBox
        '
        Me.ReportPageNumberTextBox.Location = New Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(6.1999998092651367R), Telerik.Reporting.Drawing.Unit.Inch(0.69999986886978149R))
        Me.ReportPageNumberTextBox.Name = "ReportPageNumberTextBox"
        Me.ReportPageNumberTextBox.Size = New Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.479960560798645R), Telerik.Reporting.Drawing.Unit.Inch(0.30000013113021851R))
        Me.ReportPageNumberTextBox.Style.Font.Name = "Segoe UI"
        Me.ReportPageNumberTextBox.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9.0R)
        Me.ReportPageNumberTextBox.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right
        Me.ReportPageNumberTextBox.Value = "Page: {PageNumber}"
        '
        'PayRoll
        '
        Me.DocumentName = "Payroll Report"
        Me.Items.AddRange(New Telerik.Reporting.ReportItemBase() {Me.detailSection1, Me.pageHeaderSection1, Me.pageFooterSection1})
        Me.Name = "PayrollReport"
        Me.PageSettings.Landscape = False
        Me.PageSettings.Margins = New Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Inch(0.25R), Telerik.Reporting.Drawing.Unit.Inch(0.25R), Telerik.Reporting.Drawing.Unit.Inch(0.5R), Telerik.Reporting.Drawing.Unit.Inch(0.5R))
        Me.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.Letter
        StyleRule1.Selectors.AddRange(New Telerik.Reporting.Drawing.ISelector() {New Telerik.Reporting.Drawing.TypeSelector(GetType(Telerik.Reporting.TextItemBase)), New Telerik.Reporting.Drawing.TypeSelector(GetType(Telerik.Reporting.HtmlTextBox))})
        StyleRule1.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(2.0R)
        StyleRule1.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(2.0R)
        StyleRule2.Selectors.AddRange(New Telerik.Reporting.Drawing.ISelector() {New Telerik.Reporting.Drawing.TypeSelector(GetType(Telerik.Reporting.TextItemBase)), New Telerik.Reporting.Drawing.TypeSelector(GetType(Telerik.Reporting.HtmlTextBox))})
        StyleRule2.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(2.0R)
        StyleRule2.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(2.0R)
        StyleRule3.Selectors.AddRange(New Telerik.Reporting.Drawing.ISelector() {New Telerik.Reporting.Drawing.StyleSelector(GetType(Telerik.Reporting.Table), "Corporate.TableNormal")})
        StyleRule3.Style.BorderColor.Default = System.Drawing.Color.Black
        StyleRule3.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid
        StyleRule3.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1.0R)
        StyleRule3.Style.Color = System.Drawing.Color.Black
        StyleRule3.Style.Font.Name = "Tahoma"
        StyleRule3.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9.0R)
        DescendantSelector1.Selectors.AddRange(New Telerik.Reporting.Drawing.ISelector() {New Telerik.Reporting.Drawing.TypeSelector(GetType(Telerik.Reporting.Table)), New Telerik.Reporting.Drawing.StyleSelector(GetType(Telerik.Reporting.ReportItem), "Corporate.TableBody")})
        StyleRule4.Selectors.AddRange(New Telerik.Reporting.Drawing.ISelector() {DescendantSelector1})
        StyleRule4.Style.BorderColor.Default = System.Drawing.Color.Black
        StyleRule4.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid
        StyleRule4.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1.0R)
        StyleRule4.Style.Font.Name = "Tahoma"
        StyleRule4.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9.0R)
        DescendantSelector2.Selectors.AddRange(New Telerik.Reporting.Drawing.ISelector() {New Telerik.Reporting.Drawing.TypeSelector(GetType(Telerik.Reporting.Table)), New Telerik.Reporting.Drawing.StyleSelector(GetType(Telerik.Reporting.ReportItem), "Corporate.TableHeader")})
        StyleRule5.Selectors.AddRange(New Telerik.Reporting.Drawing.ISelector() {DescendantSelector2})
        StyleRule5.Style.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(28, Byte), Integer), CType(CType(58, Byte), Integer), CType(CType(112, Byte), Integer))
        StyleRule5.Style.BorderColor.Default = System.Drawing.Color.Black
        StyleRule5.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid
        StyleRule5.Style.BorderWidth.Default = Telerik.Reporting.Drawing.Unit.Pixel(1.0R)
        StyleRule5.Style.Color = System.Drawing.Color.White
        StyleRule5.Style.Font.Name = "Tahoma"
        StyleRule5.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10.0R)
        StyleRule5.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle
        Me.StyleSheet.AddRange(New Telerik.Reporting.Drawing.StyleRule() {StyleRule1, StyleRule2, StyleRule3, StyleRule4, StyleRule5})
        Me.Width = Telerik.Reporting.Drawing.Unit.Inch(7.679999828338623R)
        CType(Me, System.ComponentModel.ISupportInitialize).EndInit()

    End Sub

    Friend WithEvents EventManagerDB As Telerik.Reporting.SqlDataSource
    Friend WithEvents detailSection1 As Telerik.Reporting.DetailSection
    Friend WithEvents table1 As Telerik.Reporting.Table
    Friend WithEvents textBox14 As Telerik.Reporting.TextBox
    Friend WithEvents textBox16 As Telerik.Reporting.TextBox
    Friend WithEvents textBox18 As Telerik.Reporting.TextBox
    Friend WithEvents textBox19 As Telerik.Reporting.TextBox
    Friend WithEvents textBox20 As Telerik.Reporting.TextBox
    Friend WithEvents textBox21 As Telerik.Reporting.TextBox
    Friend WithEvents textBox22 As Telerik.Reporting.TextBox
    Friend WithEvents textBox13 As Telerik.Reporting.TextBox
    Friend WithEvents textBox15 As Telerik.Reporting.TextBox
    Friend WithEvents textBox17 As Telerik.Reporting.TextBox
    Friend WithEvents textBox23 As Telerik.Reporting.TextBox
    Friend WithEvents textBox24 As Telerik.Reporting.TextBox
    Friend WithEvents textBox25 As Telerik.Reporting.TextBox
    Friend WithEvents textBox26 As Telerik.Reporting.TextBox
    Friend WithEvents textBox28 As Telerik.Reporting.TextBox
    Friend WithEvents textBox29 As Telerik.Reporting.TextBox
    Friend WithEvents textBox30 As Telerik.Reporting.TextBox
    Friend WithEvents textBox31 As Telerik.Reporting.TextBox
    Friend WithEvents textBox32 As Telerik.Reporting.TextBox
    Friend WithEvents textBox33 As Telerik.Reporting.TextBox
    Friend WithEvents textBox34 As Telerik.Reporting.TextBox
    Friend WithEvents textBox6 As Telerik.Reporting.TextBox
    Friend WithEvents textBox12 As Telerik.Reporting.TextBox
    Friend WithEvents textBox27 As Telerik.Reporting.TextBox
    Friend WithEvents textBox35 As Telerik.Reporting.TextBox
    Friend WithEvents textBox36 As Telerik.Reporting.TextBox
    Friend WithEvents textBox37 As Telerik.Reporting.TextBox
    Friend WithEvents textBox38 As Telerik.Reporting.TextBox
    Friend WithEvents textBox40 As Telerik.Reporting.TextBox
    Friend WithEvents textBox41 As Telerik.Reporting.TextBox
    Friend WithEvents textBox42 As Telerik.Reporting.TextBox
    Friend WithEvents textBox43 As Telerik.Reporting.TextBox
    Friend WithEvents textBox44 As Telerik.Reporting.TextBox
    Friend WithEvents textBox45 As Telerik.Reporting.TextBox
    Friend WithEvents textBox46 As Telerik.Reporting.TextBox
    Friend WithEvents textBox3 As Telerik.Reporting.TextBox
    Friend WithEvents textBox5 As Telerik.Reporting.TextBox
    Friend WithEvents textBox7 As Telerik.Reporting.TextBox
    Friend WithEvents textBox8 As Telerik.Reporting.TextBox
    Friend WithEvents textBox9 As Telerik.Reporting.TextBox
    Friend WithEvents textBox10 As Telerik.Reporting.TextBox
    Friend WithEvents textBox11 As Telerik.Reporting.TextBox
    Friend WithEvents textBox4 As Telerik.Reporting.TextBox
    Friend WithEvents textBox2 As Telerik.Reporting.TextBox
    Friend WithEvents textBox39 As Telerik.Reporting.TextBox
    Friend WithEvents textBox1 As Telerik.Reporting.TextBox
    Friend WithEvents pageHeaderSection1 As Telerik.Reporting.PageHeaderSection
    Friend WithEvents ReportNameTextBox As Telerik.Reporting.TextBox
    Friend WithEvents textBox47 As Telerik.Reporting.TextBox
    Friend WithEvents textBox48 As Telerik.Reporting.TextBox
    Friend WithEvents textBox49 As Telerik.Reporting.TextBox
    Friend WithEvents textBox50 As Telerik.Reporting.TextBox
    Friend WithEvents textBox51 As Telerik.Reporting.TextBox
    Friend WithEvents pageFooterSection1 As Telerik.Reporting.PageFooterSection
    Friend WithEvents ReportPageNumberTextBox As Telerik.Reporting.TextBox
End Class