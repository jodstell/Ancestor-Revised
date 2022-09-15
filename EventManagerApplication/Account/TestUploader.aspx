<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Master.Master" CodeBehind="TestUploader.aspx.vb" Inherits="EventManagerApplication.TestUploader" %>

<%@ Register Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" TagPrefix="CuteWebUI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
       .spacePanel {
           margin-bottom: 20px;
       }  

       .showTable {
           display: block !important;
       }

       .uploadergrid {
           display: none !important;
       }

       .AjaxUploaderCancelAllButton {
           display: none !important;
       }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container" style="padding:30px;">
    <div class="row">
        <div class="col-md-12">
        
    <asp:Panel ID="AddNewExpensePanel" runat="server">

        <div class="form-horizontal">
            <h3>Add Image</h3>

            <div class="form-group">

                <label for="ImageFileUpload" class="control-label">Image</label>

            <div  style="padding:20px;">
            <asp:Panel ID="PhotoPanel" runat="server" Visible="false" CssClass="spacePanel">
                <asp:Image ID="Image1" runat="server" Width="37%" Height="37%" ImageAlign="Middle" />
            </asp:Panel>

            <asp:Label ID="lblPath" runat="server" Visible="false"></asp:Label>

            <%--<CuteWebUI:UploadAttachments ID="ReceiptUploadAttachment" OnFileUploaded="UploadAttachments1_Photo" runat="server" InsertButtonStyle-CssClass="btn btn-default" InsertText="Select Image" CancelAllMsg=" " MultipleFilesUpload="True" ShowProgressBar="false" ShowProgressInfo="false" CancelButtonStyle-CssClass="uploadergrid" UploadingMsg=" ">
                <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="5168" />
            </CuteWebUI:UploadAttachments>--%>

            <CuteWebUI:UploadAttachments ID="UploadAttachments1" OnFileUploaded="UploadAttachments1_FileUploaded" runat="server" DropZoneID="DropPanel" InsertButtonStyle-CssClass="btn btn-primary" InsertText="Upload photo(s)" CancelAllMsg=" " >
                    <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="7168" />
                </CuteWebUI:UploadAttachments> 
            </div>


            <span class=" help-block" style="padding:20px;">Upload your image.<br />
                <strong>Allowed file types:</strong> jpg, jpeg, png, gif.
            </span>
                            
                <asp:Label ID="msgLabel" runat="server" />

            </div>

            <%--<div class="form-group" style="padding:20px;">
                <asp:Button ID="btnSave" runat="server" Text="Save Expense" CssClass="btn btn-primary" ValidationGroup="expense" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default" />
            </div>--%>


            </div>
                                                       
    </asp:Panel>

        <asp:Panel ID="ViewPanel" runat="server">
                <div class="row">

                    <telerik:RadListView runat="server" ID="PhotoListView" DataSourceID="getImageList" Skin="Bootstrap"
                        AllowPaging="false" DataKeyNames="photoID" OverrideDataSourceControlSorting="true">

                        <LayoutTemplate>

                                <div class="clearFix"></div>

                                <asp:Panel ID="itemPlaceholder" runat="server">
                                </asp:Panel>

                                <div class="clearFix">
                                </div>  
                            

                        </LayoutTemplate>

                        <EmptyItemTemplate>
                            <div class="RadListView RadListView_Default">

                                <div class="alert alert-warning" role="alert">There are no photos to be displayed.  To add a new items click on the <strong>Add New Photos</strong> 
                                    button above.</div>

                            </div>
                        </EmptyItemTemplate>

                        <ItemTemplate>

                            <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                    DataValue='<%#Eval("Image") %>' Height='<%#ImageHeight %>' Width="<%#ImageWidth %>"
                                    ResizeMode="Fit"
                                    AlternateText="Click to view larger image" ToolTip="Click to view larger image" />

                            </div>
                        </ItemTemplate>
                                  

                    </telerik:RadListView>

                    <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
        SelectCommand="SELECT [photoID], [photoTitle], [photoDescription], [Image] FROM [tempPhoto]">
                    </asp:SqlDataSource>

                                    
            </div>

        </asp:Panel>

        </div>
    </div>
</div>
</asp:Content>
