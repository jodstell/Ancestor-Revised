<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandGroupsControl.ascx.vb" Inherits="EventManagerApplication.BrandGroupsControl" %>

<telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server"  ClientEvents-OnRequestStart="requestStart">

    <telerik:RadGrid ID="BrandGroupList" runat="server" DataSourceID="getBrandGroup"
        AllowSorting="True"
        AllowPaging="True"
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

        <MasterTableView AutoGenerateColumns="False" DataKeyNames="brandGroupID" CommandItemDisplay="Top" DataSourceID="getBrandGroup">

            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <CommandItemTemplate>
                <div style="padding: 3px 0 3px 5px">
                    <asp:LinkButton ID="btnAddNew" runat="server" CommandName="InitInsert" CssClass="btn btn-success btn-sm" ForeColor="White" Visible='<%# Not BrandGroupList.MasterTableView.IsItemInserted %>'> <i class="fa fa-plus"></i> Add New Brand Group</asp:LinkButton>
                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                    <div class="pull-right" style="padding-right: 3px">
                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i>Export CSV</asp:LinkButton>
                    </div>
            </CommandItemTemplate>

            <Columns>

                <telerik:GridTemplateColumn AllowFiltering="false">
                    <ItemStyle Width="75px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black" CommandName="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn DataField="brandGroupName"
                    FilterControlAltText="Filter brandGroupName column"
                    HeaderText="Group Name"
                    SortExpression="brandGroupName"
                    UniqueName="brandGroupName">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>

                    <FilterTemplate>

                        <telerik:RadComboBox ID="RadComboBox_brandGroupName" DataSourceID="getBrandGroupList" DataTextField="brandGroupName" AllowCustomText="true" MarkFirstMatch="true"
                            DataValueField="brandGroupName" Height="200px" Width="320px" AppendDataBoundItems="true"
                            SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("brandGroupName").CurrentFilterValue%>'
                            runat="server" OnClientSelectedIndexChanged="brandGroupNameIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="All" />
                            </Items>
                        </telerik:RadComboBox>

                        <telerik:RadScriptBlock ID="RadScriptBlock_brandGroupName" runat="server">

                            <script type="text/javascript">
                                function brandGroupNameIndexChanged(sender, args) {
                                    var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                    tableView.filter("brandGroupName", args.get_item().get_value(), "EqualTo");
                                }
                            </script>

                        </telerik:RadScriptBlock>

                    </FilterTemplate>

                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn HeaderText="# of Brands" AllowFiltering="false">
                    <ItemTemplate>
                        <asp:Label ID="BrandCountLabel" runat="server" Text='<%# getBrandGroupCount(Eval("brandGroupID")) %>' />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>


                <telerik:GridTemplateColumn AllowFiltering="false">
                    <ItemStyle Width="75px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-xs btn-danger" ForeColor="White" CommandName="Delete" OnClientClick="javascript:if(!confirm('This action will delete the selected brand group and remove it. Are you sure?')){return false;}"> Delete</asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

            </Columns>


        </MasterTableView>
    </telerik:RadGrid>

    <asp:Label ID="msgLabel" runat="server" />

</telerik:RadAjaxPanel>


<asp:LinqDataSource runat="server" EntityTypeName="" ID="getBrandGroup" ContextTypeName="EventManagerApplication.DataClassesDataContext"
    OrderBy="brandGroupName" TableName="qryGetBrandGroupsByClientIDs" EnableDelete="True" EnableInsert="True" EnableUpdate="True" Where="clientID == @clientID">
    <WhereParameters>
        <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
    </WhereParameters>
</asp:LinqDataSource>


    <asp:SqlDataSource ID="getBrandGroupList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT brandGroupName FROM tblBrandGroup"
        runat="server">
    </asp:SqlDataSource>


<script type="text/javascript">
    function requestStart(sender, args) {
        if (args.get_eventTarget().indexOf("btnExport") >= 0) {
            args.set_enableAjax(false);
        }
    }


</script>