<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ClientMarketControl.ascx.vb" Inherits="EventManagerApplication.ClientMarketControl" %>


<style type="text/css">
    div.RadListBox .rlbTransferTo,
    div.RadListBox .rlbTransferToDisabled,
    div.RadListBox .rlbTransferAllToDisabled,
    div.RadListBox .rlbTransferAllTo {
        display: none;
    }

    .title {
        font-size: 14px;
        padding-bottom: 0px;
    }

    .list-containers .list-container {
        text-align: left;
        display: inline-block;
        vertical-align: top;
    }

    .background-silk .demo-container {
        background-color: #F3F3F3;
    }

    .list-container.size-thin {
        max-width: 380px;
    }

    .list-container {
        margin: 0px auto;
        padding: 10px;
        border: 1px solid #E2E4E7;
        background-color: #F5F7F8;
    }
</style>


<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= MarketList.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("/Admin/EditMarket.aspx?MarketID=" + id, "UserListDialog");
                return false;
            }

            function ShowInsertForm() {
                window.radopen("AddNewMarket.aspx", "RadWindow1");
                return false;
            }

            function refreshGrid(arg) {
                if (!arg) {
                    $find("<%= RadAjaxPanel.ClientID %>").ajaxRequest("Rebind");
                }
                else {
                    $find("<%= RadAjaxPanel.ClientID %>").ajaxRequest("RebindAndNavigate");
                }
            }
               
        </script>
    </telerik:RadCodeBlock>



<telerik:RadAjaxPanel ID="RadAjaxPanel" runat="server" ClientEvents-OnRequestStart="requestStart" OnAjaxRequest="RadAjaxManager1_AjaxRequest">

    <asp:Label ID="msgLabel" runat="server" />

    <telerik:RadGrid ID="MarketList" runat="server" DataSourceID="getMarketNameList"
        AllowSorting="True"
        ShowFooter="True"
        ShowStatusBar="true"
        AllowFilteringByColumn="True"
        CellSpacing="-1"
        Skin="Bootstrap"
        AllowAutomaticInserts="true"
        AllowAutomaticUpdates="true"
        OnItemCreated="MarketList_ItemCreated">

        <PagerStyle Position="TopAndBottom" />

        <MasterTableView AutoGenerateColumns="False" DataKeyNames="marketID" DataSourceID="getMarketNameList" CommandItemDisplay="Top">

            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <CommandItemTemplate>
                <div style="padding: 3px 0 3px 5px">    
                    <%--<asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-success btn-sm" ForeColor="White" CommandName="AddNew"><i class="fa fa-plus"></i>Add New Market</asp:LinkButton>--%>
                    <a href="#" onclick="return ShowInsertForm();" class="btn btn-sm btn-success" style="color: white;"><i class="fa fa-plus"></i> Add New Market</a>
                                    
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
                
                <telerik:GridBoundColumn DataField="marketName"
                    FilterControlAltText="Filter marketName column"
                    HeaderText="Market Name"
                    SortExpression="marketName"
                    UniqueName="marketName">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>

                </telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="Region"
                    FilterControlAltText="Filter Region column"
                    HeaderText="Region"
                    SortExpression="Region"
                    UniqueName="Region">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>

                </telerik:GridBoundColumn>
                
                <telerik:GridTemplateColumn HeaderText="Active" DataField="active" AllowFiltering="false">
                    <ItemStyle Width="100px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="BtnActive" runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("marketID") %>' ForeColor="White">
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

    <asp:SqlDataSource ID="getMarketNameList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT tblClientMarket.marketID, tblMarket.marketName FROM tblClientMarket INNER JOIN tblMarket ON tblClientMarket.marketID = tblMarket.marketID WHERE (tblClientMarket.clientID = @clientID) ORDER BY tblMarket.marketName">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>




     <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" >
        <Windows>
            <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Height="650px"
                Width="1050px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" CssClass="windowcss" VisibleStatusbar="false" Behaviors="Close" AutoSizeBehaviors="Height, Width">
            </telerik:RadWindow>
            <telerik:RadWindow RenderMode="Lightweight" ID="RadWindow1" runat="server" Height="700px"
                Width="1050px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" CssClass="windowcss" VisibleStatusbar="false" Behaviors="Resize, Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>




</telerik:RadAjaxPanel>

<script type="text/javascript">
    function requestStart(sender, args) {
        if (args.get_eventTarget().indexOf("btnExport") >= 0) {
            args.set_enableAjax(false);
        }
    }


</script>
