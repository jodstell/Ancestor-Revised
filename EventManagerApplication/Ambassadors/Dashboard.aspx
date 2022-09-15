<%@ Page Title="Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Dashboard.aspx.vb" Inherits="EventManagerApplication.Dashboard2" %>

<%@ Register Src="~/Ambassadors/UserControls/NeedRecapControl.ascx" TagPrefix="uc1" TagName="NeedRecapControl" %>
<%@ Register Src="~/Ambassadors/UserControls/UpcomingControl.ascx" TagPrefix="uc1" TagName="UpcomingControl" %>
<%@ Register Src="~/Ambassadors/UserControls/PreviousControl.ascx" TagPrefix="uc1" TagName="PreviousControl" %>
<%--<%@ Register Src="~/Ambassadors/UserControls/ScheduledControl.ascx" TagPrefix="uc1" TagName="ScheduledControl" %>--%>
<%--<%@ Register Src="~/Ambassadors/UserControls/ProcessingControl.ascx" TagPrefix="uc1" TagName="ProcessingControl" %>--%>
<%--<%@ Register Src="~/Ambassadors/UserControls/PaidControl.ascx" TagPrefix="uc1" TagName="PaidControl" %>--%>
<%@ Register Src="~/Ambassadors/UserControls/TodaysEventsControl.ascx" TagPrefix="uc1" TagName="TodaysEventsControl" %>
<%@ Register Src="~/Ambassadors/UserControls/AmbassadorCalendarControl.ascx" TagPrefix="uc1" TagName="AmbassadorCalendarControl" %>
<%@ Register Src="~/Ambassadors/UserControls/AmbassadorMapControl.ascx" TagPrefix="uc1" TagName="AmbassadorMapControl" %>
<%--<%@ Register Src="~/Ambassadors/UserControls/AvailableControl.ascx" TagPrefix="uc1" TagName="AvailableControl" %>--%>
<%@ Register Src="~/Application/Classroom/UserControls/CompletedTestsControl.ascx" TagPrefix="uc1" TagName="CompletedTestsControl" %>
<%@ Register Src="~/Application/Classroom/UserControls/AvailableTestsControl.ascx" TagPrefix="uc1" TagName="AvailableTestsControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



    <style>
        #totalevents {
            font-size: 32px;
        }

        h5 {
            font-size: 18px;
        }

        .title-block {
            font-size: 14px;
        }

        .overflow {
            height: 375px;
            overflow: auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        @media (max-width: 480px) {
            .nav-tabs > li {
                float: none;
            }
            }

        @media (min-width: 320px) and (max-width: 1024px) {
                .table > tbody > tr > td
                {
                    padding: 3px;
                }

                .col-md-12
                {
                    padding-right: 10px;
                    padding-left: 10px;
                }

                .main .container
                {
                    padding: 10px !important;
                }

                table
                {
		            overflow-x: auto;
	            }

            }
                

            .widget .widget-content {
                padding: 0 0 0;
                padding-left: 10px;
            }

        @media (min-width: 990px) and (max-width: 1190px) {
            .col-md-9 {
                width: 76%;
            }
            
        }

        @media (min-width: 770px) and (max-width: 990px) {
            .subnav-collapse.collapse {
                width: 630px;
            }

            .subnavbar .mainnav > li {
                background-color: #3B3B3B;
            }
        }

    </style>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" Modal="true"  />

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">


        <script type="text/javascript">
            // close the div in 5 secs
            window.setTimeout("closeDiv();", 3000);

            function closeDiv() {
                // jQuery version
                $("#messageHolder").fadeOut("slow", null);
            }

        </script>

    </telerik:RadScriptBlock>

    <link href="viewAmbassador.css" rel="stylesheet" />

<%--<telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">--%>

    <asp:Panel ID="Panel1" runat="server">

    <div class="container min-height">

        <div class="row">
            <div id="messageHolder">
                <asp:Literal ID="msgLabel2" runat="server" />
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12">
                <h2>Welcome
                    <asp:Label ID="AccountNameLabel" runat="server" />!</h2>

            </div>
        </div>

        <div class="row">
            <!-- Profile Box -->
            <div class="col-md-5 col-xs-12 col-sm-12">

                <div class="widget stacked">
                    <div class="widget-content" style="padding-left: 25px">

                        <div class="row" style="padding-right: 7px;">
                            <div class="col-md-3 col-sm-3 col-xs-3">
                                <asp:Repeater ID="headshot" runat="server" DataSourceID="getHeadShot1">
                                    <ItemTemplate>
                                        <div class="hidden-xs">
                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail" GenerateEmptyAlternateText="true" AlternateText="No image uploaded"
                                            DataValue='<%#IIf(TypeOf (Eval("headShot")) Is DBNull, Nothing, Eval("headShot"))%>'
                                            Height="120px" Width="120px" ResizeMode="Fit" /></div>

                                        <div class="visible-xs">
                                        <telerik:RadBinaryImage ID="RadBinaryImage2" runat="server" CssClass="thumbnail" GenerateEmptyAlternateText="true" AlternateText="No image uploaded"
                                            DataValue='<%#IIf(TypeOf (Eval("headShot")) Is DBNull, Nothing, Eval("headShot"))%>'
                                            Height="70px" Width="70px" ResizeMode="Fit" /></div>

                                    </ItemTemplate>
                                </asp:Repeater>

                            </div>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <div style="font-size: medium"><strong>
                                    <asp:Label ID="FullNameLabel" runat="server" /></strong></div>
                                <asp:Label ID="MessagesLabel" runat="server" Text="Events Participated " />
                                <span class="badge pull-right">
                                    <asp:Label ID="CountLabel" runat="server" Text="" /></span><br />
                                <asp:Label ID="MyConnectionsLabel" runat="server" Text="Total Hours YTD " />
                                <span class="badge pull-right">
                                    <asp:Label ID="TotalHoursLabel" runat="server" /></span><br />
                                <asp:Label ID="Label1" runat="server" Text="Total Pay YTD  " />
                                <span class="badge pull-right">
                                    <asp:Label ID="Label2" runat="server" /></span><br /><br />

                                 <a id="editProfileLink" href="/application/profile" class="btn btn-sm btn-default" runat="server" style="margin-bottom: 10px;"><i class="fa fa-pencil"></i> Edit Profile</a>
                            </div>
                        </div>
                        <%--End Row--%>

                        <%--<div class="row" style="height: 43px;">
                            <div class="col-md-12" style="font-size: smaller">
                                <span>
                                    <asp:Label ID="ProfileProgressText" runat="server" Text="Profile 60% complete" /></span><span class="font-size:smaller; pull-right"><a href="/Application/profile"><asp:Label ID="UpdateLabel" runat="server" Text="Update Profile" /></a></span>
                                <div class="progress">
                                    <div class="progress-bar pr" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                                        <span class="sr-only">60% Complete</span>
                                    </div>
                                </div>
                            </div>
                        </div>--%>
                        <%--End Row--%>
                    </div>
                    <%--End Panel Body--%>
                </div>
                <%--End Panel--%>
            </div>
            <!-- Todays Schedule -->
            <div class="col-md-7 col-xs-12 col-sm-12">
                <h4 style="color: black; font-weight: bold;">Today's Scheduled Event - <br /><asp:Label ID="CurrentDateLabel" runat="server" /></h4>
                <uc1:TodaysEventsControl runat="server" id="TodaysEventsControl" />
            </div>





        </div>

        <asp:SqlDataSource runat="server" ID="getHeadShot1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [headshot], [bodyshot] FROM [tblAmbassadorPhoto] WHERE ([userID] = @userID)">
            <SelectParameters>
                <asp:SessionParameter SessionField="CurrentUserID" Name="UserID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:Label ID="msgLabel" runat="server" />



        <div class="row ">

            <div class="col-md-5 col-xs-12 col-sm-12">

                <h3 style="color: black; font-weight: bold;">My Events</h3>
                <div class="bs-example">


                    <ul id="eventsTab2" class="nav nav-tabs">

                        <li class="active"><a href="#recap" data-toggle="tab">Needs Recap <span class="badge"><asp:Label ID="RecapCountLabel" runat="server" /></span></a></li>
                        <li class=""><a href="#upcoming" data-toggle="tab">Upcoming <span class="badge"><asp:Label ID="UpcomingCountLabel" runat="server" /></span></a></li>
                        <li class=""><a href="#previous" data-toggle="tab">Previous <span class="badge"><asp:Label ID="PreviousCountLabel" runat="server" /></span></a></li>

                    </ul>

                </div>

                <div class="tab-content">


                    <div class="tab-pane fade active in" id="recap">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                   <uc1:NeedRecapControl runat="server" ID="NeedRecapControl1" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="upcoming">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                   <uc1:UpcomingControl runat="server" ID="UpcomingControl1" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="previous">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    <uc1:PreviousControl runat="server" ID="PreviousControl1" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                </div>

            </div>

            <div class="col-md-7 col-xs-12 col-sm-12">

                <%--<h3 style="color: black; font-weight: bold;">Available Events</h3>
                <div class="bs-example">


                    <ul id="eventsTab" class="nav nav-tabs">

                        <li class="active"><a href="#available" data-toggle="tab">Available <span class="badge"><asp:Label ID="AvailableCountLabel" runat="server" /></span></a></li>

                    </ul>

                </div>

                <div class="tab-content">

                    <div class="tab-pane fade active in" id="available">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    <uc1:AvailableControl runat="server" id="AvailableControl" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>


                </div>--%>


                <div class="row">
            <div class="col-sm-12">

                <h3 style="color: black; font-weight: bold;">Training</h3>

                 <div class="bs-example">


                    <ul id="trainingTabs" class="nav nav-tabs">

                        <li class="active"><a href="#recap" data-toggle="tab">Courses&nbsp;<span class="badge"><asp:Label ID="CourseCountLabel" runat="server" /></span></a></li>
                        <%--<li class=""><a href="#upcoming" data-toggle="tab">Upcoming <span class="badge"><asp:Label ID="Label3" runat="server" /></span></a></li>
                        <li class=""><a href="#previous" data-toggle="tab">Previous <span class="badge"><asp:Label ID="Label4" runat="server" /></span></a></li>--%>

                    </ul>

                </div>

                <div class="tab-content">
                    <div class="tab-pane fade active in" id="available">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">

                                    <telerik:RadGrid ID="ActiveCourseList" runat="server" AutoGenerateColumns="False"
                                        DataSourceID="GetTrainingResults" AllowPaging="true" AllowSorting="true">


                                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="CourseID" CommandItemDisplay="None" AllowSorting="true">

                                                <NoRecordsTemplate>

                                                    <br />
                                                    <div class="col-md-12">
                                                        <div class="alert alert-warning" role="alert"><strong>No Schools Found.</strong>  Please adjust your filter options.</div>
                                                    </div>

                                                </NoRecordsTemplate>

                                                <RowIndicatorColumn>
                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                </RowIndicatorColumn>

                                                <Columns>

                                    <telerik:GridTemplateColumn>
                                        <ItemTemplate>
                                            <a href='<%# Eval("CourseID", "/application/classroom/lessonplan?CourseID={0}") %>' class="btn btn-primary btn-xs" style="color:white">Go to Course &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>
                                            
                                                        <br />


                                                        <%--<%# getRequiredCurriculumCount(Eval("CourseID")) %>--%>
                                        </ItemTemplate>
                                        <ItemStyle Width="160px" />
                                    </telerik:GridTemplateColumn>
                                                    
                                            <telerik:GridBoundColumn DataField="CourseTitle" HeaderText="Brand Training" SortExpression="CourseTitle">

                                            </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Percent Complete">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label2" runat="server" Text='<%# calculatPersentComplete(Eval("CurriculumCount"), Eval("CurriculumCompletedCount")) %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    
                                                    <telerik:GridTemplateColumn HeaderText="Quiz/Tests">
                                                        <ItemTemplate>
                                                           <b><%# Eval("PassedCount") %></b> out of <b><%# Eval("TestCount") %></b> Complete
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                   
                                                </Columns>

                                            </MasterTableView>

                                            <PagerStyle Position="TopAndBottom" />


                                        </telerik:RadGrid>

                                    <asp:SqlDataSource ID="GetTrainingResults" runat="server" ConnectionString='<%$ ConnectionStrings:LMSConnection %>' SelectCommand="BrandTrainingResultByUserID" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:SessionParameter SessionField="CurrentUserName" Name="UserName" Type="String"></asp:SessionParameter>
                                            
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    
                                    


                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>


                </div>
                    </div>

                    
                </div>
             </div>



        <%--<div class="row">
            <div class="col-sm-12">

                <h3 style="color: black; font-weight: bold;">Payments</h3>
                <div class="bs-example">
                    <ul id="paymentsTab" class="nav nav-tabs">
                        <li class="active"><a href="#scheduled" data-toggle="tab">Scheduled</a></li>
                        <li class=""><a href="#processing" data-toggle="tab">Processing</a></li>
                        <li class=""><a href="#paid" data-toggle="tab">Paid</a></li>

                    </ul>
                </div>

                <div class="tab-content">
                    <div class="tab-pane fade active in" id="scheduled">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    <uc1:ScheduledControl runat="server" ID="ScheduledControl" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="processing">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    <uc1:ProcessingControl runat="server" ID="ProcessingControl" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="paid">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    <uc1:PaidControl runat="server" ID="PaidControl" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                </div>

            </div>
        </div>--%>



            </div>
            <!-- End Row -->

          


         <%--<div class="col-md-5 col-xs-12 col-sm-12">

              <h3 style="color: black; font-weight: bold;">Calendar & Map</h3>
                <div class="bs-example">


                    <ul id="calendarTab" class="nav nav-tabs">

                        <li class="active"><a href="#calendar" data-toggle="tab">Calendar</a></li>
                        <li class=""><a href="#map" data-toggle="tab">Map</a></li>
                    </ul>

                </div>

             <div class="tab-content">
                    <div class="tab-pane fade active in" id="calendar">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    <uc1:AmbassadorCalendarControl runat="server" id="AmbassadorCalendarControl" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>

                  <div class="tab-pane fade" id="map">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    <uc1:AmbassadorMapControl runat="server" id="AmbassadorMapControl" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>

                 </div>



             </div>--%>



        </div>

         
    </div>

    </asp:Panel>

<%--</telerik:RadAjaxPanel>--%>
    <asp:HiddenField ID="GUID" runat="server" />

    <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
         <script type="text/javascript">
            function ShowLoadingPanel() {
                    var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                    var currentUpdatedControl = "<%= Panel1.ClientID %>";
                    loadingPanel.set_modal(true);
                    loadingPanel.show(currentUpdatedControl);
                }
         </script>
     </telerik:RadScriptBlock>

</asp:Content>
