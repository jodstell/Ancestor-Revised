<%@ Page Title="Ambassadors" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AmbassadorList.aspx.vb" Inherits="EventManagerApplication.AmbassadorList1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../Theme/css/custom1.css" rel="stylesheet" />
    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="css/schedule.css" rel="stylesheet" />

    <div class="container">

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

            function requestStart(sender, args) {

                if (args.get_eventTarget().indexOf("btnExport") > 0 ||

                args.get_eventTarget().indexOf("btnExport") > 0)

                    args.set_enableAjax(false);

                if (args.get_eventTarget().indexOf("btnExport2") > 0 ||

               args.get_eventTarget().indexOf("btnExport2") > 0)

                    args.set_enableAjax(false);

                if (args.get_eventTarget().indexOf("btnExport3") > 0 ||

              args.get_eventTarget().indexOf("btnExport3") > 0)

                    args.set_enableAjax(false);
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

        <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
    <PersistenceSettings>
        <telerik:PersistenceSetting ControlID="ActiveAmbassadorList" />
        <telerik:PersistenceSetting ControlID="RadTabStrip1" />
        </PersistenceSettings>
</telerik:RadPersistenceManager>


        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true" ClientEvents-OnRequestStart="requestStart" >
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="Panel1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

        <asp:Panel ID="Panel1" runat="server">
            <!--Header-->
            <div class="container min-height">
                <div class="row">
                    <div class="col-xs-12">
                        <h2>Brand Ambassadors</h2>
                         <ol class="breadcrumb">
                        <li><i class="fa fa-home" aria-hidden="true"></i><a href="/"> Dashboard</a></li>
                        <li class="active">Ambassadors</li>
                    </ol>

                    </div>
                </div>


                <div class="row">
                    <div class="col-md-12">

                        <asp:SqlDataSource ID="StatusData" runat="server" 
                            ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                            SelectCommand="SELECT * FROM [tblStatus]"></asp:SqlDataSource>

                        <asp:LinqDataSource ID="getActiveAmbassadors" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="userName"
                            TableName="qryViewActiveAmbassadors">
                        </asp:LinqDataSource>

                        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" SelectedIndex="0" Skin="Bootstrap">
                            <Tabs>
                                <telerik:RadTab Text="Active" runat="server" ID="activeTab"></telerik:RadTab>
                                <telerik:RadTab Text="Prospect" runat="server" ID="pendingTab"></telerik:RadTab>
                                <telerik:RadTab Text="Terminated" runat="server" ID="terminatedTab"></telerik:RadTab>
                                <telerik:RadTab Text="Rejected" runat="server" ID="rejectedTab"></telerik:RadTab>
<%--<telerik:RadTab Text="Payments" runat="server" ID="paymentsTab"></telerik:RadTab>--%>
                            </Tabs>
                        </telerik:RadTabStrip>


                        <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0">
                            <telerik:RadPageView runat="server" ID="RadPageView1">
                                <!-- Active Tab -->
                                <div class="widget stacked">
                                    <div class="widget-content">

                                        <telerik:RadGrid ID="ActiveAmbassadorList" runat="server" DataSourceID="getActiveAmbassadors"
                                            AllowFilteringByColumn="True"
                                            AllowPaging="True" AllowSorting="True"
                                            AllowCustomPaging="True" PageSize="20"
                                            ShowFooter="True"
                                            FilterType="HeaderContext"
                                            EnableHeaderContextMenu="true"
                                            EnableHeaderContextFilterMenu="true" 
                                            OnFilterCheckListItemsRequested="ActiveAmbassadorList_FilterCheckListItemsRequested" 
                                            CellSpacing="-1">

                                           <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ></ExportSettings>

                                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ambassadorID" 
                                                DataSourceID="getActiveAmbassadors" CommandItemDisplay="Top"
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
                                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ResetGrid" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                                        <div class="pull-right" style="padding-right: 3px">
                                                            <%--<asp:LinkButton ID="btnMapView1" runat="server" CssClass="btn btn-default btn-sm" ForeColor="Black" OnClick="btnMapView1_Click"><i class="fa fa-globe"></i> Map</asp:LinkButton>--%>
                                                                <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                                                        </div>
                                                </CommandItemTemplate>

                                                <Columns>

                                                    <telerik:GridTemplateColumn AllowFiltering="false" ShowFilterIcon="false" 
                                                        UniqueName="ViewButton">
                                                        <ItemStyle Width="40px" />
                                                        <ItemTemplate>

                                                            <asp:LinkButton ID="ViewButton" runat="server" CssClass="btn btn-xs btn-primary" ForeColor="white" CommandName="ViewAmbassador" CommandArgument='<%# Eval("UserID")%>'>View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>

                                                            <br />
                                                            <asp:Label ID="updateLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("labelText")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridBoundColumn FilterCheckListEnableLoadOnDemand="true" DataField="UserName"
                                                        FilterControlAltText="Filter UserName column" HeaderText="User Name" SortExpression="UserName" UniqueName="UserName" AutoPostBackOnFilter="true" CurrentFilterFunction="StartsWith" HeaderStyle-Wrap="false" Visible="true">
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

                                                   <%-- <telerik:GridBoundColumn DataField="Markets" HeaderText="Markets" SortExpression="Markets" FilterCheckListEnableLoadOnDemand="true"
                                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" Visible="true" />

                                                    <telerik:GridBoundColumn DataField="Positions" HeaderText="Positions" SortExpression="Positions" FilterCheckListEnableLoadOnDemand="true" ItemStyle-Wrap="false" Visible="true"
                                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" />--%>



                                                  

                                                </Columns>
                                            </MasterTableView>

<%--                                          <ClientSettings ReorderColumnsOnClient="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                                                <Virtualization EnableVirtualization="true" InitiallyCachedItemsCount="20"
                                                    LoadingPanelID="RadAjaxLoadingPanel1" ItemsPerView="20"/>
                                            </ClientSettings>--%>

                                            <PagerStyle Position="TopAndBottom"></PagerStyle>

                                        </telerik:RadGrid>

                                    </div>
                                </div>


                            </telerik:RadPageView>

                            <telerik:RadPageView runat="server" ID="RadPageView2">
                                <div class="widget stacked">
                                    <div class="widget-content">

                                        <telerik:RadGrid ID="PendingAmbassadorsList" runat="server" DataSourceID="SqlDataSource1"
                                            AllowFilteringByColumn="True"
                                            AllowSorting="True"
                                           
                                            ShowFooter="True" CellSpacing="-1" GroupPanelPosition="Top"
                                            FilterType="HeaderContext"
                                            EnableHeaderContextMenu="true"
                                            EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="PendingAmbassadorList_FilterCheckListItemsRequested">

                                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ></ExportSettings>

                                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ambassadorID" DataSourceID="SqlDataSource1" CommandItemDisplay="Top">

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
                                                            <asp:LinkButton ID="btnExport2" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                                                        </div>
                                                </CommandItemTemplate>

                                                <Columns>

                                                    <telerik:GridTemplateColumn AllowFiltering="false" ShowFilterIcon="false" UniqueName="ViewButton">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnViewProspect" runat="server" CssClass="btn btn-xs btn-primary" ForeColor="white" CommandArgument='<%# Eval("ambassadorID")%>' CommandName="View">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>

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

                                        <asp:LinqDataSource ID="getPendingAmbassadors" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="userName" TableName="tblAmbassadors" Where="Status == @Status">
                                            <WhereParameters>
                                                <asp:Parameter DefaultValue="Pending" Name="Status" Type="String"></asp:Parameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>

                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [qryViewPendingAmbassador]"></asp:SqlDataSource>


                                    </div>

                                </div>
                            </telerik:RadPageView>

                            <telerik:RadPageView runat="server" ID="RadPageView3">
                                <div class="widget stacked">
                                    <div class="widget-content">

                                        <telerik:RadGrid ID="TerminatedAmbassadorList" runat="server" DataSourceID="getTerminatedAmbassadorList"
                                            AllowFilteringByColumn="True"
                                            AllowPaging="True" AllowSorting="True"
                                            AllowCustomPaging="True" PageSize="20"
                                            ShowFooter="True" CellSpacing="-1" GroupPanelPosition="Top"
                                            FilterType="HeaderContext"
                                            EnableHeaderContextMenu="true"
                                            EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="TreminatedAmbassadorList_FilterCheckListItemsRequested">

                                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ></ExportSettings>

                                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ambassadorID" DataSourceID="getTerminatedAmbassadorList" CommandItemDisplay="Top">

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
                                                            <asp:LinkButton ID="btnExport3" runat="server" CommandName="ExportExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                                                        </div>
                                                </CommandItemTemplate>

                                                <Columns>

                                                    <telerik:GridTemplateColumn AllowFiltering="false" ShowFilterIcon="false" UniqueName="ViewButton">
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

                                        <asp:SqlDataSource ID="getTerminatedAmbassadorList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [qryViewTerminatedAmbassador]"></asp:SqlDataSource>


                                                                           </div>

                                </div>
                            </telerik:RadPageView>

                            <telerik:RadPageView runat="server" ID="RadPageView4">
                                <div class="widget stacked">
                                    <div class="widget-content">

                                        <telerik:RadGrid ID="RejectedAmbassadorsList" runat="server" DataSourceID="getRejectedAmbassadors"
                                            AllowFilteringByColumn="True"
                                            AllowPaging="True" AllowSorting="True"
                                            AllowCustomPaging="True" PageSize="20"
                                            ShowFooter="True" CellSpacing="-1" GroupPanelPosition="Top"
                                            FilterType="HeaderContext"
                                            EnableHeaderContextMenu="true"
                                            EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="PendingAmbassadorList_FilterCheckListItemsRequested">

                                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ></ExportSettings>

                                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ambassadorID" DataSourceID="getRejectedAmbassadors" CommandItemDisplay="Top">

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
                                                            <asp:LinkButton ID="btnExport2" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                                                        </div>
                                                </CommandItemTemplate>

                                                <Columns>

                                                    <telerik:GridTemplateColumn AllowFiltering="false" ShowFilterIcon="false" UniqueName="ViewButton">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnViewProspect" runat="server" CssClass="btn btn-xs btn-primary" ForeColor="white" CommandArgument='<%# Eval("ambassadorID")%>' CommandName="View">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>

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

                                        <asp:LinqDataSource ID="getRejectedAmbassadors" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="userName" TableName="tblAmbassadors" Where="Status == @Status">
                                            <WhereParameters>
                                                <asp:Parameter DefaultValue="Rejected" Name="Status" Type="String"></asp:Parameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>

                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                            ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                                            SelectCommand="SELECT * FROM [qryViewPendingAmbassador]"></asp:SqlDataSource>


                                    </div>

                                </div>
                            </telerik:RadPageView>

                            <telerik:RadPageView runat="server" ID="RadPageView5">
                                <!-- Payments Tab -->
                                <div class="widget stacked">
                                    <div class="widget-content">







                                    </div>

                                </div>
                            </telerik:RadPageView>

                        </telerik:RadMultiPage>




                    </div>
                </div>
            </div>

        </asp:Panel>
    </div>
</asp:Content>
