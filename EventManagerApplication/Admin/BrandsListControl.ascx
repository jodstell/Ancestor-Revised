<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandsListControl.ascx.vb" Inherits="EventManagerApplication.BrandsListControl" %>

<%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="requestStart">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="BrandsList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="BrandsList" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="BrandGroupList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="BrandGroupList" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="SupplierList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="SupplierList" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="EventTypeList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="EventTypeList" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="TeamsList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="TeamsList" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="MarketList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="MarketList" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="AccountTypeList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="AccountTypeList" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="ActivityTypeList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ActivityTypeList" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
     

</telerik:RadAjaxManager>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" BackgroundPosition="Top"></telerik:RadAjaxLoadingPanel>--%>

<telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
    <PersistenceSettings>
        <telerik:PersistenceSetting ControlID="BrandsList" />
       <%-- <telerik:PersistenceSetting ControlID="CategoryRadTreeView" />--%>
    </PersistenceSettings>
</telerik:RadPersistenceManager>

<h2>Brands</h2>
<hr />

<telerik:RadGrid ID="BrandsList" runat="server"
    AllowPaging="True"
    AllowSorting="True"
    ShowFooter="True"
    ShowStatusBar="true"
    AllowFilteringByColumn="True"
    PageSize="20" CellSpacing="-1"
    FilterType="HeaderContext"
    EnableHeaderContextMenu="true"
    EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="BrandsList_FilterCheckListItemsRequested"
    DataSourceID="getBrandbyClientList">


    <ClientSettings AllowDragToGroup="True"></ClientSettings>

    <MasterTableView AutoGenerateColumns="False" DataKeyNames="brandID" DataSourceID="getBrandbyClientList" CommandItemDisplay="Top" AllowPaging="true" AllowSorting="true">


        <RowIndicatorColumn>
            <HeaderStyle Width="20px"></HeaderStyle>
        </RowIndicatorColumn>

        <CommandItemTemplate>
            <div style="padding: 3px 0 3px 5px">
                <asp:LinkButton ID="btnAddNew" runat="server" CommandName="AddNew" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Brand</asp:LinkButton>
                <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                <div class="pull-right" style="padding-right: 3px">
                    <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                </div>
            </div>
        </CommandItemTemplate>

        <Columns>

            <telerik:GridTemplateColumn AllowFiltering="false" EnableHeaderContextMenu="false">
                <ItemStyle Width="75px" />
                <ItemTemplate>

                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black" CommandArgument='<%# Eval("brandID") %>' CommandName="EditBrand"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>

                </ItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridBoundColumn DataField="brandName"
                FilterControlAltText="Filter brandName column"
                HeaderText="Name"
                SortExpression="brandName"
                UniqueName="brandName"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterCheckListEnableLoadOnDemand="true">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>

                <FilterTemplate>

                    <telerik:RadComboBox ID="RadComboBox_brandName" DataSourceID="getBrandList" DataTextField="brandName" AllowCustomText="true" MarkFirstMatch="true"
                        DataValueField="brandName" Height="200px" Width="320px" AppendDataBoundItems="true"
                        SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("brandName").CurrentFilterValue%>'
                        runat="server" OnClientSelectedIndexChanged="brandNameIndexChanged">
                        <Items>
                            <telerik:RadComboBoxItem Text="All" />
                        </Items>
                    </telerik:RadComboBox>

                    <telerik:RadScriptBlock ID="RadScriptBlock_brandName" runat="server">

                        <script type="text/javascript">
                            function brandNameIndexChanged(sender, args) {
                                var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                tableView.filter("brandName", args.get_item().get_value(), "EqualTo");
                            }
                        </script>

                    </telerik:RadScriptBlock>

                </FilterTemplate>

            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="supplier"
                FilterControlAltText="Filter supplier column"
                HeaderText="Supplier"
                SortExpression="supplier"
                UniqueName="supplier"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterCheckListEnableLoadOnDemand="true">
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="brandGroupName"
                FilterControlAltText="Filter brandGroupName column"
                HeaderText="Group Name"
                SortExpression="brandGroupName"
                UniqueName="brandGroupName"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterCheckListEnableLoadOnDemand="true">
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="Category"
                FilterControlAltText="Filter Category column"
                HeaderText="Category"
                SortExpression="Category"
                UniqueName="Category"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterCheckListEnableLoadOnDemand="true">
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="Type"
                FilterControlAltText="Filter Type column"
                HeaderText="Type"
                SortExpression="Type"
                UniqueName="Type" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterCheckListEnableLoadOnDemand="true">
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="Variety"
                FilterControlAltText="Filter Variety column"
                HeaderText="Variety"
                SortExpression="Variety"
                UniqueName="Variety" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterCheckListEnableLoadOnDemand="true">
            </telerik:GridBoundColumn>



            <telerik:GridBoundColumn DataField="upc"
                FilterControlAltText="Filter upc column"
                HeaderText="UPC"
                SortExpression="upc"
                UniqueName="upc" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterCheckListEnableLoadOnDemand="true">
            </telerik:GridBoundColumn>



            <%--            <telerik:GridTemplateColumn HeaderText="# of Events" AllowFiltering="false">
                <ItemTemplate>
                    <asp:Label ID="EventCountLabel" runat="server" Text='<%# getEventCount(Eval("brandID")) %>' />
                </ItemTemplate>
            </telerik:GridTemplateColumn>--%>


            <telerik:GridBoundColumn DataField="NumberEvents"
                FilterControlAltText="Filter NumberEvents column"
                HeaderText="# of Events"
                SortExpression="NumberEvents"
                UniqueName="NumberEvents" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
            </telerik:GridBoundColumn>



            <telerik:GridTemplateColumn HeaderText="Active" DataField="active" UniqueName="active" SortExpression="active" AllowFiltering="false">
                <ItemStyle Width="100px" />
                <ItemTemplate>
                    <asp:LinkButton ID="BtnActive" runat="server" CommandName="SetActive" CommandArgument='<%# Eval("brandID") %>' ForeColor="White">
                        <asp:Label ID="ActiveLabel" runat="server" />
                    </asp:LinkButton>
                </ItemTemplate>
            </telerik:GridTemplateColumn>


        </Columns>

    </MasterTableView>

    <PagerStyle Position="TopAndBottom" />


</telerik:RadGrid>



<asp:LinqDataSource runat="server" EntityTypeName="" ID="getBrandbyClientList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="brandName"
    TableName="qryGetBrands" Where="clientID == @clientID">
    <WhereParameters>
        <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
    </WhereParameters>
</asp:LinqDataSource>

<asp:SqlDataSource ID="getBrandList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT brandName, clientID FROM tblBrands WHERE (clientID = @clientID) ORDER BY brandName"
    runat="server">
    <SelectParameters>
        <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID"></asp:QueryStringParameter>
    </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="getCategoryList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT Category, clientID FROM qryGetBrands WHERE (clientID = @clientID) and Category is not null ORDER BY Category"
    runat="server">
    <SelectParameters>
        <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID"></asp:QueryStringParameter>
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="getBrandGroupNameList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT brandGroupName, clientID FROM qryGetBrands WHERE (clientID = @clientID) ORDER BY brandGroupName"
    runat="server">
    <SelectParameters>
        <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID"></asp:QueryStringParameter>
    </SelectParameters>
</asp:SqlDataSource>


<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

    <script type="text/javascript">
        function requestStart(sender, args) {
            if (args.get_eventTarget().indexOf("btnExport") >= 0) {
                args.set_enableAjax(false);
            }
        }


        function clearColumnFilter(columnName) {
            var masterTable = $find("<%= BrandsList.ClientID %>").get_masterTableView();
            masterTable.filter(columnName, "", Telerik.Web.UI.GridFilterFunction.NoFilter);
        }



    </script>

</telerik:RadScriptBlock>


