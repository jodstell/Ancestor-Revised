<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ConvertAddress.aspx.vb" Inherits="EventManagerApplication.ConvertAddress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   
    <div style="margin:15px 15px 0 15px;">
     <div id="content">

     <div>
    Account Number 1: <asp:TextBox ID="accountNumberTextBox1" runat="server" CssClass="form-control" /><br />
    Account Number 2: <asp:TextBox ID="accountNumberTextBox2" runat="server" CssClass="form-control" /><br />
        </div>

    <div>
    <asp:Button ID="btnSubmit" runat="server" Text="Button" CssClass="btn btn-default btn-md" />
    </div>

    <div>
        Address 1: <asp:Label ID="addressLabel1" runat="server" /><br />
        Latitude 1: <asp:Label ID="LatitudeLabel1" runat="server" /><br />
        Longitude 1<asp:Label ID="LongitudeLabel1" runat="server" /><br /><br />
        <asp:Label ID="errorLabel1" runat="server" ForeColor="red" /><br /><br />
    </div>

          <div>
        Address 1: <asp:Label ID="addressLabel2" runat="server" /><br />
        Latitude 1: <asp:Label ID="LatitudeLabel2" runat="server" /><br />
        Longitude 1<asp:Label ID="LongitudeLabel2" runat="server" /><br /><br />
        <asp:Label ID="errorLabel2" runat="server" ForeColor="red" /><br /><br />
    </div>

         <div>
             <asp:Button ID="btnBatchConvert" runat="server" Text="Convert All Accounts" />
         </div>

         <div>
             <asp:Label ID="resultLabel" runat="server" ForeColor="Green" Font-Bold="true" />
         </div>

         </div>

        </div>

</asp:Content>
