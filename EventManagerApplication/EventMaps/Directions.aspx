<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Directions.aspx.vb" Inherits="EventManagerApplication.Directions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>

    

</head>
<body  onload="GetMap1();">
    <form id="form1" runat="server">
    <div>
         <asp:HiddenField ID="LatitudeTextBox" runat="server" />
    <asp:HiddenField ID="LongtitudeTextBox" runat="server" />



        <%: Request.QueryString("EventID")%>

                <br />
        <hr />

    <asp:Button runat="server" ID="btn1" OnClientClick="javascript:GetMap1();" Text="Get Map" />

         <div class="widget stacked">
                    <div class="widget-content">

                     <div>
          <div id='mapDiv' style="position:relative;width:600px;height:400px;"></div>

    </div>

                        </div>
                    </div>

    
    </div>

         <script type="text/javascript">
                 var map = null, infobox, dataLayer;

                 function GetMap1() {
                     alert("Code Ran");
              // Initialize the map
              map = new Microsoft.Maps.Map(document.getElementById("mapDiv"),
                         { credentials: "Ar9r5Jz1bSVYhbZJ4p8CYoOLi1NuWoHVYl1NxJftPJz_FkhXUOxosfSgxDqbIpGg" });

              alert("Code Ran2");

              dataLayer = new Microsoft.Maps.EntityCollection();
              map.entities.push(dataLayer);

              var infoboxLayer = new Microsoft.Maps.EntityCollection();
              map.entities.push(infoboxLayer);

              infobox = new Microsoft.Maps.Infobox(new Microsoft.Maps.Location(0, 0), { visible: false, offset: new Microsoft.Maps.Point(0, 20) });
              infoboxLayer.push(infobox);

              addPushpins();
          }

          function addPushpins() {
              var limit = 15;
              var bounds = map.getBounds();
              latlon = bounds.getNorthwest();
              var lat = latlon.latitude - bounds.height / 4;
              var lon = latlon.longitude + bounds.width / 4;
              var latDiff = bounds.height / 2;
              var lonDiff = bounds.width / 2;
              for (var i = 0; i < limit; i++) {
                  var pushpin = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(lat - (latDiff * Math.random()), lon + (lonDiff * Math.random())), null);
                  map.entities.push(pushpin);
              }
          }

          function AddData() {
              var pin1 = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(37.789924621582, -122.423385));
              pin1.Title = "This is Pin 1";
              pin1.Description = "Pin 1 description";
              Microsoft.Maps.Events.addHandler(pin1, 'click', displayInfobox);
              dataLayer.push(pin1);

              var pin2 = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(37.780909538269, -122.399710267782));
              pin2.Title = "This is Pin 2";
              pin2.Description = "Pin 2 description";
              Microsoft.Maps.Events.addHandler(pin2, 'click', displayInfobox);
              dataLayer.push(pin2);
          }

          function displayInfobox(e) {
              if (e.targetType == 'pushpin') {
                  infobox.setLocation(e.target.getLocation());
                  infobox.setOptions({ visible: true, title: e.target.Title, description: e.target.Description });
              }
          }
      </script>

       
    </form>
</body>
</html>
