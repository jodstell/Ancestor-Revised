<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Ambassador_Dashboard.aspx.vb" Inherits="EventManagerApplication.Ambassador_Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Theme/css/custom.css" rel="stylesheet" />
    <link href="Theme/css/custom1.css" rel="stylesheet" />

    <div class="container min-height">

        <div class="row">
            <div id="messageHolder">
                <asp:Literal ID="msgLabel2" runat="server" />
            </div>
        </div>


        <div class="row">
            <div class="col-xs-12">
                <h2>Brand Ambassador Details</h2>
            </div>

            </div>


            <div class="row">
            <div class="col-xs-12">
                <div class="widget stacked">
                            <div class="widget-content">


                                This is where our stuff goes


                                </div>
                    </div>
            </div>

            </div>


          <div class="row">
            <div class="col-xs-12">
                <div class="widget stacked">
                            <div class="widget-content">


                                This is where our stuff goes


                                </div>
                    </div>
            </div>

            </div>


          <div class="row">
            <div class="col-xs-12">
                <div class="widget stacked">
                            <div class="widget-content">


                                Events


                                <telerik:RadTabStrip ID="RadTabStrip1" runat="server" AutoPostBack="true" MultiPageID="RadMultiPage1">
                                    <Tabs>
                                        <telerik:RadTab Text="Available"></telerik:RadTab>
                                        <telerik:RadTab Text="Needs Recap"></telerik:RadTab>
                                    </Tabs>
                                </telerik:RadTabStrip>

                                <telerik:RadMultiPage ID="RadMultiPage1" runat="server">
                                    <telerik:RadPageView ID="AvailableTab" runat="server">
                                         <div class="widget stacked">
                            <div class="widget-content">
                                        
                                        
                                        Available
                                </div>
                                             </div>
                                </telerik:RadPageView>
                                    <telerik:RadPageView ID="NeedsRecapTab" runat="server">
                                         <div class="widget stacked">
                            <div class="widget-content">
                                        
                                        
                                        Needs Recap
                                </div>
                                             </div>
                                    </telerik:RadPageView>
                                </telerik:RadMultiPage>



                                </div>
                    </div>
            </div>

            </div>




        </div>

</asp:Content>
