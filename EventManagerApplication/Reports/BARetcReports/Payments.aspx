<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Payments.aspx.vb" Inherits="EventManagerApplication.Payments1" %>
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
            

            <div class="col-md-12">

                 <h2>Payments</h2>
                <div class="pull-right">
                <a href="/Reports/BARetcReports/PayrollDashboard" class="btn btn-success"><i class="fa fa-chevron-left" aria-hidden="true"></i> Return to Payroll Dashboard</a>
                </div>

                <br />




                         <telerik:RadTabStrip ID="PaymentTabStrip" runat="server" MultiPageID="RadMultiPage2" SelectedIndex="0" Skin="Bootstrap">
                                        <Tabs>
                                            <telerik:RadTab Text="Scheduled"></telerik:RadTab>
                                            <telerik:RadTab Text="Hours Billed"></telerik:RadTab>
                                            <telerik:RadTab Text="Pending"></telerik:RadTab>
                                            <telerik:RadTab Text="Approved"></telerik:RadTab>
                                            <telerik:RadTab Text="Paid"></telerik:RadTab>
                                            <telerik:RadTab Text="Rejected"></telerik:RadTab>
                                        </Tabs>
                                    </telerik:RadTabStrip>

                                    <telerik:RadMultiPage runat="server" ID="RadMultiPage2" SelectedIndex="0">
                                        <telerik:RadPageView runat="server" ID="RadPageView6">

                                            <telerik:RadGrid ID="ScehduledPaymentsGrid" runat="server" DataSourceID="getPayments" Skin="Bootstrap" RenderMode="Lightweight" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" FilterType="HeaderContext" EnableHeaderContextMenu="true">

                                                <MasterTableView DataSourceID="getPayments" AutoGenerateColumns="False" CommandItemDisplay="Top"
                                                    Font-Size="10">

                                                    <NoRecordsTemplate>
                                                        <br />
                                                        <div class="col-md-12">
                                                            <div class="alert alert-warning" role="alert"><strong>No Payments Found.</strong>  Please adjust your filter options.</div>
                                                        </div>
                                                    </NoRecordsTemplate>

                                                    <Columns>

                                                        <telerik:GridBoundColumn DataField="FullName" HeaderText="Ambassador Name" SortExpression="FullName" UniqueName="FullName" FilterControlAltText="Filter FullName column"></telerik:GridBoundColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Event Date">
                                                            <ItemTemplate>
                                                                <%# Eval("eventDate", "{0:d}") %><br />
                                                                <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="supplierName" HeaderText="Supplier Name" SortExpression="supplierName" UniqueName="supplierName" FilterControlAltText="Filter supplierName column"></telerik:GridBoundColumn>


                                                        <telerik:GridTemplateColumn HeaderText="Event Location">
                                                            <ItemTemplate>
                                                                <%# Eval("accountName") %><br />
                                                                <%# Eval("streetAddress1") %><br />
                                                                <%# Eval("city") %>, <%# Eval("state") %>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="positionTitle" HeaderText="Position" SortExpression="positionTitle" UniqueName="positionTitle" FilterControlAltText="Filter positionTitle column"></telerik:GridBoundColumn>

                                                        <%--                                                         <telerik:GridBoundColumn DataField="eventID" HeaderText="eventID" SortExpression="eventID" UniqueName="eventID" DataType="System.Int32" FilterControlAltText="Filter eventID column"></telerik:GridBoundColumn>--%>



                                                        <%--<telerik:GridBoundColumn DataField="paymentStatus" HeaderText="paymentStatus" SortExpression="paymentStatus" UniqueName="paymentStatus" FilterControlAltText="Filter paymentStatus column"></telerik:GridBoundColumn>--%>
                                                        <%--<telerik:GridBoundColumn DataField="paymentID" HeaderText="paymentID" SortExpression="paymentID" UniqueName="paymentID" DataType="System.Int32" FilterControlAltText="Filter paymentID column"></telerik:GridBoundColumn>--%>
                                                    </Columns>
                                                    <CommandItemTemplate>
                                                        <div style="padding: 3px 0 3px 5px">


                                                            <div class="pull-right" style="padding-right: 3px">
                                                                <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </CommandItemTemplate>


                                                    <NestedViewTemplate>
                                                        <div style="min-height: 400px; border: 1px solid #f1f1f1">

                                                            <%--            
     

                                                         <telerik:GridBoundColumn DataField="statusID" HeaderText="statusID" SortExpression="statusID" UniqueName="statusID" DataType="System.Int32" FilterControlAltText="Filter statusID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="rate" HeaderText="rate" SortExpression="rate" UniqueName="rate" DataType="System.Decimal" FilterControlAltText="Filter rate column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="hours" HeaderText="hours" SortExpression="hours" UniqueName="hours" DataType="System.Int32" FilterControlAltText="Filter hours column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="labor" HeaderText="labor" SortExpression="labor" UniqueName="labor" DataType="System.Decimal" FilterControlAltText="Filter labor column"></telerik:GridBoundColumn>
                                                      <telerik:GridBoundColumn DataField="RequirementID" HeaderText="RequirementID" SortExpression="RequirementID" UniqueName="RequirementID" DataType="System.Int32" FilterControlAltText="Filter RequirementID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="locationID" HeaderText="locationID" SortExpression="locationID" UniqueName="locationID" DataType="System.Int32" FilterControlAltText="Filter locationID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="accountID" HeaderText="accountID" SortExpression="accountID" UniqueName="accountID" DataType="System.Int32" FilterControlAltText="Filter accountID column"></telerik:GridBoundColumn>

                                                         

                                                         <telerik:GridBoundColumn DataField="userID" HeaderText="userID" SortExpression="userID" UniqueName="userID" FilterControlAltText="Filter userID column"></telerik:GridBoundColumn>
    <telerik:GridBoundColumn DataField="expenses" HeaderText="expenses" SortExpression="expenses" UniqueName="expenses" DataType="System.Decimal" FilterControlAltText="Filter expenses column"></telerik:GridBoundColumn>
                                                         <telerik:GridBoundColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataType="System.Decimal" FilterControlAltText="Filter Total column"></telerik:GridBoundColumn>
                                                         <telerik:GridBoundColumn DataField="paymentDate" HeaderText="paymentDate" SortExpression="paymentDate" UniqueName="paymentDate" DataType="System.DateTime" FilterControlAltText="Filter paymentDate column"></telerik:GridBoundColumn>--%>
                                                        </div>
                                                    </NestedViewTemplate>
                                                </MasterTableView>

                                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">

                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />

                                                </ClientSettings>

                                            </telerik:RadGrid>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getPayments" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryViewScheduledPayments" OrderBy="paymentDate"></asp:LinqDataSource>

                                        </telerik:RadPageView>

                                        <telerik:RadPageView runat="server" ID="RadPageView7">
                                            Hours Billed
                                        </telerik:RadPageView>

                                        <telerik:RadPageView runat="server" ID="RadPageView8">

                                            <telerik:RadGrid ID="PendingPaymentsRadGrid" runat="server" DataSourceID="LinqDataSource1" Skin="Bootstrap" RenderMode="Lightweight" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" FilterType="HeaderContext" EnableHeaderContextMenu="true" AllowMultiRowSelection="true" CellSpacing="-1" >

                                                <ClientSettings EnableRowHoverStyle="True" EnablePostBackOnRowClick="True" AllowDragToGroup="True">
                                                </ClientSettings>

                                                <MasterTableView DataSourceID="LinqDataSource1" AutoGenerateColumns="False" CommandItemDisplay="Top"
                                                    Font-Size="10">

                                                    <%--<GroupByExpressions>
                                                        <telerik:GridGroupByExpression>
                                                            <GroupByFields>
                                                                <telerik:GridGroupByField FieldAlias="FullName" FieldName="FullName" />
                                                            </GroupByFields>
                                                        </telerik:GridGroupByExpression>
                                                    </GroupByExpressions>--%>

                                                    <NoRecordsTemplate>
                                                        <br />
                                                        <div class="col-md-12">
                                                            <div class="alert alert-warning" role="alert"><strong>No Payments Found.</strong>  Please adjust your filter options.</div>
                                                        </div>
                                                    </NoRecordsTemplate>

                                                    <Columns>

                                                        <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1">
                                                        </telerik:GridClientSelectColumn>

                                                        <telerik:GridTemplateColumn AllowFiltering="false" ItemStyle-Wrap="false">
                                                            <ItemTemplate>
                                                                <div class="btn-group" role="group" aria-label="...">
                                                                  <asp:LinkButton ID="btnApproveExpense" runat="server" CssClass="btn btn-xs btn-success"><i class="fa fa-check-square" aria-hidden="true"></i> Approve</asp:LinkButton>
                                                                 
                                                                  <button type="button" class="btn btn-xs btn-danger"><i class="fa fa-times-circle" aria-hidden="true"></i> Deny</button>
                                                                </div>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="FullName" HeaderText="Ambassador Name" SortExpression="FullName" UniqueName="FullName" FilterControlAltText="Filter FullName column"></telerik:GridBoundColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Event Date">
                                                            <ItemTemplate>
                                                                <%# Eval("eventDate", "{0:d}") %><br />
                                                                <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="supplierName" HeaderText="Supplier Name" SortExpression="supplierName" UniqueName="supplierName" FilterControlAltText="Filter supplierName column"></telerik:GridBoundColumn>



                                                        <telerik:GridTemplateColumn HeaderText="Event Location">
                                                            <ItemTemplate>
                                                                <%# Eval("accountName") %><br />
                                                               <%-- <%# Eval("streetAddress1") %><br />
                                                                <%# Eval("city") %>, <%# Eval("state") %>--%>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>



                                                        <telerik:GridBoundColumn DataField="hours" HeaderText="hours" SortExpression="hours" UniqueName="hours" FilterControlAltText="Filter hours column"></telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="rate" HeaderText="rate" SortExpression="rate" UniqueName="rate" FilterControlAltText="Filter rate column" DataFormatString="{0:c}"></telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="labor" HeaderText="labor" SortExpression="labor" UniqueName="labor" DataType="System.Decimal" FilterControlAltText="Filter labor column" DataFormatString="{0:c}"></telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="expenses" HeaderText="expenses" SortExpression="expenses" UniqueName="expenses" FilterControlAltText="Filter expenses column" DataFormatString="{0:c}"></telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" FilterControlAltText="Filter Total column" DataFormatString="{0:c}"></telerik:GridBoundColumn>

                                                        <%--                                                         <telerik:GridBoundColumn DataField="eventID" HeaderText="eventID" SortExpression="eventID" UniqueName="eventID" DataType="System.Int32" FilterControlAltText="Filter eventID column"></telerik:GridBoundColumn>--%>
                                                    </Columns>
                                                    <CommandItemTemplate>
                                                        <div style="padding: 3px 0 3px 5px">

                                                            <div class="btn-group" role="group" aria-label="...">

                                                                  <button type="button" class="btn btn-sm btn-success"> <i class="fa fa-check-square" aria-hidden="true"></i> Approve Selected</button>
                                                                  <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-times-circle" aria-hidden="true"></i> Deny Selected</button>
                                                                </div>

                                                            <div class="pull-right" style="padding-right: 3px">
                                                                <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </CommandItemTemplate>


                                                    <NestedViewTemplate>
                                                        <div style="min-height: 400px; border: 1px solid #f1f1f1">

                                                            <%--            
     

                                                         <telerik:GridBoundColumn DataField="statusID" HeaderText="statusID" SortExpression="statusID" UniqueName="statusID" DataType="System.Int32" FilterControlAltText="Filter statusID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="rate" HeaderText="rate" SortExpression="rate" UniqueName="rate" DataType="System.Decimal" FilterControlAltText="Filter rate column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="hours" HeaderText="hours" SortExpression="hours" UniqueName="hours" DataType="System.Int32" FilterControlAltText="Filter hours column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="labor" HeaderText="labor" SortExpression="labor" UniqueName="labor" DataType="System.Decimal" FilterControlAltText="Filter labor column"></telerik:GridBoundColumn>
                                                      <telerik:GridBoundColumn DataField="RequirementID" HeaderText="RequirementID" SortExpression="RequirementID" UniqueName="RequirementID" DataType="System.Int32" FilterControlAltText="Filter RequirementID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="locationID" HeaderText="locationID" SortExpression="locationID" UniqueName="locationID" DataType="System.Int32" FilterControlAltText="Filter locationID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="accountID" HeaderText="accountID" SortExpression="accountID" UniqueName="accountID" DataType="System.Int32" FilterControlAltText="Filter accountID column"></telerik:GridBoundColumn>

                                                         

                                                         <telerik:GridBoundColumn DataField="userID" HeaderText="userID" SortExpression="userID" UniqueName="userID" FilterControlAltText="Filter userID column"></telerik:GridBoundColumn>
    <telerik:GridBoundColumn DataField="expenses" HeaderText="expenses" SortExpression="expenses" UniqueName="expenses" DataType="System.Decimal" FilterControlAltText="Filter expenses column"></telerik:GridBoundColumn>
                                                         <telerik:GridBoundColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataType="System.Decimal" FilterControlAltText="Filter Total column"></telerik:GridBoundColumn>
                                                         <telerik:GridBoundColumn DataField="paymentDate" HeaderText="paymentDate" SortExpression="paymentDate" UniqueName="paymentDate" DataType="System.DateTime" FilterControlAltText="Filter paymentDate column"></telerik:GridBoundColumn>--%>
                                                        </div>
                                                    </NestedViewTemplate>
                                                </MasterTableView>

                                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">

                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />

                                                </ClientSettings>

                                            </telerik:RadGrid>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryViewPendingPayments" OrderBy="eventDate desc"></asp:LinqDataSource>
                                        </telerik:RadPageView>

                                        <telerik:RadPageView runat="server" ID="RadPageView9">
                                            Approved
                                        </telerik:RadPageView>

                                        <telerik:RadPageView runat="server" ID="RadPageView10">
                                            Paid
                                        </telerik:RadPageView>

                                        <telerik:RadPageView runat="server" ID="RadPageView11">
                                            Rejected
                                        </telerik:RadPageView>


                                    </telerik:RadMultiPage>




                </div>

            </div>

        </div>


</asp:Content>
