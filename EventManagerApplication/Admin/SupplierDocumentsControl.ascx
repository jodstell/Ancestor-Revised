<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SupplierDocumentsControl.ascx.vb" Inherits="EventManagerApplication.SupplierDocumentsControl" %>

<style>
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

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<div class="pull-right" style="margin: 5px 15px 15px 0">

    <asp:Button ID="btnAddFiles" runat="server" Text="Add File(s)" CssClass="btn btn-md btn-primary" />

</div>

    <div class="clearfix"></div>

<asp:Panel ID="GridPanel" runat="server">

<telerik:RadGrid ID="SupplierDocumentList" runat="server" DataSourceID="getSupplierDocuments" AllowFilteringByColumn="True" AllowSorting="True">
    <MasterTableView AutoGenerateColumns="False" DataKeyNames="DocumentID" DataSourceID="getSupplierDocuments">
        <Columns>
           
            <telerik:GridBoundColumn DataField="DocumentName" FilterControlAltText="Filter DocumentName column" HeaderText="DocumentName" SortExpression="DocumentName" UniqueName="DocumentName">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="FileType" FilterControlAltText="Filter FileType column" HeaderText="FileType" SortExpression="FileType" UniqueName="FileType">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="ModifiedDate" DataType="System.DateTime" FilterControlAltText="Filter ModifiedDate column" HeaderText="ModifiedDate" SortExpression="ModifiedDate" UniqueName="ModifiedDate">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>
           
            <telerik:GridBoundColumn DataField="ModifiedBy" FilterControlAltText="Filter ModifiedBy column" HeaderText="ModifiedBy" SortExpression="ModifiedBy" UniqueName="ModifiedBy">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>
           
        </Columns>

    </MasterTableView>

</telerik:RadGrid>

</asp:Panel>

    <asp:Panel ID="UploadPanel" runat="server" Visible="false">
    <div class="widget stacked" style="margin-top: 25px;">
        <div class="widget-content" style="padding: 25px">

            <div class="demo-container size-wide">
                <h2>Upload Files</h2>
                <p>
                    Upload your files here using the file uploader or the drop box below.
                </p>

                <telerik:RadAsyncUpload runat="server" ID="RadAsyncUpload1" MultipleFileSelection="Automatic" DropZones=".DropZone1,#DropZone2" PostbackTriggers="btnUpload" />


                <div class="DropZone1">

                    <br />
                    <br />

                    <p>Drop Files Here</p>

                </div>

                <div class="btnbox">
                    <asp:Button ID="btnUpload" runat="server" Text="Upload Files" CssClass="btn btn-md btn-primary" />
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

<asp:LinqDataSource ID="getSupplierDocuments" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblSupplierDocuments" Where="SupplierID == @SupplierID">
    <WhereParameters>
        <asp:QueryStringParameter Name="SupplierID" QueryStringField="SupplierID" Type="Int32" />
    </WhereParameters>
</asp:LinqDataSource>



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
