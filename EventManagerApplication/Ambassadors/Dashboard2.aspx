<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Dashboard2.aspx.vb" Inherits="EventManagerApplication.Dashboard21" %>

<%@ Register Src="~/Ambassadors/UserControls/NeedRecapControl.ascx" TagPrefix="uc1" TagName="NeedRecapControl" %>
<%@ Register Src="~/Ambassadors/UserControls/UpcomingControl.ascx" TagPrefix="uc1" TagName="UpcomingControl" %>
<%@ Register Src="~/Ambassadors/UserControls/PreviousControl.ascx" TagPrefix="uc1" TagName="PreviousControl" %>
<%@ Register Src="~/Ambassadors/UserControls/ScheduledControl.ascx" TagPrefix="uc1" TagName="ScheduledControl" %>
<%@ Register Src="~/Ambassadors/UserControls/ProcessingControl.ascx" TagPrefix="uc1" TagName="ProcessingControl" %>
<%@ Register Src="~/Ambassadors/UserControls/PaidControl.ascx" TagPrefix="uc1" TagName="PaidControl" %>
<%@ Register Src="~/Ambassadors/UserControls/TodaysEventsControl.ascx" TagPrefix="uc1" TagName="TodaysEventsControl" %>
<%@ Register Src="~/Ambassadors/UserControls/AmbassadorCalendarControl.ascx" TagPrefix="uc1" TagName="AmbassadorCalendarControl" %>
<%@ Register Src="~/Ambassadors/UserControls/AmbassadorMapControl.ascx" TagPrefix="uc1" TagName="AmbassadorMapControl" %>
<%@ Register Src="~/Ambassadors/UserControls/AvailableControl.ascx" TagPrefix="uc1" TagName="AvailableControl" %>
<%@ Register Src="~/Application/Classroom/UserControls/CompletedTestsControl.ascx" TagPrefix="uc1" TagName="CompletedTestsControl" %>
<%@ Register Src="~/Application/Classroom/UserControls/AvailableTestsControl.ascx" TagPrefix="uc1" TagName="AvailableTestsControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <link href="viewAmbassador.css" rel="stylesheet" />

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

        .stat-container {
    display: table;
    margin-bottom: 1.5em;
    width: 100%;
    padding-top:10px;
    text-align: center;
}

        .stat-holder {
    display: table-cell;
    width: 25%;
}


        .stat span {
    display: block;
    margin-bottom: 0.4em;
    font-size: 32px;
    font-weight: 600;
    font-style: normal;
    color: #4a515b;
}



.widget .widget-content {
    padding: 0 0 0;
    padding-left: 10px;
}

    </style>

    <div class="container min-height">

        <div class="row">
            <div id="messageHolder">
                <asp:Literal ID="msgLabel" runat="server" />
            </div>
        </div>

        <div class="row">
            <div class="col-sm-3">
               
                <div>
                    <div class="widget stacked">
                    <div class="widget-content">
                         <asp:Repeater ID="headshot" runat="server" DataSourceID="getHeadShot1">
                                    <ItemTemplate>
                                        <div class="hidden-xs">
                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail" GenerateEmptyAlternateText="true" AlternateText="No image uploaded"
                                            DataValue='<%#IIf(TypeOf (Eval("headShot")) Is DBNull, Nothing, Eval("headShot"))%>'
                                            Height="90px" Width="90px" ResizeMode="Fit" /></div>

                                        <div class="visible-xs">
                                        <telerik:RadBinaryImage ID="RadBinaryImage2" runat="server" CssClass="thumbnail" GenerateEmptyAlternateText="true" AlternateText="No image uploaded"
                                            DataValue='<%#IIf(TypeOf (Eval("headShot")) Is DBNull, Nothing, Eval("headShot"))%>'
                                            Height="70px" Width="70px" ResizeMode="Fit" /></div>

                                    </ItemTemplate>
                                </asp:Repeater>

                                <a id="editProfileLink" href="/application/profile" class="btn btn-sm btn-default" runat="server" style="margin-bottom: 10px;"><i class="fa fa-pencil"></i> Edit Profile</a>

                         <asp:SqlDataSource runat="server" ID="getHeadShot1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [headshot], [bodyshot] FROM [tblAmbassadorPhoto] WHERE ([userID] = @userID)">
            <SelectParameters>
                <asp:SessionParameter SessionField="CurrentUserID" Name="UserID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
                        </div>
                        </div>
                    </div>


                <div>
                    <div class="widget stacked">
                    <div class="widget-content">
                    stats
                        </div>
                        </div>
                </div>

            </div>

            <div class="col-sm-9">

                <div class="col-sm-12">
                    banner
                </div>

                <div class="col-sm-3">

                    <div class="widget stacked">
                    <div class="widget-content">
                    <div class="stat-container">
                    <div class="stat-holder">
                       <div class="stat">							

							<span><asp:Label ID="AvailableCountLabel" runat="server" /></span>							

							Available Events							

						</div>
                        </div>
                        </div>
                        </div>
                        </div>


                    </div>
                <div class="col-sm-3">
                    <div class="widget stacked">
                    <div class="widget-content">
                        Needs Recap
                        </div>
                        </div>
                    </div>
                <div class="col-sm-3">
                    <div class="widget stacked">
                    <div class="widget-content">
                        Upcoming Events
                        </div>
                        </div>
                    </div>
                <div class="col-sm-3">
                    <div class="widget stacked">
                    <div class="widget-content">
                        Previous Events
                        </div>
                        </div>
                    </div>

                <div class="col-sm-12">
                     <div class="widget stacked">

                         <div class="widget-header">
					<i class="icon-star"></i>
					<h3>Available Events</h3>
				</div> <!-- /widget-header -->

                    <div class="widget-content">
                    <uc1:AvailableControl runat="server" id="AvailableControl" />
                        </div>
                         </div>
                </div>



        




            </div>
        </div>

        <div class="row">
                     <div class="col-sm-6">
                     <div class="widget stacked">

                         <div class="widget-header">
					<i class="icon-star"></i>
					<h3>Calendar</h3>
				</div> <!-- /widget-header -->

                    <div class="widget-content">
                    <uc1:AmbassadorCalendarControl runat="server" id="AmbassadorCalendarControl" />
                        </div>
                         </div>



                         

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

                <div class="col-sm-6">
                     <div class="widget stacked">

                         <div class="widget-header">
					<i class="icon-star"></i>
					<h3>Map</h3>
				</div> <!-- /widget-header -->

                    <div class="widget-content">
                     <uc1:AmbassadorMapControl runat="server" id="AmbassadorMapControl" />
                        </div>
                         </div>
                </div>
        </div>


    </div>
</asp:Content>
