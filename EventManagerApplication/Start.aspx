<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Start.aspx.vb" Inherits="EventManagerApplication.Start" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

         <style>
        .main {
            padding: 15px;
        }
    </style>
 
      <script type="text/javascript">
             window.history.forward(); function noBack() { window.history.forward(); }
      </script>


    <link href="Theme/css/pages/plans.css" rel="stylesheet" />
    <link href="Theme/css/pages/pricing.css" rel="stylesheet" />
    <div class="container main">

    <h1><%: GetTestName()%></h1> 

    <div class="row">
        <div class="col-md-9">
            <div class="widget stacked">
                <div class="widget-header">
                    <i class="icon-th-large"></i>
                    <h3>Ready to start the test...</h3>
                </div>
                <!-- /widget-header -->

                <div class="widget-content main" style="padding:50px">
                    <asp:Label ID="AgreementText" runat="server" />
                </div>
            </div>

    <div class="widget stacked">
        <div class="widget-content center" style="padding:50px">
            <h4>You may continue to the test</h4>
            <p>
                <b>Please take your time and answer each question carefully.</b>
            </p>

            <p style="color: #ff0000">
                <b>Do not leave computer unattended while taking the test.</b>
            </p>

            <div class="error-container">
                <asp:Button ID="StartButton" runat="server" Text="Continue > " CssClass="btn btn-primary btn-lg" />
                <asp:Button ID="CancelButton" runat="server" Text="Exit/Quit" CssClass="btn btn-default btn-lg" PostBackUrl="~/dashboard.aspx" />
            </div>
        </div>
    </div>

        </div>

        <div class="col-md-3 hidden-xs">
            <div class="pricing-plans plans-1">
                <div class="plan-container">
                    <div class="plan stacked blue">
                        <div class="plan-header">
                            <div class="plan-title">
                                Total Questions	        		
                            </div>
                            <!-- /plan-title -->

                            <div class="plan-price">
                                <span class="note"></span><%: GetTotalQuestions() %><span class="term">Questions</span>
                            </div>
                            <!-- /plan-price -->
                        </div>
                        <!-- /plan-header -->
                    </div>
                    <!-- /plan -->
                </div>
                <!-- /plan-container -->

                <div class="clear">&nbsp;</div>

                <div class="plan-container">
                    <div class="plan stacked">
                        <div class="plan-header">
                            <div class="plan-title">
                                Time Limit	        		
                            </div>
                            <!-- /plan-title -->

                            <div class="plan-price">
                                <span class="note"></span><%: GetTimeLimit()%><span class="term">Minutes</span>
                            </div>
                            <!-- /plan-price -->
                        </div>
                        <!-- /plan-header -->
                    </div>
                    <!-- /plan -->
                </div>
                <!-- /plan-container -->

                <div class="clear">&nbsp;</div>

                <div class="plan-container">
                    <div class="plan stacked orange">
                        <div class="plan-header">

                            <div class="plan-title">
                                Passing Grade	        		
                            </div>
                            <!-- /plan-title -->

                            <div class="plan-price">
                                <span class="note"></span><%: GetPassingGrade() %><span class="term">Percent</span>
                            </div>
                            <!-- /plan-price -->

                        </div>
                        <!-- /plan-header -->
                    </div>
                    <!-- /plan -->
                </div>
                <!-- /plan-container -->
                <div class="clear">&nbsp;</div>

            </div>
        </div>
    </div>


        </div>
</asp:Content>
