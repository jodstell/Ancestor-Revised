<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PackageSizeControl.ascx.vb" Inherits="EventManagerApplication.PackageSizeControl" %>

<telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server"  ClientEvents-OnRequestStart="requestStart">

<telerik:RadGrid ID="PackageSizeList" runat="server" DataSourceID="getCategoriesList"
        AllowSorting="True"
        AllowPaging="True"
        GroupPanelPosition="Top"
        ShowFooter="True"
        ShowStatusBar="true"
        AllowCustomPaging="True"
        Skin="Bootstrap"
        AllowFilteringByColumn="True"
        CellSpacing="-1"
        PageSize="20"
        OnItemCreated="RadGrid1_ItemCreated"
        OnItemInserted="RadGrid1_ItemInserted" 
        OnPreRender="RadGrid1_PreRender"        
        OnInsertCommand="RadGrid1_InsertCommand"
        AllowAutomaticUpdates="True"
        AllowAutomaticInserts="True">

        

        <PagerStyle Position="TopAndBottom" />

        <MasterTableView AutoGenerateColumns="False" DataKeyNames="BrandCategoryID" CommandItemDisplay="Top" DataSourceID="getCategoriesList">

            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <CommandItemTemplate>
                <div style="padding: 3px 0 3px 5px">
                    <asp:LinkButton ID="btnAddNew" runat="server" CommandName="InitInsert" CssClass="btn btn-success btn-sm" ForeColor="White" 
                        Visible='<%# Not PackageSizeList.MasterTableView.IsItemInserted %>'> <i class="fa fa-plus"></i> Add New Category</asp:LinkButton>
                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                    <div class="pull-right" style="padding-right: 3px">
                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i>Export CSV</asp:LinkButton>
                    </div>
            </CommandItemTemplate>

            <Columns>

                <telerik:GridTemplateColumn AllowFiltering="false">
                    <ItemStyle Width="75px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black" 
                            CommandName="Edit" CommandArgument='<%# Eval("BrandCategoryID") %>'><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                                
                <telerik:GridBoundColumn DataField="categoryName"
                    FilterControlAltText="Filter categoryName column"
                    HeaderText="Category Name"
                    SortExpression="categoryName"
                    UniqueName="categoryName">

                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>

                    <FilterTemplate>

                        <telerik:RadComboBox ID="RadComboBox_teamName" DataSourceID="getCategoriesList" DataTextField="categoryName" AllowCustomText="true" MarkFirstMatch="true"
                            DataValueField="categoryName" Height="200px" Width="320px" AppendDataBoundItems="true"
                            SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("categoryName").CurrentFilterValue%>'
                            runat="server" OnClientSelectedIndexChanged="teamNameIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="All" />
                            </Items>
                        </telerik:RadComboBox>

                        <telerik:RadScriptBlock ID="RadScriptBlock_categoryName" runat="server">

                            <script type="text/javascript">
                                function categoryNameIndexChanged(sender, args) {
                                    var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                    tableView.filter("categoryName", args.get_item().get_value(), "EqualTo");
                                }
                            </script>

                        </telerik:RadScriptBlock>

                    </FilterTemplate>

                </telerik:GridBoundColumn>

                <%--<telerik:GridTemplateColumn HeaderText="# of Events" AllowFiltering="false">
                    <ItemTemplate>
                        <asp:Label ID="EventsCountLabel" runat="server"  />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>--%>
                
                
                <%--<telerik:GridTemplateColumn HeaderText="Active" DataField="active" UniqueName="active" SortExpression="active" AllowFiltering="false">
                <ItemStyle Width="100px" />
                <ItemTemplate>
                    <asp:LinkButton ID="BtnActive" runat="server" CommandName="SetActive" ForeColor="White">
                        <asp:Label ID="ActiveLabel" runat="server" />
                    </asp:LinkButton>
                </ItemTemplate>
            </telerik:GridTemplateColumn>--%>                            

            </Columns>


            

        </MasterTableView>
    </telerik:RadGrid>

    <asp:Label ID="msgLabel" runat="server" />

</telerik:RadAjaxPanel>

<asp:LinqDataSource ID="getCategoriesList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="categoryName" TableName="tblBrandCategories" EnableDelete="True" EnableInsert="True" EnableUpdate="True" Where="clientID == @clientID">
    <WhereParameters>
        <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
    </WhereParameters>
</asp:LinqDataSource>


<%--<asp:LinqDataSource ID="getTeams" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="teamName" TableName="tblTeams" EnableDelete="True" EnableInsert="True" EnableUpdate="True"></asp:LinqDataSource>

<asp:SqlDataSource ID="getTeamsList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT DISTINCT teamName FROM tblTeam"></asp:SqlDataSource>--%>

<script type="text/javascript">
    function requestStart(sender, args) {
        if (args.get_eventTarget().indexOf("btnExport") >= 0) {
            args.set_enableAjax(false);
        }
    }
</script>

