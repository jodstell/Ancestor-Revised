<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="SiteDetails.aspx.vb" Inherits="EventManagerApplication.SiteDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h2>Administration</h2>
                <br />

            </div>
        </div>

        <div class="row">
            <div class="col-sm-3 col-lg-2">

                  <a href='/admin' class='btn btn-default btn-sm btn-block'>Back To Admin Overview</a>
                <p></p>

                <div class='panel panel-default'>
                    <div class='panel-heading panel-sm'><strong>Client Details</strong></div>
                    <div class='panel-body panel-sm'>
                        <a href='#' class='active' data-toggle='tab' data-target='#details'>View Details</a><br>
                    </div>
                </div>

                <div class='panel panel-default'>
                    <div class='panel-heading panel-sm'><strong>Configuration</strong></div>
                    <div class='panel-body panel-sm'>
                        <a href='#' data-toggle='tab' data-target='#clientconfig'>Client Config</a><br>
                        <a href='#' data-toggle='tab' data-target='#eventconfig'>Event Config</a><br>
                        <a href='#' data-toggle='tab' data-target='#tools'>Tools</a><br>
                    </div>
                </div>

                <div class='panel panel-default'>
                    <div class='panel-heading panel-sm'><strong>Events</strong></div>
                    <div class='panel-body panel-sm'>
                        <a href='/Admin/EventTypes/ViewEventTypes'>Event Types <span class='label label-primary pull-right'>35</span></a><br>
                        <a href='/admin/viewsuppliers'>Suppliers <span class='label label-primary pull-right'>95</span></a><br>
                        <a href='/admin/viewbrands'>Brands <span class='label label-primary pull-right'>424</span></a><br>
                        <a href='#' data-toggle='tab' data-target='#teams'>Teams <span class='label label-primary pull-right'>5</span></a><br>
                        <a href='#' data-toggle='tab' data-target='#contacttypes'>Contact Types <span class='label label-primary pull-right'>1</span></a><br>
                        <a href='#' data-toggle='tab' data-target='#tasktypes'>Task Types <span class='label label-primary pull-right'>1</span></a><br>
                        <a href='#'>Event Sections</a><br />
                        <a href='#'>Custom Fields</a><br />
                    </div>
                </div>

                <div class='panel panel-default'>
                    <div class='panel-heading panel-sm'><strong>Accounts</strong></div>
                    <div class='panel-body panel-sm'>
                        <a href='#' data-toggle='tab' data-target='#markets'>Markets <span class='label label-primary pull-right'>65</span></a><br>
                        <a href='#' data-toggle='tab' data-target='#venuetypes'>Account Types <span class='label label-primary pull-right'>40</span></a><br>
                        <a href='#'>Account Activities</a><br />
                    </div>
                </div>

            </div>

            <div class="col-sm-9 col-lg-10">






                <h2>Site Configuration</h2>
                <hr />
            </div>
        </div>
    </div>

</asp:Content>
