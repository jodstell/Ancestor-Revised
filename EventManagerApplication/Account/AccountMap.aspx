<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AccountMap.aspx.vb" Inherits="EventManagerApplication.AccountMap" %>

<%@ Register Src="~/Accounts/UserControls/AccountContacts.ascx" TagPrefix="uc1" TagName="AccountContacts" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>

    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
    <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release'></script>

</head>
<body>
    <form id="form1" runat="server">

        <asp:HiddenField ID="LatitudeTextBox" runat="server" />
        <asp:HiddenField ID="LongtitudeTextBox" runat="server" />

    <script type="text/javascript">
        window.onload = GetMap;

        function GetMap() {
                // Initialize the map
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                       {
                           credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                           center: new Microsoft.Maps.Location(lat, long),
                           zoom: 12,
                           showDashboard: false
                       });

            var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
            map.entities.push(pushpin);

        }
    </script>


    <div class="container">
        <div class="row">
            <div class="col-md-12">
    
                <div id='printoutPanel'></div>

                <uc1:AccountContacts runat="server" ID="AccountContacts" />

                <div id='mapDiv' style="width: 500px; height: 400px; margin-top: 10px;"></div>

        
            </div>
        </div>
    </div>
    </form>

</body>
</html>
