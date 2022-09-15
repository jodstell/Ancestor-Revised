<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Master.Master" CodeBehind="Course.aspx.vb" Inherits="EventManagerApplication.CourseTraining" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container min-height">

        

            <asp:Panel ID="MainPanel" runat="server">
            <div class="row ">
            <div class="col-sm-12">

                <asp:Label ID="msgLabel" runat="server" />

                <div style="margin: 25px 0 15px 0">
                    <h2>Welcome to your personalized Brand Training</h2>
                    <p>Complete each sections below and click on the Next button to continue to the next tab.<br /> Fields marked with asterisk (<span class="text-danger">*</span>) are required.</p>
                </div>
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>

                <div class="widget stacked">
                    <div class="widget-content">
                        <asp:Label ID="EventIDLabel" runat="server" />

                        <asp:PlaceHolder ID="CoursesPlaceHolder" runat="server"></asp:PlaceHolder>

                        </div>

                    </div>

                </div>
                </div>
            </asp:Panel>


            <asp:Panel ID="NotValidPanel" runat="server" Visible="false">

                <div class="row">

				<div class="col-md-12" style="margin-top:60px">

				    <div style="margin: 10px 0 10px 0">
                        <h2 style="margin-bottom: 80px;">Welcome to your personalized Brand Training</h2>

                        <div class="widget stacked">
                         <div class="widget-content" style="padding:30px;">
                            
                             <div class="alert alert-warning" style="padding: 30px;font-size: 15px;">
                              <strong>Warning!</strong> Your access token has expired or is not valid.
                            </div>

                         </div>
                        </div>
                        
                    </div>

                </div>

                </div>
            </asp:Panel>


    </div>
        

</asp:Content>
