<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="StaffingStatusControl.ascx.vb" Inherits="EventManagerApplication.StaffingStatusControl" %>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <asp:Repeater ID="StaffingList" runat="server" DataSourceID="GetEventStaff">
        <HeaderTemplate>
            <table class="table">
                <tbody>
                    <tr>
                    <th></th>
                    <th>Name</th>
                    <th>Position</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Check-in Time</th>
                    <th>Check-in Location #</th>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <img src='<%# getProfileImage(Eval("assignedUserName")) %>' width="55px" class="thumbnail"  /></td>
                <td><a href='/ambassadors/ViewAmbassadorDetails?UserID=<%# getUserID(Eval("assignedUserName") %>'><%# getFullName(Eval("assignedUserName")) %></a>
                    </td>
                <td><%# getPositionName(Eval("positionID")) %></td>
                <td><%# Eval("startTime", "{0:t}") %></td>
                <td><%# Eval("endTime", "{0:t}") %></td>
                <td>05/01/2015 12:15 PM</td>
                <td></td>
            
            </tr>
        </ItemTemplate>
        <FooterTemplate>

             <asp:Label ID="lblEmptyData"
                  Text='<%# Common.ShowAlertNoClose("warning", "<strong>No Staffing Requirements Entered.</strong> Click on the Requirements tab above to begin entering staffing requirements for this event.")%>'  runat="server" Visible="false">
             </asp:Label>

                </tbody>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    
    <asp:LinqDataSource ID="GetEventStaff" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblEventStaffingRequirements" Where="assigned == @assigned &amp;&amp; eventID == @eventID">
        <WhereParameters>
            <asp:Parameter DefaultValue="True" Name="assigned" Type="Boolean" />
            <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    


</telerik:RadAjaxPanel>

