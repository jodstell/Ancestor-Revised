<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PreviousEventsControl.ascx.vb" Inherits="EventManagerApplication.PreviousEventsControl" %>

<script>
     function bntView() {

                var loadingPanel = $find('<%= RadAjaxLoadingPanel2.ClientID %>');
                var currentUpdatedControl = "<%= Panel2.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.show(currentUpdatedControl);

            }
</script>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<asp:Panel runat="server" ID="Panel2">

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <asp:Repeater ID="PreviousEventsList" runat="server" DataSourceID="getPreviousEvents">
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
                <a class="btn btn-primary btn-xs" href='/Events/EventDetails?ID=<%# Eval("eventID") %>' onclick="bntView()">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></a></a></td>
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
                <asp:Label ID="lblEmptyData" Text='<%# Common.ShowAlertNoClose("warning", "There are no previous events to display.")%>'  runat="server" Visible="false"></asp:Label>
            </div> 
        </FooterTemplate>
    </asp:Repeater>

    <asp:LinqDataSource ID="getPreviousEvents" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" TableName="qryViewPastEvents" Where="accountID == @accountID" OrderBy="eventDate desc">
        <WhereParameters>
            <asp:QueryStringParameter QueryStringField="AccountID" Name="accountID" Type="Int32"></asp:QueryStringParameter>
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:HiddenField ID="CurrentDate" runat="server" />

</telerik:RadAjaxPanel>

</asp:Panel>