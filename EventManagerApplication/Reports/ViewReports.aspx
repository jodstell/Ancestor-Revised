<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewReports.aspx.vb" Inherits="EventManagerApplication.ViewReports" %>

<%@ Register Src="~/Reports/UserControls/SideMenuControl.ascx" TagPrefix="uc1" TagName="SideMenuControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard</h2>
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col-md-2">
                <div class="widget stacked">
                    <uc1:SideMenuControl runat="server" id="SideMenuControl" />
                </div>

            </div>

            <div class="col-md-6">
                <h3>Pernod Wine and Sparkling Performance Metrics</h3>
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
                                    <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px">
                                        <ClientEvents OnLoad="chartLoad" />

                                        <PlotArea>

                                            <CommonTooltipsAppearance Color="White" Shared="false" />

                                            <Series>

                                                <telerik:AreaSeries>

                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>

                                                    <SeriesItems>

                                                        <telerik:CategorySeriesItem Y="323.4" />

                                                        <telerik:CategorySeriesItem Y="233.8" />

                                                        <telerik:CategorySeriesItem Y="244" />

                                                        <telerik:CategorySeriesItem Y="222.1" />

                                                        <telerik:CategorySeriesItem Y="358" />

                                                        <telerik:CategorySeriesItem Y="208" />

                                                        <telerik:CategorySeriesItem Y="240.8" />

                                                        <telerik:CategorySeriesItem Y="312.4" />

                                                        <telerik:CategorySeriesItem Y="279.8" />

                                                        <telerik:CategorySeriesItem Y="345.2" />

                                                        <telerik:CategorySeriesItem Y="339.2" />

                                                        <telerik:CategorySeriesItem Y="358.9" />

                                                        <telerik:CategorySeriesItem Y="365.4" />

                                                        <telerik:CategorySeriesItem Y="302.2" />

                                                        <telerik:CategorySeriesItem Y="305.9" />

                                                        <telerik:CategorySeriesItem Y="306.8" />

                                                        <telerik:CategorySeriesItem Y="380.1" />

                                                        <telerik:CategorySeriesItem Y="277.1" />

                                                        <telerik:CategorySeriesItem Y="341.5" />

                                                        <telerik:CategorySeriesItem Y="258.3" />

                                                        <telerik:CategorySeriesItem Y="368.5" />

                                                        <telerik:CategorySeriesItem Y="250.5" />

                                                        <telerik:CategorySeriesItem Y="385.3" />

                                                        <telerik:CategorySeriesItem Y="338.3" />

                                                        <telerik:CategorySeriesItem Y="383.1" />

                                                        <telerik:CategorySeriesItem Y="264.1" />

                                                        <telerik:CategorySeriesItem Y="236.2" />

                                                        <telerik:CategorySeriesItem Y="268.1" />

                                                        <telerik:CategorySeriesItem Y="417" />

                                                        <telerik:CategorySeriesItem Y="400.6" />

                                                        <telerik:CategorySeriesItem Y="497.8" />

                                                        <telerik:CategorySeriesItem Y="295.6" />

                                                        <telerik:CategorySeriesItem Y="430.4" />

                                                        <telerik:CategorySeriesItem Y="214" />

                                                        <telerik:CategorySeriesItem Y="395.6" />

                                                        <telerik:CategorySeriesItem Y="321.5" />

                                                        <telerik:CategorySeriesItem Y="372.9" />

                                                        <telerik:CategorySeriesItem Y="387.7" />

                                                        <telerik:CategorySeriesItem Y="446.4" />

                                                        <telerik:CategorySeriesItem Y="394.2" />

                                                        <telerik:CategorySeriesItem Y="239.8" />

                                                        <telerik:CategorySeriesItem Y="368.4" />

                                                        <telerik:CategorySeriesItem Y="473.1" />

                                                    </SeriesItems>

                                                </telerik:AreaSeries>

                                            </Series>

                                        </PlotArea>

                                    </telerik:RadHtmlChart>
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
                                    <telerik:RadHtmlChart ID="RadHtmlChart2" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px">
                                        <ClientEvents OnLoad="chartLoad" />
                                        <PlotArea>

                                            <CommonTooltipsAppearance Color="White" Shared="false" />

                                            <Series>

                                                <telerik:AreaSeries>

                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>

                                                    <SeriesItems>

                                                        <telerik:CategorySeriesItem Y="323.4" />

                                                        <telerik:CategorySeriesItem Y="233.8" />

                                                        <telerik:CategorySeriesItem Y="244" />

                                                        <telerik:CategorySeriesItem Y="222.1" />

                                                        <telerik:CategorySeriesItem Y="358" />

                                                        <telerik:CategorySeriesItem Y="208" />

                                                        <telerik:CategorySeriesItem Y="240.8" />

                                                        <telerik:CategorySeriesItem Y="312.4" />

                                                        <telerik:CategorySeriesItem Y="279.8" />

                                                        <telerik:CategorySeriesItem Y="345.2" />

                                                        <telerik:CategorySeriesItem Y="339.2" />

                                                        <telerik:CategorySeriesItem Y="358.9" />

                                                        <telerik:CategorySeriesItem Y="365.4" />

                                                        <telerik:CategorySeriesItem Y="302.2" />

                                                        <telerik:CategorySeriesItem Y="305.9" />

                                                        <telerik:CategorySeriesItem Y="306.8" />

                                                        <telerik:CategorySeriesItem Y="380.1" />

                                                        <telerik:CategorySeriesItem Y="277.1" />

                                                        <telerik:CategorySeriesItem Y="341.5" />

                                                        <telerik:CategorySeriesItem Y="258.3" />

                                                        <telerik:CategorySeriesItem Y="368.5" />

                                                        <telerik:CategorySeriesItem Y="250.5" />

                                                        <telerik:CategorySeriesItem Y="385.3" />

                                                        <telerik:CategorySeriesItem Y="338.3" />

                                                        <telerik:CategorySeriesItem Y="383.1" />

                                                        <telerik:CategorySeriesItem Y="264.1" />

                                                        <telerik:CategorySeriesItem Y="236.2" />

                                                        <telerik:CategorySeriesItem Y="268.1" />

                                                        <telerik:CategorySeriesItem Y="417" />

                                                        <telerik:CategorySeriesItem Y="400.6" />

                                                        <telerik:CategorySeriesItem Y="497.8" />

                                                        <telerik:CategorySeriesItem Y="295.6" />

                                                        <telerik:CategorySeriesItem Y="430.4" />

                                                        <telerik:CategorySeriesItem Y="214" />

                                                        <telerik:CategorySeriesItem Y="395.6" />

                                                        <telerik:CategorySeriesItem Y="321.5" />

                                                        <telerik:CategorySeriesItem Y="372.9" />

                                                        <telerik:CategorySeriesItem Y="387.7" />

                                                        <telerik:CategorySeriesItem Y="446.4" />

                                                        <telerik:CategorySeriesItem Y="394.2" />

                                                        <telerik:CategorySeriesItem Y="239.8" />

                                                        <telerik:CategorySeriesItem Y="368.4" />

                                                        <telerik:CategorySeriesItem Y="473.1" />

                                                    </SeriesItems>

                                                </telerik:AreaSeries>

                                            </Series>

                                        </PlotArea>

                                    </telerik:RadHtmlChart>
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
                                    <telerik:RadHtmlChart ID="RadHtmlChart3" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px">
                                        <ClientEvents OnLoad="chartLoad" />
                                        <PlotArea>

                                            <CommonTooltipsAppearance Color="White" Shared="false" />

                                            <Series>

                                                <telerik:AreaSeries>

                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>

                                                    <SeriesItems>

                                                        <telerik:CategorySeriesItem Y="323.4" />

                                                        <telerik:CategorySeriesItem Y="233.8" />

                                                        <telerik:CategorySeriesItem Y="244" />

                                                        <telerik:CategorySeriesItem Y="222.1" />

                                                        <telerik:CategorySeriesItem Y="358" />

                                                        <telerik:CategorySeriesItem Y="208" />

                                                        <telerik:CategorySeriesItem Y="240.8" />

                                                        <telerik:CategorySeriesItem Y="312.4" />

                                                        <telerik:CategorySeriesItem Y="279.8" />

                                                        <telerik:CategorySeriesItem Y="345.2" />

                                                        <telerik:CategorySeriesItem Y="339.2" />

                                                        <telerik:CategorySeriesItem Y="358.9" />

                                                        <telerik:CategorySeriesItem Y="365.4" />

                                                        <telerik:CategorySeriesItem Y="302.2" />

                                                        <telerik:CategorySeriesItem Y="305.9" />

                                                        <telerik:CategorySeriesItem Y="306.8" />

                                                        <telerik:CategorySeriesItem Y="380.1" />

                                                        <telerik:CategorySeriesItem Y="277.1" />

                                                        <telerik:CategorySeriesItem Y="341.5" />

                                                        <telerik:CategorySeriesItem Y="258.3" />

                                                        <telerik:CategorySeriesItem Y="368.5" />

                                                        <telerik:CategorySeriesItem Y="250.5" />

                                                        <telerik:CategorySeriesItem Y="385.3" />

                                                        <telerik:CategorySeriesItem Y="338.3" />

                                                        <telerik:CategorySeriesItem Y="383.1" />

                                                        <telerik:CategorySeriesItem Y="264.1" />

                                                        <telerik:CategorySeriesItem Y="236.2" />

                                                        <telerik:CategorySeriesItem Y="268.1" />

                                                        <telerik:CategorySeriesItem Y="417" />

                                                        <telerik:CategorySeriesItem Y="400.6" />

                                                        <telerik:CategorySeriesItem Y="497.8" />

                                                        <telerik:CategorySeriesItem Y="295.6" />

                                                        <telerik:CategorySeriesItem Y="430.4" />

                                                        <telerik:CategorySeriesItem Y="214" />

                                                        <telerik:CategorySeriesItem Y="395.6" />

                                                        <telerik:CategorySeriesItem Y="321.5" />

                                                        <telerik:CategorySeriesItem Y="372.9" />

                                                        <telerik:CategorySeriesItem Y="387.7" />

                                                        <telerik:CategorySeriesItem Y="446.4" />

                                                        <telerik:CategorySeriesItem Y="394.2" />

                                                        <telerik:CategorySeriesItem Y="239.8" />

                                                        <telerik:CategorySeriesItem Y="368.4" />

                                                        <telerik:CategorySeriesItem Y="473.1" />

                                                    </SeriesItems>

                                                </telerik:AreaSeries>

                                            </Series>

                                        </PlotArea>

                                    </telerik:RadHtmlChart>
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
                                    <telerik:RadHtmlChart ID="RadHtmlChart4" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px">
                                        <ClientEvents OnLoad="chartLoad" />
                                        <PlotArea>

                                            <CommonTooltipsAppearance Color="White" Shared="false" />

                                            <Series>

                                                <telerik:AreaSeries>

                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>

                                                    <SeriesItems>

                                                        <telerik:CategorySeriesItem Y="323.4" />

                                                        <telerik:CategorySeriesItem Y="233.8" />

                                                        <telerik:CategorySeriesItem Y="244" />

                                                        <telerik:CategorySeriesItem Y="222.1" />

                                                        <telerik:CategorySeriesItem Y="358" />

                                                        <telerik:CategorySeriesItem Y="208" />

                                                        <telerik:CategorySeriesItem Y="240.8" />

                                                        <telerik:CategorySeriesItem Y="312.4" />

                                                        <telerik:CategorySeriesItem Y="279.8" />

                                                        <telerik:CategorySeriesItem Y="345.2" />

                                                        <telerik:CategorySeriesItem Y="339.2" />

                                                        <telerik:CategorySeriesItem Y="358.9" />

                                                        <telerik:CategorySeriesItem Y="365.4" />

                                                        <telerik:CategorySeriesItem Y="302.2" />

                                                        <telerik:CategorySeriesItem Y="305.9" />

                                                        <telerik:CategorySeriesItem Y="306.8" />

                                                        <telerik:CategorySeriesItem Y="380.1" />

                                                        <telerik:CategorySeriesItem Y="277.1" />

                                                        <telerik:CategorySeriesItem Y="341.5" />

                                                        <telerik:CategorySeriesItem Y="258.3" />

                                                        <telerik:CategorySeriesItem Y="368.5" />

                                                        <telerik:CategorySeriesItem Y="250.5" />

                                                        <telerik:CategorySeriesItem Y="385.3" />

                                                        <telerik:CategorySeriesItem Y="338.3" />

                                                        <telerik:CategorySeriesItem Y="383.1" />

                                                        <telerik:CategorySeriesItem Y="264.1" />

                                                        <telerik:CategorySeriesItem Y="236.2" />

                                                        <telerik:CategorySeriesItem Y="268.1" />

                                                        <telerik:CategorySeriesItem Y="417" />

                                                        <telerik:CategorySeriesItem Y="400.6" />

                                                        <telerik:CategorySeriesItem Y="497.8" />

                                                        <telerik:CategorySeriesItem Y="295.6" />

                                                        <telerik:CategorySeriesItem Y="430.4" />

                                                        <telerik:CategorySeriesItem Y="214" />

                                                        <telerik:CategorySeriesItem Y="395.6" />

                                                        <telerik:CategorySeriesItem Y="321.5" />

                                                        <telerik:CategorySeriesItem Y="372.9" />

                                                        <telerik:CategorySeriesItem Y="387.7" />

                                                        <telerik:CategorySeriesItem Y="446.4" />

                                                        <telerik:CategorySeriesItem Y="394.2" />

                                                        <telerik:CategorySeriesItem Y="239.8" />

                                                        <telerik:CategorySeriesItem Y="368.4" />

                                                        <telerik:CategorySeriesItem Y="473.1" />

                                                    </SeriesItems>

                                                </telerik:AreaSeries>

                                            </Series>

                                        </PlotArea>

                                    </telerik:RadHtmlChart>
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
                                    <telerik:RadHtmlChart ID="RainfallChart" runat="server" Layout="Sparkline" Skin="Bootstrap" Width="100%" Height="60px">
                                        <ClientEvents OnLoad="chartLoad" />
                                        <PlotArea>

                                            <CommonTooltipsAppearance Color="White" Shared="false" />

                                            <Series>

                                                <telerik:AreaSeries>

                                                    <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>

                                                    <SeriesItems>

                                                        <telerik:CategorySeriesItem Y="323.4" />

                                                        <telerik:CategorySeriesItem Y="233.8" />

                                                        <telerik:CategorySeriesItem Y="244" />

                                                        <telerik:CategorySeriesItem Y="222.1" />

                                                        <telerik:CategorySeriesItem Y="358" />

                                                        <telerik:CategorySeriesItem Y="208" />

                                                        <telerik:CategorySeriesItem Y="240.8" />

                                                        <telerik:CategorySeriesItem Y="312.4" />

                                                        <telerik:CategorySeriesItem Y="279.8" />

                                                        <telerik:CategorySeriesItem Y="345.2" />

                                                        <telerik:CategorySeriesItem Y="339.2" />

                                                        <telerik:CategorySeriesItem Y="358.9" />

                                                        <telerik:CategorySeriesItem Y="365.4" />

                                                        <telerik:CategorySeriesItem Y="302.2" />

                                                        <telerik:CategorySeriesItem Y="305.9" />

                                                        <telerik:CategorySeriesItem Y="306.8" />

                                                        <telerik:CategorySeriesItem Y="380.1" />

                                                        <telerik:CategorySeriesItem Y="277.1" />

                                                        <telerik:CategorySeriesItem Y="341.5" />

                                                        <telerik:CategorySeriesItem Y="258.3" />

                                                        <telerik:CategorySeriesItem Y="368.5" />

                                                        <telerik:CategorySeriesItem Y="250.5" />

                                                        <telerik:CategorySeriesItem Y="385.3" />

                                                        <telerik:CategorySeriesItem Y="338.3" />

                                                        <telerik:CategorySeriesItem Y="383.1" />

                                                        <telerik:CategorySeriesItem Y="264.1" />

                                                        <telerik:CategorySeriesItem Y="236.2" />

                                                        <telerik:CategorySeriesItem Y="268.1" />

                                                        <telerik:CategorySeriesItem Y="417" />

                                                        <telerik:CategorySeriesItem Y="400.6" />

                                                        <telerik:CategorySeriesItem Y="497.8" />

                                                        <telerik:CategorySeriesItem Y="295.6" />

                                                        <telerik:CategorySeriesItem Y="430.4" />

                                                        <telerik:CategorySeriesItem Y="214" />

                                                        <telerik:CategorySeriesItem Y="395.6" />

                                                        <telerik:CategorySeriesItem Y="321.5" />

                                                        <telerik:CategorySeriesItem Y="372.9" />

                                                        <telerik:CategorySeriesItem Y="387.7" />

                                                        <telerik:CategorySeriesItem Y="446.4" />

                                                        <telerik:CategorySeriesItem Y="394.2" />

                                                        <telerik:CategorySeriesItem Y="239.8" />

                                                        <telerik:CategorySeriesItem Y="368.4" />

                                                        <telerik:CategorySeriesItem Y="473.1" />

                                                    </SeriesItems>

                                                </telerik:AreaSeries>

                                            </Series>

                                        </PlotArea>

                                    </telerik:RadHtmlChart>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <h3 class="pull-right">3/01/2016 - 3/31/2016</h3>
                <div class="widget stacked">
                    <div class="widget-content">


                        <telerik:RadHtmlChart ID="RadHtmlChart5" runat="server" DataSourceID="SqlDataSource1">
                            <ChartTitle Text="Brands Promoted">
                                <Appearance Align="Center" Position="Top" Visible="True">
                                </Appearance>
                            </ChartTitle>
                            <Legend>
                                <Appearance Position="Bottom" Orientation="Vertical" Visible="True"></Appearance>
                            </Legend>

                            <PlotArea>
                                <Series>
                                    <telerik:PieSeries StartAngle="90" Name="PieSeries1" DataFieldY="Event" NameField="brandName" ExplodeField>
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






                        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [RecapSummaryForChart]"></asp:SqlDataSource>

                        <telerik:RadHtmlChart runat="server" ID="PieChart1" Transitions="true" Skin="Bootstrap" Visible="false">
                            <ClientEvents OnLoad="chartLoad" />
                            <ChartTitle Text="Brands Promoted">

                                <Appearance Align="Center" Position="Top">
                                </Appearance>

                            </ChartTitle>

                            <Legend>

                                <Appearance Position="Right" Visible="true">
                                </Appearance>

                            </Legend>

                            <PlotArea>

                                <Series>

                                    <telerik:PieSeries StartAngle="90">

                                        <LabelsAppearance Position="OutsideEnd" DataFormatString="{0} %">
                                        </LabelsAppearance>

                                        <TooltipsAppearance Color="White" DataFormatString="{0} %"></TooltipsAppearance>

                                        <SeriesItems>

                                            <telerik:PieSeriesItem BackgroundColor="#fe9a00" Exploded="true" Name="Brancott Estates"
                                                Y="18.3"></telerik:PieSeriesItem>

                                            <telerik:PieSeriesItem BackgroundColor="#005991" Exploded="false" Name="Two Lands"
                                                Y="35.8"></telerik:PieSeriesItem>

                                            <telerik:PieSeriesItem BackgroundColor="#790091" Exploded="false" Name="Campo Viejo" Y="38.3"></telerik:PieSeriesItem>

                                            <telerik:PieSeriesItem BackgroundColor="#669934" Exploded="false" Name="Kenwood" Y="4.5"></telerik:PieSeriesItem>

                                            <telerik:PieSeriesItem BackgroundColor="#c9302b" Exploded="false" Name="Perrier-Jouet" Y="2.3"></telerik:PieSeriesItem>

                                        </SeriesItems>

                                    </telerik:PieSeries>

                                </Series>

                            </PlotArea>

                        </telerik:RadHtmlChart>
                    </div>
                </div>

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
