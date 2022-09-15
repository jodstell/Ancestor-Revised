<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ViewLocation.aspx.vb" Inherits="EventManagerApplication.ViewLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>

     
    <div id="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12">
                    
                     <div id='mapDiv' style="position:relative;width:600px;height:400px;"></div>

                </div>

            </div>

        </div>

    </div>



      <script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>

      <script type="text/javascript">
          var map = null, infobox, dataLayer;

          $(document).ready(function () {

              GetMap();

          });



          function GetMap() {
              // Initialize the map
              map = new Microsoft.Maps.Map(document.getElementById("mapDiv"),
                         { credentials: "Ar9r5Jz1bSVYhbZJ4p8CYoOLi1NuWoHVYl1NxJftPJz_FkhXUOxosfSgxDqbIpGg",
                         center: new Microsoft.Maps.Location(41.8756, -87.9956), zoom: 2
                         });

              dataLayer = new Microsoft.Maps.EntityCollection();
              map.entities.push(dataLayer);

              var infoboxLayer = new Microsoft.Maps.EntityCollection();
              map.entities.push(infoboxLayer);

              infobox = new Microsoft.Maps.Infobox(new Microsoft.Maps.Location(0, 0), { visible: false, offset: new Microsoft.Maps.Point(0, 20) });
              infoboxLayer.push(infobox);

              AddData();
             // setViewBounds();
          }

          function AddData() {

            //  alert("function Started");
                            
              $.ajax({
                  type: 'GET',
                  url: '/clientService.asmx/getLocations',
                  data: {}, 
                  contentType: "application/json; charset=utf-8", 
                  dataType: "json", 
                  
                  success: function (response) {

                     // alert("function success");
                  var pins = response.d 
                  
                  $.each(pins, function (index, pin) {
                      var pin1 = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(pin.Latitude, pin.Longitude));
                      pin1.Title = pin.AccountName;
                      pin1.Description = "description";
                      Microsoft.Maps.Events.addHandler(pin1, 'click', displayInfobox);
                      dataLayer.push(pin1);
                    });
                  },
                  error: function (e, ajaxOptions, thrownError) {
                      alert("something went wrong: " + e.status);
                      alert(thrownError);
                  }
          }); 

              
          }

          function displayInfobox(e) {
              if (e.targetType == 'pushpin') {
                  infobox.setLocation(e.target.getLocation());
                  infobox.setOptions({ visible: true, title: e.target.Title, description: e.target.Description });
              }
          }

          function setViewBounds() {
              map.setView({
                  bounds: Microsoft.Maps.LocationRect.fromLocations(
                      new Microsoft.Maps.Location(37.789924621582, -122.423385),
                      new Microsoft.Maps.Location(37.780909538269, -122.399710267782))
              });
          }
      </script>




</asp:Content>

