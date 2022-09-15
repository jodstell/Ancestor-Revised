<%@ Page Title="View Assignments" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewAssignments.aspx.vb" Inherits="EventManagerApplication.ViewAssignments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">

            // close the div in 3 secs
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
            }

            function requestEnd(sender, args) {
                $('.ui-tooltip').tooltip();
            }

            function bntViewEvent() {

                var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                var currentUpdatedControl = "<%= Panel1.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.show(currentUpdatedControl);

            }

            (function () {

            window.pageLoad = function () {
                var $ = $telerik.$;
            }

            window.OnClientLoad = function (sender, args) {

                for (var i = 1; i < sender.get_wizardSteps().get_count() ; i++) {
                    sender.get_wizardSteps().getWizardStep(i).set_enabled(false);
                }
            }

        })();

        </script>
    </telerik:RadCodeBlock>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>
        </div>
    </div>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true" ClientEvents-OnRequestStart="requestStart" ClientEvents-OnResponseEnd="requestEnd">

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="ViewEventsPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                 </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <%--<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="SupplierPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>

    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="EventDataGrid" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>

    <asp:HiddenField ID="HiddenUserID" runat="server" />
    <%--<asp:HiddenField ID="HiddenClientID" runat="server" />--%>

        <div class="container min-height">
<asp:Panel ID="Panel1" runat="server">
    <asp:Panel runat="server" ID="BoxesPanel">
            <div class="row">
                <div class="col-xs-12">

                    <h2>Event Assignments</h2>

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
            <div id="mainDiv">


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

               <%-- <div class="btn-group pull-right gridbuttons" role="group" aria-label="..." style="margin-bottom: 25px;">
                    <asp:LinkButton ID="btnCalendar" runat="server" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="View Calendar" data-original-title="View Calendar" ><i class="fa fa-calendar"></i> Calendar</asp:LinkButton>
                    <asp:LinkButton ID="btnMap" runat="server" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="View Map" data-original-title="View Map"><i class="fa fa-globe"></i> Map</asp:LinkButton>
                </div>--%>

                 <div class="btn-group pull-right viewbuttons" role="group" aria-label="..." style="margin-right: 20px;">

                     <asp:Button ID="btnExportExcel" runat="server" Text="Download Excel File" CssClass="btn btn-secondary ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Download Excel File by Date Range" />

                    <asp:Button ID="btnViewWeek" runat="server" Text="Week" CssClass="btn btn-success ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Current Week" />
                    <asp:Button ID="btnViewMonth" runat="server" Text="Month" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Current Month" />

                     <%--<asp:LinkButton ID="btnViewAssignments" runat="server" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="View Ambassador Assignments" ><i class="fa fa-search"></i> View Assignments</asp:LinkButton>

                     <asp:LinkButton ID="btnViewEvents" runat="server" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="View Ambassador Assignments" Visible="false"><i class="fa fa-search"></i> View Events</asp:LinkButton>--%>

                </div>

                </div>
            </asp:Panel>

            <div style="margin-bottom: 15px;">


            <!-- Grid Panel -->

            <asp:Panel ID="AssignmentsPanel" runat="server" CssClass="GridPanelCss">
                <div class="row">
                    <div class="col-sm-12">
                        <telerik:RadGrid ID="AssignmentsGrid" runat="server" AllowPaging="True" 
                            AllowSorting="True"
                            ShowFooter="True"
                            ShowStatusBar="true"
                            AllowFilteringByColumn="True"
                            PageSize="20" CellSpacing="-1"
                            FilterType="HeaderContext"
                            EnableHeaderContextMenu="true"
                            EnableHeaderContextFilterMenu="true"
                            OnFilterCheckListItemsRequested="AssignmentsGrid_FilterCheckListItemsRequested"
                            EnableLinqExpressions="False">

                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ></ExportSettings>
                            <MasterTableView AutoGenerateColumns="False"  DataKeyNames="eventID" CommandItemDisplay="Top" AllowSorting="true">
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

                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                        <div class="pull-right" style="padding-right: 3px">

                                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>

                                        </div>
                                </CommandItemTemplate>

                                <Columns>
                                    <telerik:GridTemplateColumn DataField="eventID" HeaderText="Event ID" SortExpression="eventID" UniqueName="eventID" DataType="System.Int32" FilterControlAltText="Filter eventID column"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                        <ItemTemplate>
                                            <%# Eval("eventID") %> <a href="/events/eventdetails?ID=<%# Eval("eventID") %>" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
                                        </ItemTemplate>
                                        <ItemStyle  Wrap="false"/>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="eventID" Visible="false"
                                        FilterControlAltText="Filter eventID column"
                                        HeaderText="Event ID"
                                        SortExpression="eventID" UniqueName="eventIDexcel"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                    </telerik:GridBoundColumn>

                                    
                                    <telerik:GridTemplateColumn DataField="AmbassadorName"
                                        FilterControlAltText="Filter AmbassadorName column"
                                        HeaderText="Ambassador Name"
                                        SortExpression="AmbassadorName" UniqueName="AmbassadorNameExcel"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" Visible="false" >
                                        <ItemTemplate>
                                            <%# Eval("AmbassadorName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="AmbassadorName"
                                        FilterControlAltText="Filter AmbassadorName column"
                                        HeaderText="Ambassador Email"
                                        SortExpression="AmbassadorName" UniqueName="AmbassadorEmailExcel"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" Visible="false" >
                                        <ItemTemplate>
                                            <%# Eval("EmailAddress") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridTemplateColumn DataField="AmbassadorName"
                                        FilterControlAltText="Filter AmbassadorName column"
                                        HeaderText="Ambassador Name"
                                        SortExpression="AmbassadorName" UniqueName="AmbassadorName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" >
                                        <ItemTemplate>
                                            <b><%# Eval("AmbassadorName") %></b>

                                            <asp:HyperLink ID="HyperLink1" Target="_blank" runat="server" Visible='<%# Eval("showBALink") %>'
                                                NavigateUrl='<%#"/ambassadors/ViewAmbassadorDetails?UserID=" & Eval("ID") %>'>  <i class="fa fa-external-link" aria-hidden="true"></i></asp:HyperLink>
                                            
                                            <br />
                                            <a href="mailTo:<%# Eval("EmailAddress") %>"><%# Eval("EmailAddress") %></a><br />
                                            <%# Eval("Phone") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Phone" Visible="false"
                                        FilterControlAltText="Filter Phone column"
                                        HeaderText="Phone"
                                        SortExpression="Phone" UniqueName="PhoneExcel"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" 
                                        DataFormatString="{0:(###)###-####}" HtmlEncode="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                        <ItemStyle Wrap="false" />
                                        <HeaderStyle Wrap="false" />
                                    </telerik:GridBoundColumn>



                                    <telerik:GridBoundColumn DataField="supplierName"
                                        FilterControlAltText="Filter supplierName column"
                                        HeaderText="Supplier Name"
                                        SortExpression="supplierName" UniqueName="supplierName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Wrap="false" />
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

                                    <telerik:GridTemplateColumn AllowFiltering="true" ShowFilterIcon="false" CurrentFilterFunction="EqualTo" Visible="false"
                                        DataField="eventDate"
                                        UniqueName="eventDate"
                                        HeaderText="Date"
                                        SortExpression="eventDate">
                                        <ItemStyle  Wrap="false"/>
                                        <ItemTemplate>
                                            <%# Eval("eventDate") %> <%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridBoundColumn DataField="shortEventDate" HeaderText="Date" SortExpression="shortEventDate" UniqueName="shortEventDate" DataType="System.String" FilterControlAltText="Filter shortEventDate column" FilterCheckListEnableLoadOnDemand="true">
                                        <ItemStyle Width="60px" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="shortStartTime" HeaderText="Start" SortExpression="shortStartTime" UniqueName="shortStartTime" DataType="System.String" FilterControlAltText="Filter shortStartTime column" CurrentFilterFunction="EqualTo" FilterCheckListEnableLoadOnDemand="true">
                                        <ItemStyle Width="70px" Wrap="false" />
                                    </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="shortEndTime" HeaderText="End" SortExpression="shortEndTime" UniqueName="shortEndTime" DataType="System.String" FilterControlAltText="Filter shortEndTime column" CurrentFilterFunction="EqualTo" FilterCheckListEnableLoadOnDemand="true">
                                                <ItemStyle Width="70px" Wrap="false" />
                                            </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="Training" UniqueName="Training" >
                                        <ItemTemplate>

                                            <%# getTrainingResult(Eval("eventID"), Eval("UserID")) %>

                                        </ItemTemplate>
                                        <HeaderStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>

                                    <%--<telerik:GridTemplateColumn HeaderText="Training" UniqueName="TrainingExcel" Visible="false">
                                        <ItemTemplate>

                                            <%# getTrainingResultNostyle(Eval("eventID"), Eval("UserID")) %>

                                        </ItemTemplate>
                                        <HeaderStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>--%>


                                    <telerik:GridBoundColumn DataField="checkInTime"
                                        FilterControlAltText="Filter checkInTime column"
                                        HeaderText="Check-In Time"
                                        SortExpression="checkInTime" UniqueName="checkInTime"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Wrap="false" />
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn HeaderText="POS" AllowFiltering="true" UniqueName="PosStatus" DataField="PosStatus" SortExpression="PosStatus"
                                        FilterCheckListEnableLoadOnDemand="false">
                                        <ItemTemplate>
                                            <%# Eval("PosStatus") %><br />

                                            <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" NavigateUrl='<%# getTracking(Eval("eventID")) %>' Visible='<%# Eval("showtrackingLink") %>'>Check Status <i class="fa fa-external-link" aria-hidden="true"></i></asp:HyperLink><br />
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("shippingAddress") %>' Visible='<%# Eval("showtrackingLink") %>' /><br />
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("shippingAddress2") %>' Visible='<%# Eval("showtrackingLink") %>' />

                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="POS" AllowFiltering="true" UniqueName="PosStatusExcel" DataField="PosStatus" SortExpression="PosStatus"
                                        FilterCheckListEnableLoadOnDemand="false" Visible="false">
                                        <ItemTemplate>
                                            <%# Eval("PosStatus") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Location" AllowFiltering="true" UniqueName="accountName" DataField="accountName" SortExpression="accountName"
                                        FilterCheckListEnableLoadOnDemand="false">
                                        <ItemTemplate>
                                            <a href='/Accounts/AccountDetails?AccountID=<%# Eval("locationID")%>' style="color: cornflowerblue"><%# Eval("accountName")%></a><br />
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

                                    </Columns>

                                <PagerStyle Position="TopAndBottom" />

                            </MasterTableView>
                        </telerik:RadGrid>

                       <%-- <asp:SqlDataSource runat="server" ID="getAssignments" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                            SelectCommand="getAssignments_ByUserID" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenUserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="fromDate" Type="DateTime"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="toDate" Type="DateTime"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>--%>
                    </div>
                    </div>
            </asp:Panel>


            </div>


            </div>

</asp:Panel>



         </div>

     <%--<asp:SqlDataSource ID="getEventsByUserID" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
         SelectCommand="getEventAssignmentsByUserID" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenUserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="fromDate" Type="DateTime"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="toDate" Type="DateTime"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>--%>



    <script type="text/javascript">
        $('#events').addClass('active');
        $('.ui-tooltip').tooltip();
    </script>




</asp:Content>
