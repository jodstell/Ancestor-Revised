<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AddInventoyControl.ascx.vb" Inherits="EventManagerApplication.AddInventoyControl" %>


<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <asp:Panel ID="UpdateInventoryPanel" runat="server" Visible="false">
        <div class="col-sm-12">

            <h3>Update Inventory Count</h3>

            <div class="form-horizontal">

                <div>
                    <asp:Button ID="btnSubmitInventory" runat="server" Text="Submit" CssClass="btn btn-sm btn-primary" />
                    <asp:Button ID="btnCancelUpdateInventory" runat="server" Text="Cancel" CssClass="btn btn-sm btn-default" />
                </div>

                <div class="form-group">
                    <label for="ItemTextBox" class="col-sm-3 control-label">Brand Name:</label>
                    <div class="col-sm-6">
                        <asp:Label ID="BrandNameLabel2" runat="server" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="ItemTextBox" class="col-sm-3 control-label">Item Name:</label>
                    <div class="col-sm-6">
                        <asp:Label ID="ItemNameLabel2" runat="server" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="NewInventoryCountTextBox" class="col-sm-3 control-label">New Inventory Count</label>
                    <div class="col-md-6">

                        <telerik:RadNumericTextBox ID="NewInventoryCountTextBox" Type="Number" runat="server"  Skin="Bootstrap" Width="100px" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" MinValue="0" Value="0"></telerik:RadNumericTextBox>

                    </div>
                </div>
              
              
                <div class="form-group">
                    <label for="NotesTextBox" class="col-sm-3 control-label">Notes</label>
                    <div class="col-md-7">
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                    </div>
                </div>

                </div>
        </div>

    </asp:Panel>



    <asp:Panel ID="AddNewPanel" runat="server" Visible="false">
        <div class="col-sm-12">

            <h3>Receive Inventory Item</h3>

            <div class="form-horizontal">

                <div>
                    <asp:Button ID="btnSave" runat="server" Text="Submit" CssClass="btn btn-sm btn-primary" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-sm btn-default" />
                </div>

                <div class="form-group">
                    <label for="ItemTextBox" class="col-sm-3 control-label">Brand Name:</label>
                    <div class="col-sm-6">
                        <asp:Label ID="BrandNameLabel" runat="server" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="ItemTextBox" class="col-sm-3 control-label">Item Name:</label>
                    <div class="col-sm-6">
                        <asp:Label ID="ItemNameLabel" runat="server" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="ItemTextBox" class="col-sm-3 control-label">Shipment Received Date:</label>
                    <div class="col-sm-6">
                        <telerik:RadDatePicker ID="RecievedDateTextBox" runat="server"></telerik:RadDatePicker>
                    </div>
                </div>

                <div class="form-group">
                    <label for="ItemTextBox" class="col-sm-3 control-label">Quantity Received:</label>
                    <div class="col-sm-6">
                        <telerik:RadNumericTextBox ID="QtyTextBox" Type="Number" runat="server" Skin="Bootstrap" Width="100px" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="NotesTextBox" class="col-sm-3 control-label">Notes</label>
                    <div class="col-md-7">
                        <asp:TextBox ID="NotesTextBox" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                    </div>
                </div>


            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="ViewPanel" runat="server">

        <div class="col-md-12">
            Item Name:
            <asp:Label ID="ItemTitleLabel" runat="server" Font-Bold="true" /><br />
            Quantity On-Hand:
            <asp:Label ID="BalanceLabel" runat="server" Font-Bold="true" />

        </div>

        <div class="btn-group pull-right">
            <asp:Button ID="btnAdd" runat="server" Text="Receive Inventory" CssClass="btn btn-sm btn-success" />
            <asp:LinkButton ID="btnUpdateCount" runat="server" CssClass="btn btn-sm btn-default">Update Inventory Count</asp:LinkButton>

            <hr />
        </div>


        <div class="col-md-12">
            <asp:Repeater ID="InventoryList" runat="server" DataSourceID="getInventoryList">
                <HeaderTemplate>
                    <table class="table" cellspacing="0" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Action</th>
                                <th>Quantity</th>
                                <th>Location/Market</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr class="rlvI">
                        <td><%# Eval("date", "{0:MMMM d, yyyy}")%></td>
                        <td><%# Eval("action")%></td>
                        <td><%# Eval("quantity")%></td>
                        <td><%# Eval("location")%></td>

                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <asp:LinqDataSource ID="getInventoryList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="date desc" TableName="qryInventoryLists" Where="brandID == @brandID && itemID == @itemID">
                <WhereParameters>
                    <asp:QueryStringParameter Name="brandID" QueryStringField="BrandID" Type="Int32" />
                    <asp:QueryStringParameter QueryStringField="ItemID" Name="itemID" Type="Int32"></asp:QueryStringParameter>
                </WhereParameters>
            </asp:LinqDataSource>
        </div>

    </asp:Panel>
</telerik:RadAjaxPanel>
