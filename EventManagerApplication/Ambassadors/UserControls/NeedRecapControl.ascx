<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="NeedRecapControl.ascx.vb" Inherits="EventManagerApplication.NeedRecapControl" %>


<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="ShowLoadingPanel()">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManager>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<asp:Panel ID="Panel1" runat="server">

    <asp:Label ID="msgLabel" runat="server" />

    <telerik:RadListView ID="NeedsRecapEventsList" runat="server" DataSourceID="getNeedsRecaps" AllowPaging="false" Skin="Bootstrap" >
        <LayoutTemplate>
            <div class="overflow" style="padding-right: 15px;">
            <table class="table table-striped">
                <tbody>
                    <tr>
                        <th></th>
                        <th>Event</th>
                        <th>Date</th>
                        <th class="hidden-xs">Hours</th>
                        <th class="hidden-xs">Position</th>
                        <th>Rate</th>
                    </tr>

                    <tr runat="server" id="itemPlaceholder"></tr>

                </tbody>
            </table>
            </div>
            <%--<telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPagerProducts" runat="server" PagedControlID="NeedsRecapEventsList" PageSize="10">
                <Fields>
                    <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                    <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                    <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
                </Fields>
            </telerik:RadDataPager>--%>

        </LayoutTemplate>


        <ItemTemplate>
            <tr>
                <td>

                <asp:Button ID="btnRecap" runat="server" Text="Recap" CssClass="btn btn-sm btn-primary" 
                    CommandName="StartRecap" CommandArgument='<%# Eval("eventID") %>' Visible="true"  /><br />
                    <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("LabelText") %>' />

                </td>

                <td>
                    <a href='/Events/Event_Details?ID=<%# Eval("eventID") %>' onclick="ShowLoadingPanel()"><%# Eval("supplierName") %> <br />

                        <asp:Label ID="AccountNameLabel" runat="server" Text='<%# Eval("accountName") %>' Visible="True"></asp:Label>
                        <asp:HyperLink ID="AccountNameHyperLink" runat="server" CssClass="text-success" 
                            NavigateUrl='/Accounts/AccountDetails?AccountID=<%# Eval("accountID") %>' Visible="false"><%# Eval("accountName") %></asp:HyperLink>

                </td>
                <td><%# Eval("eventDate", "{0:d}") %><br />
                    <span style="font-size:smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span>

                </td>
                <td class="hidden-xs" style="text-align: center"><%# Eval("hours") %></td>
                <td class="hidden-xs"><%# Eval("positionTitle") %></td>
                <td><%# Eval("rate", "{0:c}") %></td>
            </tr>
        </ItemTemplate>


        <EmptyDataTemplate>
            <%--<asp:Label ID="lblEmptyData"
                Text='<%# Common.ShowAlertNoClose("warning", "There are no recap events events to display.")%>' runat="server">
            </asp:Label>--%>

            <div class="alert alert-warning" role="alert">
                There are no recap needed to display.

            </div>
        </EmptyDataTemplate>


    </telerik:RadListView>

    </asp:Panel>

    <asp:LinqDataSource ID="getNeedsRecaps" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" 
        OrderBy="eventDate desc" 
        Select="new (eventID, eventDate, supplierName, positionTitle, rate, hours, accountID, accountName, startTime, endTime, recapStatus, LabelText)" 
        TableName="qryViewNeedsRecapEventsByAmbassadors" Where="userID == @userID">
        <WhereParameters>
            <asp:SessionParameter Name="userID" SessionField="CurrentUserID" Type="String" />

        </WhereParameters>
    </asp:LinqDataSource>


