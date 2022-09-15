<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="NewProduct.aspx.vb" Inherits="EventManagerApplication.NewProduct" %>

<%@ Register Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" TagPrefix="CuteWebUI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .uploadergrid {
            display: none !important;
        }

        .AjaxUploaderCancelAllButton {
            display: none !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="MainPanel" runat="server">

        <div class="container">

            <div class="row">
                <div class="col-md-12">

                    <div style="margin: 0 0 15px 0">
                        <h2>New Product 
                        </h2>
                        <p>
                            Use this form to add a new client.  Complete each section below and click on the Next button to continue to the next tab.<br />
                            Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                        </p>



                    </div>

                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">
                    </telerik:RadAjaxPanel>

                    <asp:Label ID="msgLabel" runat="server"></asp:Label>

                    <div class="widget stacked">
                        <div class="widget-content min-height">



                            <asp:Panel runat="server" ID="ProductControlPanel">

                                <div class="row">
                                    <div class="col-md-12">
                                        <div id="messageHolder">
                                            <asp:Literal ID="msgLabel2" runat="server" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-horizontal">

                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-md btn-primary" />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="SupplierNameTextBox" class="col-sm-4 control-label">Product Name:</label>
                                            <div class="col-sm-6">
                                                <asp:TextBox ID="ProductNameTextBox" runat="server" CssClass="form-control"></asp:TextBox>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="SupplierNameTextBox" class="col-sm-4 control-label">Category:</label>
                                            <div class="col-sm-6">
                                                <telerik:RadDropDownList ID="ddlCategory" runat="server" DataSourceID="getBrandCategory" AutoPostBack="true"
                                                    DataTextField="categoryName" DataValueField="brandCategoryID" Width="250px"
                                                    AppendDataBoundItems="false" DefaultMessage="Select Category...">
                                                </telerik:RadDropDownList>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="ddlCategoryType" class="col-sm-4 control-label">Type:</label>
                                            <div class="col-sm-6">
                                                <telerik:RadDropDownList ID="ddlCategoryType" runat="server" AutoPostBack="true"
                                                    DataSourceID="getBrandCategoryType" DataTextField="name" DataValueField="brandCategoryTypeID"
                                                    AppendDataBoundItems="false" Width="250px" DefaultMessage="Select Type...">
                                                </telerik:RadDropDownList>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="ddlCategorySubType" class="col-sm-4 control-label">Variety:</label>
                                            <div class="col-sm-6">
                                                <telerik:RadDropDownList ID="ddlCategorySubType" runat="server" AutoPostBack="True"
                                                    DataSourceID="getBrandCategorySubType" DataTextField="subCategoryName"
                                                    DataValueField="categorySubTypeID" AppendDataBoundItems="false" Width="250px" DefaultMessage="Select Variety...">
                                                </telerik:RadDropDownList>

                                            </div>
                                        </div>


                                        <div class="form-group">
                                            <label for="ddlCountry" class="col-sm-4 control-label">Country of Origin:</label>
                                            <div class="col-sm-6">
                                                <telerik:RadDropDownList ID="ddlCountry" runat="server" DataSourceID="getCountryList" DataTextField="countryName" DataValueField="countryID" DefaultMessage="Select Country..." Width="250px"></telerik:RadDropDownList>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="ddlPackageSize" class="col-sm-4 control-label">Primary Package Size:</label>
                                            <div class="col-sm-6">
                                                <telerik:RadDropDownList ID="ddlPackageSize" runat="server" DefaultMessage="Select Package Size..." Width="250px">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="750ml" Value="750ml" />
                                                        <telerik:DropDownListItem Text="6-pack" Value="6-pack" />
                                                        <telerik:DropDownListItem Text="4-pack" Value="4-pack" />
                                                        <telerik:DropDownListItem Text="package" Value="package" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="UpcTextBox" class="col-sm-4 control-label">UPC:</label>
                                            <div class="col-sm-6">
                                                <asp:TextBox ID="UpcTextBox" runat="server" CssClass="form-control"></asp:TextBox>

                                            </div>
                                        </div>

                                    </div>

                                </div>

                                <div class="col-sm-6">
                                    <div class="form-horizontal">

                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="SupplierNameTextBox" class="col-sm-3 control-label">Photo:</label>
                                            <div class="col-sm-6">

                                                <asp:Repeater ID="PhotoList" runat="server" DataSourceID="getImage">
                                                    <ItemTemplate>
                                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail" DataValue='<%#IIf(TypeOf (Eval("photo")) Is DBNull, Nothing, Eval("photo"))%>' Height="150px" Width="150px" ResizeMode="Fit" />
                                                    </ItemTemplate>
                                                </asp:Repeater>


                                                <asp:Panel ID="PhotoPanel" runat="server" Visible="false">
                                                    <asp:Image ID="Image1" runat="server" Width="38%" Height="38%" ImageAlign="Middle" />
                                                </asp:Panel>

                                                <asp:Label ID="lblInfoPhoto" runat="server" Visible="false">
                        <span class="help-block"><strong style="font-size: 14px;">Click Save Changes button to save the photo.</strong></span>
                                                </asp:Label>

                                                <asp:SqlDataSource ID="getImage" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [photo] FROM [tblBrandImage] WHERE ([brandID] = @brandID)">

                                                    <SelectParameters>
                                                        <asp:QueryStringParameter QueryStringField="BrandID" Name="brandID" Type="Int32"></asp:QueryStringParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>

                                                <%--<telerik:RadAsyncUpload ID="RadAsyncUpload1" MultipleFileSelection="Disabled" MaxFileInputsCount="1" runat="server" Visible="false"></telerik:RadAsyncUpload>--%>

                                                <asp:Label ID="lblPath" runat="server" Visible="false"></asp:Label>

                                                <CuteWebUI:UploadAttachments ID="UploadAttachments1" OnFileUploaded="UploadAttachments1_Photo" runat="server" InsertButtonStyle-CssClass="btn btn-default" InsertText="Select Image" CancelAllMsg=" " MultipleFilesUpload="False" ShowProgressBar="false" ShowProgressInfo="false" CancelButtonStyle-CssClass="uploadergrid" UploadingMsg=" ">
                                                    <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="4168" />
                                                </CuteWebUI:UploadAttachments>


                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="txtABV" class="col-sm-3 control-label">ABV:</label>
                                            <div class="col-sm-3">
                                                <div class="input-group">
                                                    <asp:TextBox ID="txtABV" runat="server" CssClass="form-control" />
                                                    <span class="input-group-addon">%</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="txtAveragePrice" class="col-sm-3 control-label">Average Price:</label>
                                            <div class="col-sm-4">

                                                <telerik:RadNumericTextBox ID="RadNumerictxtAveragePrice" runat="server" NumberFormat-DecimalDigits="0" Culture="en-US" DbValueFactor="1" Type="Currency">
                                                    <NumberFormat DecimalDigits="2" ZeroPattern="$n"></NumberFormat>

                                                </telerik:RadNumericTextBox>


                                            </div>



                                        </div>

                                    </div>

                                </div>

                            </asp:Panel>




                            <asp:LinqDataSource ID="getCountryList" runat="server"
                                ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                EntityTypeName="" TableName="tblCountries">
                            </asp:LinqDataSource>

                            <asp:LinqDataSource ID="getBrandCategory" runat="server"
                                ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                EntityTypeName="" OrderBy="categoryName" TableName="tblBrandCategories" Where="clientID == @clientID">
                                <WhereParameters>
                                    <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
                                </WhereParameters>
                            </asp:LinqDataSource>

                            <asp:LinqDataSource ID="getBrandCategoryType" runat="server"
                                ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                EntityTypeName="" OrderBy="name" TableName="tblBrandCategoryTypes"
                                Where="brandCategoryID == @brandCategoryID">
                                <WhereParameters>
                                    <asp:ControlParameter ControlID="ddlCategory" Name="brandCategoryID" PropertyName="SelectedValue" DbType="Int32" DefaultValue="0" />
                                </WhereParameters>
                            </asp:LinqDataSource>

                            <asp:LinqDataSource ID="getBrandCategorySubType" runat="server"
                                ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                EntityTypeName="" OrderBy="subCategoryName" TableName="tblBrandCategorySubTypes"
                                Where="brandCategoryTypeID == @brandCategoryTypeID">
                                <WhereParameters>
                                    <asp:ControlParameter ControlID="ddlCategoryType" Name="brandCategoryTypeID"
                                        PropertyName="SelectedValue" DbType="Int32" DefaultValue="0" />
                                </WhereParameters>
                            </asp:LinqDataSource>


                            <telerik:radnotification rendermode="Lightweight" id="RadNotification1" runat="server" height="140px"
                                animation="Fade" enableroundedcorners="true" enableshadow="true" autoclosedelay="3500"
                                position="BottomRight" offsetx="-40" offsety="-50" showclosebutton="true" text="Your changes were updated successfully!" title="Success" titleicon="info"
                                keeponmouseover="true" skin="Glow" xmlns:telerik="telerik.web.ui">
                            </telerik:radnotification>


                        </div>
                    </div>

                </div>

            </div>

        </div>


    </asp:Panel>
</asp:Content>
