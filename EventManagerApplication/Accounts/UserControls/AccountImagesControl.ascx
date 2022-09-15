<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AccountImagesControl.ascx.vb" Inherits="EventManagerApplication.AccountImagesControl" %>


<style>

.DropZone1 {

    width: 100%;
    height: 90px;
    background-color: #357A2B;
    border-color: #CCCCCC;
    float: left;
    text-align: center;
    font-size: 16px;
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
</style>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy3" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="UploadPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="UploadPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="ButtonPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        
        <telerik:AjaxSetting AjaxControlID="ViewPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ViewPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="ButtonPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ButtonPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="maindiv" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>   
  
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel23" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<asp:Panel ID="ButtonPanel" runat="server">
<div class="pull-right" style="margin-bottom:20px">
            <asp:LinkButton ID="AddPhotoButton" runat="server" CssClass="btn btn-success btn-sm" Style="margin: 12px 0 12px 0"><i class="fa fa-plus"></i> Add New Photo</asp:LinkButton>
                                
                </div>
</asp:Panel>

<div id="maindiv" class="widget stacked" style="margin-top:25px;">
    <div class="widget-content" style="padding: 25px">
        
<asp:Panel ID="UploadPanel" runat="server" Visible="false">
        <div class="demo-container size-wide">
            <h2>Photos</h2>
        <p>
            Upload your photos here using the file uploader or the drop box below.
        </p>

        <telerik:RadAsyncUpload runat="server" ID="RadAsyncUpload1" MultipleFileSelection="Automatic" DropZones=".DropZone1,#DropZone2" />


        <div class="DropZone1">

            <br />
            <br />

            <p>Drop Files Here</p>

        </div>

            <div class="btnbox">
            <asp:Button ID="btnUpload" runat="server" Text="Upload Photos" CssClass="btn btn-md btn-primary" /> <asp:Button ID="btnCancelUpload" runat="server" Text="Cancel" CssClass="btn btn-md btn-default" />
</div>

    </div>
</asp:Panel>


        <asp:Panel ID="ViewPanel" runat="server">

            <asp:Label ID="errorLabel" runat="server" />

            

            <div class="row">
            <telerik:RadListView runat="server" ID="PhotoListView" DataSourceID="getImageList" Skin="Bootstrap"
                                            AllowPaging="true" DataKeyNames="photoID" OverrideDataSourceControlSorting="true">

                                            <LayoutTemplate>

                                                
                                                    <div class="clearFix"></div>

                                                    <asp:Panel ID="itemPlaceholder" runat="server">
                                                    </asp:Panel>

                                                    <div class="clearFix">
                                                    </div>

                                                
                                            </LayoutTemplate>

                                            <ItemTemplate>

                                                <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                     <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                DataValue='<%#Eval("Image") %>' Height='130px' Width="130px"
                                                 ResizeMode="Crop" AlternateText="Click to view larger image" ToolTip="Click to view larger image" onclick='<%#CreateWindowScript(Eval("accountID"), Eval("photoID")) %>' />

                                                    <div style="margin-top: -30px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">
                                                        <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" Text="Delete" CssClass="txt" />

                                                    </div>
                                                </div>
                                            </ItemTemplate>

                                            <AlternatingItemTemplate>

                                                <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">
                                         <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                        DataValue='<%#Eval("Image") %>' Height='130px' Width="130px"
                                                        ResizeMode="Crop" AlternateText="Click to view larger image" ToolTip="Click to view larger image" onclick='<%#CreateWindowScript(Eval("accountID"), Eval("photoID")) %>' />
                                                    <div style="margin-top: -30px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">

                                                        <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" Text="Delete" CssClass="txt" />

                                                    </div>

                                                </div>

                                            </AlternatingItemTemplate>
                                        </telerik:RadListView>
                </div>
            
        <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [tblAccountPhoto] WHERE ([accountID] = @accountID)">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="AccountID" Name="accountID" Type="Int32"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>


        </asp:Panel>

        <telerik:RadWindowManager runat="server" ID="RadWindowManager1">

        <Windows>

            <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" Skin="Bootstrap"
                Width="675px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                Modal="true">
            </telerik:RadWindow>

        </Windows>

    </telerik:RadWindowManager>
        

    </div>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

        <%--<script type="text/javascript">

            //<![CDATA[

            Sys.Application.add_load(function () {

                demo.initialize();

            });

            //]]>

        </script>--%>

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

    </telerik:RadScriptBlock>

</div>






