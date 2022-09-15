<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Master.Master" CodeBehind="EventConfirmation.aspx.vb" Inherits="EventManagerApplication.EventConfirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel runat="server" ID="CongratulationsPanel">

            <div class="container min-height">
                <h2>Request Event</h2>
                <div class="row">
                    <div class="col-sm-12 alert alert-success">
                        <asp:Label runat="server" ID="msgSuccessLabel"><strong style="font-size:20px; padding:30px;">Your request have been sent successfully!</strong></asp:Label>
                        
                     </div>
                 </div>
            </div>

        </asp:Panel>

</asp:Content>
