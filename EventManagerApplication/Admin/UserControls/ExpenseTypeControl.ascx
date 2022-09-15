<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ExpenseTypeControl.ascx.vb" Inherits="EventManagerApplication.ExpenseTypeControl" %>


<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="requestStart">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="ExpenseTypeGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ExpenseTypeGrid" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="ShippingVendorGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ShippingVendorGrid" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

</telerik:RadAjaxManager>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" BackgroundPosition="Top"></telerik:RadAjaxLoadingPanel>


        <telerik:RadGrid ID="ExpenseTypeGrid" runat="server" DataSourceID="GetExpenseTypeList" 
            AllowPaging="True"
            AllowSorting="True"
            ShowFooter="True"
            ShowStatusBar="true"
            AllowFilteringByColumn="True"
            PageSize="20"
            CellSpacing="-1"
            FilterType="HeaderContext"
            EnableHeaderContextMenu="true"
            EnableHeaderContextFilterMenu="true"
            EnableLinqExpressions="False">

            <MasterTableView DataKeyNames="expenseTypeID" DataSourceID="GetExpenseTypeList" AutoGenerateColumns="False" CommandItemDisplay="Top" AllowSorting="true">

                <NoRecordsTemplate>

                    <br />
                    <div class="col-md-12">
                        <div class="alert alert-warning" role="alert"><strong>No Events Found.</strong>  Please adjust your filter options.</div>
                    </div>

                </NoRecordsTemplate>

                <RowIndicatorColumn>
                    <HeaderStyle Width="20px"></HeaderStyle>
                </RowIndicatorColumn>

                <CommandItemTemplate>
                    <div style="padding: 3px 0 3px 5px">
                        <asp:LinkButton ID="btnAddNew" runat="server" CommandName="AddNew" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Expense Type</asp:LinkButton>
                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                        <div class="pull-right" style="padding-right: 3px">
                            <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                        </div>
                    </div>
                </CommandItemTemplate>

                <Columns>

                    <telerik:GridTemplateColumn AllowFiltering="false" EnableHeaderContextMenu="false" UniqueName="ViewButton">
                        <ItemStyle Width="75px" />
                        <ItemTemplate>

                            <asp:LinkButton ID="btnEditExpenseType" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black" CommandArgument='<%# Eval("expenseTypeID") %>' CommandName="EditExpenseType"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="expenseTypeTitle" HeaderText="Expense Type" SortExpression="expenseTypeTitle" UniqueName="expenseTypeTitle" FilterControlAltText="Filter expenseTypeTitle column" CurrentFilterFunction="Contains"></telerik:GridBoundColumn>

                    <telerik:GridCheckBoxColumn DataField="active" HeaderText="active" SortExpression="active" UniqueName="active" DataType="System.Boolean" FilterControlAltText="Filter active column"></telerik:GridCheckBoxColumn>
                </Columns>
            </MasterTableView>
            <PagerStyle Position="TopAndBottom" />
        </telerik:RadGrid>

        <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetExpenseTypeList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblExpenseTypes"></asp:LinqDataSource>

<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

<script type="text/javascript">
    function requestStart(sender, args) {
        if (args.get_eventTarget().indexOf("btnExport") >= 0) {
            args.set_enableAjax(false);
        }
    }


            function clearColumnFilter(columnName) {
                var masterTable = $find("<%= ExpenseTypeGrid.ClientID %>").get_masterTableView();
                masterTable.filter(columnName, "", Telerik.Web.UI.GridFilterFunction.NoFilter);
            }



</script>

    </telerik:RadScriptBlock>