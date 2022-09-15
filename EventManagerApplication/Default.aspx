<%@ Page Title="Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Default.aspx.vb" Inherits="EventManagerApplication._Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <%--<script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>--%>
    <%--<script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release'></script>--%>

    <link href="/css/infoboxStyles.css" rel="stylesheet" />
    <link href="Theme/css/custom1.css" rel="stylesheet" />


    <style>
        .infobox-body {
            height: 150px !important;
            width: 270px !important;
            max-width: 300px !important;
            max-height: 200px !important;
        }
    </style>


    <div class="container">

        <div class="row">
            <div class="col-md-9">

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
                                <h5 class="noline">Client Requested<br />
                                    Events</h5>
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

            <div class="col-md-3">
                <h4>Event Volume by:</h4>
                <br />

                <div class="bs-example">
                    <ul id="myTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                        <li class="active"><a href="#supplier" data-toggle="tab">Supplier</a></li>
                        <li class=""><a href="#brand" data-toggle="tab">Brand</a></li>
                        <li class=""><a href="#state" data-toggle="tab">State</a></li>
                        <li class=""><a href="#eventType" data-toggle="tab">Event Type</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="supplier">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <table style="width: 100%">
                                        <div id="supplierCount"></div>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="brand">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <table style="width: 100%">
                                        <div id="brandsCount"></div>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="state">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <table style="width: 100%">
                                        <div id="statesCount"></div>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="eventType">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <table style="width: 100%">
                                        <div id="eventTypeCount"></div>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>



            </div>


        </div>

    </div>


    <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="0"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>


    <script type="text/javascript">
        $('#dashboardTab').addClass('active');
    </script>



    <script type="text/javascript">

        $(document).ready(function () {

            var id = "Jim"

            $.ajax({
                type: "POST",
                url: "ClientService.asmx/getUserName",
                data: '{"userID": "' + id + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                success: function (msg) {
                  //  alert(msg.d);
                },
                error: function (e) {
                  //   alert(a.responsiveText);
                }
            });




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


    <!--The script for the big map  --->
    <script type="text/javascript">
        var map = null, infobox, dataLayer;

        function GetMap() {

            // Initialize the map

            var string1 = "Dashboard";

            $.ajax({
                type: "POST",
                url: "/ClientService.asmx/LoadBingMap",
                data: "{ 'mystring': '" + string1 + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //alert("You have been checked in");

                },
                error: function (request, status, error) {
                    //alert(request.responseText);
                },

                complete: function (response) {
                    //alert("You are now able to go to work");
                }

            });

            var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'

            map = new Microsoft.Maps.Map(document.getElementById("mapDiv"),
                       {
                           credentials: bingkey,
                           center: new Microsoft.Maps.Location(39.50, -98.35),
                           zoom: 4
                       });

                var s = $('#txtStartDate').val();
                var e = $('#txtEndDate').val();

                var clientid = <%= Session("CurrentClientID") %>;

                $.ajax({
                    type: 'POST',
                    url: '/clientService.asmx/getEventsByDateRange',
                    data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {



                        var pins = response.d

                        $.each(pins, function (index, pin) {

                           // alert(pin.VenueName);

                            var pushpinoptions = { color: pin.PushPinIcon };
                            var pins = new Microsoft.Maps.Location(pin.Latitude, pin.Longitude)

                            var pushpin = new Microsoft.Maps.Pushpin(pins, pushpinoptions);

                            var infoboxTemplate = '<div id="infoboxText" style="background-color:White; border: 1px solid rgb(136, 136, 136); min-height:130px; width: 250px; "><b id="infoboxTitle" style="position: absolute; top: 10px; left: 10px; width: 220px; ">{title}</b><p id="infoboxDescription" style="position: absolute; top: 50px; left: 10px; width: 220px; ">{description}</p></div>';

                            var myDescription = "<div style='line-height: 18px; position: absolute; top: 7%; left: 4%; font-size: 12px;'><div style='font-size: 13px;color: black;'><b>" + pin.FormatedEventDate + "</b><br />" + pin.FormatedStartTime + "</div><br />" + pin.Supplier + "<br />" + pin.VenueName + "<br />" + pin.Address1 + "<br />" + pin.City + " " + pin.State + "</div><div><br /><a style='position: absolute; top: 77%; left: 70%;' class='btn btn-primary btn-xs pull-right' href='/events/eventdetails?ID=" + pin.ID + "'>View Event</a><br /></div></div>";

                            var infobox2 = new Microsoft.Maps.Infobox(pins, {
                                description: myDescription,
                                visible: false
                            });


                            infobox2.setMap(map);

                            Microsoft.Maps.Events.addHandler(pushpin, 'click', function () {
                                infobox2.setOptions({ visible: true });
                            });


                            map.entities.push(pushpin);

                        });


                    },
                    error: function (e, ajaxOptions, thrownError) {
                       // alert("something went wrong: " + e.status);
                      //  alert(thrownError);
                    }
                });

            //add total counts of status
               AddData();
        }


        function AddData() {

            var s = $('#txtStartDate').val();
            var e = $('#txtEndDate').val();
            var clientid = <%= Session("CurrentClientID") %>;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '/clientService.asmx/getTotalEventSummaryByDateRange',
                data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var customers = eval(response.d);
                    var html = "";
                    $.each(customers, function () {
                        html += "<h2>" + this.Total + "</h2>";
                    });
                    $("#totalevents").html(html == "" ? "No results" : html);
                },
                error: function (a, b, c) {
                   // alert(a.responseText);
                }
            });

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '/clientService.asmx/getApprovedEventSummaryByDateRange',
                data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var customers = eval(response.d);
                    var html = "";
                    $.each(customers, function () {
                        html += "<h2>" + this.Total + "</h2>";
                    });
                    $("#approvedevents").html(html == "" ? "No results" : html);
                },
                error: function (a, b, c) {
                   // alert(a.responseText);
                }
            });

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '/clientService.asmx/getScheduledEventSummaryByDateRange',
                data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var customers = eval(response.d);
                    var html = "";
                    $.each(customers, function () {
                        html += "<h2>" + this.Total + "</h2>";
                    });
                    $("#scheduledevents").html(html == "" ? "No results" : html);
                },
                error: function (a, b, c) {
                    // alert(a.responseText);
                }
            });

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '/clientService.asmx/getBookedEventSummaryByDateRange',
                data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var customers = eval(response.d);
                    var html = "";
                    $.each(customers, function () {
                        html += "<h2>" + this.Total + "</h2>";
                    });
                    $("#bookedevents").html(html == "" ? "No results" : html);
                },
                error: function (a, b, c) {
                   //  alert(a.responseText);
                }
            });

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '/clientService.asmx/getCancelledEventSummaryByDateRange',
                data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var customers = eval(response.d);
                    var html = "";
                    $.each(customers, function () {
                        html += this.Total;
                    });
                    $("#cencelledevents").html(html == "" ? "No results" : html);
                },
                error: function (a, b, c) {
                   // alert(a.responseText);
                }
            });

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '/clientService.asmx/getToplinedEventSummaryByDateRange',
                data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var customers = eval(response.d);
                    var html = "";
                    $.each(customers, function () {
                        html += this.Total;
                    });
                    $("#toplinedevents").html(html == "" ? "No results" : html);
                },
                error: function (a, b, c) {
                   // alert(a.responseText);
                }
            });

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '/clientService.asmx/getShippingRequestedSummaryByDateRange',
                data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var customers = eval(response.d);
                    var html = "";
                    $.each(customers, function () {
                        html += "<h2>" + this.Total + "</h2>";
                    });
                    $("#shippingrequested").html(html == "" ? "No results" : html);
                },
                error: function (a, b, c) {
                    // alert(a.responseText);
                }
            });



            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '/clientService.asmx/getEventSupplierByDateRange',
                data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var customers = eval(response.d);
                    var html = "";
                    $.each(customers, function () {
                        html += "<tr><td style='padding-right:25px'>" + this.Title + "</td>" + "<td style='text-align:right'>" + this.Total + "</td></tr>";
                    });
                    $("#supplierCount").html(html == "" ? "No results" : html);
                },
                error: function (a, b, c) {
                   // alert(a.responseText);
                }
            });



            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '/clientService.asmx/getEventTypeByDateRange',
                data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var customers = eval(response.d);
                    var html = "";
                    $.each(customers, function () {
                        html += "<tr><td style='padding-right:25px'>" + this.Title + "</td>" + "<td style='text-align:right'>" + this.Total + "</td></tr>";
                    });
                    $("#eventTypeCount").html(html == "" ? "No results" : html);
                },
                error: function (a, b, c) {
                    // alert(a.responseText);
                }
            });


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '/clientService.asmx/getEventBrandsByDateRange',
                data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var customers = eval(response.d);
                    var html = "";
                    $.each(customers, function () {
                        html += "<tr><td style='padding-right:25px'>" + this.Title + "</td>" + "<td style='text-align:right'>" + this.Total + "</td></tr>";
                    });
                    $("#brandsCount").html(html == "" ? "No results" : html);
                },
                error: function (a, b, c) {
                    // alert(a.responseText);
                }
            });

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '/clientService.asmx/getEventStateByDateRange',
                data: '{"startDate": "' + s + '", "endDate": "' + e + '", "id": "' + clientid + '"}',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var customers = eval(response.d);
                    var html = "";
                    $.each(customers, function () {
                        html += "<tr><td style='padding-right:35px'>" + this.Title + "</td>" + "<td style='text-align:right'>" + this.Total + "</td></tr>";
                    });
                    $("#statesCount").html(html == "" ? "No results" : html);
                },
                error: function (a, b, c) {
                   //  alert(a.responseText);
                }
            });

        }



        //function displayInfobox(e) {
        //    if (e.targetType == 'pushpin') {
        //        //HTML that generates the frame for the custom infobox
        //        var pushpinFrameHTML = '<div class="infobox"><a class="infobox_close" href="javascript:closeInfobox()"><img src="/images/close.png"/></a><div class="infobox_content">{content}</div></div><div class="infobox_pointer"><img src="/images/pointer_shadow.png"></div>';

        //        var html = "<span class='infobox_title'>" + e.target.Title + "</span><br/>" + e.target.Description;

        //        infobox.setOptions({ visible: true, offset: new Microsoft.Maps.Point(-33, 20), htmlContent: pushpinFrameHTML.replace('{content}', html) });
        //        infobox.setLocation(e.target.getLocation());
        //    }
        //}



        //function setInfoBoxHTMLContent() {
        //    map.entities.clear();
        //    var infoboxOptions = { width: 200, height: 100, showCloseButton: true, zIndex: 0, offset: new Microsoft.Maps.Point(10, 0), showPointer: true };
        //    var defaultInfobox = new Microsoft.Maps.Infobox(map.getCenter(), infoboxOptions);
        //    map.entities.push(defaultInfobox);
        //}

        //function setViewBounds() {
        //    map.setView({
        //        bounds: Microsoft.Maps.LocationRect.fromLocations(
        //            new Microsoft.Maps.Location(37.789924621582, -122.423385),
        //            new Microsoft.Maps.Location(37.780909538269, -122.399710267782))
        //    });
        //}
    </script>

    <asp:Panel ID="LoadMapPanel" runat="server" Visible="true">
    <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release&callback=GetMap' async defer></script>
    </asp:Panel>

</asp:Content>
