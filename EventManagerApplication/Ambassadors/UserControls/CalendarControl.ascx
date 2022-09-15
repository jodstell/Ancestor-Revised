<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CalendarControl.ascx.vb" Inherits="EventManagerApplication.CalendarControl" %>


 <asp:Panel ID="CalendarPanel" runat="server">
                <div class="widget stacked min-height">
                    <div class="widget-content">

                    </div>
                    <telerik:RadSplitter RenderMode="Lightweight" runat="server" ID="RadSplitter1"  
                    PanesBorderSize="0" Width="1000" Height="450" Skin="Metro">
                    <telerik:RadPane runat="Server" ID="leftPane" Width="265" Scrolling="None">
                        <telerik:RadSplitter RenderMode="Lightweight" runat="server" ID="RadSplitter2" 
                            Orientation="Horizontal" Width="100%">
                            <telerik:RadPane runat="server" Height="420">
                                <telerik:RadCalendar RenderMode="Lightweight" runat="server" ID="RadCalendar1"  EnableMultiSelect="false"
                                    FocusedDate="2012/01/31" DayNameFormat="FirstTwoLetters" EnableNavigation="true"
                                    EnableMonthYearFastNavigation="true" Skin="Metro">
                                    <ClientEvents OnDateSelected="OnCalendar1DateSelected"
                                        OnCalendarViewChanged="OnCalendar1ViewChanged" />
                                </telerik:RadCalendar>
                            </telerik:RadPane>
                            <%--<telerik:RadSplitBar runat="server" EnableResize="false" />
                            <telerik:RadPane runat="server">
 
                                <telerik:RadPanelBar RenderMode="Lightweight" runat="server" ID="RadPanelBar1"  Width="95%" Skin="Metro"
                                    ExpandAnimation-Type="None" CollapseAnimation-Type="None" ExpandMode="SingleExpandedItem">
                                    <Items>
                                        <telerik:RadPanelItem runat="server" Text="My Calendars" Expanded="true">
                                            <Items>
                                                <telerik:RadPanelItem runat="server">
                                                    <ItemTemplate>
                                                        <div class="rpCheckBoxPanel">
                                                            <div class="qsf-chk-personal">
                                                                <label>
                                                                    <input id="chkPersonal" type="checkbox" title="Personal" onclick="rebindScheduler()"
                                                                        value="Personal" checked="checked" name="Personal" />
                                                                    <span>Personal</span>
                                                                </label>
                                                            </div>
                                                            <div class="qsf-chk-work">
                                                                <label>
                                                                    <input id="chkWork" type="checkbox" title="Work" onclick="rebindScheduler()" value="Work"
                                                                        checked="checked" name="Work" />
                                                                    <span>Work</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                       
                                                        <span title="This button Groups RadScheduler by its Resources creating a separate calendar for each resource item and situating the appropriate appointments there."
                                                            class="qsf-btn-hint">?</span>
                                                    </ItemTemplate>
                                                </telerik:RadPanelItem>
                                            </Items>
                                        </telerik:RadPanelItem>
                                    </Items>
                                </telerik:RadPanelBar>
                            </telerik:RadPane--%>
                        </telerik:RadSplitter>
                    </telerik:RadPane>
                    <telerik:RadSplitBar runat="server" ID="RadSplitBar2" CollapseMode="Forward" EnableResize="false" />
                    <telerik:RadPane runat="Server" ID="rightPane" Scrolling="None">
                    <telerik:RadScheduler ID="RadScheduler1" runat="server" DataSourceID="getEvents" DataKeyField="eventID" SelectedView="WeekView" AppointmentStyleMode="Default"
                        AllowEdit="False" AllowInsert="False" Skin="Metro" OverflowBehavior="Expand" DataEndField="endTime" DataStartField="startTime" DataDescriptionField="supplierID"
                        DataSubjectField="supplierName" RowHeight="30px" OnClientAppointmentClick="OnClientAppointmentClick" Width="1000px">
                        <ResourceTypes>
                            <telerik:ResourceType KeyField="eventID" Name="StatusName" TextField="statusName" ForeignKeyField="eventID"
                                DataSourceID="getEvents"></telerik:ResourceType>
                        </ResourceTypes>
                    </telerik:RadScheduler> 
                        </telerik:RadPane>
                </telerik:RadSplitter>
                    </div>
            </asp:Panel>



<asp:LinqDataSource ID="getEvents" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="qryViewEvents">
</asp:LinqDataSource>
    
