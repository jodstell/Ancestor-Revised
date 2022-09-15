<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ImageUploadTest.aspx.vb" Inherits="EventManagerApplication.ImageUploadTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   

    <div class="container">

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="Thumbnail" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadAjaxLoadingPanel runat="server" ID="LoadingExamplePanel">
        </telerik:RadAjaxLoadingPanel>

        <span class="info"></span>
        <div class="imageContainer">        
            <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" TargetFolder="~/images"  
                OnClientFileUploaded="flieUploaded">
            </telerik:RadAsyncUpload>   

            <telerik:RadBinaryImage ID="Thumbnail" runat="server" Height="250px" />

        </div>

    </div>


    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">

            function flieUploaded(sender, args) {
                $find("<%=RadAjaxManager1.ClientID%>").ajaxRequest(args.get_fileName());
                
                                
            }


            function DeleteFile(filePath) {
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    dataType: 'json',
                    url: '/ImageUploadTest.aspx/UploadFile',
                    data: "{'filePath': \"" + filePath + "\"}",
                    success: function (data) {
                        if (data.d) {
                            alert('Delete file successfully');
                        } else {
                            alert('Cannot delete file');
                        }
                    }
                });
            }


    </script>
    </telerik:RadScriptBlock>


</asp:Content>
