<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandStaffingPositionControl.ascx.vb" Inherits="EventManagerApplication.BrandStaffingPositionControl" %>

<div style="min-height: 400px">
<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <asp:Panel ID="BrandPositionListPanel" runat="server">
    <telerik:RadListView ID="BrandPositionList" runat="server"
        DataKeyNames="brandStaffingPositionID" DataSourceID="getStaffingPositions" InsertItemPosition="LastItem">
        <LayoutTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width:100%;">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Position</th>
                            <th>Start Time Offset</th>
                            <th>End Time Offset</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </tbody>
                    <tfoot>
                         <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                           CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Position</asp:LinkButton>                       
                    </tfoot>
                </table>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <tr class="rlvI">
                <td>
                    <div class="btn-group" role="group" aria-label="...">
                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-default btn-sm" ToolTip="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-sm btn-danger" ToolTip="Delete"><i class="fa fa-trash"></i> Delete</asp:LinkButton>
                        </div>
                </td>
                <td>
                    <asp:Label ID="staffingPositionIDLabel" runat="server" Text='<%# getPositionName(Eval("staffingPositionID"))%>' />
                </td>
                <td>
                    <asp:Label ID="startTimeOffSetLabel" runat="server" Text='<%# formatTimeOffset(Eval("startTimeOffSet"))%>' />
                </td>
                <td>
                    <asp:Label ID="endTimeOffSetLabel" runat="server" Text='<%# formatTimeOffset(Eval("endTimeOffSet"))%>' />
                </td>                
            </tr>
        </ItemTemplate>
        
        <EditItemTemplate>
            <tr class="rlvIEdit">
                <td>
                </td>
                <td>
                    <asp:DropDownList ID="ddlStaffingPositionID" runat="server" DataSourceID="getPositionList" CssClass="form-control input-sm" SelectedValue='<%# Bind("staffingPositionID")%>' 
                        DataTextField="positionTitle" DataValueField="staffingPositionID">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddlStartTimeOffSet" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("startTimeOffSet")%>'>
                        <asp:ListItem Value='0'>0 minutes</asp:ListItem>
                        <asp:ListItem Value='-120'>120 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-90'>90 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-60'>60 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-45'>45 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-30'>30 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-15'>15 minutes prior</asp:ListItem>
                        <asp:ListItem Value='15'>15 minutes after</asp:ListItem>
                        <asp:ListItem Value='30'>30 minutes after</asp:ListItem>
                        <asp:ListItem Value='45'>45 minutes after</asp:ListItem>
                        <asp:ListItem Value='60'>60 minutes after</asp:ListItem>
                        <asp:ListItem Value='90'>90 minutes after</asp:ListItem>
                        <asp:ListItem Value='120'>120 minutes after</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddlEndTimeOffSet" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("endTimeOffSet")%>'>
                        <asp:ListItem Value='0'>0 minutes</asp:ListItem>
                        <asp:ListItem Value='-120'>120 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-90'>90 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-60'>60 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-45'>45 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-30'>30 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-15'>15 minutes prior</asp:ListItem>
                        <asp:ListItem Value='15'>15 minutes after</asp:ListItem>
                        <asp:ListItem Value='30'>30 minutes after</asp:ListItem>
                        <asp:ListItem Value='45'>45 minutes after</asp:ListItem>
                        <asp:ListItem Value='60'>60 minutes after</asp:ListItem>
                        <asp:ListItem Value='90'>90 minutes after</asp:ListItem>
                        <asp:ListItem Value='120'>120 minutes after</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-sm btn-primary" Text="Save Changes" ToolTip="Update" />
                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-sm btn-default" Text="Cancel" ToolTip="Cancel" />                
                </td>

            </tr>
        </EditItemTemplate>
        <InsertItemTemplate>
            <tr class="rlvIEdit">

                 <td>
                </td>
                <td>
                    <asp:DropDownList ID="ddlStaffingPositionID" runat="server" DataSourceID="getPositionList" CssClass="form-control input-sm" SelectedValue='<%# Bind("staffingPositionID")%>' 
                        DataTextField="positionTitle" DataValueField="staffingPositionID">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddlStartTimeOffSet" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("startTimeOffSet")%>'>
                        <asp:ListItem Value='0'>0 minutes</asp:ListItem>
                        <asp:ListItem Value='-120'>120 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-90'>90 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-60'>60 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-45'>45 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-30'>30 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-15'>15 minutes prior</asp:ListItem>
                        <asp:ListItem Value='15'>15 minutes after</asp:ListItem>
                        <asp:ListItem Value='30'>30 minutes after</asp:ListItem>
                        <asp:ListItem Value='45'>45 minutes after</asp:ListItem>
                        <asp:ListItem Value='60'>60 minutes after</asp:ListItem>
                        <asp:ListItem Value='90'>90 minutes after</asp:ListItem>
                        <asp:ListItem Value='120'>120 minutes after</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddlEndTimeOffSet" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("endTimeOffSet")%>'>
                        <asp:ListItem Value='0'>0 minutes</asp:ListItem>
                        <asp:ListItem Value='-120'>120 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-90'>90 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-60'>60 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-45'>45 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-30'>30 minutes prior</asp:ListItem>
                        <asp:ListItem Value='-15'>15 minutes prior</asp:ListItem>
                        <asp:ListItem Value='15'>15 minutes after</asp:ListItem>
                        <asp:ListItem Value='30'>30 minutes after</asp:ListItem>
                        <asp:ListItem Value='45'>45 minutes after</asp:ListItem>
                        <asp:ListItem Value='60'>60 minutes after</asp:ListItem>
                        <asp:ListItem Value='90'>90 minutes after</asp:ListItem>
                        <asp:ListItem Value='120'>120 minutes after</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-sm btn-primary" Text="Save Changes" ToolTip="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-sm btn-default" Text="Cancel" ToolTip="Cancel" />
                </td>

               
            </tr>
        </InsertItemTemplate>
        <EmptyDataTemplate>
            <div class="RadListView RadListView_Default">
                 <table class="table" cellspacing="0" style="width:100%;">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Position</th>
                            <th>Start Time Offset</th>
                            <th>End Time Offset</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="5">
                                <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Position</strong> button above.</div>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                         <%--<asp:Button ID="btnInsert2" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                          Text="Add New Position" CssClass="btn btn-xs btn-primary pull-right"></asp:Button>--%>
                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                           CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Position</asp:LinkButton>
                    </tfoot>
                </table>
                
                                
            </div>
        </EmptyDataTemplate>
        
    </telerik:RadListView>
</asp:Panel>




    <asp:LinqDataSource ID="getPositionList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="positionTitle" TableName="tblStaffingPositions">
    </asp:LinqDataSource>


    <asp:LinqDataSource ID="getStaffingPositions" runat="server" 
        ContextTypeName="EventManagerApplication.DataClassesDataContext" 
        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" 
        TableName="tblBrandStaffingPositions" Where="brandID == @brandID">
        <WhereParameters>
            <asp:SessionParameter DbType="Int32" Name="brandID" SessionField="SelectedBrandID" />
        </WhereParameters>
    </asp:LinqDataSource>


    
</telerik:RadAjaxPanel>
</div>
