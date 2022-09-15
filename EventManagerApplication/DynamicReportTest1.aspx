<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="DynamicReportTest1.aspx.vb" Inherits="EventManagerApplication.DynamicReportTest1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .table {
            margin-bottom: 0px;
        }
    </style>

    <div class="container" style="min-height: 400px;">

    <div class="row">
            <div class="col-xs-12">
                <h3>Activity Results: Account Tasting</h3>
                <p>September 8, 2016 to September 8, 2016<br />
                Number of Responses: 20</p>
                <hr />
            </div>
        </div>
        <!-- end row -->
        <div class="row">

            <div class="col-md-6 table-responsive">

                <asp:PlaceHolder ID="InsertPlaceHolder" runat="server"></asp:PlaceHolder>
              

            </div>

        </div>

    </div>
</asp:Content>
