<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master"
    CodeBehind="oldAccountDetails.aspx.vb" Inherits="EventManagerApplication.AccountDetails" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .widget .widget-content {
            padding-top: 5px;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="LatitudeTextBox" runat="server" />
    <asp:HiddenField ID="LongtitudeTextBox" runat="server" />
    <asp:HiddenField ID="LocationTextBox" runat="server" />


    <script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>

    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h2 style="font-weight:bold;">Account Details</h2>
                <div class="detail">
                   <h4 style="font-weight:bold;"> Account Name:
                    <asp:Label ID="AccountNameLabel" runat="server" Font-Bold="true" /><br /></h4>
                    Location:
                    <asp:Label ID="LocationLabel" runat="server" Font-Bold="true" /><br />
                </div>
                <hr />
            </div>
        </div>
        <!-- /row -->

        <div class="row">

            <div class="col-md-6">

                <div class="bs-example">
                    <ul id="myTab" class="nav nav-tabs">
                        <li class="active"><a href="#details" data-toggle="tab">Details</a></li>
                        <li class=""><a href="#address" data-toggle="tab">Address</a></li>
                        <li class=""><a href="#contacts" data-toggle="tab">Contacts</a></li>
                        <li class=""><a href="#notes" data-toggle="tab">Notes</a></li>
                        <li class=""><a href="/Accounts/EditAccount?AccountID=<%= Request.QueryString("AccountID") %>">Edit</a></li>
                    </ul>
                </div>
                <asp:FormView ID="AccountDetailForm" runat="server" DataKeyNames="accountID" DataSourceID="LinqDataSource1" Width="100%">
                    <ItemTemplate>


                <div class="tab-content">
                    <div class="tab-pane fade active in" id="details">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div>
                                    <label>DBA Name:</label>
                                    <asp:Label ID="dbaNameLabel" runat="server" Text='<%# Bind("DBAName") %>' />
                                </div>
                                <div>
                                    <label>Business Name:</label>
                                    <asp:Label ID="BusinessNameLabel" runat="server" Text='<%# Bind("accountName") %>' />
                                </div>
                                <br />
                                <div>
                                    <label>Phone:</label>
                                    <asp:Label ID="PhoneLabel" runat="server" Text='<%# Bind("phone") %>' />
                                </div>
                                <br />
                                <div>
                                    <label>Website:</label>
                                    <asp:Label ID="WebsiteLabel" runat="server" Text='<%# Bind("website") %>' />
                                </div>
                                <div>
                                    <label>Account ID:</label>
                                    <asp:Label ID="AccountIDLabel" runat="server" Text='<%# Bind("accoutID") %>' />
                                </div>
                                <div>
                                    <label>Distributer's ID:</label>
                                    <asp:Label ID="DistributerIDLabel" runat="server" Text='<%# Bind("distributorID") %>' />
                                </div>
                                <br />
                                <div>
                                    <label>Market:</label>
                                    <asp:Label ID="MarketLabel" runat="server" Text='<%# Bind("marketID") %>'  />
                                </div>
                                <div>
                                    <label>Venue Type:</label>
                                    <asp:Label ID="VenueTypeLabel" runat="server" />
                                </div>
                                <br />
                                <div>
                                    <label>Capacity:</label>
                                    <asp:Label ID="CapacityLabel" runat="server" Text='<%# Bind("capacity") %>' />
                                </div>
                                <div>
                                    <label>Number of Bars:</label>
                                    <asp:Label ID="NumberOfBarsLabel" runat="server" Text='<%# Bind("numberofBars") %>' />
                                </div>
                                <div>
                                    <label>Bartender Stations:</label>
                                    <asp:Label ID="BartenderStationsLabel" runat="server" />
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="address">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div>
                                    <label>Address 1:</label>
                                    <asp:Label ID="Address1Label" runat="server" Text='<%# Bind("streetAddress1") %>' />
                                </div>
                                <div>
                                    <label>Address 2:</label>
                                    <asp:Label ID="Address2Label" runat="server" Text='<%# Bind("streetAddress2")%>' />
                                </div>
                                <br />
                                <div>
                                    <label>City:</label>
                                    <asp:Label ID="CityLabel" runat="server" Text='<%# Bind("city") %>' />
                                </div>
                                <div>
                                    <label>State:</label>
                                    <asp:Label ID="StateLabel" runat="server" Text='<%# Bind("state") %>' />
                                </div>
                                <div>
                                    <label>Zip:</label>
                                    <asp:Label ID="ZipLabel" runat="server" Text='<%# Bind("zipCode") %>' />
                                </div>
                                <br />
                                <br />
                                <div>
                                    <label style="font-weight:bold; color:black;">Coordinates</label>      
                                </div>
                                <div>
                                    <label>Latitude:</label>
                                    <asp:Label ID="LatitudeLabel" runat="server" Text='<%# Bind("latitude") %>' />
                                </div>
                                <div>
                                    <label>Longitude:</label>
                                    <asp:Label ID="LongitudeLabel" runat="server" Text='<%# Bind("longitude") %>' />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="contacts">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div>
                                    <label>Manager Name:</label>
                                    <asp:Label ID="ManagerNameLabel" runat="server" Text='<%# Bind("managerName") %>' />
                                </div>
                                <div>
                                    <label>Manager Email:</label>
                                    <asp:Label ID="ManagerEmailLabel" runat="server" Text='<%# Bind("managerEmail") %>' />
                                </div>
                                <div>
                                    <label>Manager Phone:</label>
                                    <asp:Label ID="ManagerPhoneLabel" runat="server" Text='<%# Bind("managerPhone") %>' />
                                </div>
                                <br />
                                <br />
                                <div>
                                    <label>Sales Rep Name:</label>
                                    <asp:Label ID="SalesRepNameLabel" runat="server" Text='<%# Bind("salesRepName") %>' />
                                </div>
                                <div>
                                    <label>Sales Rep Email:</label>
                                    <asp:Label ID="SalesRepEmailLabel" runat="server" Text='<%# Bind("salesRepEmail") %>' />
                                </div>
                                <div>
                                    <label>Sales Rep Phone:</label>
                                    <asp:Label ID="SalesRepPhoneLabel" runat="server" Text='<%# Bind("salesRepPhone") %>' />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="notes">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <asp:TextBox style="width: 525px; height: 120px;" TextMode="MultiLine" ID="notesTextBox" runat="server" Text='<%# Bind("notes") %>' />
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="edit">
                        <div class="widget stacked">
                            <div class="widget-content">
                            </div>
                        </div>
                    </div>




                </div>

                    </ItemTemplate>
                </asp:FormView>

                <asp:LinqDataSource ID="getAccountDetail" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblAccounts" Where="accountID == @accountID">
                    <WhereParameters>
                        <asp:QueryStringParameter DefaultValue="228679" Name="accountID" QueryStringField="AccountID" Type="String" />
                    </WhereParameters>
                </asp:LinqDataSource>

            </div>


            <div class="col-md-6">

                <div class="bs-example">

                    <ul id="accountTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0px">
                        <li class="active"><a href="#map" data-toggle="tab">Map</a></li>
                        <li class=""><a href="#files" data-toggle="tab">Files</a></li>
                        <li class=""><a href="#photos" data-toggle="tab">Photos</a></li>
                    </ul>
                </div>



                <div class="tab-content">
                    <div class="tab-pane fade active in" id="map">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div style="margin-bottom: 10px;">
                                    <div>
                                        <asp:Label ID="AccountNameLabel1" Font-Bold="true" Font-Size="Large" runat="server" />
                                    </div>
                                    <div>
                                        <asp:Label ID="AccountAddressLabel1" runat="server" />
                                    </div>
                                </div>

                                <div id="routePanel" style="margin-bottom: 10px; display: none">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            Enter your starting address:
                                                <asp:TextBox ID="txtFromAddress" runat="server" CssClass="form-control input-sm" />
                                            <div style="margin-top: 5px;">
                                                <input type="button" value="Get Directions" onclick="createDirections();" class="btn btn-default btn-sm pull-right" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div style="margin-bottom: 10px;">
                                    <input type="button" id="showTraffic" value="Show Traffic" onclick="showTrafficLayer();" class="btn btn-xs btn-secondary" /><input type="button" id="hideTraffic" value="Hide Traffic" onclick="    hideTrafficLayer();" class="btn btn-xs btn-secondary" style="display: none" />
                                </div>


                                <div id='mapDiv' style="position: relative; width: 100%; height: 50%;"></div>

                                <div style="margin-top: 5px;">

                                    <label>Show Helpful Locations:</label><br />
                                    <a href="#" class="btn btn-link">Grocery Store</a> |  <a href="#" class="btn btn-link">Convenience Store</a>  |  <a href="#" class="btn btn-link">Gas Station</a>  |  <a href="#" class="btn btn-link">Party Store</a>


                                </div>
                                <div id="LocationList"></div>

                                <div id='directionsItinerary'></div>

                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="files">
                        <div class="widget stacked">
                            <div class="widget-content">
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="photos">
                        <div class="widget stacked">
                            <div class="widget-content">
                            </div>
                        </div>
                    </div>






                </div>

            </div>

        </div>


        <div class="row">
            <div class="col-md-12">
                

                <div class="bs-example">
                    <ul id="activitiesTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0px">
                        <li class="active"><a href="#activities" data-toggle="tab">Activities</a></li>
                        <li class=""><a href="#upcomingEvents" data-toggle="tab">Upcoming Events</a></li>
                        <li class=""><a href="#previousEvents" data-toggle="tab">Previous Events</a></li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="activities">
                            <div class="widget stacked">
                                <div class="widget-content">
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="upcomingEvents">
                            <div class="widget stacked">
                                <div class="widget-content">
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="previousEvents">
                            <div class="widget stacked">
                                <div class="widget-content">
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>

        </div>




    </div>




    <script type="text/javascript">
        var map = null;
        var trafficLayer;
        var directionsManager;
        var directionsErrorEventObj;
        var directionsUpdatedEventObj;
        var a = null;
        var b = null;

        $(document).ready(function () {

            GetMap();

        });

        function GetMap() {

            // Initialize the map
            map = new Microsoft.Maps.Map(document.getElementById("mapDiv"),
                       {
                           credentials: "Ar9r5Jz1bSVYhbZJ4p8CYoOLi1NuWoHVYl1NxJftPJz_FkhXUOxosfSgxDqbIpGg",
                       });

            loadTrafficModule();
            addPushpinWithOptions();
        }

        $("#tab1").click(function () {

            clearDisplay();
            GetMap();
            $('#routePanel').hide();

        });

        $("#tab2").click(function () {

            $('#accountTab a:first').tab('show');

            $('#tab1').removeClass('active');
            $('#tab2').addClass('active');
            $('#routePanel').show();

        });




        function addPushpinWithOptions() {
            var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();

            var offset = new Microsoft.Maps.Point(0, 5);
            var pushpinOptions = { text: '', visible: true, textOffset: offset };
            var pushpin = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(lat, long), pushpinOptions);
            map.setView({ center: new Microsoft.Maps.Location(lat, long), zoom: 12 });
            map.entities.push(pushpin);
        }



        function createDirectionsManager() {
            var displayMessage;
            if (!directionsManager) {
                directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
                displayMessage = 'Directions Module loaded\n';
                displayMessage += 'Directions Manager loaded';
            }
            //  alert(displayMessage);
            directionsManager.resetDirections();
            directionsErrorEventObj = Microsoft.Maps.Events.addHandler(directionsManager, 'directionsError', function (arg) { alert(arg.message) });
            directionsUpdatedEventObj = Microsoft.Maps.Events.addHandler(directionsManager, 'directionsUpdated', function () { alert('Directions updated') });
        }

        function createDrivingRoute() {

            var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();

            var FromAddress = $('#<%=txtFromAddress.ClientID%>').val();
            var ToAddress = $('#<%=AccountAddressLabel1.ClientID%>').text();
            var ToLocation = $('#<%=LocationTextBox.ClientID%>').val();

            if (!directionsManager) { createDirectionsManager(); }
            directionsManager.resetDirections();
            // Set Route Mode to driving 
            directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
            var seattleWaypoint = new Microsoft.Maps.Directions.Waypoint({ address: FromAddress });
            directionsManager.addWaypoint(seattleWaypoint);
            var tacomaWaypoint = new Microsoft.Maps.Directions.Waypoint({ address: ToLocation, location: new Microsoft.Maps.Location(lat, long) });
            directionsManager.addWaypoint(tacomaWaypoint);
            // Set the element in which the itinerary will be rendered
            directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('directionsItinerary') });
            alert('Calculating directions...');
            directionsManager.calculateDirections();
        }

        function createDirections() {

            if (!directionsManager) {
                Microsoft.Maps.loadModule('Microsoft.Maps.Directions', { callback: createDrivingRoute });
            }
            else {
                createDrivingRoute();
            }
        }


        /// reset

        function resetDirections() {
            if (!directionsManager) { createDirectionsManager(); }
            directionsManager.resetDirections();
            // alert('Directions cleared (Waypoints cleared, map/itinerary cleared, request and render options reset to default values)');
        }

        if (!directionsManager) {
            Microsoft.Maps.loadModule('Microsoft.Maps.Directions', { callback: resetDirections });
        }
        else {
            resetDirections();
        }

        // clear display

        function clearDisplay() {
            if (!directionsManager) { createDirectionsManager(); }
            directionsManager.clearDisplay();
            // alert('Directions cleared (map/itinerary cleared, Waypoints preserved, request and render options preserved)');
        }

        if (!directionsManager) {
            Microsoft.Maps.loadModule('Microsoft.Maps.Directions', { callback: clearDisplay });
        }
        else {
            clearDisplay();
        }

        // show traffic layer

        function trafficModuleLoaded() {
            setMapView();
        }
        function loadTrafficModule() {
            Microsoft.Maps.loadModule('Microsoft.Maps.Traffic', { callback: trafficModuleLoaded });
        }
        function setMapView() {
            var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
          var long = $('#<%=LongtitudeTextBox.ClientID%>').val();

          map.setView({ zoom: 10, center: new Microsoft.Maps.Location(lat, long) })
      }

      function showTrafficLayer() {

          trafficLayer = new Microsoft.Maps.Traffic.TrafficLayer(map);
          // show the traffic Layer
          trafficLayer.show();
          $("#hideTraffic").show();
          $("#showTraffic").hide();
      }


      // hide traffic layer

      function hideTrafficLayer() {
          // hide the traffic Layer
          trafficLayer.hide();
          $("#hideTraffic").hide();
          $("#showTraffic").show();
      }


    </script>

    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblAccounts" Where="accountID == @accountID">
        <WhereParameters>
            <asp:QueryStringParameter DefaultValue="228679" Name="accountID" QueryStringField="AccountID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

</asp:Content>
