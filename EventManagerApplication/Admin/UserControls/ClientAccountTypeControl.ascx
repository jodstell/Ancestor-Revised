<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ClientAccountTypeControl.ascx.vb" Inherits="EventManagerApplication.ClientAccountTypeControl" %>


<telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">

            function ShowEditForm2(id, rowIndex) {
                var grid = $find("<%= AccountTypeList.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("/Admin/EditAccountType.aspx?itemID=" + id, "UserListDialog");
                return false;
            }

            function ShowInsertForm2() {
                window.radopen("AddAccountType.aspx", "RadWindow1");
                return false;
            }

            <%--function refreshGrid2(arg) {
                if (!arg) {
                    $find("<%= RadAjaxPanel1.ClientID %>").ajaxRequest("Rebind");
                }
                else {
                    $find("<%= RadAjaxPanel1.ClientID %>").ajaxRequest("RebindAndNavigate");
                }
            }--%>
               
        </script>
    </telerik:RadCodeBlock>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server"  ClientEvents-OnRequestStart="requestStart">
    

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
        OnItemCreated="AccountTypeList_ItemCreated">

        <PagerStyle Position="TopAndBottom" />

        <MasterTableView AutoGenerateColumns="False" DataKeyNames="accountTypeID" CommandItemDisplay="Top" DataSourceID="getAccountType">

            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <CommandItemTemplate>
                <div style="padding: 3px 0 3px 5px">
                    <%--<asp:LinkButton ID="btnAddNew" runat="server" CommandName="AddNew" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Account Type</asp:LinkButton>--%>
                    <a href="#" onclick="return ShowInsertForm2();" class="btn btn-sm btn-success" style="color: white;"><i class="fa fa-plus"></i> Add New Account Type</a>

                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                    <div class="pull-right" style="padding-right: 3px">
                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                    </div>
            </CommandItemTemplate>

            <Columns>

                <telerik:GridTemplateColumn AllowFiltering="false">
                    <ItemStyle Width="75px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black" CommandName="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn DataField="accountTypeName"
                    FilterControlAltText="Filter activityName column"
                    HeaderText="Name"
                    SortExpression="accountTypeName"
                    UniqueName="accountTypeName">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>

                    <FilterTemplate>

                        <telerik:RadComboBox ID="RadComboBox_accountTypeName" DataSourceID="getaccountTypeList" DataTextField="accountTypeName"
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

                <telerik:GridCheckBoxColumn EditFormColumnIndex="1" UniqueName="GridCheckBoxColumn" DataField="active" HeaderText="Globally Active" AllowFiltering="false">
                </telerik:GridCheckBoxColumn>

                <telerik:GridTemplateColumn HeaderText="# of Accounts" AllowFiltering="false">
                    <ItemTemplate>
                        <asp:Label ID="AccountCountLabel" runat="server" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

              
                <telerik:GridTemplateColumn HeaderText="Active" AllowFiltering="false">
                    <ItemStyle Width="100px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="BtnActive" runat="server" CommandName="SetActive" CommandArgument='<%# Eval("accountTypeID") %>' ForeColor="White">
                            <asp:Label ID="ActiveLabel" runat="server" />
                        </asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-xs btn-danger" ForeColor="White"
                                OnClientClick="javascript:if(!confirm('This action will delete the selected activity type for All clients. Are you sure?')){return false;}"><i class="fa fa-trash" aria-hidden="true"></i> Delete</asp:LinkButton>
                        </ItemTemplate>
                </telerik:GridTemplateColumn>

            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

<asp:Label ID="msgLabel" runat="server" />
    
</telerik:RadAjaxPanel>



<script type="text/javascript">
    function requestStart(sender, args) {
        if (args.get_eventTarget().indexOf("btnExport") >= 0) {
            args.set_enableAjax(false);
        }
    }


</script>

    <asp:LinqDataSource ID="getAccountType" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblAccountTypes" OrderBy="accountTypeName"></asp:LinqDataSource>


    <asp:SqlDataSource ID="getAccountTypeList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT accountTypeName FROM tblAccountType"
        runat="server">
        
    </asp:SqlDataSource>