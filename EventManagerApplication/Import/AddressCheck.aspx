<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AddressCheck.aspx.vb" Inherits="EventManagerApplication.AddressCheck" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">

        <div class="col-md-12">

            <h3>Address Checker</h3>

            Address: <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox> <asp:Button ID="Button1" runat="server" Text="Button" CssClass="btn btn-primary" />

            
        </div>

        <div class="col-md-12">
            Latitude:  <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label><br />
            Longtitude:  <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label><br />
            Address:  <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
        </div>
    </div>
</asp:Content>
