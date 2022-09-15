<%@ Page Title="Edit Recap" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditRecap.aspx.vb" Inherits="EventManagerApplication.EditRecap"   %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-control-padding {
            margin-top: -15px;
            display: inline-block;
        }

        .RadComboBox {
    text-align: left;
    display: block;
    vertical-align: middle;
    white-space: nowrap;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container minheight">

        <div class="row">
            <div class="col-md-12">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>
        </div>



        <div class="row">
            <div class="col-xs-12 marginbotton10">
                <h2>Event Recap</h2>
                <div class="detail">
                    Event Name:
                    <asp:Label ID="EventNameLabel" runat="server" Font-Bold="true" /><br />
                    Date:
                    <asp:Label ID="EventDateLabel" runat="server" Font-Bold="true" /><br />
                    Event ID:
                    <asp:Label ID="EventIDLabel" runat="server" Font-Bold="true" /><br />
                </div>

            </div>
        </div>

        <div class="row">
            <div class="widget stacked">
                <div class="widget-content">

                    <div class="col-md-8">

                        <asp:PlaceHolder ID="InsertPlaceHolder" runat="server"></asp:PlaceHolder>

                        <br />

                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary"  />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default" />


                    </div>

                </div>
            </div>
        </div>

    </div>

</asp:Content>
