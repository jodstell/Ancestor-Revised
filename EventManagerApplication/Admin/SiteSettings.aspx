<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="SiteSettings.aspx.vb" Inherits="EventManagerApplication.SiteSettings" %>

<%@ Register Src="~/Admin/UserControls/ExpenseTypeControl.ascx" TagPrefix="uc1" TagName="ExpenseTypeControl" %>
<%@ Register Src="~/Admin/UserControls/ShippingVendorControl.ascx" TagPrefix="uc1" TagName="ShippingVendorControl" %>
<%@ Register Src="~/Admin/UserControls/SiteConfigurationControl.ascx" TagPrefix="uc1" TagName="SiteConfigurationControl" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="css/clients.css" rel="stylesheet" />

    <script type="text/javascript">
        // close the div in 5 secs
        window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version
            $("#messageHolder").fadeOut("slow", null);
        }
    </script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row">
            <div id="messageHolder">
                <asp:Literal ID="msgLabel" runat="server" />
            </div>
        </div>


        <div class="row">
            <div class="col-md-12">

                <div style="margin: 0 0 15px 0">
                    <h2>Site Settings</h2>
                </div>

                <div class="tabbable">

                    <ul id="MainTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                        <li class="active"><a href="#defaulttab" data-toggle="tab">Default Settings</a></li>
                        <li><a href="#configurationtab" data-toggle="tab">Configuration</a></li>

                        <li class="pull-right secondarytab"><a href="/admin/siteadministration"><i class="fa fa-angle-double-left"></i>&nbsp;Site Administration</a></li>

                    </ul>

                    <div class="tab-content tab-container">
                        <!-- Default Configuration Tab -->
                        <div class="tab-pane active" id="defaulttab">
                            <div class="widget stacked">
                                            <div class="widget-content min-height">

                                                <div class="contentbox">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <h2>Default Settings</h2>
                                                <hr />

                                               <uc1:SiteConfigurationControl runat="server" ID="SiteConfigurationControl" />
                                                                </div>
                                                            </div>

                                                    </div>

                                            </div>
                                        </div>

                        </div>

                        <!-- Configuration Tab -->
                        <div class="tab-pane" id="configurationtab">
                            <div class="tabbable tabs-left">

                                <ul id="configTab" class="nav nav-tabs sec" style="margin-bottom: 3px; border-bottom: 0">
                                    <li class="secondarytab active"><a href="#expensetype" data-toggle="tab">Expense Type</a></li>
                                    <li class="secondarytab"><a href="#shippingvendor" data-toggle="tab">Shipping Vendor</a></li>
<%--                                    <li class="secondarytab"><a href="#eventconfig" data-toggle="tab">Event Configuration</a></li>
                                    <li class="secondarytab"><a href="#toolsconfig" data-toggle="tab">Tools</a></li>--%>
                                </ul>

                                <div class="tab-content tab-info">
                                    <!-- Expense Type -->
                                    <div class="tab-pane active" id="expensetype">
                                        <div class="widget stacked">
                                            <div class="widget-content min-height">

                                                <div class="contentbox">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <h2>Expense Type</h2>
                                                <hr />

                                                <uc1:ExpenseTypeControl runat="server" id="ExpenseTypeControl" />
                                                                </div>
                                                            </div>

                                                    </div>

                                            </div>
                                        </div>
                                    </div>

                                    <!-- Shipping Vendor -->
                                     <div class="tab-pane" id="shippingvendor">
                                        <div class="widget stacked">
                                            <div class="widget-content min-height">

                                                <div class="contentbox">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <h2>Shipping Vendor</h2>
                                                <hr />

                                               <uc1:ShippingVendorControl runat="server" id="ShippingVendorControl" />
                                                                </div>
                                                            </div>

                                                    </div>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>



        </div>


    </div>

    <script>

        $(document).ready(function () {

            handleTabLinks();
        });

        function handleTabLinks() {
            if (window.location.hash == '') {
                window.location.hash = window.location.hash + '#_';
            }
            var hash = window.location.hash.split('#')[1];
            var prefix = '_';
            var hpieces = hash.split('/');
            for (var i = 0; i < hpieces.length; i++) {
                var domelid = hpieces[i].replace(prefix, '');
                var domitem = $('a[href=#' + domelid + '][data-toggle=tab]');
                if (domitem.length > 0) {
                    domitem.tab('show');
                }
            }
            $('a[data-toggle=tab]').on('shown', function (e) {
                if ($(this).hasClass('nested')) {
                    var nested = window.location.hash.split('/');
                    window.location.hash = nested[0] + '/' + e.target.hash.split('#')[1];
                } else {
                    window.location.hash = e.target.hash.replace('#', '#' + prefix);
                }
            });
        }


    </script>
</asp:Content>
