<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Payments.aspx.vb" Inherits="EventManagerApplication.Payments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container min-height">
            <div class="row">
                <div class="col-xs-12">
                    <h2>Payments</h2>
                </div>
            </div>

            <div class="row ">
                <div class="col-sm-12">

                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="getPayments" GroupPanelPosition="Top" Skin="Bootstrap" RenderMode="Lightweight" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" FilterType="HeaderContext" EnableHeaderContextMenu="true" >
                        
                        <MasterTableView DataSourceID="getPayments" AutoGenerateColumns="False" CommandItemDisplay="Top">

                            <NoRecordsTemplate>
                                    <br />
                                    <div class="col-md-12">
                                        <div class="alert alert-warning" role="alert"><strong>No Events Found.</strong>  Please adjust your filter options.</div>
                                    </div>
                                </NoRecordsTemplate>

                            <CommandItemTemplate>
                                    <div style="padding: 3px 0 3px 5px">
                                        

                                        <div class="pull-right" style="padding-right: 3px">
                                            <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                                        </div></div>
                                </CommandItemTemplate>

                            <Columns>
                                <telerik:GridBoundColumn DataField="eventExpenseID" HeaderText="eventExpenseID" SortExpression="eventExpenseID" UniqueName="eventExpenseID" DataType="System.Int32" FilterControlAltText="Filter eventExpenseID column" AutoPostBackOnFilter="true" CurrentFilterFunction="StartsWith"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="description" HeaderText="description" SortExpression="description" UniqueName="description" FilterControlAltText="Filter description column" AutoPostBackOnFilter="true" CurrentFilterFunction="StartsWith"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="amount" HeaderText="amount" SortExpression="amount" UniqueName="amount" DataType="System.Decimal" FilterControlAltText="Filter amount column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="expenseBy" HeaderText="expenseBy" SortExpression="expenseBy" UniqueName="expenseBy" FilterControlAltText="Filter expenseBy column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="expenseType" HeaderText="expenseType" SortExpression="expenseType" UniqueName="expenseType" FilterControlAltText="Filter expenseType column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="eventID" HeaderText="eventID" SortExpression="eventID" UniqueName="eventID" DataType="System.Int32" FilterControlAltText="Filter eventID column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="userName" HeaderText="userName" SortExpression="userName" UniqueName="userName" FilterControlAltText="Filter userName column"></telerik:GridBoundColumn>
                            </Columns>

                            <NestedViewTemplate>
                                <div style="min-height:400px; border:1px solid #f1f1f1">

                                    <p>Hello</p>
                                </div>
                            </NestedViewTemplate>
                        </MasterTableView>

                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">

                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />

                    </ClientSettings>

                    </telerik:RadGrid>
                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getPayments" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryViewExpensesByEvents"></asp:LinqDataSource>
                </div>
                </div>

        </div>
</asp:Content>
