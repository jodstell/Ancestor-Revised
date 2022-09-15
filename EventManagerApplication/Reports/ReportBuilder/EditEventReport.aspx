<%@ Page Title="Edit Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditEventReport.aspx.vb" Inherits="EventManagerApplication.EditEventReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="EventTypeComboBox">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RecapPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="RecapCheckBox">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RecapPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" />

    <link href="/Theme/css/custom1.css" rel="stylesheet" />
    <link href="css/CustomEvents.css" rel="stylesheet" />

     <style>
        .multiColumn ul
        {
            width:100%;
        }

        .multiColumn li
        {
            float:left;
            width:25%;
        }

        .form-group {
            margin-bottom: 10px !important;
        }

         .RadListBox RadListBox_Bootstrap {
             overflow: auto;
         }






     .label-standard {
            background-color: #000;
        }

        .form-group {
            margin-bottom: 10px;
        }


        .rlvI1 {
            font-size: 24px;
            border-bottom: 0 solid;
            padding-top: 5px;
            padding-bottom: 3px;
        }

        .rlvIEdit1 {
            width: 400px;
            margin: 15px;
        }

        .RadListView_Metro {
            margin: 5px;
        }

        .RadListView div.rlvI, .RadListView div.rlvA, .RadListView div.rlvISel, .RadListView div.rlvIEmpty, .RadListView div.rlvIEdit1 {
            border-bottom: 0 solid;
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

    <div class="container">

        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard - Report Builder</h2>
                <hr />
            </div>
        </div>

    <div class="col-md-12">

        <asp:HiddenField ID="HiddenEventTypeID" runat="server" />

        <h3>Edit Report: <asp:Label ID="SelectedReportLabel" runat="server"></asp:Label></h3>

        <hr />
         <div class="row">
            <div class="col-md-12">
                <div class="btn-group" role="group" aria-label="...">
                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-success btn-sm"><i class="fa fa-check-square-o" aria-hidden="true"></i> Save Report</asp:LinkButton>
                <asp:LinkButton ID="btnSaveAsNew" runat="server" CssClass="btn btn-primary btn-sm"><i class="fa fa-plus-square" aria-hidden="true"></i> Save As New Report</asp:LinkButton>
                <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-sm"><i class="fa fa-trash" aria-hidden="true"></i> Delete</asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-default btn-sm">Cancel</asp:LinkButton>
                </div>

            </div>
          </div>

        <hr />




        <div class="form-horizontal">

            <div class="form-group">
                <label for="ReportNameTextBox" class="col-sm-2 control-label">Report Name</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="ReportNameTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label for="DescriptionTextBox" class="col-sm-2 control-label">Description</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="DescriptionTextBox" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">Settings</label>
                <div class="col-sm-10">
                    <div>

                        <ul id="myTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                            <li class="active" runat="server" id="filterTab"><a href="#filter" data-toggle="tab">Filters</a></li>
                            <li class="" runat="server" id="columnsTab"><a href="#columns" data-toggle="tab">Columns</a></li>
                            <li class="" runat="server" id="marketsTab"><a href="#markets" data-toggle="tab">Markets</a></li>
                            <li class="" runat="server" id="recapsTab"><a href="#recaps" data-toggle="tab">Recaps</a></li>
                            <li class="" runat="server" id="brandsTab"><a href="#brands" data-toggle="tab">Brands</a></li>
                            <li class="" runat="server" id="trackingTab"><a href="#tracking" data-toggle="tab">Event Tracking</a></li>
                            <li class="" runat="server" id="attributesTab"><a href="#attributes" data-toggle="tab">Attributes</a></li>
                            <%--<li class="" runat="server" id="permissionsTab"><a href="#permission" data-toggle="tab">Permissions</a></li>--%>

                        </ul>

                        <div class="tab-content">

                            <div class="tab-pane fade active in" id="filter">
                                <div class="widget stacked">
                                    <div class="widget-content">

                                        <div class="row">
                                            <div class="col-md-5">
                                            <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="FromDatePicker" class="col-sm-4 control-label">Start Date</label>
                                                <div class="col-sm-8">
                                                    <telerik:RadDatePicker ID="FromDatePicker" runat="server">
                                                        <Calendar runat="server">
                                                            <SpecialDays>
                                                                <telerik:RadCalendarDay Repeatable="Today">
                                                                    <ItemStyle CssClass="rcToday" />
                                                                </telerik:RadCalendarDay>
                                                            </SpecialDays>
                                                        </Calendar>
                                                    </telerik:RadDatePicker>
                                                </div>
                                            </div>


                                            <div class="form-group">
                                                <label for="ToDatePicker" class="col-sm-4 control-label">End Date</label>
                                                <div class="col-sm-8">
                                                    <telerik:RadDatePicker ID="ToDatePicker" runat="server">
                                                        <Calendar runat="server">
                                                            <SpecialDays>
                                                                <telerik:RadCalendarDay Repeatable="Today">
                                                                    <ItemStyle CssClass="rcToday" />
                                                                </telerik:RadCalendarDay>
                                                            </SpecialDays>
                                                        </Calendar>
                                                    </telerik:RadDatePicker>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="SupplierComboBox" class="col-sm-4 control-label">Supplier</label>
                                                <div class="col-sm-8">
                                                    <telerik:RadComboBox ID="SupplierComboBox" runat="server" DataSourceID="getSupplierList" DataTextField="supplierName" DataValueField="supplierID" Width="200px" AppendDataBoundItems="true">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="- All Suppliers -" Value="0" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getSupplierList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="supplierName" TableName="tblSuppliers" Where="clientID == @clientID">
                                                        <WhereParameters>
                                                            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="AccountListBox" class="col-sm-4 control-label">Event Status</label>
                                                <div class="col-sm-8">
                                                    <telerik:RadListBox RenderMode="Lightweight" ID="EventStatusListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="200px"
                                                        DataTextField="statusName" DataValueField="statusID" DataSourceID="getEventStatus">
                                                    </telerik:RadListBox>

                                                    <span id="helpBlock" class="help-block">All will show if none are selected. </span>

                                                </div>
                                            </div>

                                            <asp:LinqDataSource ID="getEventStatus" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="statusName" TableName="tblStatus"></asp:LinqDataSource>


                                        </div>
                                            </div>

                                            <div class="col-md-6">
<div class="form-horizontal">
                                            <div class="form-group">
                                            <label for="AccountListBox" class="col-sm-3 control-label">Event Type</label>
                                                <div class="col-sm-8">
                                                    <telerik:RadListBox RenderMode="Lightweight" ID="EventTypeRadListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="300px" Height="350px"
                                                        DataTextField="eventTypeName" DataValueField="eventTypeID" DataSourceID="getEventTypes">
                                                    </telerik:RadListBox>

                                                    <span id="helpBlock1" class="help-block">All will show if none are selected. </span>
                                                </div>
                                            </div>

    <asp:LinqDataSource ID="getEventTypes" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="eventTypeName" TableName="qryEventTypeByClients" Where="clientID == @clientID">
        <WhereParameters>
           <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
        </WhereParameters>
    </asp:LinqDataSource>
                                        </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="columns">
                                <div class="widget stacked">
                                    <div class="widget-content">


                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label for="EventListBox" class="col-sm-2 control-label">Event Fields</label>
                                                <div class="col-sm-10">
                                                    <telerik:RadListBox RenderMode="Lightweight" ID="EventListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="200px"
                                                        DataTextField="fieldTitle" DataValueField="fieldName" DataSourceID="getEventDateFields">
                                                    </telerik:RadListBox>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="AccountListBox" class="col-sm-2 control-label">Account Fields</label>
                                                <div class="col-sm-10">
                                                    <telerik:RadListBox RenderMode="Lightweight" ID="AccountListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="200px"
                                                        DataTextField="fieldTitle" DataValueField="fieldName" DataSourceID="getAccountDataFields">
                                                    </telerik:RadListBox>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="AccountListBox" class="col-sm-2 control-label">Ambassador Fields</label>
                                                <div class="col-sm-10">
                                                    <telerik:RadListBox RenderMode="Lightweight" ID="AmbassadorListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="200px"
                                                        DataTextField="fieldTitle" DataValueField="fieldName" DataSourceID="getAmbassadorDataFields">
                                                    </telerik:RadListBox>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="markets">
                                <div class="widget stacked">
                                    <div class="widget-content">
                                        <div class="form-horizontal">


                                            <div class="form-group">
                                                <label for="MarketListBox" class="col-sm-2 control-label">Markets</label>
                                                <div class="col-sm-10">
                                                    <telerik:RadListBox RenderMode="Lightweight" ID="MarketListBox" runat="server" CheckBoxes="true" Style="top: 0px; left: 0px" Width="100%"
                                                        DataTextField="marketName" DataValueField="marketID" DataSourceID="getMarkets" CssClass="multiColumn">
                                                    </telerik:RadListBox>

                                                    <span id="helpBlock1" class="help-block">All will show if none are selected. </span>

                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getMarkets" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="marketName" TableName="tblMarkets"></asp:LinqDataSource>
                                                </div>
                                            </div>



                                        </div>
                                    </div>
                                </div>
                            </div>

                             <div class="tab-pane fade" id="recaps">
                                <asp:Panel runat="server" ID="RecapPanel">
                                <div class="widget stacked">
                                    <div class="widget-content">
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="" class="col-sm-2 control-label">Report Type</label>
                                                <div class="col-sm-10" style="padding-top:5px;">
                                                    <asp:CheckBox ID="RecapCheckBox" runat="server" Text="Recap" AutoPostBack="true" />
                                                    <span id="helpBlock4" class="help-block">Select to enable recap questions.</span>
                                                </div>



                                            </div>


                                            <div class="form-group">
                                                <label for="RecapListBox" class="col-sm-2 control-label">Default Questions</label>
                                                <div class="col-sm-10">
                                                    <telerik:RadListBox RenderMode="Lightweight" ID="RecapListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="500px"
                                                        DataTextField="reportColumn" DataValueField="QuestionID" DataSourceID="getRecapQuestions">
                                                    </telerik:RadListBox>
                                                </div>
                                            </div>



                                            <div class="form-group">
                                                <label for="EventTypeComboBox" class="col-sm-2 control-label">Event Type</label>
                                                <div class="col-sm-10">

                                                    <telerik:RadComboBox ID="EventTypeComboBox" runat="server" DataSourceID="getEventTypeList" DataTextField="eventTypeName" DataValueField="eventTypeID" AppendDataBoundItems="true" AutoPostBack="true">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="Select Event Type" Value="0" />
                                                        </Items>
                                                    </telerik:RadComboBox>

                                                    <span id="helpBlock3" class="help-block">Event Type is required in order to show recap questions.</span>


                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getEventTypeList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblEventTypes"></asp:LinqDataSource>
                                                </div>
                                            </div>


                                            <div class="form-group">
                                                <label for="EventTypeComboBox" class="col-sm-2 control-label">Recap Questions</label>
                                                <div class="col-sm-10">
                                                    <telerik:RadListBox ID="EventTypeRecapQuestionsListBox" runat="server" CheckBoxes="True" DataSourceID="getEventTypeRecapQuestions"
                                                         DataTextField="question" DataValueField="eventTypeRecapQuestionID" EmptyMessage="Select Event Type from above."></telerik:RadListBox>

                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getEventTypeRecapQuestions" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblEventTypeRecapQuestions" Where="clientID == @clientID && eventTypeID == @eventTypeID">
                                                        <WhereParameters>
                                                            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                                            <asp:ControlParameter ControlID="HiddenEventTypeID" PropertyName="Value" Name="eventTypeID" Type="Int32"></asp:ControlParameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                                </asp:Panel>
                            </div>


                            <div class="tab-pane fade" id="brands">
                                <asp:Panel runat="server" ID="Panel1">
                                    <div class="widget stacked">
                                        <div class="widget-content">
                                            <div class="form-horizontal">
                                                 <div class="form-group">
                                                <label for="RecapListBox" class="col-sm-2 control-label">Brands</label>
                                                <div class="col-sm-10">
                                                   <telerik:RadListBox RenderMode="Lightweight" ID="BrandsListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="500px" AutoPostBack="true"
                                                        DataTextField="brandName" DataValueField="brandID">
                                                    </telerik:RadListBox>

                                                   
                                                </div>
                                            </div>
                                            </div>



                                             <div class="form-horizontal">
                                                 <div class="form-group">
                                                <label for="RecapListBox" class="col-sm-2 control-label">Recap Questions</label>
                                                <div class="col-sm-10">
                                                   <telerik:RadListBox RenderMode="Lightweight" ID="BrandRecapQuestionListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="100%" EmptyMessage="There are no recap questions."
                                                        DataTextField="question" DataValueField="brandRecapQuestionID">
                                                    </telerik:RadListBox>

                                                   
                                                </div>
                                            </div>
                                            </div>


                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>


                            <div class="tab-pane fade" id="tracking">
                                <div class="widget stacked">
                                    <div class="widget-content">
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="RecapListBox" class="col-sm-2 control-label">Event Tracking</label>
                                                <div class="col-sm-10">
                                                    <telerik:RadListBox RenderMode="Lightweight" ID="POTrackingList" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="100%"
                                                        DataTextField="fieldTitle" DataValueField="fieldName" DataSourceID="getPODataFields">
                                                    </telerik:RadListBox>

                                                    <telerik:RadListBox RenderMode="Lightweight" ID="BudgetTrackingListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="100%" Height="400px" EmptyMessage="  There are no tracking questions for this supplier." DataTextField="question" DataValueField="supplierBudgetQuestionID">
                                                    </telerik:RadListBox>
                                                </div>
                                            </div>

                                            

                                            </div>
                                        </div>
                                    </div>
                             </div>


                            <div class="tab-pane fade" id="attributes">
                                <div class="widget stacked">
                                    <div class="widget-content">
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="" class="col-sm-2 control-label">Status:</label>
                                                <div class="col-sm-10" style="padding-top:5px;">
                                                    <asp:CheckBox ID="ActiveCheckBox" runat="server" Text="Active" />
                                                </div>
                                            </div>



                                            <div class="form-group">
                                                <label for="" class="col-sm-2 control-label">Group by:</label>
                                                <div class="col-sm-10">
                                                    <telerik:RadComboBox ID="GroupByComboBox" runat="server">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="None" Value="0" />
                                                            <telerik:RadComboBoxItem Text="Event" Value="Event" />
                                                            <telerik:RadComboBoxItem Text="Account" Value="Account" />
                                                            <telerik:RadComboBoxItem Text="Brand" Value="Brand" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="" class="col-sm-2 control-label">Report Settings:</label>
                                                <div class="col-sm-10" style="padding-top:5px;">
                                                    <asp:CheckBox ID="AllowFilteringCheckBox" runat="server" Text="Allow Filtering" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="" class="col-sm-2 control-label"></label>
                                                <div class="col-sm-10">
                                                    <asp:CheckBox ID="AllowSortingCheckBox" runat="server" Text="Allow Sorting" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="" class="col-sm-2 control-label"></label>
                                                <div class="col-sm-10">
                                                    <asp:CheckBox ID="AllowReorderCheckBox" runat="server" Text="Allow Reorder" />
                                                </div>
                                            </div>

                                           <%-- <div class="form-group">
                                                <label for="" class="col-sm-2 control-label"></label>
                                                <div class="col-sm-10">
                                                    <asp:CheckBox ID="AllowGroupingCheckBox" runat="server" Text="Allow Grouping" />
                                                </div>
                                            </div>--%>




                                            <div class="form-group">
                                                <label for="" class="col-sm-2 control-label">Export File Name:</label>
                                                <div class="col-sm-3">
                                                     <div class="input-group">
                                                      <asp:TextBox ID="ExportFileTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                      <span class="input-group-addon" id="basic-addon2">.xlsx</span>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="permission">
                                <div class="widget stacked">
                                    <div class="widget-content">
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="EnableAllClientsCheckBox" class="col-sm-3 control-label">Roles:</label>
                                                <div class="col-sm-9" style="top: 6px;">

                                                    <p><asp:CheckBox ID="ckAdmin" runat="server" AutoPostBack="true" /> Administrator</p>
                                                    <p><asp:CheckBox ID="ckAccounting" runat="server" AutoPostBack="true" /> Accounting</p>
                                                    <p><asp:CheckBox ID="ckAgency" runat="server" AutoPostBack="true" /> Agency</p>
                                                    <p><asp:CheckBox ID="ckClient" runat="server" AutoPostBack="true" /> Client</p>
                                                    <p><asp:CheckBox ID="ckEventManager" runat="server" AutoPostBack="true" /> Event Manager</p>
                                                    <p><asp:CheckBox ID="ckRecuiter" runat="server" AutoPostBack="true" /> Recruiter/Booking</p>
                                                    <br />
                                                </div>
                                            </div>



                                            <div class="form-group">
                                    <label for="EnableAllSupplierCheckBox" class="col-sm-3 control-label">Supplier Assigned:</label>
                                    <div class="col-sm-9" style="top: 6px;">

                                        <asp:CheckBox ID="EnableAllSuppliersCheckBox" runat="server" Text="Enable All Suppliers" AutoPostBack="true" />

                                        <div id="clientsPanel" runat="server" class="list-containers">

                                            <div class="list-container size-thin">
                                                <div class="title">
                                                    Available Suppliers
                                                </div>

                                                <telerik:RadListBox ID="SuppliersList" runat="server"
                                                    TransferToID="SelectedSuppliersList"
                                                    AllowTransferOnDoubleClick="True"
                                                    EnableDragAndDrop="True"
                                                    ButtonSettings-AreaWidth="35px" Height="200px" Width="275px"
                                                    DataKeyField="supplierID"
                                                    DataSortField="supplierName"
                                                    DataSourceID="gelAllSuppliers"
                                                    DataTextField="supplierName"
                                                    DataValueField="supplierID"
                                                    AllowTransfer="True"
                                                    AutoPostBackOnTransfer="true"
                                                    Skin="Bootstrap">
                                                    <ButtonSettings ShowTransferAll="false" />

                                                </telerik:RadListBox>

                                            </div>

                                            <asp:SqlDataSource ID="gelAllSuppliers" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                                SelectCommand="SELECT [supplierID], [supplierName] FROM [tblSupplier] ORDER BY [supplierName]"></asp:SqlDataSource>


                                            <div class="list-container size-thin">

                                                <div class="title">
                                                    Selected Suppliers
                                                </div>

                                                <telerik:RadListBox runat="server" ID="SelectedSuppliersList"
                                                    AllowDelete="True"
                                                    AutoPostBackOnDelete="true"
                                                    Height="200px" Width="275px" Skin="Bootstrap">
                                                </telerik:RadListBox>

                                            </div>


                                        </div>


                                    </div>
                                </div>

                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        </div>

         <asp:LinqDataSource runat="server" EntityTypeName="" ID="getPODataFields" ContextTypeName="EventManagerApplication.ReportDataClassesDataContext" OrderBy="sortOrder" TableName="rptFields" Where="tableName == @tableName">
            <WhereParameters>
                <asp:Parameter DefaultValue="tblPO" Name="tableName" Type="String"></asp:Parameter>
            </WhereParameters>
        </asp:LinqDataSource>


        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getEventDateFields" ContextTypeName="EventManagerApplication.ReportDataClassesDataContext" OrderBy="sortOrder" TableName="rptFields" Where="tableName == @tableName">
            <WhereParameters>
                <asp:Parameter DefaultValue="tblEvent" Name="tableName" Type="String"></asp:Parameter>
            </WhereParameters>
        </asp:LinqDataSource>

        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getAccountDataFields" ContextTypeName="EventManagerApplication.ReportDataClassesDataContext" OrderBy="sortOrder" TableName="rptFields" Where="tableName == @tableName">
            <WhereParameters>
                <asp:Parameter DefaultValue="tblAccount" Name="tableName" Type="String"></asp:Parameter>
            </WhereParameters>
        </asp:LinqDataSource>

        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getAmbassadorDataFields" ContextTypeName="EventManagerApplication.ReportDataClassesDataContext" OrderBy="sortOrder" TableName="rptFields" Where="tableName == @tableName">
            <WhereParameters>
                <asp:Parameter DefaultValue="tblAmbassador" Name="tableName" Type="String"></asp:Parameter>
            </WhereParameters>
        </asp:LinqDataSource>


        <asp:LinqDataSource ID="getRecapQuestions" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="QuestionID" TableName="tblDefaultRecapQuestions"></asp:LinqDataSource>







        <div>


        </div>

    </div>

   </div>
</asp:Content>
