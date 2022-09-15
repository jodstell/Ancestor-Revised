<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="WebForm1.aspx.vb" Inherits="EventManagerApplication.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">



        <div id='printoutPanel'></div>
        
        <div id='myMap' style='width: 100vw; height: 100vh;'></div>
        <script type='text/javascript'>
                var map;
                function loadMapScenario() {
                    map = new Microsoft.Maps.Map(document.getElementById('myMap'), {
                        credentials: 'AncUUS0MoHOCy9jcqr5_SDTlQAo96zZc8Z5urats12cx5_FlaKsWvHnmpwZxcjY2'
                    });
                }
                
            
        </script>
        <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release&callback=loadMapScenario' async defer></script>


</asp:Content>
