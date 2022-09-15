<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EventPhotoGalleryControl.ascx.vb" Inherits="EventManagerApplication.EventPhotoGalleryControl" %>


<style>
    .galery {
        background-color: grey;
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

    .txt {
        border: 0 !important;
        background: #eeeeee !important;
        color: Black !important;
        margin-left: 25%;
        margin-right: auto;
        width: 100%;
        filter: alpha(opacity=50); /* IE's opacity*/
        opacity: 0.50;
        text-align: center;
    }

    #list {
        max-width: 900px;
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



                
<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"> 
    <AjaxSettings> 
        <telerik:AjaxSetting AjaxControlID="GalleryPanel"> 
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="GalleryPanel" LoadingPanelID="RadAjaxLoadingPanel1" /> 
            </UpdatedControls> 
        </telerik:AjaxSetting>
     
        <telerik:AjaxSetting AjaxControlID="UploadPanel"> 
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="UploadPanel" LoadingPanelID="RadAjaxLoadingPanel1" /> 
            </UpdatedControls> 
        </telerik:AjaxSetting>   

        <telerik:AjaxSetting AjaxControlID="StaffingPnel1"> 
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="StaffingPnel1" LoadingPanelID="RadAjaxLoadingPanel1" /> 
                <telerik:AjaxUpdatedControl ControlID="scores" />
                <telerik:AjaxUpdatedControl ControlID="ProductTrainingPanel" />
            </UpdatedControls> 
        </telerik:AjaxSetting>
        
        <telerik:AjaxSetting AjaxControlID="NotesPanel"> 
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="NotesPanel" LoadingPanelID="RadAjaxLoadingPanel1" /> 
            </UpdatedControls> 
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="ProductTrainingPanel"> 
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="ProductTrainingPanel" LoadingPanelID="RadAjaxLoadingPanel1" /> 
            </UpdatedControls> 
        </telerik:AjaxSetting>
               
   </AjaxSettings>
</telerik:RadAjaxManager>


    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" 
    style="position:absolute; top:0; left:0; width:100%; height:100%"></telerik:RadAjaxLoadingPanel>


    <asp:Panel ID="GalleryPanel" runat="server">
        <h3>Photo Gallery 
        </h3>
               
             <asp:LinkButton ID="btnAddPhotos" runat="server" CssClass="btn btn-xs btn-success pull-right"><i class="fa fa-plus"></i>  Add Photo</asp:LinkButton>
                   

        <telerik:RadListView runat="server" ID="PhotoListView" DataSourceID="getImageList" Skin="Bootstrap"
            AllowPaging="true" DataKeyNames="photoID" OverrideDataSourceControlSorting="true">

            <LayoutTemplate>

                <div id="list">

                    <asp:Panel runat="server" ID="Panel1" CssClass="buttonsWrapper" Visible="<%#Container.PageCount > 1 %>">

                        <asp:Button runat="server" ID="PrevButton" CommandName="Page" CommandArgument="Prev"
                            Text="Prev Page" Enabled="<%#Container.CurrentPageIndex > 0 %>" />

                        <asp:Button runat="server" ID="NextButton" CommandName="Page" CommandArgument="Next"
                            Text="Next Page" Enabled="<%#Container.CurrentPageIndex < Container.PageCount - 1 %>" />

                        <br />

                    </asp:Panel>

                    <%--<div class="sliderWrapper">

                        <span class="buttonsWrapper">Resize image:</span>

                        <telerik:RadSlider runat="server" ID="RadSlider1" MaximumValue="3" MinimumValue="1" CssClass="buttonsWrapper" Skin="Bootstrap"
                            Value="2" LiveDrag="false" SmallChange="1" AutoPostBack="true" OnValueChanged="RadSlider1_ValueChanged"
                            Width="150px" CausesValidation="false" />

                    </div>--%>

                    <div class="clearFix">
                    </div>

                    <asp:Panel ID="itemPlaceholder" runat="server">
                    </asp:Panel>

                    <div class="clearFix">
                    </div>

                </div>

            </LayoutTemplate>

            <ItemTemplate>

                <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                    <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                        DataValue='<%#Eval("Image") %>' Height='<%#ImageHeight %>' Width="<%#ImageWidth %>"
                        ResizeMode="Fit"
                        onclick='<%#CreateWindowScript(Eval("eventID"), Eval("photoID")) %>'
                        AlternateText="Click to view larger image" ToolTip="Click to view larger image" />

                    <div style="margin-top: -30px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">
                        <asp:LoginView ID="LoginView_AddButton" runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles="Administrator, EventManager">
                                    <ContentTemplate>
                                        <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" Text="Delete" CssClass="txt" />
                                    </ContentTemplate>
                                </asp:RoleGroup>
                            </RoleGroups>
                        </asp:LoginView>


                    </div>

                </div>

            </ItemTemplate>

            <AlternatingItemTemplate>

                <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                    <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                        DataValue='<%#Eval("Image") %>' Height='<%#ImageHeight %>' Width="<%#ImageWidth %>"
                        ResizeMode="Fit"
                        onclick='<%#CreateWindowScript(Eval("eventID"), Eval("photoID")) %>'
                        AlternateText="Click to view larger image" ToolTip="Click to view larger image" />

                    <div style="margin-top: -30px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">

                        <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" Text="Delete" CssClass="txt" />

                    </div>

                </div>

            </AlternatingItemTemplate>
        </telerik:RadListView>

        <asp:Label ID="errorLabel" runat="server" />

        <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [photoID], [photoTitle], [photoDescription], [Image], [accountID], [eventID], [brandID] FROM [tblPhoto] WHERE ([eventID] = @eventID)">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="String"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>

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
                Width="675px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                Modal="true">
            </telerik:RadWindow>

        </Windows>

    </telerik:RadWindowManager>


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

