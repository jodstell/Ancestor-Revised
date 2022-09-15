<%@ Page Title="Administration" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Default.aspx.vb" Inherits="EventManagerApplication._Default5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
.panel-sm
{
    padding:5px;
}
</style>


    <div class="container">

        <div class="row">
            <div class="col-xs-12">
                <h2>Administration</h2>
                <br />

            </div>
        </div>


         <div class="col-md-12">

            <div class="feature col-md-15 col-sm-3 center">
                <a href="/account/course">
                    <div class="well greenbox medbox">
                        <div class="icon"><i class="fa fa-table fa-3x"></i></div>
                        <h4 class="noline">Clients</h4>
                    </div>
                </a>
            </div>

             <div class="feature col-md-15 col-sm-3 center">
                <a href="/account/tests/testlistings">
                    <div class="well darkbluebox medbox">
                        <div class="icon"><i class="fa fa-check-square-o fa-3x"></i></div>
                        <h4 class="noline">Users</h4>
                    </div>
                </a>
            </div>

            <div class="feature col-md-15 col-sm-3 center">
                <a href="/account/students/">
                    <div class="well orangebox medbox">
                        <div class="icon"><i class="fa fa-users fa-3x"></i></div>
                        <h4 class="noline">Regions</h4>
                    </div>
                </a>
            </div>

            <div class="feature col-md-15 col-sm-3 center">
                <a href="/account/reports">
                    <div class="well redbox medbox">
                        <div class="icon"><i class="fa fa-bar-chart-o fa-3x"></i></div>
                        <h4 class="noline">Events</h4>
                    </div>
                </a>
            </div>

            <div class="feature col-md-15 col-sm-3 center">
                <a href="/account/settings" class="noline">
                    <div class="well bluebox medbox">
                        <div class="icon"><i class="fa fa-cogs fa-3x"></i></div>
                        <h4>Accounts</h4>
                    </div>
                </a>
            </div>
            <div class="clear"></div>
            <br />
        </div>

      
            </div>

</asp:Content>
