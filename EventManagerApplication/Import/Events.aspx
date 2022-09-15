<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Events.aspx.vb" Inherits="EventManagerApplication.ImportEvents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div id="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12">

                    <h1>Import Events</h1>

                    <asp:Button ID="btnImport" runat="server" Text="Begin Import" /> 

                    <div>
                        <asp:Label ID="msgLabel" runat="server" />

                    </div>



                </div>
            </div>
        </div>
    </div>

</asp:Content>
