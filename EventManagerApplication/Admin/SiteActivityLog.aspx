<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="SiteActivityLog.aspx.vb" Inherits="EventManagerApplication.SiteActivityLog" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h2>Administration</h2>
                <h3>History Logs</h3>
                <br />

            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">

                <telerik:RadGrid ID="HistoryLogGrid" runat="server" 
                    AllowPaging="True"
                            AllowSorting="True"
                            ShowFooter="True"
                            ShowStatusBar="true"
                            AllowFilteringByColumn="True"
                            PageSize="20" CellSpacing="-1"
                            FilterType="HeaderContext"
                            EnableHeaderContextMenu="true"
                            EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="HistoryLogGrid_FilterCheckListItemsRequested"
                            EnableLinqExpressions="False">

                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ></ExportSettings>


                    <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="Top" AllowSorting="true">
                        <NoRecordsTemplate>

                                    <br />
                                    <div class="col-md-12">
                                        <div class="alert alert-warning" role="alert"><strong>No Events Found.</strong>  Please adjust your filter options.</div>
                                    </div>

                                </NoRecordsTemplate>

                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </RowIndicatorColumn>

                        <CommandItemTemplate>
                                    <div style="padding: 3px 0 3px 5px">

                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ResetGrid" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>
                                    </div>
       
                                </CommandItemTemplate>

                        <Columns>
                            
                            <telerik:GridBoundColumn DataField="UserName" HeaderText="UserName" SortExpression="UserName" UniqueName="UserName" FilterControlAltText="Filter UserName column"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true"></telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="Full Name" HeaderText="Full Name" SortExpression="Full_Name" UniqueName="Full_Name" FilterControlAltText="Filter Full_Name column" CurrentFilterFunction="Contains"></telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="EventID" HeaderText="EventID" SortExpression="EventID" UniqueName="EventID" DataType="System.Int32" FilterControlAltText="Filter EventID column" CurrentFilterFunction="EqualTo"></telerik:GridBoundColumn>
                            
                            <telerik:GridBoundColumn DataField="ActivityDate(CST)" HeaderText="ActivityDate(CST)" SortExpression="ActivityDate_CST_" UniqueName="ActivityDate_CST_" DataType="System.DateTime" FilterControlAltText="Filter ActivityDate_CST_ column"></telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="Activity" HeaderText="Activity" SortExpression="Activity" UniqueName="Activity" FilterControlAltText="Filter Activity column"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true"></telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="PageURL" HeaderText="PageURL" SortExpression="PageURL" UniqueName="PageURL" FilterControlAltText="Filter PageURL column"></telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="Details" HeaderText="Details" SortExpression="Details" UniqueName="Details" FilterControlAltText="Filter Details column"></telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="IPAddress" HeaderText="IPAddress" SortExpression="IPAddress" UniqueName="IPAddress" FilterControlAltText="Filter IPAddress column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UserAgent" HeaderText="UserAgent" SortExpression="UserAgent" UniqueName="UserAgent" FilterControlAltText="Filter UserAgent column"></telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>

                    <PagerStyle Position="TopAndBottom" />

                </telerik:RadGrid>

              <%--  <asp:LinqDataSource runat="server" EntityTypeName="" ID="getHistoryLog" ContextTypeName="EventManagerApplication.LMSDataClassesDataContext" OrderBy="ActivityDate_CST_ desc" TableName="qryViewHistoryLogs"></asp:LinqDataSource>--%>
            </div>
        </div>

      </div>
</asp:Content>
