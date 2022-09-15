<%@ Page Title="Active List" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ActiveList.aspx.vb" Inherits="EventManagerApplication.ActiveList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../Theme/css/custom1.css" rel="stylesheet" />
    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="css/schedule.css" rel="stylesheet" />

    <div class="container">

        <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
            <PersistenceSettings>
                <telerik:PersistenceSetting ControlID="ActiveAmbassadorList" />
            </PersistenceSettings>
        </telerik:RadPersistenceManager>

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
                    <h2>Brand Ambassadors: Active</h2>
                    <ol class="breadcrumb">
                        <li><i class="fa fa-home" aria-hidden="true"></i><a href="/">Dashboard</a></li>
                        <li class="active">Active Ambassadors</li>
                    </ol>

                </div>
            </div>

            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" Skin="Bootstrap">
                <Tabs>
                    <telerik:RadTab Text="Active" runat="server" ID="activeTab"></telerik:RadTab>
                    <telerik:RadTab Text="Prospect" runat="server" ID="pendingTab" NavigateUrl="PendingList.aspx"></telerik:RadTab>
                    <telerik:RadTab Text="Terminated" runat="server" ID="terminatedTab" NavigateUrl="TerminatedList.aspx"></telerik:RadTab>
                    <telerik:RadTab Text="Rejected" runat="server" ID="rejectedTab" NavigateUrl="RejectedList.aspx"></telerik:RadTab>
                    <%--<telerik:RadTab Text="Payments" runat="server" ID="paymentsTab"></telerik:RadTab>--%>
                </Tabs>
            </telerik:RadTabStrip>


            <div class="widget stacked">
                <div class="widget-content">

                    <div class="col-md-12 marginbottom10 margintop20">

                        <telerik:RadComboBox ID="MarketComboBox" runat="server" DataSourceID="getMarketList"
                            DataTextField="marketName" DataValueField="marketID" Label="Filter by Market:"
                            Width="320px" MarkFirstMatch="True" AllowCustomText="True" AutoPostBack="true" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="All Markets" Value="0" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </div>

                    <div>
                        <telerik:RadGrid ID="ActiveAmbassadorList" runat="server" 
                            AllowPaging="True"
                            AllowSorting="True"
                            ShowFooter="True"
                            ShowStatusBar="true"
                            AllowFilteringByColumn="True"
                            PageSize="20" CellSpacing="-1"
                            FilterType="HeaderContext"
                            EnableHeaderContextMenu="true"
                            EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="ActiveAmbassadorList_FilterCheckListItemsRequested" EnableLinqExpressions="False">

                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true"></ExportSettings>

                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ambassadorID" CommandItemDisplay="Top"
                                Font-Size="10">

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
                                        <asp:LinkButton ID="btnAdvancedFilters" runat="server" OnClientClick="CreateWindowScript()" CssClass="btn btn-primary btn-sm" ForeColor="White" Visible="false"><i class="fa fa-filter"></i> Advanced Filters</asp:LinkButton>


                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ResetGrid" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                        <div class="pull-right" style="padding-right: 3px">
                                            <%--<asp:LinkButton ID="btnMapView1" runat="server" CssClass="btn btn-default btn-sm" ForeColor="Black" OnClick="btnMapView1_Click"><i class="fa fa-globe"></i> Map</asp:LinkButton>--%>
                                            <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                                        </div>
                                </CommandItemTemplate>

                                <Columns>

                                    <telerik:GridTemplateColumn AllowFiltering="false" ShowFilterIcon="false" UniqueName="ViewButton">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>

                                            <asp:LinkButton ID="ViewButton" runat="server" CssClass="btn btn-xs btn-primary" ForeColor="white" CommandName="ViewAmbassador" CommandArgument='<%# Eval("UserID")%>'>View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>

                                            <br />
                                            <asp:Label ID="updateLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("labelText")%>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridBoundColumn FilterCheckListEnableLoadOnDemand="true" DataField="UserName"
                                        FilterControlAltText="Filter UserName column" HeaderText="User Name" SortExpression="UserName" UniqueName="UserName" AutoPostBackOnFilter="true" CurrentFilterFunction="StartsWith" HeaderStyle-Wrap="false" Visible="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="FirstName" HeaderText="First Name" SortExpression="FirstName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" HeaderStyle-Wrap="false" />

                                    <telerik:GridBoundColumn DataField="LastName" HeaderText="Last Name" SortExpression="LastName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" HeaderStyle-Wrap="false" />

                                    <telerik:GridBoundColumn DataField="EmailAddress" HeaderText="Email" SortExpression="EmailAddress" FilterCheckListEnableLoadOnDemand="false"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" />

                                    <telerik:GridBoundColumn DataField="City" HeaderText="City" SortExpression="City"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" />

                                    <telerik:GridBoundColumn DataField="State" HeaderText="State" SortExpression="State" FilterCheckListEnableLoadOnDemand="true"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" />

                                    <telerik:GridTemplateColumn HeaderText="Last Login" SortExpression="LastLoginDate" AllowFiltering="false" GroupByExpression="False" Groupable="false" UniqueName="LastLoginDate">
                                        <ItemTemplate>

                                            <asp:Label ID="Label1" runat="server" Text='<%#Common.GetTimeAdjustment(Eval("LastLoginDate"))%>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <%-- <telerik:GridBoundColumn DataField="Markets" HeaderText="Markets" SortExpression="Markets" FilterCheckListEnableLoadOnDemand="true"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" Visible="true" />

                        <telerik:GridBoundColumn DataField="Positions" HeaderText="Positions" SortExpression="Positions" FilterCheckListEnableLoadOnDemand="true" ItemStyle-Wrap="false" Visible="true"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />--%>
                                </Columns>
                            </MasterTableView>

                                <%--<ClientSettings ReorderColumnsOnClient="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                        <Virtualization EnableVirtualization="true" InitiallyCachedItemsCount="20"
                            LoadingPanelID="RadAjaxLoadingPanel1" ItemsPerView="20" />
                    </ClientSettings>--%>

                            <PagerStyle Position="TopAndBottom"></PagerStyle>

                        </telerik:RadGrid>

                    </div>

<%--                    <asp:LinqDataSource ID="getActiveAmbassadors" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="userName" TableName="qryViewActiveAmbassadors">
                    </asp:LinqDataSource>--%>

                    <asp:SqlDataSource ID="getActiveAmbassadorsByMarketID" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getActiveAmbassador_byMarketID" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="MarketComboBox" PropertyName="SelectedValue" Name="marketID" Type="Int32"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>

                </div>
            </div>
        </asp:Panel>
    </div>


    <asp:LinqDataSource ID="getMarketList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="marketName" TableName="tblMarkets">
    </asp:LinqDataSource>

</asp:Content>
