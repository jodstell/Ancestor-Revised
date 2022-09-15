<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EventNoteControl.ascx.vb" Inherits="EventManagerApplication.EventNoteControl" %>




<asp:Panel runat="server" ID="NotesPanel" >

    <telerik:RadListView ID="NoteList" runat="server"
        DataKeyNames="eventID" DataSourceID="getNotes" InsertItemPosition="FirstItem">
        <LayoutTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width:100%;">
                    
                    <tbody>
                        <tr></tr>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </tbody>
                    <tfoot>                         
                        <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-xs btn-success pull-right" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"><i class="fa fa-plus"></i>  Add New Note</asp:LinkButton>
                    </tfoot>
                </table>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <tr class="rlvI">
                <td><asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-xs btn-primary" Text="Edit" ToolTip="Edit" /></td>
                <td><asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note")%>' />

                    <div class="notefooter">
                        Created by: <asp:Label ID="dateLabel" runat="server" Text='<%# getFullName(Eval("createdBy"))%>' /> on <asp:Label ID="byLabel" runat="server" Text='<%# Eval("dateCreated", "{0:f}")%>' />
                    </div>

                </td>
                <td><asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" Text="Delete" ToolTip="Delete" /></td>
            </tr>
        </ItemTemplate>

        <EditItemTemplate>
            <tr class="rlvIEdit">
                <td>
                    </td>
                <td><asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("note")%>' CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox></td>
                <td> 
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Update" ToolTip="Update" />
                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />                
                </td>
                

         </EditItemTemplate>

        <InsertItemTemplate>
            <tr class="rlvIEdit">
                <td>
                    </td>
                <td><asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("note")%>' CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox></td>
                <td> 
                    <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                </td>
            </InsertItemTemplate>
        
       
        <EmptyDataTemplate>
            <div class="RadListView RadListView_Default">
                 <table class="table" cellspacing="0" style="width:100%;">
                   
                    <tbody>
                        <tr>
                            <td colspan="7">
                                <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Note</strong> button above.</div>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-xs btn-success pull-right" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"><i class="fa fa-plus"></i>  Add New Note</asp:LinkButton>
                    </tfoot>
                </table>
            </div>
        </EmptyDataTemplate>
        
    </telerik:RadListView>


    <asp:LinqDataSource ID="getNotes" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" OrderBy="dateCreated"
        TableName="tblEventNotes" Where="eventID == @eventID">
        <WhereParameters>
            <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
  
</asp:Panel>