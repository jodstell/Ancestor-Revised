<%@ Page Title="View Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewEventReport.aspx.vb" Inherits="EventManagerApplication.ViewEventReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">



    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="MainPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<asp:Panel ID="MainPanel" runat="server">
    <div class="container">

        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard - Report Builder</h2>
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12">
                <a href="EditEventReport?ReportID=<%= Request.QueryString("ReportID") %>" class="btn btn-primary">Edit Report</a>
                <asp:LoginView ID="LoginView1" runat="server">
                    <RoleGroups>
                        <asp:RoleGroup Roles="Administrator">
                            <ContentTemplate>
                                <a href="/Reports/ReportBuilder/Events" class="btn btn-default">Return to List</a>
                            </ContentTemplate>
                        </asp:RoleGroup>
                    </RoleGroups>
                </asp:LoginView>
                
                <a href="/Reports/Dashboard" class="btn btn-default">Return to Reports</a>
                
            </div>
        </div>

        <hr />

        <div class="row">
            <div class="col-xs-12">

                <div style="margin-bottom:10px;">

                    <h3><asp:Label ID="SelectedReportLabel" runat="server"></asp:Label></h3>

                    <strong> From:</strong>
                    <telerik:RadDatePicker ID="FromDatePicker" runat="server" Culture="en-US">
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
                    <telerik:RadDatePicker ID="ToDatePicker" runat="server" Culture="en-US">
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

                </div>



                <asp:PlaceHolder ID="ResultsGridPlaceHolder" runat="server"></asp:PlaceHolder>

            </div>

        </div>

    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getEventReport" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ReportID" Name="reportID" Type="Int32"></asp:QueryStringParameter>
            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
            <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="selectedToDate" Type="DateTime"></asp:ControlParameter>
            <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="selectedFromDate" Type="DateTime"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Panel>


</asp:Content>
