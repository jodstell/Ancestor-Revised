
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
                   credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
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


