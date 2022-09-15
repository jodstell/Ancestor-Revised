<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AccountContacts.ascx.vb" Inherits="EventManagerApplication.AccountContacts" %>

<style>
    .line {
        line-height: 1.5 !important;
    }
</style>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ContactListPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ContactListPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>


<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">
    
<asp:Panel runat="server" ID="ContactListPanel">
    <telerik:RadListView ID="ContactList" runat="server"
        DataKeyNames="accountContactID" DataSourceID="getContacts" InsertItemPosition="FirstItem">
        <LayoutTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Title</th>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>D.O.B</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </tbody>
                    <tfoot>
                        <asp:LoginView ID="LoginView_AddButton" runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                                    <ContentTemplate>
                                        <asp:LinkButton ID="btnInsert1" runat="server" CommandName="InitInsert"
                                            CssClass="btn btn-success btn-sm pull-right"><i class="fa fa-plus"></i> Add New Contact</asp:LinkButton>
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
                    
                    <asp:LoginView ID="LoginView_AddButton" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                                <ContentTemplate>
                                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-xs btn-default line" ToolTip="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger line"
                                        ToolTip="Delete"><i class="fa fa-trash"></i> Delete</asp:LinkButton>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>

                </td>
                <td>
                    <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title")%>' /></td>
                <td>
                    <asp:Label ID="contactNameLabel" runat="server" Text='<%# Eval("contactName")%>' /></td>
                <td>
                    <asp:Label ID="contactPhoneLabel" runat="server" Text='<%# Eval("contactPhone")%>' /></td>
                <td>
                    <asp:Label ID="ContactEmailLabel" runat="server" Text='<%# Eval("contactEmail")%>' /></td>
                <td>
                    <asp:Label ID="DOBLabel" runat="server" Text='<%# Eval("dob")%>' /></td>                
            </tr>
        </ItemTemplate>

        <EditItemTemplate>
            <tr class="rlvIEdit">
                <td></td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("title")%>' CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("contactName")%>' CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("contactPhone")%>' CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("contactEmail")%>' CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("dob")%>' CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:LoginView ID="LoginView_AddButton" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                                <ContentTemplate>
                                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary line" Text="Update" ToolTip="Update" />
                                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default line" Text="Cancel" ToolTip="Cancel" />
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>
                </td>


        </EditItemTemplate>

        <InsertItemTemplate>
            <tr class="rlvIEdit">
                <td></td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("title")%>' CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("contactName")%>' CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("contactPhone")%>' CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("contactEmail")%>' CssClass="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="emailValidator" runat="server" Display="Dynamic"
                        ErrorMessage="Please enter valid e-mail address" ValidationExpression="^[\w\.\-]+@[a-zA-Z0-9\-]+(\.[a-zA-Z0-9\-]{1,})*(\.[a-zA-Z]{2,3}){1,2}$"
                        ControlToValidate="TextBox5">
                    </asp:RegularExpressionValidator>
                </td>

                <td>
                    <telerik:RadDateInput ID="DOBTextBox" runat="server" Text='<%# Bind("dob")%>' DateFormat="d" CssClass="form-control"></telerik:RadDateInput>


                </td>
                <td>
                    <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                </td>
        </InsertItemTemplate>


        <EmptyDataTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Title</th>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>D.O.B</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="7">
                                <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Contact</strong> button above.</div>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <asp:LoginView ID="LoginView_AddButton" runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                                    <ContentTemplate>
                                        <asp:LinkButton ID="btnInsert1" runat="server" CommandName="InitInsert"
                                            CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New Contact</asp:LinkButton>
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

    <asp:LinqDataSource ID="getContacts" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" OrderBy="contactName"
        TableName="tblAccountContacts" Where="accountID == @accountID">
        <WhereParameters>
            <asp:QueryStringParameter Name="accountID" QueryStringField="AccountID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

</telerik:RadAjaxPanel>
