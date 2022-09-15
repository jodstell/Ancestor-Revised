<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin.Master" CodeBehind="Default.aspx.vb" Inherits="EventManagerApplication._Default7" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="MainPanel" runat="server">

        <div class="container">

            <div class="row">
                <div class="col-md-12">

                    <div style="margin: 0 0 15px 0">
                        <h2>Users 
                        </h2>
                        <%--<p>
                            Use this form to add a new client.  Complete each section below and click on the Next button to continue to the next tab.<br />
                            Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                        </p>--%>



                    </div>

                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">
                    </telerik:RadAjaxPanel>

                    <asp:Label ID="msgLabel" runat="server"></asp:Label>

                    <div class="widget stacked">
                        <div class="widget-content min-height">
                        </div>
                    </div>

                </div>

            </div>

        </div>


    </asp:Panel>
</asp:Content>
