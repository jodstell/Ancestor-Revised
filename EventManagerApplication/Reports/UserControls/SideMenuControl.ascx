<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SideMenuControl.ascx.vb" Inherits="EventManagerApplication.SideMenuControl" %>

<div class="widget-content-sidebar sidemenu" style="padding: 15px 5px 15px;">
    <h5 class="headerbar">Dashboard</h5>
    <ul>
        <li><a href="/Reports/OffPremiseDashboard.aspx">Retail/Off Premise</a></li>
        <li><a href="/Reports/OnPremiseDashboard.aspx">Bar/On Premise</a></li>
    </ul>

        <asp:LoginView ID="LoginView0" runat="server">
        <RoleGroups>
            <asp:RoleGroup Roles="Administrator, EventManager, Accounting, Client, Recruiter/Booking">
                <ContentTemplate>
    <h5 class="headerbar">Sales Recap Reports</h5>
    <ul>
        <li><a href="/Reports/SalesRecap/OffPremiseReport.aspx">Retail/Off Premise</a></li>
        <li><a href="/Reports/SalesRecap/OnPremiseReport.aspx">Bar/On Premise</a></li>
    </ul>
                                    </ContentTemplate>
            </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>

    <asp:LoginView ID="LoginView_1" runat="server">
        <RoleGroups>
            <asp:RoleGroup Roles="Administrator, EventManager, Accounting, Client, Agency, Recruiter/Booking">
                <ContentTemplate>

                    <h5 class="headerbar">Custom Supplier Reports</h5>

                    <asp:Repeater ID="SupplierReportsList" runat="server" DataSourceID="getSupplierReports">
                        <HeaderTemplate><ul></HeaderTemplate>
                        <ItemTemplate>
                            <li><a href="/Reports/ReportBuilder/ViewEventReport?ReportID=<%# Eval("reportID") %>"><%# Eval("reportTitle") %></a></li>
                        </ItemTemplate>
                        <FooterTemplate></ul></FooterTemplate>
                    </asp:Repeater>



                    <asp:SqlDataSource runat="server" ID="getSupplierReports" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getReportByUserIDAndClientID" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                            <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>



                   <%-- <ul>
                        <li><a href="/Reports/CustomSupplier/ExecutiveScorecard.aspx">Executive Scorecard</a></li>
                        <li><a href="/Reports/CustomSupplier/MBNProgram.aspx">MBN Program</a></li>
                        <li><a href="/Reports/CustomSupplier/AccountActivityReport.aspx">Account Activity Reports</a></li>

                    </ul>--%>

                </ContentTemplate>
            </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>

        <asp:LoginView ID="LoginView1" runat="server">
        <RoleGroups>
            <asp:RoleGroup Roles="Administrator">
                <ContentTemplate>

    <h5 class="headerbar">Reports</h5>
    <ul>
        <%--<li><a href="/Reports/ClientReports/<%: clientFolder() %>/Invoicing.aspx">Invoicing</a></li>--%>
        <li><a href="/Reports/BARetcReports/Invoicing.aspx">Invoicing</a></li>
        <li><a href="/Reports/BARetcReports/BrandAmbassadors.aspx">Brand Ambassadors</a></li>
        <li><a href='/Reports/BARetcReports/PayrollDashboard'>Payroll</a></li>
        <%--<li><a href='/Reports/ClientReports/<%: clientFolder() %>/Payroll.aspx'>Payroll</a></li>--%>
        <li><a href="/Reports/BARetcReports/PayCards.aspx">Pay Cards</a></li>
        <li><a href="/Reports/CustomSupplier/AccountActivityReport.aspx">Account Activity Reports</a></li>
    </ul>

                    
                </ContentTemplate>
            </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>

    <asp:LoginView ID="LoginView2" runat="server">
        <RoleGroups>
            <asp:RoleGroup Roles="Administrator">
                <ContentTemplate>

    <h5 class="headerbar">Report Builder</h5>
    <ul>
        <li><a href="/Reports/ReportBuilder/AccountsVenues.aspx">Accounts/Venues</a></li>
        <li><a href="/Reports/ReportBuilder/Events.aspx">Events</a></li>
        <li><a href="/Reports/ReportBuilder/Staff.aspx">Staff</a></li>
        <li><a href="/Reports/ReportBuilder/Supplier.aspx">Supplier</a></li>
    </ul>


                </ContentTemplate>
            </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>

</div>
