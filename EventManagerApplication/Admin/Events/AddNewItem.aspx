<%@ Page Title="Add New POS Item" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AddNewItem.aspx.vb" Inherits="EventManagerApplication.AddNewItem" %>

<%@ Register Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" TagPrefix="CuteWebUI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .uploadergrid {
           display: none !important;
       }

    .AjaxUploaderCancelAllButton {
           display: none !important;
       }

        .form-group {
            margin-bottom: 10px;
        }

        input[type="checkbox"], input[type="radio"] {
            margin: 4px 10px 0;
            line-height: normal;
        }

        .form-horizontal .control-label {
            padding-top: 0;
            margin-bottom: 0;
            text-align: right;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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

                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>

                    <div class="widget stacked">
                        <div class="widget-content">



                            <telerik:RadWizard ID="AddItemWizard" runat="server" DisplayCancelButton="true" DisplayProgressBar="false" Skin="Bootstrap">

                                <WizardSteps>

                                    <telerik:RadWizardStep Title="Default Information" ValidationGroup="default">

                                        <div class="col-md-12">

                                            <div class="form-horizontal">

                                                <asp:Panel ID="AddtoGroupPanel" runat="server">
                                                <div class="form-group">
                                                    <label for="txtBrandName" class="col-sm-3 control-label">Add this item to the Brand Group?<span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">

                                                        <asp:RadioButtonList  ID="ckbxInGroup" runat="server">
                                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                            <asp:ListItem Text="No" Value="False" Selected="True"></asp:ListItem>
                                                        </asp:RadioButtonList>

                                                        <asp:CustomValidator ID="CustomValidator1" ErrorMessage="Please select either Yes or No."
                                                            CssClass="errorlabel" ClientValidationFunction="ValidateCheckBoxList" runat="server" ValidationGroup="default" />


                                                    </div>
                                                </div>
                                                </asp:Panel>

                                                <div class="form-group">
                                                    <label for="ItemNameTextBox" class="col-sm-3 control-label">Item Name:<span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="ItemNameTextBox" runat="server" CssClass="form-control"  />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                        ErrorMessage="Item Name is required." CssClass="errorlabel" ControlToValidate="ItemNameTextBox"
                                                        Display="Dynamic" ValidationGroup="default"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="RetailPriceTextBox" class="col-sm-3 control-label">Retail Price/Unit:<span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">
                                                        <telerik:RadNumericTextBox ID="RetailPriceTextBox" runat="server" Culture="en-US" DbValueFactor="1" LabelWidth="64px" Type="Currency" Width="160px" EmptyMessage="Enter units count.">
                                                            <NumberFormat ZeroPattern="$n"></NumberFormat>
                                                        </telerik:RadNumericTextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                        ErrorMessage="Price is required." CssClass="errorlabel" ControlToValidate="RetailPriceTextBox" ValidationGroup="default"></asp:RequiredFieldValidator>
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
                                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="HowManyUnitsTextBoxRadNumericTextBox" Width="160px" EmptyMessage="Enter units count." MinValue="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0"></telerik:RadNumericTextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                        ErrorMessage="Units in a kit is required." CssClass="errorlabel" ControlToValidate="HowManyUnitsTextBoxRadNumericTextBox"
                                                        Display="Dynamic" ValidationGroup="default"></asp:RequiredFieldValidator>
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
                                                <%--<telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MultipleFileSelection="Disabled" MaxFileInputsCount="1">
                                                </telerik:RadAsyncUpload>--%>


                            <asp:Panel ID="PhotoPanel" runat="server" Visible="false">
                                <asp:Image ID="Image1" runat="server" Width="37%" Height="37%" ImageAlign="Middle" />
                            </asp:Panel>

                            <asp:Label ID="lblPath" runat="server" Visible="false"></asp:Label>

                            <CuteWebUI:UploadAttachments ID="UploadAttachments1" OnFileUploaded="UploadAttachments1_Photo" runat="server" InsertButtonStyle-CssClass="btn btn-default" InsertText="Select Image" CancelAllMsg=" " MultipleFilesUpload="False" ShowProgressBar="false" ShowProgressInfo="false" CancelButtonStyle-CssClass="uploadergrid" UploadingMsg=" ">
                                <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="4168" />
                            </CuteWebUI:UploadAttachments>

                                            </div>
                                                </div>

                                            <div class="form-group">
                                            <label for="countInvertory" class="col-sm-3 control-label">Current Inventory:</label>
                                            <div class="col-sm-3">
                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="countInvertoryTextBoxRadNumericTextBox" Width="160px" MinValue="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" Value="0"></telerik:RadNumericTextBox>
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

</asp:Content>
