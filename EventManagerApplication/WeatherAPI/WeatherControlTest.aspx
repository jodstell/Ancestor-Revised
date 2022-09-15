<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="WeatherControlTest.aspx.vb" Inherits="EventManagerApplication.WeatherControlTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        table
        {
            border: 1px solid #ccc;
            border-collapse: collapse;
        }
        table th
        {
            background-color: #F7F7F7;
            color: #333;
            font-weight: bold;
        }
        table th, table td
        {
            padding: 5px;
            border: 1px solid #ccc;
        }
        table, table table td
        {
            border: 0px solid #ccc;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <asp:TextBox ID="txtCity" runat="server" Text="" />
    <asp:Button ID="btnGetWeather" Text="Get Weather Information" runat="server" />

    <!-- Today -->
    <div class="weatherwrapper">
        <div class="datebox">
            <asp:Label ID="lblDay0" runat="server" />
            <div class="monthlabel">
                <asp:Label ID="lblMonth0" runat="server" /></div></div>
        <div class="col2"><div class="daylabel">Today</div>
            <div class="templabel">Low: <asp:Label ID="lblTempMin0" runat="server" /></div>
            <div class="templabel">High: <asp:Label ID="lblTempMax0" runat="server" /></div></div>
        <div class="col3"><asp:Image ID="imgWeatherIcon0" runat="server" Width="60px"  />
            <div>
                <asp:Label ID="lblMain0" runat="server" />
            </div>
        </div>
    </div>

    <!-- Tomorrow -->
         <div class="weatherwrapper">
        <div class="datebox">
            <asp:Label ID="lblDay1" runat="server" />
            <div class="monthlabel">
                <asp:Label ID="lblMonth1" runat="server" /></div></div>
        <div class="col2"><div class="daylabel">Tomorrow</div>
            <div class="templabel">Low: <asp:Label ID="lblTempMin1" runat="server" /></div>
            <div class="templabel">High: <asp:Label ID="lblTempMax1" runat="server" /></div></div>
        <div class="col3"><asp:Image ID="imgWeatherIcon1" runat="server" Width="60px"  />
            <div>
                <asp:Label ID="lblMain1" runat="server" />
            </div>
        </div>
    </div>


    <!-- Next Day -->
        <div class="weatherwrapper">
        <div class="datebox">
            <asp:Label ID="lblDay2" runat="server" />
            <div class="monthlabel">
                <asp:Label ID="lblMonth2" runat="server" /></div></div>
        <div class="col2"><div class="daylabel">
            <asp:Label ID="lblDayName2" runat="server" /></div>
            <div class="templabel">Low: <asp:Label ID="lblTempMin2" runat="server" /></div>
            <div class="templabel">High: <asp:Label ID="lblTempMax2" runat="server" /></div></div>
        <div class="col3"><asp:Image ID="imgWeatherIcon2" runat="server" Width="60px"  />
            <div>
                <asp:Label ID="lblMain2" runat="server" />
            </div>
        </div>
    </div>


    <style>
        .weatherwrapper {
            border: 1px solid #808080;
            background: #333;
            padding: 15px;
            margin:0px;
            height: 112px;
        }

        .monthlabel {font-size: 16px; margin-top:14px; font-weight:300;}

         .datebox {
            font-size:48px;
            text-align: center;
            background: white;
            border: 1px solid #808080;
            padding: 14px;
            width: 80px;
            height: 80px;
            float:left;
	overflow:hidden;
        }

         .daylabel {
             font-size: 28px;
             text-align: right;
             margin-bottom:10px;
         }

         .templabel {

             font-size: 16px;
             text-align:right;
         }

 .col2 {
    color: white;
	float:left;
	position:relative;
	left:80px;
    width: 150px;
	overflow:hidden;
}

.col3 {
 color: white;
	float:left;
	position:relative;
	left:120px;
	overflow:hidden;
    font-size: 24px;
    margin-top: -10px;
 }


    </style>



</asp:Content>
