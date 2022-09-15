<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewActivities.aspx.vb" Inherits="EventManagerApplication.ViewActivities" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="ActivityGrid" />
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
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <asp:Panel ID="Panel1" runat="server">

     <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <h2>Activities </h2>
                 <div class="widget-box">
                        <div class="widget-title">
                            <h5>Activities for
                            <asp:Label ID="lblWeek" runat="server" Text="Label" Font-Bold="true" Font-Size="Larger" />
                            </h5>
                        </div>
                    </div>

                <ol class="breadcrumb">
                        <li><a href="/">Dashboard</a></li>
                        <li><a href="/Accounts/ViewAccounts?LoadState=Yes">Accounts</a></li>
                        <li class="active">Activities</li>
                    </ol>
                </div>
            </div>

          <!-- Date Filter -->
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

                </div>

                 <div class="btn-group pull-right viewbuttons" role="group" aria-label="..." style="margin-right: 20px;">
                    <asp:Button ID="btnViewWeek" runat="server" Text="Week" CssClass="btn btn-success ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Current Week" />
                    <asp:Button ID="btnViewMonth" runat="server" Text="Month" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Current Month" />
                </div>

                </div>

                <div class="row">
            <div class="col-sm-12">

                <telerik:RadGrid ID="ActivityGrid" runat="server" DataSourceID="getActivityList" AllowFilteringByColumn="True"
                        AllowPaging="True" AllowSorting="True"
                        AllowCustomPaging="True" PageSize="20"
                        ShowFooter="True" CellSpacing="-1"
                        FilterType="HeaderContext"
                        EnableHeaderContextMenu="true"
                        EnableHeaderContextFilterMenu="true"
                        OnFilterCheckListItemsRequested="ActivityGrid_FilterCheckListItemsRequested">

                    <MasterTableView DataSourceID="getActivityList" AutoGenerateColumns="False" CommandItemDisplay="Top">

                         <NoRecordsTemplate>

                                    <br />
                                    <div class="col-md-12">
                                        <div class="alert alert-warning" role="alert"><strong>No Activities Found.</strong>  Please adjust your filter options.</div>
                                    </div>

                                </NoRecordsTemplate>

                        <CommandItemTemplate>
                                    <div style="padding: 3px 0 3px 5px">




                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                        <div class="pull-right" style="padding-right: 3px">

                                       <asp:LoginView ID="LoginView1" runat="server">
                                           <RoleGroups>
                                               <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, Client, Accounting">
                                                   <ContentTemplate>
                                                       <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcell" CssClass="btn btn-secondary btn-sm pull-right"
                                                           ForeColor="White"><i class="fa fa-download "></i> Export Excel</asp:LinkButton>
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

                                           <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-xs btn-primary" ForeColor="white" CommandName="EditActivity" CommandArgument='<%# Eval("accountActivityID")%>'>View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>


                                            <%--<a href='/accounts/editactivity?ActivityID=<%# Eval("accountActivityID")%>&AccountID=<%# Eval("accountID")%>&Mode=View' class="btn btn-primary btn-xs"style="color: #fff">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>--%>

                                            <br />
                                           <%-- <asp:Label ID="NotificationLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("labelText")%>' />--%>
                                         </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="ActivityName" HeaderText="Activity Type" SortExpression="ActivityName" UniqueName="ActivityName" FilterControlAltText="Filter ActivityName column" FilterCheckListEnableLoadOnDemand="true"></telerik:GridBoundColumn>

                             <telerik:GridBoundColumn DataField="activityDate" HeaderText="Date" SortExpression="activityDate" UniqueName="activityDate" DataType="System.DateTime" DataFormatString="{0:D}" FilterControlAltText="Filter activityDate column" ></telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="status" HeaderText="Status" SortExpression="status" UniqueName="status" FilterControlAltText="Filter status column" FilterCheckListEnableLoadOnDemand="true"></telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="Account" HeaderText="Account Name" SortExpression="Account" UniqueName="Account" FilterControlAltText="Filter Account column"></telerik:GridBoundColumn>


                            <telerik:GridBoundColumn DataField="AccountType" HeaderText="AccountType" SortExpression="AccountType" UniqueName="AccountType" FilterControlAltText="Filter AccountType column" FilterCheckListEnableLoadOnDemand="true"></telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="Market" HeaderText="Market" SortExpression="Market" UniqueName="Market" FilterControlAltText="Filter Market column" FilterCheckListEnableLoadOnDemand="true"></telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>

                     <PagerStyle Position="TopAndBottom" />

                </telerik:RadGrid>


                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getActivityList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="activityDate desc" TableName="qryGetAccountActivities" Where="activityDate >= @activityDate && activityDate <= @activityDate1">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="activityDate" Type="DateTime"></asp:ControlParameter>
                        <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="activityDate1" Type="DateTime"></asp:ControlParameter>
                    </WhereParameters>
                </asp:LinqDataSource>
            </div>
                    </div>
         </div>
        </asp:Panel>

    <script>
        function requestStart(sender, args) {

            if (args.get_eventTarget().indexOf("btnExport") > 0 ||

            args.get_eventTarget().indexOf("btnExport") > 0)

                args.set_enableAjax(false);
        }
    </script>

</asp:Content>
