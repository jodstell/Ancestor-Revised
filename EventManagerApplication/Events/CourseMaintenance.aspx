<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="CourseMaintenance.aspx.vb" Inherits="EventManagerApplication.CourseMaintenance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">


        <asp:TextBox ID="BrandIDTextBox" runat="server"></asp:TextBox>

        <asp:Button ID="BtnSubmit" runat="server" Text="Button" />




        <telerik:RadGrid ID="RadGrid1" runat="server"></telerik:RadGrid>
    </div>

</asp:Content>
