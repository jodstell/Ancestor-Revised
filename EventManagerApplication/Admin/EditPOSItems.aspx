<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditPOSItems.aspx.vb" Inherits="EventManagerApplication.EditPOSItems1" %>

<%@ Register Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" TagPrefix="CuteWebUI" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="../Theme/css/custom1.css" rel="stylesheet" />
    <link href="/theme/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />

    <style>
        html {
            overflow: hidden !important;
        }

        .uploadergrid {
           display: none !important;
       }

    .AjaxUploaderCancelAllButton {
           display: none !important;
       }
    </style>

    <title></title>
</head>
<body>
    <form id="form1" runat="server">

             
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


        <asp:ScriptManager ID="ScriptManager2" runat="server" />       
        
        <div class="container">
                            <div class="row" style="margin: 30px;">

                                <div class="col-md-8">

                                        <asp:Panel ID="AddtoGroupPanel" runat="server">
                                            <div class="form-horizontal" style="margin-top: 10px;">
                                                
                                            </div>
                                        </asp:Panel>


                                            <asp:FormView ID="InventoryItemForm" runat="server" DataKeyNames="itemID" DataSourceID="getInventoryList2" DefaultMode="Edit" Width="100%">
                                            <EditItemTemplate>
                                                <div class="form-horizontal">


                                                    <div class="form-group">
                                                    <label for="txtBrandName" class="col-sm-5 control-label">Add this item to the Brand Group?</label>
                                                    <div class="col-sm-6" style="padding-left: 5px;">

                                                        <asp:RadioButtonList  ID="ckbxInGroup" runat="server" selectedValue='<%# Bind("inGroup") %>'>
                                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                        
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-5 control-label">Item Name:</label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="ItemNameTextBox" runat="server" CssClass="form-control" Text='<%# Bind("itemName") %>' />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-5 control-label">Retail Price/Unit:</label>
                                                    <div class="col-sm-6">
                                                        <div class="input-group col-sm-6">
                                                            <span class="input-group-addon" id="basic-addon1">$</span>
                                                           <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Text='<%# Bind("retailPrice") %>' />
                                                            <%--<telerik:RadNumericTextBox ID="RetailPriceTextBox" runat="server" Culture="en-US" Type="Currency" DisplayText='<%# Bind("retailPrice") %>' CssClass="form-control"></telerik:RadNumericTextBox>--%>
                                                                   </div>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-5 control-label">Package Size:</label>
                                                    <div class="col-sm-6">
                                                       <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Text='<%# Bind("packageSize") %>' />        
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-5 control-label">How many units should be shipped in a kit?:</label>
                                                    <div class="col-sm-3">
                                                       <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" Text='<%# Bind("unitsInKit") %>' Width="150px" />
                                                       <%-- <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="RadNumericTextBox2" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" DisplayText='<%# Bind("unitsInKit") %>' Width="150px"></telerik:RadNumericTextBox>--%>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-5 control-label">How will this product be used?:</label>
                                                    <div class="col-sm-7">
                                                        <asp:CheckBox ID="CheckBox2" runat="server" Text="Off-Premise Kit" Checked='<%# Bind("offPremiseKit") %>' /><br />
                                                        <asp:CheckBox ID="CheckBox3" runat="server" Text="On-Premise Kit" Checked='<%# Bind("onPremiseKit") %>' /><br />
                                                        <asp:CheckBox ID="CheckBox4" runat="server" Text="Account Placement" Checked='<%# Bind("accountPlacement") %>' /><br />
                                                        <asp:CheckBox ID="CheckBox5" runat="server" Text="Consumer Giveaway" Checked='<%# Bind("giveaway") %>' /><br />
                                                        <asp:CheckBox ID="CheckBox6" runat="server" Text="Trade/Account Gift" Checked='<%# Bind("accountGift") %>' /><br />

                                                        
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-5 control-label">Does this item need to be returned to inventory?:</label>
                                                    <div class="col-sm-7">
                                                        <asp:CheckBox ID="CheckBox1" runat="server" Text="Yes" Checked='<%# Bind("returnToInventory") %>' />
                                                    </div>
                                                </div>
                                                </div>
                                            </EditItemTemplate>

                                        </asp:FormView>
                                                                                  

                                </div>


                                <div class="col-md-4">
                                    <h3>Product Photo</h3>


                                    <div class="col-xs-12 col-md-12">

                                         <asp:Repeater ID="headshot" runat="server" DataSourceID="getImage">
                                                    <ItemTemplate>
                                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail"
                                                            DataValue='<%#IIf(TypeOf (Eval("image")) Is DBNull, Nothing, Eval("image"))%>'
                                                            Height="200px" Width="200px" ResizeMode="Fit" />
                                                    </ItemTemplate>
                                                </asp:Repeater>

                                    <asp:Panel ID="PhotoPanel" runat="server" Visible="false">
                                        <asp:Image ID="Image1" runat="server" Width="55%" Height="55%" ImageAlign="Middle" />
                                    </asp:Panel>
                   
                                    <asp:Label ID="lblInfoPhoto" runat="server" Visible="false">
                                    <span class="help-block"><strong style="font-size: 13px;">Click the Update button to save the photo.</strong></span>
                                    </asp:Label>

                                                <asp:SqlDataSource runat="server" ID="getImage" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [image] FROM [tblInventoryItem] WHERE ([itemID] = @itemID)">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter QueryStringField="ItemID" Name="itemID" Type="String"></asp:QueryStringParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>

                                        
                                    </div>

                                    <div class="col-xs-12 col-md-12" style="right: 10%;">
                                        <div class="col-md-6">
                                            <div>
                                                <%--<telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MultipleFileSelection="Disabled" MaxFileInputsCount="1" HideFileInput="true"></telerik:RadAsyncUpload>--%>


                            <asp:Label ID="lblPath" runat="server" Visible="false"></asp:Label>

                    <CuteWebUI:UploadAttachments ID="UploadAttachments1" OnFileUploaded="UploadAttachments1_Photo" runat="server" InsertButtonStyle-CssClass="btn btn-default" InsertText="Select Image" CancelAllMsg=" " MultipleFilesUpload="False" ShowProgressBar="false" ShowProgressInfo="false" CancelButtonStyle-CssClass="uploadergrid" UploadingMsg=" ">
                        <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="4168" />
                    </CuteWebUI:UploadAttachments>

                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div>

                                                <asp:HyperLink ID="btnDownload" runat="server" CssClass="btn btn-default"><i class="fa fa-download fa-1x bin"></i> Download Image</asp:HyperLink>

                                            </div>
                                        </div>
                                    </div>


                                </div>

                            </div>
        </div>
        <div class="pull-right" style="margin: 12px 12px 12px 12px">
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary btn-sm" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default btn-sm" />
                            </div>


        <asp:SqlDataSource runat="server" ID="getInventoryList2" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [qryGetInventoryList] WHERE ([itemID] = @itemID)" InsertCommand="INSERT INTO [qryGetInventoryList] ([thumbnail], [itemName], [Brand], [retailPrice], [packageSize], [unitsInKit], [QtyOnHand]) VALUES (@thumbnail, @itemName, @Brand, @retailPrice, @packageSize, @unitsInKit, @QtyOnHand)" UpdateCommand="UPDATE tblInventoryItem SET itemName = @itemName, retailPrice = @retailPrice, inGroup = @inGroup, offPremiseKit = @offPremiseKit, onPremiseKit = @onPremiseKit, accountPlacement = @accountPlacement, giveaway = @giveaway, accountGift = @accountGift, returnToInventory = @returnToInventory WHERE (itemID = @itemID)">
            <InsertParameters>
                <asp:Parameter Name="thumbnail" Type="Object"></asp:Parameter>
                <asp:Parameter Name="itemName" Type="String"></asp:Parameter>
                <asp:Parameter Name="Brand" Type="String"></asp:Parameter>
                <asp:Parameter Name="retailPrice" Type="Decimal"></asp:Parameter>
                <asp:Parameter Name="packageSize" Type="String"></asp:Parameter>
                <asp:Parameter Name="unitsInKit" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="QtyOnHand" Type="String"></asp:Parameter>
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="itemID" Name="itemID" Type="Int32"></asp:QueryStringParameter>
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="itemName"></asp:Parameter>
                <asp:Parameter Name="retailPrice"></asp:Parameter>
                <asp:Parameter Name="itemID"></asp:Parameter>
                <asp:Parameter Name="inGroup"></asp:Parameter>
                <asp:Parameter Name="packageSize"></asp:Parameter>
                <asp:Parameter Name="unitsInKit"></asp:Parameter>
                <asp:Parameter Name="offPremiseKit"></asp:Parameter>
                <asp:Parameter Name="onPremiseKit"></asp:Parameter>
                <asp:Parameter Name="accountPlacement"></asp:Parameter>
                <asp:Parameter Name="giveaway"></asp:Parameter>
                <asp:Parameter Name="accountGift"></asp:Parameter>
                <asp:Parameter Name="returnToInventory"></asp:Parameter>

            </UpdateParameters>
      </asp:SqlDataSource>

    
    </form>
</body>
</html>
