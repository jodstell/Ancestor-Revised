function GetMap() {
            // Initialize the map
            var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
            var locName = $('#<%=LocationNameMap.ClientID%>').val();
            var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                   {
                       credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                       center: new Microsoft.Maps.Location(lat, long),
                       zoom: 10
                   });

            var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
            map.entities.push(pushpin);


            //Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
            //    var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
            //    directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
            //    var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ address: locName });
            //    directionsManager.addWaypoint(waypoint1);
            //    directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
            //    directionsManager.setRequestOptions({ distanceUnit: Microsoft.Maps.Directions.DistanceUnit.miles });
            //    directionsManager.showInputPanel('directionsInputContainer');
            //    directionsManager.calculateDirections();

            //});

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
                 credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                 center: new Microsoft.Maps.Location(lat, long),
                 zoom: 10
             });

    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
    map.entities.push(pushpin);

    var FromAddress = $('#<%=SelectedDirectionsName.ClientID%>').val();
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
                   credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
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
               credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
               center: new Microsoft.Maps.Location(lat, long),
               zoom: 10
           });

    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
    map.entities.push(pushpin);

    //Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
    //    var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
    //    var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ location: new Microsoft.Maps.Location(lat, long) });
    //    directionsManager.addWaypoint(waypoint1);
    //    directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
    //    directionsManager.showInputPanel('directionsInputContainer');
    //});

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
                   credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                   center: new Microsoft.Maps.Location(lat, long),
                   zoom: 10
               });

    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
    map.entities.push(pushpin);


    //Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
    //    var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
    //    var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ location: new Microsoft.Maps.Location(lat, long) });
    //    directionsManager.addWaypoint(waypoint1);
    //    directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
    //    directionsManager.showInputPanel('directionsInputContainer');
    //});


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
                   credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
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

    //function pageBackwards() {
    //    if (pageIdx > 0) {
    //        pageIdx--;
    //        getNearByLocations();
    //    }
    //}
    //function pageForward() {
    //    //Ensure that paging does not exceed the number of results.
    //    if ((pageIdx + 1) * 10 < numResults) {
    //        pageIdx++;
    //        getNearByLocations();
    //    }
    //}

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
                   credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
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

    //function pageBackwards() {
    //    if (pageIdx > 0) {
    //        pageIdx--;
    //        getNearByLocations();
    //    }
    //}
    //function pageForward() {
    //    //Ensure that paging does not exceed the number of results.
    //    if ((pageIdx + 1) * 10 < numResults) {
    //        pageIdx++;
    //        getNearByLocations();
    //    }
    //}

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
                   credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
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

    //function pageBackwards() {
    //    if (pageIdx > 0) {
    //        pageIdx--;
    //        getNearByLocations();
    //    }
    //}

    //function pageForward() {
    //    //Ensure that paging does not exceed the number of results.
    //    if ((pageIdx + 1) * 10 < numResults) {
    //        pageIdx++;
    //        getNearByLocations();
    //    }
    //}

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
               credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
               center: new Microsoft.Maps.Location(lat, long),
               zoom: 10
           });

    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
    map.entities.push(pushpin);


    //Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
    //    var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
    //    directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
    //    var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ location: new Microsoft.Maps.Location(lat, long) });
    //    directionsManager.addWaypoint(waypoint1);
    //    directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
    //    directionsManager.showInputPanel('directionsInputContainer');
    //    directionsManager.calculateDirections();
    //});

    $("#btnFindGroceryStoresLink").removeClass("btn-success");
    $("#btnFindConvienienceStoresLink").removeClass("btn-success");
    $("#btnFindGasStationsLink").removeClass("btn-success");

}

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