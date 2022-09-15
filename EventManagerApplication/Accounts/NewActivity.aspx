<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="NewActivity.aspx.vb" Inherits="EventManagerApplication.NewActivity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .widget .widget-content {
            padding-top: 5px;
        }

        .nav-tabs, .nav-pills {
            margin-bottom: 1px;
        }

        .table th, .table td {
            border-top: none !important;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group-sm {
            margin-bottom: 10px;
        }

        .combobox {
            width: 300px;
        }
    </style>
        <style>
        .widget .widget-content {
            padding-top: 5px;
        }

        .nav-tabs, .nav-pills {
            margin-bottom: 1px;
        }

        .table th, .table td {
            border-top: none !important;
        }

.DropZone1 {

    width: 100%;
    height: 120px;
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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>

                        <telerik:AjaxSetting AjaxControlID="Panel1">
                            <UpdatedControls>
                                <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                            </UpdatedControls>

                        </telerik:AjaxSetting>
        
       </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>



    <asp:Panel ID="Panel1" runat="server">
    <div class="container" style="min-height: 400px;">

        <div class="row">
            <div class="col-xs-12">
                <h2>New Activity: <asp:Label ID="ActivityNameLabel" runat="server" /></h2>
                <hr />
            </div>
        </div>
        <!-- end row -->
        <div class="row">
            <div class="col-xs-12">

                <asp:Label ID="msgLabel" runat="server" ></asp:Label>

                <div>
                      <p>
                            Commplete the form below.  Answer each question carefully and as accurate as you can.  Click on the Sumbit Form button to submit your Activity.<br />
                            Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                        </p>

                        <asp:LinkButton ID="BtnAddActivity" runat="server" Text="Submit Form" CssClass="btn btn-primary" OnClick="BtnAddActivity_Click1" />
                        &nbsp;
                        <a href='/Accounts/AccountDetails?AccountID=<%= Request.QueryString("AccountID")%>#activities' class="btn btn-default">Cancel</a>

                  
                    
                </div>
                <hr />
            </div>
        </div>
        <!-- end row -->

        <div class="row1">
            <div class="col-xs-10">


                <div class="form-horizontal">

                    

                    <div class="form-group">
                        <label for="activityTypeLabel">Activity Date</label>
                        <div id="dp-ex-2" class="input-group date" style="width: 150px;">
                            <asp:TextBox ID="dateText" runat="server" CssClass="form-control" />
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div>


                    <asp:PlaceHolder ID="InsertPlaceHolder" runat="server"></asp:PlaceHolder>

                </div>
                <!-- End Form -->
                </div>
</div>

        <div class="row">
        <div class="col-md-6">
                    <div class="widget stacked">

                                <div class="widget-content">

                            <div class="demo-container size-wide">
            <h2>Photos</h2>
        <p>
            Upload your photos here using the file uploader or the drop box below.
        </p>

        <telerik:RadAsyncUpload runat="server" ID="RadAsyncUpload1" MultipleFileSelection="Automatic" DropZones=".DropZone1,#DropZone2" />

        <div class="DropZone1">

            <br />
            
            <p><i class="fa fa-cloud-download fa-4x" aria-hidden="true"></i></p>
            <p style="font-size:large">Drop Files Here</p>

        </div>


    </div>

                    </div>
                        </div>
</div>
            </div>


        <div class="row">
                    <div class="col-md-12">
                    
                        <asp:LinkButton ID="BtnAddActivity2" runat="server" Text="Submit Form" CssClass="btn btn-primary" OnClick="BtnAddActivity_Click1" />
                        &nbsp;
                        <a href='/Accounts/AccountDetails?AccountID=<%= Request.QueryString("AccountID")%>#activities' class="btn btn-default">Cancel</a>
                    
                    </div>
               </div>





            
        

        <br />

        <!-- POS Distribultion Control -->
        <asp:Panel ID="POSPanel" runat="server" Visible="false" >
            <div class="margintop20">
            <hr />
            <h3>POS Distribution</h3>

            <div class="margintop20 marginbottom10">

                <table class="table1" cellspacing="0" style="width:100%">
                            <thead>
                                <tr>
                                    <th>Supplier</th>
                                    <th>POS Item</th>
                                    <th>Qty</th>
                                    <th>&nbsp;</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <telerik:RadComboBox ID="SupplierComboBox" runat="server" Width="300px" EmptyMessage="- Select Supplier -" MarkFirstMatch="True" AllowCustomText="True" AutoPostBack="true" DataTextField="supplierName" DataValueField="supplierID" DataSourceID="GetSupplierList">
                                        </telerik:RadComboBox>

                                        <asp:SqlDataSource runat="server" ID="GetSupplierList" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetSuppliersByUser" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="PosItemComboBox" runat="server" MarkFirstMatch="True" AllowCustomText="True" EnableLoadOnDemand="true"
                                            DataTextField="FullName" DataValueField="itemID" Width="580px" EmptyMessage="- Select -" DataSourceID="GetPOSItemList">
                                            <HeaderTemplate>

                            <table style="width: 570px" cellspacing="0" cellpadding="0">

                                <tr>

                                    <td style="width: 320px;">

                                        Product Name

                                    </td>

                                    <td style="width: 80px;">

                                        Units in Kit

                                    </td>

                                    <td style="width: 80px;">

                                        Package Size

                                    </td>

                                     <td style="width: 80px;">

                                        Price per Unit

                                    </td>


                                </tr>

                            </table>

                        </HeaderTemplate>

                        <ItemTemplate>

                            <table style="width: 570px" cellspacing="0" cellpadding="0">

                                <tr>

                                    <td style="width: 320px;">

                                        <%# DataBinder.Eval(Container.DataItem, "FullName")%> 

                                    </td>

                                    <td style="width: 80px;">

                                        <%# DataBinder.Eval(Container.DataItem, "UnitsInKit")%>

                                    </td>

                                    <td style="width: 80px;">

                                        <%# DataBinder.Eval(Container.DataItem, "packageSize")%>

                                    </td>

                                    <td style="width: 80px;">

                                        <%# DataBinder.Eval(Container.DataItem, "retailPrice")%>

                                    </td>

                                </tr>

                            </table>

                        </ItemTemplate>
                                        </telerik:RadComboBox>

                                        <asp:SqlDataSource runat="server" ID="GetPOSItemList" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetInventoryItemsbySupplier" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="SupplierComboBox" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    
                                    
                                    <td><telerik:RadNumericTextBox ID="qtyTextBox" runat="server" Width="75px" NumberFormat-DecimalDigits="0"></telerik:RadNumericTextBox></td>
                                    <td><asp:LinkButton ID="btnInsertItem" runat="server" 
                                    CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add POS Item</asp:LinkButton></td>
                                </tr>
                                </tbody>
                    </table>



                <asp:HiddenField ID="HiddenTempID" runat="server" />
                
                
                
                
            </div>

            <telerik:RadListView ID="BrandEventTaskList" runat="server"
                InsertItemPosition="FirstItem" DataKeyNames="id" DataSourceID="LinqDataSource1">
                <LayoutTemplate>
                    <div class="RadListView RadListView_Default">
                        <table class="table" cellspacing="0" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>&nbsp;</th>
                                    <th>POS Item</th>
                                    <th>Units in Kit</th>
                                    <th>Package Size</th>
                                    <th>Retail Price</th>
                                    <th>Qty</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </tbody>
                            <tfoot>
                            </tfoot>
                        </table>
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr class="rlvI">
                        <td>
                            <div class="btn-group" role="group" aria-label="...">
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-default btn-sm" ToolTip="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                                <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-sm btn-danger" ToolTip="Delete"><i class="fa fa-trash"></i> Delete</asp:LinkButton>
                            </div>
                        </td>
                        <td><%# Eval("itemName") %></td>
                        <td><%# Eval("units") %></td>
                        <td><%# Eval("package") %></td>
                        <td><%# Eval("retailPrice") %></td>
                        <td><%# Eval("qty") %></td>
                        <td><%# Eval("total") %></td>
                    </tr>
                </ItemTemplate>

                <EditItemTemplate>
                    <tr class="rlvIEdit">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-sm btn-primary" Text="Save Changes" ToolTip="Update" />
                            <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-sm btn-default" Text="Cancel" ToolTip="Cancel" />
                        </td>

                    </tr>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <tr class="rlvIEdit">

                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>
                            <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-sm btn-primary" Text="Save Changes" ToolTip="Insert" />
                            <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-sm btn-default" Text="Cancel" ToolTip="Cancel" />
                        </td>


                    </tr>
                </InsertItemTemplate>
                <EmptyDataTemplate>
                    <div class="RadListView RadListView_Default">
                        <table class="table" cellspacing="0" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>&nbsp;</th>
                                    <th>POS Item</th>
                                    <th>Units in Kit</th>
                                    <th>Package Size</th>
                                    <th>Retail Price</th>
                                    <th>Qty</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="5">
                                        <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add POS Item</strong> button above.</div>
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot>
                            </tfoot>
                        </table>


                    </div>
                </EmptyDataTemplate>

            </telerik:RadListView>




                <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tempAccountPosDistributions" Where="tempID == @tempID" EnableDelete="True">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="HiddenTempID" PropertyName="Value" Name="tempID" Type="String"></asp:ControlParameter>
                    </WhereParameters>
                </asp:LinqDataSource>
            



                </div>
        </asp:Panel>

    </div>
    <!-- End Container -->
    </asp:Panel>

    <asp:LinqDataSource ID="getActivityTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="activityName" TableName="qryViewActivityTypeByClients" Where="clientID == @clientID">
        <WhereParameters>
            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
        </WhereParameters>
    </asp:LinqDataSource>

       

</asp:Content>
