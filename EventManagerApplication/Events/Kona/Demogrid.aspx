<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Demogrid.aspx.vb" Inherits="EventManagerApplication.Demogrid" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">

        <asp:Panel runat="server" ID="BoxesPanel">
            <div class="row">
                <div class="col-xs-12">

                    <h2>Events</h2>

                    <div class="widget-box">
                        <div class="widget-title">
                            <h5>Event Summary for
                            <asp:Label ID="lblWeek" runat="server" Text="Label" Font-Bold="true" Font-Size="Larger" />
                            </h5>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">

                <div class="col-sm-12">

                    <div class="feature col-sx-4 col-sm-2 center">

                            <div class="well blackbox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="TotalCountLabel" runat="server" /></h2>
                                <h5 class="text-center">Total<br />
                                    Events</h5>
                            </div>

                    </div>
                    <div class="feature col-sx-4 col-sm-2 center">

                            <div class="well bluebox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="ApprovedCountLabel" runat="server" /></h2>
                                <h5 class="text-center">Approved<br />
                                    Events</h5>
                            </div>

                    </div>


                    <div class="feature col-sx-4 col-sm-2 center">


                            <div class="well orangebox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="ScheduledCountLabel" runat="server" /></h2>
                                <h5 class="text-center">Scheduled<br />
                                    Events</h5>
                            </div>

                    </div>

                    <div class="feature col-sx-4 col-sm-2 center">

                            <div class="well greenbox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="BookedCountLabel" runat="server" /></h2>
                                <h5 class="text-center">Booked<br />
                                    Events</h5>
                            </div>

                    </div>

                    <div class="feature col-sx-4 col-sm-2 center">

                            <div class="well darkbluebox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="RequestedCountLabel" runat="server" /></h2>
                                <h5 class="text-center">Client Requested<br />
                                    Events</h5>
                            </div>

                    </div>

                    <div class="feature col-sx-2 col-sm-1 center">

                            <div class="well redbox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="CancelledCountLabel" runat="server" /></h2>
                                <h5 class="text-center">Canceled<br />
                                    Events</h5>
                            </div>

                    </div>


                    <div class="feature col-sx-2 col-sm-1">

                            <div class="well purplebox smbox center">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="ToplinedCountLabel" runat="server" /></h2>
                                <h5 class="text-center">Toplined<br />
                                    Events</h5>
                            </div>

                    </div>


                </div>

            </div>
    </asp:Panel>

                    <!-- Date Filter -->
            <asp:Panel runat="server" ID="DatePanel">
            <div style="margin-bottom: 15px;">
                From:
                <telerik:RadDatePicker ID="FromDatePicker" runat="server">
                    <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>
                </telerik:RadDatePicker>
                To:
                <telerik:RadDatePicker ID="ToDatePicker" runat="server">
                    <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>
                </telerik:RadDatePicker>
                <asp:Button ID="btnChangeDateRange" runat="server" Text="Go" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Date Range" />

                <%--<a id='filterbutton' class="filterbutton" href="#">Advanced Filter</a>--%>

                <div class="btn-group pull-right gridbuttons" role="group" aria-label="..." style="margin-bottom: 25px;">
                    <asp:LinkButton ID="btnCalendar" runat="server" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="View Calendar" data-original-title="View Calendar" ><i class="fa fa-calendar"></i> Calendar</asp:LinkButton>
                    <asp:LinkButton ID="btnMap" runat="server" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="View Map" data-original-title="View Map"><i class="fa fa-globe"></i> Map</asp:LinkButton>
                </div>

                 <div class="btn-group pull-right viewbuttons" role="group" aria-label="..." style="margin-right: 20px;">
                    <asp:Button ID="btnViewWeek" runat="server" Text="Week" CssClass="btn btn-success ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Current Week" />
                    <asp:Button ID="btnViewMonth" runat="server" Text="Month" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Current Month" />

                     <asp:LinkButton ID="btnViewAssignments" runat="server" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="View Ambassador Assignments" Visible="false" ><i class="fa fa-search"></i> View Assignments</asp:LinkButton>

                     <asp:LinkButton ID="btnViewEvents" runat="server" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="View Ambassador Assignments" Visible="false"><i class="fa fa-search"></i> View Events</asp:LinkButton>

                </div>

                </div>
            </asp:Panel>

            <div style="margin-bottom: 15px;">

                        <telerik:RadGrid ID="EventDataGrid" runat="server" 
                            AllowPaging="True"
                            AllowSorting="True"
                            ShowFooter="True"
                            ShowStatusBar="true"
                            AllowFilteringByColumn="True"
                            PageSize="20" CellSpacing="-1"
                            FilterType="HeaderContext"
                            EnableHeaderContextMenu="true"
                            EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="EventDataGrid_FilterCheckListItemsRequested"
                            EnableLinqExpressions="False">

                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ></ExportSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="eventID" CommandItemDisplay="Top" AllowSorting="true">

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
                                        <asp:LoginView ID="LoginView_AddButton" runat="server">
                                            <RoleGroups>
                                                <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, Accounting">
                                                    <ContentTemplate>
                                                        <%--<asp:LinkButton ID="btnAddNew" runat="server" PostBackUrl="NewEvent" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Event</asp:LinkButton>--%>

                                                        <asp:LinkButton ID="btnAddNew" runat="server" CssClass="btn btn-success btn-sm" ForeColor="White" CommandName="AddNewEvent"> <i class="fa fa-plus"></i> Add New Event</asp:LinkButton>

                                                        <asp:LinkButton ID="btnImportEvents" runat="server" PostBackUrl="ImportEvents" CssClass="btn btn-default btn-sm" Visible="false"> <i class="fa fa fa-upload"></i> Import Events</asp:LinkButton>

                                                    </ContentTemplate>
                                                </asp:RoleGroup>
                                            </RoleGroups>
                                        </asp:LoginView>
                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ResetGrid" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                        <div class="pull-right" style="padding-right: 3px">

                                        <%--<asp:LoginView ID="LoginView2" runat="server">
                                            <RoleGroups>
                                                <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, Accounting">
                                                    <ContentTemplate>
                                                        <asp:LinkButton ID="btnViewRequestedEvents" runat="server" PostBackUrl="~/Events/ViewRequestedEvents.aspx" CssClass="btn btn-primary btn-sm"
                                                            ForeColor="White" >View Requested Events &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>
                                                    </ContentTemplate>
                                                </asp:RoleGroup>
                                            </RoleGroups>
                                        </asp:LoginView>--%>


                                            <asp:LoginView ID="LoginView1" runat="server">
                                                <RoleGroups>
                                                    <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, Accounting, Agency, Client">
                                                        <ContentTemplate>
                                                            <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                                                        </ContentTemplate>
                                                    </asp:RoleGroup>
                                                </RoleGroups>
                                            </asp:LoginView>
                                        </div>
                                </CommandItemTemplate>

                                <Columns>
                                    <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewButton">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>

                                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary btn-xs" ForeColor="White" CommandName="ViewEvent" CommandArgument='<%# Eval("eventID")%>'>View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>


                                             <%--OnClientClick="bntViewEvent()"--%>


                                            <br />
                                            <asp:Label ID="NotificationLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("labelText")%>' />
                                         </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridTemplateColumn DataField="eventID" HeaderText="Event ID" SortExpression="eventID" UniqueName="eventID" DataType="System.Int32" FilterControlAltText="Filter eventID column"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                    <ItemTemplate>
                                                        <%# Eval("eventID") %> <a href="/events/eventdetails?ID=<%# Eval("eventID") %>" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
                                                    </ItemTemplate>
                                        <ItemStyle  Wrap="false"/>
                                        <HeaderStyle Wrap="false" />
                                                </telerik:GridTemplateColumn>

                                     <telerik:GridBoundColumn DataField="eventID" Visible="false"
                                        FilterControlAltText="Filter eventID column"
                                        HeaderText="Event ID"
                                        SortExpression="eventID" UniqueName="eventID1"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="supplierName"
                                        FilterControlAltText="Filter supplierName column"
                                        HeaderText="Supplier Name"
                                        SortExpression="supplierName" UniqueName="supplierName" FilterControlWidth="150px"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="175px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="brands" FilterControlAltText="Filter brandName column"
                                        HeaderText="Brands" SortExpression="brands" UniqueName="brands"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn AllowFiltering="true" ShowFilterIcon="false" CurrentFilterFunction="EqualTo"
                                        DataField="eventDate"
                                        UniqueName="eventDate"
                                        HeaderText="Date"
                                        SortExpression="eventDate">
                                        <ItemStyle  Wrap="false"/>
                                        <ItemTemplate>
                                            <%# Eval("eventDate", "{0:d}") %> <%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridTemplateColumn DataField="statusName" FilterControlAltText="Filter statusName column"
                                        HeaderText="Status" SortExpression="statusName" UniqueName="statusName" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" GroupByExpression="statusName statusID Group By statusName">
                                        <ItemStyle Width="120px" />
                                        <ItemTemplate>
                                            <asp:Image ID="StatusImage" runat="server" ImageUrl='<%#Eval("iconURL") %>' Width="10px" Height="10px" style="margin-bottom: 2px;" />
                                            <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("statusName")%>' /><br />
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("RequestedLabel")%>' />
                                            </ItemTemplate>


                                    </telerik:GridTemplateColumn>

                                     <telerik:GridBoundColumn DataField="statusName" FilterControlAltText="Filter status column"
                                        HeaderText="Status" SortExpression="status" UniqueName="status" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" Visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="marketName" FilterControlAltText="Filter marketName column"
                                        HeaderText="Market" SortExpression="marketName" UniqueName="marketName" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="eventTypeName" FilterControlAltText="Filter typeName column"
                                        HeaderText="Event Type" SortExpression="eventTypeName" UniqueName="eventTypeName" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="Location" AllowFiltering="true" UniqueName="accountName" DataField="accountName" SortExpression="accountName"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <ItemTemplate>
                                            <a href='/Accounts/AccountDetails?AccountID=<%# Eval("accountID")%>' style="color: cornflowerblue"><%# Eval("accountName")%></a><br />
                                            <%# Eval("address")%><br />
                                            <%# Eval("city")%>, <%# Eval("state")%>
                                        </ItemTemplate>
                                        <ItemStyle Width="160px" />
                                    </telerik:GridTemplateColumn>

                                     <telerik:GridBoundColumn DataField="accountName" FilterControlAltText="Filter accountName1 column"
                                        HeaderText="Account Name" SortExpression="accountName1" UniqueName="accountName1" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" Visible="False">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                     </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="address" FilterControlAltText="Filter address column"
                                        HeaderText="Address" SortExpression="address" UniqueName="address" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" Visible="False">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                     </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="city" FilterControlAltText="Filter city column"
                                        HeaderText="City" SortExpression="city" UniqueName="city" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" Visible="False">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="state" FilterControlAltText="Filter state column"
                                        HeaderText="State" SortExpression="state" UniqueName="state" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" Visible="False">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="importFileID" FilterControlAltText="Filter importFileID column"
                                        HeaderText="importFileID" SortExpression="importFileID" UniqueName="importFileID" FilterControlWidth="120px">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                </Columns>

                            </MasterTableView>

                            <PagerStyle Position="TopAndBottom" />


                        </telerik:RadGrid>

                </div>
    </div>
</asp:Content>
