<%@ Page Title="Available Events" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AvailableEvents.aspx.vb" Inherits="EventManagerApplication.AvailableEvents" %>

<%@ Register Src="~/Ambassadors/UserControls/AvailableControl.ascx" TagPrefix="uc1" TagName="AvailableControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">  
    

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
        <div class="col-md-12">
            <asp:Label ID="ErrorLabel" runat="server" />
        </div>
    </div>

    <div class="row">

        <div class="col-md-7">

            <h3 style="color: black; font-weight: bold;">Available Events</h3>

            <div>
                <div>
                    <div class="col-md-12">

                        <telerik:RadGrid ID="AvailableEventsList" runat="server" DataSourceID="getAvailableEvents" AutoGenerateColumns="False" CellSpacing="-1" Height="700px">


                            <ClientSettings EnableRowHoverStyle="true">
                                <Selecting AllowRowSelect="true" />
                                <ClientEvents OnRowClick="RefreshMap" />
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>

                            <MasterTableView DataSourceID="getAvailableEvents" DataKeyNames="eventID" ClientDataKeyNames="eventID" >
                                <Columns>

                                    <telerik:GridTemplateColumn>
                                        <ItemStyle Wrap="false" />
                                        
                                        <ItemTemplate>
                                            <div class="btn-group" role="group" aria-label="...">
                                            
                                                <asp:Button ID="btnRequestEvent" runat="server" Text='Request' CssClass='btn btn-sm btn-primary'  
                                                    CommandArgument='<%# Eval("eventID") %>' CommandName="RequestEvent" Visible='<%# showRequestButton(Eval("eventID")) %>' />

                                                <asp:Button ID="btnDeleteRequestEvent" runat="server" Text='Delete Request' CssClass='btn btn-sm btn-danger'  
                                                    CommandArgument='<%# Eval("eventID") %>' CommandName="DeleteRequestEvent" Visible='<%# showDeleteRequestButton(Eval("eventID")) %>' />

                                            <a href='/Events/Event_Details?ID=<%# Eval("eventID") %>' class="btn btn-sm btn-default" onclick="ShowLoadingPanel()">View Event</a>
                                                </div><br />
                                            <asp:Label ID="RequestStatusLabel" runat="server" Font-Size="Small" Text='<%# getRequestStatus(Eval("eventID")) %>'></asp:Label>
                                        </ItemTemplate>
                                        
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Event" UniqueName="supplierName" SortExpression="supplierName">
                                        <ItemTemplate>
                                            <a href='/Events/Event_Details?ID=<%# Eval("eventID") %>' onclick="ShowLoadingPanel()"><%# Eval("supplierName") %></a>
                    <br />
<asp:Label ID="Label1" runat="server" Text='<%# Eval("accountName") %>'></asp:Label><br />
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("streetAddress1") %>'></asp:Label><br />
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("city") %>'></asp:Label>,<asp:Label ID="Label4" runat="server" Text='<%# Eval("state") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Event Date" UniqueName="eventDate" SortExpression="eventDate">
                                        <ItemTemplate>
                                            <%# Eval("eventDate", "{0:d}") %><br />
                    <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="hours" FilterControlAltText="Filter hours column"
                                        HeaderText="Hours" SortExpression="hours" UniqueName="hours">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="positionTitle" FilterControlAltText="Filter positionTitle column"
                                        HeaderText="Position" SortExpression="positionTitle" UniqueName="positionTitle">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="miles" FilterControlAltText="Filter miles column"
                                        HeaderText="Miles" SortExpression="miles" UniqueName="miles">
                                    </telerik:GridBoundColumn>
                                                                        
                                </Columns>

                                <NoRecordsTemplate>

                                    <table class="table" cellspacing="0" style="width: 100%;">
                                        <tbody>
                                            <tr>
                                                <td colspan="7">
                                                    <div class="alert alert-warning" role="alert">There are no available events in your area. Please check back again.</div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

                                </NoRecordsTemplate>

                            </MasterTableView>

                            
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="getAvailableEvents" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                            SelectCommand="GetAvailableEventsbyAmbassadorID" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="CurrentUserID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

                        <%--<uc1:AvailableControl runat="server" id="AvailableControl" />--%>
                    </div>
                </div>
                <!-- End Content -->
            </div>

        </div>

        <div class="col-md-5">

            <h3 style="color: black; font-weight: bold;">Map</h3>
            
            <div class="widget stacked">
                <div class="widget-content">

                    <div id="mapDiv" style="width: 100%; height: 100%; position: relative;"></div>
                    <span>Click on an event in the avaliable events table to find the location on the map.</span>

                </div>
            </div>                               
            
        </div>

    </div>
</div>


    <asp:HiddenField ID="LatitudeHiddenField" runat="server" />
    <asp:HiddenField ID="LongtitudeHiddenField" runat="server" />

    <asp:Label ID="LatitudeLabel" runat="server" ForeColor="White" />
    <asp:Label ID="LongtitudeLabel" runat="server" ForeColor="White" />

    
    <script type="text/javascript">
        var map = null, infobox, dataLayer;

        function RefreshMap(sender, args) {

             var eventID = args.getDataKeyValue("eventID");

             // Initialize the map
             var lat = $('#<%=LatitudeHiddenField.ClientID%>').val();
             var long = $('#<%=LongtitudeHiddenField.ClientID%>').val();


            var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'

            map = new Microsoft.Maps.Map(document.getElementById("mapDiv"),
                {
                    credentials: bingkey,
                    center: new Microsoft.Maps.Location(lat, long),
                    zoom: 9
                });

            var userid = 'FakeID';

            $.ajax({
                type: 'POST',
                url: '/clientService.asmx/GetAvailableEventsMapbyAmbassadorSelectedEvent',
                data: '{"UserID": "' + eventID + '"}',
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

                        var myDescription = "<div style='line-height: 18px; position: absolute; top: 7%; left: 4%; font-size: 12px;'><div style='font-size: 13px;color: black;'><b>" + pin.FormatedEventDate + "</b><br />" + pin.FormatedStartTime + "</div><br />" + pin.Supplier + "<br />" + pin.VenueName + "<br />" + pin.Address1 + "<br />" + pin.City + " " + pin.State + "</div><div><br /><a style='position: absolute; top: 77%; left: 70%;' class='btn btn-primary btn-xs pull-right' href='/events/event_details?ID=" + pin.ID + "'>View Event</a><br /></div></div>";

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
                    //alert("something went wrong: " + e.status);
                    //  alert(thrownError);
                }
            });

        }

        function GetMap() {

            // Initialize the map

            var lat = $('#<%=LatitudeHiddenField.ClientID%>').val();
            var long = $('#<%=LongtitudeHiddenField.ClientID%>').val();


            var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'

                    map = new Microsoft.Maps.Map(document.getElementById("mapDiv"),
                        {
                            credentials: bingkey,
                            center: new Microsoft.Maps.Location(lat, long),
                            zoom: 9
                        });

                    var userid = 'FakeID';

                    //alert(userid);

                    $.ajax({
                        type: 'POST',
                        url: '/clientService.asmx/GetAvailableEventsMapbyAmbassador',
                        data: '{"UserID": "' + userid + '"}',
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

                                var myDescription = "<div style='line-height: 18px; position: absolute; top: 7%; left: 4%; font-size: 12px;'><div style='font-size: 13px;color: black;'><b>" + pin.FormatedEventDate + "</b><br />" + pin.FormatedStartTime + "</div><br />" + pin.Supplier + "<br />" + pin.VenueName + "<br />" + pin.Address1 + "<br />" + pin.City + " " + pin.State + "</div><div><br /><a style='position: absolute; top: 77%; left: 70%;' class='btn btn-primary btn-xs pull-right' href='/events/event_details?ID=" + pin.ID + "'>View Event</a><br /></div></div>";

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
                            //alert("something went wrong: " + e.status);
                            //  alert(thrownError);
                        }
                    });

                    }
        
    </script>

    
    <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release&callback=GetMap' async defer></script>

</asp:Content>