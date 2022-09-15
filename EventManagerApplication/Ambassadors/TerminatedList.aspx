<%@ Page Title="Terminated List" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="TerminatedList.aspx.vb" Inherits="EventManagerApplication.TerminatedList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../Theme/css/custom1.css" rel="stylesheet" />
    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="css/schedule.css" rel="stylesheet" />

<div class="container">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="Panel1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

     <asp:Panel ID="Panel1" runat="server">

             <div class="row">
            <div class="col-xs-12">
                <h2>Brand Ambassadors: Terminated</h2>
                <ol class="breadcrumb">
                    <li><i class="fa fa-home" aria-hidden="true"></i><a href="/">Dashboard</a></li>
                    <li class="active">Terminated Ambassadors</li>
                </ol>

            </div>
        </div>

            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="2" Skin="Bootstrap">
                            <Tabs>
                                <telerik:RadTab Text="Active" runat="server" ID="activeTab" NavigateUrl="ActiveList.aspx"></telerik:RadTab>
                                <telerik:RadTab Text="Prospect" runat="server" ID="pendingTab" NavigateUrl="PendingList.aspx"></telerik:RadTab>
                                <telerik:RadTab Text="Terminated" runat="server" ID="terminatedTab" NavigateUrl="TerminatedList.aspx"></telerik:RadTab>
                                <telerik:RadTab Text="Rejected" runat="server" ID="rejectedTab" NavigateUrl="RejectedList.aspx"></telerik:RadTab>
<%--<telerik:RadTab Text="Payments" runat="server" ID="paymentsTab"></telerik:RadTab>--%>
                            </Tabs>
                        </telerik:RadTabStrip>

    <div class="widget stacked">
        <div class="widget-content">

            <telerik:RadGrid ID="TerminatedAmbassadorList" runat="server" DataSourceID="getTerminatedList"
                AllowFilteringByColumn="True"
                AllowPaging="True" AllowSorting="True"
                AllowCustomPaging="True" PageSize="20"
                ShowFooter="True" CellSpacing="-1" GroupPanelPosition="Top"
                FilterType="HeaderContext"
                EnableHeaderContextMenu="true"
                EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="TreminatedAmbassadorList_FilterCheckListItemsRequested">

                <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ></ExportSettings>

                <MasterTableView AutoGenerateColumns="False" DataKeyNames="ambassadorID" DataSourceID="getTerminatedList" CommandItemDisplay="Top">

                    <NoRecordsTemplate>

                        <br />
                        <div class="col-md-12">
                            <div class="alert alert-warning" role="alert"><strong>No Ambassadors Found.</strong>  Please adjust your filter options.</div>
                        </div>

                    </NoRecordsTemplate>

                    <RowIndicatorColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>

                    <CommandItemTemplate>
                        <div style="padding: 3px 0 3px 5px">
                            <asp:LoginView ID="LoginView_AddButton" runat="server">
                                <RoleGroups>
                                    <asp:RoleGroup Roles="Administrator, Recruiter/Booking, Accounting">
                                        <ContentTemplate>
                                            <asp:LinkButton ID="btnAddNew" runat="server" PostBackUrl="AddAmbassador" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Ambassador</asp:LinkButton>
                                        </ContentTemplate>
                                    </asp:RoleGroup>
                                </RoleGroups>
                            </asp:LoginView>

                            <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                            <div class="pull-right" style="padding-right: 3px">
                                <asp:LinkButton ID="btnExport3" runat="server" CommandName="ExportExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                            </div>
                    </CommandItemTemplate>

                    <Columns>

                        <telerik:GridTemplateColumn AllowFiltering="false" ShowFilterIcon="false" UniqueName="ViewButton">
                            <ItemTemplate>
                                <a href="ViewAmbassadorDetails.aspx?UserID=<%# Eval("UserID")%>" class="btn btn-xs btn-primary" style="color: #fff">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn FilterCheckListEnableLoadOnDemand="true" DataField="UserName"
                            FilterControlAltText="Filter UserName column" HeaderText="User Name" SortExpression="UserName" UniqueName="UserName" AutoPostBackOnFilter="true" CurrentFilterFunction="StartsWith">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="FirstName" HeaderText="First Name" SortExpression="FirstName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />

                        <telerik:GridBoundColumn DataField="LastName" HeaderText="Last Name" SortExpression="LastName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />

                        <telerik:GridBoundColumn DataField="EmailAddress" HeaderText="Email" SortExpression="EmailAddress" FilterCheckListEnableLoadOnDemand="false"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />

                        <telerik:GridBoundColumn DataField="City" HeaderText="City" SortExpression="City"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" />

                        <telerik:GridBoundColumn DataField="State" HeaderText="State" SortExpression="State" FilterCheckListEnableLoadOnDemand="true"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" />

                        <telerik:GridTemplateColumn HeaderText="Last Login" SortExpression="LastLoginDate" AllowFiltering="false">
                            <ItemTemplate>

                                <asp:Label ID="Label1" runat="server" Text='<%#Common.GetTimeAdjustment(Eval("LastLoginDate"))%>' />
                                <%--<%# (Eval("LastLoginDate") = DBNull.Value) : Eval("LastLoginDate")%>--%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                    </Columns>
                </MasterTableView>

                <PagerStyle Position="TopAndBottom"></PagerStyle>

            </telerik:RadGrid>

             <asp:LinqDataSource ID="getTerminatedList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" 
                TableName="qryViewTerminatedAmbassadors"></asp:LinqDataSource>

           
                                    </div>

    </div>
</asp:Panel>
</div>

</asp:Content>
