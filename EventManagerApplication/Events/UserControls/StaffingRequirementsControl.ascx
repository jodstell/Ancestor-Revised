<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="StaffingRequirementsControl.ascx.vb" Inherits="EventManagerApplication.StaffingRequirementsControl" %>


<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <strong>Event Date: <asp:Label ID="eventDateLabel" runat="server" /> - Event Start: <asp:Label ID="startTimeLabel" runat="server" /> - Event End: <asp:Label ID="endTimeLabel" runat="server" /></strong>

    <telerik:RadListView ID="BrandPositionList" runat="server"
        DataKeyNames="RequirementID" DataSourceID="getEventPositions" InsertItemPosition="FirstItem">
        <LayoutTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width:100%;">
                    <thead>
                        <tr>
                            <th>Position</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </tbody>
                    <tfoot>
                         <asp:Button ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                          Text="Add New Position" CssClass="btn btn-xs btn-primary pull-right"></asp:Button>
                    </tfoot>
                </table>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <tr class="rlvI">

                <td>
                    <asp:Label ID="staffingPositionIDLabel" runat="server" Text='<%# getPositionName(Eval("positionID"))%>' />
                </td>
                <td>
                    <asp:Label ID="startTimeOffSetLabel" runat="server" Text='<%# Eval("startTime", "{0:t}")%>' />
                </td>
                <td>
                    <asp:Label ID="endTimeOffSetLabel" runat="server" Text='<%# Eval("endTime", "{0:t}")%>' />
                </td>
                <td>
                    <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" Text="Remove Position" ToolTip="Delete" />
                </td>
            </tr>
        </ItemTemplate>
        
        <EditItemTemplate>
            <tr class="rlvIEdit">

                <td>
                    <asp:DropDownList ID="ddlStaffingPositionID" runat="server" DataSourceID="getPositionList" CssClass="form-control input-med" SelectedValue='<%# Bind("positionID")%>' 
                        DataTextField="positionTitle" DataValueField="staffingPositionID">
                    </asp:DropDownList>
                </td>
                <td>
                   <telerik:RadTimePicker ID="RadTimePicker1" runat="server" DbSelectedDate='<%# Bind("startTime")%>' Skin="Bootstrap"></telerik:RadTimePicker>
                </td>
                <td>
                    <telerik:RadTimePicker ID="RadTimePicker2" runat="server" DbSelectedDate='<%# Bind("endTime")%>' Skin="Bootstrap"></telerik:RadTimePicker>
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Update" />
                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />                
                </td>

            </tr>
        </EditItemTemplate>
        <InsertItemTemplate>
            <tr class="rlvIEdit">

               
                <td>
                    <asp:DropDownList ID="ddlStaffingPositionID" runat="server" DataSourceID="getPositionList" CssClass="form-control input-med" 
                        SelectedValue='<%# Bind("positionID")%>' 
                        DataTextField="positionTitle" DataValueField="staffingPositionID">
                    </asp:DropDownList>
                </td>
                <td>

                    <telerik:RadTimePicker ID="RadTimePicker12" runat="server" DbSelectedDate='<%# Bind("startTime")%>' Skin="Bootstrap"></telerik:RadTimePicker>

                </td>
                <td>
                    <telerik:RadTimePicker ID="RadTimePicker22" runat="server" DbSelectedDate='<%# Bind("endTime") %>' Skin="Bootstrap" Culture="en-US"></telerik:RadTimePicker>
                  
                </td>
                <td>
                    <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                </td>

               
            </tr>
        </InsertItemTemplate>
        <EmptyDataTemplate>
            <div class="RadListView RadListView_Default">
                 <table class="table" cellspacing="0" style="width:100%;">
                    <thead>
                        <tr>
                            <th>Position</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="5">
                                <div class="alert alert-warning" role="alert">
                                There are no open positions.  To add a new position click on the "Add New Position" button above.
                                </div>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                         <asp:Button ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                          Text="Add New Position" CssClass="btn btn-xs btn-primary pull-right"></asp:Button>
                    </tfoot>
                </table>
                
                                
            </div>
        </EmptyDataTemplate>
        
    </telerik:RadListView>

    <asp:Label ID="MsgLabel" runat="server" />

<asp:LinqDataSource ID="getEventPositions" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
    EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblEventStaffingRequirements" Where="eventID == @eventID &amp;&amp; assigned == @assigned">
    <WhereParameters>
        <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="Int32" />
        <asp:Parameter DefaultValue="False" Name="assigned" Type="Boolean" />
    </WhereParameters>
</asp:LinqDataSource>

     <asp:LinqDataSource ID="getPositionList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
         EntityTypeName="" OrderBy="positionTitle" TableName="tblStaffingPositions">
    </asp:LinqDataSource>

    </telerik:RadAjaxPanel>


