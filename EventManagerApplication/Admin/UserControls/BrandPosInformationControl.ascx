<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandPosInformationControl.ascx.vb" Inherits="EventManagerApplication.BrandPosInformationControl" %>


<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

     <div class="col-sm-12">
         <h3>Information</h3>
        <div class="form-horizontal">

            <div class="form-group">
                <label for="SupplierNameTextBox" class="col-sm-2 control-label">Item Name:</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
  
                </div>
            </div>

            <div class="form-group">
                <label for="SupplierNameTextBox" class="col-sm-2 control-label">Retail Price/Unit:</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
  
                </div>
            </div>

            <div class="form-group">
                <label for="SupplierNameTextBox" class="col-sm-2 control-label">Package Size:</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control"></asp:TextBox>
  
                </div>
            </div>

            <div class="form-group">
                <label for="SupplierNameTextBox" class="col-sm-2 control-label">How many units should be shipped in a kit?:</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control"></asp:TextBox>
  
                </div>
            </div>

            <div class="form-group">
                <label for="SupplierNameTextBox" class="col-sm-2 control-label">Product Photo:</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control"></asp:TextBox>
  
                </div>
            </div>

</div>
         </div>

</telerik:RadAjaxPanel>
