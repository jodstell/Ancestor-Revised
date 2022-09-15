<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Events.aspx.vb"
    Inherits="EventManagerApplication.Events1" %>
<%@ Register Src="~/Reports/UserControls/SideMenuControl.ascx" TagPrefix="uc1" TagName="SideMenuControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .multiColumn ul
{
    width:100%;
}
.multiColumn li
{
    float:left;
    width:25%;
}
    </style>

    <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard - Report Builder</h2>
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

                <asp:LinkButton ID="btnAddNewReport" runat="server" CssClass="btn btn-success" PostBackUrl="NewEventReport.aspx">Add New Report</asp:LinkButton>
                <hr />

                <div>

                    <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="getReportsList"
                        AllowPaging="True"
                        AllowSorting="True"
                        ShowFooter="True"
                        ShowStatusBar="true"
                        AllowFilteringByColumn="True"
                        PageSize="20"
                        FilterType="HeaderContext"
                        EnableHeaderContextMenu="true"
                        EnableHeaderContextFilterMenu="true">
                        <MasterTableView DataSourceID="getReportsList" AutoGenerateColumns="False">
                            <Columns>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <a href='/Reports/ReportBuilder/ViewEventReport?ReportID=<%#Eval("reportID") %>' class="btn btn-primary btn-sm" style="color: white">View Report &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridBoundColumn DataField="reportTitle" HeaderText="Report Title" SortExpression="reportTitle" UniqueName="reportTitle" FilterControlAltText="Filter reportName column"></telerik:GridBoundColumn>

                                <telerik:GridCheckBoxColumn DataField="active" HeaderText="active" SortExpression="active" UniqueName="active" DataType="System.Boolean" FilterControlAltText="Filter active column"></telerik:GridCheckBoxColumn>

                                <telerik:GridBoundColumn DataField="modifiedBy" HeaderText="modifiedBy" SortExpression="modifiedBy" UniqueName="modifiedBy" FilterControlAltText="Filter modifiedBy column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="modifiedDate" HeaderText="modifiedDate" SortExpression="modifiedDate" UniqueName="modifiedDate" DataType="System.DateTime" FilterControlAltText="Filter modifiedDate column"></telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getReportsList" ContextTypeName="EventManagerApplication.ReportDataClassesDataContext" OrderBy="reportTitle" TableName="getEventReportLists" Where="clientID == @clientID">

                        <WhereParameters>
                            <asp:SessionParameter SessionField="CurrentClientID" Name="clientID" Type="Int32"></asp:SessionParameter>
                        </WhereParameters>
                    </asp:LinqDataSource>
                </div>
            </div>

     </div>
    </div>

</asp:Content>
