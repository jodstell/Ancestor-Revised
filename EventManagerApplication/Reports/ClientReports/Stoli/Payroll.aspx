<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Payroll.aspx.vb" Inherits="EventManagerApplication.StoliPayroll" %>




<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>





<%@ Register Src="~/Reports/UserControls/SideMenuControl.ascx" TagPrefix="uc1" TagName="SideMenuControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>

    <link href="http://kendo.cdn.telerik.com/2015.3.930/styles/kendo.common.min.css" rel="stylesheet" />
    <link href="http://kendo.cdn.telerik.com/2015.3.930/styles/kendo.bootstrap.min.css" rel="stylesheet" />

    <!--kendo.web.min.js or kendo.all.min.js can be used as well instead of the following custom Kendo UI-->
    <script src="/ReportViewer/js/kendo.subset.2015.3.930.min.js"></script>

    <script src="/ReportViewer/js/telerikReportViewer-10.2.16.914.min.js"></script>

  <style>
        #reportViewer1 {
            /*position: absolute;
            left: 5px;
            right: 5px;
            top: 5px;
            bottom: 5px;
            overflow: hidden;
            font-family: Verdana, Arial;*/
        }
    </style>


      <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard - Reports</h2>
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

<%--               <telerik:ReportViewer
            ID="reportViewer1"
            runat="server">
            <ReportSource 
                IdentifierType="TypeReportSource" 
                Identifier="Dashboard, ReportLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
            </ReportSource>
        </telerik:ReportViewer>--%>

             <telerik:ReportViewer
            ID="reportViewer1"
            ServiceUrl="/api/reports/"
            Deferred="true"
                    width="100%"
            runat="server">
          <ReportSource Identifier="ClientReports/Stoli/PayrollReport.trdp" IdentifierType="UriReportSource">
                </ReportSource>
        </telerik:ReportViewer>

                <telerik:DeferredScripts runat="server"></telerik:DeferredScripts>


       

        </div>
     </div>
    </div>

</asp:Content>
