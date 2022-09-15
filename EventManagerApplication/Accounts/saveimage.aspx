<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="saveimage.aspx.vb" Inherits="EventManagerApplication.saveimage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="content min-height">

         <asp:TextBox ID="txtUrl" runat="server" Text="" />
    <asp:Button ID="Button1" Text="Capture" runat="server" OnClick="Capture" />
    <br />
    <asp:Image ID="imgScreenShot" runat="server" Height="500" Width="700"  />



        <br />
        <asp:Label ID="Label1" runat="server" />

    </div>

</asp:Content>
