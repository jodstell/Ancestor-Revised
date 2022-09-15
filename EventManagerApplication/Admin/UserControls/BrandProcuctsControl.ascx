<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandProcuctsControl.ascx.vb" Inherits="EventManagerApplication.BrandProcuctsControl" %>



<telerik:RadGrid ID="ProcustList" runat="server"
    AllowPaging="True"
    AllowSorting="True"
    ShowFooter="True"
    ShowStatusBar="true"
    AllowFilteringByColumn="True"
    PageSize="20" CellSpacing="-1"
    FilterType="HeaderContext"
    EnableHeaderContextMenu="true"
    EnableHeaderContextFilterMenu="true" 
    DataSourceID="getProductsByBrands">


    <ClientSettings AllowDragToGroup="True"></ClientSettings>

    <MasterTableView AutoGenerateColumns="False" DataKeyNames="productID" DataSourceID="getProductsByBrands" CommandItemDisplay="Top" AllowPaging="true" AllowSorting="true">


        <RowIndicatorColumn>
            <HeaderStyle Width="20px"></HeaderStyle>
        </RowIndicatorColumn>

        <CommandItemTemplate>
            <div style="padding: 3px 0 3px 5px">
                <asp:LinkButton ID="btnAddNew" runat="server" CommandName="AddNew" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Product</asp:LinkButton>
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

                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black" CommandArgument='<%# Eval("productID") %>' CommandName="EditBrand"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>

                </ItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridBoundColumn DataField="productName"
                FilterControlAltText="Filter productName column"
                HeaderText="Name"
                SortExpression="productName"
                UniqueName="productName"
                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                FilterCheckListEnableLoadOnDemand="true">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>

                <FilterTemplate>

                    <telerik:RadComboBox ID="RadComboBox_productName" DataSourceID="getProductList" DataTextField="productName" AllowCustomText="true" MarkFirstMatch="true"
                        DataValueField="productName" Height="200px" Width="320px" AppendDataBoundItems="true"
                        SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("productName").CurrentFilterValue%>'
                        runat="server" OnClientSelectedIndexChanged="brandNameIndexChanged">
                        <Items>
                            <telerik:RadComboBoxItem Text="All" />
                        </Items>
                    </telerik:RadComboBox>

                    <telerik:RadScriptBlock ID="RadScriptBlock_productName" runat="server">

                        <script type="text/javascript">
                            function productNameIndexChanged(sender, args) {
                                var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                tableView.filter("productName", args.get_item().get_value(), "EqualTo");
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



            <%--<telerik:GridTemplateColumn HeaderText="# of Events" AllowFiltering="false">
                <ItemTemplate>
                    <asp:Label ID="EventCountLabel" runat="server" Text='<%# getEventCount(Eval("brandID")) %>' />
                </ItemTemplate>
            </telerik:GridTemplateColumn>--%>


            <%--<telerik:GridBoundColumn DataField="NumberEvents"
                FilterControlAltText="Filter NumberEvents column"
                HeaderText="# of Events"
                SortExpression="NumberEvents"
                UniqueName="NumberEvents" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
            </telerik:GridBoundColumn>--%>



            <telerik:GridTemplateColumn HeaderText="Active" DataField="active" UniqueName="active" SortExpression="active" AllowFiltering="false">
                <ItemStyle Width="100px" />
                <ItemTemplate>
                    <asp:LinkButton ID="BtnActive" runat="server" CommandName="SetActive" CommandArgument='<%# Eval("productID") %>' ForeColor="White">
                        <asp:Label ID="ActiveLabel" runat="server" />
                    </asp:LinkButton>
                </ItemTemplate>
            </telerik:GridTemplateColumn>


        </Columns>

    </MasterTableView>

    <PagerStyle Position="TopAndBottom" />


</telerik:RadGrid>

<asp:LinqDataSource ID="getProductsByBrands" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="getProductsByBrands" Where="brandID == @brandID">
    <WhereParameters>
        <asp:SessionParameter DbType="Int32" Name="brandID" SessionField="SelectedBrandID" />
    </WhereParameters>
</asp:LinqDataSource>
