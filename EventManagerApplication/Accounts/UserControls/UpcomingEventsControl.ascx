<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UpcomingEventsControl.ascx.vb" Inherits="EventManagerApplication.UpcomingEventsControl" %>

<script>
     function bntView() {

                var loadingPanel = $find('<%= RadAjaxLoadingPanelUpcoming.ClientID %>');
                var currentUpdatedControl = "<%= RadAjaxPanel1.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.show(currentUpdatedControl);

            }
</script>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelUpcoming" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<asp:Panel runat="server" ID="UpcomingPanel">

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <asp:Repeater ID="UpcomingEventsList" runat="server" DataSourceID="getUpcomingEvents">
        <HeaderTemplate>
            <table class="table" cellspacing="0" style="width: 100%;">
                <thead>
                    <tr>
                        <th>&nbsp;</th>
                        <th>Date/Time</th>
                        <th>Supplier Name</th>
                        <th>Status</th>
                        <th>Brands</th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td>
                <a class="btn btn-primary btn-xs" href='/Events/EventDetails?ID=<%# Eval("eventID") %>' onclick="bntView()">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></a></td>
                <td><%# Eval("eventDate", "{0:D}") %>  <%# Eval("startTime", "{0:t}") %></td>
                <td><%# Eval("supplierName") %></td>
                <td><%# Eval("statusName") %></td>
                <td><%# Eval("brands") %></td>
                <td>&nbsp;</td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody>
                    <tfoot>
                    </tfoot>
            </table>

            <div style='margin: 8px;'>
                <asp:Label ID="lblEmptyData" Text='<%# Common.ShowAlertNoClose("warning", "There are no upcoming events to display.")%>' runat="server" Visible="false"></asp:Label>
            </div>

        </FooterTemplate>
    </asp:Repeater>

    <asp:LinqDataSource ID="getUpcomingEvents" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" TableName="qryViewCurrentEvents" Where="accountID == @accountID" OrderBy="eventDate desc">
        <WhereParameters>
            <asp:QueryStringParameter QueryStringField="AccountID" Name="accountID" Type="Int32"></asp:QueryStringParameter>
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:HiddenField ID="CurrentDate" runat="server" />

</telerik:RadAjaxPanel>

</asp:Panel>