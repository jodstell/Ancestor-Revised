<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewGallery.aspx.vb" Inherits="EventManagerApplication.ViewGallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"> 
   <AjaxSettings> 
        <telerik:AjaxSetting AjaxControlID="ButtonPanel"> 
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="GalleryPanel"  />
                <telerik:AjaxUpdatedControl ControlID="FilterPanel"  />
                <telerik:AjaxUpdatedControl ControlID="ButtonPanel" />
                <telerik:AjaxUpdatedControl ControlID="UploadPanel"  />
            </UpdatedControls> 
        </telerik:AjaxSetting>
   </AjaxSettings>

    <AjaxSettings> 
        <telerik:AjaxSetting AjaxControlID="GalleryPanel"> 
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="GalleryPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="FilterPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="ButtonPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="UploadPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
            </UpdatedControls> 
        </telerik:AjaxSetting>
   </AjaxSettings>

    <AjaxSettings> 
        <telerik:AjaxSetting AjaxControlID="FilterPanel"> 
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="GalleryPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="FilterPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="ButtonPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="UploadPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
            </UpdatedControls> 
        </telerik:AjaxSetting>
   </AjaxSettings>

    <AjaxSettings> 
        <telerik:AjaxSetting AjaxControlID="UploadPanel"> 
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="GalleryPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="FilterPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="ButtonPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="UploadPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
            </UpdatedControls> 
        </telerik:AjaxSetting>
   </AjaxSettings>
</telerik:RadAjaxManager>


    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" 
    style="position:absolute; top:0; left:0; width:100%; height:100%"></telerik:RadAjaxLoadingPanel>


    <asp:HiddenField ID="HiddenSessionGUID" runat="server" />

    <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Gallery</h2>


                <style>
                    .RadDataPager_Bootstrap {
                        background: none;
                        border: 0;
                    }

                    .DropZone1 {
                        width: 100%;
                        height: 90px;
                        background-color: #357A2B;
                        border-color: #CCCCCC;
                        float: left;
                        text-align: center;
                        font-size: 24px;
                        color: white;
                        margin-bottom: 25px;
                    }

                    .demo-container .RadAsyncUpload {
                        margin-left: 250px;
                        margin-bottom: 28px;
                    }

                    .demo-container .RadUpload .ruUploadProgress {
                        width: 230px;
                        display: inline-block;
                        overflow: hidden;
                        text-overflow: ellipsis;
                    }

                    .demo-container .ruFakeInput {
                        width: 200px;
                    }

                    .btnbox {
                        padding-top: 25px;
                        text-align: right;
                    }

                    .imageContainer {
                        float: left;
                        margin: 5px;
                        padding: 2px;
                        position: relative;
                        background: #eeeeee;
                    }

                        .imageContainer:hover {
                            background-color: #a1da29 !important;
                        }

                    .buttonsWrapper {
                        display: inline-block;
                        vertical-align: middle;
                    }

                    .image {
                        cursor: pointer;
                        display: block;
                    }

                    .delete {
                        border: 2px solid;
                        padding: 2px;
                        color: red;
                        background-color: white;
                        float: right;
                    }

                    .bin {
                        border: 2px solid;
                        padding: 2px;
                        color: white;
                        background-color: #428BCA;
                    }


                    #list {
                        max-width: 100%;
                    }

                    .clearFix {
                        clear: both;
                    }

                    .demo-container {
                        max-width: 856px;
                    }

                    .sliderWrapper {
                        float: left;
                        display: inline-block;
                        margin-bottom: 15px;
                    }
                </style>

               <%-- <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">--%>

                    <h3>Photo Gallery</h3>

                    


                    <asp:Panel ID="ButtonPanel" runat="server">
                        <div class="pull-right btn-group" role="group" style="padding-top: 5px;">


                            <button class="btn btn-default btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Photo Bin  <span class="badge">
                                    <asp:Label ID="PhotoBinCountLabel" runat="server" /></span>
                            </button>
                            <ul class="dropdown-menu">
                                <li>

                                    <asp:HyperLink ID="HyperLink2" runat="server">Download Photo Bin</asp:HyperLink>

                                </li>

                                <li>
                                    <asp:LinkButton ID="btnDeletePhotoBin" runat="server" CssClass="">
                                Delete Photo Bin 
                                    </asp:LinkButton></li>


                            </ul>

                            <asp:LinkButton ID="btnFilter" runat="server" CssClass="btn btn-sm btn-default">
            <i class="fa fa-filter"></i> Filters
                            </asp:LinkButton>

                            <%-- <asp:LinkButton ID="btnAddPhotos1" runat="server" Text="Add Photo" CssClass="btn btn-sm btn-primary pull-right">
        <i class="fa fa-plus"></i> Add New Photo
                            </asp:LinkButton>--%>
                        </div>
                    </asp:Panel>
                
                    <asp:Panel ID="FilterPanel" runat="server" Visible="false">

                        <div class="widget stacked" style="margin-top: 25px;">
                            <div class="widget-content" style="padding-left: 35px">

                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="pull-right btn-group" role="group">
                                            <asp:Button ID="btnApplyFilter2" runat="server" Text="Apply Filter" CausesValidation="True" CssClass="btn btn-primary" OnClick="ApplyFilter_Click" />
                                            <asp:Button ID="btnCancelFilter2" runat="server" Text="Cancel" CssClass="btn btn-default" OnClick="CancelFilter_Click" />
                                            <asp:Button ID="btnClearFilter2" runat="server" Text="Clear" CssClass="btn btn-default" OnClick="ClearFilter_Click" />
                                        </div>

                                    </div>
                                </div>

                                <div class="row">



                                    <div class="col-md-4">
                                        <div class="panel panel-default">
                                            <div class="panel-body">

                                                <h4 style="font-weight: bold; color: #3276B1;">Date Range</h4>
                                                <p>Select the date range</p>

                                                <asp:Label ID="Label1" runat="server" Text="From Date" Width="80px" CssClass="fromDateLabel"></asp:Label>
                                                
                                                <telerik:RadDatePicker  ID="FromDate" runat="server" AutoPostBack="true" OnSelectedDateChanged="FromDate_SelectedDateChanged">
                                                </telerik:RadDatePicker>

                                                <br />
                                                <br />
                                                <asp:Label ID="Label2" runat="server" Text="To Date" Width="77px" CssClass="toDateLabel"></asp:Label>
                                                
                                                <telerik:RadDatePicker  ID="ToDate" runat="server">
                                                </telerik:RadDatePicker>

                                            </div>
                                        </div>

                                    </div>

                                    <div class="col-md-4">



                                        <h4 style="font-weight: bold; color: #3276B1; margin-bottom: 15px;">Supplier</h4>


                                        <asp:DropDownList ID="SupplierDropDownList" runat="server" AutoPostBack="true" DataSourceID="getSupplier" DataTextField="supplierName" DataValueField="supplierID" CssClass="form-control" Width="320px"></asp:DropDownList>

                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getSupplier" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="supplierName" Select="new (supplierID, supplierName)" TableName="tblSuppliers" Where="clientID == @clientID">
                                            <WhereParameters>
                                                <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>
                                        <br style="margin-bottom: 10px;" />

                                        <p style="font-weight: bold; color: #3276B1;">Brands</p>
                                        <div style="overflow-y: auto; width: 320px; height: 350px; border: 1px solid #c0c0c0">

                                             <telerik:RadListBox RenderMode="Lightweight" ID="BrandCheckBoxList" runat="server" CheckBoxes="true" ShowCheckAll="true" Font-Bold="false" DataSourceID="getBrandList" DataTextField="brandName" DataValueField="brandID">
                                                </telerik:RadListBox>

<%--                                            <asp:CheckBoxList ID="BrandCheckBoxList" runat="server" DataSourceID="getBrandList" DataTextField="brandName" DataValueField="brandID"></asp:CheckBoxList>--%>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getBrandList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="brandName" TableName="getBrandsbySuppliers" Where="supplierID == @supplierID">
                                                <WhereParameters>
                                                    <asp:ControlParameter ControlID="SupplierDropDownList" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>
                                        </div>



                                    </div>

                                    <div class="col-md-4">


                                        <h4 style="font-weight: bold; color: #3276B1; margin-bottom: 10px;">Markets</h4>
                                        <br />
                                        <div style="overflow-y: auto; width: 300px; height: 350px; border: 1px solid #c0c0c0">

                                            <asp:CheckBoxList ID="MarketCheckBoxList" runat="server" DataSourceID="getMarketList" DataTextField="marketName" DataValueField="marketID"></asp:CheckBoxList>
                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getMarketList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="marketName" TableName="tblMarkets"></asp:LinqDataSource>
                                        </div>


                                    </div>

                                </div>

                                <br />



                                <div class="pull-right btn-group" role="group">
                                    <asp:Button ID="btnApplyFilter" runat="server" Text="Apply Filter" CausesValidation="True" CssClass="btn btn-primary" OnClick="ApplyFilter_Click" />
                                    <asp:Button ID="btnCancelFilter" runat="server" Text="Cancel" CssClass="btn btn-default" OnClick="CancelFilter_Click" />
                                    <asp:Button ID="btnClearFilter" runat="server" Text="Clear" CssClass="btn btn-default" OnClick="ClearFilter_Click" />
                                </div>

                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="GalleryPanel" runat="server">

                    <asp:Label ID="FilterLabel" runat="server" />
                    <asp:Label ID="BrandFilterLabel" runat="server" />
                    <asp:Label ID="MarketFilterLabel" runat="server" />
                    <asp:Label ID="DateRangeLabel" runat="server" />

                        
                          <div class="widget stacked">
                    <div class="widget-content">


                        <telerik:RadListView runat="server" ID="PhotoListView" Skin="Bootstrap" DataKeyNames="photoID" AllowMultiItemSelection="true"
                            OverrideDataSourceControlSorting="true" AllowPaging="True">
                            

                            <ItemTemplate>

                                <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">


                                    <asp:Label ID="photoTitleLabel" runat="server" Text='<%# Eval("photoTitle") %>'></asp:Label><br />
                                    <asp:Label ID="dateUploadedLabel" runat="server" Text='<%# Eval("dateUploaded") %>'></asp:Label>

                                    <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                        DataValue='<%#Eval("LargeImage") %>' Height='260px' Width="260px" 
                                        ResizeMode="Crop"
                                        onclick='<%#CreateWindowScript(Eval("eventID"), Eval("photoID")) %>'
                                        AlternateText="Click to view larger image" ToolTip="Click to view larger image" />
                                   


                                    <div style="margin-top: -30px; margin-bottom: 50px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">


                                        <asp:LinkButton ID="btnSavetoBin" runat="server" ToolTip="Add to Bin" CommandArgument='<%# Eval("photoID") %>' 
                                            CommandName="AddtoBin"><i class="fa fa-archive fa-2x bin"></i></asp:LinkButton>

                                        <asp:LinkButton ID="btnDownloadImage" runat="server" ToolTip="Download Image" CommandArgument='<%# Eval("photoID") %>' 
                                            CommandName="DownloadImage"><i class="fa fa-download fa-2x bin"></i></asp:LinkButton>

                                        <asp:LinkButton ID="btnViewItem" runat="server" ToolTip="View Event" CommandName="View" 
                                            OnClick='<%#CreateWindowScript2(Eval("eventID")) %>'><i class="fa fa-eye fa-2x bin"></i></asp:LinkButton>

                                        <%--<asp:LinkButton ID="btnDeleteImage" runat="server" ToolTip="Delete Image" CommandArgument='<%# Eval("photoID") %>' CommandName="DeleteImage"><i class="fa fa-trash fa-2x delete"></i></asp:LinkButton>--%>
                                    </div>




                                </div>

                            </ItemTemplate>

                            <LayoutTemplate>
                                
                                <div id="page1">
                                    <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPager1" runat="server" PageSize="50" PagedControlID="PhotoListView" AllowSEOPaging="true">
                                        <Fields>
                                            <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                                            <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                                            <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
                                               
                                            <telerik:RadDataPagerPageSizeField PageSizeText=" &nbsp;&nbsp;Page size: &nbsp;"></telerik:RadDataPagerPageSizeField>
                                        </Fields>
                                    </telerik:RadDataPager>
                                 </div>
                                       
                                <div class="clearFix">
                                    </div>

                                    <asp:Panel ID="itemPlaceholder" runat="server">
                                    </asp:Panel>

                                    <div class="clearFix">
                                    </div>

                                <div id="page2">
                                <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPager2" runat="server" PageSize="50" PagedControlID="PhotoListView" AllowSEOPaging="true">
                                        <Fields>
                                            <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                                            <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                                            <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
                                               
                                            <telerik:RadDataPagerPageSizeField PageSizeText=" &nbsp;&nbsp;Page size: &nbsp;"></telerik:RadDataPagerPageSizeField>
                                        </Fields>
                                    </telerik:RadDataPager>
                                </div>

                            </LayoutTemplate>

                        </telerik:RadListView>

                        <asp:Label ID="errorLabel" runat="server" />

                        </div>
                              </div>
    
                        <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                            SelectCommand="SELECT [photoID], [photoTitle], [photoDescription], [dateUploaded], [LargeImage], [accountID], [eventID], [brandID], [keywords], [marketID], [clientID] FROM [qryGetPhotoGallery] WHERE ([clientID] = @clientID) ORDER BY [dateUploaded]">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>


                        <asp:SqlDataSource ID="getImageListByMarket" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="sp_galleryFiltertest" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HF_SelectedMarkets" PropertyName="Value" Name="marketID_String" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="getImageListByBrandAndMarket" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="sp_GalleryViewByBrandAndMarket" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HF_SelectedMarkets" PropertyName="Value" Name="marketID_String" Type="String"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="HF_SelectedBrands" PropertyName="Value" Name="brandID_String" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="getImageListByBrand" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="sp_GalleryViewByBrand" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HF_SelectedBrands" PropertyName="Value" Name="brandID_String" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="getImageListByDateRange" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="sp_GalleryViewByDateRange" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="FromDate" PropertyName="SelectedDate" DbType="Date" Name="startDate"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="ToDate" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="getImageListByBrandAndDateRange" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="sp_GalleryViewByBrandAndDateRange" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HF_SelectedBrands" PropertyName="Value" Name="brandID_String" Type="String"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="FromDate" PropertyName="SelectedDate" DbType="Date" Name="startDate"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="ToDate" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="getImageListByMarketAndDateRange" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="sp_GalleryViewByMarketAndDateRange" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HF_SelectedMarkets" PropertyName="Value" Name="marketID_String" Type="String"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="FromDate" PropertyName="SelectedDate" DbType="Date" Name="startDate"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="ToDate" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="getImageListByBrandAndMarketAndDateRange" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="sp_GalleryViewByBrandAndMarketAndDateRange" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HF_SelectedMarkets" PropertyName="Value" Name="marketID_String" Type="String"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="HF_SelectedBrands" PropertyName="Value" Name="brandID_String" Type="String"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="FromDate" PropertyName="SelectedDate" DbType="Date" Name="startDate"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="ToDate" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>


                        <asp:HiddenField ID="HF_SelectedMarkets" runat="server" />
                        <asp:HiddenField ID="HF_SelectedBrands" runat="server" />
                    </asp:Panel>

                    <asp:Panel ID="UploadPanel" runat="server" Visible="false">
                        <div class="widget stacked" style="margin-top: 25px;">
                            <div class="widget-content" style="padding: 25px">

                                <div class="demo-container size-wide">
                                    <h2>Upload Photos</h2>
                                    <p>
                                        Upload your photos here using the file uploader or the drop box below.
                                    </p>

                                    <telerik:RadAsyncUpload runat="server" ID="RadAsyncUpload1" MultipleFileSelection="Automatic" DropZones=".DropZone1,#DropZone2" PostbackTriggers="btnUpload" />


                                    <div class="DropZone1">

                                        <br />
                                        <br />

                                        <p>Drop Files Here</p>

                                    </div>

                                    <div class="btnbox">
                                        <asp:Button ID="btnUpload" runat="server" Text="Upload Photos" CssClass="btn btn-md btn-primary" />
                                        <asp:Button ID="btnCancelUpload" runat="server" Text="Cancel" CssClass="btn btn-md btn-default" />
                                    </div>

                                    <asp:Label ID="msgLabel" runat="server" />

                                </div>


                            </div>

                            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                <script type="text/javascript">
                                    //<![CDATA[
                                    Sys.Application.add_load(function () {
                                        demo.initialize();
                                    });
                                    //]]>
                                </script>
                            </telerik:RadScriptBlock>

                        </div>
                    </asp:Panel>



                    <telerik:RadWindowManager runat="server" ID="RadWindowManager1">

                        <Windows>
                            <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" NavigateUrl="/PhotoGallery.aspx" Skin="Bootstrap"
                                Width="700px" Height="600px" AutoSize="false" Behaviors="Close" ShowContentDuringLoad="false"
                                Modal="true">
                            </telerik:RadWindow>

                        </Windows>

                    </telerik:RadWindowManager>

                <telerik:RadWindow ID="BinPhotos" runat="server" Modal="false" VisibleOnPageLoad="false" Width="625px" Height="330px" Behaviors="Close,Move" AutoSize="false" Skin="Bootstrap">
        <ContentTemplate>
            <div class="container1">
            <div class="widget stacked">
                            <div class="widget-content">

                                <div class="row" style="margin-bottom: 25px;">
                                    <div class="col-sm-12">
                                        <div class="pull-right btn-group" role="group">
                                            
                                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="ZipFileHandler.ashx">HyperLink</asp:HyperLink>

                                            <a href="ZipFileHandler.ashx" onclick="CancelFilter_Click()">Download Photo Bin </a>
                                            


                                            <asp:Button ID="CloseBinButton" runat="server" Text="Cancel" CssClass="btn btn-default" OnClientClick="CancelFilter_Click()" />
                                            
                                        </div>

                                    </div>
                                </div>

                                
                                <br />

                                </div>
                            </div>
                        </div>
               
        </ContentTemplate>  
    </telerik:RadWindow>

                <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
                <script>
                   
                    function CreateWindowScriptBin() {
                                $find("<%=BinPhotos.ClientID %>").show();
                            }
        
                    function CancelFilter_Click() {
                         $find("<%=BinPhotos.ClientID %>").close();
                              
                    }

                    function myFunction() {
                        location.reload();
                    }

                  
                </script>
                    </telerik:RadScriptBlock>




                <!-- This script is for the drop and drag upload-->
                <script>

                    (function () {
                        var $;
                        var demo = window.demo = window.demo || {};

                        demo.initialize = function () {
                            $ = $telerik.$;

                            if (!Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                                $(".qsf-demo-canvas").html("<strong>Your browser does not support Drag and Drop. Please take a look at the info box for additional information.</strong>");
                            }

                            else {
                                $(document).bind({ "drop": function (e) { e.preventDefault(); } });
                                var dropZone1 = $(document).find(".DropZone1");
                                dropZone1.bind({ "dragenter": function (e) { dragEnterHandler(e, dropZone1); } })
                                         .bind({ "dragleave": function (e) { dragLeaveHandler(e, dropZone1); } })
                                         .bind({ "drop": function (e) { dropHandler(e, dropZone1); } });

                                var dropZone2 = $(document).find("#DropZone2");
                                dropZone2.bind({ "dragenter": function (e) { dragEnterHandler(e, dropZone2); } })
                                         .bind({ "dragleave": function (e) { dragLeaveHandler(e, dropZone2); } })
                                         .bind({ "drop": function (e) { dropHandler(e, dropZone2); } });
                            }
                        };

                        function dropHandler(e, dropZone) {
                            dropZone[0].style.backgroundColor = "#357A2B";
                        }

                        function dragEnterHandler(e, dropZone) {
                            var dt = e.originalEvent.dataTransfer;
                            var isFile = (dt.types != null && (dt.types.indexOf ? dt.types.indexOf('Files') != -1 : dt.types.contains('application/x-moz-file')));
                            if (isFile || $telerik.isSafari5 || $telerik.isIE10Mode || $telerik.isOpera)
                                dropZone[0].style.backgroundColor = "#000000";
                        }

                        function dragLeaveHandler(e, dropZone) {
                            if (!$telerik.isMouseOverElement(dropZone[0], e.originalEvent))
                                dropZone[0].style.backgroundColor = "#357A2B";
                        }

                        function uploadPhotos() {

                        }

                    })();
                </script>

                <script>

                    function containerMouseover(sender) {
                        sender.getElementsByTagName("div")[0].style.display = "";
                    }

                    function containerMouseout(sender) {
                        sender.getElementsByTagName("div")[0].style.display = "none";
                    }
                </script>





            </div>
        </div>
    </div>

     <script type="text/javascript">

        //$(document).ready(function () {

        //    alert("We loaded the page");
        //   AddData();

        //});

         function Navigate() {

            alert("The function started");


            $.ajax({
                url: "/clientService.asmx/getNewGuid",
                data: {},
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
alert(msg.d);
                    $("#currentViewName").html(msg.d);
                },
                error: function (e) {
                    $("#currentViewName").html("There was an error retrieving the user guid");
                }
            });

            

            
         }

         $("#FieldDb").on("click", function () {
             Navigate();
         });


         </script>

    <script type="text/javascript">
        $('#gallery').addClass('active');
        
      

      
    </script>



    <script src="/Theme/js/ekko-lightbox.min.js"></script>
    <script type="text/javascript">

        function removePager() {
            document.getElementById("page1").style.display = "none";
            document.getElementById("page2").style.display = "none";
        }


			$(document).ready(function ($) {

				// delegate calls to data-toggle="lightbox"
				$(document).delegate('*[data-toggle="lightbox"]:not([data-gallery="navigateTo"])', 'click', function(event) {
					event.preventDefault();
					return $(this).ekkoLightbox({
						onShown: function() {
							if (window.console) {
								return console.log('onShown event fired');
							}
						},
						onContentLoaded: function() {
							if (window.console) {
								return console.log('onContentLoaded event fired');
							}
						},
						onNavigate: function(direction, itemIndex) {
							if (window.console) {
								return console.log('Navigating '+direction+'. Current item: '+itemIndex);
							}
						}
					});
				});

				//Programatically call
				$('#open-image').click(function (e) {
					e.preventDefault();
					$(this).ekkoLightbox();
				});
				$('#open-youtube').click(function (e) {
					e.preventDefault();
					$(this).ekkoLightbox();
				});

				$(document).delegate('*[data-gallery="navigateTo"]', 'click', function(event) {
					event.preventDefault();
					return $(this).ekkoLightbox({
						onShown: function() {
							var lb = this;
							$(lb.modal_content).on('click', '.modal-footer a#jumpit', function(e) {
								e.preventDefault();
								lb.navigateTo(2);
							});
							$(lb.modal_content).on('click', '.modal-footer a#closeit', function(e) {
								e.preventDefault();
								lb.close();
							});
						}
					});
				});

			});
		</script>

</asp:Content>
