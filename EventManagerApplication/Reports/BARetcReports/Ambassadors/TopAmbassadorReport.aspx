<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="TopAmbassadorReport.aspx.vb" Inherits="EventManagerApplication.TopAmbassadorReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">

        <h3>Top Ambassadors</h3>

        <telerik:RadGrid ID="RadGrid1" runat="server"></telerik:RadGrid>

    </div>
</asp:Content>
