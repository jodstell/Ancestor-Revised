<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UpcomingControl.ascx.vb" Inherits="EventManagerApplication.UpcomingControl" %>


<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">



    <telerik:RadListView ID="UpcomingEventsList" runat="server" DataSourceID="getUpcomingEvents" AllowPaging="False" Skin="Bootstrap">
        <LayoutTemplate>
            <div class="overflow" style="padding-right: 15px;">
            <table class="table table-striped">
                <tbody>
                    <tr>
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
           <%-- <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPagerProducts" runat="server" PagedControlID="UpcomingEventsList" PageSize="10">
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
                    <a href='/Events/Event_Details?ID=<%# Eval("eventID") %>'onclick="ShowLoadingPanel()"><%# Eval("supplierName") %></a><br />

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
                <td class="hidden-xs" style="text-align: center"><%# Eval("hours") %></td>
                <td class="hidden-xs"><%# Eval("positionTitle") %></td>
                <td><%# Eval("rate", "{0:c}") %></td>
            </tr>

        </ItemTemplate>


        <EmptyDataTemplate>
            <%--<asp:Label ID="lblEmptyData"
                Text='<%# Common.ShowAlertNoClose("warning", "There are no upcoming events to display.")%>' runat="server">
            </asp:Label>--%>

            <div class="alert alert-warning" role="alert">
                There are no upcoming events to display.
  
            </div>

        </EmptyDataTemplate>



    </telerik:RadListView>



    <asp:LinqDataSource ID="getUpcomingEvents" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="eventDate desc" Select="new (eventID, eventDate, supplierName, hours, rate, positionTitle, accountID, accountName, startTime, endTime)" TableName="qryViewCurrentEventsByAmbassadors" Where="userID == @userID">
        <WhereParameters>
            <asp:SessionParameter Name="userID" SessionField="CurrentUserID" Type="String" />
        </WhereParameters>
    </asp:LinqDataSource>




</telerik:RadAjaxPanel>





