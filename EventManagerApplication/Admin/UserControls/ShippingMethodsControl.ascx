<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ShippingMethodsControl.ascx.vb" Inherits="EventManagerApplication.ShippingMethodsControl" %>

<telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server"  ClientEvents-OnRequestStart="requestStart">

    <telerik:RadGrid ID="ShippingMethodList" runat="server" DataSourceID="getShippingMethodList"
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



        <MasterTableView DataKeyNames="shippingMethodID" DataSourceID="getShippingMethodList" AutoGenerateColumns="False" CommandItemDisplay="Top">
            <Columns>
               <%-- <telerik:GridBoundColumn DataField="shippingMethodID" ReadOnly="True" HeaderText="shippingMethodID" SortExpression="shippingMethodID" UniqueName="shippingMethodID" DataType="System.Int32" FilterControlAltText="Filter shippingMethodID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="shippingMethodTitle" HeaderText="shippingMethodTitle" SortExpression="shippingMethodTitle" UniqueName="shippingMethodTitle" FilterControlAltText="Filter shippingMethodTitle column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="shippingVendorID" HeaderText="shippingVendorID" SortExpression="shippingVendorID" UniqueName="shippingVendorID" DataType="System.Int32" FilterControlAltText="Filter shippingVendorID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="clientID" HeaderText="clientID" SortExpression="clientID" UniqueName="clientID" DataType="System.Int32" FilterControlAltText="Filter clientID column"></telerik:GridBoundColumn>--%>
            </Columns>
        </MasterTableView>

        <PagerStyle Position="TopAndBottom" />

        <MasterTableView AutoGenerateColumns="False" DataKeyNames="shippingMethodID" CommandItemDisplay="Top" DataSourceID="getShippingMethodList">

            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <CommandItemTemplate>
                <div style="padding: 3px 0 3px 5px">
                    <asp:LinkButton ID="btnAddNew" runat="server" CommandName="InitInsert" CssClass="btn btn-success btn-sm" ForeColor="White"
                        Visible='<%# Not ShippingMethodList.MasterTableView.IsItemInserted %>'> <i class="fa fa-plus"></i> Add New Shipping Method</asp:LinkButton>
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
                            CommandName="Edit" CommandArgument='<%# Eval("shippingMethodID") %>'><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn DataField="shippingMethodTitle"
                    FilterControlAltText="Filter shippingMethodTitle column"
                    HeaderText="Title"
                    SortExpression="shippingMethodTitle"
                    UniqueName="shippingMethodTitle">

                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>

                   <%-- <FilterTemplate>

                        <telerik:RadComboBox ID="RadComboBox_teamName" DataSourceID="getShippingMethodList" DataTextField="shippingMethodTitle" AllowCustomText="true" MarkFirstMatch="true"
                            DataValueField="shippingMethodTitle" Height="200px" Width="320px" AppendDataBoundItems="true"
                            SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("shippingMethodTitle").CurrentFilterValue%>'
                            runat="server" OnClientSelectedIndexChanged="teamNameIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="All" />
                            </Items>
                        </telerik:RadComboBox>

                        <telerik:RadScriptBlock ID="RadScriptBlock_shippingMethodTitle" runat="server">

                            <script type="text/javascript">
                                function shippingMethodTitleIndexChanged(sender, args) {
                                    var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                    tableView.filter("shippingMethodTitle", args.get_item().get_value(), "EqualTo");
                                }
                            </script>

                        </telerik:RadScriptBlock>

                    </FilterTemplate>--%>

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

<asp:LinqDataSource ID="getShippingMethodList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="shippingMethodTitle" TableName="tblShippingMethods" EnableDelete="True" EnableInsert="True" EnableUpdate="True" Where="clientID == @clientID">
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
