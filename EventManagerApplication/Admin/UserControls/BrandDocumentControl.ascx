<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandDocumentControl.ascx.vb" Inherits="EventManagerApplication.BrandDocumentControl" %>


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

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

<div style="margin: 5px 15px 15px 0">

    <p> Upload training related documents here.</p>

     <p>
                                            <asp:LinkButton ID="btnUploadFile" runat="server" CssClass="btn btn-primary"><i class="fa fa-upload"></i>&nbsp;&nbsp;Upload File</asp:LinkButton>
                                            &nbsp;&nbsp;

                                        </p>
                                    <hr />

</div>

    <div class="clearfix"></div>

<asp:Panel ID="LibraryPanel" runat="server">

    <div class="col-md-12">


                                                <telerik:RadGrid ID="DocumentsGrid" runat="server" CellSpacing="-1">
                                            <MasterTableView DataKeyNames="FileID" AutoGenerateColumns="false" >

                                                 <NoRecordsTemplate>

                                                <br />
                                                <div class="col-md-12">
                                                    <div class="alert alert-warning" role="alert"><strong>No document uploaded.</strong>  Use the file uploader above to add your files.</div>
                                                </div>

                                            </NoRecordsTemplate>

                                                <Columns>
                                                    <telerik:GridTemplateColumn>
                                                        <ItemTemplate>
                                                            <a class="btn btn-default" style="color:black" href='/FileHandler.aspx?ID=<%# Eval("ID")%>''><i class="fa fa-download" aria-hidden="true"></i> Download</a>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>



                                                    <telerik:GridBoundColumn DataField="FileName" HeaderText="Document Name" SortExpression="FileName" UniqueName="FileName" FilterControlAltText="Filter FileName column"></telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Uploaded By" SortExpression="ModifiedBy" UniqueName="ModifiedBy" FilterControlAltText="Filter ModifiedBy column">
                                                        <ItemTemplate>
                                                            <asp:Label ID="ModifiedByLabel" runat="server" Text='<%#Common.GetFullName(Eval("UploadedBy")) %>' />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridBoundColumn DataField="DateUploaded" HeaderText="Uploaded Date" SortExpression="DateUploaded" UniqueName="DateUploaded" DataType="System.DateTime" FilterControlAltText="Filter DateUploaded column"></telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn>
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger" CommandArgument='<%# Eval("FileID") %>' CommandName="DeleteFile" ForeColor="white"><i class="fa fa-trash" aria-hidden="true"></i> Delete</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>

 <asp:Label ID="CourseIDTextBox" runat="server" />


    </div>











</asp:Panel>

    <asp:Panel ID="FileUploadPanel" runat="server" Visible="false">

                            <h2>Upload File</h2>
                                        <hr />

                                        <div class="form-horizontal">
						<div class="form-group">
							<label class="col-md-2">Display Name</label>

							<div class="col-md-6">
                                <asp:TextBox ID="txtFileName" runat="server" CssClass="form-control"></asp:TextBox>
							</div>
						</div>

                                        <div class="form-group">
							            <label class="col-md-2">Upload File</label>

							            <div class="col-md-6">
                                            <telerik:RadAsyncUpload ID="RadAsyncUpload" runat="server" MaxFileInputsCount="1"></telerik:RadAsyncUpload>

							            </div>
						            </div>

                                            <div class="form-group">
							<label class="col-md-2"></label>

							<div class="col-md-6">
                                <asp:Button ID="btnSubmitFileUpload" runat="server" Text="Submit" CssClass="btn btn-primary" />
                                &nbsp;&nbsp;
                                <asp:LinkButton ID="btnExitUpload" runat="server" CssClass="btn btn-secondary">Cancel & Close</asp:LinkButton>
							</div>
						</div>

                                            <asp:Label ID="msgUploadError" runat="server" />

                                            </div>
                            </asp:Panel>



    </telerik:RadAjaxPanel>

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
