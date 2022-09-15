<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CityWeatherControl.ascx.vb" Inherits="EventManagerApplication.CityWeatherControl" %>

  <!-- Today -->
    <div class="row weatherwrapper">
        <div class="col-xs-2 datebox">
            <asp:Label ID="lblDay0" runat="server" />
            <div class="monthlabel">
                <asp:Label ID="lblMonth0" runat="server" /></div>

        </div>
        <div class="col-xs-4 col2">
            <div class="daylabel">Today</div>
            <div class="templabel">Low: <asp:Label ID="lblTempMin0" runat="server" /></div>
            <div class="templabel">High: <asp:Label ID="lblTempMax0" runat="server" /></div>

        </div>
        <div class="col-xs-4 col3"><asp:Image ID="imgWeatherIcon0" runat="server" Width="60px"  />
            <div>
                <asp:Label ID="lblMain0" runat="server" />
            </div>
        </div>
    </div>

    <!-- Tomorrow -->
        <div class="row weatherwrapper">
        <div class="col-xs-2 datebox">
            <asp:Label ID="lblDay1" runat="server" />
            <div class="monthlabel">
                <asp:Label ID="lblMonth1" runat="server" /></div>
        </div>
        <div class="col-xs-4 col2">
            <div class="daylabel">Tomorrow</div>
            <div class="templabel">Low: <asp:Label ID="lblTempMin1" runat="server" /></div>
            <div class="templabel">High: <asp:Label ID="lblTempMax1" runat="server" /></div>

        </div>
        <div class="col-xs-4 col2"><asp:Image ID="imgWeatherIcon1" runat="server" Width="60px"  />
            <div>
                <asp:Label ID="lblMain1" runat="server" />
            </div>
        </div>
    </div>


    <!-- Next Day -->
        <div class="row weatherwrapper">
        <div class="col-xs-2 datebox">
            <asp:Label ID="lblDay2" runat="server" />
            <div class="monthlabel">
                <asp:Label ID="lblMonth2" runat="server" /></div>
             </div>
        <div class="col-xs-4 col2"><div class="daylabel">
            <asp:Label ID="lblDayName2" runat="server" /></div>
            <div class="templabel">Low: <asp:Label ID="lblTempMin2" runat="server" /></div>
            <div class="templabel">High: <asp:Label ID="lblTempMax2" runat="server" /></div>
        </div>
        <div class="col-xs-4 col3"><asp:Image ID="imgWeatherIcon2" runat="server" Width="60px"  />
            <div>
                <asp:Label ID="lblMain2" runat="server" />
            </div>
        </div>
    </div>


    <style>
        .weatherwrapper {
            border: 1px solid #fff;
            background: #333;
            padding: 10px;
            margin:0px;
            /*height: 112px;*/
        }

        .monthlabel {font-size: 16px; margin-top:5px; font-weight:300;}

         .datebox {
            font-size:36px;
            text-align: center;
            background: white;
            border: 1px solid #808080;
            padding: 8px;
            width: 70px;
            height: 70px;
            float:left;
	overflow:hidden;
        }

         .daylabel {
             font-size: 22px;
             text-align: right;
             margin-bottom:8px;
         }

         .templabel {

             font-size: 14px;
             text-align:right;
         }

 .col2 {
    color: white;
	/*float:left;
	position:relative;
	left:80px;
    width: 150px;
	overflow:hidden;*/
}

.col3 {
 color: white;
	float:left;
	/*position:relative;
	left:120px;
	overflow:hidden;*/
    font-size: 22px;
    margin-top: -10px;
 }


    </style>
