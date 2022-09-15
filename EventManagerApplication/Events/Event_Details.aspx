<%@ Page Title="Event Details" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Event_Details.aspx.vb" Inherits="EventManagerApplication.Event_Details" %>

<%@ Register Src="~/Events/UserControls/QuestionaireControl.ascx" TagPrefix="uc1" TagName="QuestionaireControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="LatitudeTextBox" runat="server" />
    <asp:HiddenField ID="LongtitudeTextBox" runat="server" />
    <asp:HiddenField ID="LocationTextBox" runat="server" />
    <asp:HiddenField ID="LocationNameMap" runat="server" />

    <asp:Label ID="lblStreetAddress" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblCityAddress" runat="server" Visible="false"></asp:Label>

    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="css/EventDetails.css" rel="stylesheet" />


<div class="container">


    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <%--<telerik:AjaxSetting AjaxControlID="GalleryPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GalleryPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>

            <%--<telerik:AjaxSetting AjaxControlID="UploadPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UploadPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>

            <telerik:AjaxSetting AjaxControlID="RecapPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RecapPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

           <%--<telerik:AjaxSetting AjaxControlID="StaffingPnel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="StaffingPnel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="DetailsPanel" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>

            <telerik:AjaxSetting AjaxControlID="ProductTrainingPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ProductTrainingPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
        
        <%--<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="POSPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="POSPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="LogisticsPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="LogisticsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="DirectionsPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="DirectionsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

    </telerik:RadAjaxManager>


    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"
        Style="position: absolute; top: 0; left: 0; width: 100%; height: 100%">
    </telerik:RadAjaxLoadingPanel>




    <div class="row">
        <div class="col-md-12">
            <div id="messageHolder">
                <asp:Literal ID="msgLabel" runat="server" />

            </div>

            <span id="total"></span>

        </div>
    </div>


    <div class="row">
        <div class="col-xs-12 eventDetails">
            <h2>Event Details</h2>

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


    <div class="row">

        <div class="col-md-6">
            <h4>Event Details</h4>

            <div class="bs-example">
                <ul id="myTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                    <li class="active" runat="server" id="informationTab"><a href="#information" data-toggle="tab">Information</a></li>
                </ul>


                <div class="tab-content">

                    <div class="tab-pane fade active in" id="information">
                        <div class="widget stacked">
                            <div class="widget-content">

                                <asp:Panel ID="DetailsPanel" runat="server">
                                <div class="col-md-6">
                                    <div>
                                        <label>Current Status:</label>
                                        <asp:Label ID="StatusLabel" runat="server" Font-Bold="true" />
                                    </div>

                                    <div>
                                        <label>Event Type:</label>
                                        <asp:Label ID="EventTypeLabel" runat="server" />
                                    </div>

                                    <div>
                                        <label>Market:</label>
                                        <asp:Label ID="MarketLabel" runat="server" />
                                    </div>


                                    <div>
                                        <label>Supplier:</label>
                                        <asp:Label ID="SupplierLabel" runat="server" />
                                    </div>


                                </div>

                                <div class="col-md-6">

                                    <div>
                                        <label>Event Date:</label>
                                        <asp:Label ID="DateLabel" runat="server" />
                                    </div>

                                    <div>
                                        <label>Start Time:</label>
                                        <asp:Label ID="StartTimeLabel" runat="server" />
                                    </div>

                                    <div>
                                        <label>End Time:</label>
                                        <asp:Label ID="EndTimeLabel" runat="server" />
                                    </div>

                                    <div>
                                        <label>Hours:</label>
                                        <asp:Label ID="HoursLabel" runat="server" />
                                    </div>

                                </div>
                                </asp:Panel>

                                <div class="col-md-12">
                                    <div>
                                        <label>Brands:</label>
                                        <asp:Label ID="BrandsLabel" runat="server" />
                                    </div>

                                    <div>
                                        <label>Team:</label>
                                        <asp:Label ID="TeamLabel" runat="server" />
                                    </div>

                                    <hr />
                                    <div>
                                        <label class="tightlabel">Attire:</label><br />
                                        <asp:Literal ID="AttireLabel" runat="server"></asp:Literal>

                                    </div>
                                    <br />
                                    <div>
                                        <label>POS:</label><br />
                                        <asp:Label ID="POSLabel" runat="server" />
                                    </div>
                                    <br />
                                    <div>
                                        <label>Sampling Notes:</label><br />
                                        <asp:Label ID="SamplingLabel" runat="server" />
                                    </div>
                                    <br />
                                    <div>
                                        <label>Additional Instructions:</label><br />
                                        <asp:Label ID="AdditionalInstruvtionsLabel" runat="server" Text="Take a photo of the product in all the locations in the store."></asp:Label>
                                    </div>
                                    <br />
                                    <div>
                                        <label>Event Description:</label><br />
                                        <asp:Label ID="DescriptionLabel" runat="server" />
                                    </div>
                                </div>

                                <!-- End Event Details -->

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>



        <div class="col-md-6">
                <h4>Account/Location</h4>

                <div class="bs-example">

                    <ul id="accountTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                        <li id="tab1" class="active"><a href="#address" data-toggle="tab">Address</a></li>
                        <li id="tab2" class=""><a href="#address" data-toggle="tab">Directions</a></li>
                        <li class="">
                            <a href="#weather" data-toggle="tab">Weather</a>


                        </li>
                    </ul>



                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="address">
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


                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getAmbassadorList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="fullName" TableName="qryGetAssignedAmbassaorsbyEventIDs" Where="eventID == @eventID">
                                                        <WhereParameters>
                                                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>


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

                                    <div style="margin-bottom: 10px;">
                                        <input type="button" id="showTraffic" value="Show Traffic" onclick="MapTraffic()" class="btn btn-xs btn-secondary" /><input type="button" id="hideTraffic" value="Hide Traffic" onclick="    hideTrafficLayer()" class="btn btn-xs btn-secondary" style="display: none" /> </div><div id='mapDiv' style="position: relative; width: 100%; height: 50%;"></div>
                                    <div style="width: 100%" id="printoutPanel"></div>
                                    <div id="printoutPanelGas"></div>
                                    <div id="printoutPanelGrocery"></div>
                                    <div id="printoutPanelConvenience"></div>
                                    <div id='sdsPageResultsHeader' style="display: none;">
                                        <div id='pageResultsButtons'>
                                            <input type='button' value='<' onclick='pageBackwards();' /> <input type='button' value='>' onclick='pageForward();' /> </div><div id='pageInfo' style="display: none;"></div>
                                    </div>


                                    <div style="margin-top: 5px;">

                                        <label>Show Helpful Locations:</label><br />
                                        <div class="btn-group pull-left gridbuttons" role="group" aria-label="...">

                                            <input type="button" id="btnFindGroceryStoresLink" value="Grocery Stores" onclick="GetGroceryStores()" class="btn btn-default" /> <input type="button" id="btnFindConvienienceStoresLink" value="Convenience Stores" onclick="GetConvenienceStores()" class="btn btn-default" /> <input type="button" id="btnFindGasStationsLink" value="Gas Stations" onclick="GetGasStations()" class="btn btn-default" /> </div><div class="btn-group pull-right gridbuttons" role="group" aria-label="...">
                                            <input type="button" id="btnFindPartyStoresLink" value="Clear Locations" onclick="ClearMap()" class="btn btn-default" /> </div></div></div></div></div><div class="tab-pane fade" id="weather">
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <div style="margin-bottom: 5px;">
                                        <div>
                                            <asp:Label ID="CityLabel" Font-Bold="true" Font-Size="X-Large" runat="server" />
                                        </div>

                                    </div>

                                    <asp:Panel ID="WeatherForcastPanel" runat="server">
                                        <asp:Repeater ID="WeatherListRepeater" runat="server" DataSourceID="getWeatherList">
                                            <ItemTemplate>
                                                <div class="row weatherwrapper">
                                            <div class="col-xs-2 datebox">
                                                <asp:Label ID="lblDay0" runat="server" Text='<%# Eval("dayNumber") %>' />
                                                <div class="monthlabel">
                                                    <asp:Label ID="lblMonth0" runat="server" Text='<%# String.Format("{0:MMM}", Eval("weatherDate")) %>' />
                                                </div>

                                            </div>
                                            <div class="col-xs-4 col2">
                                                <div class="daylabel"><%# Eval("day") %></div>
                                                <div class="templabel">
                                                    Low: <asp:Label ID="lblTempMin0" runat="server" Text='<%# Eval("lowTemp") %>' />
                                                </div>
                                                <div class="templabel">
                                                    High: <asp:Label ID="lblTempMax0" runat="server" Text='<%# Eval("highTemp") %>' />
                                                </div>

                                            </div>
                                            <div class="col-xs-4 col3">
                                                <asp:Image ID="imgWeatherIcon0" runat="server" Width="60px" ImageUrl='<%# Eval("icon") %>' />
                                                <div>
                                                    <asp:Label ID="lblMain0" runat="server" Text='<%# Eval("condition") %>' />
                                                </div>
                                            </div>
                                        </div>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                <asp:Label ID="lblEmptyData" Text='<%# Common.ShowAlertNoClose("warning", "There are no weather results found to display.")%>'
                                                    runat="server" Visible="false">
                                                </asp:Label></FooterTemplate></asp:Repeater><!-- Today -->
                                        
                                        <asp:SqlDataSource runat="server" ID="getWeatherList" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                                            SelectCommand="getWeatherbyEvent" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                    </asp:Panel>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>


    </div>



     <!-- Staffing Section -->
        <div id="staffingPanel" runat="server" class="row">
            <div class="col-md-12">
                <h4>Staffing</h4>

                <asp:Panel runat="server" ID="StaffingPnel1">

                    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" AutoPostBack="false" MultiPageID="RadMultiPage1" SelectedIndex="0" Skin="Bootstrap">
                        <Tabs>
                            <telerik:RadTab Text="Status" runat="server" ID="statusTab" Value="status"></telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>

                    <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0" RenderSelectedPageOnly="false">

                        <telerik:RadPageView runat="server" ID="RadPageView1">
                            <!-- Status Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <div class="col-md-12">
                                        <label class="greenlabel pull-right">
                                            Positions Staffed: <asp:Label ID="positionsStaffedCountLabel" runat="server" /></label>
                                        <label class="redlabel pull-right">
                                            Positions Available: <asp:Label ID="positionsAvailableCountLabel" runat="server" /></label>
                                    </div>

                                    <asp:Repeater ID="StaffingList" runat="server" DataSourceID="GetEventStaff2">

                                        <HeaderTemplate>
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <th class="hidden-xs"></th>
                                                        <th>Name</th><th>Position</th><th>Start Time</th><th>End Time</th><th class="hidden-xs">Check-in Time</th><th class="hidden-xs">Check-in Confirmed</th></tr>
                                        </HeaderTemplate>

                                        <ItemTemplate>
                                            <tr>
                                                <td class="hidden-xs">
                                                    <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" GenerateEmptyAlternateText="true" AlternateText="Click to view larger image"
                                                        DataValue='<%# IIf(Eval("headShot") IsNot DBNull.Value, Eval("headShot"), New System.Byte(-1) {})%>'
                                                        AutoAdjustImageControlSize="false" Width="80px" ToolTip='<%#getFullName(Eval("assignedUserName")) %>'
                                                        CssClass="thumbnail" onclick='<%#CreateWindowScript(Eval("userID"), 1)%>' Visible='<%# setImage(Eval("userID")) %>' />
                                                </td>

                                                <td>
                                                <asp:Label ID="HiddenUserID" runat="server" Text='<%# getUserID(Eval("assignedUserName")) %>' Visible="false"></asp:Label>
                                                <asp:Label ID="AssignedNameLabel" runat="server" Text='<%# getFullName(Eval("assignedUserName")) %>'></asp:Label>
                                                </td>
                                                <td><%# Eval("positionTitle") %></td>
                                                <td><%# Eval("startTime", "{0:t}") %></td>
                                                <td><%# Eval("endTime", "{0:t}") %></td>
                                                <td class="hidden-xs"><%# Eval("checkInTime", "{0:t}") %></td>
                                                <td class="hidden-xs"></td>

                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </tbody>
            </table>

                             <asp:Label ID="lblEmptyData"
                                 Text='<%# Common.ShowAlertNoClose("warning", "<strong>No Staffing Requirements Entered.</strong> Click on the Requirements tab above to begin entering staffing requirements for this event.")%>' runat="server" Visible="false">
                             </asp:Label></FooterTemplate></asp:Repeater>
                                    
                                    <asp:SqlDataSource ID="GetEventStaff2" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                        SelectCommand="pr_qryEventStaffingStatus" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                            <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                </div>
                            </div>
                        </telerik:RadPageView>
                        
                    </telerik:RadMultiPage>

                </asp:Panel>

            </div>

        </div>



    <div class="row">

        <div class="col-md-6">
            <h4>Product Training</h4>
            <asp:Panel runat="server" ID="ProductTrainingPanel">

                <telerik:RadTabStrip ID="TrainingRadTabStrip" runat="server" AutoPostBack="false" MultiPageID="TrainingRadMultiPage" SelectedIndex="0" Skin="Bootstrap">
                    <Tabs>
                        <telerik:RadTab Text="Courses" runat="server" ID="coursesTab" vaule="courses"></telerik:RadTab>
                        <telerik:RadTab Text="Scores" runat="server" ID="scoresTab" Value="scores"></telerik:RadTab>
                        <telerik:RadTab Text="Documents" runat="server" ID="documentsTab" Value="documents"></telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>

                <telerik:RadMultiPage runat="server" ID="TrainingRadMultiPage" SelectedIndex="0" RenderSelectedPageOnly="false">

                    <telerik:RadPageView runat="server" ID="RadPageView5">


                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 200px;">

                                    <telerik:RadListView ID="EventCourseListView" runat="server" DataSourceID="getEventCourse"
                                        ItemPlaceholderID="ItemPlaceHolder" BorderWidth="0px" Width="100%">

                                        <LayoutTemplate>
                                            <asp:Panel ID="GroupPlaceHolder" runat="server"></asp:Panel>
                                        </LayoutTemplate>

                                        <ItemTemplate>
                                            <div>
                                                <div class="leftColumn"><%# Eval("icon") %></div>
                                                <asp:HyperLink ID="CurriculumLink" runat="server" CssClass="pointer"><%# Eval("curriculumTitle") %></asp:HyperLink>
                                                <asp:Label ID="CurriculumID" runat="server" Text='<%# Eval("CurriculumID") %>' Visible="false" />
                                                <asp:Label ID="TestID" runat="server" Text='<%# Eval("TestID") %>' Visible="false" />
                                                <asp:Label ID="TypeLabel" runat="server" Text='<%# Eval("ContentID") %>' Visible="false" />
                                            </div>
                                        </ItemTemplate>

                                        <DataGroups>
                                            <telerik:ListViewDataGroup GroupField="CourseTitle" DataGroupPlaceholderID="GroupPlaceHolder">
                                                <DataGroupTemplate>
                                                    <asp:Panel runat="server" ID="DataGroupPanel" CssClass="dataGroup">
                                                        <h3><%# CType(Container, RadListViewDataGroupItem).DataGroupKey %></h3>
                                                        <asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder>
                                                    </asp:Panel>
                                                </DataGroupTemplate>
                                            </telerik:ListViewDataGroup>
                                        </DataGroups>

                                        <EmptyDataTemplate>
                                            <div class="RadListView RadListView_Default">
                                                <table class="table" cellspacing="0" style="width: 100%;">

                                                    <tbody>
                                                        <tr>
                                                            <td colspan="7">
                                                                <div class="alert alert-warning" role="alert">Theres no product training content available at this time.</div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </EmptyDataTemplate>

                                    </telerik:RadListView>

                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getEventCourse" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                        TableName="qryGetEventCourses" Where="eventID == @eventID">
                                        <WhereParameters>
                                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                        </WhereParameters>
                                    </asp:LinqDataSource>
                                    <div class="clearfix"></div>

                                    <div>
                                    <asp:Label ID="msgTrainingLabel" runat="server" /></div>

                                    

                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getBrandTrainingList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblBrandTrainings" Where="brandID == @brandID">
                                        <WhereParameters>
                                            <asp:ControlParameter ControlID="HiddenBrandID" PropertyName="Value" Name="brandID" Type="Int32"></asp:ControlParameter>
                                        </WhereParameters>
                                    </asp:LinqDataSource>

                                    <asp:HiddenField ID="HiddenBrandID" runat="server" />

                                </div>
                            </div>


                    </telerik:RadPageView>

                    <telerik:RadPageView runat="server" ID="RadPageView6">


                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 200px;">

                                    <h3>Training Results</h3>
                                    <asp:PlaceHolder ID="TestScoresPlaceHolder" runat="server"></asp:PlaceHolder>

                                </div>
                            </div>


                    </telerik:RadPageView>

                    <telerik:RadPageView runat="server" ID="RadPageView7">


                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 200px;">
                                    <div class="col-md-12">

                                         <asp:Repeater ID="DocumentRepeater" runat="server">
                                            <HeaderTemplate>
                                                <h3>Documents</h3>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <div>
                                                    <div class="leftColumn"><%# Common.getIcon(Eval("FileType")) %>
                                                       </div>
                                                    <a href='<%# Eval("FileURL") %>'><%# Eval("FileName") %></a>
                                                </div>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                 <asp:Label ID="lblEmptyData"
                                                Text='<%# Common.ShowAlertNoClose("warning", "There are no documents for this event.")%>'  runat="server" Visible="false">
                                         </asp:Label>

                                            </FooterTemplate>
                                        </asp:Repeater>

                                        <br />
                                        <br />

                                    </div>
                                </div>
                            </div>


                    </telerik:RadPageView>

                </telerik:RadMultiPage>

                </asp:Panel>
        </div>


        <div class="col-md-6">
            <h4>POS Shipping/Logistics</h4>
            <asp:Panel ID="LogisticsPanel" runat="server">

                <telerik:RadTabStrip ID="POSRadTabStrip" runat="server" MultiPageID="POSRadMultiPage" AutoPostBack="false" SelectedIndex="0" Skin="Bootstrap">
                    <Tabs>
                        <telerik:RadTab Text="Kits" runat="server" ID="kitsTab" Value="kits"></telerik:RadTab>
                        <telerik:RadTab Text="Shipping Location" runat="server" ID="shippinglocationTab" Value="shippinglocation"></telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>

                <telerik:RadMultiPage runat="server" ID="POSRadMultiPage" SelectedIndex="0" RenderSelectedPageOnly="false">

                    <telerik:RadPageView runat="server" ID="RadPageView8">

                        <asp:Panel ID="noPosItemsPanel" runat="server" Visible="false">
                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 200px;">

                                    <asp:Label ID="noPosItemsLabel" runat="server" />

                                    <asp:Literal ID="POSKitRequestedLabel" runat="server"></asp:Literal>

                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="POSPanel" runat="server">
                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 200px;">

                                    <div class="row" style="padding: 15px;">
                                        <div class="col-sm-12 col-md-12">
                                            <p></p>
                                            <asp:Label ID="EventTypeName" runat="server" Font-Bold="true" /><br />

                                                <telerik:RadListBox RenderMode="Lightweight" ID="POSItemList" runat="server" CheckBoxes="true" ShowCheckAll="true"               Width="100%" Font-Bold="false">
                                                </telerik:RadListBox>
                                            <asp:Label ID="errorLabel2" runat="server" />
                                        </div>
                                    </div>
                                                                                                                      

                                    <div class="row" style="padding: 0 15px 10px 15px;">
                                        <div class="col-sm-12 col-md-12">
                                            <strong>Ship to:</strong><br /> <telerik:RadComboBox ID="SendToList" runat="server" Width="250px">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="FedEx Office" Value="3" />
                                                    <telerik:RadComboBoxItem Text="Brand Ambassador" Value="1" />
                                                    <telerik:RadComboBoxItem Text="Event Location" Value="2" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>


                                    <div class="row" style="padding: 0 15px 10px 15px;">
                                        <div class="col-sm-12 col-md-12">
                                            <strong>Shipping Notes:</strong><br /> <telerik:RadTextBox ID="NotesTextBox" runat="server" Width="100%" Height="90px" TextMode="MultiLine"></telerik:RadTextBox>
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </asp:Panel>

                    </telerik:RadPageView>

                    <telerik:RadPageView runat="server" ID="RadPageView9">

                        <div class="widget stacked Container1">
                            <div class="widget-content" style="min-height: 200px;">

                                <asp:HiddenField ID="Hidden_POSLatitude" runat="server" Visible="true" />
                                <asp:HiddenField ID="HIdden_POSLongtitude" runat="server" Visible="true" />

                                <div class="row" style="padding: 15px;">
                                    <div class="col-sm-12 col-md-12">

                                        <p>
                                            <asp:Label ID="ShippingStatusLabel" runat="server" />
                                        </p>

                                    </div>

                                </div>

                            <asp:Panel ID="ShippingPanel" runat="server">

                                <div class="row" style="padding:  0 15px 0 15px;">
                                    <div class="col-sm-7 col-md-7">

                                    <asp:Label ID="ShippingEventTypeName" runat="server" Font-Bold="true" />

                                            <asp:Repeater ID="POSItems" runat="server" DataSourceID="getKitItems">
                                                <HeaderTemplate>

                                                    <table class="table compacttable">
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <%#Eval("qty") %>
                                                        </td>
                                                        <td>
                                                            <%#Eval("itemName") %>
                                                        </td>

                                                        <td class="pull-right">$<%#Eval("total") %></td></tr></ItemTemplate><FooterTemplate>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>

                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getKitItems" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryGetPosKitItems" Where="eventID == @eventID">
                                        <WhereParameters>
                                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                        </WhereParameters>
                                        </asp:LinqDataSource>

                                    </div>


                                    <div class="col-sm-5 col-md-5">

                                        <strong>Shipping Address:</strong><br /> <asp:Label ID="ShippingAddressLabel" runat="server" Text="Shipping Address Label" /><br />
                                        <asp:Label ID="AttLabel" runat="server" /><br />
                                        <br />

                                        <asp:Label ID="ShippedViaLabel" runat="server" /><br />
                                        <asp:Label ID="ShippedTypeLabel" runat="server" /><br />
                                        <asp:Label ID="TrackingLabel" runat="server" />


                                    </div>
                                </div>

                            </asp:Panel>

                            </div>
                        </div>


                    </telerik:RadPageView>
                    
                </telerik:RadMultiPage>

            </asp:Panel>

        </div>

    </div>



    
            <div class="row">
                <div class="col-md-12">
                    <h4>Event Recap</h4>
<asp:Panel ID="RecapPanel" runat="server">
                    <div class="bs-example">

                <telerik:RadTabStrip ID="recapTab" runat="server" MultiPageID="recapTabMultipage" AutoPostBack="false" SelectedIndex="0" Skin="Bootstrap">
                    <Tabs>
                        <telerik:RadTab Text="Questionnaire" runat="server" ID="QuestionnaireRadTab" Value="Questionnaire"></telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Photo Gallery" ID="PhotoGalleryRadTab" Value="PhotoGallery"></telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>

                        <%--<ul id="recapTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">

                            <li class="active"><a href="#questionnaire" data-toggle="tab">Questionnaire</a></li><li><a href="#photogallery" data-toggle="tab">Photo Gallery <span class="badge"><asp:Label ID="PhotoCountLabel" runat="server" /></span></a></li>

                        </ul>--%>
                        <asp:Label ID="msgLabel2" runat="server" />

                        <telerik:RadMultiPage runat="server" ID="recapTabMultipage" SelectedIndex="0" RenderSelectedPageOnly="false">

                            <telerik:RadPageView runat="server" ID="RadPageView2">
                                <div class="widget stacked">
                                    <div class="widget-content" style="min-height: 300px;">

                                        <uc1:QuestionaireControl runat="server" ID="QuestionaireControl" />

                                    </div>
                                </div>
                            </telerik:RadPageView>

                            <telerik:RadPageView runat="server" ID="RadPageView3">
                                <div class="widget stacked">
                                    <div class="widget-content" style="min-height: 300px;">

                                            <h3>Photo Gallery </h3>

                                            <telerik:RadListView runat="server" ID="PhotoListView" Skin="Bootstrap" DataKeyNames="photoID" OverrideDataSourceControlSorting="true">

                                                <LayoutTemplate>

                                                    <div id="list2">

                                                        <div class="clearFix">
                                                        </div>

                                                        <asp:Panel ID="itemPlaceholder" runat="server">
                                                        </asp:Panel>

                                                        <div class="clearFix">
                                                        </div>

                                                    </div>

                                                </LayoutTemplate>

                                                <EmptyItemTemplate>
                                                <div class="RadListView RadListView_Default">

                                                    <div class="alert alert-warning" role="alert">There are no photos to be displayed.  To add a new items click on the <strong>Add New Photos</strong>
                                                        button above.</div>

                                                </div>
                                            </EmptyItemTemplate>

                                                <ItemTemplate>

                                                    <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                                        <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                            DataValue='<%#Eval("Image") %>' Height='<%#ImageHeight %>' Width="<%#ImageWidth %>"
                                                            ResizeMode="Crop"
                                                            onclick='<%#CreateWindowScript3(Eval("eventID"), Eval("photoID")) %>'
                                                            AlternateText="Click to view larger image" ToolTip="Click to view larger image" />

                                                        <div style="margin-top: -22px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">


                                                             </div></div>

                                                </ItemTemplate>



                                </telerik:RadListView>

                                            <asp:Label ID="errorLabel" runat="server" />

                                            <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                                                SelectCommand="SELECT [photoID], [photoTitle], [photoDescription], [Image], [accountID], [eventID], [brandID] FROM [tblPhoto] WHERE ([eventID] = @eventID)">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="String"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>


                                        
                                        <telerik:RadWindowManager runat="server" ID="RadWindowManager2">

                                            <Windows>

                                                <telerik:RadWindow runat="server" ID="RadWindow1" VisibleStatusbar="false" NavigateUrl="/PhotoGallery.aspx" Skin="Bootstrap"
                                                    Width="675px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                                                    Modal="true">
                                                </telerik:RadWindow>

                                            </Windows>

                                        </telerik:RadWindowManager>

                                    </div>
                                </div>
                            </telerik:RadPageView>

                        </telerik:RadMultiPage>
                        


                        </div>
                        <!-- end content -->
</asp:Panel>
                    </div>
                </div>

        

</div>

            


    <telerik:RadWindowManager runat="server" ID="RadWindowManager1">
        <Windows>
            <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" NavigateUrl="/PhotoGallery.aspx" Skin="Bootstrap"
                Width="675px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    



    <%--javascripts--%>
    

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


            function GetMap() {

                // Initialize the map
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var locName = $('#<%=LocationNameMap.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                       {
                           credentials: "Ak_nGW12DZsVeNtw7O4tw1U76K-AyZupWE-O4o4q-A2r7VrqlON3jS4HHlsi85mx",
                           center: new Microsoft.Maps.Location(lat, long),
                           zoom: 10
                       });

            var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
            map.entities.push(pushpin);

            document.getElementById('printoutPanelGas').style.display = "none";
            document.getElementById('printoutPanelConvenience').style.display = "none";
            document.getElementById('printoutPanelGrocery').style.display = "none";
            document.getElementById('printoutPanel').style.display = "none";


            $("#btnFindGroceryStoresLink").removeClass("btn-success");
            $("#btnFindConvienienceStoresLink").removeClass("btn-success");
            $("#btnFindGasStationsLink").removeClass("btn-success");

        }

        function createDirections() {
            document.getElementById('printoutPanelGas').style.display = "none";
            document.getElementById('printoutPanelConvenience').style.display = "none";
            document.getElementById('printoutPanelGrocery').style.display = "none";
            document.getElementById('printoutPanel').style.display = "block";

            // Initialize the map
            var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
            var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                     {
                         credentials: "Ak_nGW12DZsVeNtw7O4tw1U76K-AyZupWE-O4o4q-A2r7VrqlON3jS4HHlsi85mx",
                         center: new Microsoft.Maps.Location(lat, long),
                         zoom: 10
                     });

            var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
            map.entities.push(pushpin);

            <%--var FromAddress = $('#<%=SelectedDirectionsName.ClientID%>').val();--%>
            var ToAddress = $('#<%=AccountAddressLabel1.ClientID%>').text();
            var ToLocation = $('#<%=LocationTextBox.ClientID%>').val();
            var locName = $('#<%=LocationNameMap.ClientID%>').val();


          Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
              var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
              // Set Route Mode to driving
              directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
              var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ address: FromAddress });
              var waypoint2 = new Microsoft.Maps.Directions.Waypoint({ address: locName, location: new Microsoft.Maps.Location(lat, long) });
              directionsManager.addWaypoint(waypoint1);
              directionsManager.addWaypoint(waypoint2);
              // Set the element in which the itinerary will be rendered
              directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
              directionsManager.setRequestOptions({ distanceUnit: Microsoft.Maps.Directions.DistanceUnit.miles });
              directionsManager.calculateDirections();
          });


          $("#btnFindGroceryStoresLink").removeClass("btn-success");
          $("#btnFindConvienienceStoresLink").removeClass("btn-success");
          $("#btnFindGasStationsLink").removeClass("btn-success");

      }

      function createDirectionsByAddress() {
          document.getElementById('printoutPanelGas').style.display = "none";
          document.getElementById('printoutPanelConvenience').style.display = "none";
          document.getElementById('printoutPanelGrocery').style.display = "none";
          document.getElementById('printoutPanel').style.display = "block";

          // Initialize the map
                    var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                    var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                    var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                               {
                                   credentials: "Ak_nGW12DZsVeNtw7O4tw1U76K-AyZupWE-O4o4q-A2r7VrqlON3jS4HHlsi85mx",
                                   center: new Microsoft.Maps.Location(lat, long),
                                   zoom: 10
                               });

                    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                    map.entities.push(pushpin);

                    var FromAddress = $('#<%=txtFromAddress.ClientID%>').val();
                    var ToAddress = $('#<%=AccountAddressLabel1.ClientID%>').text();
                    var ToLocation = $('#<%=LocationTextBox.ClientID%>').val();
                    var locName = $('#<%=LocationNameMap.ClientID%>').val();


                    Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
                        var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
                        // Set Route Mode to driving
                        directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
                        var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ address: FromAddress });
                        var waypoint2 = new Microsoft.Maps.Directions.Waypoint({ address: locName, location: new Microsoft.Maps.Location(lat, long) });
                        directionsManager.addWaypoint(waypoint1);
                        directionsManager.addWaypoint(waypoint2);
                        // Set the element in which the itinerary will be rendered
                        directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
                        directionsManager.setRequestOptions({ distanceUnit: Microsoft.Maps.Directions.DistanceUnit.miles });
                        directionsManager.calculateDirections();
                    });

                    $("#btnFindGroceryStoresLink").removeClass("btn-success");
                    $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                    $("#btnFindGasStationsLink").removeClass("btn-success");

      }



            function MapTraffic() {
                    $("#hideTraffic").show();
                    $("#showTraffic").hide();
                    document.getElementById('printoutPanelGas').style.display = "none";
                    document.getElementById('printoutPanelConvenience').style.display = "none";
                    document.getElementById('printoutPanelGrocery').style.display = "none";


                    // Initialize the map
                    var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                    var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                    var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                           {
                               credentials: "Ak_nGW12DZsVeNtw7O4tw1U76K-AyZupWE-O4o4q-A2r7VrqlON3jS4HHlsi85mx",
                               center: new Microsoft.Maps.Location(lat, long),
                               zoom: 10
                           });

                var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                map.entities.push(pushpin);

                Microsoft.Maps.loadModule('Microsoft.Maps.Traffic', function () {
                    var manager = new Microsoft.Maps.Traffic.TrafficManager(map);
                    manager.show();
                })

                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                $("#btnFindGasStationsLink").removeClass("btn-success");

            }

            function hideTrafficLayer() {
                $("#hideTraffic").hide();
                $("#showTraffic").show();
                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                document.getElementById('printoutPanelGrocery').style.display = "none";

                // Initialize the map
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                           {
                               credentials: "Ak_nGW12DZsVeNtw7O4tw1U76K-AyZupWE-O4o4q-A2r7VrqlON3jS4HHlsi85mx",
                               center: new Microsoft.Maps.Location(lat, long),
                               zoom: 10
                           });

                var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                map.entities.push(pushpin);

                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                $("#btnFindGasStationsLink").removeClass("btn-success");

            }


            function GetGasStations() {
                document.getElementById('printoutPanelGrocery').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                // Initialize the map
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map, queryOptions, numResults;
                var pageIdx = 0;
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                           {
                               credentials: "Ak_nGW12DZsVeNtw7O4tw1U76K-AyZupWE-O4o4q-A2r7VrqlON3jS4HHlsi85mx",
                               center: new Microsoft.Maps.Location(lat, long),
                               zoom: 13
                           });


                Microsoft.Maps.loadModule('Microsoft.Maps.SpatialDataService', function () {
                    //Create a query to get nearby data.
                    queryOptions = {
                        queryUrl: 'https://spatial.virtualearth.net/REST/v1/data/f22876ec257b474b82fe2ffcb8393150/NavteqNA/NavteqPOIs',
                        top: 15,
                        inlineCount: true,
                        spatialFilter: {
                            spatialFilterType: 'nearby',
                            location: map.getCenter(),
                            radius: 10
                        },
                        filter: 'EntityTypeID eq 5540'
                    };
                    //Trigger an initial search.
                    getNearByLocations();
                });
                function getNearByLocations() {
                    //Remove any existing data from the map.
                    map.entities.clear();
                    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                    map.entities.push(pushpin);
                    //Update the query options to skip results based on the page index.
                    queryOptions.skip = pageIdx * 10;
                    Microsoft.Maps.SpatialDataService.QueryAPIManager.search(queryOptions, map, function (data, inlineCount) {
                        //Store the number of results available.
                        numResults = inlineCount;
                        if (data.length > 0) {
                            //Calculate the start and end result index.
                            var start = pageIdx * 10 + 1;
                            var end = start + data.length - 1;
                            document.getElementById('pageInfo').innerText = 'Results: ' + start + ' - ' + end + ' of ' + inlineCount + ' results';
                            //Create a list of the results.
                            var listHTML = ['<table>'], locations = [];
                            for (var i = 0; i < data.length; i++) {
                                //Create HTML for each line item in the list.
                                //Add a column of index numbers.
                                listHTML.push('<tr><td>', (start + i), ') </td>');
                                //Create a link that calls a function, pass in the EntityID of a result.
                                listHTML.push('<td style="padding-left:20px;"><a href="javascript: void (0);" ', 'onclick="listItemClicked(\'', data[i].metadata.EntityID, '\');"></a>', data[i].metadata.DisplayName, '</td>');
                                //Create a column to display the distance to the location.
                                var num = data[i].metadata.__Distance / 1.61;
                                listHTML.push('<td style="padding-left:30px;">', Math.round(num * 100) / 100, ' mile(s)</td></tr>');
                                //Add the result number to the pushpin.
                                data[i].setOptions({ text: start + i + '' });
                                locations.push(data[i].getLocation());
                            }
                            listHTML.push('</table>');
                            document.getElementById('printoutPanelGas').innerHTML = listHTML.join('');
                            document.getElementById('printoutPanelGas').style.display = "block";
                            document.getElementById('printoutPanelGas').style.height = "130px";
                            document.getElementById('printoutPanelGas').style.overflow = "auto";
                            //Add results to the map.
                            map.entities.push(data);
                            //Set the map view to show all the locations.
                            //Add apadding to account for the pushpins pixel size.
                            map.setView({
                                bounds: Microsoft.Maps.LocationRect.fromLocations(locations),
                                padding: 30
                            });
                        }
                    });
                }
                function listItemClicked(entityId) {
                    //When an item in the list is clicked, look up its pushpin by entitiyId.
                    var shape, len = map.entities.getLength();
                    for (var i = 0; i < len; i++) {
                        shape = map.entities.get(i);
                        if (shape.metadata.EntityID == entityId) {
                            //Center the map over the pushpin and zoom in.
                            map.setView({ center: shape.getLocation(), zoom: 15 });
                            break;
                        }
                    }
                }

            }


            function GetGroceryStores() {

                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                // Initialize the map
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map, queryOptions, numResults;
                var pageIdx = 0;
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                           {
                               credentials: "Ak_nGW12DZsVeNtw7O4tw1U76K-AyZupWE-O4o4q-A2r7VrqlON3jS4HHlsi85mx",
                               center: new Microsoft.Maps.Location(lat, long),
                               zoom: 13
                           });


                Microsoft.Maps.loadModule('Microsoft.Maps.SpatialDataService', function () {
                    //Create a query to get nearby data.
                    queryOptions = {
                        queryUrl: 'https://spatial.virtualearth.net/REST/v1/data/f22876ec257b474b82fe2ffcb8393150/NavteqNA/NavteqPOIs',
                        top: 15,
                        inlineCount: true,
                        spatialFilter: {
                            spatialFilterType: 'nearby',
                            location: map.getCenter(),
                            radius: 10
                        },
                        filter: 'EntityTypeID eq 5400'
                    };
                    //Trigger an initial search.
                    getNearByLocations();
                });

                function getNearByLocations() {
                    //Remove any existing data from the map.
                    map.entities.clear();
                    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                    map.entities.push(pushpin);
                    //Update the query options to skip results based on the page index.
                    queryOptions.skip = pageIdx * 10;
                    Microsoft.Maps.SpatialDataService.QueryAPIManager.search(queryOptions, map, function (data, inlineCount) {
                        //Store the number of results available.
                        numResults = inlineCount;
                        if (data.length > 0) {
                            //Calculate the start and end result index.
                            var start = pageIdx * 10 + 1;
                            var end = start + data.length - 1;
                            document.getElementById('pageInfo').innerText = 'Results: ' + start + ' - ' + end + ' of ' + inlineCount + ' results';
                            //Create a list of the results.
                            var listHTML = ['<table>'], locations = [];
                            for (var i = 0; i < data.length; i++) {
                                //Create HTML for each line item in the list.
                                //Add a column of index numbers.
                                listHTML.push('<tr><td>', (start + i), ') </td>');
                                //Create a link that calls a function, pass in the EntityID of a result.
                                listHTML.push('<td style="padding-left:20px;"><a href="javascript: void (0);" ', 'onclick="listItemClicked(\'', data[i].metadata.EntityID, '\');"></a>', data[i].metadata.DisplayName, '</td>');
                                //Create a column to display the distance to the location.
                                var num = data[i].metadata.__Distance / 1.61;
                                listHTML.push('<td style="padding-left:30px;">', Math.round(num * 100) / 100, ' mile(s)</td></tr>');
                                //Add the result number to the pushpin.
                                data[i].setOptions({ text: start + i + '' });
                                locations.push(data[i].getLocation());
                            }
                            listHTML.push('</table>');
                            document.getElementById('printoutPanelGrocery').innerHTML = listHTML.join('');
                            document.getElementById('printoutPanelGrocery').style.display = "block";
                            document.getElementById('printoutPanelGrocery').style.height = "130px";
                            document.getElementById('printoutPanelGrocery').style.overflow = "auto";
                            //Add results to the map.
                            map.entities.push(data);
                            //Set the map view to show all the locations.
                            //Add apadding to account for the pushpins pixel size.
                            map.setView({
                                bounds: Microsoft.Maps.LocationRect.fromLocations(locations),
                                padding: 30
                            });
                        }
                    });
                }
                function listItemClicked(entityId) {
                    //When an item in the list is clicked, look up its pushpin by entitiyId.
                    var shape, len = map.entities.getLength();
                    for (var i = 0; i < len; i++) {
                        shape = map.entities.get(i);
                        if (shape.entity.EntityID == entityId) {
                            //Center the map over the pushpin and zoom in.
                            map.setView({ center: shape.getLocation(), zoom: 15 });
                            break;
                        }
                    }
                }

            }


            function GetConvenienceStores() {

                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelGrocery').style.display = "none";
                // Initialize the map
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                  var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map, queryOptions, numResults;
                var pageIdx = 0;
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                           {
                               credentials: "Ak_nGW12DZsVeNtw7O4tw1U76K-AyZupWE-O4o4q-A2r7VrqlON3jS4HHlsi85mx",
                               center: new Microsoft.Maps.Location(lat, long),
                               zoom: 13
                           });


                Microsoft.Maps.loadModule('Microsoft.Maps.SpatialDataService', function () {

                    //Create a query to get nearby data.
                    queryOptions = {
                        queryUrl: 'https://spatial.virtualearth.net/REST/v1/data/f22876ec257b474b82fe2ffcb8393150/NavteqNA/NavteqPOIs',
                        top: 15,
                        inlineCount: true,
                        spatialFilter: {
                            spatialFilterType: 'nearby',
                            location: map.getCenter(),
                            radius: 10
                        },
                        filter: 'EntityTypeID eq 9535'
                    };
                    //Trigger an initial search.
                    getNearByLocations();
                });

                function getNearByLocations() {
                    //Remove any existing data from the map.
                    map.entities.clear();
                    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                    map.entities.push(pushpin);
                    //Update the query options to skip results based on the page index.
                    queryOptions.skip = pageIdx * 10;
                    Microsoft.Maps.SpatialDataService.QueryAPIManager.search(queryOptions, map, function (data, inlineCount) {
                        //Store the number of results available.
                        numResults = inlineCount;
                        if (data.length > 0) {
                            //Calculate the start and end result index.
                            var start = pageIdx * 10 + 1;
                            var end = start + data.length - 1;
                            document.getElementById('pageInfo').innerText = 'Results: ' + start + ' - ' + end + ' of ' + inlineCount + ' results';
                            //Create a list of the results.
                            var listHTML = ['<table>'], locations = [];
                            for (var i = 0; i < data.length; i++) {
                                //Create HTML for each line item in the list.
                                //Add a column of index numbers.
                                listHTML.push('<tr><td>', (start + i), ') </td>');
                                //Create a link that calls a function, pass in the EntityID of a result.
                                listHTML.push('<td style="padding-left:20px;"><a href="javascript: void (0);" ', 'onclick="listItemClicked(\'', data[i].metadata.EntityID, '\');"></a>', data[i].metadata.DisplayName, '</td>');
                                //Create a column to display the distance to the location.
                                var num = data[i].metadata.__Distance / 1.61;
                                listHTML.push('<td style="padding-left:30px;">', Math.round(num * 100) / 100, ' mile(s)</td></tr>');
                                //Add the result number to the pushpin.
                                data[i].setOptions({ text: start + i + '' });
                                locations.push(data[i].getLocation());
                            }
                            listHTML.push('</table>');
                            document.getElementById('printoutPanelConvenience').innerHTML = listHTML.join('');
                            document.getElementById('printoutPanelConvenience').style.display = "block";
                            document.getElementById('printoutPanelConvenience').style.height = "130px";
                            document.getElementById('printoutPanelConvenience').style.overflow = "auto";
                            //Add results to the map.
                            map.entities.push(data);
                            //Set the map view to show all the locations.
                            //Add apadding to account for the pushpins pixel size.
                            map.setView({
                                bounds: Microsoft.Maps.LocationRect.fromLocations(locations),
                                padding: 30
                            });
                        }
                    });
                }

                function listItemClicked(entityId) {
                    //When an item in the list is clicked, look up its pushpin by entitiyId.
                    var shape, len = map.entities.getLength();
                    for (var i = 0; i < len; i++) {
                        shape = map.entities.get(i);
                        if (shape.entity.EntityID == entityId) {
                            //Center the map over the pushpin and zoom in.
                            map.setView({ center: shape.getLocation(), zoom: 15 });
                            break;
                        }
                    }
                }

            }

            function ClearMap() {

                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                document.getElementById('printoutPanelGrocery').style.display = "none";
                // Initialize the map

                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                       {
                           credentials: "Ak_nGW12DZsVeNtw7O4tw1U76K-AyZupWE-O4o4q-A2r7VrqlON3jS4HHlsi85mx",
                           center: new Microsoft.Maps.Location(lat, long),
                           zoom: 10
                       });

            var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
            map.entities.push(pushpin);

            $("#btnFindGroceryStoresLink").removeClass("btn-success");
            $("#btnFindConvienienceStoresLink").removeClass("btn-success");
            $("#btnFindGasStationsLink").removeClass("btn-success");

        }

        </script>


    </telerik:RadScriptBlock>

    <script src="/events/js/RequiredPositions.js"></script>

    <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release&callback=GetMap' async defer></script>


</asp:Content>
