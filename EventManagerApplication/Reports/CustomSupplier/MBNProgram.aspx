<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="MBNProgram.aspx.vb" 
    Inherits="EventManagerApplication.MBNProgram" %>
<%@ Register Src="~/Reports/UserControls/SideMenuControl.ascx" TagPrefix="uc1" TagName="SideMenuControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard - Custom Supplier Reports</h2>
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col-md-2">
                <div class="widget stacked">
                    <uc1:SideMenuControl runat="server" id="SideMenuControl" />
                </div>

            </div>

            <div class="col-md-10">


                 <h3>MBN Program</h3>

 

        </div>
     </div>
    </div>

</asp:Content>
