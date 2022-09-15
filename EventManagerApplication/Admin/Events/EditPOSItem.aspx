<%@ Page Title="Edit POS Item" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditPOSItem.aspx.vb" Inherits="EventManagerApplication.EditPOSItem" %>

<%@ Register Src="~/Admin/UserControls/AddInventoyControl.ascx" TagPrefix="uc1" TagName="AddInventoyControl" %>
<%@ Register Src="~/Admin/UserControls/VendorInformationControl.ascx" TagPrefix="uc1" TagName="VendorInformationControl" %>

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
        <div class="row">
            <div id="messageHolder">
                <asp:Literal ID="msgLabel" runat="server" />
            </div>
        </div>


        <div class="row">
            <div class="col-md-12">
                <h2>Edit Inventory Item</h2>
                <hr />
            </div>
        </div>


        <div class="tabbable">

            <ul id="MainTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0px">
                <li class="active"><a href="#defaulttab" data-toggle="tab">Default Information</a></li>
                <li><a href="#inventorytab" data-toggle="tab">Inventory</a></li>
                <li class=""><a href="#vendortab" data-toggle="tab">Vendor Information</a></li>
                <li class="pull-right secondarytab">

                    <asp:HyperLink ID="ReturnLink" runat="server"><i class="fa fa-angle-double-left"></i>&nbsp;Client Overview</asp:HyperLink>
                </li>
            </ul>

            <div class="tab-content tab-container">
                <!-- Client Details Tab -->
                <div class="tab-pane active" id="defaulttab">
                    <div class="widget stacked">
                        <div class="widget-content">

                            <h2>Default Information</h2>
                            <p>Use the tabs above to manage inventory and vendor information</p>
                            <hr />




                            <div style="margin: 12px 0 12px 0">
                                <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CssClass="btn btn-primary btn-sm" />
                                <asp:Button ID="btnReturn" runat="server" Text="Return to Brand Details" CssClass="btn btn-default btn-sm" />
                            </div>
                            <hr />

                            <div class="row">

                                <div class="col-md-8">

                                    <div class="form-horizontal">

                                        <asp:Panel ID="AddtoGroupPanel" runat="server">
                                               <%-- <div class="form-group">
                                                    <label for="txtBrandName" class="col-sm-3 control-label">Add this item to the Brand Group?</label>
                                                    <div class="col-sm-6">

                                                        <asp:CheckBox ID="ckbxInGroup" runat="server" Text="Yes" Checked='<%# Bind("inGroup") %>' />
                                                       

                                                    </div>
                                                </div>--%>
                                                </asp:Panel>

                                        <asp:FormView ID="InventoryItemForm" runat="server" DataKeyNames="itemID" DataSourceID="getInventoryList2" DefaultMode="Edit" Width="100%">
                                            <EditItemTemplate>

                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-3 control-label">Item Name:</label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="ItemNameTextBox" runat="server" CssClass="form-control" Text='<%# Bind("itemName") %>' />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-3 control-label">Retail Price/Unit:</label>
                                                    <div class="col-sm-3">
                                                        <div class="input-group">
                                                            <span class="input-group-addon" id="basic-addon1">$</span>
                                                           <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" aria-describedby="basic-addon1" Text='<%# Bind("retailPrice") %>' />
                                                            <%--<telerik:RadNumericTextBox ID="RetailPriceTextBox" runat="server" Culture="en-US" Type="Currency" DisplayText='<%# Bind("retailPrice") %>' CssClass="form-control"></telerik:RadNumericTextBox>--%>
                                                                   </div>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-3 control-label">Package Size:</label>
                                                    <div class="col-sm-3">
                                                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Text='<%# Bind("packageSize") %>' />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-3 control-label">How many units should be shipped in a kit?:</label>
                                                    <div class="col-sm-3">
                                                        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" Text='<%# Bind("unitsInKit") %>' />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-3 control-label">How will this product be used?:</label>
                                                    <div class="col-sm-3">
                                                        <asp:CheckBox ID="CheckBox2" runat="server" Text="Off-Premise Kit" Checked='<%# Bind("offPremiseKit") %>' /><br />
                                                        <asp:CheckBox ID="CheckBox3" runat="server" Text="On-Premise Kit" Checked='<%# Bind("onPremiseKit") %>' /><br />
                                                        <asp:CheckBox ID="CheckBox4" runat="server" Text="Account Placement" Checked='<%# Bind("accountPlacement") %>' /><br />
                                                        <asp:CheckBox ID="CheckBox5" runat="server" Text="Consumer Giveaway" Checked='<%# Bind("giveaway") %>' /><br />
                                                        <asp:CheckBox ID="CheckBox6" runat="server" Text="Trade/Account Gift" Checked='<%# Bind("accountGift") %>' /><br />


                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ItemTextBox" class="col-sm-3 control-label">Does this item need to be returned to inventory?:</label>
                                                    <div class="col-sm-3">
                                                        <asp:CheckBox ID="CheckBox1" runat="server" Text="Yes" Checked='<%# Bind("returnToInventory") %>' />
                                                    </div>
                                                </div>

                                            </EditItemTemplate>

                                        </asp:FormView>

                                    </div>
                                    <!-- End Form -->
                                </div>


                                <div class="col-xs-4">
                                    <h3>Product Photo</h3>


                                    <div class="col-xs-12 col-md-12">

                                            <asp:Repeater ID="ProductImageRepeater" runat="server" DataSourceID="getImage">
                                                <ItemTemplate>
                                                    <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail"
                                                        DataValue='<%#IIf(TypeOf (Eval("image")) Is DBNull, Nothing, Eval("image"))%>'
                                                        Height="200px" Width="200px" ResizeMode="Fit" />
                                                </ItemTemplate>
                                            </asp:Repeater>

                                    <asp:Panel ID="PhotoPanel" runat="server" Visible="false">
                                        <asp:Image ID="Image1" runat="server" Width="45%" Height="45%" ImageAlign="Middle" />
                                    </asp:Panel>
                   
                                    <asp:Label ID="lblInfoPhoto" runat="server" Visible="false">
                                    <span class="help-block"><strong style="font-size: 14px;">Click Save Changes button to save the photo.</strong></span>
                                    </asp:Label>

                                                <asp:SqlDataSource runat="server" ID="getImage" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [image] FROM [tblInventoryItem] WHERE ([itemID] = @itemID)">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter QueryStringField="ItemID" Name="itemID" Type="String"></asp:QueryStringParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>


                                    </div>


                                    <div class="col-xs-12 col-md-12" style="right: 10%;">
                                        <div class="col-md-4">
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
                    </div>
                </div>



                <!-- Inventory Tab -->
                <div class="tab-pane" id="inventorytab">
                    <div class="widget stacked">
                        <div class="widget-content">

                            <h2>Inventory</h2>
                            <hr />
                            <div class="row">
                                <div class="col-sm-12">


                                    <%--<uc1:AddInventoyControl runat="server" ID="AddInventoyControl" />--%>

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

                                </div>

                            </div>
                        </div>
                    </div>
                </div>



                <!-- Vendor Tab -->
                <div class="tab-pane" id="vendortab">
                    <div class="widget stacked">
                        <div class="widget-content">
                            <h2>Vendor Information</h2>
                            <hr />

                            <div class="row">
                                <div class="col-sm-12">

                                    <uc1:VendorInformationControl runat="server" ID="VendorInformationControl" />


                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <asp:LinqDataSource ID="getInventoryItem" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblInventoryItems" Where="itemID == @itemID">
        <WhereParameters>
            <asp:QueryStringParameter Name="itemID" QueryStringField="ItemID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:SqlDataSource runat="server" ID="getInventoryList2" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [qryGetInventoryList] WHERE ([itemID] = @itemID)" InsertCommand="INSERT INTO [qryGetInventoryList] ([thumbnail], [itemName], [Brand], [retailPrice], [packageSize], [unitsInKit], [QtyOnHand]) VALUES (@thumbnail, @itemName, @Brand, @retailPrice, @packageSize, @unitsInKit, @QtyOnHand)" 
        UpdateCommand="UPDATE tblInventoryItem SET itemName = @itemName, retailPrice = @retailPrice, offPremiseKit = @offPremiseKit, onPremiseKit = @onPremiseKit, accountPlacement = @accountPlacement, giveaway = @giveaway, accountGift = @accountGift, returnToInventory = @returnToInventory WHERE (itemID = @itemID)">
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



</asp:Content>
