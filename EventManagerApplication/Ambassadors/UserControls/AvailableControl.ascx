<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AvailableControl.ascx.vb" Inherits="EventManagerApplication.AvailableControl" %>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">



    <telerik:RadListView ID="AvailabelEventsList" runat="server" DataSourceID="getAvailableEvents" AllowPaging="True" Skin="Bootstrap">
        <LayoutTemplate>

            <table class="table table-striped">
                <tbody>
                    <tr>
                        <th class="hidden-xs"></th>
                        <th class="hidden-xs">Event</th>
                        <th class="hidden-xs">Date</th>
                        <th class="hidden-xs">Hours</th>
                        <th class="hidden-xs">Position</th>
                        <th class="hidden-xs">Distance</th>
                        <th class="visible-xs"></th>
                        <th class="visible-xs">Event Details</th>
                    </tr>

                    <tr runat="server" id="itemPlaceholder"></tr>

                </tbody>
            </table>

            <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPagerProducts" runat="server" PagedControlID="AvailabelEventsList" PageSize="20">
                <Fields>
                    <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                    <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                    <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
                </Fields>
            </telerik:RadDataPager>
        </LayoutTemplate>

        <ItemTemplate>

            <tr class="hidden-xs">
                <td style="width:200px">
                    <div class="btn-group" role="group" aria-label="...">
                    <asp:Button ID="btnRequestEvent" runat="server" Text='<%# Eval("ButtonText") %>' CssClass='<%# Eval("ButtonCSS") %>' Enabled='<%# Eval("EnableButton") %>' CommandArgument='<%# Eval("eventID") %>' CommandName="RequestEvent" />

                    <a href='/Events/Event_Details?ID=<%# Eval("eventID") %>' class="btn btn-sm btn-default" onclick="ShowLoadingPanel()">View Event</a>
                        </div>
                </td>
                <td>
                    <a href='/Events/Event_Details?ID=<%# Eval("eventID") %>' onclick="ShowLoadingPanel()"><%# Eval("supplierName") %></a>
                    <br />

                    <asp:LoginView ID="LoginView_AddButton" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Client, Agency, Student">
                                <ContentTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("accountName") %>'></asp:Label>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>

                        <RoleGroups>
                            <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, Accounting">
                                <ContentTemplate>
                                    <a class="text-success" href='/Accounts/AccountDetails?AccountID=<%# Eval("accountID") %>'><%# Eval("accountName") %></a>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>


                </td>
                <td><%# Eval("eventDate", "{0:d}") %><br />
                    <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span></td>
                <td style="text-align: center"><%# Eval("hours") %></td>
                <td><%# Eval("positionTitle") %></td>
                <td><%# Eval("miles") %> miles</td>
            </tr>

            <tr class="visible-xs" style="border-bottom: 1px solid lightgray;">
                <td style="padding: 10px;">
                    <asp:Button ID="btnRequestEvent2" runat="server" Text='<%# Eval("ButtonText") %>' CssClass='<%# Eval("ButtonCSS") %>' Enabled='<%# Eval("EnableButton") %>' CommandArgument='<%# Eval("eventID") %>' CommandName="RequestEvent" />
                </td>
                <td style="padding-left: 15px;">
                    <a href='/Events/EventDetails?ID=<%# Eval("eventID") %>'><%# Eval("supplierName") %></a>
                    <br />
                    <asp:LoginView ID="LoginView1" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Client, Agency, Student">
                                <ContentTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("accountName") %>'></asp:Label>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>

                        <RoleGroups>
                            <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, Accounting">
                                <ContentTemplate>
                                    <a class="text-success" href='/Accounts/AccountDetails?AccountID=<%# Eval("accountID") %>'><%# Eval("accountName") %></a>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>
                    <br />
                   Date: <%# Eval("eventDate", "{0:d}") %><br />
                    <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span>
                    <br />
                    <%# Eval("hours") %> hours
                    <br />
                    <%# Eval("positionTitle") %> position
                    <br />
                    <%# Eval("miles") %> miles
                </td>
            </tr>

        </ItemTemplate>
        

        <EmptyDataTemplate>
            <%--<asp:Label ID="lblEmptyData"
                Text='<%# Common.ShowAlertNoClose("warning", "There are no upcoming events to display.")%>' runat="server">
            </asp:Label>--%>

            <div class="alert alert-warning" role="alert">
                There are no available events to display.

            </div>

        </EmptyDataTemplate>
    </telerik:RadListView>

    <asp:SqlDataSource ID="getAvailableEvents" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetAvailableEventsbyAmbassador" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="CurrentUserID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>



</telerik:RadAjaxPanel>