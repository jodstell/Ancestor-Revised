<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="BrandAmbassadorList.aspx.vb" Inherits="EventManagerApplication.BrandAmbassadorList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .RadGrid_Bootstrap .rgPagerCell .rgNumPart a {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
        }

        #ctl00_MainContent_RadWindow1_C  {
            overflow: hidden !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Theme/css/custom1.css" rel="stylesheet" />
    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="css/schedule.css" rel="stylesheet" />


    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script>
            // close the div in 5 secs    
            window.setTimeout("closeDiv();", 3000);

            function closeDiv() {
                // jQuery version        
                $("#messageHolder").fadeOut("slow", null);
            }


            ////on click calendar             
            function OnClientAppointmentClick(sender, eventArgs) {
                var apt = eventArgs.get_appointment().get_id();
                window.location.href = "/Events/EventDetails?ID=" + apt;
            }

        </script>

    </telerik:RadScriptBlock>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>
        </div>
    </div>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="ActiveGridPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="MapPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="ScehduledPaymentsGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ScehduledPaymentsGrid" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>


            <telerik:AjaxSetting AjaxControlID="PendingPaymentsRadGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PendingPaymentsRadGrid" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>




        </AjaxSettings>

    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <div class="container">

        <!--Header-->
        <div class="container min-height">
            <div class="row">
                <div class="col-xs-12">
                    <h2>Brand Ambassadors</h2>
                    <br />
                </div>
            </div>


            <div class="row">
                <div class="col-md-12">
                    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" AutoPostBack="true" MultiPageID="RadMultiPage1" SelectedIndex="0" Skin="Bootstrap">
                        <Tabs>
                            <telerik:RadTab Text="Active" runat="server" ID="activeTab"></telerik:RadTab>
                            <telerik:RadTab Text="Prospect" runat="server" ID="pendingTab"></telerik:RadTab>
                            <telerik:RadTab Text="Terminated" runat="server" ID="terminatedTab"></telerik:RadTab>
                            <telerik:RadTab Text="Calendar" runat="server" ID="calendarTab"></telerik:RadTab>
                            <telerik:RadTab Text="Payments" runat="server" ID="paymentsTab"></telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>


                    <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0" RenderSelectedPageOnly="true">
                        <telerik:RadPageView runat="server" ID="RadPageView1">
                            <!-- Active Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <asp:Panel ID="Panel1" runat="server">

                                        <asp:Panel ID="ActiveGridPanel" runat="server">

                                            <telerik:RadGrid ID="ActiveAmbassadorList" runat="server" DataSourceID="getActiveAmbassadors"
                                                AllowFilteringByColumn="True"
                                                AllowPaging="True" AllowSorting="True"
                                                AllowCustomPaging="True" PageSize="20"
                                                ShowFooter="True"
                                                FilterType="HeaderContext"
                                                EnableHeaderContextMenu="true"
                                                EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="ActiveAmbassadorList_FilterCheckListItemsRequested" CellSpacing="-1">

                                                <ExportSettings IgnorePaging="True" OpenInNewWindow="True">
                                                    <Pdf AllowAdd="True" AllowCopy="True">
                                                    </Pdf>
                                                </ExportSettings>

                                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="ambassadorID" DataSourceID="getActiveAmbassadors" CommandItemDisplay="Top"
                                                    Font-Size="10">

                                                    <NoRecordsTemplate>

                                                        <br />
                                                        <div class="col-md-12">
                                                            <div class="alert alert-warning" role="alert"><strong>No Ambassadors Found.</strong>  Please adjust your filter options.</div>
                                                        </div>

                                                    </NoRecordsTemplate>

                                                    <RowIndicatorColumn>
                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                    </RowIndicatorColumn>

                                                    <CommandItemTemplate>
                                                        <div style="padding: 3px 0 3px 5px">
                                                            <asp:LoginView ID="LoginView_AddButton" runat="server">
                                                                <RoleGroups>
                                                                    <asp:RoleGroup Roles="Administrator, Recruiter/Booking, Accounting">
                                                                        <ContentTemplate>
                                                                            <asp:LinkButton ID="btnAddNew" runat="server" PostBackUrl="AddAmbassador" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Ambassador</asp:LinkButton>
                                                                        </ContentTemplate>
                                                                    </asp:RoleGroup>
                                                                </RoleGroups>
                                                            </asp:LoginView>
                                                            <asp:LinkButton ID="btnAdvancedFilters" runat="server" OnClientClick="CreateWindowScript()" CssClass="btn btn-primary btn-sm" ForeColor="White" Visible="false"><i class="fa fa-filter"></i> Advanced Filters</asp:LinkButton>
                                                            <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>
                                                                                                                        
                                                            <div class="pull-right" style="padding-right: 3px">
                                                                <asp:LinkButton ID="btnMapView1" runat="server" CssClass="btn btn-default btn-sm" ForeColor="Black" OnClick="btnMapView1_Click"><i class="fa fa-globe"></i> Map</asp:LinkButton>
                                                                <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                                                            </div>
                                                    </CommandItemTemplate>

                                                    <Columns>

                                                        <telerik:GridTemplateColumn AllowFiltering="false" ShowFilterIcon="false">
                                                            <ItemStyle Width="40px" />
                                                            <ItemTemplate>
                                                                <a href="ViewAmbassadorDetails.aspx?UserID=<%# Eval("UserID")%>" class="btn btn-xs btn-primary" style="color: #fff">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a><br />
                                                                <asp:Label ID="updateLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("labelText")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn FilterCheckListEnableLoadOnDemand="true" DataField="UserName"
                                                            FilterControlAltText="Filter UserName column" HeaderText="User Name" SortExpression="UserName" UniqueName="UserName" AutoPostBackOnFilter="true" CurrentFilterFunction="StartsWith" HeaderStyle-Wrap="false" Visible="false">
                                                        </telerik:GridBoundColumn>



                                                        <telerik:GridBoundColumn DataField="FirstName" HeaderText="First Name" SortExpression="FirstName"
                                                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" HeaderStyle-Wrap="false" />

                                                        <telerik:GridBoundColumn DataField="LastName" HeaderText="Last Name" SortExpression="LastName"
                                                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" HeaderStyle-Wrap="false" />

                                                        <telerik:GridBoundColumn DataField="EmailAddress" HeaderText="Email" SortExpression="EmailAddress" FilterCheckListEnableLoadOnDemand="false"
                                                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />

                                                        <telerik:GridBoundColumn DataField="City" HeaderText="City" SortExpression="City"
                                                            AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" />

                                                        <telerik:GridBoundColumn DataField="State" HeaderText="State" SortExpression="State" FilterCheckListEnableLoadOnDemand="true"
                                                            AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" />

                                                        <telerik:GridBoundColumn DataField="Markets" HeaderText="Markets" SortExpression="Markets" FilterCheckListEnableLoadOnDemand="true"
                                                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />

                                                        <telerik:GridBoundColumn DataField="Positions" HeaderText="Positions" SortExpression="Positions" FilterCheckListEnableLoadOnDemand="true" ItemStyle-Wrap="false"
                                                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />



                                                        <telerik:GridTemplateColumn HeaderText="Last Login" SortExpression="LastLoginDate" AllowFiltering="false" Visible="false">
                                                            <ItemTemplate>

                                                                <asp:Label ID="Label1" runat="server" Text='<%# GetTimeAdjustment(Eval("LastLoginDate"))%>' />
                                                                <%--<%# (Eval("LastLoginDate") = DBNull.Value) : Eval("LastLoginDate")%>--%>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                    </Columns>
                                                </MasterTableView>

                                                <PagerStyle Position="TopAndBottom"></PagerStyle>

                                            </telerik:RadGrid>
                                        </asp:Panel>

                                        <asp:Panel ID="MapPanel" runat="server" Visible="false">

                                            <div class="row">
                                                <div class="col-md-12 bottommargin10">
                                                    <div class="pull-right">
                                                        <asp:LinkButton ID="btnHideMap" runat="server" CssClass="btn btn-default btn-sm"
                                                            ForeColor="Black"><i class="fa fa-th"></i> Hide Map</asp:LinkButton>
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="widget stacked">
                                                <div class="widget-content">

                                                    <%--<asp:Button ID="btnBoston" runat="server" Text="Go to Boston" CssClass="btn btn-primary" />
                                            <br />
                                            <asp:Button ID="btnBostonwithAccounts" runat="server" Text="Get Boston with Accounts" CssClass="btn btn-primary" />
                                            </div>--%>

                                                    <div class="col-md-12 filter">
                                                        <div class="col-md-4">


                                                            <div class="form-group">


                                                                <label for="MarketTextBox" class="control-label">Filter By Market:</label><br />

                                                                <telerik:RadComboBox ID="MarketRadComboBox" runat="server" EmptyMessage="Choose a Market" Width="320px" AutoPostBack="true" DataSourceID="getMarkets" DataTextField="marketName" DataValueField="marketID" MarkFirstMatch="True" AllowCustomText="True" AppendDataBoundItems="true" EnableLoadOnDemand="true">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem Text="All Markets" Value="0" Selected="true" />
                                                                    </Items>
                                                                </telerik:RadComboBox>

                                                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getMarkets" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="marketName" TableName="tblMarkets"></asp:LinqDataSource>



                                                            </div>

                                                        </div>


                                                        <div class="col-md-4 verticalLine2">
                                                            <div class="form-group">
                                                                <label for="PositionTextBox" class="control-label">Filter By Position:</label><br />

                                                                <telerik:RadComboBox ID="PositionRadComboBox" runat="server" EmptyMessage="Choose a Position" Width="320px" DataSourceID="GetPositions" DataTextField="positionTitle" DataValueField="staffingPositionID" MarkFirstMatch="True" AllowCustomText="True" AppendDataBoundItems="true" EnableLoadOnDemand="true" AutoPostBack="true">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem Text="All Positions" Value="0" Selected="true" />
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetPositions" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="positionTitle" TableName="tblStaffingPositions"></asp:LinqDataSource>



                                                            </div>
                                                        </div>



                                                        <div class="col-md-4 verticalLine">
                                                            <div class="form-horizontal">
                                                                <label class="control-label pull-left" style="padding-bottom: 10px;">Add Layer:</label>
                                                                <div class="col-sm-12">
                                                                    <asp:RadioButtonList ID="RadioButtonLayers" runat="server" OnSelectedIndexChanged="RadioButtonLayers_SelectedIndexChanged" AutoPostBack="true">
                                                                        <asp:ListItem Text="Show Accounts" Value="accounts" />
                                                                        <asp:ListItem Text="Show Scheduled Events" Value="scheduledEvents" />
                                                                    </asp:RadioButtonList>

                                                                </div>
                                                            </div>
                                                            <asp:LinkButton runat="server" ID="clrFilters" CssClass="btn btn-default btn-sm pull-right">Clear Layers</asp:LinkButton>
                                                            <div></div>


                                                            <div class="col-sm-12">
                                                                <asp:Label ID="AmbassadorCountLabel" runat="server" />
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>

                                            </div>

                                            <div class="widget stacked">
                                                <div class="widget-content">

                                                    <telerik:RadMap runat="server" ID="RadMap1" CssClass="MyMap" Skin="Bootstrap" RenderMode="Lightweight"
                                                        Width="100%" Height="500" Zoomable="true">



                                                        <DataBindings>

                                                            <MarkerBinding DataShapeField="shape" DataTitleField="FirstName"
                                                                DataLocationLatitudeField="latitude" DataLocationLongitudeField="longitude" />

                                                        </DataBindings>

                                                    </telerik:RadMap>

                                                    <asp:LinqDataSource ID="getAmbassadorList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="GetAmbassadorMaps"></asp:LinqDataSource>

                                                    <asp:LinqDataSource ID="getAmbassadorListbyMarket" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="GetAmbassadorMapbyMarketIDs" Where="marketID == @marketID">
                                                        <WhereParameters>
                                                            <asp:ControlParameter ControlID="MarketRadComboBox" PropertyName="SelectedValue" Name="marketID" Type="Int32"></asp:ControlParameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>



                                                    <asp:LinqDataSource ID="GetBostonwithAccounts" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="GetAmbassadorMapbyMarketID_withAccounts"></asp:LinqDataSource>

                                                </div>


                                            </div>


                                        </asp:Panel>
                                    </asp:Panel>
                                </div>

                            </div>
                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView2">
                            <!-- Pending Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <telerik:RadGrid ID="PendingAmbassadorsList" runat="server" DataSourceID="getPendingAmbassadors"
                                        AllowFilteringByColumn="True"
                                        AllowPaging="True" AllowSorting="True"
                                        AllowCustomPaging="True" PageSize="20"
                                        ShowFooter="True" CellSpacing="-1" GroupPanelPosition="Top"
                                        FilterType="HeaderContext"
                                        EnableHeaderContextMenu="true"
                                        EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="ActiveAmbassadorList_FilterCheckListItemsRequested">

                                        <ExportSettings IgnorePaging="True" OpenInNewWindow="True">
                                            <Pdf AllowAdd="True" AllowCopy="True">
                                            </Pdf>
                                        </ExportSettings>

                                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="ambassadorID" DataSourceID="getPendingAmbassadors" CommandItemDisplay="Top">

                                            <NoRecordsTemplate>

                                                <br />
                                                <div class="col-md-12">
                                                    <div class="alert alert-warning" role="alert"><strong>No Ambassadors Found.</strong>  Please adjust your filter options.</div>
                                                </div>

                                            </NoRecordsTemplate>

                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>

                                            <CommandItemTemplate>
                                                <div style="padding: 3px 0 3px 5px">
                                                    <asp:LoginView ID="LoginView_AddButton" runat="server">
                                                        <RoleGroups>
                                                            <asp:RoleGroup Roles="Administrator, Recruiter/Booking, Accounting">
                                                                <ContentTemplate>
                                                                    <asp:LinkButton ID="btnAddNew" runat="server" PostBackUrl="AddAmbassador" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Ambassador</asp:LinkButton>
                                                                </ContentTemplate>
                                                            </asp:RoleGroup>
                                                        </RoleGroups>
                                                    </asp:LoginView>

                                                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>
                                                                                                      

                                                    <div class="pull-right" style="padding-right: 3px">
                                                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                                                    </div>
                                            </CommandItemTemplate>

                                            <Columns>

                                                <telerik:GridTemplateColumn AllowFiltering="false" ShowFilterIcon="false">
                                                    <ItemTemplate>
                                                        <a href="ViewProspectAmbassador?UserID=<%# Eval("ambassadorID")%>" class="btn btn-xs btn-primary" style="color: #fff">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>



                                                <telerik:GridBoundColumn DataField="FirstName" HeaderText="First Name" SortExpression="FirstName"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />

                                                <telerik:GridBoundColumn DataField="LastName" HeaderText="Last Name" SortExpression="LastName"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />

                                                <telerik:GridBoundColumn DataField="EmailAddress" HeaderText="Email" SortExpression="EmailAddress" FilterCheckListEnableLoadOnDemand="false"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />

                                                <telerik:GridBoundColumn DataField="City" HeaderText="City" SortExpression="City"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" />

                                                <telerik:GridBoundColumn DataField="State" HeaderText="State" SortExpression="State" FilterCheckListEnableLoadOnDemand="true"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" />

                                                <telerik:GridTemplateColumn HeaderText="Registration Date" SortExpression="LastLoginDate" AllowFiltering="false">
                                                    <ItemTemplate>

                                                        <asp:Label ID="Label1" runat="server" Text='<%# GetTimeAdjustment(Eval("LastLoginDate"))%>' />
                                                        <%--<%# (Eval("LastLoginDate") = DBNull.Value) : Eval("LastLoginDate")%>--%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                            </Columns>
                                        </MasterTableView>

                                        <PagerStyle Position="TopAndBottom"></PagerStyle>

                                    </telerik:RadGrid>
                                </div>
                            </div>
                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView3">
                            <!-- Locked Out Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <telerik:RadGrid ID="TerminatedAmbassadorList" runat="server" DataSourceID="getTerminatedAmbassadors"
                                        AllowFilteringByColumn="True"
                                        AllowPaging="True" AllowSorting="True"
                                        AllowCustomPaging="True" PageSize="20"
                                        ShowFooter="True" CellSpacing="-1" GroupPanelPosition="Top"
                                        FilterType="HeaderContext"
                                        EnableHeaderContextMenu="true"
                                        EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="ActiveAmbassadorList_FilterCheckListItemsRequested">

                                        <ExportSettings IgnorePaging="True" OpenInNewWindow="True">
                                            <Pdf AllowAdd="True" AllowCopy="True">
                                            </Pdf>
                                        </ExportSettings>

                                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="ambassadorID" DataSourceID="getTerminatedAmbassadors" CommandItemDisplay="Top">

                                            <NoRecordsTemplate>

                                                <br />
                                                <div class="col-md-12">
                                                    <div class="alert alert-warning" role="alert"><strong>No Ambassadors Found.</strong>  Please adjust your filter options.</div>
                                                </div>

                                            </NoRecordsTemplate>

                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>

                                            <CommandItemTemplate>
                                                <div style="padding: 3px 0 3px 5px">
                                                    <asp:LoginView ID="LoginView_AddButton" runat="server">
                                                        <RoleGroups>
                                                            <asp:RoleGroup Roles="Administrator, Recruiter/Booking, Accounting">
                                                                <ContentTemplate>
                                                                    <asp:LinkButton ID="btnAddNew" runat="server" PostBackUrl="AddAmbassador" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Ambassador</asp:LinkButton>
                                                                </ContentTemplate>
                                                            </asp:RoleGroup>
                                                        </RoleGroups>
                                                    </asp:LoginView>

                                                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                                    <div class="pull-right" style="padding-right: 3px">
                                                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                                                    </div>
                                            </CommandItemTemplate>

                                            <Columns>

                                                <telerik:GridTemplateColumn AllowFiltering="false" ShowFilterIcon="false">
                                                    <ItemTemplate>
                                                        <a href="ViewAmbassadorDetails.aspx?UserID=<%# Eval("UserID")%>" class="btn btn-xs btn-primary" style="color: #fff">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn FilterCheckListEnableLoadOnDemand="true" DataField="UserName"
                                                    FilterControlAltText="Filter UserName column" HeaderText="User Name" SortExpression="UserName" UniqueName="UserName" AutoPostBackOnFilter="true" CurrentFilterFunction="StartsWith">
                                                </telerik:GridBoundColumn>



                                                <telerik:GridBoundColumn DataField="FirstName" HeaderText="First Name" SortExpression="FirstName"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />

                                                <telerik:GridBoundColumn DataField="LastName" HeaderText="Last Name" SortExpression="LastName"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />

                                                <telerik:GridBoundColumn DataField="EmailAddress" HeaderText="Email" SortExpression="EmailAddress" FilterCheckListEnableLoadOnDemand="false"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />

                                                <telerik:GridBoundColumn DataField="City" HeaderText="City" SortExpression="City"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" />

                                                <telerik:GridBoundColumn DataField="State" HeaderText="State" SortExpression="State" FilterCheckListEnableLoadOnDemand="true"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" />

                                                <telerik:GridTemplateColumn HeaderText="Last Login" SortExpression="LastLoginDate" AllowFiltering="false">
                                                    <ItemTemplate>

                                                        <asp:Label ID="Label1" runat="server" Text='<%# GetTimeAdjustment(Eval("LastLoginDate"))%>' />
                                                        <%--<%# (Eval("LastLoginDate") = DBNull.Value) : Eval("LastLoginDate")%>--%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                            </Columns>
                                        </MasterTableView>

                                        <PagerStyle Position="TopAndBottom"></PagerStyle>

                                    </telerik:RadGrid>
                                </div>
                            </div>
                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView4">
                            <!-- Calendar Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <telerik:RadButton RenderMode="Lightweight" ID="ApprovedCheckBox" runat="server" ToggleType="CheckBox" CssClass="approved"
                                        ButtonType="LinkButton" Checked="true" OnClick="btnToggle_Click">
                                        <ToggleStates>
                                            <telerik:RadButtonToggleState Text="Approved" Selected="true" PrimaryIconCssClass="rbToggleCheckboxChecked" />
                                            <telerik:RadButtonToggleState Text="Approved" PrimaryIconCssClass="rbToggleCheckbox" />
                                        </ToggleStates>
                                    </telerik:RadButton>
                                    <telerik:RadButton RenderMode="Lightweight" ID="ScheduledCheckBox" runat="server" ToggleType="CheckBox" CssClass="scheduled"
                                        ButtonType="LinkButton" Checked="true" OnClick="btnToggle_Click">
                                        <ToggleStates>
                                            <telerik:RadButtonToggleState Text="Scheduled" Selected="true" PrimaryIconCssClass="rbToggleCheckboxChecked" />
                                            <telerik:RadButtonToggleState Text="Scheduled" PrimaryIconCssClass="rbToggleCheckbox" />
                                        </ToggleStates>
                                    </telerik:RadButton>
                                    <telerik:RadButton RenderMode="Lightweight" ID="BookedCheckBox" runat="server" ToggleType="CheckBox" CssClass="booked"
                                        ButtonType="LinkButton" Checked="true" OnClick="btnToggle_Click">
                                        <ToggleStates>
                                            <telerik:RadButtonToggleState Text="Booked" Selected="true" PrimaryIconCssClass="rbToggleCheckboxChecked" />
                                            <telerik:RadButtonToggleState Text="Booked" PrimaryIconCssClass="rbToggleCheckbox" />
                                        </ToggleStates>
                                    </telerik:RadButton>
                                    <telerik:RadButton RenderMode="Lightweight" ID="RequestedCheckBox" runat="server" ToggleType="CheckBox" CssClass="requested"
                                        ButtonType="LinkButton" Checked="true" OnClick="btnToggle_Click">
                                        <ToggleStates>
                                            <telerik:RadButtonToggleState Text="Requested" Selected="true" PrimaryIconCssClass="rbToggleCheckboxChecked" />
                                            <telerik:RadButtonToggleState Text="Requested" PrimaryIconCssClass="rbToggleCheckbox" />
                                        </ToggleStates>
                                    </telerik:RadButton>
                                    <telerik:RadButton RenderMode="Lightweight" ID="CancelledCheckBox" runat="server" ToggleType="CheckBox" CssClass="cancelled"
                                        ButtonType="LinkButton" Checked="false" OnClick="btnToggle_Click">
                                        <ToggleStates>
                                            <telerik:RadButtonToggleState Text="Cancelled" Selected="true" PrimaryIconCssClass="rbToggleCheckboxChecked" />
                                            <telerik:RadButtonToggleState Text="Cancelled" PrimaryIconCssClass="rbToggleCheckbox" />
                                        </ToggleStates>
                                    </telerik:RadButton>
                                    <telerik:RadButton RenderMode="Lightweight" ID="ToplinedCheckBox" runat="server" ToggleType="CheckBox" CssClass="toplined"
                                        ButtonType="LinkButton" Checked="false" OnClick="btnToggle_Click">
                                        <ToggleStates>
                                            <telerik:RadButtonToggleState Text="Toplined" Selected="true" PrimaryIconCssClass="rbToggleCheckboxChecked" />
                                            <telerik:RadButtonToggleState Text="Toplined" PrimaryIconCssClass="rbToggleCheckbox" />
                                        </ToggleStates>
                                    </telerik:RadButton>

                                    <telerik:RadScheduler ID="RadScheduler1" runat="server" DataSourceID="getEvents" DataKeyField="eventID" SelectedView="WeekView"
                                        AppointmentStyleMode="Default" AllowEdit="False" AllowInsert="False" Skin="Bootstrap" OverflowBehavior="Expand"
                                        DataEndField="endTime" DataStartField="startTime" DataDescriptionField="tooltiptext"
                                        DataSubjectField="supplierName" RowHeight="30px" OnClientAppointmentClick="OnClientAppointmentClick">

                                        <ResourceTypes>
                                            <telerik:ResourceType KeyField="eventID" Name="StatusName" TextField="statusName" ForeignKeyField="eventID"
                                                DataSourceID="getEvents"></telerik:ResourceType>
                                        </ResourceTypes>
                                        <ResourceTypes>
                                            <telerik:ResourceType KeyField="statusID" Name="Status" TextField="statusName" ForeignKeyField="statusID"
                                                DataSourceID="StatusData"></telerik:ResourceType>
                                        </ResourceTypes>

                                    </telerik:RadScheduler>
                                </div>
                            </div>
                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView5">
                            <!-- Payments Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <telerik:RadTabStrip ID="PaymentTabStrip" runat="server" MultiPageID="RadMultiPage2" SelectedIndex="0" Skin="Bootstrap">
                                        <Tabs>
                                            <telerik:RadTab Text="Scheduled"></telerik:RadTab>
                                            <telerik:RadTab Text="Hours Billed"></telerik:RadTab>
                                            <telerik:RadTab Text="Pending"></telerik:RadTab>
                                            <telerik:RadTab Text="Approved"></telerik:RadTab>
                                            <telerik:RadTab Text="Paid"></telerik:RadTab>
                                            <telerik:RadTab Text="Rejected"></telerik:RadTab>
                                        </Tabs>
                                    </telerik:RadTabStrip>

                                    <telerik:RadMultiPage runat="server" ID="RadMultiPage2" SelectedIndex="0">
                                        <telerik:RadPageView runat="server" ID="RadPageView6">

                                            <telerik:RadGrid ID="ScehduledPaymentsGrid" runat="server" DataSourceID="getPayments" Skin="Bootstrap" RenderMode="Lightweight" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" FilterType="HeaderContext" EnableHeaderContextMenu="true">

                                                <MasterTableView DataSourceID="getPayments" AutoGenerateColumns="False" CommandItemDisplay="Top"
                                                    Font-Size="10">

                                                    <NoRecordsTemplate>
                                                        <br />
                                                        <div class="col-md-12">
                                                            <div class="alert alert-warning" role="alert"><strong>No Payments Found.</strong>  Please adjust your filter options.</div>
                                                        </div>
                                                    </NoRecordsTemplate>

                                                    <Columns>

                                                        <telerik:GridBoundColumn DataField="FullName" HeaderText="Ambassador Name" SortExpression="FullName" UniqueName="FullName" FilterControlAltText="Filter FullName column"></telerik:GridBoundColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Event Date">
                                                            <ItemTemplate>
                                                                <%# Eval("eventDate", "{0:d}") %><br />
                                                                <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="supplierName" HeaderText="Supplier Name" SortExpression="supplierName" UniqueName="supplierName" FilterControlAltText="Filter supplierName column"></telerik:GridBoundColumn>


                                                        <telerik:GridTemplateColumn HeaderText="Event Location">
                                                            <ItemTemplate>
                                                                <%# Eval("accountName") %><br />
                                                                <%# Eval("streetAddress1") %><br />
                                                                <%# Eval("city") %>, <%# Eval("state") %>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="positionTitle" HeaderText="Position" SortExpression="positionTitle" UniqueName="positionTitle" FilterControlAltText="Filter positionTitle column"></telerik:GridBoundColumn>

                                                        <%--                                                         <telerik:GridBoundColumn DataField="eventID" HeaderText="eventID" SortExpression="eventID" UniqueName="eventID" DataType="System.Int32" FilterControlAltText="Filter eventID column"></telerik:GridBoundColumn>--%>



                                                        <%--<telerik:GridBoundColumn DataField="paymentStatus" HeaderText="paymentStatus" SortExpression="paymentStatus" UniqueName="paymentStatus" FilterControlAltText="Filter paymentStatus column"></telerik:GridBoundColumn>--%>
                                                        <%--<telerik:GridBoundColumn DataField="paymentID" HeaderText="paymentID" SortExpression="paymentID" UniqueName="paymentID" DataType="System.Int32" FilterControlAltText="Filter paymentID column"></telerik:GridBoundColumn>--%>
                                                    </Columns>
                                                    <CommandItemTemplate>
                                                        <div style="padding: 3px 0 3px 5px">


                                                            <div class="pull-right" style="padding-right: 3px">
                                                                <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </CommandItemTemplate>


                                                    <NestedViewTemplate>
                                                        <div style="min-height: 400px; border: 1px solid #f1f1f1">

                                                            <%--            
     

                                                         <telerik:GridBoundColumn DataField="statusID" HeaderText="statusID" SortExpression="statusID" UniqueName="statusID" DataType="System.Int32" FilterControlAltText="Filter statusID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="rate" HeaderText="rate" SortExpression="rate" UniqueName="rate" DataType="System.Decimal" FilterControlAltText="Filter rate column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="hours" HeaderText="hours" SortExpression="hours" UniqueName="hours" DataType="System.Int32" FilterControlAltText="Filter hours column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="labor" HeaderText="labor" SortExpression="labor" UniqueName="labor" DataType="System.Decimal" FilterControlAltText="Filter labor column"></telerik:GridBoundColumn>
                                                      <telerik:GridBoundColumn DataField="RequirementID" HeaderText="RequirementID" SortExpression="RequirementID" UniqueName="RequirementID" DataType="System.Int32" FilterControlAltText="Filter RequirementID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="locationID" HeaderText="locationID" SortExpression="locationID" UniqueName="locationID" DataType="System.Int32" FilterControlAltText="Filter locationID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="accountID" HeaderText="accountID" SortExpression="accountID" UniqueName="accountID" DataType="System.Int32" FilterControlAltText="Filter accountID column"></telerik:GridBoundColumn>

                                                         

                                                         <telerik:GridBoundColumn DataField="userID" HeaderText="userID" SortExpression="userID" UniqueName="userID" FilterControlAltText="Filter userID column"></telerik:GridBoundColumn>
    <telerik:GridBoundColumn DataField="expenses" HeaderText="expenses" SortExpression="expenses" UniqueName="expenses" DataType="System.Decimal" FilterControlAltText="Filter expenses column"></telerik:GridBoundColumn>
                                                         <telerik:GridBoundColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataType="System.Decimal" FilterControlAltText="Filter Total column"></telerik:GridBoundColumn>
                                                         <telerik:GridBoundColumn DataField="paymentDate" HeaderText="paymentDate" SortExpression="paymentDate" UniqueName="paymentDate" DataType="System.DateTime" FilterControlAltText="Filter paymentDate column"></telerik:GridBoundColumn>--%>
                                                        </div>
                                                    </NestedViewTemplate>
                                                </MasterTableView>

                                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">

                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />

                                                </ClientSettings>

                                            </telerik:RadGrid>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getPayments" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryViewScheduledPayments" OrderBy="paymentDate"></asp:LinqDataSource>

                                        </telerik:RadPageView>

                                        <telerik:RadPageView runat="server" ID="RadPageView7">
                                            Hours Billed
                                        </telerik:RadPageView>

                                        <telerik:RadPageView runat="server" ID="RadPageView8">

                                            <telerik:RadGrid ID="PendingPaymentsRadGrid" runat="server" DataSourceID="LinqDataSource1" Skin="Bootstrap" RenderMode="Lightweight" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" FilterType="HeaderContext" EnableHeaderContextMenu="true" AllowMultiRowSelection="true" CellSpacing="-1" >

                                                <ClientSettings EnableRowHoverStyle="True" EnablePostBackOnRowClick="True" AllowDragToGroup="True">
                                                </ClientSettings>

                                                <MasterTableView DataSourceID="LinqDataSource1" AutoGenerateColumns="False" CommandItemDisplay="Top"
                                                    Font-Size="10">

                                                    <%--<GroupByExpressions>
                                                        <telerik:GridGroupByExpression>
                                                            <GroupByFields>
                                                                <telerik:GridGroupByField FieldAlias="FullName" FieldName="FullName" />
                                                            </GroupByFields>
                                                        </telerik:GridGroupByExpression>
                                                    </GroupByExpressions>--%>

                                                    <NoRecordsTemplate>
                                                        <br />
                                                        <div class="col-md-12">
                                                            <div class="alert alert-warning" role="alert"><strong>No Payments Found.</strong>  Please adjust your filter options.</div>
                                                        </div>
                                                    </NoRecordsTemplate>

                                                    <Columns>

                                                        <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1">
                                                        </telerik:GridClientSelectColumn>

                                                        <telerik:GridTemplateColumn AllowFiltering="false" ItemStyle-Wrap="false">
                                                            <ItemTemplate>
                                                                <div class="btn-group" role="group" aria-label="...">
                                                                  <asp:LinkButton ID="btnApproveExpense" runat="server" CssClass="btn btn-xs btn-success"><i class="fa fa-check-square" aria-hidden="true"></i> Approve</asp:LinkButton>
                                                                 
                                                                  <button type="button" class="btn btn-xs btn-danger"><i class="fa fa-times-circle" aria-hidden="true"></i> Deny</button>
                                                                </div>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="FullName" HeaderText="Ambassador Name" SortExpression="FullName" UniqueName="FullName" FilterControlAltText="Filter FullName column"></telerik:GridBoundColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Event Date">
                                                            <ItemTemplate>
                                                                <%# Eval("eventDate", "{0:d}") %><br />
                                                                <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="supplierName" HeaderText="Supplier Name" SortExpression="supplierName" UniqueName="supplierName" FilterControlAltText="Filter supplierName column"></telerik:GridBoundColumn>



                                                        <telerik:GridTemplateColumn HeaderText="Event Location">
                                                            <ItemTemplate>
                                                                <%# Eval("accountName") %><br />
                                                                <%# Eval("streetAddress1") %><br />
                                                                <%# Eval("city") %>, <%# Eval("state") %>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>



                                                        <telerik:GridBoundColumn DataField="positionTitle" HeaderText="Position" SortExpression="positionTitle" UniqueName="positionTitle" FilterControlAltText="Filter positionTitle column"></telerik:GridBoundColumn>

                                                        <%--                                                         <telerik:GridBoundColumn DataField="eventID" HeaderText="eventID" SortExpression="eventID" UniqueName="eventID" DataType="System.Int32" FilterControlAltText="Filter eventID column"></telerik:GridBoundColumn>--%>
                                                    </Columns>
                                                    <CommandItemTemplate>
                                                        <div style="padding: 3px 0 3px 5px">

                                                            <div class="btn-group" role="group" aria-label="...">

                                                                  <button type="button" class="btn btn-sm btn-success"> <i class="fa fa-check-square" aria-hidden="true"></i> Approve Selected</button>
                                                                  <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-times-circle" aria-hidden="true"></i> Deny Selected</button>
                                                                </div>

                                                            <div class="pull-right" style="padding-right: 3px">
                                                                <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </CommandItemTemplate>


                                                    <NestedViewTemplate>
                                                        <div style="min-height: 400px; border: 1px solid #f1f1f1">

                                                            <%--            
     

                                                         <telerik:GridBoundColumn DataField="statusID" HeaderText="statusID" SortExpression="statusID" UniqueName="statusID" DataType="System.Int32" FilterControlAltText="Filter statusID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="rate" HeaderText="rate" SortExpression="rate" UniqueName="rate" DataType="System.Decimal" FilterControlAltText="Filter rate column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="hours" HeaderText="hours" SortExpression="hours" UniqueName="hours" DataType="System.Int32" FilterControlAltText="Filter hours column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="labor" HeaderText="labor" SortExpression="labor" UniqueName="labor" DataType="System.Decimal" FilterControlAltText="Filter labor column"></telerik:GridBoundColumn>
                                                      <telerik:GridBoundColumn DataField="RequirementID" HeaderText="RequirementID" SortExpression="RequirementID" UniqueName="RequirementID" DataType="System.Int32" FilterControlAltText="Filter RequirementID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="locationID" HeaderText="locationID" SortExpression="locationID" UniqueName="locationID" DataType="System.Int32" FilterControlAltText="Filter locationID column"></telerik:GridBoundColumn>

                                                         <telerik:GridBoundColumn DataField="accountID" HeaderText="accountID" SortExpression="accountID" UniqueName="accountID" DataType="System.Int32" FilterControlAltText="Filter accountID column"></telerik:GridBoundColumn>

                                                         

                                                         <telerik:GridBoundColumn DataField="userID" HeaderText="userID" SortExpression="userID" UniqueName="userID" FilterControlAltText="Filter userID column"></telerik:GridBoundColumn>
    <telerik:GridBoundColumn DataField="expenses" HeaderText="expenses" SortExpression="expenses" UniqueName="expenses" DataType="System.Decimal" FilterControlAltText="Filter expenses column"></telerik:GridBoundColumn>
                                                         <telerik:GridBoundColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataType="System.Decimal" FilterControlAltText="Filter Total column"></telerik:GridBoundColumn>
                                                         <telerik:GridBoundColumn DataField="paymentDate" HeaderText="paymentDate" SortExpression="paymentDate" UniqueName="paymentDate" DataType="System.DateTime" FilterControlAltText="Filter paymentDate column"></telerik:GridBoundColumn>--%>
                                                        </div>
                                                    </NestedViewTemplate>
                                                </MasterTableView>

                                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">

                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />

                                                </ClientSettings>

                                            </telerik:RadGrid>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryViewPendingPayments" OrderBy="paymentDate"></asp:LinqDataSource>
                                        </telerik:RadPageView>

                                        <telerik:RadPageView runat="server" ID="RadPageView9">
                                            Approved
                                        </telerik:RadPageView>

                                        <telerik:RadPageView runat="server" ID="RadPageView10">
                                            Paid
                                        </telerik:RadPageView>

                                        <telerik:RadPageView runat="server" ID="RadPageView11">
                                            Rejected
                                        </telerik:RadPageView>


                                    </telerik:RadMultiPage>



                                </div>
                            </div>
                        </telerik:RadPageView>
                    </telerik:RadMultiPage>

                </div>
            </div>


        </div>






    </div>
    <asp:SqlDataSource ID="StatusData" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [tblStatus]"></asp:SqlDataSource>

    <asp:LinqDataSource ID="getActiveAmbassadors" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="userName" TableName="qryViewActiveAmbassador_withMarkets">
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="getPendingAmbassadors" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="userName" TableName="tblAmbassadors" Where="Status == @Status">
        <WhereParameters>
            <asp:Parameter DefaultValue="Pending" Name="Status" Type="String"></asp:Parameter>
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="getTerminatedAmbassadors" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="userName" TableName="tblAmbassadors" Where="Status == @Status">
        <WhereParameters>
            <asp:Parameter DefaultValue="Terminated" Name="Status" Type="String"></asp:Parameter>
        </WhereParameters>
    </asp:LinqDataSource>


    <asp:SqlDataSource ID="getAllApplicants" runat="server"
        ConnectionString="<%$ ConnectionStrings:MembershipConnection %>"
        SelectCommand="SELECT * FROM [StudentDetails] WHERE ([SiteID] = @SiteID and [Status] = 'Active') ORDER BY [UserName]">
        <SelectParameters>
            <asp:Parameter Name="SiteID" DefaultValue="GigEngyn" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="getPendingApplicants" runat="server"
        ConnectionString="<%$ ConnectionStrings:MembershipConnection %>"
        SelectCommand="SELECT  * FROM [StudentDetails] WHERE ([SiteID] = @SiteID and [Status] = 'Invitation Sent') ORDER BY [LastName]">
        <SelectParameters>
            <asp:Parameter Name="SiteID" DefaultValue="GigEngyn" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="getLockedApplicants" runat="server"
        ConnectionString="<%$ ConnectionStrings:MembershipConnection %>"
        SelectCommand="SELECT  * FROM [StudentDetails] WHERE ([SiteID] = @SiteID and [Status] = 'Locked') ORDER BY [LastName]">
        <SelectParameters>
            <asp:Parameter Name="SiteID" DefaultValue="GigEngyn" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:LinqDataSource ID="getEvents" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="qryViewEvents">
    </asp:LinqDataSource>



    <%--<telerik:RadWindowManager runat="server" ID="RadWindowManager1">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow" VisibleStatusbar="false" NavigateUrl="/Ambassadors/AddAdvancedFilters.aspx" Skin="Bootstrap"
                Width="725px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>--%>



    <telerik:RadWindow ID="RadWindow1" runat="server" Modal="true" VisibleOnPageLoad="false" Width="625px" Height="330px" Behaviors="Close,Move" AutoSize="false" Skin="Bootstrap">
        <ContentTemplate>
            
            <div class="widget stacked">
                            <div class="widget-content">

                                <div class="row" style="margin-bottom: 25px;">
                                    <div class="col-sm-12">
                                        <div class="pull-right btn-group" role="group">
                                            <asp:Button ID="btnApplyFilter2" runat="server" Text="Apply Filter" CausesValidation="True" CssClass="btn btn-primary" />
                                            <asp:Button ID="btnCancelFilter2" runat="server" Text="Cancel" CssClass="btn btn-default" OnClientClick="CancelFilter_Click()" />
                                            <asp:Button ID="btnClearFilter2" runat="server" Text="Clear" CssClass="btn btn-default" />
                                        </div>

                                    </div>
                                </div>

                                <div class="row">
                                    
                                    <div class="col-md-6">
                                        
                                        <h4 style="font-weight: bold; color: #3276B1; margin-bottom: 15px;">Positions</h4>
                                                                                
                                    </div>

                                    <div class="col-md-6">


                                        <h4 style="font-weight: bold; color: #3276B1; margin-bottom: 10px;">Markets</h4>
                                        <br />
                                        
                                                                                
                                    </div>

                                </div>

                                <br />

                                
                            </div>
                        </div>
               
        </ContentTemplate>  
    </telerik:RadWindow>

    <script type="text/javascript">
        $('#ambassadors1').addClass('active');

        function CreateWindowScript() {
            //var win = window.radopen('/Ambassadors/AddAdvancedFilters.aspx', 'RadWindow');
            //win.center();
            $find("<%=RadWindow1.ClientID %>").show();
        }
        
        function CancelFilter_Click() {
            window.close();
        }

    </script>




</asp:Content>
