<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BrandAmbassadorsDetails.aspx.vb" Inherits="EventManagerApplication.BrandAmbassadorsDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    
<head runat="server">

    <title>Brand Ambassadors Details</title>

    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
    <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release'></script>
    <link href="../Theme/css/base-admin-3.css" rel="stylesheet" />
    <link href="../Theme/css/bootstrap.css" rel="stylesheet" />
    <link href="../Theme/css/bootstrap-responsive.min.css" rel="stylesheet" />
 


    

</head>
<body>
    
    <form id="form1" runat="server">


      <div style="display:none">
    <asp:Label ID="LatitudeTextBox" runat="server" />
    <asp:Label ID="LongtitudeTextBox" runat="server" />
    <asp:Label ID="FromAddressLatitude" runat="server"/>
    <asp:Label ID="FromAddressLongtitude" runat="server" /> 
          <asp:Label ID="LocationName2" runat="server" Font-Bold="true" Font-Size="Small" ForeColor="Green" />
          <asp:Label ID="ToAdress2" runat="server" Font-Bold="true" Font-Size="Small" ForeColor="Red" />
          </div>

        <script type="text/javascript"> 
        window.onload = loadMapScenario;
                                           
        function loadMapScenario() {
            
                            // Initialize the map
                         
                         var tolat = $('#<%=LatitudeTextBox.ClientID%>').text();
                         var tolong = $('#<%=LongtitudeTextBox.ClientID%>').text();
                         var FromAddressLatitude = $('#<%=FromAddressLatitude.ClientID%>').text();
                         var FromAddressLongtitude = $('#<%=FromAddressLongtitude.ClientID%>').text();
                         var location = $('#<%=LocationName2.ClientID%>').text();
                         var tolocation = $('#<%=ToAdress2.ClientID%>').text();
                                                

                         var mapambass = new Microsoft.Maps.Map(document.getElementById('mapAmbassadorDiv'),
                                {
                                    credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                                    zoom: 11
                                });
                                
                            var pushpin = new Microsoft.Maps.Pushpin(mapambass.getCenter(), { color: 'red' });
                            mapambass.entities.push(pushpin);

                            Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
                                var directionsManager2 = new Microsoft.Maps.Directions.DirectionsManager(mapambass);
                                // Set Route Mode to driving
                                directionsManager2.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
                                var waypoint3 = new Microsoft.Maps.Directions.Waypoint({ address: location, location: new Microsoft.Maps.Location(FromAddressLatitude, FromAddressLongtitude) });
                                var waypoint4 = new Microsoft.Maps.Directions.Waypoint({ address: tolocation, location: new Microsoft.Maps.Location(tolat, tolong) });
                                directionsManager2.addWaypoint(waypoint3);
                                directionsManager2.addWaypoint(waypoint4);
                                // Set the element in which the itinerary will be rendered
                                directionsManager2.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanelAmbass') });
                                directionsManager2.calculateDirections();
                            });
                                                                   
                        }

                    </script>

        <div class="container">

    
            <div class="row">

                 <div class="col-md-12">
                     <br />
                     <asp:Label ID="AmbassadorNameLabel" Font-Bold="true" Font-Size="Large" runat="server" /><br />
                     <asp:Label ID="From" runat="server" Font-Bold="true" Font-Size="Medium" Text="From Address:" />  <asp:Label ID="LocationName" runat="server" Font-Bold="true" Font-Size="Small" ForeColor="Green" /><br /><br />

                     <asp:Label ID="AccountNameLabel1" Font-Bold="true" Font-Size="Large" runat="server" /><br />
                     <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="Medium" Text="To Address:" />  <asp:Label ID="ToAdress" runat="server" Font-Bold="true" Font-Size="Small" ForeColor="Red" /><br />   
                                       
                     <div id="printoutPanelAmbass" style="display:none;"></div>
                     <div id='mapAmbassadorDiv' style='width: 500px; height: 400px; margin-top: 10px;'></div>  
                     
                </div>

                
            </div>

    

        </div>
    </form>

</body>
</html>
