<%@ Page Title="Payments" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="PaymentsNew.aspx.vb" Inherits="EventManagerApplication.PaymentsNew" %>

<%@ Register Src="~/Ambassadors/UserControls/PaidControl.ascx" TagPrefix="uc1" TagName="PaidControl" %>
<%@ Register Src="~/Ambassadors/UserControls/ScheduledControl.ascx" TagPrefix="uc1" TagName="ScheduledControl" %>
<%@ Register Src="~/Ambassadors/UserControls/ProcessingControl.ascx" TagPrefix="uc1" TagName="ProcessingControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-sm-12">

                <h3 style="color: black; font-weight: bold;">Payments</h3>

                <div class="bs-example">
                    <ul id="paymentsTab" class="nav nav-tabs" style="margin-bottom: 0px !important;">
                        <li class="active"><a href="#scheduled" data-toggle="tab">Scheduled</a></li>
                        <li class=""><a href="#processing" data-toggle="tab">Processing</a></li>
                        <li class=""><a href="#paid" data-toggle="tab">Approved for Payment</a></li>
                    </ul>
                </div>

                <div class="tab-content">
                    <div class="tab-pane fade active in" id="scheduled">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    <uc1:ScheduledControl runat="server" ID="ScheduledControl" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="processing">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    <uc1:ProcessingControl runat="server" ID="ProcessingControl" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="paid">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    <uc1:PaidControl runat="server" ID="PaidControl" />
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                </div>

            </div>
        </div>
    </div>

</asp:Content>
