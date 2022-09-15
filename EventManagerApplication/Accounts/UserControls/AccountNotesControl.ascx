<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AccountNotesControl.ascx.vb" Inherits="EventManagerApplication.AccountNotesControl" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>



<telerik:RadAjaxPanel ID="RadAjaxPanelNotes" runat="server">

 <asp:Panel ID="Panel1" runat="server">
    <telerik:RadListView ID="NoteList" runat="server"
        DataKeyNames="accountNoteID" DataSourceID="getNotes" InsertItemPosition="FirstItem">
        <LayoutTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width: 100%;">

                    <tbody>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </tbody>
                    <tfoot>
                        <asp:LoginView ID="LoginView_AddButton" runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                                    <ContentTemplate>
                                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert"
                                            CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New Note </asp:LinkButton>
                                    </ContentTemplate>
                                </asp:RoleGroup>
                            </RoleGroups>
                        </asp:LoginView>
                    </tfoot>
                </table>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <tr class="rlvI">
                <td>
                    <div class="btn-group" role="group" aria-label="...">
                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-default btn-sm" ToolTip="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                    <asp:LoginView ID="LoginView_AddButton" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                                <ContentTemplate>
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-sm btn-danger"
                                        ToolTip="Delete"><i class="fa fa-trash"></i> Delete</asp:LinkButton>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>
                    </div>
                </td>
                <td>
                    <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note")%>' />

                    <div class="notefooter">
                        Created by:
                        <asp:Label ID="dateLabel" runat="server" Text='<%# getFullName(Eval("createdBy"))%>' />
                        on
                        <asp:Label ID="byLabel" runat="server" Text='<%# Eval("dateCreated", "{0:f}")%>' />
                    </div>
                </td>                
            </tr>
        </ItemTemplate>

        <EditItemTemplate>
            <tr class="rlvIEdit">
                <td></td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("note")%>' CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox></td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-sm btn-primary" Text="Update" ToolTip="Update" />
                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-sm btn-default" Text="Cancel" ToolTip="Cancel" />
                </td>


        </EditItemTemplate>

        <InsertItemTemplate>
            <tr class="rlvIEdit">
                <td></td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("note")%>' CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox></td>
                <td>
                    <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-sm btn-primary" Text="Save Changes" ToolTip="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-sm btn-default" Text="Cancel" ToolTip="Cancel" />
                </td>
        </InsertItemTemplate>


        <EmptyDataTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width: 100%;">

                    <tbody>
                        <tr>
                            <td colspan="7">
                                <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Note</strong> button above.</div>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <asp:LoginView ID="LoginView_AddButton" runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                                    <ContentTemplate>
                                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert"
                                            CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New Note</asp:LinkButton>
                                    </ContentTemplate>
                                </asp:RoleGroup>
                            </RoleGroups>
                        </asp:LoginView>
                    </tfoot>
                </table>
            </div>
        </EmptyDataTemplate>

    </telerik:RadListView>
</asp:Panel>

    <asp:LinqDataSource ID="getNotes" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" OrderBy="dateCreated"
        TableName="tblAccountNotes" Where="accountID == @accountID">
        <WhereParameters>
            <asp:QueryStringParameter Name="accountID" QueryStringField="AccountID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

</telerik:RadAjaxPanel>
