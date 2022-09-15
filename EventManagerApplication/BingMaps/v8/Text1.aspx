<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Text1.aspx.vb" Inherits="EventManagerApplication.Text1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <div class="container">

        <div class="row">
            <div class="col-md-9">

                <div id='printoutPanel'></div>

    <div>

                <strong><span>Event Summary - Week of</span>
                    <a id="btnPrev" href="#" class="btn btn-link">< Previous</a>

                    <span id="SelectedWeek" style="font-size: 1.5em"></span>

                    <a id="btnNext" class="btn btn-link">Next ></a></strong>

                <input id="txtStartDate" type="text" style="display: none" /><input id="txtEndDate" type="text" style="display: none" />

                <asp:HiddenField ID="hiddenStartDate" runat="server" />


                <div style="margin-bottom: 15px; display: none">
                    From:
                <telerik:RadDatePicker ID="FromDatePicker" runat="server"></telerik:RadDatePicker>
                    To:
                <telerik:RadDatePicker ID="ToDatePicker" runat="server"></telerik:RadDatePicker>
                    <asp:Button ID="btnChangeDateRange" runat="server" Text="Go" CssClass="btn btn-default" />

                    <div class="btn-group pull-right" role="group" aria-label="...">
                        <asp:Button ID="btnViewWeek" runat="server" Text="Week" CssClass="btn btn-success" />
                        <asp:Button ID="btnViewMonth" runat="server" Text="Month" CssClass="btn btn-default" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">

                        <div class="feature col-sm-2 col-xs-3  center">

                            <div class="well blackbox smbox">
                                <div class="marginbotton5"><span id="totalevents"></span></div>
                                <h5 class="noline">Total<br />
                                    Events</h5>
                            </div>

                        </div>

                        <div class="feature col-sm-2 col-xs-3 center">

                            <div class="well approved smbox">
                                <div class="marginbotton5"><span id="approvedevents"></span></div>
                                <h5>Approved<br />
                                    Events</h5>
                            </div>

                        </div>

                        <div class="feature col-sm-2 col-xs-3 center">

                            <div class="well scheduled smbox">
                                <div class="marginbotton5"><span id="scheduledevents"></span></div>
                                <h5 class="noline">Scheduled<br />
                                    Events</h5>
                            </div>

                        </div>

                        <div class="feature col-sm-2 col-xs-3 center">

                            <div class="well booked smbox">
                                <div class="marginbotton5"><span id="bookedevents"></span></div>
                                <h5 class="noline">Booked<br />
                                    Events</h5>
                            </div>

                        </div>

                        <div class="feature col-md-2 col-xs-3  center">

                            <div class="well requested smbox">
                                <div class="marginbotton5"><span id="shippingrequested"></span></div>
                                <h5 class="noline">Shipping<br />
                                    Requested</h5>
                            </div>

                        </div>

                        <div class="feature col-sm-2 col-xs-3 center">

                            <div class="altered-well cancelled altered-sm-box">
                                <span class="sm-box" id="cencelledevents"></span>
                                <span class="sm-box-text">Cancelled</span>
                            </div>



                            <div class="altered-well toplined altered-sm-box">
                                <span class="sm-box" id="toplinedevents"></span>
                                <span class="sm-box-text">Toplined</span>
                            </div>

                        </div>



                    </div>
                </div>


                <div class="row">
                    <div class="col-md-12">
                        <!-- Row created from script -->
                        <div class="row">
                            <div id="results" class="col-md-2">
                            </div>
                        </div>

                        <div class="clearfix"></div>

                        <div class="widget stacked">
                            <div class="widget-content" style="padding: 2px 2px 2px;">

                                <div id='mapDiv' style="position: relative; width: 100%; height: 100%;"></div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

                </div>

            </div>

            </div>

    <script type='text/javascript'>
                $(document).ready(function () {

               

                Date.prototype.GetFirstDayOfWeek = function () {
                    return (new Date(this.setDate(this.getDate() - this.getDay())));
                }

                Date.prototype.GetLastDayOfWeek = function () {
                    return (new Date(this.setDate(this.getDate() - this.getDay() + 6)));
                }

                var today = new Date();

                var start = today.GetFirstDayOfWeek()
                var end = today.GetLastDayOfWeek()


                var startDate = (start.getMonth() + 1 + "/" + start.getDate() + "/" + start.getFullYear());
                var endDate = (end.getMonth() + 1 + "/" + end.getDate() + "/" + end.getFullYear());


                $('#txtStartDate').val(startDate);
                $('#txtEndDate').val(endDate);
                var end_dt = new Date($('#txtEndDate').val());
                var start_dt = new Date($('#txtStartDate').val());
                $('#SelectedWeek').html(getMonthFormat(start_dt) + " - " + getMonthFormat(end_dt));
                $('#hiddenStartDate').val(startDate);


                $('#btnNext').click(function () {
                    var end_dt = new Date($('#txtEndDate').val());
                    end_dt.setDate(end_dt.getDate() + 7); // add 7 days
                    $('#txtEndDate').val(getDateFormat(end_dt));

                    var start_dt = new Date($('#txtStartDate').val());
                    start_dt.setDate(start_dt.getDate() + 7); // add 7 days
                    $('#txtStartDate').val(getDateFormat(start_dt));

                    $('#SelectedWeek').html(getMonthFormat(start_dt) + " - " + getMonthFormat(end_dt));
                    GetMap();
                });

                $('#btnPrev').click(function () {
                    var end_dt = new Date($('#txtEndDate').val());
                    end_dt.setDate(end_dt.getDate() - 7); // subtract 7 days
                    $('#txtEndDate').val(getDateFormat(end_dt));

                    var start_dt = new Date($('#txtStartDate').val());
                    start_dt.setDate(start_dt.getDate() - 7); // subtract 7 days
                    $('#txtStartDate').val(getDateFormat(start_dt));

                    $('#SelectedWeek').html(getMonthFormat(start_dt) + " - " + getMonthFormat(end_dt));
                    GetMap();
                });


            });

            function getDateFormat(d) {

                return (d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear();
            }

            function getMonthFormat(d) {

                var m_names = new Array("January", "February", "March",
                "April", "May", "June", "July", "August", "September",
                "October", "November", "December");

                var curr_date = d.getDate();
                var curr_month = d.getMonth();
                var curr_year = d.getFullYear();

                return (m_names[curr_month] + " " + curr_date);
            }

        </script>

    <script type='text/javascript'>
            function loadMapScenario() {
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'), {
                    credentials: 'AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj',
                    center: new Microsoft.Maps.Location(39.50, -98.35), 
                    zoom: 4,
                    mapTypeId: Microsoft.Maps.MapTypeId.road,
                    animate: false
                });

                //  alert("function Started");



                var s = $('#txtStartDate').val();
                var e = $('#txtEndDate').val();
                var clientid = "18";

                $.ajax({
                    type: 'POST',
                    url: '/clientService.asmx/getEventsByDateRange',
                    data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                       
                        
                        var pins = response.d

                        $.each(pins, function (index, pin) {

                          //  alert(pin.PushPinIcon);

                            var pushpinoptions = { color: pin.PushPinIcon };

                            var pushpin = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(pin.Latitude, pin.Longitude), pushpinoptions);
                            var center = new Microsoft.Maps.Location(pin.Latitude, pin.Longitude)


                           var infobox = new Microsoft.Maps.Infobox(center, { title: "<div><b>" + pin.FormatedEventDate + "</b><br />" + pin.FormatedStartTime,
                                description: "<div style='line-height: 12px;'>" + pin.Supplier + "<br />" + pin.VenueName + "<br />" + pin.Address1 + "<br />" + pin.City + " " + pin.State + "</div><div><br /><a class='btn btn-primary btn-xs pull-right' href='/events/eventdetails?ID=" + pin.ID + "'>View Event</a><br /></div></div>", visible: false });

                            infobox.setMap(map);

                            Microsoft.Maps.Events.addHandler(pushpin, 'click', function () {
                                infobox.setOptions({ visible: true });
                            });


                            
                          //  var infobox = new Microsoft.Maps.Infobox(pushpins[0].getLocation(), { visible: false });
                          //  infobox.setMap(map);

                           // pushpin.Title = "<div><b>" + pin.FormatedEventDate + "</b><br />" + pin.FormatedStartTime;
                           // pushpin.Description = "<div style='line-height: 12px;'>" + pin.Supplier + "<br />" + pin.VenueName + "<br />" + pin.Address1 + "<br />" + pin.City + " " + pin.State + "</div><div><br /><a class='btn btn-primary btn-xs pull-right' href='/events/eventdetails?ID=" + pin.ID + "'>View Event</a><br /></div></div>";

                            
                            //continue with info
                            
                                                      

                            
                            map.entities.push(pushpin);

                        });



                    },
                    error: function (e, ajaxOptions, thrownError) {
                        alert("something went wrong: " + e.status);
                        alert(thrownError);
                    }
                });




                // Generate an array of 10 random pushpins within current map bounds
              //  var pushpins = Microsoft.Maps.TestDataGenerator.getPushpins(10, map.getBounds());
                
               

               

                
             //   var me1 = new Microsoft.Maps.Location(33.4700088500977, -111.905975341797)

            //    var pushpin1 = new Microsoft.Maps.Pushpin(me1, null);
            //    map.entities.push(pushpin1);



                // 

               // var pushpins = Microsoft.Maps.TestDataGenerator.getPushpins(10, map.getBounds());
                

            //    var layer = new Microsoft.Maps.Layer();
              //  layer.add(pushpins);
           //     map.layers.insert(layer);
               


              //  var layer = new Microsoft.Maps.Layer();
              //  layer.add(pushpins);
             //   map.layers.insert(dataLayer);

             //   AddData();

            }


            function AddData() {


                alert('hello');
               
            }

    </script>
    <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release&callback=loadMapScenario' async defer></script>

</asp:Content>
