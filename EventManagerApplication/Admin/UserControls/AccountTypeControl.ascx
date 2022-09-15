<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AccountTypeControl.ascx.vb" Inherits="EventManagerApplication.AccountTypeControl" %>

<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="requestStart">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="AccountTypeList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="AccountTypeList" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="StaffList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="StaffList" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
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
</telerik:RadAjaxManager>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" BackgroundPosition="Top"></telerik:RadAjaxLoadingPanel>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="requestStart">

<telerik:RadGrid ID="AccountTypeList" runat="server" DataSourceID="getAccountType"
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
        AllowAutomaticUpdates="True"
        AllowAutomaticInserts="True"
        OnItemCreated="RadGrid1_ItemCreated"
        OnItemInserted="RadGrid1_ItemInserted" 
        OnPreRender="RadGrid1_PreRender"
        OnInsertCommand="RadGrid1_InsertCommand">

        

        <PagerStyle Position="TopAndBottom" />

        <MasterTableView AutoGenerateColumns="False" DataKeyNames="accountTypeID" CommandItemDisplay="Top" DataSourceID="getAccountType">

            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <CommandItemTemplate>
                <div style="padding: 3px 0 3px 5px">                    
                    <asp:LinkButton ID="btnAddNew" runat="server" CssClass="btn btn-success btn-sm" ForeColor="White" CommandName="AddNew"><i class="fa fa-plus"></i>Add New Type</asp:LinkButton>
                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>                    

                <div class="pull-right" style="padding-right: 3px">
                                <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i>Export CSV</asp:LinkButton>
                            </div>
            </CommandItemTemplate>

            <Columns>

                <telerik:GridTemplateColumn AllowFiltering="false">
                    <ItemStyle Width="75px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-xs btn-default" ToolTip="Edit" ForeColor="Black"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                                
                <telerik:GridBoundColumn DataField="accountTypeName"
                    FilterControlAltText="Filter accountTypeName column"
                    HeaderText="Name"
                    SortExpression="accountTypeName"
                    UniqueName="accountTypeName">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>

                    <FilterTemplate>

                        <telerik:RadComboBox ID="RadComboBox_accountTypeName" DataSourceID="getAccountTypeList" DataTextField="accountTypeName" AllowCustomText="true" MarkFirstMatch="true"
                            DataValueField="accountTypeName" Height="200px" Width="320px" AppendDataBoundItems="true"
                            SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("accountTypeName").CurrentFilterValue%>'
                            runat="server" OnClientSelectedIndexChanged="accountTypeNameIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="All" />
                            </Items>
                        </telerik:RadComboBox>

                        <telerik:RadScriptBlock ID="RadScriptBlock_accountTypeName" runat="server">

                            <script type="text/javascript">
                                function accountTypeNameIndexChanged(sender, args) {
                                    var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                    tableView.filter("accountTypeName", args.get_item().get_value(), "EqualTo");
                                }
                            </script>

                        </telerik:RadScriptBlock>

                    </FilterTemplate>

                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn HeaderText="Active" AllowFiltering="false">                    
                    <ItemStyle Width="100px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="BtnActive" runat="server" CommandName="SetActive" CommandArgument='<%# Eval("accountTypeID")%>' ForeColor="White">
                            <asp:Label ID="ActiveLabel" runat="server" />
                        </asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                <telerik:GridTemplateColumn AllowFiltering="false">
                    <ItemStyle Width="75px" />
                    <ItemTemplate>                        
                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" 
                        ToolTip="Delete" OnClientClick="javascript:if(!confirm('This action will delete the selected account type and remove it. Are you sure?')){return false;}" ForeColor="White">Delete</asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>                             

            </Columns>


            

        </MasterTableView>
    </telerik:RadGrid>

    <asp:Label ID="msgLabel" runat="server" />

    <asp:LinqDataSource ID="getAccountType" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblAccountTypes" OrderBy="accountTypeName"></asp:LinqDataSource>

    <asp:SqlDataSource ID="getAccountTypeList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT DISTINCT accountTypeName FROM [tblAccountType]"></asp:SqlDataSource>

    </telerik:RadAjaxPanel>

<script type="text/javascript">
    function requestStart(sender, args) {
        if (args.get_eventTarget().indexOf("btnExport") >= 0) {
            args.set_enableAjax(false);
        }
    }


</script>