<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="OffPremiseDashboard.aspx.vb" 
    Inherits="EventManagerApplication.OffPremiseDashboard" %>
<%@ Register Src="~/Reports/UserControls/SideMenuControl.ascx" TagPrefix="uc1" TagName="SideMenuControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hiddenUserID" runat="server" />
    <asp:HiddenField ID="hiddenClientID" runat="server" />

        <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard: Retail/Off Premise</h2>
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col-md-2">
                <div class="widget stacked">
                    <uc1:SideMenuControl runat="server" id="SideMenuControl" />
                </div>

            </div>

            <div class="col-md-10">

 <h3>
     <asp:Label ID="SelectedSupplierLabel" runat="server" Text="Performance Metrics"></asp:Label></h3>

                 <p style="font-size: 12px;">
                    <asp:Label ID="DateRangeLabel" runat="server" Font-Bold="true" /></p>

                <div class="widget-content-sidebar sidemenu" style="padding: 15px 5px 15px;">

                 <telerik:RadComboBox RenderMode="Lightweight" ID="SelectedSupplier" runat="server" 
                                        Label="Supplier:" EmptyMessage="Select Supplier" AllowCustomText="true" MarkFirstMatch="true"
                                        Height="200px" Width="375px" DataSourceID="GetSupplierList" DataValueField="supplierID" DataTextField="supplierName">
                                    </telerik:RadComboBox>

                    <asp:SqlDataSource runat="server" ID="GetSupplierList" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetSuppliersByUserIDandClientID" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hiddenUserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>

                            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>

                        </SelectParameters>
                    </asp:SqlDataSource>



                <strong> From:</strong>

                <telerik:RadDatePicker ID="FromDatePicker" runat="server" Culture="en-US" SelectedDate="2016-03-01">
                    <DateInput runat="server" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy"  LabelWidth="40%">
                    </DateInput>
                     <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>
                </telerik:RadDatePicker>

                <strong> To:</strong>
                <telerik:RadDatePicker ID="ToDatePicker" runat="server" Culture="en-US" SelectedDate="2016-03-31">
                    <DateInput DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%">
                    </DateInput>
                     <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>
                </telerik:RadDatePicker>

                <asp:Button ID="btnChangeDateRange" runat="server" Text="Go" CssClass="btn btn-default" />

                <%--<a id='filterbutton' class="filterbutton" href="#">Advanced Filter</a>--%>


                <div class="btn-group pull-right" role="group" aria-label="...">
                    <asp:Button ID="btnViewWeek" runat="server" Text="Week" CssClass="btn btn-success" />
                    <asp:Button ID="btnViewMonth" runat="server" Text="Month" CssClass="btn btn-default" />
                </div>
            </div>

                <asp:Panel ID="MainPanel" runat="server">

                    <div runat="server" id="DefaultMessage" class="alert alert-info" role="alert">Select a supplier and date range above.</div>

                    <asp:Label ID="NoResultLabel" runat="server" />

                </asp:Panel>


 <asp:Panel ID="ReportPanel" runat="server" Visible="false">
            <div class="col-md-7">

               
                <div class="widget stacked">
                    <div class="widget-content">


                        <div class="panel panel-default">
                            <div class="panel-body">

                                <div class="col-md-3">
                                    <strong>Event Volume</strong><br />
                                    <h2>
                                        <asp:Label ID="VolumeLabel" runat="server" /></h2>
                                </div>
                                <div class="col-md-9">


                                    <telerik:RadHtmlChart ID="EventVolumeChart" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px" DataSourceID="getEventCounts" Transitions="False">

                                        <PlotArea>
                                            <CommonTooltipsAppearance Color="White" Shared="false" />
                                            <Series>
                                                <telerik:AreaSeries Name="WeekCounts1" DataFieldY="COUNT">
                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>
                                                </telerik:AreaSeries>
                                            </Series>
                                        </PlotArea>
                                        
                                        <Legend>
                                            <Appearance Position="Bottom" Orientation="Vertical"></Appearance>
                                        </Legend>

                                    </telerik:RadHtmlChart>


                                    <asp:SqlDataSource runat="server" ID="getEventCounts" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetEventCountByWeek_EventType" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" DbType="Date" Name="startDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="SelectedSupplier" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                                            <asp:Parameter DefaultValue="261" Name="eventTypeID" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    
                                </div>
                            </div>

                        </div>

                        <div class="panel panel-default">
                            <div class="panel-body">

                                <div class="col-md-3">
                                    <strong>Consumers Sampled</strong><br />
                                    <h2>
                                        <asp:Label ID="SampledTotalLabel" runat="server" /></h2>
                                </div>
                                <div class="col-md-9">
                                    
                                    <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px" DataSourceID="getSampledWeeklyTotals" Transitions="False">


                                        <PlotArea>

                                            <CommonTooltipsAppearance Color="White" Shared="false" />

                                            <Series>
                                                <telerik:AreaSeries Name="WeekCounts1" DataFieldY="TOTAL">
                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>
                                                </telerik:AreaSeries>

                                            </Series>
                                        </PlotArea>

                                        <Legend>
                                            <Appearance Position="Bottom" Orientation="Vertical"></Appearance>
                                        </Legend>

                                    </telerik:RadHtmlChart>

                                    <asp:SqlDataSource runat="server" ID="getSampledWeeklyTotals" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getRecapWeeklyTotalsbyDateRange" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="0" Name="recapID" Type="Int32"></asp:Parameter>
                                            <asp:Parameter DefaultValue="1" Name="recapQuestionID" Type="Int32"></asp:Parameter>
                                            <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" DbType="Date" DefaultValue="" Name="startDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="SelectedSupplier" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>

                        </div>

                        <div class="panel panel-default">
                            <div class="panel-body">

                                <div class="col-md-3">
                                    <strong>Bottles Sold</strong><br />
                                    <h2><asp:Label ID="BottlesSoldTotalLabel" runat="server" /></h2>
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadHtmlChart ID="RadHtmlChart2" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px" DataSourceID="getSoldWeeklyTotals" Transitions="False">


                                        <PlotArea>

                                            <CommonTooltipsAppearance Color="White" Shared="false" />

                                            <Series>
                                                <telerik:AreaSeries Name="WeekCounts1" DataFieldY="TOTAL">
                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>
                                                </telerik:AreaSeries>

                                            </Series>
                                        </PlotArea>

                                        <Legend>
                                            <Appearance Position="Bottom" Orientation="Vertical"></Appearance>
                                        </Legend>

                                    </telerik:RadHtmlChart>

                                     <asp:SqlDataSource runat="server" ID="getSoldWeeklyTotals" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getRecapWeeklyTotalsbyDateRange" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="0" Name="recapID" Type="Int32"></asp:Parameter>
                                            <asp:Parameter DefaultValue="3" Name="recapQuestionID" Type="Int32"></asp:Parameter>
                                            <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" DbType="Date" DefaultValue="" Name="startDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="SelectedSupplier" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>

                        </div>

                        <div class="panel panel-default">
                            <div class="panel-body">

                                <div class="col-md-3">
                                    <strong>Conversion Rate</strong><br />
                                    <h2>
                                        <asp:Label ID="ConversionRateLabel" runat="server" /></h2>
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadHtmlChart ID="RadHtmlChart3" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px" DataSourceID="GetConversionRate" Transitions="False">


                                        <PlotArea>

                                            <CommonTooltipsAppearance Color="White" Shared="false" />

                                            <Series>
                                                <telerik:AreaSeries Name="WeekCounts1" DataFieldY="Conversion">
                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>
                                                </telerik:AreaSeries>

                                            </Series>
                                        </PlotArea>

                                        <Legend>
                                            <Appearance Position="Bottom" Orientation="Vertical"></Appearance>
                                        </Legend>

                                    </telerik:RadHtmlChart>
                                    <asp:SqlDataSource runat="server" ID="GetConversionRate" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getRecapWeeklyConversionRatebyDateRange" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" DbType="Date" Name="startDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="SelectedSupplier" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>

                        </div>


                        <div class="panel panel-default">
                            <div class="panel-body">

                                <div class="col-md-3">
                                    <strong>Case Displays</strong><br />
                                    <h2>
                                        <asp:Label ID="CaseDisplayLabel" runat="server"  /></h2>
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadHtmlChart ID="RadHtmlChart5" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px" DataSourceID="GetConversionRate" Transitions="False">


                                        <PlotArea>

                                            <CommonTooltipsAppearance Color="White" Shared="false" />

                                            <Series>
                                                <telerik:AreaSeries Name="WeekCounts1" DataFieldY="Conversion">
                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>
                                                </telerik:AreaSeries>

                                            </Series>
                                        </PlotArea>

                                        <Legend>
                                            <Appearance Position="Bottom" Orientation="Vertical"></Appearance>
                                        </Legend>

                                    </telerik:RadHtmlChart>
                                    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getRecapWeeklyConversionRatebyDateRange" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" DbType="Date" Name="startDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="SelectedSupplier" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>

                        </div>

                        <div class="panel panel-default">
                            <div class="panel-body">

                                <div class="col-md-3">
                                    <strong>Average Cases per Display</strong><br />
                                    <h2>
                                        <asp:Label ID="AverageCasesLabel" runat="server"  /></h2>
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadHtmlChart ID="RadHtmlChart6" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px" DataSourceID="GetConversionRate" Transitions="False">


                                        <PlotArea>

                                            <CommonTooltipsAppearance Color="White" Shared="false" />

                                            <Series>
                                                <telerik:AreaSeries Name="WeekCounts1" DataFieldY="Conversion">
                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>
                                                </telerik:AreaSeries>

                                            </Series>
                                        </PlotArea>

                                        <Legend>
                                            <Appearance Position="Bottom" Orientation="Vertical"></Appearance>
                                        </Legend>

                                    </telerik:RadHtmlChart>
                                    <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getRecapWeeklyConversionRatebyDateRange" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" DbType="Date" Name="startDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="SelectedSupplier" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>

                        </div>

                        <div class="panel panel-default">
                            <div class="panel-body">

                                <div class="col-md-3">
                                    <strong>Estimated Revenue</strong><br />
                                    <h2><asp:Label ID="RevenueLabel" runat="server" /></h2>
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadHtmlChart ID="RadHtmlChart4" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px" DataSourceID="GetEstimatedRevenue" Transitions="False">


                                        <PlotArea>

                                            <CommonTooltipsAppearance Color="White" Shared="false" />

                                            <Series>
                                                <telerik:AreaSeries Name="WeekCounts1" DataFieldY="TOTAL">
                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>
                                                </telerik:AreaSeries>

                                            </Series>
                                        </PlotArea>

                                        <Legend>
                                            <Appearance Position="Bottom" Orientation="Vertical"></Appearance>
                                        </Legend>

                                    </telerik:RadHtmlChart>

                                    <asp:SqlDataSource runat="server" ID="GetEstimatedRevenue" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getRecapWeeklyEstimatedRevenue" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" DbType="Date" Name="startDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="SelectedSupplier" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                
            </div>

            <div class="col-md-5">
                
                <div class="widget stacked">
                    <div class="widget-content">


                        <telerik:RadHtmlChart ID="BrandsPromotedChart" runat="server" DataSourceID="getBrandTotals">
                            <ChartTitle Text="Brands Promoted">
                                <Appearance Align="Center" Position="Top" Visible="True">
                                </Appearance>
                            </ChartTitle>
                            <Legend>
                                <Appearance Position="Bottom" Orientation="Vertical" Visible="True"></Appearance>
                            </Legend>

                            <PlotArea>
                                <Series>
                                    <telerik:PieSeries StartAngle="90" Name="PieSeries1" DataFieldY="Event" NameField="brandName">
                                        <TooltipsAppearance Visible="true">
                                            <ClientTemplate>

                                            #=dataItem.brandName#

                            </ClientTemplate>
                                        </TooltipsAppearance>

                                        <LabelsAppearance>
                                            <ClientTemplate>
                                                #=dataItem.Event# Events
                                            </ClientTemplate>
                                        </LabelsAppearance>
                                    </telerik:PieSeries>
                                </Series>
                            </PlotArea>

                            <Legend>
                                <Appearance Position="Bottom" Orientation="Vertical"></Appearance>
                            </Legend>
                        </telerik:RadHtmlChart>

                        <br />


                        <telerik:RadListView ID="BrandTotalList" runat="server" DataKeyNames="brandID" DataSourceID="GetBrandTotalSummary" Skin="Bootstrap">
                            <LayoutTemplate>
                                <div class="" style="margin-left: 25px; margin-right: 20px;">
                                    <div runat="server" id="itemPlaceholder"></div>
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <div class="" style="margin-bottom: 15px;">
                                   
                                    &nbsp;<asp:Label ID="Label1" runat="server" Text='<%# getPercentage(Eval("Events")) %>' Font-Bold="true"></asp:Label>&nbsp;<asp:Label Text='<%# Eval("Column1") %>' runat="server" ID="Column1Label" Font-Bold="true" /><br />
                                     
                                    &nbsp;<asp:Label Text='<%# Eval("Events") %>' runat="server" ID="EventsLabel" Font-Size="X-Small" /> Events&nbsp;&nbsp;
                                    &nbsp;<asp:Label Text='<%# Eval("Sampled") %>' runat="server" ID="SampledLabel" Font-Size="X-Small" /> Sampled&nbsp;&nbsp;
                                    &nbsp;<asp:Label Text='<%# Eval("BottlesSold") %>' runat="server" ID="BottlesSoldLabel" Font-Size="X-Small" /> Bottles Sold<br />
                                </div>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <div class="" style="margin-bottom: 15px;">
                                    &nbsp;<asp:Label ID="Label1" runat="server" Text='<%# getPercentage(Eval("Events")) %>' Font-Bold="true"></asp:Label>&nbsp;<asp:Label Text='<%# Eval("Column1") %>' runat="server" ID="Column1Label" Font-Bold="true" /><br />
                                     
                                    &nbsp;<asp:Label Text='<%# Eval("Events") %>' runat="server" ID="EventsLabel" Font-Size="X-Small" /> Events&nbsp;&nbsp;
                                    &nbsp;<asp:Label Text='<%# Eval("Sampled") %>' runat="server" ID="SampledLabel" Font-Size="X-Small" /> Sampled&nbsp;&nbsp;
                                    &nbsp;<asp:Label Text='<%# Eval("BottlesSold") %>' runat="server" ID="BottlesSoldLabel" Font-Size="X-Small" /> Bottles Sold<br />
                                </div>
                            </AlternatingItemTemplate>
                            
                            <EmptyDataTemplate>
                                <div class="RadListView RadListView_Bootstrap">
                                    <div class="rlvEmpty">There are no items to be displayed.</div>
                                </div>
                            </EmptyDataTemplate>
                            <SelectedItemTemplate>
                                <div class="" style="margin-bottom: 15px;">
                                   &nbsp;<asp:Label ID="Label1" runat="server" Text='<%# getPercentage(Eval("Events")) %>' Font-Bold="true"></asp:Label>&nbsp;<asp:Label Text='<%# Eval("Column1") %>' runat="server" ID="Column1Label" Font-Bold="true" /><br />
                                    &nbsp;<asp:Label Text='<%# Eval("Events") %>' runat="server" ID="EventsLabel" Font-Size="X-Small" /> Events&nbsp;&nbsp;
                                    &nbsp;<asp:Label Text='<%# Eval("Sampled") %>' runat="server" ID="SampledLabel" Font-Size="X-Small" /> Sampled&nbsp;&nbsp;
                                    &nbsp;<asp:Label Text='<%# Eval("BottlesSold") %>' runat="server" ID="BottlesSoldLabel" Font-Size="X-Small" /> Bottles Sold<br />
                                </div>
                            </SelectedItemTemplate>
                        </telerik:RadListView>



                        <asp:SqlDataSource runat="server" ID="GetBrandTotalSummary" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getRecapSummaryTotalsForChartbySupplier" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="startdate" Type="DateTime"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="enddate" Type="DateTime"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="SelectedSupplier" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource runat="server" ID="getBrandTotals" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getRecapSummaryForChartbySupplier" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="startdate" Type="DateTime"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="enddate" Type="DateTime"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="SelectedSupplier" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        
                    </div>
                </div>

            </div>
</asp:Panel>
                </div>

        </div>




    </div>

    <script type="text/javascript">
        $('#reports').addClass('active');


        (function (global) {

            var chart;



            function ChartLoad(sender, args) {

                chart = sender.get_kendoWidget(); //store a reference to the Kendo Chart widget, we will use its methods

            }



            global.chartLoad = ChartLoad;



            function resizeChart() {

                if (chart)

                    chart.resize(); //redraw the chart so it takes the new size of its container when it changes (e.g., browser window size change, parent container size change)

            }





            //this logic ensures that the chart resizing will happen only once, at most - every 200ms

            //to prevent calling the handler too often if old browsers fire the window.onresize event multiple times

            var TO = false;

            window.onresize = function () {

                if (TO !== false)

                    clearTimeout(TO);

                TO = setTimeout(resizeChart, 200);

            }



        })(window);
    </script>

</asp:Content>
