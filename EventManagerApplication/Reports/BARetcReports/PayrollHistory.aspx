<%@ Page Title="Payroll History" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="PayrollHistory.aspx.vb" Inherits="EventManagerApplication.PayrollHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container min-height">

    <div class="row">
        <div class="col-xs-12">
            <h2>Reporting Dashboard - Reports</h2>
            <hr />
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12">
            <h3>Payroll History</h3>

            <div class="btn-group pull-right" role="group" aria-label="..." style="padding-bottom: 15px;">
                <a href="/Reports/BARetcReports/PayrollDashboard" class="btn btn-default"><i class="fa fa-chevron-left" aria-hidden="true"></i> Return to Payroll Dashboard</a>
            </div>

            <div class="widget stacked">
                <div class="widget-content">

                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="getRecentPayments" PageSize="20" AllowPaging="true">

                        <MasterTableView DataKeyNames="paymentID" DataSourceID="getRecentPayments" AutoGenerateColumns="False">
                            <Columns>

                                <telerik:GridTemplateColumn HeaderText="Payroll Name">
                                    <ItemTemplate><a href='/documents/payrollexport/<%# Eval("payrollName") %><%# Eval("paymentID") %>.csv'><%# Eval("payrollName") %>.csv</a></ItemTemplate>
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

                        <PagerStyle Position="TopAndBottom" />
                    </telerik:RadGrid>


                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getRecentPayments" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                        OrderBy="dateSubmitted" TableName="tblPayments"></asp:LinqDataSource>


                </div>
            </div>
        </div>
    </div>

</div>

</asp:Content>
