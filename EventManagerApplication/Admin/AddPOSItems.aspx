<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AddPOSItems.aspx.vb" Inherits="EventManagerApplication.AddPOSItems" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="../Theme/css/custom1.css" rel="stylesheet" />

    <title></title>

    <script type="text/javascript">
            function CloseAndRebind(args)
            {
                GetRadWindow().BrowserWindow.refreshGrid(args);
                GetRadWindow().close();
            }
 
            function GetRadWindow()
            {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)
 
                return oWindow;
            }
 
            function CancelEdit()
            {
                GetRadWindow().close();
            }
        </script>

    <style>
        html {
            overflow: hidden !important;
        }
               

    </style>

</head>
<body>
    <form id="form1" runat="server">

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel2" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"
        IsSticky="true" Style="position: absolute; top: 0; left: 0; height: 100%; width: 100%;">
    </telerik:RadAjaxLoadingPanel>

        <asp:Panel runat="server" ID="Panel2">
        <asp:ScriptManager ID="ScriptManager2" runat="server">
            <Scripts>
                <%--To learn more about bundling scripts in ScriptManager see http://go.microsoft.com/fwlink/?LinkID=301884 --%>
                <%--Framework Scripts--%>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="jquery" />
                <asp:ScriptReference Name="bootstrap" />
                <asp:ScriptReference Name="respond" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
                <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" />
                <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" />
                <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" />
                <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" />
                <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" />
                <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" />
                <asp:ScriptReference Name="WebFormsBundle" />
                <%--Site Scripts--%>
            </Scripts>
        </asp:ScriptManager> 

    <div class="container">

<%--        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">--%>

            <div class="row">
                <div class="col-md-12">

                    <div style="margin: 0 0 15px 0">
                        <h2>New POS Item: <asp:Label ID="txtBrandName" runat="server" /></h2>
                        <p>Use this form to add a new item.  Complete each sections below and click on the Next button to continue to the next tab.
                            <br />
                        Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                        </p>
                    </div>

                    <asp:Label ID="msgLabel" runat="server" />

                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

                    <div class="widget stacked">
                        <div class="widget-content">



                            <telerik:RadWizard ID="AddItemWizard" runat="server" DisplayCancelButton="true" DisplayProgressBar="false" Skin="Bootstrap">
                                
                                <WizardSteps>

                                    <telerik:RadWizardStep Title="Default Information" ValidationGroup="default1" CausesValidation="true">

                                        <div class="col-md-12">
                                            
                                            <div class="form-horizontal">

                                               
                                                <div class="form-group">
                                                    <label for="txtBrandName" class="col-sm-3 control-label">Add this item to the Brand Group?<span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">

                                                        <asp:RadioButtonList  ID="ckbxInGroup" runat="server">
                                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                            <asp:ListItem Text="No" Value="False" Selected="True"></asp:ListItem>
                                                        </asp:RadioButtonList>

                                                       <%-- <asp:CustomValidator ID="CustomValidator1" ErrorMessage="Please select either Yes or No."
                                                            CssClass="errorlabel" ClientValidationFunction="ValidateCheckBoxList" runat="server" ValidationGroup="default" />--%>


                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="SupplierComboBox" class="col-sm-3 control-label">Supplier:<span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">
                                                        <telerik:RadComboBox ID="SupplierComboBox" runat="server" DataSourceID="GetSuppliersList" DataTextField="supplierName" DataValueField="supplierID" AutoPostBack="true" Width="250px" AllowCustomText="true" MarkFirstMatch="true" EmptyMessage="Select a Supplier"></telerik:RadComboBox>

                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" InitialValue="" ControlToValidate="SupplierComboBox" ValidationGroup="default1" ErrorMessage="Please select a supplier" CssClass="errorlabel" />

                                                        <%--<asp:LinqDataSource runat="server" EntityTypeName="" ID="GetSupplierList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="supplierName" TableName="tblSuppliers">
                                                        </asp:LinqDataSource>--%>

                                                        <asp:SqlDataSource ID="GetSuppliersList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetSuppliersByUserIDandClientID" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                                        <asp:SessionParameter SessionField="CurrentClientID" Name="clientID" Type="Int32"></asp:SessionParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>


                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="BrandComboBox" class="col-sm-3 control-label">Brand:<span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">
                                                        <telerik:RadComboBox ID="BrandComboBox" runat="server" DataTextField="brandName" DataValueField="brandID" Width="250px" AllowCustomText="true" MarkFirstMatch="true" EmptyMessage="Select a Brand"></telerik:RadComboBox>

                                                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" InitialValue="" ControlToValidate="BrandComboBox" ValidationGroup="default1" ErrorMessage="Please select a brand" CssClass="errorlabel" />
                                                </div>
                                                </div>


                                                <div class="form-group">
                                                    <label for="ItemNameTextBox" class="col-sm-3 control-label">Item Name:<span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="ItemNameTextBox" runat="server" CssClass="form-control" ValidationGroup="default1" />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                        ErrorMessage="Item Name is required." CssClass="errorlabel" ControlToValidate="ItemNameTextBox"
                                                        Display="Dynamic" ValidationGroup="default1"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="RetailPriceTextBox" class="col-sm-3 control-label">Retail Price/Unit:<span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">

                                                        <telerik:RadNumericTextBox ID="RetailPriceTextBox" runat="server" Culture="en-US" Value="0" DbValueFactor="1" LabelWidth="64px" Type="Currency" Width="160px" EmptyMessage="Enter unit Price.">
                                                            <NumberFormat ZeroPattern="$n"></NumberFormat>
                                                        </telerik:RadNumericTextBox>

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                        ErrorMessage="Price is required." CssClass="errorlabel" ControlToValidate="RetailPriceTextBox" ValidationGroup="default1"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="PackageSizeTextBox" class="col-sm-3 control-label">Package Size:</label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="PackageSizeTextBox" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="HowManyUnitsTextBox" class="col-sm-3 control-label">How many units should be shipped in a kit?<span class="text-danger">*</span>
                                                    </label>
                                                    <div class="col-sm-9">
                                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="HowManyUnitsTextBoxRadNumericTextBox" Width="160px" EmptyMessage="Enter unit quantity." MinValue="0" ShowSpinButtons="true" Value="1" NumberFormat-DecimalDigits="0" Height="35px"></telerik:RadNumericTextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                        ErrorMessage="Units in a kit is required." CssClass="errorlabel" ControlToValidate="HowManyUnitsTextBoxRadNumericTextBox"
                                                        Display="Dynamic" ValidationGroup="default1"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                
                                            </div>
                                            <!-- End Form -->

                                            
                                        </div>

                                    </telerik:RadWizardStep>

                                    
                                    <telerik:RadWizardStep Title="Inventory Information" ValidationGroup="inventory">

                                        <div class="col-md-12">
                                            <div class="form-horizontal">

                                            <div class="form-group">
                                                    <label for="CheckBoxes" class="col-sm-3 control-label">How will this product be used?:</label>

                                                    <div class="col-sm-9">
                                                        <asp:CheckBox ID="OffPremiseKitCheckBox" runat="server" Text="Off-Premise Kit"  /><br />
                                                        <asp:CheckBox ID="OnPremiseKitCheckBox" runat="server" Text="On-Premise Kit"  /><br />
                                                        <asp:CheckBox ID="AccountPlacementCheckBox" runat="server" Text="Account Placement"  /><br />
                                                        <asp:CheckBox ID="ConsumerGiveawayCheckBox" runat="server" Text="Consumer Giveaway" /><br />
                                                        <asp:CheckBox ID="TradeAccountGiftCheckBox" runat="server" Text="Trade/Account Gift"  /><br />
                                                    </div>

                                                </div>

                                                <div class="form-group">
                                                    <label for="YesCheckBox" class="col-sm-3 control-label">Does this item need to be returned to inventory?</label>
                                                    <div class="col-sm-3">
                                                        <asp:CheckBox ID="YesCheckBox" runat="server" Text="Yes"  />
                                                    </div>
                                                </div>

                                       
                                            <div class="form-group">
                                             <label for="countInvertory" class="col-sm-3 control-label">Image:</label>
                                            <div class="col-sm-4">
                                                <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MultipleFileSelection="Disabled" MaxFileInputsCount="1">
                                                </telerik:RadAsyncUpload>
                                            </div>
                                                </div>

                                            <div class="form-group">
                                            <label for="countInvertory" class="col-sm-3 control-label">Current Inventory:<span class="text-danger">*</span></label>
                                            <div class="col-sm-3">                                                
                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="countInvertoryTextBoxRadNumericTextBox" Width="160px" Value="0" MinValue="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" Height="35px"></telerik:RadNumericTextBox>

                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                        ErrorMessage="Current Inventory is required." CssClass="errorlabel" ControlToValidate="countInvertoryTextBoxRadNumericTextBox"
                                                        Display="Dynamic" ValidationGroup="inventory"></asp:RequiredFieldValidator>

                                            </div>
                                                </div>
                                                                                 

                                            </div>
                                        </div>

                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Vendor Information" ValidationGroup="vendor">
                                        
                                            <div class="form-horizontal">
                                                <div class="col-md-12">

                                                <div class="form-group">
                                                    <label for="vendorURLTextBox" class="col-sm-3 control-label">Vendor Source (URL):</label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="vendorURLTextBox" runat="server" CssClass="form-control"  />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="productIDTextBox" class="col-sm-3 control-label">Product ID:</label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="productIDTextBox" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="costPerUnitTextBox" class="col-sm-3 control-label">Wholesale Cost Per Unit:</label>
                                                    <div class="col-sm-4">                                                        
                                                        <telerik:RadNumericTextBox ID="costPerUnitTextBoxRadNumericTextBox" runat="server" Culture="en-US" DbValueFactor="1" LabelWidth="64px" Type="Currency" Width="160px" EmptyMessage="Enter units count.">
                                                            <NumberFormat ZeroPattern="$n"></NumberFormat>
                                                        </telerik:RadNumericTextBox>
                                                </div>                                                                                                                        </div>                          


                                                <div class="form-group">
                                                    <label for="packageShippingSizeTextBox" class="col-sm-3 control-label">Package/Shipping Size:</label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="packageShippingSizeTextBox" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="packageShippingWeightTextBox" class="col-sm-3 control-label">Package/Shipping Weight:</label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="packageShippingWeightTextBox" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>

                                            

                                                    </div>

                                        </div>
                                           
                                    </telerik:RadWizardStep>

                                </WizardSteps>

                            </telerik:RadWizard>



                             <asp:LinqDataSource ID="getInventoryItem" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblInventoryItems">
       
    </asp:LinqDataSource>
                        </div>
                    </div>


                </div>
            </div>

    <%--    </telerik:RadAjaxPanel>--%>

    </div>

           
    </asp:Panel>

        <script type="text/javascript">

    function ValidateCheckBoxList(sender, args) {

        var checkBoxList = document.getElementById("<%=ckbxInGroup.ClientID %>");
        var checkboxes = checkBoxList.getElementsByTagName("input");
        var isValid = false;

        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                isValid = true;
                break;
            }
        }

        args.IsValid = isValid;
   }

</script>


    </form>
</body>
</html>
