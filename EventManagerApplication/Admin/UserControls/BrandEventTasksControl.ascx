<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandEventTasksControl.ascx.vb" Inherits="EventManagerApplication.BrandEventTasksControl" %>


<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <asp:Panel runat="server" ID="BrandEventTaskListPanel">
    <telerik:RadListView ID="BrandEventTaskList" runat="server"
        DataKeyNames="taskID" DataSourceID="getBrandEventTasks" InsertItemPosition="FirstItem">
        <LayoutTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width:100%;">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Task</th>
                            <th>Category</th>
                            <th>Date Due Offset</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </tbody>
                    <tfoot> 
                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                           CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Task</asp:LinkButton>                     
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
                    <asp:Label ID="TaskNameLabel" runat="server" Text='<%#(Eval("taskName"))%>' />
                </td>
                <td>
                    <asp:Label ID="CategoryLabel" runat="server" Text='<%# (Eval("category"))%>' />
                </td>
                <td>
                    <asp:Label ID="dateDueOffSetLabel" runat="server" Text='<%# Eval("DateDueOffSet")%>' />
                </td>                
            </tr>
        </ItemTemplate>
        
        <EditItemTemplate>
            <tr class="rlvIEdit">
                <td>
                </td>
                <td>
                    <asp:TextBox ID="taskNameTextBox" runat="server" Text='<%# Bind("taskName")%>' CssClass="form-control"></asp:TextBox>
                </td>
                <td>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("category")%>'>
                    <asp:ListItem Text="Task" Value="Task"></asp:ListItem>    
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddlEndTimeOffSet" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("dateDueOffSet")%>'>
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
                    <asp:TextBox ID="taskNameTextBox" runat="server" Text='<%# Bind("taskName")%>' CssClass="form-control"></asp:TextBox>
                </td>
                <td>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("category")%>'>
                    <asp:ListItem Text="Task" Value="Task"></asp:ListItem>    
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddlEndTimeOffSet" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("dateDueOffSet")%>'>
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
                            <th>Task</th>
                            <th>Category</th>
                            <th>Date Due Offset</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="5">
                                <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Task</strong> button above.</div>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                         <%--<asp:Button ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                          Text="Add New Task" CssClass="btn btn-xs btn-primary pull-right"></asp:Button>--%>
                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                           CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Task</asp:LinkButton> 
                    </tfoot>
                </table>
                
                                
            </div>
        </EmptyDataTemplate>
        
    </telerik:RadListView>

</asp:Panel>
    <asp:LinqDataSource ID="getBrandEventTasks" runat="server" 
        ContextTypeName="EventManagerApplication.DataClassesDataContext" 
        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" 
        TableName="tblBrandEventTasks" Where="brandID == @brandID">
        <WhereParameters>
            <asp:SessionParameter DbType="Int32" Name="brandID" SessionField="SelectedBrandID" />
        </WhereParameters>
    </asp:LinqDataSource>


    
</telerik:RadAjaxPanel>
