<%@ Page Title="New Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="NewEventReport.aspx.vb" Inherits="EventManagerApplication.NewEventReport" %>

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

        <telerik:AjaxSetting AjaxControlID="SupplierRadComboBox">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel2" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
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

        .RadListBox .rlbEmptyMessage {
   
    color: red;
    padding-top: 8px;
}

</style>
    <asp:Panel ID="Panel2" runat="server">
   <div class="container">

        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard - Report Builder</h2>
                <hr />
            </div>
        </div>

    <div class="col-md-12">


        <h3>Add New Report</h3>

        <hr />
        <div class="row">
            <div class="col-md-12">
                <div class="btn-group" role="group" aria-label="...">
                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-success btn-sm" ValidationGroup="details" CausesValidation="true"><i class="fa fa-check-square-o" aria-hidden="true"></i> Save Report</asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-default btn-sm" PostBackUrl="/Reports/ReportBuilder/Events" CausesValidation="false">Cancel</asp:LinkButton>
                </div>
                
            </div>

            <div class="col-md-12">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList" 
  HeaderText="Please fix the following errors:" ValidationGroup="details" />
                </div>
        </div>

        <hr />


        <div class="form-horizontal">

            <div class="form-group">
                <label for="inputEmail3" class="col-sm-2 control-label">Report Name <span class="text-danger">*</span></label>
                <div class="col-sm-8">
                    <asp:TextBox ID="ReportNameTextBox" runat="server" CssClass="form-control"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="EventNameRequiredFieldValidator" runat="server"
                     ErrorMessage="Report Name is required" CssClass="errorlabel" ControlToValidate="ReportNameTextBox"
                     Display="Dynamic" ValidationGroup="details"></asp:RequiredFieldValidator>

                </div>
            </div>
            <div class="form-group">
                <label for="inputPassword3" class="col-sm-2 control-label">Description</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="ReportDescriptionTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <label for="inputPassword3" class="col-sm-2 control-label">Settings</label>
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
                                            <div class="col-md-10">
                                            <div class="form-horizontal">
                                            
                                            <div class="form-group">
                                                <label for="FromDatePicker" class="col-sm-2 control-label">Start Date</label>
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
                                                <label for="ToDatePicker" class="col-sm-2 control-label">End Date</label>
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
                                                <label for="SupplierRadComboBox" class="col-sm-2 control-label">Supplier <span class="text-danger">*</span></label>
                                                <div class="col-sm-8">

                                                    <telerik:RadComboBox ID="SupplierRadComboBox" runat="server" DataSourceID="getSupplierList" DataTextField="supplierName" DataValueField="supplierID" Width="300px" AppendDataBoundItems="true" AllowCustomText="true" MarkFirstMatch="true" AutoPostBack="true" EmptyMessage="Select Supplier">
                                                    </telerik:RadComboBox>

                                                    <asp:RequiredFieldValidator ID="EventTypeIDTextBoxRequiredFieldValidator" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="details"
                                                            ControlToValidate="SupplierRadComboBox"
                                                            ErrorMessage="Supplier is required"></asp:RequiredFieldValidator>

                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getSupplierList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="supplierName" TableName="tblSuppliers" Where="clientID == @clientID">
                                                        <WhereParameters>
                                                            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>
                                                </div>
                                            </div>

                                           


                                            <div class="form-group">
                                                <label for="EventStatusListBox" class="col-sm-2 control-label">Event Status</label>
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

<%--                                            <div class="col-md-6">
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
            <asp:Parameter DefaultValue="18" Name="clientID" Type="Int32"></asp:Parameter>
        </WhereParameters>
    </asp:LinqDataSource>
                                        </div>
                                            </div>--%>
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
                                                <label for="inputPassword3" class="col-sm-2 control-label">Markets</label>
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
                                                    <asp:CheckBox ID="RecapCheckBox" runat="server" Text="Recap" AutoPostBack="true" Checked="true" Enabled="false" />
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
                                                            <asp:ControlParameter ControlID="EventTypeComboBox" PropertyName="SelectedValue" Name="eventTypeID" Type="Int32"></asp:ControlParameter>
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
                                                   <telerik:RadListBox RenderMode="Lightweight" ID="BrandsListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="500px" AutoPostBack="true" EmptyMessage="You need to select a Supplier on the Filters tab"
                                                        DataTextField="brandName" DataValueField="brandID">
                                                    </telerik:RadListBox>

                                                   
                                                     <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="ValidationCriteria" 
                                                            ErrorMessage="At least one Brand is required" CssClass="errorlabel" ValidationGroup="details"></asp:CustomValidator> 

                                                        <telerik:RadScriptBlock runat="server" ID="RadScriptBlock">
                                                            <script type="text/javascript"> 
                                                                function ValidationCriteria(source, args) 
                                                                { 
                                                                    var listbox = $find('<%= BrandsListBox.ClientID %>'); 
                                                                    var check = 0; 
                                                                    var items = listbox.get_items(); 
                                                                    for (var i = 0; i<= items.get_count()-1; i++) 
                                                                    { 
                                                                        var item = items.getItem(i); 
                                                                        if(item.get_checked()) 
                                                                        { 
                                                                            check = 1; 
                                                                        } 
                                                                    } 
                                                                    if(check) 
                                                                        args.IsValid =true; 
                                                                    else 
                                                                        args.IsValid = false; 
                                                                } 
                                                                </script> 
                                                        </telerik:RadScriptBlock>

                                                </div>
                                            </div>
                                            </div>



                                             <div class="form-horizontal">
                                                 <div class="form-group">
                                                <label for="RecapListBox" class="col-sm-2 control-label">Recap Questions</label>
                                                <div class="col-sm-10">
                                                   <telerik:RadListBox RenderMode="Lightweight" ID="BrandRecapQuestionListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="100%" EmptyMessage="Select Brand from above."
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

                                                    <telerik:RadListBox RenderMode="Lightweight" ID="BudgetTrackingListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="100%" Height="400px" EmptyMessage="  There are no custom tracking questions for this supplier."
                                                        DataTextField="question" DataValueField="supplierBudgetQuestionID">
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
                                                    <asp:CheckBox ID="ActiveCheckBox" runat="server" Text="Active" Checked="true" />
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
                                                    <asp:CheckBox ID="AllowFilteringCheckBox" runat="server" Text="Allow Filtering" Checked="true" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="" class="col-sm-2 control-label"></label>
                                                <div class="col-sm-10">
                                                    <asp:CheckBox ID="AllowSortingCheckBox" runat="server" Text="Allow Sorting" Checked="true" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="" class="col-sm-2 control-label"></label>
                                                <div class="col-sm-10">
                                                    <asp:CheckBox ID="AllowReorderCheckBox" runat="server" Text="Allow Reorder" Checked="true" />
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
                                                      <asp:TextBox ID="ExportFileTextBox" runat="server" CssClass="form-control" Text="export"></asp:TextBox>
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


        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getPODataFields" ContextTypeName="EventManagerApplication.ReportDataClassesDataContext" OrderBy="sortOrder" TableName="rptFields" Where="tableName == @tableName">
            <WhereParameters>
                <asp:Parameter DefaultValue="tblPO" Name="tableName" Type="String"></asp:Parameter>
            </WhereParameters>
        </asp:LinqDataSource>


        <%--<asp:Button ID="btnSubmitReport" runat="server" Text="Create Query" />--%>


        <div>

            <%--<asp:Label ID="Label1" runat="server" Visible="false" />--%>

            <%--<telerik:RadGrid ID="RadGrid1" runat="server"
                AllowPaging="True"
                AllowSorting="True"
                ShowFooter="True"
                ShowStatusBar="true"
                AllowFilteringByColumn="True"
                PageSize="20" CellSpacing="-1"
                FilterType="HeaderContext"
                EnableHeaderContextMenu="true"
                EnableHeaderContextFilterMenu="true">
                <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True"></ClientSettings>

                <MasterTableView AutoGenerateColumns="true" DataKeyNames="eventID" CommandItemDisplay="Top" AllowSorting="true">

                    <CommandItemTemplate>
                        <div style="padding: 3px 0 3px 5px">
                            <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ResetGrid" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                            <div class="pull-right" style="padding-right: 3px">
                                <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                            </div>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <PagerStyle Position="TopAndBottom" />
            </telerik:RadGrid>--%>


            <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'></asp:SqlDataSource>--%>
        </div>

    </div>

   </div>
        </asp:Panel>
</asp:Content>
