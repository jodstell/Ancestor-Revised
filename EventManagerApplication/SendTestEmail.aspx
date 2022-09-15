<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="SendTestEmail.aspx.vb" Inherits="EventManagerApplication.SendTestEmail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
            <div class="col-md-12">

                <h3>Send Test Email</h3>

                <p>
                   <asp:Button ID="BtnSend" runat="server" Text="Send" />
                </p>

                <p>
                    <asp:Label ID="ResultLabel" runat="server" Text=""></asp:Label>
                </p>

                </div>

        </div>
</asp:Content>
