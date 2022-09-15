<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin.Master" CodeBehind="ClientList.aspx.vb" Inherits="EventManagerApplication.ClientList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
 
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ClientsPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ClientsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ClientsList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ClientsList" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>        
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>--%>

    <div class="container">
        <div class="row">
        </div>

        <div class="row">
            <div class="col-md-12">
                <h2>Clients</h2>
                
                <hr />

                <div class="widget stacked">
                    <div class="widget-content min-height">

                        <asp:Panel ID="ClientsPanel" runat="server">

                        <div style="margin-top: 10px;">

                            <telerik:RadGrid ID="ClientList" runat="server" DataSourceID="getClientList"
                                AllowPaging="True"
                                AllowSorting="True"
                                ShowFooter="True"
                                ShowStatusBar="true"
                                AllowFilteringByColumn="True"
                                PageSize="20" CellSpacing="-1"
                                FilterType="HeaderContext"
                                EnableHeaderContextMenu="true"
                                EnableHeaderContextFilterMenu="true">


                                <ExportSettings IgnorePaging="true" OpenInNewWindow="true"></ExportSettings>

                                <MasterTableView DataKeyNames="ClientID" DataSourceID="getClientList" AutoGenerateColumns="False" CommandItemDisplay="Top" AllowSorting="true">
                                    <NoRecordsTemplate>

                                        <br />
                                        <div class="col-md-12">
                                            <div class="alert alert-warning" role="alert"><strong>No Results Found.</strong>  Please adjust your filter options.</div>
                                        </div>

                                    </NoRecordsTemplate>



                                    <CommandItemTemplate>
                                        <div style="padding: 3px 0 3px 5px">
                                            <asp:LinkButton ID="btnAddNew" runat="server" CssClass="btn btn-success btn-sm" ForeColor="White" CommandName="NewClient"> <i class="fa fa-plus"></i> Add New Client</asp:LinkButton>
                                            <asp:LinkButton ID="btnAdvancedFilters" runat="server" OnClientClick="CreateWindowScriptFilter()" CssClass="btn btn-primary btn-sm" ForeColor="White" Visible="false"><i class="fa fa-filter"></i> Advanced Filters</asp:LinkButton>
                                            <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>


                                            <div class="pull-right" style="padding-right: 3px">

                                                <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export to Excel</asp:LinkButton>
                                            </div>
                                    </CommandItemTemplate>

                                    <Columns>

                                        <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewButton">
                                            <ItemStyle Width="40px" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnViewProfile" CommandName="ViewClient" runat="server" CommandArgument='<%# Eval("ClientID")%>' CssClass="btn btn-primary btn-xs" ForeColor="White">
                                                View Client &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="clientID" HeaderText="ID" CurrentFilterFunction="Contains" SortExpression="clientID" UniqueName="clientID" FilterControlAltText="Filter clientID column"></telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="clientName" HeaderText="Client Name" SortExpression="clientName" CurrentFilterFunction="Contains" UniqueName="clientName" FilterControlAltText="Filter clientName column"></telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="country" HeaderText="country" SortExpression="country" CurrentFilterFunction="Contains" UniqueName="country" FilterControlAltText="Filter country column"></telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="city" HeaderText="city" CurrentFilterFunction="Contains" SortExpression="city" UniqueName="city" FilterControlAltText="Filter city column"></telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="state" HeaderText="state" SortExpression="state" UniqueName="state" FilterControlAltText="Filter state column" ItemStyle-Width="20%"></telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="active" HeaderText="active" SortExpression="active" UniqueName="active" FilterControlAltText="Filter active column"></telerik:GridBoundColumn>







                                        <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="DeleteButton">
                                            <ItemStyle Width="40px" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnDeleteProfile" CommandName="DeleteClient" runat="server" CommandArgument='<%# Eval("ClientID")%>' CssClass="btn btn-danger btn-xs" ForeColor="White" OnClientClick="javascript:if(!confirm('This action will delete the selected client. Are you sure?')){return false;}">
                                                <i class="fa fa-trash"></i>&nbsp;&nbsp;Delete Client</asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                    </Columns>
                                </MasterTableView>

                                <PagerStyle Position="TopAndBottom"></PagerStyle>

                            </telerik:RadGrid>


                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getStaffList"
                                ContextTypeName="EventManagerApplication.UserDataClassesDataContext"
                                OrderBy="lastLoginDate desc" TableName="qryViewStaffListings">
                            </asp:LinqDataSource>

                            <asp:LinqDataSource ID="getClientList" runat="server" EntityTypeName=""
                                ContextTypeName="EventManagerApplication.DataClassesDataContext"  
                                OrderBy="clientName" TableName="tblClients"></asp:LinqDataSource>

                            <asp:Panel ID="AddNewClientPanel" runat="server">
                            </asp:Panel>

                        </div>

                        </asp:Panel>

                    </div>

                </div>
            </div>
        </div>

    </div>

</asp:Content>
