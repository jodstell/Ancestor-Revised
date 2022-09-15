<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EventTypeControl.ascx.vb" Inherits="EventManagerApplication.EventTypeControl" %>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server"  ClientEvents-OnRequestStart="requestStart">

    <telerik:RadGrid ID="EventTypeList" runat="server" DataSourceID="getEventTypebyClientList"
        AllowSorting="True"
        AllowPaging="True"
        GroupPanelPosition="Top"
        ShowFooter="True"
        ShowStatusBar="true"
        AllowCustomPaging="True"
        Skin="Bootstrap"
        AllowFilteringByColumn="True"
        CellSpacing="-1"
        PageSize="20">

        <PagerStyle Position="TopAndBottom" />

        <MasterTableView AutoGenerateColumns="False" DataKeyNames="eventTypeID" CommandItemDisplay="Top" DataSourceID="getEventTypebyClientList">

            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <CommandItemTemplate>
                <div style="padding: 3px 0 3px 5px">
                    <asp:LinkButton ID="btnAddNew" runat="server" CommandName="AddNew" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Event Type</asp:LinkButton>
                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                    <div class="pull-right" style="padding-right: 3px">
                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                    </div>
            </CommandItemTemplate>

            <Columns>

                <telerik:GridTemplateColumn AllowFiltering="false">
                    <ItemStyle Width="75px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn DataField="eventTypeName"
                    FilterControlAltText="Filter eventTypeName column"
                    HeaderText="Name"
                    SortExpression="eventTypeName"
                    UniqueName="eventTypeName">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>

                    <FilterTemplate>

                        <telerik:RadComboBox ID="RadComboBox_eventTypeName" DataSourceID="getEventTypeList" DataTextField="eventTypeName" AllowCustomText="true" MarkFirstMatch="true"
                            DataValueField="eventTypeName" Height="200px" Width="320px" AppendDataBoundItems="true"
                            SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("eventTypeName").CurrentFilterValue%>'
                            runat="server" OnClientSelectedIndexChanged="eventTypeNameIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="All" />
                            </Items>
                        </telerik:RadComboBox>

                        <telerik:RadScriptBlock ID="RadScriptBlock_eventTypeName" runat="server">

                            <script type="text/javascript">
                                function eventTypeNameIndexChanged(sender, args) {
                                    var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                    tableView.filter("eventTypeName", args.get_item().get_value(), "EqualTo");
                                }
                            </script>

                        </telerik:RadScriptBlock>

                    </FilterTemplate>

                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn HeaderText="# of Events" AllowFiltering="false">
                    <ItemTemplate>
                        <asp:Label ID="EventCountLabel" runat="server" Text="Label" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>


                <telerik:GridTemplateColumn HeaderText="Active" AllowFiltering="false">
                    <ItemStyle Width="100px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="BtnActive" runat="server" CommandName="SetActive" CommandArgument='<%# Eval("eventTypeID") %>' ForeColor="White">
                            <asp:Label ID="ActiveLabel" runat="server" />
                        </asp:LinkButton>
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

<asp:LinqDataSource runat="server" EntityTypeName="" ID="getEventTypebyClientList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="eventTypeName" TableName="tblEventTypes">
    </asp:LinqDataSource>

    <asp:SqlDataSource ID="getEventTypeList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT eventTypeName FROM tblEventType"
        runat="server">
        
    </asp:SqlDataSource>