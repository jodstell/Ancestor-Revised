<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DirectionsMapControl.ascx.vb" Inherits="EventManagerApplication.DirectionsMapControl" %>


<div id='mapDiv2' style="position: relative; width: 100%; height: 50%;"></div>


 <script type="text/javascript">
          var map = null;
          var directionsManager;
          var directionsErrorEventObj;
          var directionsUpdatedEventObj;
          var a = null;
          var b = null;

          $(document).ready(function () {

              GetMap();
          });
            
          function GetMap()
              
      {

              // Initialize the map
          map = new Microsoft.Maps.Map(document.getElementById("mapDiv2"),
                     {
                         credentials: "Ar9r5Jz1bSVYhbZJ4p8CYoOLi1NuWoHVYl1NxJftPJz_FkhXUOxosfSgxDqbIpGg",
                     });

          getLocation();
          }


          function createDirectionsManager() {
              var displayMessage;
              if (!directionsManager) {
                  directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
                  displayMessage = 'Directions Module loaded\n';
                  displayMessage += 'Directions Manager loaded';
              }
              alert(displayMessage);
              directionsManager.resetDirections();
              directionsErrorEventObj = Microsoft.Maps.Events.addHandler(directionsManager, 'directionsError', function (arg) { alert(arg.message) });
              directionsUpdatedEventObj = Microsoft.Maps.Events.addHandler(directionsManager, 'directionsUpdated', function () { alert('Directions updated') });
          }

          function createDrivingRoute() {
              if (!directionsManager) { createDirectionsManager(); }
              directionsManager.resetDirections();



              // Set Route Mode to driving 


              directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
              alert(a + ', ' + b)
              var seattleWaypoint = new Microsoft.Maps.Directions.Waypoint({ location: new Microsoft.Maps.Location(a, b) });
              directionsManager.addWaypoint(seattleWaypoint);
              var tacomaWaypoint = new Microsoft.Maps.Directions.Waypoint({ address: 'Sofia, Bulgaria' });
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

          function getLocation() {
              if (navigator.geolocation) {
                  navigator.geolocation.getCurrentPosition(showPosition);
              } else {
                  x.innerHTML = "Geolocation is not supported by this browser.";
              }
          }

          function showPosition(position) {
              a = position.coords.latitude;
              b = position.coords.longitude;
              createDirections();
              // x.innerHTML = position.coords.latitude + ", " + position.coords.longitude;
          }


     </script>