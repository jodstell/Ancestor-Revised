<%@ Page Title="Reports" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Dashboard.aspx.vb" Inherits="EventManagerApplication.Dashboard4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard</h2>
                <ol class="breadcrumb">
                    <li><i class="fa fa-home" aria-hidden="true"></i><a href="/"> Dashboard</a></li>
                    <li class="active">Reports</li>
                </ol>

            </div>
        </div>

        <div class="row">

            <div class="col-md-5 sidemenu">

                <div class="feature col-sm-6 col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <h3>Dashboards</h3>
                            <ul>
                                <li><a href="/Reports/OffPremiseDashboard.aspx">Retail/Off Premise</a></li>
                                <li><a href="/Reports/OnPremiseDashboard.aspx">Bar/On Premise</a></li>
                            </ul>

                        </div>
                    </div>
                </div>

                <div class="feature col-sm-6 col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <h3>Sales Recap Reports</h3>
                            <ul>
                                <li><a href="/Reports/SalesRecap/OffPremiseReport.aspx">Retail/Off Premise</a></li>
                                <li><a href="/Reports/SalesRecap/OnPremiseReport.aspx">Bar/On Premise</a></li>
                            </ul>
                        </div>
                    </div>
                </div>


                <asp:LoginView ID="LoginView1" runat="server">
                    <RoleGroups>
                        <asp:RoleGroup Roles="Administrator">
                            <ContentTemplate>

                                <div class="feature col-sm-6 col-md-6">
                                    <div class="panel panel-default min-height250">
                                        <div class="panel-body">
                                            <h3>Reports</h3>
                                            <ul>
                                                <%--<li><a href="/Reports/ClientReports/<%: clientFolder() %>/Invoicing.aspx">Invoicing</a></li>--%>
                                                <li><a href="/Reports/BARetcReports/Invoicing.aspx">Invoicing</a></li>
                                                <li><a href="/Reports/BARetcReports/Shipping.aspx">Shipping</a></li>

                                                <li><a href="/Reports/BARetcReports/BrandAmbassadors.aspx">Brand Ambassadors</a></li>
                                                <li><a href='/Reports/BARetcReports/PayrollDashboard'>Payroll</a></li>
                                                <%--<li><a href='/Reports/ClientReports/<%: clientFolder() %>/Payroll.aspx'>Payroll</a></li>--%>
                                                <li><a href="/Reports/BARetcReports/PayCards.aspx">Pay Cards</a></li>
                                                <li><a href="/Reports/CustomSupplier/AccountActivityReport.aspx">Account Activity Reports</a></li>
                                                

                                            </ul>
                                        </div>
                                    </div>
                                </div>

                            </ContentTemplate>
                        </asp:RoleGroup>
                    </RoleGroups>
                </asp:LoginView>

                <asp:LoginView ID="LoginView2" runat="server">
                    <RoleGroups>
                        <asp:RoleGroup Roles="Administrator">
                            <ContentTemplate>

                                <div class="feature col-sm-6 col-md-6">
                                    <div class="panel panel-default min-height250">
                                        <div class="panel-body">
                                            <h3>Report Builder</h3>
                                            <ul>
                                                <li><a href="/Reports/ReportBuilder/AccountsVenues.aspx">Accounts/Venues</a></li>
                                                <li><a href="/Reports/ReportBuilder/Events.aspx">Events</a></li>
                                                <li><a href="/Reports/ReportBuilder/Staff.aspx">Staff</a></li>
                                                <li><a href="/Reports/ReportBuilder/Supplier.aspx">Supplier</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                            </ContentTemplate>
                        </asp:RoleGroup>
                    </RoleGroups>
                </asp:LoginView>
            </div>


            <div class="col-md-7 sidemenu">

                <asp:LoginView ID="LoginView_1" runat="server">
                    <RoleGroups>
                        <asp:RoleGroup Roles="Administrator, EventManager, Accounting, Client, Agency, Recruiter/Booking">
                            <ContentTemplate>

                                <div class="feature col-sm-12 col-md-12">
                                    <div class="panel panel-default min-height250">
                                        <div class="panel-body">
                                            <h3>Custom Supplier Reports</h3>

                                            <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="getSupplierReports" 
                                                AllowPaging="True"
                                                AllowSorting="True"
                                                ShowFooter="True"
                                                ShowStatusBar="true"
                                                AllowFilteringByColumn="True"
                                                PageSize="20" CellSpacing="-1"
                                                FilterType="HeaderContext"
                                                EnableHeaderContextMenu="true"
                                                EnableHeaderContextFilterMenu="true">


                                                <MasterTableView DataKeyNames="reportID" DataSourceID="getSupplierReports" AutoGenerateColumns="False">
                                                    <Columns>


                                                        <telerik:GridTemplateColumn HeaderText="Report" SortExpression="reportTitle" UniqueName="reportTitle" FilterControlAltText="Filter reportTitle column" CurrentFilterFunction="Contains">
                                                            <ItemTemplate>
                                                                <a href="/Reports/ReportBuilder/ViewEventReport?ReportID=<%# Eval("reportID") %>"><%# Eval("reportTitle") %></a>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="modifiedBy" ReadOnly="True" HeaderText="Modified By" SortExpression="modifiedBy" UniqueName="modifiedBy" FilterControlAltText="Filter modifiedBy column"></telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="modifiedDate" ReadOnly="True" HeaderText="Modified Date" SortExpression="modifiedDate" UniqueName="modifiedDate" DataType="System.DateTime" FilterControlAltText="Filter modifiedDate column"></telerik:GridBoundColumn>
                                                    </Columns>
                                                </MasterTableView>
                                            </telerik:RadGrid>


                                            <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="getSupplierReports" 
                                                DataKeyNames="reportID" Visible="false">
                                                 <LayoutTemplate>
                                                <asp:Panel ID="GroupPlaceHolder" runat="server"></asp:Panel>
                                            </LayoutTemplate>

                                            <ItemTemplate>
                                                <ul>
                                                    <li>
                                                    <asp:HyperLink ID="CurriculumLink" runat="server" CssClass="pointer"><%# Eval("reportTitle") %></asp:HyperLink>
                                                   </li>
                                                </ul>

                                            </ItemTemplate>

                                            <DataGroups>
                                                <telerik:ListViewDataGroup GroupField="supplierName" DataGroupPlaceholderID="GroupPlaceHolder">
                                                    <DataGroupTemplate>
                                                        <asp:Panel runat="server" ID="DataGroupPanel" CssClass="dataGroup">
                                                            <strong><%# CType(Container, RadListViewDataGroupItem).DataGroupKey %></strong>
                                                                   <asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder>
                                                            <hr />
                                                            </asp:Panel>
                                                    </DataGroupTemplate>
                                                </telerik:ListViewDataGroup>
                                            </DataGroups>

                                            <EmptyDataTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">

                                                        <tbody>
                                                            <tr>
                                                                <td colspan="7">
                                                                    <div class="alert alert-warning" role="alert">There are no reports.  </div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </EmptyDataTemplate>
                                            </telerik:RadListView>




                                            <asp:SqlDataSource runat="server" ID="getSupplierReports" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getReportByUserIDAndClientID" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                                    <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </div>
                                    </div>
                                </div>

                            </ContentTemplate>
                        </asp:RoleGroup>
                    </RoleGroups>
                </asp:LoginView>

            </div>




        </div>
    </div>



</asp:Content>
