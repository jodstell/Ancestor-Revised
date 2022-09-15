<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Check.aspx.vb" Inherits="EventManagerApplication.Check" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release&callback=GetMap' async defer></script>

    <div class="container">

        <div class="col-md-4 col-xs-12" style="margin-top: 10px; margin-bottom:10px">
            <asp:Panel ID="NotCheckInPanel" runat="server">
           <a href="#" id="checkinbutton" onclick="checkInAmbassador()" class="btn btn-lg btn-primary pull-right checkinbutton">Check In</a></asp:Panel>

            <asp:Panel ID="CheckInPanel" runat="server"><h3><span class="label label-success">Check-in Confirmed</span></h3></asp:Panel>
            <h3><span id="checkInSuccess" class="label label-success" style="display:none">Check-in Confirmed</span></h3>

        </div>

    </div>

    <asp:HiddenField ID="hdnLatitude" runat="server" />
    <asp:HiddenField ID="hdnLongitude" runat="server" />

    <asp:Label ID="hiddenUserName" runat="server"  Visible="true" ForeColor="White"></asp:Label>
    <asp:Label ID="hiddenEventID" runat="server"  Visible="true" ForeColor="White"></asp:Label>

    <div id='mapDiv' style="position: relative;"></div>





    <script>

        var map = null;
        $(document).ready(function () {
            $("#checkInSuccess").hide();
            GetMap();
        });


        function checkInAmbassador() {
            // first run checkin time

            var username = document.getElementById('<%=hiddenUserName.ClientID%>').innerHTML
            var eventid = document.getElementById('<%=hiddenEventID.ClientID%>').innerHTML

            var string1 = username + ";" + eventid;

            $.ajax({
                type: "POST",
                url: "/ambassadors/CheckInServices.asmx/setCheckinTime",
                data: "{ 'mystring': '" + string1 + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //alert("You have been checked in");

                },
                error: function (request, status, error) {
                    alert(request.responseText);
                },

                complete: function (response) {
                    //alert("You are now able to go to work");
                }

            });

            $("#checkinbutton").hide();
            $("#checkInSuccess").show();

            // now run checkin location

            map = new Microsoft.Maps.Map(document.getElementById("mapDiv"),
                       {
                           credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                           center: new Microsoft.Maps.Location(39.50, -98.35),
                           zoom: 4,
                           mapTypeId: Microsoft.Maps.MapTypeId.road,
                           animate: false
                       });

            //Request the user's location
            navigator.geolocation.getCurrentPosition(function (position) {
                var loc = new Microsoft.Maps.Location(
                    position.coords.latitude,
                    position.coords.longitude);

                //Add a pushpin at the user's location.
                var pin = new Microsoft.Maps.Pushpin(loc);
                map.entities.push(pin);

                //Center the map on the user's location.
                map.setView({ center: loc, zoom: 15 });

                var locationPoint1 = position.coords.latitude;
                var locationPoint2 = position.coords.longitude;

                var thestring = username + ";" + locationPoint1 + ";" + locationPoint2 + ";" + eventid;

                $.ajax({
                    type: "POST",
                    url: "/ambassadors/CheckInServices.asmx/setCheckInLocation",
                    data: "{ 'mystring': '" + thestring + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                    },
                    error: function (request, status, error) {
                        // alert(request.responseText);
                    },

                    complete: function (response) {

                    }

                });

            })

            }













    </script>



</asp:Content>
