<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="RegionsAndMarkets.ascx.vb" Inherits="EventManagerApplication.RegionsAndMarkets" %>


<telerik:RadAjaxPanel ID="RadAjaxPanel" runat="server" ClientEvents-OnRequestStart="requestStart">
    <telerik:RadGrid ID="MarketList" runat="server" DataSourceID="getMarkets"
        AllowPaging="True"
        AllowSorting="True"
        ShowFooter="True"
        ShowStatusBar="true"
        AllowFilteringByColumn="True"
        PageSize="20"
        AllowCustomPaging="True"
        CellSpacing="-1"
        GroupPanelPosition="Top"       
        Skin="Bootstrap"
        OnItemCreated="RadGrid1_ItemCreated"
        OnItemInserted="RadGrid1_ItemInserted" 
        OnPreRender="RadGrid1_PreRender"
        OnInsertCommand="RadGrid1_InsertCommand" AllowAutomaticInserts="true" AllowAutomaticUpdates="true">

        <PagerStyle Position="TopAndBottom" />

        <MasterTableView AutoGenerateColumns="False" DataKeyNames="marketID" DataSourceID="getMarkets" CommandItemDisplay="Top">

            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <CommandItemTemplate>
                <div style="padding: 3px 0 3px 5px">
                    <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-success btn-sm" ForeColor="White" CommandName="AddNew"><i class="fa fa-plus"></i>Add New Market</asp:LinkButton>
                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                    <div class="pull-right" style="padding-right: 3px">
                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i>Export CSV</asp:LinkButton>
                    </div>
            </CommandItemTemplate>

            <Columns>

                <telerik:GridTemplateColumn AllowFiltering="false">
                    <ItemStyle Width="75px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="EditButton" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black" CommandName="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn DataField="marketName"
                    FilterControlAltText="Filter marketName column"
                    HeaderText="Market Name"
                    SortExpression="marketName"
                    UniqueName="marketName">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>

                    <FilterTemplate>

                        <telerik:RadComboBox ID="RadComboBox_marketName" DataSourceID="getMarketNameList" DataTextField="marketName" AllowCustomText="true" MarkFirstMatch="true"
                            DataValueField="marketName" Height="200px" Width="380px" AppendDataBoundItems="true"
                            SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("marketName").CurrentFilterValue%>'
                            runat="server" OnClientSelectedIndexChanged="marketNameIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="All" />
                            </Items>
                        </telerik:RadComboBox>

                        <telerik:RadScriptBlock ID="RadScriptBlock_marketName" runat="server">

                            <script type="text/javascript">
                                function marketNameIndexChanged(sender, args) {
                                    var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                    tableView.filter("marketName", args.get_item().get_value(), "EqualTo");
                                }
                            </script>

                        </telerik:RadScriptBlock>

                    </FilterTemplate>

                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn HeaderText="# of Accounts" AllowFiltering="false">
                    <ItemTemplate>
                        <asp:Label ID="AccountsLabel" runat="server" Text='<%# getAccountsCount(Eval("marketID"))%>' />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Active" DataField="active" AllowFiltering="false">
                    <ItemStyle Width="100px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="BtnActive" runat="server" CommandName="SetActive" CommandArgument='<%# Eval("marketID") %>' ForeColor="White">
                            <asp:Label ID="ActiveLabel" runat="server" />
                        </asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:LinqDataSource ID="getMarkets" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblMarkets" OrderBy="marketName"></asp:LinqDataSource>

    <asp:SqlDataSource ID="getMarketNameList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT DISTINCT marketName FROM [tblMarket]"></asp:SqlDataSource>

</telerik:RadAjaxPanel>

<script type="text/javascript">
    function requestStart(sender, args) {
        if (args.get_eventTarget().indexOf("btnExport") >= 0) {
            args.set_enableAjax(false);
        }
    }


</script>
