<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="VendorInformationControl.ascx.vb" Inherits="EventManagerApplication.VendorInformationControl" %>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <asp:FormView ID="FormView1" runat="server" DataKeyNames="itemID" DataSourceID="getInventoryItemVendorInformation" DefaultMode="Edit" Width="100%">
        <EditItemTemplate>

            <div class="col-sm-12">

            <div class="form-horizontal">

                <div style="margin: 12px 0 12px 0">
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-primary btn-sm" />
                </div>
                <hr />

                <div class="form-group">
                    <label for="ItemTextBox" class="col-sm-3 control-label">Vendor Source (URL):</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="vendorURLTextBox" runat="server" CssClass="form-control" Text='<%# Bind("vendorURL") %>' />
                    </div>
                </div>

                <div class="form-group">
                    <label for="ItemTextBox" class="col-sm-3 control-label">Product ID:</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="productIDTextBox" runat="server" Text='<%# Bind("productID") %>' CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="ItemTextBox" class="col-sm-3 control-label">Wholesale Cost Per Unit:</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="costPerUnitTextBox" runat="server" Text='<%# Bind("costPerUnit") %>' CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="ItemTextBox" class="col-sm-3 control-label">Package/Shipping Size:</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="packageShippingSizeTextBox" runat="server" Text='<%# Bind("packageShippingSize") %>' CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="ItemTextBox" class="col-sm-3 control-label">Package/Shipping Weight:</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="packageShippingWeightTextBox" runat="server" Text='<%# Bind("packageShippingWeight") %>' CssClass="form-control" />
                    </div>
                </div>

            </div>

                </div>

        </EditItemTemplate>

    </asp:FormView>

    <asp:LinqDataSource ID="getInventoryItemVendorInformation" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableUpdate="True" EntityTypeName="" TableName="tblInventoryItems" Where="itemID == @itemID">
        <WhereParameters>
            <asp:QueryStringParameter Name="itemID" QueryStringField="ItemID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

</telerik:RadAjaxPanel>

