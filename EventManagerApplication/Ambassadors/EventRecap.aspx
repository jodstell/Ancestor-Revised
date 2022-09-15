<%@ Page Title="Event Recap" Language="vb" AutoEventWireup="false"  MasterPageFile="~/Dashboard.Master" CodeBehind="EventRecap.aspx.vb" Inherits="EventManagerApplication.EventRecap" %>

<%@ Register Src="~/Events/UserControls/EventPhotoGalleryControl.ascx" TagPrefix="uc1" TagName="EventPhotoGalleryControl" %>
<%@ Register Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" TagPrefix="CuteWebUI" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


   <style>
       .spacePanel {
           margin-bottom: 20px;
       }  

    .headerLabel {
         color: #F90;
        border: 0;
        font-family: 'Open Sans';
        font-weight: normal;
        font-size: 24px;
        width: 100%;
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

        .main {
                padding: 15px;
             }

        .DropZone1 {
            width: 100%;
            height: 195px;
            background-color: white;
            border-color: #CCCCCC;
            float: left;
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: black;
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

       span.errorlabel {
           left: 10px !important;
       }

    </style>

    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        (function () {

            window.pageLoad = function () {
                var $ = $telerik.$;
            }

            window.OnClientLoad = function (sender, args) {

                for (var i = 1; i < sender.get_wizardSteps().get_count() ; i++) {
                    sender.get_wizardSteps().getWizardStep(i).set_enabled(false);
                }
            }

            window.OnClientButtonClicking = function (sender, args) {

                if (!args.get_nextActiveStep().get_enabled()) {
                    args.get_nextActiveStep().set_enabled(true);
                }
                
            }
            
        })();


        //<![CDATA[
        Sys.Application.add_load(function () {
            demo.initialize();
        });
                    //]]>

        (function () {
            var $;
            var demo = window.demo = window.demo || {};

            demo.initialize = function () {
                $ = $telerik.$;
            };

            window.validationFailed = function (radAsyncUpload, args) {
                var $row = $(args.get_row());
                var erorMessage = getErrorMessage(radAsyncUpload, args);
                var span = createError(erorMessage);
                $row.addClass("ruError");
                $row.append(span);
            }

            function getErrorMessage(sender, args) {
                var fileExtention = args.get_fileName().substring(args.get_fileName().lastIndexOf('.') + 1, args.get_fileName().length);
                if (args.get_fileName().lastIndexOf('.') != -1) {//this checks if the extension is correct
                    if (sender.get_allowedFileExtensions().indexOf(fileExtention) == -1) {
                        return ("This file type is not supported.");
                    }
                    else {
                        return ("This file exceeds the maximum allowed size of 5 MB.");
                    }
                }
                else {
                    return ("not correct extension.");
                }
            }

            function createError(erorMessage) {
                var input = '<span class="errorlabel">' + erorMessage + ' </span>';
                return input;
            }



        })();

    </script>

   <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="MainPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="UploadPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="UploadPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="MissingPhotoPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="ViewPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ViewPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="MissingPhotoPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="AddPhotoButton">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="MainPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="MissingPhotoPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManager>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" BackgroundPosition="Top"></telerik:RadAjaxLoadingPanel>

<asp:Panel ID="MainPanel" runat="server">

    <div class="container">
        <!-- Page Header -->
        <div class="row">
            <div class="col-xs-12 marginbotton10">
                <h2>Event Recap</h2>
                <div class="detail">
                    Event Name:
                    <asp:Label ID="EventNameLabel" runat="server" Font-Bold="true" /><br />
                    Date:
                    <asp:Label ID="EventDateLabel" runat="server" Font-Bold="true" /><br />
                    Event ID:
                    <asp:Label ID="EventIDLabel" runat="server" Font-Bold="true" /><br />
                </div>

            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <!-- Recap Wizard -->
                <div class="widget stacked">
                    <div class="widget-content">
                        <telerik:RadWizard ID="RecapWizard" runat="server" DisplayProgressBar="false" DisplayCancelButton="true" OnClientLoad="OnClientLoad" OnClientButtonClicking="OnClientButtonClicking" RenderMode="Auto">

                            <WizardSteps>
                               
                                <telerik:RadWizardStep Title="Add Expenses">
 <!-- Add Expenses -->
                                    <div class="col-md-12">

                                        <asp:Label ID="ErrorLabel1" runat="server" />

                                        <%--<h2><asp:Label ID="label1" runat="server"></asp:Label></h2>--%>

                                        <h3>If you have any expenses for this event, please add them now.</h3>

                                        <telerik:RadListView ID="EventExpenseList" runat="server"
                                            DataKeyNames="eventExpenseID" DataSourceID="SqlDataSource1" InsertItemPosition="FirstItem">

                                            <LayoutTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">
                                                        <thead>
                                                            <tr>
                                                                <th class="hidden-xs"></th>
                                                                <th>Type</th>
                                                                <th class="hidden-xs">Description</th>
                                                                <th>Amount</th>
                                                                <th class="hidden-xs">Payable</th>
                                                                <th>&nbsp;</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr id="itemPlaceholder" runat="server">
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <asp:LinkButton ID="btnInsert1" runat="server" CommandName="AddNewExpense" Visible="<%# Not Container.IsItemInserted %>"
                                                                CssClass="btn btn-success btn-sm pull-right"><i class="fa fa-plus"></i> Add New Expense</asp:LinkButton>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </LayoutTemplate>

                                            <ItemTemplate>
                                                <tr class="rlvI">
                                                    <td class="hidden-xs">
                                                        <%--<telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" 
                                                            DataValue='<%#Eval("receipt") %>' Height='100px' width='100px'
                                                             ResizeMode="Fill"  />--%>
                                                        <asp:Label ID="btnViewReciept" runat="server" Text="View Receipt" CssClass="btn btn-sm btn-default"
                                                            OnClick='<%#CreateRecapReceiptScript(Eval("eventExpenseID"))%>' Visible='<%# Eval("enabled") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="TypeLabel" runat="server" Text='<%# getExpenseType(Eval("expenseTypeID"))%>' />
                                                    </td>
                                                    <td class="hidden-xs">
                                                        <asp:Label ID="DescriptionLabel" runat="server" Text='<%#Eval("description")%>' />
                                                    </td>

                                                    <td>
                                                        <asp:Label ID="AmountLabel" runat="server" Text='<%# Eval("amount", "{0:C}") %>' />
                                                    </td>
                                                    <td class="hidden-xs">
                                                        <asp:Label ID="PayableLabel" runat="server" Text="" />
                                                    </td>

                                                    <td>
                                                        <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" Text="Delete" ToolTip="Delete" />
                                                    </td>
                                                </tr>
                                            </ItemTemplate>

                                            <EditItemTemplate>
                                                <tr class="rlvIEdit">

                                                    <td>
                                                        <asp:DropDownList ID="ddlExpenseType" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("expenseTypeID") %>' DataSourceID="getExpenseTypeList" DataTextField="expenseTypeTitle" DataValueField="expenseTypeID">
                                                        </asp:DropDownList>

                                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getExpenseTypeList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="sort" TableName="tblExpenseTypes"></asp:LinqDataSource>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description")%>' CssClass="form-control"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="amountTextBox2" runat="server" Text='<%# Bind("amount")%>' CssClass="form-control"></asp:TextBox>
                                                    </td>
                                                    <td></td>
                                                    <td>
                                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-sm btn-primary" Text="Save Changes" ToolTip="Update" />
                                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-sm btn-default" Text="Cancel" ToolTip="Cancel" />
                                                    </td>

                                                </tr>
                                            </EditItemTemplate>

                                            <EmptyDataTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">
                                                        <thead>
                                                            <tr>
                                                                <th>Type</th>
                                                                <th class="hidden-xs">Description</th>
                                                                <th>Amount</th>
                                                                <th class="hidden-xs">Payable</th>
                                                                <th>&nbsp;</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td colspan="5">
                                                                    <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Expense</strong> button above.</div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <asp:LinkButton ID="btnInsert1" runat="server" CommandName="AddNewExpense" Visible="<%# Not Container.IsItemInserted %>" CssClass="btn btn-success btn-sm pull-right"><i class="fa fa-plus"></i> Add New Expense</asp:LinkButton>
                                                        </tfoot>
                                                    </table>


                                                </div>
                                            </EmptyDataTemplate>

                                            

                                        </telerik:RadListView>


                                        <div>

                                            If you are done entering your receipts, click on the Next button to continue.  You may click Cancel to quit and save this recap to be completed later.
                                        </div>

                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                            ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                                            DeleteCommand="DELETE FROM [tblEventExpense] WHERE [eventExpenseID] = @eventExpenseID" 
                                            InsertCommand="INSERT INTO [tblEventExpense] ([eventStaffingRequirementID], [expenseTypeID], [description], [amount], [receipt], [submittedDate], [submittedBy]) VALUES (@eventStaffingRequirementID, @expenseTypeID, @description, @amount, @receipt, @submittedDate, @submittedBy)" 
                                            SelectCommand="SELECT * FROM [qryViewExpensesByEvent] WHERE ([eventStaffingRequirementID] = @eventStaffingRequirementID)" 
                                            UpdateCommand="UPDATE [tblEventExpense] SET [eventStaffingRequirementID] = @eventStaffingRequirementID, [expenseTypeID] = @expenseTypeID, [description] = @description, [amount] = @amount, [receipt] = @receipt, [submittedDate] = @submittedDate, [submittedBy] = @submittedBy WHERE [eventExpenseID] = @eventExpenseID">
                                            <DeleteParameters>
                                                <asp:Parameter Name="eventExpenseID" Type="Int32"></asp:Parameter>
                                            </DeleteParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="eventStaffingRequirementID" Type="Int32"></asp:Parameter>
                                                <asp:Parameter Name="expenseTypeID" Type="Int32"></asp:Parameter>
                                                <asp:Parameter Name="description" Type="String"></asp:Parameter>
                                                <asp:Parameter Name="amount" Type="Decimal"></asp:Parameter>
                                                <asp:Parameter Name="receipt" Type="Object"></asp:Parameter>
                                                <asp:Parameter Name="submittedDate" Type="DateTime"></asp:Parameter>
                                                <asp:Parameter Name="submittedBy" Type="String"></asp:Parameter>
                                            </InsertParameters>
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="Hidden_EventRequirementStaffingID" PropertyName="Value" Name="eventStaffingRequirementID" Type="Int32"></asp:ControlParameter>
                                            </SelectParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="eventStaffingRequirementID" Type="Int32"></asp:Parameter>
                                                <asp:Parameter Name="expenseTypeID" Type="Int32"></asp:Parameter>
                                                <asp:Parameter Name="description" Type="String"></asp:Parameter>
                                                <asp:Parameter Name="amount" Type="Decimal"></asp:Parameter>
                                                <asp:Parameter Name="receipt" Type="Object"></asp:Parameter>
                                                <asp:Parameter Name="submittedDate" Type="DateTime"></asp:Parameter>
                                                <asp:Parameter Name="submittedBy" Type="String"></asp:Parameter>
                                                <asp:Parameter Name="eventExpenseID" Type="Int32"></asp:Parameter>
                                            </UpdateParameters>
                                        </asp:SqlDataSource>


                                        <asp:LinqDataSource ID="getEventExpense" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblEventExpenses" Where="eventStaffingRequirementID == @eventStaffingRequirementID" EnableDelete="True">
                                            <WhereParameters>
                                                <asp:ControlParameter ControlID="Hidden_EventRequirementStaffingID" PropertyName="Value" Name="eventStaffingRequirementID" Type="Int32"></asp:ControlParameter>

                                            </WhereParameters>
                                        </asp:LinqDataSource>

                                    </div>



                                </telerik:RadWizardStep>

                                
                                <telerik:RadWizardStep Title="Upload Photos" style="overflow: hidden;">
<!-- Upload Photos -->

                                    <h3>If you have any photo's for this event, please add them now.</h3>

                                    <div class="row">
                                        <asp:Panel ID="ButtonPanel" runat="server">
                                            <div class="pull-right" style="margin-bottom:20px; margin-right: 20px;">
                                        <asp:LinkButton ID="AddPhotoButton" runat="server" CssClass="btn btn-success btn-sm" Style="margin: 12px 0 12px 0">
                                            <i class="fa fa-plus"></i> Add New Photo</asp:LinkButton>
                                            </div>
                                        </asp:Panel>
                                    </div>

                                    <asp:Panel ID="MissingPhotoPanel" runat="server">
                                    <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Photo</strong> button above.</div>
                                    </asp:Panel>

                                    <asp:Panel ID="ErrorPanel" runat="server" Visible="false">
                                        <div class="alert alert-danger" role="alert"> <strong>Sorry!</strong> There is a problem uploading your photos. To add a new item click on the <strong>Add New Photo</strong> button above.</div>
                                    </asp:Panel>

                                    <div class="col-md-8 marginbotton10">
                                        
                                        <asp:Panel ID="UploadPanel" runat="server" Visible="false">

                                                <p>
                                                    Upload your photos here using the file uploader or the drop box below.
                                                </p>

                                           <%-- <telerik:RadAsyncUpload runat="server" ID="RadAsyncUpload1" MultipleFileSelection="Automatic" DropZones=".DropZone1,#DropZone2" PostbackTriggers="btnUpload" AllowedFileExtensions="jpg,jpeg,png,gif" OnClientValidationFailed="validationFailed"  />--%>



                                            <span class="help-block">
                                                <strong>Allowed file types:</strong> jpg, jpeg, png, gif.
                                            </span>
                                                                                        

                                            <CuteWebUI:UploadAttachments ID="UploadAttachments1" OnFileUploaded="UploadAttachments1_FileUploaded" runat="server" DropZoneID="DropPanel" InsertButtonStyle-CssClass="btn btn-primary" InsertText="Upload photo(s)" CancelAllMsg=" " >
                                                <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="7168" />
                                            </CuteWebUI:UploadAttachments> 
                                            
                                                                                        
                                            <div class="widget-content" style="margin-top: 20px;">

                                            <div class="DropZone1" id="DropPanel">

                                                <br />
                                                <br />

                                                <p style="font-size: 25px; font-weight: bold;"><i class="fa fa-plus-circle" aria-hidden="true"></i> Drop Files Here</p>

                                            </div>

                                            </div>
                                                

                                            <asp:Label ID="errorLabel" runat="server" />


                                            <div class="btnbox">
                                                <%--<asp:Button ID="btnUpload" runat="server" Text="Upload Photos" CssClass="btn btn-md btn-primary" />--%>
                                                <asp:Button ID="btnCancelUpload" runat="server" Text="Cancel" CssClass="btn btn-md btn-default" />
                                            </div>

                                            <asp:Label ID="msgLabel" runat="server" />
                                        </asp:Panel>
                                        
                                    </div>

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
                                                        ResizeMode="Crop"
                                                        onclick='<%#CreateWindowScript(Eval("eventID"), Eval("photoID")) %>'
                                                        AlternateText="Click to view larger image" ToolTip="Click to view larger image" />

                                                    <div style="margin-top: -30px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">
                                                        <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" Text="Delete" CssClass="txt" />

                                                    </div>
                                                </div>
                                            </ItemTemplate>

                                            <AlternatingItemTemplate>
                                                <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">
                                                    <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                        DataValue='<%#Eval("Image") %>' Height='<%#ImageHeight %>' Width="<%#ImageWidth %>"
                                                        ResizeMode="Crop"
                                                        onclick='<%#CreateWindowScript(Eval("eventID"), Eval("photoID")) %>'
                                                        AlternateText="Click to view larger image" ToolTip="Click to view larger image" />
                                                    <div style="margin-top: -30px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">

                                                        <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" Text="Delete" CssClass="txt" />

                                                    </div>

                                                </div>

                                            </AlternatingItemTemplate>                                            

                                        </telerik:RadListView>

                                        <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                            SelectCommand="SELECT [photoID], [photoTitle], [photoDescription], [Image], [accountID], [eventID], [brandID] FROM [tblPhoto] WHERE ([eventID] = @eventID) and ([Tag] Is Not Null)">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="EventID" Name="eventID" Type="String"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                    
                                </div>


                                 <div>

                                            If you are done entering your photo's, click on the Next button to continue.  You may click Cancel to quit and save this recap to be completed later.
                                        </div>

                            </asp:Panel>


                                   

                                </telerik:RadWizardStep>

                                
                                <telerik:RadWizardStep Title="Answer Questions" ValidationGroup="Recap">
<!-- Recap Questions -->

                                     <p>
                            Commplete the form below.  Answer each question carefully and as accurate as you can.  Click on the Finish button to submit your recap.<br />
                            Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                        </p>
                                    <div class="col-md-8">
                                        <asp:PlaceHolder ID="InsertPlaceHolder" runat="server"></asp:PlaceHolder>

                                    </div>

                                </telerik:RadWizardStep>

                            </WizardSteps>
                        </telerik:RadWizard>
                        
                        <asp:Panel ID="AddNewExpensePanel" runat="server">


                            <div class="col-md-12">
                               

                                <div class="form-horizontal">
                                    <h3>Add Expense</h3>

                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">Expense Type </label>
                                        <div class="col-md-4">
                                            <asp:DropDownList ID="ddlExpenseType" runat="server" CssClass="form-control" DataSourceID="getExpenseTypeList" DataTextField="expenseTypeTitle" DataValueField="expenseTypeID" AppendDataBoundItems="true">
                                                <asp:ListItem Text="Select Expense Type" Value=""></asp:ListItem>
                                            </asp:DropDownList>

                                            <span class="help-block">Select the expense type.</span>

                                            <asp:RequiredFieldValidator ID="EventNameRequiredFieldValidator" runat="server"
                                                            ErrorMessage="Expense Type is required" CssClass="errorlabel" ControlToValidate="ddlExpenseType"
                                                            Display="Dynamic" ValidationGroup="expense"></asp:RequiredFieldValidator>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getExpenseTypeList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="sort" TableName="tblExpenseTypes"></asp:LinqDataSource>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="descriptionTextBox" class="col-sm-2 control-label">Description</label>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="descriptionTextBox" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>

                                            <span class="help-block">Enter description of the expense.</span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="amountTextBox" class="col-sm-2 control-label">Amount</label>
                                        <div class="col-md-4">
                                            <telerik:RadNumericTextBox ID="amountTextBox" Type="Currency" runat="server"  Skin="Bootstrap" Width="100px"></telerik:RadNumericTextBox>

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ErrorMessage="Amount is required" CssClass="errorlabel" ControlToValidate="amountTextBox"
                                            Display="Dynamic" ValidationGroup="expense"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="ReceiptFileUpload" class="col-sm-2 control-label">Receipt</label>
                                        <div class="col-md-4">

                                            <%--<telerik:RadAsyncUpload ID="ReceiptAsyncUpload" runat="server" MaxFileInputsCount="1" Skin="Bootstrap"            AllowedFileExtensions="jpg,jpeg,png,gif" MaxFileSize="5242880"
                                                OnFileUploaded="RadAsyncUpload1_FileUploaded" OnClientValidationFailed="validationFailed" 
                                                UploadedFilesRendering="BelowFileInput" Width="250px">
                                            </telerik:RadAsyncUpload>--%>

                                            <%--OnFileUploaded="ReceiptUploadAttachments_FileUploaded"--%>

                                            <%--<CuteWebUI:UploadAttachments ID="ReceiptUploadAttachments" runat="server" InsertButtonStyle-CssClass="btn btn-primary" InsertText="Upload photo" CancelAllMsg=" " MultipleFilesUpload="false" OnAttachmentRemoveClicked="ReceiptUploadAttachments_AttachmentRemoveClicked" OnFileUploaded="ReceiptUploadAttachments_FileUploaded">
                                                <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="5120" />
                                            </CuteWebUI:UploadAttachments> --%>

                            <asp:Panel ID="PhotoPanel" runat="server" Visible="false" CssClass="spacePanel">
                                <asp:Image ID="Image1" runat="server" Width="37%" Height="37%" ImageAlign="Middle" />
                            </asp:Panel>

                            <asp:Label ID="lblPath" runat="server" Visible="false"></asp:Label>

                            <CuteWebUI:UploadAttachments ID="ReceiptUploadAttachment" OnFileUploaded="UploadAttachments1_Photo" runat="server" InsertButtonStyle-CssClass="btn btn-default" InsertText="Select Image" CancelAllMsg=" " MultipleFilesUpload="False" ShowProgressBar="false" ShowProgressInfo="false" CancelButtonStyle-CssClass="uploadergrid" UploadingMsg=" ">
                                <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="5168" />
                            </CuteWebUI:UploadAttachments>

                                            <span class="help-block">Upload your receipt.<br />
                                                <strong>Allowed file types:</strong> jpg, jpeg, png, gif.
                                            </span>

                <div class="qsf-results">
 
                <asp:Panel ID="ValidFiles" Visible="false" runat="server" CssClass="qsf-success">
                    <h3>You successfully uploaded:</h3>
                    <ul class="qsf-list" runat="server" id="ValidFilesList"></ul>
                </asp:Panel>
 
                <asp:Panel ID="InvalidFiles" Visible="false" runat="server" CssClass="qsf-error">
                    <h3>The Upload failed for:</h3>
                    <ul class="qsf-list ruError" runat="server" id="InValidFilesList">
                        <li>
                            <p class="ruErrorMessage">The size of your overall upload exceeded the maximum of 5 MB</p>
                        </li>
                    </ul> 
                </asp:Panel>

                </div>
                                   
                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-offset-2 col-sm-10">
                                            <asp:Button ID="btnSaveExpense" runat="server" Text="Save Expense" CssClass="btn btn-primary" ValidationGroup="expense" />
                                            <asp:Button ID="btnCancelExpense" runat="server" Text="Cancel" CssClass="btn btn-default" />

                                        </div>
                                    </div>

                                    

                                </div>
            </div>

            

            <div class="qsf-decoration"></div>

                                   </div>
                                   
                        </asp:Panel>

                    </div>
                </div>


            </div>
        </div>

    </div>

</asp:Panel>
    <telerik:RadWindowManager runat="server" ID="RadWindowManager1">

        <Windows>

            <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" Skin="Bootstrap"
                Width="675px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                Modal="true">
            </telerik:RadWindow>

        </Windows>

    </telerik:RadWindowManager>

    <asp:HiddenField ID="Hidden_EventRequirementStaffingID" runat="server" />

    <script>

       

        function containerMouseover(sender) {
            sender.getElementsByTagName("div")[0].style.display = "";
        }

        function containerMouseout(sender) {
            sender.getElementsByTagName("div")[0].style.display = "none";
        }


       

    </script>
</asp:Content>
