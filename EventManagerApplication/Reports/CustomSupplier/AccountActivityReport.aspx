<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AccountActivityReport.aspx.vb" Inherits="EventManagerApplication.AccountActivityReport" %>

<%@ Register Src="~/Reports/UserControls/SideMenuControl.ascx" TagPrefix="uc1" TagName="SideMenuControl" %>

<%@ Register Assembly="Telerik.ReportViewer.Html5.WebForms, Version=10.2.16.914, Culture=neutral, PublicKeyToken=a9d7983dfcc261be" Namespace="Telerik.ReportViewer.Html5.WebForms" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <style>
        .table {
            margin-bottom: 0px;
        }
    </style>

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

                

                 <h3>Account Activity Reports</h3>
                <span style="font-size:20px"><asp:Label ID="selectedDateLabel" runat="server"></asp:Label></span>

                  <p style="font-size: 12px;">
                    <asp:Label ID="DateRangeLabel" runat="server" Font-Bold="true" /></p>

                <div class="widget-content-sidebar sidemenu" style="padding: 15px 5px 15px;">

                 <telerik:RadComboBox RenderMode="Lightweight" ID="SelectedActivity" runat="server" 
                                        Label="Activity:" EmptyMessage="Select Activity"
                                        Height="200px" Width="275px" DataSourceID="getActivityTypeList" DataValueField="activityTypeID" DataTextField="activityName">
                                    </telerik:RadComboBox>

                   <asp:LinqDataSource ID="getActivityTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="activityName" TableName="qryViewActivityTypeByClients" Where="clientID == @clientID">
        <WhereParameters>
           <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
        </WhereParameters>
    </asp:LinqDataSource>



                <strong> From:</strong>

                <telerik:RadDatePicker ID="FromDatePicker" runat="server" Culture="en-US" SelectedDate="2016-03-01">
                    <DateInput runat="server" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy"  LabelWidth="40%">
                    </DateInput>
                     <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>
                </telerik:RadDatePicker>

                <strong> To:</strong>
                <telerik:RadDatePicker ID="ToDatePicker" runat="server" Culture="en-US" SelectedDate="2016-03-31">
                    <DateInput runat="server" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%">
                    </DateInput>
                     <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>
                </telerik:RadDatePicker>

                <asp:Button ID="btnChangeDateRange" runat="server" Text="Go" CssClass="btn btn-default" />

                <%--<a id='filterbutton' class="filterbutton" href="#">Advanced Filter</a>--%>


                <div class="btn-group pull-right" role="group" aria-label="...">
                    <%--<asp:Button ID="btnViewWeek" runat="server" Text="Week" CssClass="btn btn-success" />
                    <asp:Button ID="btnViewMonth" runat="server" Text="Month" CssClass="btn btn-default" />--%>
                </div>
            </div>

                <asp:Panel ID="MainPanel" runat="server">

                    <div runat="server" id="DefaultMessage" class="alert alert-info" role="alert">Select a report and date range above.</div>

                    <asp:Label ID="NoResultLabel" runat="server" />

                </asp:Panel>
 

             <%--   <div class="row">
            <div class="col-xs-12">
                <h3>Activity Results: Account Tasting</h3>
                Number of Responses: 20
                <hr />
            </div>
        </div>--%>
        <!-- end row -->

                <%--<div class="row">

                <div class="col-md-8 table-responsive">

                                    <div class="widget stacked">
                            <div class="widget-content">



                                <telerik:RadGrid ID="RadGrid1" runat="server" Visible="false"></telerik:RadGrid>



                    <asp:PlaceHolder ID="InsertPlaceHolder" runat="server"></asp:PlaceHolder>

                                </div>
                                        </div>
               </div>

                    <div class="col-md-4">

                        <div class="pull-right">
                            <asp:Button ID="btnViewDetails" runat="server" Text="View Detail Report" CssClass="btn btn-primary" />
                        </div>

                        </div>

                    </div>--%>



                <div class="row">
                    <div class="col-md-12">

                   
</div>
                  
                </div>



               



        </div>
     </div>
    </div>

</asp:Content>