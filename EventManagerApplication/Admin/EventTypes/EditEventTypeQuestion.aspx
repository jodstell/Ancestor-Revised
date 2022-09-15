<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditEventTypeQuestion.aspx.vb" Inherits="EventManagerApplication.EditEventTypeQuestion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div class="container">

        <div class="row">

            <div class="row">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>

            <div style="margin: 0 0 15px 0">
                    <h2>Client Details: 
                        <asp:Label ID="ClientNameLabel" runat="server" Font-Bold="true" />
                    </h2>
                    <h3>Event Type: 
                        <asp:Label ID="EventTypeNameLabel" Font-Bold="true" runat="server" /></h3>
                </div>

            <h2>Edit Recap Question</h2>


            <asp:Button ID="btnSave" runat="server" Text="Save Changes" /><asp:Button ID="btnCancel" runat="server" Text="Cancel" />

            </div>

         </div>


</asp:Content>
