<%@ Page Title="Event Scheduler" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EventScheduler.aspx.vb" Inherits="EventManagerApplication.EventScheduler" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hidden values for map -->
    <asp:HiddenField ID="LatitudeTextBox" runat="server" />
    <asp:HiddenField ID="LongtitudeTextBox" runat="server" />
    <asp:HiddenField ID="LocationTextBox" runat="server" />
    <asp:HiddenField ID="LocationNameMap" runat="server" />

    <asp:HiddenField ID="EventIDHiddenField" runat="server" />

    <asp:HiddenField ID="MarketIDHiddenField3" runat="server" />

         <link href="/css/infoboxStyles.css" rel="stylesheet" />
    <link href="Theme/css/custom1.css" rel="stylesheet" />


    <style>
        .infobox-body {
            height: 150px !important;
            width: 270px !important;
            max-width: 300px !important;
            max-height: 200px !important;
        }
    </style>

        <style>
        @media screen and (min-width: 1150px) and (max-width: 1465px) {
            .hideCol {
                display: none !important;
            }
        }

         .filterWrapper {
        overflow: hidden;
    }



    .filterDropDown1 {
        color: #2a6ca3;
        font-size: 11px;
        margin-bottom: 20px;
    }

    </style>

      <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="css/EventDetails.css" rel="stylesheet" />

    <script>
        function requestStart(sender, args) {

            if (args.get_eventTarget().indexOf("btnExportExcel") > 0 ||

                args.get_eventTarget().indexOf("btnExportExcel") > 0)

                args.set_enableAjax(false);
        }
    </script>

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="requestStart">
        <AjaxSettings>

    <telerik:AjaxSetting AjaxControlID="StaffingPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="StaffingPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<div class="container">
        <div class="row">
            <div class="col-md-12">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />

                </div>

                <span id="total"></span>

            </div>
        </div>
        <!--End Row-->

        <!-- Header Row -->
        <div class="row">
            <div class="col-xs-12 eventDetails">
                <h2>Event Scheduler</h2>

                <asp:Panel ID="BreadCrumbPanel" runat="server">
                    <ol class="breadcrumb">
                        <li><i class="fa fa-home" aria-hidden="true"></i>&nbsp;<a href="/">Dashboard</a></li>
                        <li>
                            <asp:HyperLink ID="ReturnLink1" runat="server" NavigateUrl="/Events/ViewEvents?LoadState=Yes">Events</asp:HyperLink></li>
                        <li>
                            <a href='/Events/EventDetails?ID=<%=Request.QueryString("ID") %>'>Event Details</a></li>

                        <li class="active">Event Scheduler</li>
                    </ol>

                    <a href='/Events/EventDetails?ID=<%=Request.QueryString("ID") %>' class="btn btn-default pull-right"><i class="fa fa-chevron-left" aria-hidden="true"></i>&nbsp;Go Back to Event Details</a>
                </asp:Panel>

                <div class="detail">
                    Event Name:
                    <asp:Label ID="EventNameLabel" runat="server" Font-Bold="true" /><br />
                    Date:
                    <asp:Label ID="EventDateLabel" runat="server" Font-Bold="true" /><br />
                    Event ID:
                    <asp:Label ID="EventIDLabel" runat="server" Font-Bold="true" /><br />
                </div>
                <hr />

            </div>
        </div>
        <!-- /row -->

    <div class="row marginbotton10">
            <div class="col-md-12">

                <div class="form-inline">
                                Market: &nbsp;<telerik:RadComboBox ID="MarketComboBox" runat="server" DataTextField="marketName" AllowCustomText="false" MarkFirstMatch="true" DataSourceID="getMarketList" DataValueField="marketID" Height="200px"  LoadingMessage="Searching..." AutoPostBack="true" Width="280px"></telerik:RadComboBox>
                                                           
                    
                  &nbsp; &nbsp;
                Position:&nbsp;<telerik:RadComboBox ID="PositionComboBox" runat="server" AllowCustomText="false" MarkFirstMatch="true"  Height="200px" Width="275px" LoadingMessage="Searching..." AutoPostBack="true">
                    <Items>
                        <telerik:RadComboBoxItem Text="Off-Premise Brand Ambassador" Value="1" />
                        <telerik:RadComboBoxItem Text="On-Premise Brand Ambassador" Value="2" />
                    </Items>
                </telerik:RadComboBox>

                    <span class="pull-right">
                    <asp:LinkButton ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-warning"><i class="fa fa-envelope" aria-hidden="true"></i> Download Email List</asp:LinkButton>
                    </span>
                    </div>
               </div>
        </div>


    <!-- Map Row -->
    <div class="row">
          <div class="col-md-12">
        <div class="widget stacked">
                                <div class="widget-content">
                                    <div style="margin-bottom: 10px;">
                                        <div>
                                            <asp:HyperLink ID="AccountHyperLink1" runat="server">
                                                <asp:Label ID="AccountNameLabel1" Font-Bold="true" Font-Size="Large" runat="server" />
                                            </asp:HyperLink></div><div>
                                            <asp:Label ID="AccountAddressLabel1" runat="server" />
                                        </div>
                                    </div>

                                    <asp:Panel ID="DirectionsPanel" runat="server">
                                        <div id="direct" style="margin-bottom: 10px; display: none;">
                                            <div class="panel panel-default">
                                                <div class="panel-body">


                                                    <asp:Panel ID="SelectedAmbassadorPanel" runat="server">
                                                        Select an Ambassador <div class="row">
                                                            <div class="col-md-6">
                                                                <asp:DropDownList ID="SelectedDirectionsName" runat="server" CssClass="form-control" DataSourceID="getAmbassadorList" DataTextField="fullName" DataValueField="fullAddress" Width="300px">
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="col-md-6 pull-right">
                                                                <input type="button" value="Get Directions" onclick="createDirections();" class="btn btn-default btn-sm" />

                                                            </div>

                                                        </div>
                                                    </asp:Panel>




                                                    <asp:Panel ID="EnterAddressPanel" runat="server">
                                                        enter a starting address: <asp:TextBox ID="txtFromAddress" runat="server" CssClass="form-control input-sm" />
                                                        <div style="margin-top: 5px;">
                                                            <input type="button" value="Get Directions" onclick="createDirectionsByAddress();" class="btn btn-default btn-sm" />

                                                        </div>

                                                    </asp:Panel>

                                                </div>
                                            </div>

                                        </div>
                                    </asp:Panel>


                                    
                                    <div id='mapDiv' style="position: relative; width: 100%; height: 50%;"></div>
                                    <div style="width: 100%" id="printoutPanel"></div>
                                    <div id="printoutPanelGas"></div>
                                    <div id="printoutPanelGrocery"></div>
                                    <div id="printoutPanelConvenience"></div>
                                    <div id='sdsPageResultsHeader' style="display: none;">
                                        <div id='pageResultsButtons'>
                                            <input type='button' value='<' onclick='pageBackwards();' /> <input type='button' value='>' onclick='pageForward();' /> </div><div id='pageInfo' style="display: none;"></div>
                                    </div>




                                </div></div></div></div>
    
    <!-- Assign BA Selection Tab -->
    <asp:Panel ID="StaffingPanel" runat="server">
                        <div class="widget stacked">
                                <div class="widget-content">

                                    <div class="col-md-12">
                                        <label class="greenlabel pull-right">
                                            Positions Staffed: <asp:Label ID="positionsStaffedCountLabel2" runat="server" /></label>
                                        <label class="redlabel pull-right">
                                            Positions Available: <asp:Label ID="positionsAvailableCountLabel2" runat="server" /></label>
                                    </div>

                                    <div class="col-md-12">
                                    
                                        </div>
                                    <%--<link href="/events/css/RequiredPositions1.css" rel="stylesheet" />--%>

                                    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

                                        <script type="text/javascript">
                                            var resultsPanel;
                                            Sys.Application.add_load(function myfunction() {
                                                resultsPanel = $get("<%= ResultsPanel.ClientID %>");
                                            })

                                        </script>
                                    </telerik:RadCodeBlock>

                                    <style>
                                        .marginbottom5 {
                                            margin-bottom: 5px;
                                        }
                                    </style>

                                    <p>
                                        Total Staffing Spend: <asp:Label ID="TotalSpendLabel" runat="server" Font-Bold="true" />
                                    </p>
                                    <p>
                                        Total Staff Results: <asp:Label ID="StaffCountLabel" runat="server" />
                                    </p>




                                    <!-- Left Column Available BA's -->
                                    <div class="col-md-6">

                                        <div class="row">
                                            <div class="col-md-12" style="margin-bottom: 10px;">

                                                <div class="filterWrapper">
                                                    <div class="filterDropDown1">

                                                        <asp:Panel ID="LookupPanel" runat="server">

                                                            

                                                            <div>

                                                                

                                                                <telerik:RadComboBox ID="LookupAmbassadorText" runat="server" DataTextField="FullName" AllowCustomText="false" MarkFirstMatch="true"
                                                                    DataValueField="userName" Height="200px" Width="280px" LoadingMessage="Searching..." EmptyMessage="Ambassador Name" AutoPostBack="true">
                                                                </telerik:RadComboBox>



                                                                
                                                                    <asp:LinkButton ID="btnClearFiltersAmbassador" runat="server" CssClass="btn btn-default"><i class="fa fa-refresh" aria-hidden="true"></i> Refresh</asp:LinkButton><span class="pull-right"></span></div><!-- /input-group --></asp:Panel></div></div></div></div><div class="row">
                                            <div class="col-md-12">

                                                <div id="trackContainer">

                                                    <asp:Label ID="trackErrorLabel" runat="server" ForeColor="Red" />

                                                    <%--use getAvailableAmbassadorList--%>
                                                    <telerik:RadListView ID="AvailableAmbassadorList" runat="server" Skin="Silk" DataKeyNames="userName,FirstName,LastName"
                                                        ClientDataKeyNames="userName,FirstName,LastName" OnItemDrop="AvailableAmbassadorList_ItemDrop" ItemPlaceholderID="TrackContainer" AllowPaging="True" PageSize="10">

                                                        <ClientSettings AllowItemsDragDrop="true">

                                                            <ClientEvents OnItemDragStarted="itemDragStarted" OnItemDragging="itemDragging" OnItemDropping="trackDropping"></ClientEvents>

                                                        </ClientSettings>


                                                        <LayoutTemplate>
                                                            <div class="RadListView RadListView_Silk overflow" style="padding-right: 15px;">
                                                                <asp:PlaceHolder ID="TrackContainer" runat="server"></asp:PlaceHolder>
                                                            </div>

                                                            <div class="pagerWrapper" id="studentsPager">

                                                                <div class="demoPager">

                                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnFirst"
                                                                        CommandName="Page" CommandArgument="First" Text="First"
                                                                        Enabled="<%#Container.CurrentPageIndex > 0 %>">
                                                                    </telerik:RadButton>

                                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnPrev" 
                                                                        CommandName="Page" CommandArgument="Prev"
                                                                        Text="Prev" Enabled="<%#Container.CurrentPageIndex > 0 %>">
                                                                    </telerik:RadButton>

                                                                    <span class="numericPageSize">Page <%#Container.CurrentPageIndex + 1 %>of <%#Container.PageCount %></span><telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnNext" 
                                                                        CommandName="Page" CommandArgument="Next"
                                                                        Text="Next" Enabled="<%#Container.CurrentPageIndex + 1 < Container.PageCount %>">
                                                                    </telerik:RadButton>

                                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnLast" 
                                                                        CommandName="Page" CommandArgument="Last"
                                                                        Text="Last" Enabled="<%#Container.CurrentPageIndex + 1 < Container.PageCount %>">
                                                                    </telerik:RadButton>

                                                                </div>

                                                                <div>

                                                                    <span class="pageSize">Page Size:</span> <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cmbPageSize" 
                                                                        OnSelectedIndexChanged="cmbPageSize_SelectedIndexChanged" AutoPostBack="true" 
                                                                        Width="60px"
                                                                        SelectedValue="<%#Container.PageSize %>">
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem Text="10" Value="10"></telerik:RadComboBoxItem>
                                                                            <telerik:RadComboBoxItem Text="25" Value="25"></telerik:RadComboBoxItem>
                                                                            <telerik:RadComboBoxItem Text="50" Value="50"></telerik:RadComboBoxItem>
                                                                            <telerik:RadComboBoxItem Text="100" Value="100"></telerik:RadComboBoxItem>
                                                                        </Items>
                                                                    </telerik:RadComboBox>

                                                                </div>
                                                            </div>


                                                        </LayoutTemplate>


                                                        <ItemTemplate>

                                                            <div class="track rlvI">
                                                                <div class="row">
                                                                    <div class="col-md-12">

                                                                        <div class="col-md-2">
                                                                            <div class="row">
                                                                                <div class="col-md-12" draggable="true">
                                                                                    <div class="col-md-5">
                                                                                        <telerik:RadListViewItemDragHandle 
                                                                                            ID="RadListViewItemDragHandle1" runat="server" 
                                                                                            ToolTip="Drag to schedule" 
                                                                                            Visible='<%# hasInvoice() %>'>
                                                                                        </telerik:RadListViewItemDragHandle>
                                                                                    </div>

                                                                                    <div class="col-md-7" draggable="false">
                                                                                        <telerik:RadBinaryImage ID="RadBinaryImage2" runat="server"
                                                                                            draggable="false"
                                                                                            GenerateEmptyAlternateText="true" 
                                                                                            AlternateText="Click to view larger image"
                                                                                            DataValue='<%# IIf(Eval("headshot") IsNot DBNull.Value, Eval("headshot"), New System.Byte(-1) {})%>'
                                                                                            AutoAdjustImageControlSize="false" Width="70px" Height="80px" CssClass="thumbnail img-circle" onclick='<%#CreateWindowScript(Eval("userID"), 1)%>' />
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <!-- end row -->

                                                                        </div>

                                                                        <div class="col-md-10">

                                                                            <div class="col-md-6" style="padding-right: 0px; padding-left: 23px;">
                                                                                <a id="ambassadorlink" draggable="false" target="_blank" href='/ambassadors/ViewAmbassadorDetails?UserID=<%# Eval("UserID") %>'><span style="font-size: medium; font-weight: 400; color: black">
                                                                                    <header><%# Eval("FirstName") %>  <%# Eval("LastName") %></header>
                                                                                </span>
                                                                                </a>
                                                                                <i class="fa fa-envelope" aria-hidden="true"></i>&nbsp;<a href='mailto:<%# Eval("EmailAddress") %> '><%# Eval("EmailAddress") %></a><br /><i class="fa fa-phone-square" aria-hidden="true"></i>&nbsp;<%# Common.FormatPhoneNumber(Eval("Phone").ToString()) %></div><div class="col-md-2"><%# Eval("City")%></div>
                                                                            <div class="col-md-2"><%# Eval("State") %></div>
                                                                            <div class="col-md-2" style="padding: 5px; right: 10px;">
                                                                                <a href="#" class="trigger btn btn-sm btn-default">More Details</a> </div><div class="col-md-12" style="padding-top: 10px;">
                                                                                <asp:Label ID="milesLabel" runat="server" />
                                                                                <%# Eval("miles") %> miles from Event Location <a href='/Events/BrandAmbassadorsDetails.aspx?userID=<%# Eval("UserID") %>&ID=<%=Request.QueryString("ID") %>' onclick="window.open(this.href, '', 'width=600,height=600,toolbar=0,resizable=0'); return false;">(View Map)</a> </div><div class="col-md-12">
                                                                                <asp:Label ID="ConflictLabel" runat="server" Text='<%# checkSchedule(Eval("UserID")) %>' />
                                                                            </div>

                                                                            <div class="col-md-6">
                                                                                <asp:Label ID="IsRequestLabel" runat="server" Text='<%# Eval("Requested") %>'></asp:Label></div><div class="col-md-6" style="bottom: 3px !important; left: 26px !important;">
                                                                                <asp:Button ID="BtnIsRequested" runat="server" Text="Delete Request" CssClass="btn btn-sm btn-danger pull-right"
                                                                                    CommandName="RemoveRequest" CommandArgument='<%# Eval("UserID") %>' Visible='<%# Eval("IsRequested") %>' OnClientClick="javascript:if(!confirm('This action will delete the request for this BA. Are you sure?')){return false;}" />
                                                                            </div>




                                                                        </div>

                                                                        <table style="width: 100%">

                                                                            <tr>
                                                                                <td>
                                                                                    <div class="showDiv" style="padding-left: 0px; padding-top: 10px;">

                                                                                        <div class="col-md-4" style="padding-top: 0px;">
                                                                                            <%-- <h4><span class="label label-success"><i class="fa fa-trophy" aria-hidden="true"></i>BARetc Ambassador</span></h4>--%>
                                                                                            <div class="panel panel-default">
                                                                                                <div class="panel-body">
                                                                                                    Events Participated <span class="badge pull-right"><%# Eval("YTDEventCount") %></span><br />Total Hours TYD <span class="badge pull-right"><%# Eval("YTDHours") %></span><br /><%-- Total Pay YTD  <span class="badge pull-right">$<%# Eval("YTDPay") %></span><br />--%></div></div></div><div class="col-md-8" style="padding-top: 0px;">

                                                                                            <div class="panel panel-default">
                                                                                                <div class="panel-body">

                                                                                                    <%-- <div class="row">
                                                                                                        <div class="form-group">
                                                                                                            <label for="TrainingTextBox" class="col-sm-2">Training:</label>
                                                                                                            <div class="col-sm-10">
                                                                                                                <asp:Label ID="Label8" runat="server" Text='<%# getTrainingResults(Eval("UserID")) %>' />
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>--%>
                                                                                                    <div class="row">
                                                                                                        <div class="form-group">
                                                                                                            <label for="MarketsTextBox" class="col-sm-2">Markets:</label> <div class="col-sm-10">
                                                                                                                <asp:Label ID="marketNameLabel" runat="server" Text='<%# Eval("Markets") %>'></asp:Label></div></div></div><div class="row">
                                                                                                        <div class="form-group">
                                                                                                            <label for="PositionsTextBox" class="col-sm-2">Positions:</label> <div class="col-sm-10">
                                                                                                                <asp:Label ID="AmabassadorPositionLabel" runat="server" Text='<%# Eval("Positions") %>'></asp:Label></div></div></div></div></div></div></div></td></tr></table></div></div></div></ItemTemplate><EmptyDataTemplate>

                                                            <div class="noTracks">
                                                                There are no results to show </div></EmptyDataTemplate></telerik:RadListView></div></div></div><asp:HiddenField ID="HF_ClientID" runat="server" />
                                        <asp:HiddenField ID="HF_MarketID" runat="server" />
                                        <asp:HiddenField ID="HF_PositionID" runat="server" />

                                        <asp:SqlDataSource ID="getAvailableAmbassadorList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                            SelectCommand="getAvailableAmbassador" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="LatitudeTextBox" PropertyName="Value" Name="lat" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="LongtitudeTextBox" PropertyName="Value" Name="long" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="MarketComboBox" PropertyName="SelectedValue" Name="marketID" Type="Int32"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="PositionComboBox" PropertyName="SelectedValue" Name="positionID" Type="Int32"></asp:ControlParameter>
                                                <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                        <%-- <asp:SqlDataSource ID="getAvailableAmbassadorList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [tempAvailableAmbassador] ORDER BY CASE WHEN Requested = '' THEN 1 ELSE 0 END, miles asc"></asp:SqlDataSource>--%>

                                        <asp:SqlDataSource ID="getAvailableAmbassadorListByUserName" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                            SelectCommand="getAvailableAmbassadorByUserID" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="LatitudeTextBox" PropertyName="Value" Name="lat" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="LongtitudeTextBox" PropertyName="Value" Name="long" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_MarketID" PropertyName="Value" Name="marketID" Type="Int32"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_PositionID" PropertyName="Value" Name="positionID" Type="Int32"></asp:ControlParameter>
                                                <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="String" />

                                                <asp:ControlParameter ControlID="LookupAmbassadorText" PropertyName="SelectedValue" Name="userName" Type="String"></asp:ControlParameter>
                                            </SelectParameters>


                                        </asp:SqlDataSource>




                                        <asp:SqlDataSource ID="getAvailableAmbassadorNameList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                            SelectCommand="getAvailableAmbassadorNameList" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="LatitudeTextBox" PropertyName="Value" Name="lat" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="LongtitudeTextBox" PropertyName="Value" Name="long" Type="String"></asp:ControlParameter>

                                                <asp:ControlParameter ControlID="HF_MarketID" PropertyName="Value" Name="marketID" Type="Int32"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_PositionID" PropertyName="Value" Name="positionID" Type="Int32"></asp:ControlParameter>
                                                <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>


                                        <br />
                                    </div>


                                    <!-- Right Column Assignements -->
                                    <div class="col-md-6">
                                        <div class="row">
                                            <!-- The buttons will not be visiable if the event was invoiced -->
                                            <div class="col-md-12" style="margin-bottom: 10px;">
                                                <asp:Label ID="msgLabel1" runat="server" Text=""></asp:Label><div class="btn-group pull-right" role="group" aria-label="...">
                                                    <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-sm btn-primary" />
                                                    <asp:Button ID="btnCancelChanges" runat="server" Text="Cancel" CssClass="btn btn-sm btn-default" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row overflow">

                                            <div id="" class="col-md-12">

                                                <asp:Repeater ID="PositionList" runat="server">
                                                    <HeaderTemplate>
                                                        <div id="div1">
                                                    </HeaderTemplate>

                                                    <ItemTemplate>

                                                        <!-- Item Template with the drop ambassador feature  -->

                                                        <div class="widget stacked ">
                                                            <div class="widget-content">

                                                                <div id="" class="bag">
                                                                    <h4>
                                                                        <asp:Label ID="TitleLabel" runat="server" Text='<%# getPositionName(Eval("positionID"))%>'></asp:Label></h4><!-- assigned panel --><asp:Panel ID="AssignedPanel" runat="server" Visible='<%# getAssigned(Eval("assigned")) %>'>


                                                                        <h4><span class="label label-success pull-left" style="margin-right: 15px;"><%# getFullName(Eval("assignedUserName")) %></span></h4>

                                                                        <asp:LinkButton ID="btnRemoveAssigned" runat="server" CommandName="Remove" CommandArgument='<%# Eval("RequirementID") %>' CssClass="btn btn-xs btn-warning marginbottom5" OnClientClick="javascript:if(!confirm('This action will delete the assigned ambassador from this event. Are you sure?')){return false;}" Visible='<%# hasInvoice() %>'><i class="fa fa-times"></i> Remove</asp:LinkButton><span style="font-size: 14px" class="label label-success pull-right">Staffed</span> </asp:Panel><!-- /end assigned panel --><!-- NOT assigned panel --><asp:Panel ID="NotAssignedPanel" runat="server" Visible='<%# getNotAssigned(Eval("assigned")) %>'>
                                                                        <div id="genreContainer">

                                                                            <asp:LinkButton ID="GenreLink" runat="server" CommandName="ShowTracks" CommandArgument='<%# Eval("RequirementID") %>' onmouseover='this.className += " selected";' onmouseout='this.className = this.className.split(" selected").join("");'>
                                           Unassigned (drag an ambassador from the left)</asp:LinkButton></div><div style="padding: 5px 0 5px 0; margin-bottom: 10px;">
                                                                            <span style="font-size: 14px; margin-bottom: 10px;" class="label label-warning pull-right">Available</span> </div></asp:Panel><!-- /end NOT assigned panel --><table style="width: 100%" class="table-responsive">
                                                                        <tr>
                                                                            <th>Start Time</th><th>End Time</th><th>Rate</th><th class="hideCol">Total Pay</th></tr><tr>

                                                                            <td>
                                                                                <telerik:RadDateTimePicker ID="startTimeRadTimePicker" runat="server" DbSelectedDate='<%# Bind("startTime")%>' Skin="Bootstrap" Width="220px"></telerik:RadDateTimePicker>
                                                                            </td>
                                                                            <td>
                                                                                <telerik:RadDateTimePicker ID="endTimeRadTimePicker" runat="server" DbSelectedDate='<%# Bind("endTime")%>' Skin="Bootstrap" Width="220px"></telerik:RadDateTimePicker>
                                                                            </td>
                                                                            <td>

                                                                                <telerik:RadNumericTextBox ID="RateTextBox" runat="server" NumberFormat-DecimalDigits="2" Culture="en-US" DbValueFactor="1" Type="Currency" Width="100px" ShowSpinButtons="true" DbValue='<%# Bind("rate") %>' DisplayText='<%# Bind("rate", "{0:C}") %>'>
                                                                                    <NumberFormat DecimalDigits="2" ZeroPattern="$n"></NumberFormat>
                                                                                </telerik:RadNumericTextBox>

                                                                            </td>
                                                                            <td class="hideCol" style="padding-top: 15px"><strong>
                                                                                <asp:Label ID="TotalLabel" runat="server" Text='<%# getTotalPay(Eval("RequirementID"))%>'></asp:Label><asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("RequirementID") %>' />
                                                                            </strong></td>

                                                                        </tr>
                                                                    </table>

                                                                    <asp:CompareValidator ID="dateCompareValidator" runat="server" ControlToValidate="endTimeRadTimePicker"
                                                                        ValidationGroup="eventdate" CssClass="errorlabel"
                                                                        ControlToCompare="startTimeRadTimePicker" Operator="GreaterThan" Type="String" ErrorMessage="The end date must be after the start date." />

                                                                </div>
                                                            </div>
                                                        </div>

                                                    </ItemTemplate>

                                                    <FooterTemplate>
                                                        </div>

                                                    </FooterTemplate>
                                                </asp:Repeater>

                                            </div>
                                        </div>


                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1"
                                            ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="assigned"
                                            TableName="tblEventStaffingRequirements" Where="eventID == @eventID">
                                            <WhereParameters>
                                                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>
                                    </div>

                                    <div class="clearFix"></div>


                                    <asp:Panel ID="ResultsPanel" runat="server" CssClass="result">
                                    </asp:Panel>

                                </div>
                            </div>
                            <!-- End of Assign BA Selection Tab -->


        <telerik:RadGrid ID="AmbassaodrEmailListGrid" runat="server" AutoGenerateColumns="false">
            <MasterTableView>
                <Columns>
                    <telerik:GridBoundColumn DataField="userName" ReadOnly="True" HeaderText="User Name" SortExpression="userName" 
                        UniqueName="userName" FilterControlAltText="Filter userName column"></telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="firstName" ReadOnly="True" HeaderText="First Name" SortExpression="firstName" 
                        UniqueName="firstName" FilterControlAltText="Filter firstName column"></telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="lastName" ReadOnly="True" HeaderText="Last Name" SortExpression="lastName" 
                        UniqueName="lastName" FilterControlAltText="Filter lastName column"></telerik:GridBoundColumn>

                     <telerik:GridBoundColumn DataField="EmailAddress" ReadOnly="True" HeaderText="Email Address" SortExpression="EmailAddress" 
                        UniqueName="EmailAddress" FilterControlAltText="Filter EmailAddress column"></telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>

    </asp:Panel>

    </div>



        <asp:LinqDataSource ID="getMarketList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="marketName" TableName="tblMarkets">
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="getEventPositions" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                        EnableDelete="True" EnableInsert="True" EnableUpdate="True"
                                        EntityTypeName="" TableName="tblEventStaffingRequirements" Where="eventID == @eventID">
                                        <WhereParameters>
                                            <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="Int32" />
                                        </WhereParameters>
                                    </asp:LinqDataSource>

    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getAmbassadorList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="fullName" TableName="qryGetAssignedAmbassaorsbyEventIDs" Where="eventID == @eventID">
                                                            <WhereParameters>
                                                                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                                            </WhereParameters>
                                                        </asp:LinqDataSource>


      <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Text="Event status updated to Booked!" Title="Success" TitleIcon="info"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>

     <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification2" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Text="Event status updated to Scheduled!" Title="Success" TitleIcon="info"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>


        <script src="/events/js/RequiredPositions.js"></script>

        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

        <script type="text/javascript">
                                            // close the div in 5 secs
                                            window.setTimeout("closeDiv();", 3000);

                                            function closeDiv() {
                                                // jQuery version
                                                $("#messageHolder").fadeOut("slow", null);
                                            }

                                            function containerMouseover(sender) {
                                                sender.getElementsByTagName("div")[0].style.display = "";
                                            }

                                            function containerMouseout(sender) {
                                                sender.getElementsByTagName("div")[0].style.display = "none";
                                            }

                                            $("#tab1").click(function () {

                                                GetMap();
                                                $('#direct').hide();


                                                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                                                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                                                $("#btnFindGasStationsLink").removeClass("btn-success");


                                            });

                                            $("#tab2").click(function () {

                                                GetMap();
                                                $("#printoutPanel").html("");

                                                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                                                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                                                $("#btnFindGasStationsLink").removeClass("btn-success");

                                                $('#accountTab a:first').tab('show');

                                                $('#tab1').removeClass('active');
                                                $('#tab2').addClass('active');
                                                $('#direct').show();


                                            });

                                            $("#btnFindGroceryStoresLink").click(function () {
                                                $("#btnFindGroceryStoresLink").addClass("btn-success");
                                                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                                                $("#btnFindGasStationsLink").removeClass("btn-success");
                                            });

                                            $("#btnFindConvienienceStoresLink").click(function () {
                                                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                                                $("#btnFindConvienienceStoresLink").addClass("btn-success");
                                                $("#btnFindGasStationsLink").removeClass("btn-success");
                                            });

                                            $("#btnFindGasStationsLink").click(function () {
                                                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                                                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                                                $("#btnFindGasStationsLink").addClass("btn-success");
                                            });



                                            $("a.trigger").click(function (eventObject) {
                                                $(this).parent().parent().next().find('div.showDiv').toggle();
                                                return false;
                                            });

                                            function triggerShowDiv() {
                                                $("a.trigger").click(function (eventObject) {
                                                    $(this).parent().parent().next().find('div.showDiv').toggle();
                                                    return false;
                                                });
                                            };

        </script>


            <script type="text/javascript">
                                            var map = null, infobox, dataLayer;



                function GetMap() {

                    // Initialize the map

                    var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();


                var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'

                map = new Microsoft.Maps.Map(document.getElementById("mapDiv"),
                    {
                        credentials: bingkey,
                        center: new Microsoft.Maps.Location(lat, long),
                        zoom: 9
                    });

                var eventid = $('#<%=EventIDHiddenField.ClientID%>').val();
                var marketID = $('#<%=MarketComboBox.ClientID%>').val();
                var positionID = $('#<%=PositionComboBox.ClientID%>').val()
                


                var ddlMarket = $find('<%=MarketComboBox.ClientID %>');
                var marketValue = ddlMarket.get_selectedItem().get_value();
                var marketText = ddlMarket.get_selectedItem().get_text();

                var ddlPosition = $find('<%=PositionComboBox.ClientID %>');
                var positionValue = ddlPosition.get_selectedItem().get_value();
                var positionText = ddlPosition.get_selectedItem().get_text();

                //alert(countryValue);

                var myString = eventid + ';' + marketValue + ';' + positionValue;

                $.ajax({
                    type: 'POST',
                    url: '/clientService.asmx/GetAvailableAmbassadorMapbyEventID',
                    data: '{"EventID": "' + myString + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        var pins = response.d

                        $.each(pins, function (index, pin) {

                            // alert(pin.VenueName);

                            var pushpinoptions = { color: pin.PushPinIcon };
                            var pins = new Microsoft.Maps.Location(pin.Latitude, pin.Longitude)

                            var pushpin = new Microsoft.Maps.Pushpin(pins, pushpinoptions);

                            var infoboxTemplate = '<div id="infoboxText" style="background-color:White; border: 1px solid rgb(136, 136, 136); min-height:130px; width: 250px; "><b id="infoboxTitle" style="position: absolute; top: 10px; left: 10px; width: 220px; ">{title}</b><p id="infoboxDescription" style="position: absolute; top: 50px; left: 10px; width: 220px; ">{description}</p></div>';

                            var myDescription = "<div style='line-height: 18px; position: absolute; top: 7%; left: 4%; font-size: 12px;'><div style='font-size: 13px;color: black;'><b>" + pin.EventName + "</b><br />" + pin.City + ", " + pin.State + "</div><br />" + pin.VenueName + "</div><div><br />" + pin.Supplier + "<br /></div></div>";

                            var infobox2 = new Microsoft.Maps.Infobox(pins, {
                                description: myDescription,
                                visible: false
                            });


                            infobox2.setMap(map);

                            Microsoft.Maps.Events.addHandler(pushpin, 'click', function () {
                                infobox2.setOptions({ visible: true });
                            });


                            map.entities.push(pushpin);

                        });


                    },
                    error: function (e, ajaxOptions, thrownError) {
                        //alert("something went wrong: " + e.status);
                        //  alert(thrownError);
                    }
                });

                }

    </script>

            </telerik:RadScriptBlock>

    <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release&callback=GetMap' async defer></script>
    

    <style>
        .FixWidth {
            width: 380px;
        }
    </style>
</asp:Content>
