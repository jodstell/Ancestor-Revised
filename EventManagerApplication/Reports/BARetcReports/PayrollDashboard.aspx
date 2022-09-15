<%@ Page Title="Payroll Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="PayrollDashboard.aspx.vb" Inherits="EventManagerApplication.PayrollDashboard" %>

<%@ Register Src="~/Reports/UserControls/SideMenuControl.ascx" TagPrefix="uc1" TagName="SideMenuControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../../Theme/css/custom.css" rel="stylesheet" />
    <link href="../../Theme/css/custom1.css" rel="stylesheet" />

    <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard - Reports</h2>
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col-md-2">
                <div class="widget stacked">
                    <uc1:SideMenuControl runat="server" ID="SideMenuControl" />
                </div>

            </div>

            <div class="col-md-10">



                <div class="col-sm-12">

                    <h2>Payroll Reports</h2>


                    <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label>

                    <div class="widget stacked">

                        <div class="widget-header">
                            <i class="icon-bookmark fa fa-th-large" aria-hidden="true"></i>

                            <h3>Estimated Upcoming Payroll</h3>
                        </div>
                        <!-- /widget-header -->

                        <div class="widget-content">

                            <div class="">

                                <span style="font-size: 20px">
                                    <asp:Label ID="selectedDateLabel" runat="server"></asp:Label></span>
                                <div class="row" style="margin-top: 15px"></div>



                                <div class="col-sm-12">

                                    <div class="feature col-sx-4 col-sm-2 center">

                                        <div class="well blackbox smbox">
                                            <div class="marginbotton10"></div>
                                            <h2 class="text-center">
                                                <asp:Label ID="TotalCountLabel" runat="server" /></h2>
                                            <h5 class="text-center">Total<br />
                                                Events</h5>
                                        </div>

                                    </div>
                                    <div class="feature col-sx-4 col-sm-2 center">

                                        <div class="well bluebox smbox">
                                            <div class="marginbotton10"></div>
                                            <h2 class="text-center">
                                                <asp:Label ID="AmbassadorCountLabel" runat="server" /></h2>
                                            <h5 class="text-center">Number of<br />
                                                Ambassadors</h5>
                                        </div>

                                    </div>


                                    <div class="feature col-sx-4 col-sm-2 center">


                                        <div class="well orangebox smbox">
                                            <div class="marginbotton10"></div>
                                            <h2 class="text-center">
                                                <asp:Label ID="TotalHoursLabel" runat="server" /></h2>
                                            <h5 class="text-center">Total<br />
                                                Hours</h5>
                                        </div>

                                    </div>

                                    <div class="feature col-sm-5 col-sm-3 center">

                                        <div class="well greenbox smbox">
                                            <div class="marginbotton10"></div>
                                            <h2 class="text-center">
                                                <asp:Label ID="TotalPayrollLabel" runat="server" /></h2>
                                            <h5 class="text-center">Total<br />
                                                Payroll</h5>
                                        </div>

                                    </div>

                                    <div class="feature col-sm-4 col-sm-3 center">

                                        <div class="well darkbluebox smbox">
                                            <div class="marginbotton10"></div>
                                            <h2 class="text-center">
                                                <asp:Label ID="AgeragePayLabel" runat="server" /></h2>
                                            <h5 class="text-center">Average Event<br />
                                                Cost</h5>
                                        </div>

                                    </div>

                                  <%--  <div class="feature col-sx-1 col-sm-1 center">
                                    </div>--%>





                                </div>

                                <div class="col-sm-12" style="padding: 15px 5px 15px;">

                                    <strong>From:</strong>

                                    <telerik:RadDatePicker ID="FromDatePicker" runat="server" Culture="en-US" SelectedDate="2016-03-01">
                                        <DateInput runat="server" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%">
                                        </DateInput>
                                        <Calendar runat="server">
                                            <SpecialDays>
                                                <telerik:RadCalendarDay Repeatable="Today">
                                                    <ItemStyle CssClass="rcToday" />
                                                </telerik:RadCalendarDay>
                                            </SpecialDays>
                                        </Calendar>
                                    </telerik:RadDatePicker>

                                    <strong>To:</strong>
                                    <telerik:RadDatePicker ID="ToDatePicker" runat="server" Culture="en-US" SelectedDate="2016-03-31">
                                        <DateInput runat="server" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%">
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

                                        <%-- <a href="/Reports/BARetcReports/PayrollDashboard" class="btn btn-success"><i class="fa fa-chevron-left" aria-hidden="true"></i> Return to Payroll Dashboard</a>--%>
                                    </div>
                                </div>


                            </div>
                        </div>

                    </div>

                </div>


                <div class="col-md-6">



                    <div class="widget stacked">

                        <div class="widget-header">
                            <i class="icon-bookmark fa fa-bars" aria-hidden="true"></i>
                            <h3>Reports</h3>
                        </div>
                        <!-- /widget-header -->

                        <div class="widget-content">

                            <div class="shortcuts">
                                <%--
						<a href="/Reports/BARetcReports/Payments" class="shortcut">
							<i class="shortcut-icon fa fa-usd"></i>
							<span class="shortcut-label">Payments</span>
						</a> --%>

                                <a href="/Reports/BARetcReports/PayrollExport" class="shortcut">
                                    <i class="shortcut-icon fa fa fa-download"></i>
                                    <span class="shortcut-label">Payroll Extract</span>
                                </a>

                                <a href="/Reports/BARetcReports/PayrollApproved" class="shortcut">
                                    <i class="shortcut-icon fa fa-check-square-o"></i>
                                    <span class="shortcut-label">Approved</span>
                                </a>

                                <a href="/Reports/BARetcReports/PayrollPaid" class="shortcut">
                                    <i class="shortcut-icon fa fa-usd"></i>
                                    <span class="shortcut-label">Paid</span>
                                </a>

                                <a href='/Reports/BARetcReports/PayrollRejected' class="shortcut">
                                    <i class="shortcut-icon fa fa-ban"></i>
                                    <span class="shortcut-label">Rejected</span>
                                </a>

                                <%--						<a href="javascript:;" class="shortcut">
							<i class="shortcut-icon icon-comment"></i>
							<span class="shortcut-label">Comments</span>
						</a>

						<a href="javascript:;" class="shortcut">
							<i class="shortcut-icon icon-user"></i>
							<span class="shortcut-label">Users</span>
						</a>

						<a href="javascript:;" class="shortcut">
							<i class="shortcut-icon icon-file"></i>
							<span class="shortcut-label">Notes</span>
						</a>

						<a href="javascript:;" class="shortcut">
							<i class="shortcut-icon icon-picture"></i>
							<span class="shortcut-label">Photos</span>
						</a>

						<a href="javascript:;" class="shortcut">
							<i class="shortcut-icon icon-tag"></i>
							<span class="shortcut-label">Tags</span>
						</a>--%>
                            </div>
                            <!-- /shortcuts -->


                        </div>
                    </div>



                </div>

                <div class="col-md-6">
                    <div class="widget stacked">

                        <div class="widget-header">
                            <i class="icon-bookmark fa fa-file-excel-o" aria-hidden="true"></i>
                            <h3>Recent Payroll Files</h3>

                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getRecentPayments" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                OrderBy="dateSubmitted" TableName="tblPayments" Where="clientID == @clientID">
                                <WhereParameters>
                                    <asp:SessionParameter SessionField="CurrentClientID" Name="clientID" Type="Int32"></asp:SessionParameter>
                                </WhereParameters>
                            </asp:LinqDataSource>
                        </div>
                        <!-- /widget-header -->

                        <div class="widget-content">

                            <telerik:RadGrid ID="PastPayrollGrid" runat="server" DataSourceID="getRecentPayments" PageSize="5" AllowPaging="true" CellSpacing="-1">

                                <MasterTableView DataKeyNames="paymentID" DataSourceID="getRecentPayments" AutoGenerateColumns="False">
                                    <Columns>
                                        <%--<telerik:GridTemplateColumn>
                                            <ItemTemplate>
                                                    <asp:LinkButton ID="ExportPayroll" CommandName="ExportPayroll" CommandArgument='<%# Eval("paymentID") %>' runat="server">Download</asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>
                                        

                                       <telerik:GridTemplateColumn HeaderText="Payroll Name">
                                            <ItemTemplate><a href='/payrollexport/<%# Eval("payrollName") %><%# Eval("paymentID") %>.csv'><%# Eval("payrollName") %>.csv</a></ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="dateSubmitted" HeaderText="Date Submitted" SortExpression="dateSubmitted" UniqueName="dateSubmitted"
                                            DataType="System.DateTime" FilterControlAltText="Filter dateSubmitted column" DataFormatString="{0:d}"></telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="fromDate" HeaderText="From Date" SortExpression="fromDate" UniqueName="fromDate"
                                            DataType="System.DateTime" FilterControlAltText="Filter fromDate column" DataFormatString="{0:d}"></telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="toDate" HeaderText="To Date" SortExpression="toDate" UniqueName="toDate" DataType="System.DateTime"
                                            FilterControlAltText="Filter toDate column" DataFormatString="{0:d}"></telerik:GridBoundColumn>


                                    </Columns>

                                    <NoRecordsTemplate>
                                        <br />
                                        <div class="col-md-12">
                                            <div class="alert alert-warning" role="alert"><strong>There are no Payroll files to Show.</div>
                                        </div>
                                    </NoRecordsTemplate>
                                </MasterTableView>

                                <PagerStyle Position="Bottom" />
                            </telerik:RadGrid>



                        </div>
                    </div>

                </div>


            </div>
        </div>
    </div>


</asp:Content>
