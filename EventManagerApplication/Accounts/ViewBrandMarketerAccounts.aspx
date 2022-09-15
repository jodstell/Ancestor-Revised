<%@ Page Title="Brand Marketer Accounts" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewBrandMarketerAccounts.aspx.vb" Inherits="EventManagerApplication.ViewBrandMarketerAccounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="css/RadMap.css" rel="stylesheet" />


    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="AccountDataGrid" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>


    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="requestStart">
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

        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <h2>Brand Marketer Accounts</h2>

                    <ol class="breadcrumb">
                        <li><i class="fa fa-home" aria-hidden="true"></i><a href="/"> Dashboard</a></li>
                        <li class="active">Accounts</li>
                    </ol>

                    <span id="total"></span>

                </div>
            </div>

            <div class="row">
                <div class="col-sm-12">
                    <asp:Panel ID="GridPanel" runat="server">

                        <asp:Panel ID="MapPanel" runat="server" Visible="false">

                            <div class="row">
                                <div class="col-md-12 bottommargin10">
                                    <div class="pull-right">
                                        <asp:LinkButton ID="btnHideMap" runat="server" CssClass="btn btn-default btn-sm"
                                            ForeColor="Black"><i class="fa fa-th"></i> Hide Map</asp:LinkButton>
                                    </div>
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-md-12">

                                    <div class="widget stacked min-height">
                                        <div class="widget-content">

                                            <telerik:RadMap runat="server" ID="RadMap1" Zoom="4" CssClass="MyMap" Skin="Bootstrap" RenderMode="Mobile" Width="100%" Height="500" Zoomable="true">

                                                <CenterSettings Latitude="39.639537564366705" Longitude="-92.548828125" />

                                                <DataBindings>

                                                    <MarkerBinding DataShapeField="shape" DataTitleField="accountName"
                                                        DataLocationLatitudeField="latitude" DataLocationLongitudeField="longitude" />

                                                </DataBindings>

                                            </telerik:RadMap>

                                        </div>
                                    </div>

                                </div>
                                <asp:HiddenField ID="HiddenField1" runat="server" />


                            </div>

                        </asp:Panel>


                     
                        <telerik:RadGrid ID="AccountDataGrid" runat="server"
                            DataSourceID="GetAccounts"
                            AllowFilteringByColumn="True"
                            AllowPaging="True" AllowSorting="True"
                            AllowCustomPaging="True" PageSize="20"
                            ShowFooter="True" CellSpacing="-1"
                            FilterType="HeaderContext"
                            EnableHeaderContextMenu="true"
                            EnableHeaderContextFilterMenu="true"
                            OnFilterCheckListItemsRequested="AccountDataGrid_FilterCheckListItemsRequested">

                            <ExportSettings IgnorePaging="True" OpenInNewWindow="True">
                                <Pdf AllowAdd="True" AllowCopy="True">
                                </Pdf>
                            </ExportSettings>

                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="accountID" DataSourceID="GetAccounts" CommandItemDisplay="Top">

                                <CommandItemTemplate>
                                    <div style="padding: 3px 0 3px 5px">

                                        <asp:LoginView ID="LoginView_AddButton" runat="server">
                                            <RoleGroups>
                                                <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                                                    <ContentTemplate>
                                                        <asp:LinkButton ID="btnAddNew" runat="server" PostBackUrl="AddAccount" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add Account</asp:LinkButton>
                                                    </ContentTemplate>
                                                </asp:RoleGroup>
                                            </RoleGroups>
                                        </asp:LoginView>


                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                        <asp:LinkButton ID="btnViewActivities" runat="server" PostBackUrl="ViewActivities" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-list"></i> View Activities</asp:LinkButton>


                                        <div class="pull-right" style="padding-right: 3px">
                                            <asp:LinkButton ID="btnMap" runat="server" CommandName="ViewMap" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-globe"></i> Map</asp:LinkButton>&nbsp;
                                       <asp:LoginView ID="LoginView1" runat="server">
                                           <RoleGroups>
                                               <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, Client, Accounting">
                                                   <ContentTemplate>
                                                       <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm pull-right"
                                                           ForeColor="White"><i class="fa fa-download "></i>
                                                            Export Excel</asp:LinkButton>
                                                   </ContentTemplate>
                                               </asp:RoleGroup>
                                           </RoleGroups>
                                       </asp:LoginView>
                                        </div>
                                </CommandItemTemplate>

                                <Columns>


                                    <telerik:GridTemplateColumn AllowFiltering="false" Visible="false">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>
                                            <asp:LoginView ID="LoginView1" runat="server">
                                                <RoleGroups>
                                                    <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, Client, Agency">
                                                        <ContentTemplate>
                                                            <a href='/Accounts/AccountDetails?AccountID=<%# Eval("accountID")%>'>View Account</a>
                                                            <asp:LinkButton ID="btnEdit" runat="server"
                                                                CommandName="EditAccount" CommandArgument='<%# Eval("accountID")%>' CssClass="btn btn-primary btn-xs" ForeColor="White">View Account <%# Eval("accountID")%></asp:LinkButton>
                                                        </ContentTemplate>
                                                    </asp:RoleGroup>
                                                </RoleGroups>
                                            </asp:LoginView>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewButton">
                                        <ItemTemplate>

                                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-xs btn-primary" ForeColor="white" CommandName="EditAccount" CommandArgument='<%# Eval("accountID")%>'>View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>

                                            <br />
                                            <%--<asp:Label ID="updateLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("labelText")%>'></asp:Label>--%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="accountID"
                                        FilterControlAltText="Filter accountID column"
                                        HeaderText="Account ID" SortExpression="accountID" UniqueName="accountID"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <%--<telerik:GridBoundColumn DataField="VpID"
                                    FilterControlAltText="Filter VpID column"
                                    HeaderText="VpID" SortExpression="VpID" UniqueName="VpID"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                    <ColumnValidationSettings>
                                        <ModelErrorMessage Text="" />
                                    </ColumnValidationSettings>
                                </telerik:GridBoundColumn>--%>


                                    <telerik:GridBoundColumn DataField="accountName"
                                        FilterControlAltText="Filter accountName column"
                                        HeaderText="Name" SortExpression="accountName" UniqueName="accountName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="streetAddress1"
                                        FilterControlAltText="Filter streetAddress1 column"
                                        HeaderText="Address" SortExpression="streetAddress1" UniqueName="streetAddress1" FilterControlWidth="150px"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="city" FilterCheckListEnableLoadOnDemand="true"
                                        FilterControlAltText="Filter city column"
                                        HeaderText="City" SortExpression="city" UniqueName="city"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="StateName" FilterCheckListEnableLoadOnDemand="true"
                                        FilterControlAltText="Filter state column"
                                        HeaderText="State" SortExpression="StateName" UniqueName="StateName">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                        <FilterTemplate>

                                            <telerik:RadComboBox ID="RadComboBox_StateName" DataSourceID="getStateNameList" DataTextField="StateName"
                                                DataValueField="StateName" Height="200px" Width="120px" AppendDataBoundItems="true"
                                                SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("StateName").CurrentFilterValue%>'
                                                runat="server" OnClientSelectedIndexChanged="StateNameIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="All" />
                                                </Items>
                                            </telerik:RadComboBox>

                                            <telerik:RadScriptBlock ID="RadScriptBlock_StateName" runat="server">

                                                <script type="text/javascript">
                                                    function StateNameIndexChanged(sender, args) {
                                                        var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                                    tableView.filter("StateName", args.get_item().get_value(), "EqualTo");
                                                }
                                                </script>

                                            </telerik:RadScriptBlock>

                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="zipCode"
                                        FilterControlAltText="Filter zipCode column"
                                        HeaderText="Zip Code" SortExpression="zipCode" UniqueName="zipCode"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="accountTypeName" FilterCheckListEnableLoadOnDemand="true"
                                        FilterControlAltText="Filter accountTypeName column"
                                        HeaderText="Type" SortExpression="accountTypeName" UniqueName="accountTypeName">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                        <FilterTemplate>

                                            <telerik:RadComboBox ID="RadComboBox_accountType" DataSourceID="getAccountType" DataTextField="accountTypeName"
                                                DataValueField="accountTypeName" Height="200px" Width="120px" AppendDataBoundItems="true"
                                                SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("accountTypeName").CurrentFilterValue%>'
                                                runat="server" OnClientSelectedIndexChanged="accountTypeIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="All" />
                                                </Items>
                                            </telerik:RadComboBox>

                                            <telerik:RadScriptBlock ID="RadScriptBlock_accountType" runat="server">

                                                <script type="text/javascript">
                                                    function accountTypeIndexChanged(sender, args) {
                                                        var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                                    tableView.filter("accountTypeName", args.get_item().get_value(), "EqualTo");
                                                }
                                                </script>

                                            </telerik:RadScriptBlock>

                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="marketName" FilterCheckListEnableLoadOnDemand="true"
                                        FilterControlAltText="Filter marketName column"
                                        HeaderText="Market" SortExpression="marketName" UniqueName="marketName">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>

                                        <FilterTemplate>

                                            <telerik:RadComboBox ID="RadComboBox_marketName" DataSourceID="getMarketList" DataTextField="marketName"
                                                DataValueField="marketName" Height="200px" Width="120px" AppendDataBoundItems="true"
                                                SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("marketName").CurrentFilterValue%>'
                                                runat="server" OnClientSelectedIndexChanged="MarketIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="All" />
                                                </Items>
                                            </telerik:RadComboBox>

                                            <telerik:RadScriptBlock ID="RadScriptBlock_marketName" runat="server">

                                                <script type="text/javascript">
                                                    function MarketIndexChanged(sender, args) {
                                                        var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                                    tableView.filter("marketName", args.get_item().get_value(), "EqualTo");
                                                }
                                                </script>

                                            </telerik:RadScriptBlock>

                                        </FilterTemplate>

                                    </telerik:GridBoundColumn>


                                </Columns>
                            </MasterTableView>
                            <PagerStyle Position="TopAndBottom" />
                        </telerik:RadGrid>

                    </asp:Panel>


                    <asp:LinqDataSource ID="getClients" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="clientID" TableName="tblClients">
                    </asp:LinqDataSource>

                    <asp:SqlDataSource ID="GetAccounts2" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                        SelectCommand="getAccountsByUserID" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                    <asp:LinqDataSource ID="GetAccounts" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="qryViewAccounts" OrderBy="accountName" Where="brandChampion == @brandChampion">
                        <WhereParameters>
                            <asp:Parameter DefaultValue="True" Name="brandChampion" Type="Boolean"></asp:Parameter>
                        </WhereParameters>
                    </asp:LinqDataSource>

                    <asp:SqlDataSource ID="getMarketList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT marketName FROM qryViewAccounts  ORDER BY marketName"
                        runat="server"></asp:SqlDataSource>

                    <asp:SqlDataSource ID="getAccountType" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT accountTypeName FROM qryViewAccounts ORDER BY accountTypeName"
                        runat="server"></asp:SqlDataSource>

                    <asp:SqlDataSource ID="getStateNameList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT StateName FROM qryViewAccounts  ORDER BY StateName"
                        runat="server"></asp:SqlDataSource>

                </div>
            </div>
        </div>

    </asp:Panel>

    <script type="text/javascript">
        $('#accounts').addClass('active');

        function requestStart(sender, args) {

            if (args.get_eventTarget().indexOf("btnExport") > 0 ||

            args.get_eventTarget().indexOf("btnExport") > 0)

                args.set_enableAjax(false);
        }

    </script>


</asp:Content>
