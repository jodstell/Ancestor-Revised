<%@ Page Title="New Brand" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="NewBrand.aspx.vb" Inherits="EventManagerApplication.NewBrand" %>

<%@ Register Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" TagPrefix="CuteWebUI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">

        .uploadergrid {
           display: none !important;
       }

        .AjaxUploaderCancelAllButton {
           display: none !important;
       }

        div.RadListBox .rlbTransferTo,
        div.RadListBox .rlbTransferToDisabled,
        div.RadListBox .rlbTransferAllToDisabled,
        div.RadListBox .rlbTransferAllTo {
            display: none;
        }

        .title {
            font-size: 14px;
            padding-bottom: 0;
        }

        .list-containers .list-container {
            text-align: left;
            display: inline-block;
            vertical-align: top;
        }

        .background-silk .demo-container {
            background-color: #F3F3F3;
        }

        .list-container.size-thin {
            max-width: 380px;
        }

        .list-container {
            margin: 0 auto;
            padding: 10px;
            border: 1px solid #E2E4E7;
            background-color: #F5F7F8;
        }
    </style>

    <style>
        .form-group {
            margin-bottom: 10px;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">

        <div class="row">
            <div class="col-md-12">

                <div style="margin: 0 0 15px 0">
                    <h2>New Brand 
                    </h2>
                    <p>
                        Use this form to add a new brand.  Complete each section below and click on the Next button to continue to the next tab.<br />
                        Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                    </p>

                   

                </div>

                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

                     <asp:Label ID="msgLabel" runat="server" />

                    <div class="widget stacked">
                        <div class="widget-content min-height">



                            <asp:TextBox ID="tempGUID" runat="server" Visible="false" />

                            <telerik:RadWizard ID="NewBrandWizard" runat="server" DisplayCancelButton="true" DisplayProgressBar="false" Skin="Bootstrap">
                                <WizardSteps>
                                    <telerik:RadWizardStep Title="Information" ValidationGroup="information">
                                        <div class="col-md-12">

                                            <h3>Brand Information</h3>

                                            <hr />
                                            <div class="form-horizontal">

                                                <div class="form-group">
                                                    <label for="BrandNameTextBox" class="col-sm-2 control-label">Brand Name: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="BrandNameTextBox" runat="server" CssClass="form-control" />
                                                        <asp:RequiredFieldValidator ID="BrandNameTextBoxRequiredFieldValidator" runat="server"
                                                            ErrorMessage="This field is required." CssClass="errorlabel" ControlToValidate="BrandNameTextBox"
                                                            Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <%--<telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server">
                                         <div class="form-group">
                                            <label for="BrandNameTextBox" class="col-sm-2 control-label">Brand Group:</label>
                                            <div class="col-sm-6">
                                                <telerik:RadComboBox ID="BrandGroupList" runat="server" EmptyMessage="Select a Brand Group" DataSourceID="getBrandGroups" DataTextField="brandGroupName" DataValueField="brandGroupID" DropDownWidth="300px" Width="300px">
                                                    <FooterTemplate>

                                                         <div class="input-group">
                                                          <asp:TextBox ID="NewBrandGroupTextBox" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                          <span class="input-group-btn">
                                                            <asp:Button ID="btnAddBrandGroup" runat="server" Text="Add Group" CssClass="btn btn-primary btn-sm" OnClick="btnAddBrandGroup_Click" />
                                                          </span>
                                                        </div>

                                                    </FooterTemplate>
                                                </telerik:RadComboBox>
                                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getBrandGroups" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="brandGroupName" TableName="tblBrandGroups">
                                                </asp:LinqDataSource>
                                            </div>
                                        </div>
                                            </telerik:RadAjaxPanel>--%>

                                                <div class="form-group">
                                                   <%-- <label for="AssociatedSuppliersListBox" class="col-sm-2 control-label">Associated Suppliers:</label>--%>
                                                    <div class="col-sm-10">

<%--                                                        <div class="list-containers">

                                                            <div class="list-container size-thin">
                                                                <div class="title">
                                                                    Available Suppliers
                                                                </div>

                                                                <telerik:RadListBox ID="AvailableSuppliers" runat="server"
                                                                    DataSourceID="SqlDataSource2"
                                                                    DataKeyField="supplierID"
                                                                    DataTextField="supplierName"
                                                                    DataValueField="supplierID"
                                                                    DataSortField="supplierName"
                                                                    TransferToID="SelectedSuppliers"
                                                                    AllowTransferOnDoubleClick="true"
                                                                    EnableDragAndDrop="true"
                                                                    ButtonSettings-AreaWidth="35px" Height="200px" Width="230px"
                                                                    AutoPostBack="true"
                                                                    AllowTransfer="True"
                                                                    AutoPostBackOnTransfer="true" Skin="Bootstrap" Style="top: 0; left: 0">
                                                                    <ButtonSettings ShowTransferAll="false" />
                                                                </telerik:RadListBox>

                                                            </div>

                                                            <div class="list-container size-thin">

                                                                <div class="title">
                                                                    Associated Suppliers
                                                                </div>

                                                                <telerik:RadListBox ID="SelectedSuppliers" runat="server"
                                                                    DataKeyField="supplierID"
                                                                    DataTextField="supplierName"
                                                                    DataValueField="supplierID"
                                                                    DataSortField="supplierName"
                                                                    AllowDelete="True"
                                                                    AutoPostBack="true"
                                                                    AutoPostBackOnDelete="true"
                                                                    Height="200px" Width="225px" Skin="Bootstrap">
                                                                </telerik:RadListBox>

                                                            </div>

                                                              <asp:HiddenField ID="HF_SelectedItemID" runat="server" />

                                                            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                                                                ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                                                                SelectCommand="SELECT supplierID AS DataKeyID, supplierID AS InsertID, supplierID, supplierName FROM tblSupplier WHERE ((supplierID NOT IN (select supplierID from getAllSuppliersbyBrands where getAllSuppliersbyBrands.brandID = @brandID)) AND clientID = @clientID) ORDER BY supplierName">
                                                                <SelectParameters>
                                                                    <asp:QueryStringParameter Name="brandID" QueryStringField="BrandID" DefaultValue="0" />
                                                                    <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>

                                                        </div> here--%>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ActiveTextBox" class="col-sm-2 control-label">Active:</label>
                                                    <div class="col-sm-2">
                                                        <asp:DropDownList ID="ActiveTextBox" runat="server" CssClass="form-control" Width="150px">
                                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                        </asp:DropDownList>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="StartDateTextBox1" class="col-sm-2 control-label">Brand Start Date:</label>
                                                    <div class="col-sm-10">
                                                        <div class="form-inline">

                                                            <telerik:RadDatePicker ID="StartDateDatePicker" runat="server" Skin="Bootstrap"></telerik:RadDatePicker>

                                                            <label for="EndDateTextBox" class="control-label" style="padding-right: 15px; padding-left: 20px;">Brand End Date:</label>

                                                            <telerik:RadDatePicker ID="EndDateDatePicker" runat="server" Skin="Bootstrap"></telerik:RadDatePicker>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="DataViewEndDateTextBox" class="col-sm-2 control-label">Data View End Date:</label>
                                                    <div class="col-sm-2">
                                                        <telerik:RadDatePicker ID="DataViewEndDateDatePicker" runat="server" Skin="Bootstrap"></telerik:RadDatePicker>
                                                    </div>
                                                </div>

                                               <%-- <div class="form-group">
                                                            <label  class="col-sm-2 control-label">LMS School:</label>
                                                            <div class="col-sm-4">
                                                                <asp:DropDownList runat="server" ID="CourseList" DataSourceID="getCourseList" DataTextField="CourseTitle" DataValueField="CourseID" CssClass="form-control"  AutoPostBack="true" AppendDataBoundItems="true">
                                                                    <asp:ListItem Text="-- Select School --" Value=""></asp:ListItem>
                                                                </asp:DropDownList>

                                                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getCourseList" ContextTypeName="EventManagerApplication.LMSDataClassesDataContext" OrderBy="CourseTitle" TableName="Courses" Where="SiteID == @SiteID">
                                                                    <WhereParameters>
                                                                        <asp:Parameter DefaultValue="GigEngyn" Name="SiteID" Type="String"></asp:Parameter>
                                                                    </WhereParameters>
                                                                </asp:LinqDataSource>
                                                            </div>
                                                </div>--%>

                                                  <%--<div class="form-group">
                                                            <label  class="col-sm-2 control-label">Brand Training:</label>
                                                            <div class="col-sm-4">
                                                                <asp:DropDownList ID="CurriculumList" runat="server" DataSourceID="getCurriculumList" DataTextField="Title" DataValueField="CurriculumGroupID" 
                                                                        AppendDataBoundItems="true" CssClass="form-control">
                                                                    <asp:ListItem Text="-- Select Training Course --" Value=""></asp:ListItem>
                                                                </asp:DropDownList>


                                                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getCurriculumList" ContextTypeName="EventManagerApplication.LMSDataClassesDataContext" OrderBy="Title" TableName="CurriculumGroups" Where="CourseID == @CourseID">
                                                                    <WhereParameters>
                                                                        <asp:ControlParameter ControlID="CourseList" PropertyName="SelectedValue" Name="CourseID" Type="String"></asp:ControlParameter>
                                                                    </WhereParameters>
                                                                </asp:LinqDataSource>
                                                            </div>

                                                 </div>--%>

                                            </div>
                                        </div>

                                    </telerik:RadWizardStep>

                                    <telerik:RadWizardStep Title="Event Execution">
                                        <div class="col-md-12">
                                            <h3>Event Execution</h3>
                                            <p>
                                                Click on the <strong>Add New Item</strong> button on the right to add Event Execution items to this brand.
                                            </p>
                                            <hr />
                                            <telerik:RadListView ID="EventExecutionList" runat="server" DataKeyNames="tempBrandEventExecutionID"
                                                DataSourceID="getBrandExecutionList" InsertItemPosition="FirstItem">
                                                <LayoutTemplate>
                                                    <div>
                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                                    CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New Item</asp:LinkButton>
                                                            </div>
                                                        </div>
                                                        <div id="itemPlaceholder" runat="server">
                                                        </div>
                                                    </div>
                                                </LayoutTemplate>
                                                <ItemTemplate>
                                                    <div>
                                                        <h3>
                                                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-xs btn-primary" ToolTip="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                                                            <asp:Label ID="eventTypeIDLabel" runat="server" Font-Bold="true" Text='<%# getEventTypeTitle(Eval("eventTypeID")) %>' />
                                                        </h3>
                                                    </div>

                                                    <div class="col-sm-3">
                                                        <strong>Attire:</strong>
                                                        <div class="panel panel-default eqbox">
                                                            <div class="panel-body">
                                                                <asp:Label ID="attireLabel" runat="server" Text='<%# Eval("attire") %>' />
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="col-sm-3">
                                                        <strong>POS:</strong>
                                                        <div class="panel panel-default eqbox">
                                                            <div class="panel-body">
                                                                <asp:Label ID="posLabel" runat="server" Text='<%# Eval("pos") %>' />
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="col-sm-3">
                                                        <strong>Sampling Instructions:</strong>
                                                        <div class="panel panel-default eqbox">
                                                            <div class="panel-body">
                                                                <asp:Label ID="samplingInstructionsLabel" runat="server" Text='<%# Eval("samplingInstructions") %>' />
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="col-sm-3">
                                                        <strong>Event Details:</strong>
                                                        <div class="panel panel-default eqbox">
                                                            <div class="panel-body">
                                                                <asp:Label ID="eventDetailsLabel" runat="server" Text='<%# Eval("eventDetails") %>' />
                                                            </div>
                                                        </div>

                                                    </div>
                                                    
                                                </ItemTemplate>

                                                <EditItemTemplate>
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <div class="col-sm-3" style="margin-bottom: 15px;">
                                                                <strong>Type: </strong>
                                                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="getEventTypeList" SelectedValue='<%# Bind("eventTypeID")%>'
                                                                    DataTextField="eventTypeName" DataValueField="eventTypeID" CssClass="form-control">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-sm-12">

                                                            <div class="col-sm-3">
                                                                <strong>Attire:</strong>
                                                                <asp:TextBox ID="attireTextBox" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" Text='<%# Bind("attire") %>' />
                                                            </div>

                                                            <div class="col-sm-3">
                                                                <strong>POS:</strong>
                                                                <asp:TextBox ID="posTextBox" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" Text='<%# Bind("pos") %>' />
                                                            </div>

                                                            <div class="col-sm-3">
                                                                <strong>Sampling Instructions:</strong>
                                                                <asp:TextBox ID="samplingInstructionsTextBox" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" Text='<%# Bind("samplingInstructions") %>' />
                                                            </div>

                                                            <div class="col-sm-3">
                                                                <strong>Event Details:</strong>
                                                                <asp:TextBox ID="eventDetailsTextBox" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" Text='<%# Bind("eventDetails") %>' />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div style="padding: 15px 0 15px 0;">
                                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Update" />
                                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                                                    </div>

                                                    <hr />


                                                </EditItemTemplate>
                                                <InsertItemTemplate>

                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <div class="col-sm-3" style="margin-bottom: 15px;">
                                                                <strong>Type: </strong>
                                                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="getEventTypeList" SelectedValue='<%# Bind("eventTypeID")%>'
                                                                    DataTextField="eventTypeName" DataValueField="eventTypeID" CssClass="form-control" AppendDataBoundItems="true">
                                                                    <asp:ListItem Text="-- Select Event Type --" Value=""></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-sm-12">

                                                            <div class="col-sm-3">
                                                                <strong>Attire:</strong>
                                                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" Text='<%# Bind("attire") %>' />
                                                            </div>

                                                            <div class="col-sm-3">
                                                                <strong>POS:</strong>
                                                                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" Text='<%# Bind("pos") %>' />
                                                            </div>

                                                            <div class="col-sm-3">
                                                                <strong>Sampling Instructions:</strong>
                                                                <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" Text='<%# Bind("samplingInstructions") %>' />
                                                            </div>

                                                            <div class="col-sm-3">
                                                                <strong>Event Details:</strong>
                                                                <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" Text='<%# Bind("eventDetails") %>' />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div style="padding: 15px 0 15px 0;">
                                                        <asp:Button ID="btnInsert" runat="server" CommandName="PerformInsert" CssClass="btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" />
                                                        <asp:Button ID="btnCancelInsert" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                                                    </div>

                                                    <hr />

                                                </InsertItemTemplate>
                                                <EmptyDataTemplate>
                                                    <div class="RadListView RadListView_Default">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <asp:LinkButton ID="btnInsert2" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>" CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New Item
                                                                    </asp:LinkButton>
                                                                </div>
                                                            </div>

                                                            <br />

                                                            <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Item</strong> button above.</div> 
                                                    </div>
                                                </EmptyDataTemplate>

                                            </telerik:RadListView>
                                        </div>


                                        <asp:LinqDataSource ID="getEventTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="eventTypeName" TableName="qryEventTypeByClients" Where="clientID == @clientID">
                                            <WhereParameters>
                                                <asp:QueryStringParameter Name="clientID" QueryStringField="ClientID" Type="Int32" />
                                            </WhereParameters>
                                        </asp:LinqDataSource>

                                        <asp:LinqDataSource ID="getBrandExecutionList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tempBrandEventExecutions" Where="tempBrandID == @tempBrandID">
                                            <WhereParameters>
                                                <asp:ControlParameter ControlID="tempGUID" DbType="String" Name="tempBrandID" PropertyName="text" />
                                            </WhereParameters>
                                        </asp:LinqDataSource>
                                    </telerik:RadWizardStep>
                                  
                                    


                                    

                                    <telerik:RadWizardStep Title="Event Tasks">

                                        <div class="col-md-12">
                                            <h3>Event Tasks</h3>
                                            <hr />

                                            <telerik:RadListView ID="BrandEventTaskList" runat="server"
                                                DataKeyNames="tempTaskID" DataSourceID="getBrandEventTasks" InsertItemPosition="LastItem">
                                                <LayoutTemplate>
                                                    <div class="RadListView RadListView_Default">
                                                        <table class="table" cellspacing="0" style="width: 100%;">
                                                            <thead>
                                                                <tr>
                                                                    <th>&nbsp;</th>
                                                                    <th>Task</th>
                                                                    <th>Category</th>
                                                                    <th>Date Due Offset</th>
                                                                    <th>&nbsp;</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr id="itemPlaceholder" runat="server">
                                                                </tr>
                                                            </tbody>
                                                            <tfoot>
                                                                <asp:LinkButton ID="btnInsert2" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                                    CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New Task</asp:LinkButton>
                                                            </tfoot>
                                                        </table>
                                                    </div>
                                                </LayoutTemplate>
                                                <ItemTemplate>
                                                    <tr class="rlvI">
                                                        <td>
                                                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-xs btn-primary" Text="Edit" ToolTip="Edit" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="TaskNameLabel" runat="server" Text='<%#(Eval("taskName"))%>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="CategoryLabel" runat="server" Text='<%# (Eval("category"))%>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="dateDueOffSetLabel" runat="server" Text='<%# Eval("DateDueOffSet")%>' />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" Text="Delete" ToolTip="Delete" />
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>

                                                <EditItemTemplate>
                                                    <tr class="rlvIEdit">
                                                        <td></td>
                                                        <td>
                                                            <asp:TextBox ID="taskNameTextBox" runat="server" Text='<%# Bind("taskName")%>' CssClass="form-control"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("category")%>'>
                                                                <asp:ListItem Text="Task" Value="Task"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlEndTimeOffSet" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("dateDueOffSet")%>'>
                                                                <asp:ListItem Value='0'>0 minutes</asp:ListItem>
                                                                <asp:ListItem Value='-120'>120 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='-90'>90 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='-60'>60 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='-45'>45 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='-30'>30 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='-15'>15 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='15'>15 minutes after</asp:ListItem>
                                                                <asp:ListItem Value='30'>30 minutes after</asp:ListItem>
                                                                <asp:ListItem Value='45'>45 minutes after</asp:ListItem>
                                                                <asp:ListItem Value='60'>60 minutes after</asp:ListItem>
                                                                <asp:ListItem Value='90'>90 minutes after</asp:ListItem>
                                                                <asp:ListItem Value='120'>120 minutes after</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Update" />
                                                            <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                                                        </td>

                                                    </tr>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <tr class="rlvIEdit">

                                                        <td></td>
                                                        <td>
                                                            <asp:TextBox ID="taskNameTextBox" runat="server" Text='<%# Bind("taskName")%>' CssClass="form-control"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("category")%>'>
                                                                <asp:ListItem Text="Task" Value="Task"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlEndTimeOffSet" runat="server" CssClass="form-control input-sm" SelectedValue='<%# Bind("dateDueOffSet")%>'>
                                                                <asp:ListItem Value='0'>0 minutes</asp:ListItem>
                                                                <asp:ListItem Value='-120'>120 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='-90'>90 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='-60'>60 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='-45'>45 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='-30'>30 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='-15'>15 minutes prior</asp:ListItem>
                                                                <asp:ListItem Value='15'>15 minutes after</asp:ListItem>
                                                                <asp:ListItem Value='30'>30 minutes after</asp:ListItem>
                                                                <asp:ListItem Value='45'>45 minutes after</asp:ListItem>
                                                                <asp:ListItem Value='60'>60 minutes after</asp:ListItem>
                                                                <asp:ListItem Value='90'>90 minutes after</asp:ListItem>
                                                                <asp:ListItem Value='120'>120 minutes after</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" />
                                                            <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                                                        </td>


                                                    </tr>
                                                </InsertItemTemplate>
                                                <EmptyDataTemplate>
                                                    <div class="RadListView RadListView_Default">
                                                        <table class="table" cellspacing="0" style="width: 100%;">
                                                            <thead>
                                                                <tr>
                                                                    <th>&nbsp;</th>
                                                                    <th>Task</th>
                                                                    <th>Category</th>
                                                                    <th>Date Due Offset</th>
                                                                    <th>&nbsp;</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td colspan="5">
                                                                        <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Task</strong> button above.</div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                            <tfoot>
                                                                <asp:LinkButton ID="btnInsert1" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                                    CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New Task</asp:LinkButton>
                                                            </tfoot>
                                                        </table>


                                                    </div>
                                                </EmptyDataTemplate>

                                            </telerik:RadListView>


                                            <asp:LinqDataSource ID="getBrandEventTasks" runat="server"
                                                ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName=""
                                                TableName="tempBrandEventTasks" Where="tempBrandID == @tempBrandID">
                                                <WhereParameters>
                                                    <asp:ControlParameter ControlID="tempGUID" Name="tempBrandID" Type="String" PropertyName="Text" />
                                                </WhereParameters>
                                            </asp:LinqDataSource>


                                        </div>

                                    </telerik:RadWizardStep>

                                    <%--<telerik:RadWizardStep Title="Documents"></telerik:RadWizardStep>--%>

                                    <telerik:RadWizardStep Title="Recap Questions">
                                        <div class="col-md-12">
                                            <h3>Recap Questions</h3>
                                            <hr />
                                            <asp:Panel ID="RecapListPanel" runat="server">


                                                <telerik:RadListView ID="BrandRecapList" runat="server"
                                                    DataKeyNames="tempBrandRecapQuestionID" InsertItemPosition="FirstItem" DataSourceID="getBrandRecapQuestionList">
                                                    <LayoutTemplate>
                                                        <div class="RadListView RadListView_Default">
                                                            <table class="table" cellspacing="0" style="width: 100%;">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Recap Question</th>
                                                                        <th>Question Type</th>
                                                                        <th></th>
                                                                        <th></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr id="itemPlaceholder" runat="server">
                                                                    </tr>
                                                                </tbody>
                                                                <tfoot>
                                                                    <asp:LinkButton ID="btnInsert1" runat="server" CommandName="AddQuestion" Visible="<%# Not Container.IsItemInserted %>"
                                                                        CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Recap Question</asp:LinkButton>
                                                                </tfoot>
                                                            </table>
                                                        </div>
                                                    </LayoutTemplate>
                                                    <ItemTemplate>
                                                        <tr class="rlvI">
                                                            <td>


                                                                <asp:Label ID="questionLabel" runat="server" Text='<%# Eval("question")%>' />
                                                            </td>
                                                            <td>
                                                                <%# Eval("questionType")%>
                                                            </td>
                                                            <td></td>
                                                            </td>

                    <td>
                        <div class="pull-right">

                            <asp:LinkButton ID="DeleteButton1" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" ToolTip="Delete" OnClientClick="javascript:if(!confirm('This action will delete the selected question. Are you sure?')){return false;}"><i class="fa fa-trash"></i> Delete</asp:LinkButton>
                        </div>
                    </td>
                                                        </tr>
                                                    </ItemTemplate>

                                                    <EditItemTemplate>
                                                        <tr class="rlvIEdit">

                                                            <td colspan="4">

                                                                <div class="form-horizontal">
                                                                    <div class="form-group">
                                                                        <label for="ColumnNameTextBox" class="col-sm-2 control-label">Question</label>
                                                                        <div class="col-sm-8">
                                                                            <asp:TextBox ID="ColumnNameTextBox" runat="server" Text='<%# Bind("question")%>' CssClass="form-control" />
                                                                        </div>
                                                                    </div>



                                                                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Update" />
                                                                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />

                                                                </div>




                                                            </td>


                                                        </tr>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <tr class="rlvIEdit">


                                                            <td colspan="4">
                                                                <div class="form-horizontal">
                                                                    <div class="form-group">
                                                                        <label for="ColumnNameTextBox" class="col-sm-2 control-label">Question</label>
                                                                        <div class="col-sm-8">
                                                                            <asp:TextBox ID="ColumnNameTextBox" runat="server" Text='<%# Bind("question")%>' CssClass="form-control" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label for="accountNameTextBox" class="col-sm-2 control-label">Column Type</label>
                                                                        <div class="col-sm-10">
                                                                            <asp:RadioButtonList ID="columnTypeList" runat="server" AutoPostBack="true">
                                                                                <asp:ListItem Text="Single line of text" Value="text"></asp:ListItem>
                                                                                <asp:ListItem Text="Multiple lines of text" Value="multiline"></asp:ListItem>
                                                                                <asp:ListItem Text="Choice" Value="choice"></asp:ListItem>
                                                                                <asp:ListItem Text="Number" Value="number"></asp:ListItem>
                                                                                <asp:ListItem Text="Date" Value="date"></asp:ListItem>
                                                                                <asp:ListItem Text="Currency" Value="currency"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </div>
                                                                    </div>

                                                                    <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" />
                                                                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />

                                                                </div>
                                                            </td>


                                                        </tr>
                                                    </InsertItemTemplate>
                                                    <EmptyDataTemplate>
                                                        <div class="RadListView RadListView_Default">
                                                            <table class="table" cellspacing="0" style="width: 100%;">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Recap Question</th>
                                                                        <th>Question Type</th>
                                                                        <th></th>
                                                                        <th></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td colspan="5">
                                                                            <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Question</strong> button above.</div>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                                <tfoot>
                                                                    <asp:LinkButton ID="btnInsert4" runat="server" CommandName="AddQuestion" Visible="<%# Not Container.IsItemInserted %>"
                                                                        CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New Question</asp:LinkButton>
                                                                </tfoot>
                                                            </table>


                                                        </div>
                                                    </EmptyDataTemplate>

                                                </telerik:RadListView>

                                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getBrandRecapQuestionList" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" TableName="tempBrandRecapQuestions" Where="tempBrandID == @tempBrandID">
                                                    <WhereParameters>
                                                        <asp:ControlParameter ControlID="tempGUID" Name="tempBrandID" Type="String" PropertyName="Text" />
                                                    </WhereParameters>
                                                </asp:LinqDataSource>

                                            </asp:Panel>


                                            <asp:Panel ID="NewRecapQuestionPanel" runat="server" Visible="false" Style="margin-top: 15px;">



                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label for="ColumnNameTextBox" class="col-sm-2 control-label">Question</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="ColumnNameTextBox" runat="server" CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="RequiredFieldTextBox" class="col-sm-2 control-label">Required Field</label>
                                                        <div class="col-sm-8">
                                                            <asp:RadioButtonList ID="RequiredFieldTextBox" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                                <asp:ListItem Text="No" Value="False" Selected="True"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                            <span id="helpBlock2" class="help-block">Require that this column contains information.</span>



                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="columnTypeList" class="col-sm-2 control-label">Column Type</label>
                                                        <div class="col-sm-10">
                                                            <asp:RadioButtonList ID="columnTypeList" runat="server" AutoPostBack="true">
                                                                <asp:ListItem Text="Single line of text" Value="text"></asp:ListItem>
                                                                <asp:ListItem Text="Multiple lines of text" Value="multiline"></asp:ListItem>
                                                                <asp:ListItem Text="Yes/No (check box)" Value="yes/no"></asp:ListItem>
                                                                <asp:ListItem Text="Choice (menu to choose from)" Value="choice"></asp:ListItem>
                                                                <asp:ListItem Text="Number (1, 1.0, 100)" Value="number"></asp:ListItem>
                                                                <asp:ListItem Text="Date" Value="date"></asp:ListItem>
                                                                <asp:ListItem Text="Time" Value="time"></asp:ListItem>
                                                                <asp:ListItem Text="Currency ($)" Value="currency"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                    </div>



                                                    <!-- Text Option -->
                                                    <asp:Panel ID="DescriptionPanel" runat="server">
                                                        <div class="form-group">
                                                            <label for="txtDescription" class="col-sm-2 control-label">Description Text</label>
                                                            <div class="col-sm-8">
                                                                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control"></asp:TextBox>
                                                                <span id="helpBlock" class="help-block">Specify detailed options for the type of information you selected.</span>
                                                            </div>
                                                        </div>

                                                    </asp:Panel>

                                                    <!-- Multiple Lines Option -->
                                                    <asp:Panel ID="MultilinePanel" runat="server" Visible="false">
                                                        <div class="form-group">
                                                            <label for="txtLines" class="col-sm-2 control-label">Number of lines for text</label>
                                                            <div class="col-sm-6">
                                                                <asp:TextBox ID="txtLines" runat="server" Text="6" CssClass="form-control"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </asp:Panel>


                                                    <!-- Choice Option -->
                                                    <asp:Panel ID="ChoicePanel" runat="server" Visible="false">

                                                        <div class="form-group">
                                                            <label for="txtChioces" class="col-sm-2 control-label">Choices</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtChioces" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control"></asp:TextBox>
                                                                <span id="helpBlock3" class="help-block">Type each choice on a separate line.</span>


                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="DisplayOptions" class="col-sm-2 control-label">Display Options</label>
                                                            <div class="col-sm-10">
                                                                <asp:RadioButtonList ID="DisplayOptions" runat="server">
                                                                    <asp:ListItem Selected="True" Text="Drop-Down Menu" Value="drop"></asp:ListItem>
                                                                    <asp:ListItem Text="Radio Buttons" Value="radio"></asp:ListItem>
                                                                    <asp:ListItem Text="Checkboxes (allow multiple selections)" Value="check"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </div>

                                                    </asp:Panel>

                                                    <!-- Choice Option -->
                                                    <asp:Panel ID="YesNoPanel" runat="server" Visible="false">

                                                        <div class="form-group">
                                                            <label for="ckbYesNo" class="col-sm-2 control-label">Default Value</label>
                                                            <div class="col-sm-4">

                                                                <asp:RadioButtonList ID="ckbYesNo" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Text="Yes" Selected="True"></asp:ListItem>
                                                                    <asp:ListItem Text="No"></asp:ListItem>
                                                                </asp:RadioButtonList>


                                                            </div>
                                                        </div>
                                                    </asp:Panel>


                                                    <!-- Number Option -->
                                                    <asp:Panel ID="NumberPanel" runat="server" Visible="false">

                                                        <div class="form-group">
                                                            <label for="txtDecimalPlace" class="col-sm-2 control-label">Number of decimal places</label>
                                                            <div class="col-sm-1">
                                                                <asp:DropDownList ID="txtDecimalPlace" runat="server" CssClass="form-control">
                                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="txtDefaultNumber" class="col-sm-2 control-label">Default value</label>
                                                            <div class="col-sm-1">
                                                                <asp:TextBox ID="txtDefaultNumber" runat="server" CssClass="form-control"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="DisplayOptions" class="col-sm-2 control-label">Show as percentage</label>
                                                            <div class="col-sm-10">
                                                                <asp:RadioButtonList ID="ckbPercentage" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                                    <asp:ListItem Text="No" Selected="True" Value="False"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                                (for example, 50%)
                                                            </div>
                                                        </div>

                                                    </asp:Panel>

                                                    <!-- Date Option -->
                                                    <asp:Panel ID="DatePanel" runat="server" Visible="false">
                                                        <div class="form-group">
                                                            <label for="ckbDateFormat" class="col-sm-2 control-label">Date and Time Format</label>
                                                            <div class="col-sm-10">
                                                                <asp:RadioButtonList ID="ckbDateFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Text="Date Only" Selected="True" Value="Date"></asp:ListItem>
                                                                    <asp:ListItem Text="Date & Time" Value="DateTime"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>

                                                        </div>

                                                        <div class="form-group">
                                                            <label for="DisplayOptions" class="col-sm-2 control-label">Display Format</label>
                                                            <div class="col-sm-10">
                                                                <asp:RadioButtonList ID="ckbDateDisplayFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Text="Standard" Selected="True"></asp:ListItem>
                                                                    <asp:ListItem Text="Friendly"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>

                                                        </div>

                                                        <div class="form-group">
                                                            <label for="ckbDateDefualtValue" class="col-sm-2 control-label">Default Value</label>
                                                            <div class="col-sm-10">
                                                                <asp:RadioButtonList ID="ckbDateDefualtValue" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Text="None" Selected="True" Value="None"></asp:ListItem>
                                                                    <asp:ListItem Text="Current Date" Value="Current"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>

                                                        </div>

                                                    </asp:Panel>

                                                    <!-- Date Option -->
                                                    <asp:Panel ID="TimePanel" runat="server" Visible="false">
                                                        <div class="form-group">
                                                            <label for="ckbTimeFormat" class="col-sm-2 control-label">Time Format</label>
                                                            <div class="col-sm-10">
                                                                <asp:RadioButtonList ID="ckbTimeFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Text="12 hours" Selected="True"></asp:ListItem>
                                                                    <asp:ListItem Text="24 hours"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>

                                                        </div>
                                                    </asp:Panel>

                                                    <!-- Currency Option -->
                                                    <asp:Panel ID="CurrencyPanel" runat="server" Visible="false">
                                                    </asp:Panel>


                                                    <div class="form-group">
                                                        <label for="accountNameTextBox" class="col-sm-2 control-label"></label>
                                                        <div class="col-sm-6">
                                                            <asp:Button ID="btnUpdateQuestion" runat="server" Text="Update" CssClass="btn btn-primary" Visible="false" />
                                                            <asp:Button ID="btnInsertQuestion" runat="server" Text="Save" CssClass="btn btn-primary" />
                                                            <asp:Button ID="btnCancelNewQuestion" runat="server" Text="Cancel" CssClass="btn btn-default" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <asp:Label ID="msg" runat="server" />

                                            </asp:Panel>
                                        </div>
                                    </telerik:RadWizardStep>

                                    <%--  <telerik:RadWizardStep Title="POS">
                                        <div class="col-md-12">
                                            <h3>Point of Sale</h3>
                                            <hr />

                                        </div>
                                    </telerik:RadWizardStep>--%>
                                </WizardSteps>
                            </telerik:RadWizard>

                        </div>
                    </div>
                </telerik:RadAjaxPanel>
            </div>

        </div>

    </div>

</asp:Content>
