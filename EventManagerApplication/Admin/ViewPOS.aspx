<%@ Page Title="POS/Logistics" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewPOS.aspx.vb" Inherits="EventManagerApplication.ViewPOS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

        .windowcss {
            overflow: hidden !important;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="HiddenUserID" runat="server" />

    <link href="../Theme/css/custom.css" rel="stylesheet" />

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script>
            // close the div in 5 secs
            window.setTimeout("closeDiv();", 3000);

            function closeDiv() {
                // jQuery version
                $("#messageHolder").fadeOut("slow", null);
            }

        </script>

    </telerik:RadScriptBlock>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= InventoryList.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("/Admin/EditPOSItems.aspx?itemID=" + id, "UserListDialog");
                return false;
            }

            function ShowInsertForm() {
                window.radopen("AddPOSItems.aspx", "RadWindow1");
                return false;
            }

            function ShowRecieveForm() {
                window.radopen("RecieveItems.aspx", "UserListDialog");
                return false;
            }


            function ShowRecieveForm2(id, rowIndex) {
                var grid = $find("<%= InventoryList.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("/Admin/RecieveItems.aspx?itemID=" + id, "UserListDialog");
                return false;
            }

            function ShowUpdateInventoryCountForm(id, rowIndex) {
                var grid = $find("<%= InventoryList.ClientID %>");

                            var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                            grid.get_masterTableView().selectItem(rowControl, true);

                            window.radopen("/Admin/UpdateInventoryCount.aspx?itemID=" + id, "UserListDialog");
                            return false;
                        }

            
            function refreshGrid(arg) {
                if (!arg) {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("Rebind");
                }
                else {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("RebindAndNavigate");
                }
            }
                //function RowDblClick(sender, eventArgs) {
                //    window.radopen("EditPOSItems.ascx?itemID=" + eventArgs.getDataKeyValue("itemID"), "UserListDialog");
                //}
        </script>
    </telerik:RadCodeBlock>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>
        </div>
    </div>

        <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="posKitsList" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>



    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="requestStart">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="InventoryList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="InventoryList" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap">
    </telerik:RadAjaxLoadingPanel>

    <asp:Panel ID="Panel1" runat="server">

        <div class="container min-height">
            <div class="row">
                <div class="col-xs-12">
                    <h2>POS & Logistics</h2>
                    <ol class="breadcrumb">
                        <li><a href="/">Dashboard</a></li>
                        <li class="active">POS/Logistics</li>
                    </ol>
                </div>
            </div>


            <div class="row">
                <div class="col-md-12">
                    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" AutoPostBack="false" MultiPageID="RadMultiPage1" SelectedIndex="0" Skin="Bootstrap">
                        <Tabs>
                            <telerik:RadTab Text="POS Kits" runat="server" ID="activeTab"></telerik:RadTab>
                            <telerik:RadTab Text="Inventory" runat="server" ID="pendingTab"></telerik:RadTab>

                        </Tabs>
                    </telerik:RadTabStrip>

                    <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0">
                        <telerik:RadPageView runat="server" ID="RadPageView1">
                            <!-- Active Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <telerik:RadGrid ID="posKitsList" runat="server" DataSourceID="getPosKitsByUserID"
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
                                        OnFilterCheckListItemsRequested="posKitsList_FilterCheckListItemsRequested">

                                        <PagerStyle Position="TopAndBottom" />

                                        <MasterTableView DataKeyNames="kitID" DataSourceID="getPosKitsByUserID" CommandItemDisplay="Top" AutoGenerateColumns="false">

                                            <NoRecordsTemplate>

                                                <br />
                                                <div class="col-md-12">
                                                    <div class="alert alert-warning" role="alert"><strong>No POS Kits Found.</strong>  Please adjust your filter options.</div>
                                                </div>

                                            </NoRecordsTemplate>

                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>

                                            <CommandItemTemplate>
                                                <div style="padding: 3px 0 3px 5px">
                                                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>


                                                    <div class="pull-right" style="padding-right: 3px">
                                                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White" Visible="false"><i class="fa fa-download"></i> Export to Excel</asp:LinkButton>
                                                    </div>

                                                </div>
                                            </CommandItemTemplate>

                                            <Columns>

                                                <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewButton">
                                                    <ItemStyle Width="75px" />
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnEditKit" runat="server" CommandName="EditKit" CommandArgument='<%# Eval("kitID")%>' CssClass="btn btn-primary btn-xs" ForeColor="White">View &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton><br />

                                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("labelText") %>' Font-Size="X-Small"></asp:Label>


                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>




                                                <telerik:GridTemplateColumn DataField="eventID" HeaderText="Event ID" SortExpression="eventID" UniqueName="eventID" DataType="System.Int32" FilterControlAltText="Filter eventID column"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                    <ItemTemplate>
                                                        <%# Eval("eventID") %> <a href="/events/eventdetails?ID=<%# Eval("eventID") %>" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn DataField="eventID" Visible="false"
                                                    FilterControlAltText="Filter eventID column"
                                                    HeaderText="Event ID"
                                                    SortExpression="eventID" UniqueName="eventIDExcel"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    FilterCheckListEnableLoadOnDemand="true">
                                                </telerik:GridBoundColumn>



                                                <telerik:GridTemplateColumn AllowFiltering="true" ShowFilterIcon="false" CurrentFilterFunction="EqualTo"
                                                    DataField="eventDate"
                                                    UniqueName="eventDate"
                                                    HeaderText="Event Date"
                                                    SortExpression="eventDate">
                                                    <ItemStyle  Wrap="false"/>
                                                    <ItemTemplate>
                                                        <%# Eval("eventDate", "{0:d}") %> <%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn AllowFiltering="true" ShowFilterIcon="false" CurrentFilterFunction="EqualTo"
                                                    DataField="createdDate"
                                                    UniqueName="createdDate"
                                                    HeaderText="Requested Date"
                                                    SortExpression="createdDate">
                                                    <ItemStyle  Wrap="false"/>
                                                    <ItemTemplate>
                                                        <%# Eval("createdDate", "{0:d}") %>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>


                                                <telerik:GridBoundColumn DataField="supplierName" HeaderText="Supplier" SortExpression="supplierName" UniqueName="supplierName" FilterControlAltText="Filter supplierName column"></telerik:GridBoundColumn>


                                                <telerik:GridBoundColumn DataField="accountName" HeaderText="Account" SortExpression="accountName" UniqueName="accountName" FilterControlAltText="Filter accountName column"></telerik:GridBoundColumn>


                                                <%--<telerik:GridBoundColumn DataField="brands" HeaderText="Brands" SortExpression="brands" UniqueName="brands" FilterControlAltText="Filter brands column">
                                                    <ItemStyle Width="200px" />
                                                </telerik:GridBoundColumn>--%>


                                                <telerik:GridBoundColumn DataField="status" HeaderText="Status" SortExpression="status" UniqueName="status" FilterControlAltText="Filter status column">
                                                    <ItemStyle Width="100px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridDateTimeColumn DataField="shippedDate" HeaderText="Shipped Date" SortExpression="shippedDate" UniqueName="shippedDate" DataType="System.DateTime" FilterControlAltText="Filter shippedDate column"
                                                     DataFormatString="{0:M/d/yyyy}" ></telerik:GridDateTimeColumn>

                                                <telerik:GridBoundColumn DataField="shippingVendorName" HeaderText="Shipped By" SortExpression="shippedBy" UniqueName="shippedBy" FilterControlAltText="Filter shippedBy column"></telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="shippingMethodTitle" HeaderText="Shipped Type" SortExpression="shippingMethodTitle" UniqueName="shippingMethodTitle" FilterControlAltText="Filter shippingMethodTitle column"></telerik:GridBoundColumn>



                                                <telerik:GridTemplateColumn DataField="trackingNumber" HeaderText="Tracking Number" SortExpression="trackingNumber" UniqueName="trackingNumber"  
                                                    FilterControlAltText="Filter trackingNumber column" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                    <ItemTemplate>
                                                        <%# getTrackingLink(Eval("kitID")) %>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>


                                                <telerik:GridTemplateColumn DataField="trackingNumber" HeaderText="Tracking Number" SortExpression="trackingNumber" UniqueName="trackingNumberExcel"  
                                                    FilterControlAltText="Filter trackingNumber column" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" Visible="false">
                                                    <ItemTemplate>
                                                        <%# getTrackingLinkNoLinks(Eval("kitID")) %>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>


                                            </Columns>
                                        </MasterTableView>

                                    </telerik:RadGrid>

                                    <asp:SqlDataSource ID="getPosKitsByUserID" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getPosKitsByUserIDAndClientID" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                <asp:ControlParameter ControlID="HiddenUserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                                </div>
                                </div>
                            </telerik:RadPageView>

                         <telerik:RadPageView runat="server" ID="RadPageView2">
                            <!-- Active Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <telerik:RadGrid ID="InventoryList" runat="server"  DataSourceID="getInventoryList" AllowAutomaticDeletes="True"
                                        AllowPaging="True"
                                        AllowSorting="True"
                                        ShowFooter="True"
                                        ShowStatusBar="true"
                                        AllowFilteringByColumn="True"
                                        PageSize="10"
                                        CellSpacing="-1" GroupPanelPosition="Top"
                                        FilterType="HeaderContext"
                                        EnableHeaderContextMenu="true"
                                        EnableHeaderContextFilterMenu="true"
                                        OnFilterCheckListItemsRequested="InventoryList_FilterCheckListItemsRequested"
                                        AllowAutomaticUpdates="True"
                                        AllowAutomaticInserts="True"
                                        OnItemCreated="InventoryList_ItemCreated">

                                        <PagerStyle Position="TopAndBottom" />

                                        <MasterTableView DataKeyNames="itemID" DataSourceID="getInventoryList" AutoGenerateColumns="False" CommandItemDisplay="Top">

                                            <NoRecordsTemplate>

                                            <br />
                                            <div class="col-md-12">
                                                <div class="alert alert-warning" role="alert"><strong>No Inventory Items Found.</strong>  Please adjust your filter options.</div>
                                            </div>

                                        </NoRecordsTemplate>

                                        <RowIndicatorColumn>
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </RowIndicatorColumn>

                                            <CommandItemTemplate>
                                                <div style="padding: 3px 0 3px 5px">
                                                    <asp:LoginView ID="LoginView1" runat="server">
                                                        <RoleGroups>
                                                            <asp:RoleGroup Roles="Administrator, EventManager">
                                                                <ContentTemplate>
                                                    <%--<asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-sm btn-success" ForeColor="White" CommandName="InitInsert"><i class="fa fa-plus"></i> Add New Item</asp:LinkButton>--%>
                                                    <a href="#" onclick="return ShowInsertForm();" class="btn btn-sm btn-success" style="color: white;"><i class="fa fa-plus"></i> Add New Record</a>
                                                    <%--<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-sm btn-primary" ForeColor="White"><i class="fa fa-plus"></i> Recieve Inventory Item</asp:LinkButton>--%>
                                                    <a href="#" onclick="return ShowRecieveForm();" class="btn btn-sm btn-primary" style="color: white;"><i class="fa fa-plus"></i> Receive  Inventory Item</a>
                                                                </ContentTemplate>
                                                            </asp:RoleGroup>
                                                        </RoleGroups>
                                                    </asp:LoginView>
                                                     
                                                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                                    <div class="pull-right" style="padding-right: 3px">
                                                        <asp:LinkButton ID="btnExport2" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export to Excel</asp:LinkButton>
                                                        </div>
                                                </div>
                                            </CommandItemTemplate>

                                            <Columns>

                        <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewButton">
                            <ItemStyle Width="75px" />
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black" CommandName="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                                
                                <%--<asp:HyperLink ID="EditLink" runat="server" Text="Edit"></asp:HyperLink>--%>
                                <div style="margin-top:5px;">
                                <asp:LinkButton ID="btnShowInventory" runat="server" CssClass="btn btn-xs btn-primary" CommandName="ShowInventory" ForeColor="White"><i class="fa fa-plus"></i> Receive Inventory</asp:LinkButton>
                                </div>
                                <%--<a href="#" onclick="return ShowRecieveForm2();" class="btn btn-sm btn-primary" style="color: white;"><i class="fa fa-plus"></i> Button</a>--%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                                                <telerik:GridBinaryImageColumn DataField="thumbnail" AllowFiltering="false" UniqueName="thumbnail">

                                                </telerik:GridBinaryImageColumn>


                                                <telerik:GridBoundColumn DataField="itemName" HeaderText="Name" SortExpression="itemName" UniqueName="itemName"
                                                    FilterControlAltText="Filter itemName column"
                                                    AutoPostBackOnFilter="true"
                                                    CurrentFilterFunction="EqualTo"
                                                    ShowFilterIcon="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="BrandName" HeaderText="Brand" SortExpression="BrandName" UniqueName="BrandName" DataType="System.String"         FilterControlAltText="Filter BrandName column"
                                                FilterCheckListEnableLoadOnDemand="true">
                                                    <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                                </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="SupplierName" HeaderText="Supplier" SortExpression="SupplierName" UniqueName="SupplierName" DataType="System.String"         FilterControlAltText="Filter SupplierName column"
                                                FilterCheckListEnableLoadOnDemand="true">
                                                    <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                                </telerik:GridBoundColumn>

                                                <telerik:GridCheckBoxColumn DataField="inGroup" HeaderText="Group Item" SortExpression="inGroup" UniqueName="inGroup" DataType="System.Byte" FilterControlAltText="Filter inGroup column"></telerik:GridCheckBoxColumn>

                                                <telerik:GridBoundColumn DataField="retailPrice" HeaderText="Retail Price" SortExpression="retailPrice" UniqueName="retailPrice" DataType="System.Double" FilterControlAltText="Filter retailPrice column"></telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="packageSize" HeaderText="Package Size" SortExpression="packageSize" UniqueName="packageSize" DataType="System.Int32" FilterControlAltText="Filter packageSize column"></telerik:GridBoundColumn>

                                                  <telerik:GridBoundColumn DataField="unitsInKit" HeaderText="Units in Kit" SortExpression="unitsInKit" UniqueName="unitsInKit" DataType="System.Int32" FilterControlAltText="Filter unitsInKit column"></telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn Visible="false" DataField="QtyonHand" HeaderText="Qty on Hand" SortExpression="QtyonHand" UniqueName="QtyonHand" DataType="System.Int32" FilterControlAltText="Filter QtyonHand column"></telerik:GridBoundColumn>

                                                <telerik:GridTemplateColumn DataField="QtyonHand" HeaderText="Qty on Hand" SortExpression="QtyonHand" UniqueName="QtyonHandTemplate" DataType="System.Int32" FilterControlAltText="Filter QtyonHand column">
                                                    <ItemTemplate><%# Eval("QtyonHand") %> <asp:LinkButton ID="btnChangeQty" CssClass="pull-right" CommandName="ShowInventory" runat="server" Visible="true"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></asp:LinkButton></ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                 <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="DeleteButton">
                                                    <ItemStyle Width="75px" />
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnEditKit" runat="server" CommandName="Delete"  CssClass="btn btn-danger btn-xs" ForeColor="White"
                                                            OnClientClick="javascript:if(!confirm('This action will delete the selected inventory item. Are you sure?')){return false;}"><i class="fa fa-trash"></i>&nbsp;&nbsp;Delete</asp:LinkButton><br />

                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>

                                        </MasterTableView>



        <ClientSettings>
            <%--<Selecting AllowRowSelect="true"></Selecting>--%>
            <%--<ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>--%>
        </ClientSettings>

                                    </telerik:RadGrid>

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


                                    <asp:SqlDataSource runat="server" ID="getInventoryList" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                                        SelectCommand="getInventoryListByUserIDAndClientID" SelectCommandType="StoredProcedure" DeleteCommand="DELETE FROM tblInventoryItem WHERE (itemID = @itemID)">

                                        <SelectParameters>
                                            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>

                                <asp:ControlParameter ControlID="HiddenUserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                            </SelectParameters>

                                        <DeleteParameters>
                                            <asp:Parameter Name="itemID"></asp:Parameter>
                                        </DeleteParameters>

                                    </asp:SqlDataSource>
                                </div>
                                </div>
                            </telerik:RadPageView>

                        </telerik:RadMultiPage>

                    </div>

                </div>
            </div>

        </asp:Panel>

     <script type="text/javascript">
         $('#pos').addClass('active');

         function requestStart(sender, args) {
             if (args.get_eventTarget().indexOf("btnExport") > 0 ||
             args.get_eventTarget().indexOf("btnExport") > 0)
                 args.set_enableAjax(false);

             if (args.get_eventTarget().indexOf("btnExport2") > 0 ||
             args.get_eventTarget().indexOf("btnExport2") > 0)
                 args.set_enableAjax(false);
         }

    </script>

</asp:Content>
