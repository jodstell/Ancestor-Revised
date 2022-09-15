<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EventTypeTaskControl.ascx.vb" Inherits="EventManagerApplication.EventTypeTaskControl" %>



    <telerik:RadListView ID="TaskList" runat="server" 
        DataKeyNames="eventTypeTaskID" DataSourceID="getEventTypeTasks" InsertItemPosition="FirstItem">
        <LayoutTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>Task</th>
                            <th>Due Date Offset</th>
                            <th>Notes</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </tbody>
                    <tfoot>
                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                            CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New Task</asp:LinkButton>
                    </tfoot>
                </table>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <tr class="rlvI">
                <td>
                    <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("taskTitle")%>' /></td>
                <td>
                    <asp:Label ID="contactNameLabel" runat="server" Text='<%# formatTimeOffset(Eval("dateDueOffset"))%>' /></td>
                <td>
                    <asp:Label ID="contactPhoneLabel" runat="server" Text='<%# Eval("Notes")%>' /></td>

                <td>

                    <div class="btn-group pull-right" role="group" aria-label="...">
                    <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-sm btn-primary" Text="Edit" ToolTip="Edit" />

                    <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-sm btn-danger" Text="Remove" ToolTip="Delete" />
                        </div>
                        </td>
            </tr>
        </ItemTemplate>

        <EditItemTemplate>
            <tr class="rlvIEdit">
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("taskTitle")%>' CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:DropDownList ID="ddlEndTimeOffSet" runat="server" CssClass="form-control" SelectedValue='<%# Bind("dateDueOffset")%>'>
                        <asp:ListItem Value='0'>0 days</asp:ListItem>
                        <asp:ListItem Value='-1'>1 day prior</asp:ListItem>
                        <asp:ListItem Value='-2'>2 days prior</asp:ListItem>
                        <asp:ListItem Value='-3'>3 days prior</asp:ListItem>
                        <asp:ListItem Value='-4'>4 days prior</asp:ListItem>
                        <asp:ListItem Value='-5'>5 days prior</asp:ListItem>
                        <asp:ListItem Value='-6'>6 days prior</asp:ListItem>
                        <asp:ListItem Value='-7'>7 days prior</asp:ListItem>
                        <asp:ListItem Value='-14'>14 days prior</asp:ListItem>
                        <asp:ListItem Value='-30'>30 days prior</asp:ListItem>
                        <asp:ListItem Value='1'>1 day after</asp:ListItem>
                        <asp:ListItem Value='2'>2 days after</asp:ListItem>
                        <asp:ListItem Value='3'>3 days after</asp:ListItem>
                    </asp:DropDownList>

                </td>
                <td>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("notes")%>' CssClass="form-control"></asp:TextBox></td>

                <td style="width: 150px;">
                    <div class="btn-group" role="group" aria-label="...">

                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-sm btn-primary" Text="Save" ToolTip="Update" />
                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-sm btn-default" Text="Cancel" ToolTip="Cancel" />
                    </div>
                </td>
        </EditItemTemplate>

        <InsertItemTemplate>
            <tr class="rlvIEdit">
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("taskTitle")%>' CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:DropDownList ID="ddlEndTimeOffSet" runat="server" CssClass="form-control" SelectedValue='<%# Bind("dateDueOffset")%>'>
                        <asp:ListItem Value='0'>0 days</asp:ListItem>
                        <asp:ListItem Value='-1'>1 day prior</asp:ListItem>
                        <asp:ListItem Value='-2'>2 days prior</asp:ListItem>
                        <asp:ListItem Value='-3'>3 days prior</asp:ListItem>
                        <asp:ListItem Value='-4'>4 days prior</asp:ListItem>
                        <asp:ListItem Value='-5'>5 days prior</asp:ListItem>
                        <asp:ListItem Value='-6'>6 days prior</asp:ListItem>
                        <asp:ListItem Value='-7'>7 days prior</asp:ListItem>
                        <asp:ListItem Value='-14'>14 days prior</asp:ListItem>
                        <asp:ListItem Value='-30'>30 days prior</asp:ListItem>
                        <asp:ListItem Value='1'>1 day after</asp:ListItem>
                        <asp:ListItem Value='2'>2 days after</asp:ListItem>
                        <asp:ListItem Value='3'>3 days after</asp:ListItem>
                    </asp:DropDownList></td>
                <td>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("notes")%>' CssClass="form-control"></asp:TextBox></td>

                <td style="width: 150px;">

                    <div class="btn-group" role="group" aria-label="...">

                        <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-sm btn-primary" Text="Save" ToolTip="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-sm btn-default" Text="Cancel" ToolTip="Cancel" />
                    </div>


                </td>
        </InsertItemTemplate>


        <EmptyDataTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>Task</th>
                            <th>Due Date Offset</th>
                            <th>Notes</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="7">
                                <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Task</strong> button above.</div>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                            Text="Add New Task" CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New Task</asp:LinkButton>
                    </tfoot>
                </table>
            </div>
        </EmptyDataTemplate>

    </telerik:RadListView>


    <!-- LinqDataSource -->
    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getEventTypeTasks" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblEventTypeTasks" Where="eventTypeID == @eventTypeID" EnableDelete="True" EnableInsert="True" EnableUpdate="True">
        <WhereParameters>
            <asp:QueryStringParameter QueryStringField="EventTypeID" Name="eventTypeID" Type="Int32"></asp:QueryStringParameter>

        </WhereParameters>
    </asp:LinqDataSource>


