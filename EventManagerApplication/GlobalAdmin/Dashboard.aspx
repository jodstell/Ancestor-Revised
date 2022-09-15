<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin.Master" CodeBehind="Dashboard.aspx.vb" Inherits="EventManagerApplication.Dashboard5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="container">
            <div class="row">
            </div>


            <div class="row">
                <div class="col-md-12">
                    <h2>Site Administration</h2>
                    <br />

                    <div id="Tabs" role="tabpanel">
                        <!-- Nav tabs -->
                        <%--<ul id="MainTab" class="nav nav-tabs" role="tablist" style="margin-bottom: 3px; border-bottom: 0">
                        <li class="active"><a href="#configuration" data-toggle="tab">Configuration</a></li>
                        <li class=""><a href="#clients" data-toggle="tab">Clients</a></li>
                        <li class=""><a href="#users" data-toggle="tab">Users</a></li>

                    </ul>--%>



                        <div class="tab-content">
                            <!-- Configuration Tab -->
                            <div class="tab-pane fade active in" id="configuration">
                                <div class="widget stacked">
                                    <div class="widget-content min-height">

                                        <div id="row1" class="row1" runat="server">

                                            <div class="col-md-12">


                                                <div class="col-md-7">

<%--                                                    <div class="row">

                                                        <h3>Global Settings</h3>

                                                        <div class="col-sm-4 col-xs-6 equalheight">
                                                            <div class="boxSetting">

                                                                <span class="fa-stack fa-3x social">
                                                                    <asp:LinkButton ID="LinkButton1" runat="server">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class='fa fa-cog fa-stack-1x fa-inverse'></i></asp:LinkButton>
                                                                </span>

                                                                <h4>Clients</h4>
                                                                <p>Add or Edit Clients.</p>

                                                            </div>

                                                        </div>

                                                        <div class="col-sm-4 col-xs-6 equalheight">
                                                            <div class="boxSetting">

                                                                <span class="fa-stack fa-3x social">
                                                                    <asp:LinkButton ID="LinkButton2" runat="server">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class='fa fa-users fa-stack-1x fa-inverse'></i></asp:LinkButton>
                                                                </span>

                                                                <h4>Users</h4>
                                                                <p>Add and manage site users.</p>
                                                            </div>

                                                        </div>

                                                        

                                                    </div>--%>

                                                    <div class="row">

                                                        <h3>
                                                            <asp:Label ID="ClientNameLabel" runat="server" Text=""></asp:Label>
                                                            Settings</h3>

                                                        <div class="col-sm-4 col-xs-6 equalheight">
                                                            <div class="boxSetting">

                                                                <span class="fa-stack fa-3x social">
                                                                    <asp:LinkButton ID="btnConfiguration" runat="server">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class='fa fa-cog fa-stack-1x fa-inverse'></i></asp:LinkButton>
                                                                </span>

                                                                <h4>Configuration</h4>
                                                                <p>Edit event and account settings.</p>

                                                            </div>

                                                        </div>

                                                        <div class="col-sm-4 col-xs-6 equalheight">
                                                            <div class="boxSetting">

                                                                <span class="fa-stack fa-3x social">
                                                                    <asp:LinkButton ID="btnViewStaffConfiguration" runat="server" PostBackUrl="~/GlobalAdmin/Clients/Default.aspx">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class='fa fa-wrench fa-stack-1x fa-inverse'></i></asp:LinkButton>
                                                                </span>

                                                                <h4>Client Configuration</h4>
                                                                <p>Manage clients.</p>
                                                            </div>

                                                        </div>

                                                        <div class="col-sm-4 col-xs-6 equalheight">
                                                            <div class="boxSetting">

                                                                <span class="fa-stack fa-3x social">
                                                                    <asp:LinkButton ID="btnEmail" runat="server">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class='fa fa-envelope-o fa-stack-1x fa-inverse'></i></asp:LinkButton>
                                                                </span>

                                                                <h4>Email Messages</h4>
                                                                <p>Edit emails and alerts.</p>
                                                            </div>

                                                        </div>

                                                    </div>

                                                    <div class="row">

                                                        <div class="col-sm-4 col-xs-6 equalheight">
                                                            <div class="boxSetting">

                                                                <span class="fa-stack fa-3x social">
                                                                    <asp:LinkButton ID="btnUsers" runat="server">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class='fa fa-users fa-stack-1x fa-inverse'></i></asp:LinkButton>
                                                                </span>

                                                                <h4>Users</h4>
                                                                <p>Add and manage site users.</p>
                                                            </div>

                                                        </div>

                                                        <div class="col-sm-4 col-xs-6 equalheight">
                                                            <div class="boxSetting">

                                                                <span class="fa-stack fa-3x social">
                                                                    <asp:LinkButton ID="btnViewSiteConfiguration" runat="server">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class='fa fa-cogs fa-stack-1x fa-inverse'></i></asp:LinkButton>
                                                                </span>

                                                                <h4>Site Settings</h4>
                                                                <p>Adjust the site settings.</p>
                                                            </div>

                                                        </div>

                                                        <div class="col-sm-4 col-xs-6 equalheight">
                                                            <div class="boxSetting">

                                                                <span class="fa-stack fa-3x social">
                                                                    <asp:LinkButton ID="btnWeatherAPI" runat="server">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class='fa fa-cloud fa-stack-1x fa-inverse'></i></asp:LinkButton>
                                                                </span>

                                                                <h4>Weather API</h4>
                                                                <p>Connection settings for the weather API.</p>
                                                            </div>

                                                        </div>

                                                    </div>

                                                    <hr />

                                                    




                                                </div>

                                                <div class="col-md-5 col-sidebar-right">

                                                    <asp:Panel ID="StatsPanel" runat="server">

                                                        <div class="widget stacked">

                                                            <div class="widget-header">
                                                                <i class="icon-star"></i>
                                                                <h3>Site Stats</h3>
                                                            </div>
                                                            <!-- /widget-header -->


                                                            <div class="widget-content">

                                                                <div class="stats">

                                                                    <div style="cursor: pointer" class="stat" onclick="CreateWindowScript('/Admin/Pages/CurrentOnlineUsers.aspx', 'Details')">
                                                                        <span class="stat-value">
                                                                            <asp:Label ID="CurrentLoginCountLabel" runat="server" /></span>
                                                                        Current Users
                                                                        <asp:Literal ID="CurrentLoginIcon" runat="server" /><br />
                                                                        Online
                                                                    </div>


                                                                    <!-- /stat -->

                                                                    <div style="cursor: pointer" class="stat" onclick="CreateWindowScript('/Admin/Pages/SiteVisits.aspx', 'RadWindow1')">
                                                                        <span class="stat-value">
                                                                            <asp:Label ID="TotalLoginCount" runat="server" /></span>
                                                                        Site Visits
                                                                        <asp:Literal ID="TotalLoginIcon" runat="server" /><br />
                                                                        (last 24 hrs)
                                                                    </div>
                                                                    <!-- /stat -->

                                                                    <div style="cursor: pointer" class="stat last-stat" style="margin-right: 25px;" onclick="CreateWindowScript('/Admin/Pages/NewVisits.aspx','Details')">
                                                                        <span class="stat-value">
                                                                            <asp:Label ID="NewVisitPercentLabel" runat="server" /></span>
                                                                        New Visits
                                                                        <asp:Literal ID="NewVisitPercentIcon" runat="server" /><br />
                                                                        (last 24 hrs)
                                                                    </div>
                                                                    <!-- /stat -->

                                                                </div>
                                                                <!-- /stats -->



                                                                <div class="stats">

                                                                    <div class="stat" style="cursor: pointer" onclick="CreateWindowScript('/Admin/Pages/NewRecaps.aspx', 'RadWindow2')">
                                                                        <span class="stat-value">
                                                                            <asp:Label ID="RecapsSubmittedLabel" runat="server" /></span>
                                                                        Recaps Submitted
                                                                        <asp:Literal ID="RecapsSubmittedIcon" runat="server" /><br />
                                                                        (last 24 hrs)
                                                                    </div>


                                                                    <!-- /stat -->

                                                                    <div class="stat" style="cursor: pointer" onclick="CreateWindowScript('/Admin/Pages/ApprovedEvents.aspx','Details')">
                                                                        <span class="stat-value">
                                                                            <asp:Label ID="ApprovedEventsCountLabel" runat="server" /></span>
                                                                        Approved Events
                                                                        <asp:Literal ID="ApprovedEventIcon" runat="server" /><br />
                                                                        (last 24 hrs)
                                                                    </div>
                                                                    <!-- /stat -->

                                                                    <div class="stat last-stat" style="margin-right: 25px; cursor: pointer" onclick="CreateWindowScript('/Admin/Pages/NewEvents.aspx','Details')">
                                                                        <span class="stat-value">
                                                                            <asp:Label ID="NewEventsCountLabel" runat="server" /></span>
                                                                        New Events
                                                                        <asp:Literal ID="NewEventIcon" runat="server" /><br />
                                                                        (last 24 hrs)
                                                                    </div>
                                                                    <!-- /stat -->

                                                                </div>
                                                                <!-- /stats -->

                                                                <div class="stats">

                                                                    <div class="stat" style="cursor: pointer" onclick="CreateWindowScript('/Admin/Pages/NewRegistrations.aspx','Details')">
                                                                        <span class="stat-value">
                                                                            <asp:Label ID="NewRegistrationsLabel" runat="server" /></span>
                                                                        New Registrations
                                                                        <asp:Literal ID="NewRegistrationsIcon" runat="server" /><br />
                                                                        (last 24 hrs)
                                                                    </div>


                                                                    <!-- /stat -->

                                                                    <div class="stat" style="cursor: pointer" onclick="CreateWindowScript('/Admin/Pages/BookedEvents.aspx','Details')">
                                                                        <span class="stat-value">
                                                                            <asp:Label ID="NewAssignmentsLabel" runat="server" /></span>
                                                                        Booked Events
                                                                        <asp:Literal ID="NewAssignmentsIcon" runat="server" /><br />
                                                                        (last 24 hrs)
                                                                    </div>
                                                                    <!-- /stat -->

                                                                    <div class="stat last-stat" style="margin-right: 25px; cursor: pointer" onclick="CreateWindowScript('/Admin/Pages/NewAmbassadors.aspx','Details')">
                                                                        <span class="stat-value">

                                                                            <asp:Label ID="NewAmbassadorsLabel" runat="server" /></span>
                                                                        New Ambassadors
                                                                        <asp:Literal ID="NewAmbassadorsIcon" runat="server" /><br />
                                                                        (last 24 hrs)
                                                                    </div>
                                                                    <!-- /stat -->

                                                                </div>
                                                                <!-- /stats -->


                                                            </div>
                                                            <!-- /widget-content -->

                                                        </div>
                                                        <!-- /widget -->

                                                    </asp:Panel>

                                                    <div>

                                                        <%-- <ul class="fa-ul">
                                                        <li><i class="fa-li fa fa-check-square" aria-hidden="true"></i>Successfully connected to GigEngyn version
                                                            <asp:Label ID="LMSVersionLabel" runat="server" /></li>
                                                        <li><i class="fa-li fa fa-check-square" aria-hidden="true"></i>Successfully connected to api services.</li>
                                                        <li><i class="fa-li fa fa-check-square" aria-hidden="true"></i>
                                                            </li>
                                                    </ul>--%>

                                                        <asp:Label ID="lblASPVersion" runat="server" />

                                                        <div class="margintop20">
                                                            <%--<a href="ReleaseNotes" class="btn btn-primary">Release Notes</a>--%>
                                                            <a href="siteactivitylog" class="btn btn-primary">History Log</a>
                                                        </div>


                                                    </div>

                                                </div>
                                            </div>

                                        </div>

                                        <asp:Panel ID="PanelSiteConfiguration" runat="server" Visible="false">
                                        </asp:Panel>

                                        <asp:Panel ID="PanelStaffConfiguration" runat="server" Visible="false">
                                            <asp:Button ID="ButtonStaffConfiguration" runat="server" Text="Back To Site Administration" CssClass="btn btn-default" />
                                            <br />
                                            <br />
                                            <p>Add control here</p>
                                            <%--<uc1:StaffConfigurationControl runat="server" ID="StaffConfigurationControl" />--%>
                                        </asp:Panel>

                                        <asp:Panel ID="PanelWeatherAPI" runat="server" Visible="false">

                                            <asp:Button ID="ButtonWeatherAPIConfiguration" runat="server" Text="Back To Site Administration" CssClass="btn btn-default" />
                                            <asp:Button ID="btnSaveWeather" runat="server" Text="Save Changes" CssClass="btn bg-primary" />
                                            <asp:Button ID="btnUpdateWeather" runat="server" Text="Update Weather Table" CssClass="btn btn-success" /><asp:Label ID="UpdateWeatherResultLabel" runat="server" />
                                            <br />
                                            <br />

                                            <div class="col-md-6">
                                                <div class="form-horizontal">

                                                    <div class="form-group">
                                                        <asp:Label ID="lblAppID" runat="server" Text="App ID" CssClass="col-sm-2 control-label"></asp:Label>
                                                        <div class="col-sm-7">
                                                            <asp:TextBox ID="TextBoxAppID" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <asp:Label ID="lblURL" runat="server" Text="URL" CssClass="col-sm-2 control-label"></asp:Label>
                                                        <div class="col-sm-7">
                                                            <asp:TextBox ID="URLTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                        </asp:Panel>

                                    </div>
                                </div>
                            </div>

                            <!-- Clients Tab -->
                            <%--<div class="tab-pane fade" id="clients">
                           <div class="widget stacked">
                                <div class="widget-content min-height">

                                    <h2>Clients</h2>
                                    <hr />

                                    <asp:Repeater ID="ClientListRepeater" runat="server" DataSourceID="getClientList">
                                        <HeaderTemplate></HeaderTemplate>
                                        <ItemTemplate>
                                            <div class="feature col-sm-3 col-md-3 center">
                                                <div class="panel panel-default min-height250">
                                                    <div class="panel-body">
                                                        <a href='ClientDetails?ClientID=<%# Eval("clientID")%>'>
                                                            <div class="center" style="height: 95px; vertical-align: bottom">
                                                                <asp:Image ID="ClientLogo" runat="server" ImageUrl='<%# Eval("logoURL")%>' CssClass="thumbnail-center" Width="175px" /></div>
                                                        </a>
                                                        <p></p>
                                                        <h4><%# Eval("clientName")%></h4>
                                                        <p></p>
                                                        <a href='ClientDetails?ClientID=<%# Eval("clientID")%>' class="btn btn-primary">Edit Client</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:Repeater>



                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getClientList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="clientID" TableName="tblClients" Where="active == @active">
                                        <WhereParameters>
                                            <asp:Parameter DefaultValue="True" Name="active" Type="Boolean"></asp:Parameter>
                                        </WhereParameters>
                                    </asp:LinqDataSource>



                                </div>
                            </div>
                        </div>--%>

                            <!-- Users Tab -->
                            <%--<div class="tab-pane fade" id="users">--%>



                            <%--</div>--%>
                        </div>

                    </div>
                </div>



            </div>
        </div>
</asp:Content>
