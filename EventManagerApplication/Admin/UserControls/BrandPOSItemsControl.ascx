<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandPOSItemsControl.ascx.vb" Inherits="EventManagerApplication.BrandPOSItemsControl" %>

<div style="min-height:400px">
<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <asp:Panel runat="server" ID="BrandPOSListPanel">
    <telerik:RadListView ID="BrandPOSList" runat="server"
        DataKeyNames="itemID" DataSourceID="getInventoryList" InsertItemPosition="LastItem">
        <LayoutTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width:100%;">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Item Name</th>
                            <th>Group Item</th>
                            <th>Retail Price</th>
                            <th>Package Size</th>
                            <th>Quantity On Hand</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </tbody>
                    <tfoot>
                         <asp:LinkButton ID="btnAddNew" runat="server" CommandName="AddNewItem" Visible="<%# Not Container.IsItemInserted %>"
                          CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Item</asp:LinkButton>
                    </tfoot>
                </table>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <tr class="rlvI">
                <td>
                    <div class="btn-group" role="group" aria-label="...">
                    <a href="/admin/events/editpositem?ClientID=<%#Request.QueryString("ClientID")%>&BrandID=<%#Request.QueryString("BrandID")%>&ItemID=<%#(Eval("itemID"))%>" class="btn btn-default btn-sm"><i class="fa fa-pencil"></i>  Edit</a>
                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-sm btn-danger" ToolTip="Delete"
                        OnClientClick="javascript:if(!confirm('This action will delete the selected inventory item and history. Are you sure?')){return false;}">
                        <i class="fa fa-trash"></i>   Delete</asp:LinkButton>
                    </div>
                </td>

                <td>
                    <asp:Label ID="itemNameLabel" runat="server" Text='<%#Eval("itemName")%>' />
                </td>

                <td>
                    <asp:CheckBox ID="retailPriceCheckBox" runat="server" Checked='<%#Eval("inGroup")%>' Enabled="false" />
                </td>

                <td>
                    <asp:Label ID="retailPriceLabel" runat="server" Text='<%# Eval("retailPrice")%>' />
                </td>
                <td>
                    <asp:Label ID="packageSizeLabel" runat="server" Text='<%# Eval("packageSize")%>' />
                </td>

                <td>
                    <asp:Label ID="Label1" runat="server" Text='<%# getOnHandQuantity(Eval("itemID"))%>' />
                </td>

            </tr>
        </ItemTemplate>




        <EmptyDataTemplate>
            <div class="RadListView RadListView_Default">
                 <table class="table" cellspacing="0" style="width:100%;">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Item Name</th>
                            <th>Group Item</th>
                            <th>Retail Price</th>
                            <th>Package Size</th>
                            <th>Quantity On Hand</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6">
                                <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Item</strong> button above.</div>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                         <%--<asp:Button ID="btnInsert1" runat="server" CommandName="AddNewItem" Visible="<%# Not Container.IsItemInserted %>"
                          Text="Add New Item" CssClass="btn btn-xs btn-primary pull-right"></asp:Button>--%>
                         <asp:LinkButton ID="btnAddNew" runat="server" CommandName="AddNewItem" Visible="<%# Not Container.IsItemInserted %>"
                          CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Item</asp:LinkButton>
                    </tfoot>
                </table>


            </div>
        </EmptyDataTemplate>

    </telerik:RadListView>

    <asp:HiddenField ID="HiddenBrandGroupID" runat="server" />
</asp:Panel>

    <asp:LinqDataSource ID="getPOSItems" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="itemName" TableName="tblInventoryItems" Where="brandID == @brandID" EnableDelete="True">
        <WhereParameters>
            <asp:SessionParameter DbType="Int32" Name="brandID" SessionField="SelectedBrandID" />
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:SqlDataSource ID="getInventoryList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="ViewInventoryItemListByBrand" SelectCommandType="StoredProcedure" DeleteCommand="DELETE FROM tblInventoryItem WHERE (itemID = @itemID)" UpdateCommand="UPDATE tblInventoryItem SET itemName = @itemName, retailPrice = @retailPrice WHERE (itemID = @itemID)">
        <DeleteParameters>
            <asp:Parameter Name="itemID"></asp:Parameter>
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenBrandGroupID" PropertyName="Value" Name="brandGroupID" Type="Int32"></asp:ControlParameter>
           <asp:SessionParameter DbType="Int32" Name="brandID" SessionField="SelectedBrandID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="itemName"></asp:Parameter>
            <asp:Parameter Name="retailPrice"></asp:Parameter>
            <asp:Parameter Name="itemID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

</telerik:RadAjaxPanel>
</div>


<telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Text="Your changes were updated successfully!" Title="Success" TitleIcon="info"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>
