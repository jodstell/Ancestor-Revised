<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="PayrollExport2.aspx.vb" Inherits="EventManagerApplication.PayrollExport2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="MainPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <asp:Panel ID="MainPanel" runat="server">

        <div class="container min-height">
            <div class="row">
                <div class="col-xs-12">
                    <h2>Reporting Dashboard - Reports</h2>
                    <hr />
                </div>
            </div>

            <div class="row">


                <div class="col-md-12">


                    <h3>Payroll Extract</h3>

                    <span style="font-size: 20px">
                        <asp:Label ID="selectedDateLabel" runat="server"></asp:Label></span>

                    <p style="font-size: 12px;">
                        <asp:Label ID="DateRangeLabel" runat="server" Font-Bold="true" />
                    </p>

                    <div style="padding: 15px 5px 15px;">

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

                            <a href="/Reports/BARetcReports/PayrollDashboard" class="btn btn-success"><i class="fa fa-chevron-left" aria-hidden="true"></i> Return to Payroll Dashboard</a>
                        </div>
                    </div>


                    <telerik:RadGrid ID="PendingPaymentsRadGrid" runat="server" DataSourceID="LinqDataSource1" Skin="Bootstrap" RenderMode="Lightweight" 
                        AllowPaging="True"  PageSize="50" AllowSorting="True" AllowFilteringByColumn="True" FilterType="HeaderContext" EnableHeaderContextMenu="true" AllowMultiRowSelection="true" CellSpacing="-1">

                        <ClientSettings EnableRowHoverStyle="True" EnablePostBackOnRowClick="True" AllowDragToGroup="True">
                        </ClientSettings>

                        <MasterTableView DataSourceID="LinqDataSource1" AutoGenerateColumns="False" CommandItemDisplay="Top" 
                            Font-Size="10">

                            <NoRecordsTemplate>
                                <br />
                                <div class="col-md-12">
                                    <div class="alert alert-warning" role="alert"><strong>There are no Pending Payments.</strong>  Please adjust your filter options.</div>
                                </div>
                            </NoRecordsTemplate>

                            <Columns>
                                <telerik:GridBoundColumn DataField="assignedUserName" HeaderText="assignedUserName" SortExpression="assignedUserName" UniqueName="assignedUserName" FilterControlAltText="Filter assignedUserName column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FullName" HeaderText="FullName" SortExpression="FullName" UniqueName="FullName" FilterControlAltText="Filter FullName column"></telerik:GridBoundColumn>


                                <telerik:GridBoundColumn DataField="UserID" HeaderText="UserID" SortExpression="UserID" UniqueName="UserID" FilterControlAltText="Filter UserID column"></telerik:GridBoundColumn>

                                <%--   <telerik:GridTemplateColumn HeaderText="Event Date">
                                    <ItemTemplate>
                                        <%# Eval("eventDate", "{0:d}") %><br />
                                        <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridBoundColumn DataField="supplierName" HeaderText="Supplier Name" SortExpression="supplierName" UniqueName="supplierName" FilterControlAltText="Filter supplierName column"></telerik:GridBoundColumn>--%>







                                <%--    <telerik:GridBoundColumn DataField="hours" HeaderText="Hours" SortExpression="hours" UniqueName="hours" FilterControlAltText="Filter hours column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="rate" HeaderText="Rate" SortExpression="rate" UniqueName="rate" FilterControlAltText="Filter rate column" DataFormatString="{0:c}"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="labor" HeaderText="Labor" SortExpression="labor" UniqueName="labor" DataType="System.Decimal" FilterControlAltText="Filter labor column" DataFormatString="{0:c}"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="expenses" HeaderText="Expenses" SortExpression="expenses" UniqueName="expenses" FilterControlAltText="Filter expenses column" DataFormatString="{0:c}"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" FilterControlAltText="Filter Total column" DataFormatString="{0:c}"></telerik:GridBoundColumn>--%>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 3px 0 3px 5px">

                                    <div class="btn-group" role="group" aria-label="...">

                                        <button type="button" class="btn btn-sm btn-success"><i class="fa fa-check-square" aria-hidden="true"></i>Approve Selected</button>
                                        <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-times-circle" aria-hidden="true"></i>Deny Selected</button>
                                    </div>

                                    <div class="pull-right" style="padding-right: 3px">
                                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export to Excel</asp:LinkButton>
                                    </div>
                                </div>
                            </CommandItemTemplate>


                            <NestedViewTemplate>
                            </NestedViewTemplate>
                        </MasterTableView>

                        <PagerStyle Position="TopAndBottom" />

                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">

                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />

                        </ClientSettings>

                    </telerik:RadGrid>

                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryGetAmbassador_PendingPayments" OrderBy="FullName">
                        
                    </asp:LinqDataSource>


                </div>

            </div>

        </div>

    </asp:Panel>
</asp:Content>
