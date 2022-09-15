<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="MapControl.aspx.vb" Inherits="EventManagerApplication.MapControl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    
    <asp:HiddenField ID="LatitudeTextBox" runat="server" />
    <asp:HiddenField ID="LongtitudeTextBox" runat="server" />



    <script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>

    <div class="container">
        <div class="row">
            <div class="col-xs-12">
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
        <!-- /row -->

         <div class="row">
            <div class="col-md-6">
                <h4>Event Details</h4>

          <div class="bs-example">
                    <ul id="myTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0px">
                <li class="active"><a href="#information" data-toggle="tab">Information</a></li>
                <li class=""><a href="#budget" data-toggle="tab">Budget</a></li>
                <li class=""><a href="#notes" data-toggle="tab">Notes</a></li>
                  <li class=""><a href="#log" data-toggle="tab">Log</a></li>
                  <li class=""><a href="/Events/EditEvent?EventID=<%= Request.QueryString("ID") %>">Edit</a></li>
              </ul>
              <div class="tab-content">
                <div class="tab-pane fade active in" id="information">
                    <div class="widget stacked">
                        <div class="widget-content">
                            <div>
                                <label>Event Type:</label>
                                <asp:Label ID="EventTypeLabel" runat="server" />
                            </div>
                            <div>
                                <label>Supplier:</label>
                                <asp:Label ID="SupplierLabel" runat="server" />
                            </div>
                            <div>
                                <label>Brands:</label>
                                <asp:Label ID="BrandsLabel" runat="server" />
                            </div>
                            <div>
                                <label>Market:</label>
                                <asp:Label ID="MarketLabel" runat="server" />
                            </div>
                             <br />
                            <div>
                                <label>Current Status:</label>
                                <asp:Label ID="StatusLabel" runat="server" />
                            </div>
                            <br />
                            <div>
                                <label>Attire:</label>
                                <asp:Label ID="AttireLabel" runat="server" />
                            </div>
                            <br />
                            <div>
                                <label>POS:</label>
                                <asp:Label ID="POSLabel" runat="server" />
                            </div>
                            <br />
                            <div>
                                <label>Sampling Notes:</label>
                                <asp:Label ID="SamplingLabel" runat="server" />
                            </div>

                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="budget">
                    <div class="widget stacked">
                        <div class="widget-content">
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="notes">
                    <div class="widget stacked">
                        <div class="widget-content">
                        </div>
                    </div>
                </div>

                  <div class="tab-pane fade" id="log">
                    <div class="widget stacked">
                        <div class="widget-content">
                        </div>
                    </div>
                </div>
               
              </div>
            </div>
            </div>

             <div class="col-md-6">
                 <h4>Account/Location</h4>

          <div class="bs-example">
                   
              <ul id="accountTab" class="nav nav-tabs" style="margin-bottom:3px; border-bottom: 0px">
                <li id="tab1" class="active"><a href="#address" data-toggle="tab">Address</a></li>
                <li id="tab2" class=""><a href="#directions">Directions</a></li>
                <li class=""><a href="#weather" data-toggle="tab">Weather</a></li>
              </ul>
              <div class="tab-content">
                <div class="tab-pane fade active in" id="address">
                    <div class="widget stacked">
                        <div class="widget-content">
                            <div>
                                <asp:Label ID="AccountNameLabel" runat="server" />
                            </div>
                            <div>
                                <asp:Label ID="AccountAddressLabel" runat="server" />
                            </div>

                           <div>
                               <input type="button" value="ShowTrafficLayer" onclick="showTrafficLayer();" />  |  <input type="button" value="HideTrafficLayer" onclick="hideTrafficLayer();" />
                           </div>
                                    <div id='mapDiv' style="position: relative; width: 100%; height: 50%;"></div>
                            <!-- Directions Button -->
                            <div>
                             <input type="button" value="CreateDrivingRoute" onclick="createDirections();" />
                          </div>
                          <div id='directionsItinerary'> </div> 
                            <!-- End Directions Button -->

                            <div>
                                <label>Show Helpful Locations:</label><br />

                                
                            </div>
                            <div id="LocationList"></div>

                        </div>
                     </div>
                </div>
                <div class="tab-pane fade" id="directions">
                    <div class="widget stacked">
                    <div class="widget-content">

                        <p id="demo"></p>
                                    <div id='mapDiv2' style="position: relative; width: 100%; height: 50%;"></div>

                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="weather">
                    <div class="widget stacked">
                        <div class="widget-content">
                            
                                    <div>
                                        <asp:Label ID="Label1" runat="server" />
                        </div>
                                    <div>
                                        <asp:Label ID="Label2" runat="server" />
                    </div>

                                    <!-- Today -->
                                    <div class="row weatherwrapper">
                                        <div class="col-xs-2 datebox">
                                            <asp:Label ID="lblDay0" runat="server" />
                                            <div class="monthlabel">
                                                <asp:Label ID="lblMonth0" runat="server" />
                </div>
               
              </div>
                                        <div class="col-xs-4 col2">
                                            <div class="daylabel">Today</div>
                                            <div class="templabel">Low:
                                                <asp:Label ID="lblTempMin0" runat="server" /></div>
                                            <div class="templabel">High:
                                                <asp:Label ID="lblTempMax0" runat="server" /></div>

            </div>
                                        <div class="col-xs-4 col3">
                                            <asp:Image ID="imgWeatherIcon0" runat="server" Width="60px" />
                                            <div>
                                                <asp:Label ID="lblMain0" runat="server" />
            </div>
                                        </div>
                                    </div>

                                    <!-- Tomorrow -->
                                    <div class="row weatherwrapper">
                                        <div class="col-xs-2 datebox">
                                            <asp:Label ID="lblDay1" runat="server" />
                                            <div class="monthlabel">
                                                <asp:Label ID="lblMonth1" runat="server" />
                                            </div>
        </div>
                                        <div class="col-xs-4 col2">
                                            <div class="daylabel">Tomorrow</div>
                                            <div class="templabel">Low:
                                                <asp:Label ID="lblTempMin1" runat="server" /></div>
                                            <div class="templabel">High:
                                                <asp:Label ID="lblTempMax1" runat="server" /></div>

                                        </div>
                                        <div class="col-xs-4 col3">
                                            <asp:Image ID="imgWeatherIcon1" runat="server" Width="60px" />
                                            <div>
                                                <asp:Label ID="lblMain1" runat="server" />
                                            </div>
                                        </div>
                                    </div>


                                    <!-- Next Day -->
                                    <div class="row weatherwrapper">
                                        <div class="col-xs-2 datebox">
                                            <asp:Label ID="lblDay2" runat="server" />
                                            <div class="monthlabel">
                                                <asp:Label ID="lblMonth2" runat="server" />
                                            </div>
                                        </div>
                                        <div class="col-xs-4 col2">
                                            <div class="daylabel">
                                                <asp:Label ID="lblDayName2" runat="server" />
                                            </div>
                                            <div class="templabel">Low:
                                                <asp:Label ID="lblTempMin2" runat="server" /></div>
                                            <div class="templabel">High:
                                                <asp:Label ID="lblTempMax2" runat="server" /></div>
                                        </div>
                                        <div class="col-xs-4 col3">
                                            <asp:Image ID="imgWeatherIcon2" runat="server" Width="60px" />
                                            <div>
                                                <asp:Label ID="lblMain2" runat="server" />
                                            </div>
                                        </div>
                                    </div>
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

        });

         function addPushpinWithOptions()
                {
                    var lat = '47.5';
                    var long = '-122.33';

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
              if (!directionsManager) { createDirectionsManager(); }
              directionsManager.resetDirections();
              // Set Route Mode to driving 
              directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
              var seattleWaypoint = new Microsoft.Maps.Directions.Waypoint({ address: 'Seattle, WA' });
              directionsManager.addWaypoint(seattleWaypoint);
              var tacomaWaypoint = new Microsoft.Maps.Directions.Waypoint({ address: 'Tacoma, WA', location: new Microsoft.Maps.Location(47.255134, -122.441650) });
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
              displayAlert('Directions cleared (Waypoints cleared, map/itinerary cleared, request and render options reset to default values)');
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
              displayAlert('Directions cleared (map/itinerary cleared, Waypoints preserved, request and render options preserved)');
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
              map.setView({ zoom: 10, center: new Microsoft.Maps.Location(47.5, -122.33) })
          }
          
          function showTrafficLayer() {

              trafficLayer = new Microsoft.Maps.Traffic.TrafficLayer(map);
              // show the traffic Layer
              trafficLayer.show();
          }


          // hide traffic layer

          function hideTrafficLayer() {
              // hide the traffic Layer
              trafficLayer.hide();
          }
       
      
      </script>
</asp:Content>
