<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SupplierListControl.ascx.vb" Inherits="EventManagerApplication.SupplierListControl" %>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="requestStart">


    <h2>Suppliers</h2>
    <hr />

    <telerik:RadGrid ID="SupplierList" runat="server"
        AllowSorting="True"
        AllowPaging="True"
        ShowFooter="True"
        ShowStatusBar="true"
        AllowCustomPaging="True"
        Skin="Bootstrap"
        AllowFilteringByColumn="True"
        CellSpacing="-1"
        PageSize="20"
        FilterType="HeaderContext"
        EnableHeaderContextMenu="true"
        EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="SupplierList_FilterCheckListItemsRequested"
        DataSourceID="getSupplierbyClientList">

        <MasterTableView DataKeyNames="supplierID" DataSourceID="getSupplierbyClientList" AutoGenerateColumns="False" CommandItemDisplay="Top"></MasterTableView>

        <ExportSettings IgnorePaging="true" OpenInNewWindow="true"></ExportSettings>

        <PagerStyle Position="TopAndBottom" />
        <MasterTableView AutoGenerateColumns="False"
            DataKeyNames="supplierID" CommandItemDisplay="Top">

            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <CommandItemTemplate>
                <div style="padding: 3px 0 3px 5px">
                    <asp:LinkButton ID="btnAddNew" runat="server" CommandName="AddNew" CssClass="btn btn-success btn-sm" ForeColor="White" Visible="true"> <i class="fa fa-plus"></i> Add New Supplier</asp:LinkButton>
                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                    <div class="pull-right" style="padding-right: 3px">
                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                    </div>
            </CommandItemTemplate>

            <Columns>

                <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewButton" EnableHeaderContextMenu="false">
                    <ItemStyle Width="75px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("supplierID") %>' 
                            CommandName="EditSupplier" CssClass="btn btn-xs btn-default" ForeColor="Black"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn DataField="supplierName"
                    FilterControlAltText="Filter supplierName column" FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains"
                    HeaderText="Name" SortExpression="supplierName" UniqueName="supplierName" FilterControlWidth="320px">

                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>

                    <FilterTemplate>

                        <telerik:RadComboBox ID="RadComboBox_supplierName" DataSourceID="getSupplierList" DataTextField="supplierName" AllowCustomText="true" MarkFirstMatch="true"
                            DataValueField="supplierName" Height="200px" Width="320px" AppendDataBoundItems="true"
                            SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("supplierName").CurrentFilterValue%>'
                            runat="server" OnClientSelectedIndexChanged="supplierNameIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="All" />
                            </Items>
                        </telerik:RadComboBox>

                        <telerik:RadScriptBlock ID="RadScriptBlock_supplierName" runat="server">

                            <script type="text/javascript">
                                function supplierNameIndexChanged(sender, args) {
                                    var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                    tableView.filter("supplierName", args.get_item().get_value(), "EqualTo");
                                }
                            </script>

                        </telerik:RadScriptBlock>

                    </FilterTemplate>

                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn HeaderText="# of Brands" AllowFiltering="false">
                    <ItemTemplate>
                        <asp:Label ID="BrandCountLabel" runat="server" Text='<%# getEventBrandsCount(Eval("supplierID")) %>' />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="# of Events" AllowFiltering="false">
                    <ItemTemplate>
                        <asp:Label ID="EventCountLabel" runat="server" Text='<%# getEventCount(Eval("supplierID")) %>' />

                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridCheckBoxColumn DataField="LMS"
                    FilterControlAltText="Filter LMS column"
                    HeaderText="LMS"
                    SortExpression="LMS"
                    UniqueName="LMS" AllowFiltering="False">
                </telerik:GridCheckBoxColumn>

                <telerik:GridTemplateColumn HeaderText="Active" DataField="active" UniqueName="active" SortExpression="active" AllowFiltering="false">
                    <ItemStyle Width="100px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="BtnActive" runat="server" CommandName="SetActive" CommandArgument='<%# Eval("supplierID") %>' ForeColor="White">
                            <asp:Label ID="ActiveLabel" runat="server" />
                        </asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getSupplierbyClientList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="supplierName" TableName="qryGetSupplierLists" Where="clientID == @clientID">

        <WhereParameters>
            <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:SqlDataSource ID="getSupplierList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT supplierName, clientID FROM tblSupplier WHERE (clientID = @clientID) ORDER BY supplierName"
        runat="server">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>



    <script type="text/javascript">
        function requestStart(sender, args)
        {
            if (args.get_eventTarget().indexOf("btnExport") >= 0)
            {
                args.set_enableAjax(false);
            }
        }


    </script>

</telerik:RadAjaxPanel>


