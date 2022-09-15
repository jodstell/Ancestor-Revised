<%@ Page Title="Add Event" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="NewEvent.aspx.vb" Inherits="EventManagerApplication.NewEvent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    .RadWizard_Bootstrap .rwzNext{
    border-color: #2e6da4;
    color: #fff;
    background-color: #337ab7;
    width: 150px;

}

.RadWizard_Bootstrap .rwzFinish {
    border-color: #449d44;
    color: #fff;
    background-color: #419641;
    width: 150px;
}
    </style>


    <script>

        // close the div in 5 secs
        window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version
            $("#messageHolder").fadeOut("slow", null);
        }


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

                // if finish button is clicked
                var command = args.get_command();


            if (command == "2") {

                // show loading panel when cancel button is clicked
                var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                var currentUpdatedControl = "<%= MainPanel.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.show(currentUpdatedControl);
            }

            if (command == "3") {

                // show loading panel when finish button is clicked
                var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                var currentUpdatedControl = "<%= MainPanel.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.show(currentUpdatedControl);
            }

            }

        })();
    </script>

    <script type="text/javascript">
                function OnClientItemChecked(sender, args) {
                        args.get_item().set_selected(args.get_item().get_checked());
                }
    </script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link href="/Theme/css/custom1.css" rel="stylesheet" />
    <link href="css/CustomEvents.css" rel="stylesheet" />


    <div class="container">


<telerik:RadAjaxManager ID="RadAjaxManager2" runat="server">

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="MainPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="MainPanel"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="EventTypeIDComboBox">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="EventTypeIDComboBox" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="SelectedBrandsListPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="SelectedBrandsListPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="EventDatePicker">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="StartDateTimePicker" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="EndDateTimePicker" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="EventDatePicker"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="Label1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="StartDateTimePicker">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="StartDateTimePicker" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="EndDateTimePicker" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="PositionStartTimePicker" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="EndDateTimePicker">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="EndDateTimePicker" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="PositionEndTimePicker" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="ddlStaffingPositionID">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ddlStaffingPositionID"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="RateTextBox" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="SupplierBrandsPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="SupplierBrandsPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="SearchPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="SearchPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="ResultsPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ResultsPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="LocationPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="LocationPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ResultsPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="LocationPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="AddLocationPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="AddLocationPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

</telerik:RadAjaxManager>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

        <asp:Panel ID="MainPanel" runat="server">
            <div class="row">
                <div class="col-md-12">

                    <div style="margin: 0 0 15px 0">
                        <h2>New Event:</h2>
                        <p>
                            Use this form to add a new event.  Complete each sections below and click on the Next button to continue to the next tab.<br />
                            Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                        </p>
                    </div>

                    <div id="mainDiv" class="widget stacked">
                        <div class="widget-content">

                            <telerik:RadWizard ID="EventWizard" runat="server" DisplayNavigationBar="true" DisplayNavigationButtons="true" DisplayCancelButton="true" DisplayProgressBar="false" OnClientLoad="OnClientLoad" OnClientButtonClicking="OnClientButtonClicking">

                                <WizardSteps>


                                    <telerik:RadWizardStep Title="Event Information" ValidationGroup="details" CausesValidation="true">


                                        <div class="col-md-12 min-height">
                                            <div class="form-horizontal">

                                                <div class="form-group">
                                                    <label for="eventTitleTextBox" class="col-sm-3 control-label">Name of Event <span class="text-danger">*</span></label>
                                                    <div class="col-sm-8">
                                                        <asp:TextBox ID="eventTitleTextBox" runat="server" CssClass="form-control" />

                                                        <span class="help-block">Add the name of the event.</span>

                                                        <asp:RequiredFieldValidator ID="EventNameRequiredFieldValidator" runat="server"
                                                            ErrorMessage="Event Name is required" CssClass="errorlabel" ControlToValidate="eventTitleTextBox"
                                                            Display="Dynamic" ValidationGroup="details"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                        <%--<asp:Panel ID="SupplierBrandsPanel" runat="server">

                                                <div class="form-group">
                                                    <label for="supplierIDTextBox" class="col-sm-3 control-label">Supplier <span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">

                                                        <telerik:RadComboBox ID="supplierIDComboBox" runat="server" AutoPostBack="true" AllowCustomText="false" MarkFirstMatch="true"
                                                            DataSourceID="getSuppliers" Width="275px" EmptyMessage="Select a Supplier"
                                                            DataTextField="supplierName" DataValueField="supplierID" AppendDataBoundItems="true">
                                                            <Items>
                                                                <telerik:RadComboBoxItem Text="-- Select Supplier --" Value="0" />
                                                            </Items>
                                                        </telerik:RadComboBox>



                                                        <asp:DropDownList ID="supplierIDTextBox" runat="server" AutoPostBack="true" Visible="false"
                                                            DataSourceID="getSuppliers" CssClass="form-control"
                                                            DataTextField="supplierName" DataValueField="supplierID" AppendDataBoundItems="true">
                                                            <asp:ListItem Text="-- Select Supplier --" Value="0"></asp:ListItem>
                                                        </asp:DropDownList>

                                                        <asp:RequiredFieldValidator ID="supplierIDRequiredFieldValidator" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="details"
                                                            ControlToValidate="supplierIDComboBox" InitialValue="0"
                                                            ErrorMessage="Supplier is required"></asp:RequiredFieldValidator>

                                                        <asp:LinqDataSource ID="getSuppliers" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                            EntityTypeName="" OrderBy="supplierName" TableName="tblSuppliers" Where="clientID == @clientID">
                                                            <WhereParameters>
                                                                <asp:SessionParameter SessionField="CurrentClientID" Name="clientID" Type="Int32"></asp:SessionParameter>
                                                            </WhereParameters>
                                                        </asp:LinqDataSource>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label">Brands <span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">


                                                        <div class="list-containers">

                                                            <div class="list-container size-thin">
                                                                <div class="title">
                                                                    Available Brands
                                                                </div>
                                                                <telerik:RadListBox ID="BrandsListBox" runat="server"
                                                                    TransferToID="SelectedBrandsList"
                                                                    AllowTransferOnDoubleClick="True"
                                                                    EnableDragAndDrop="True"
                                                                    ButtonSettings-AreaWidth="35px" Height="200px" Width="275px"
                                                                    DataKeyField="brandID"
                                                                    DataSortField="brandName"
                                                                    DataSourceID="SqlDataSource1"
                                                                    DataTextField="brandName"
                                                                    DataValueField="brandID"
                                                                    AllowTransfer="True"
                                                                    AutoPostBackOnTransfer="True"
                                                                    Skin="Bootstrap">
                                                                    <ButtonSettings ShowTransferAll="false" />

                                                                </telerik:RadListBox>
                                                            </div>

                                                            <div class="list-container size-thin">

                                                                <div class="title">
                                                                    Selected Brands
                                                                </div>
                                                                <telerik:RadListBox runat="server" ID="SelectedBrandsList"
                                                                    DataKeyField="brandID"
                                                                    DataTextField="brandName"
                                                                    DataValueField="brandID"
                                                                    DataSortField="brandName"
                                                                    Height="200px" Width="275px" Skin="Bootstrap">
                                                                </telerik:RadListBox>

                                                            </div>

                                                            <asp:CustomValidator ID="SelectedBrandsCustomValidator" runat="server" ValidationGroup="details" CssClass="errorlabel"
                                                                ClientValidationFunction="ValidationCriteria" ErrorMessage="Please select at least one Brand">
                                                            </asp:CustomValidator>

                                                            <telerik:RadScriptBlock ID="block1" runat="server">
                                                                <script type="text/javascript">
                                                                    function ValidationCriteria(source, args) {
                                                                        var listbox = $find('<%= SelectedBrandsList.ClientID %>');
                                                                        var check = 0;
                                                                        var items = listbox.get_items();
                                                                        var cnt = items.get_count();
                                                                        if (cnt)
                                                                            args.IsValid = true;
                                                                        else                                                                                                                           args.IsValid = false;

                                                                    }
                                                                </script>
                                                            </telerik:RadScriptBlock>

                                                        </div>

                                                    </div>
                                                </div>

                                        </asp:Panel>--%>

                                                <div class="form-group">
                                                    <label for="EventTypeIDTextBox" class="col-sm-3 control-label">Event Type <span class="text-danger">*</span></label>
                                                    <div class="col-sm-5">

                                                        <telerik:RadComboBox  ID="EventTypeIDComboBox" runat="server" DataSourceID="GetEventTypeList" AutoPostBack="true"
                                                            DataTextField="eventTypeName" Width="300px" AllowCustomText="false" MarkFirstMatch="true" EmptyMessage="Select Event Type"
                                                            DataValueField="eventTypeID" AppendDataBoundItems="false">
                                                        </telerik:RadComboBox>

                                                        <%--<span class="help-block">Select the event type.  This is required!</span>--%>

                                                        <asp:RequiredFieldValidator ID="EventTypeIDTextBoxRequiredFieldValidator" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="details"
                                                            ControlToValidate="EventTypeIDComboBox"
                                                            ErrorMessage="Event Type is required"></asp:RequiredFieldValidator>


                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="EventTypeIDTextBox" class="col-sm-3 control-label">Team</label>
                                                    <div class="col-sm-5">

                                                        <telerik:RadComboBox  ID="TeamComboBox" runat="server" DataSourceID="GetTeamList" AutoPostBack="true"
                                                            DataTextField="teamName" Width="300px" AllowCustomText="false" MarkFirstMatch="true"
                                                            DataValueField="teamID" AppendDataBoundItems="false" EmptyMessage="Select a Team">
                                                        </telerik:RadComboBox>

                                                        <span class="help-block">Select a team.  Leave blank if there is no team.</span>

                                                    </div>
                                                </div>

                                                <asp:LinqDataSource ID="GetTeamList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                    EntityTypeName="" OrderBy="teamName" TableName="tblTeams">
                                                </asp:LinqDataSource>

                                                <!-- End form-group -->


                                                <div class="form-group">

                                                    <label for="supplierIDTextBox" class="col-sm-3 control-label">Supplier <span class="text-danger">*</span></label>

                                                    <div class="col-sm-9">
                                                        <telerik:RadComboBox ID="supplierIDComboBox" runat="server" AllowCustomText="false" MarkFirstMatch="true"
                                                            DataSourceID="getSuppliers" Width="300px" DataTextField="supplierName" DataValueField="supplierID" EmptyMessage="Select Supplier" Enabled="false">                                                    
                                                        </telerik:RadComboBox>

                                                        <asp:CompareValidator ID="supplierIDComparevalidator" ErrorMessage="Supplier is required"           ControlToValidate="supplierIDComboBox" runat="server" CssClass="errorlabel" Operator="NotEqual" 
                                                            ValueToCompare="-- Select Supplier --" ValidationGroup="details" />

                                                        <asp:LinqDataSource ID="getSuppliers" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                            EntityTypeName="" OrderBy="supplierName" TableName="tblSuppliers">

                                                        </asp:LinqDataSource>
                                                    </div>

                                                </div>

                                                <%--<div class="form-group">
                                                    <label class="col-sm-3 control-label">Status</label>
                                                    <div class="col-sm-5">
                                                        <telerik:RadComboBox ID="statusIDComboBox" runat="server" DataSourceID="GetStatusList" Width="300px"
                                                            DataTextField="statusName" DataValueField="statusID" AppendDataBoundItems="true">
                                                            <Items>
                                                                <telerik:RadComboBoxItem Text="-- Select Status --" Value="0" />
                                                            </Items>
                                                        </telerik:RadComboBox>

                                                    </div>
                                                </div>



                                                <asp:LinqDataSource ID="GetStatusList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                    EntityTypeName="" OrderBy="statusName" TableName="tblStatus">
                                                </asp:LinqDataSource>--%>

                                                

                                            </div>
                                        </div>


                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Brands" ValidationGroup="brands" CausesValidation="True" Active="true">
                                              
                                        <div class="col-md-8">
                                            <p>Select the brands that you wish to present at the event.</p>
                                            <div class="form-horizontal">

                                                <div class="form-group">
                                                    <div class="col-sm-9">

                                                        <asp:Panel ID="SelectedBrandsListPanel" runat="server">
                                                        <telerik:RadListBox RenderMode="Lightweight" ID="SelectedBrandsList" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="500px" Height="350px" DataTextField="brandName" DataValueField="brandID" DataSourceID="getSupplierList" OnClientItemChecked="OnClientItemChecked" AutoPostBack="true">
                                                        </telerik:RadListBox>
                                                        </asp:Panel>

                                                        
                                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="ValidationCriteria" 
                                                            ErrorMessage="Brand is required" CssClass="errorlabel" ValidationGroup="brands"></asp:CustomValidator> 

                                                        <telerik:RadScriptBlock runat="server" ID="RadScriptBlock">
                                                            <script type="text/javascript"> 
                                                                function ValidationCriteria(source, args) 
                                                                { 
                                                                    var listbox = $find('<%= SelectedBrandsList.ClientID %>'); 
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


                                                    <asp:SqlDataSource ID="getSupplierList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                                                        SelectCommand="SELECT * FROM [getBrandsbySupplier] WHERE ([supplierID] = @supplierID) ORDER BY [brandName]">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter QueryStringField="supplierID" Name="supplierID" Type="Int32"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                </div>
                                            </div>
                                        </div>

                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Dates & Times" ValidationGroup="eventdate" CausesValidation="True">

                                        <div class="col-md-8" style="min-height: 400px;">

                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label">Event Date: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">
                                                        <telerik:RadDatePicker ID="EventDatePicker" runat="server" Culture="en-US" ShowPopupOnFocus="true" OnSelectedDateChanged="EventDatePicker_SelectedDateChanged"
                                                            Skin="Bootstrap" AutoPostBack="True">
                                                            <Calendar runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle CssClass="rcToday" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                        </telerik:RadDatePicker>

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="eventdate"
                                                            ControlToValidate="EventDatePicker"
                                                            ErrorMessage="Event Date is required"></asp:RequiredFieldValidator>


                                                    </div>
                                                </div>



                                                <div class="form-group">
                                                    <label for="StartDateTimePicker" class="col-sm-3 control-label">Start Time: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">

                                                        <telerik:RadDateTimePicker ID="StartDateTimePicker" Culture="en-US" ShowPopupOnFocus="true" runat="server" Skin="Bootstrap" Width="230px" OnSelectedDateChanged="StartDateTimePicker_SelectedDateChanged" AutoPostBack="True" AutoPostBackControl="Both">
                                                            <Calendar runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle CssClass="rcToday" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                            <DateInput DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" AutoPostBack="True" LabelWidth="40%">
                                                            </DateInput>

                                                        </telerik:RadDateTimePicker>

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="eventdate"
                                                            ControlToValidate="StartDateTimePicker"
                                                            ErrorMessage="Start Time is required"></asp:RequiredFieldValidator>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="EndDateTimePicker" class="col-sm-3 control-label">End Time: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">
                                                        <telerik:RadDateTimePicker ID="EndDateTimePicker" Culture="en-US" ShowPopupOnFocus="true" runat="server" Skin="Bootstrap" Width="230px" AutoPostBack="True" AutoPostBackControl="Both" OnSelectedDateChanged="EndDateTimePicker_SelectedDateChanged">
                                                            <Calendar runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle CssClass="rcToday" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                        </telerik:RadDateTimePicker>

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="eventdate"
                                                            ControlToValidate="EndDateTimePicker"
                                                            ErrorMessage="End Time is required"></asp:RequiredFieldValidator>

                                                        <asp:CompareValidator ID="dateCompareValidator" runat="server" ControlToValidate="EndDateTimePicker"
                                                            ValidationGroup="eventdate" CssClass="errorlabel"
                                                            ControlToCompare="StartDateTimePicker" Operator="GreaterThan" Type="String" ErrorMessage="The end date must be after the start date.">

                                                        </asp:CompareValidator>

                                                    </div>
                                                </div>







                                            </div>

                                        </div>

                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Event Details" CausesValidation="false">

                                        <div class="col-md-12" style="min-height: 250px;">

                                            <p>Enter any additions details that are necessary for this event. Please remove any text or headings that are not needed.</p>

                                            <div class="form-horizontal">


                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label">Event Description</label>
                                                    <div class="col-sm-8">
                                                        <telerik:RadEditor ID="eventDescriptionTextBox" runat="server" RenderMode="Lightweight" ToolsFile="BasicTools.xml" EditModes="Design" Width="100%"></telerik:RadEditor>
                                                        <span id="helpBlock" class="help-block">Enter a short description of the event. </span>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label for="inputEmail3" class="col-sm-3 control-label">Attire</label>
                                                    <div class="col-sm-8">
                                                        <telerik:RadEditor ID="attireTextEditor" runat="server" RenderMode="Lightweight" ToolsFile="BasicTools.xml" EditModes="Design" Width="100%"></telerik:RadEditor>


                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label for="inputEmail3" class="col-sm-3 control-label">POS Requirements</label>
                                                    <div class="col-sm-8">
                                                        <telerik:RadEditor ID="posRequirementsEditor" runat="server" RenderMode="Lightweight" ToolsFile="BasicTools.xml" EditModes="Design" Width="100%"></telerik:RadEditor>

                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label for="inputEmail3" class="col-sm-3 control-label">Sampling Notes</label>

                                                    <div class="col-sm-8">
                                                        <telerik:RadEditor ID="samplingNotesRadEditor" runat="server" RenderMode="Lightweight" ToolsFile="BasicTools.xml" EditModes="Design" Width="100%"></telerik:RadEditor>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Location" ValidationGroup="location" CausesValidation="true">

                                        <asp:Panel ID="AjaxLocationPanel" runat="server">

                                            <div class="col-md-12" style="min-height: 250px;">

                                            <div class="form-horizontal">

                                                <asp:Panel ID="SearchPanel" runat="server">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">
                                                            Search Market: <span class="text-danger">*</span>
                                                            <br />
                                                            <br />
                                                            <asp:LinkButton ID="btnAddNewLocation" runat="server" CssClass="btn btn-success"><i class="fa fa-plus-square"></i> Add New Location</asp:LinkButton>
                                                        </label>
                                                        <div class="col-sm-5">
                                                            <asp:DropDownList ID="MarketList" runat="server" AutoPostBack="true"
                                                                DataSourceID="GetMarketList" DataTextField="marketName"
                                                                DataValueField="marketID" CssClass="form-control" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="-- Select Market to Search --" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>

                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="MarketList" InitialValue="0"
                                                            ErrorMessage="Market is required"></asp:RequiredFieldValidator>




                                                        </div>

                                                    </div>


                                                </asp:Panel>
                                                <!-- End Search Panel -->


                                                <asp:Label ID="msgLabel" runat="server" />
                                                <asp:Label ID="accountLableMngError" runat="server" Visible="false" CssClass="errorlabel" />

                                                <asp:Panel ID="ResultsPanel" runat="server" Visible="false">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Select an Account: <span class="text-danger">*</span></label>
                                                        <div class="col-sm-9">

                                                            <!-- Find the results until the selected market is changed -->
                                                            <telerik:RadGrid ID="ResultsGrid" runat="server" CellSpacing="-1" DataSourceID="GetAccountListbyMarketSearch"
                                                                Visible="false" GroupPanelPosition="Top"
                                                                AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True">

                                                                <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>

                                                                <MasterTableView AutoGenerateColumns="False" DataSourceID="GetAccountListbyMarketSearch">

                                                                    <NoRecordsTemplate>
                                                                        <div style="background-color: #b94a48; color: white; font-size: 14px; font-weight: bold; padding: 2px;">
                                                                        There were no results. Click Add New Location button.</div>
                                                                    </NoRecordsTemplate>

                                                                    <Columns>

                                                                        <telerik:GridTemplateColumn AllowFiltering="false">
                                                                            <ItemStyle Width="40px" />
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="btnSelect" runat="server"
                                                                                    CommandName="SelectAccount" CommandArgument='<%# Eval("Vpid") %>'
                                                                                    CssClass="btn btn-primary btn-md" ForeColor="White" OnClick="btnSelect_Click">Select</asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>

                                                                        <telerik:GridBoundColumn DataField="accountName"
                                                                            FilterControlAltText="Filter accountName column"
                                                                            HeaderText="Account Name" ReadOnly="True" SortExpression="accountName"
                                                                            UniqueName="accountName"
                                                                           >

                                                                              <FilterTemplate>

                                                                                <telerik:RadComboBox ID="RadComboBox_accountName" DataSourceID="GetAccountListbyMarketSearch" DataTextField="accountName" AllowCustomText="false" MarkFirstMatch="true"
                                                                                    DataValueField="accountName" Height="200px" Width="320px" AppendDataBoundItems="true"
                                                                                    SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("accountName").CurrentFilterValue%>'
                                                                                    runat="server" OnClientSelectedIndexChanged="accountNameIndexChanged">
                                                                                    <Items>
                                                                                        <telerik:RadComboBoxItem Text="All" />
                                                                                    </Items>
                                                                                </telerik:RadComboBox>

                                                                                <telerik:RadScriptBlock ID="RadScriptBlock_accountName" runat="server">

                                                                                    <script type="text/javascript">
                                                                                        function accountNameIndexChanged(sender, args) {
                                                                                            var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                                                                            tableView.filter("accountName", args.get_item().get_value(), "EqualTo");
                                                                                                            }
                                                                                    </script>

                                                                                </telerik:RadScriptBlock>

                                                                            </FilterTemplate>










                                                                        </telerik:GridBoundColumn>






                                                                        <telerik:GridBoundColumn DataField="streetAddress1"
                                                                            FilterControlAltText="Filter streetAddress1 column"
                                                                            HeaderText="Address" ReadOnly="True"
                                                                            SortExpression="streetAddress1" UniqueName="streetAddress1"
                                                                            FilterControlWidth="150px"
                                                                            AutoPostBackOnFilter="true"
                                                                            CurrentFilterFunction="Contains"
                                                                            ShowFilterIcon="false">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="City"
                                                                            FilterControlAltText="Filter city column"
                                                                            HeaderText="City"
                                                                            ReadOnly="True"
                                                                            SortExpression="city"
                                                                            UniqueName="city">

                                                                            <FilterTemplate>
                                                                                <telerik:RadComboBox ID="FilterCityTextBox"
                                                                                    Height="200px" Width="150px" AppendDataBoundItems="True"
                                                                                    runat="server" DataSourceID="GetCityList" DataTextField="city"
                                                                                    DataValueField="city" SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("city").CurrentFilterValue%>'
                                                                                    OnClientSelectedIndexChanged="CityIndexChanged">
                                                                                    <Items>
                                                                                        <telerik:RadComboBoxItem Text="All" />
                                                                                    </Items>
                                                                                </telerik:RadComboBox>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server"                               Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="FilterCityTextBox" InitialValue="All" ></asp:RequiredFieldValidator>


                                                                                <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                                                                    <script type="text/javascript">
                                                                                        function CityIndexChanged(sender, args) {
                                                                                            var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                                                                            tableView.filter("city", args.get_item().get_value(), "EqualTo");
                                                                                        }
                                                                                    </script>
                                                                                </telerik:RadScriptBlock>

                                                                            </FilterTemplate>

                                                                        </telerik:GridBoundColumn>



                                                                    </Columns>
                                                                </MasterTableView>

                                                                <PagerStyle Position="TopAndBottom" />

                                                            </telerik:RadGrid>



                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                                <!-- End Results Panel -->



                                                <asp:Panel ID="LocationPanel" runat="server" Visible="false">

                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Selected Account:</label>
                                                        <div class="col-sm-9" style="padding-top: 8px;">
                                                            <asp:Label ID="AccountNameLabel" runat="server" /><br />
                                                            <asp:Label ID="AccountAddressLabel" runat="server" /><br />
                                                            <asp:Label ID="AccountCityStateLabel" runat="server" /><br />
                                                            <br />
                                                            <asp:Button ID="btnRemoveAccount" runat="server" Text="Remove Account" CssClass="btn btn-default btn-sm" />

                                                            <br />
                                                            <br />
                                                            <br />
                                                            <div id="messageHolder">
                                                                <asp:Literal ID="selectedAccountMsg" runat="server" />
                                                            </div>

                                                            <asp:HiddenField ID="HiddenLocationID" runat="server" />
                                                        </div>
                                                    </div>
                                                </asp:Panel>

                                                <asp:Panel ID="AddLocationPanel" runat="server" Visible="false" >

                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Add New Account Location</label>
                                                        <div class="col-sm-9" style="padding-top: 8px;">
                                                        </div>
                                                    </div>

                                                     <div class="form-group">
                                                        <label class="col-sm-3 control-label">Account Name: <span class="text-danger">*</span></label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="txtAccountName" runat="server" CssClass="form-control" />

                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="txtAccountName"
                                                            ErrorMessage="Account Name is required"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Address: <span class="text-danger">*</span></label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control" />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="txtAddress1"
                                                            ErrorMessage="Address is required"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">City: <span class="text-danger">*</span></label>
                                                        <div class="col-sm-3">
                                                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="txtCity"
                                                            ErrorMessage="City is required"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">State: <span class="text-danger">*</span></label>
                                                        <div class="col-sm-3">
                                                            <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="- Select State -" Value="3"></asp:ListItem>
                                                                <asp:ListItem Value="AL">Alabama</asp:ListItem>
                                                                <asp:ListItem Value="AK">Alaska</asp:ListItem>
                                                                <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                                                                <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                                                                <asp:ListItem Value="CA">California</asp:ListItem>
                                                                <asp:ListItem Value="CO">Colorado</asp:ListItem>
                                                                <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                                                                <asp:ListItem Value="DC">District of Columbia</asp:ListItem>
                                                                <asp:ListItem Value="DE">Delaware</asp:ListItem>
                                                                <asp:ListItem Value="FL">Florida</asp:ListItem>
                                                                <asp:ListItem Value="GA">Georgia</asp:ListItem>
                                                                <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                                                                <asp:ListItem Value="ID">Idaho</asp:ListItem>
                                                                <asp:ListItem Value="IL">Illinois</asp:ListItem>
                                                                <asp:ListItem Value="IN">Indiana</asp:ListItem>
                                                                <asp:ListItem Value="IA">Iowa</asp:ListItem>
                                                                <asp:ListItem Value="KS">Kansas</asp:ListItem>
                                                                <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                                                                <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                                                                <asp:ListItem Value="ME">Maine</asp:ListItem>
                                                                <asp:ListItem Value="MD">Maryland</asp:ListItem>
                                                                <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                                                                <asp:ListItem Value="MI">Michigan</asp:ListItem>
                                                                <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                                                                <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                                                                <asp:ListItem Value="MO">Missouri</asp:ListItem>
                                                                <asp:ListItem Value="MT">Montana</asp:ListItem>
                                                                <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                                                                <asp:ListItem Value="NV">Nevada</asp:ListItem>
                                                                <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                                                                <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                                                                <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                                                                <asp:ListItem Value="NY">New York</asp:ListItem>
                                                                <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                                                                <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                                                                <asp:ListItem Value="OH">Ohio</asp:ListItem>
                                                                <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                                                                <asp:ListItem Value="OR">Oregon</asp:ListItem>
                                                                <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                                                                <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                                                                <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                                                                <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                                                                <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                                                                <asp:ListItem Value="TX">Texas</asp:ListItem>
                                                                <asp:ListItem Value="UT">Utah</asp:ListItem>
                                                                <asp:ListItem Value="VT">Vermont</asp:ListItem>
                                                                <asp:ListItem Value="VA">Virginia</asp:ListItem>
                                                                <asp:ListItem Value="WA">Washington</asp:ListItem>
                                                                <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                                                                <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                                                                <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="ddlState" InitialValue="3"
                                                            ErrorMessage="State is required"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Zip: <span class="text-danger">*</span></label>
                                                        <div class="col-sm-2">
                                                            <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="txtZip"
                                                            ErrorMessage="Zip is required"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Phone:</label>
                                                        <div class="col-sm-2">
                                                            <%--<asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />--%>
                                                            <telerik:RadMaskedTextBox RenderMode="Lightweight" ID="txtPhone" runat="server" Mask="(###)###-####" 
                                                            Width="200px" Height="33px"></telerik:RadMaskedTextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Account Type: <span class="text-danger">*</span></label>
                                                        <div class="col-sm-3">
                                                            <asp:DropDownList ID="AccountTypeIDTextBox" runat="server" CssClass="form-control" TabIndex="6"
                                                                AppendDataBoundItems="True" DataSourceID="getAccountType" DataTextField="accountTypeName" DataValueField="accountTypeID">
                                                                <asp:ListItem Text="- Select Account Type -" Value="2"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="AccountTypeIDTextBox" InitialValue="2"
                                                            ErrorMessage="Account Type is required"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Market: <span class="text-danger">*</span></label>
                                                        <div class="col-sm-3">
                                                            <asp:DropDownList ID="marketIDddl" runat="server" DataSourceID="LinqDataSource1"
                                                                DataTextField="marketName" DataValueField="marketID" CssClass="form-control" AppendDataBoundItems="True">
                                                                <asp:ListItem Text="- Select Market -" Value="1"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="marketIDddl" InitialValue="1"
                                                            ErrorMessage="Market is required"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label"></label>
                                                        <div class="col-sm-9" style="padding-top: 8px;">
                                                            <asp:Button ID="btnCancelAddAccount" runat="server" Text="Cancel Add New Location" CssClass="btn btn-danger" OnClientClick="javascript:if(!confirm('This action will cancel adding the new location. Are you sure?')){return false;}" />
                                                        </div>
                                                    </div>

                                                    <asp:LinqDataSource ID="getAccountType" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="accountTypeName" TableName="tblAccountTypes" Where="active == @active">
                                                        <WhereParameters>
                                                            <asp:Parameter DefaultValue="True" Name="active" Type="Boolean" />
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>

                                                    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="marketName" TableName="tblMarkets">
                                                    </asp:LinqDataSource>

                                                </asp:Panel>

                                            </div>
                                            <!-- End form-horizontal -->

                                        </div>

                                        </asp:Panel>

                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Staff Requirements" ValidationGroup="staff" CausesValidation="true">
                                        <div class="col-md-12">
                                            <div class="form-horizontal">


                                                <div class="form-group">
                                                    <label for="" class="col-sm-3 control-label">Position <span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">

                                                        <asp:DropDownList ID="ddlStaffingPositionID" runat="server" DataSourceID="getPositionList" CssClass="form-control input-med"
                                                            DataTextField="positionTitle" DataValueField="staffingPositionID" AutoPostBack="true" OnSelectedIndexChanged="ddlStaffingPositionID_SelectedIndexChanged" AppendDataBoundItems="true">
                                                            <asp:ListItem Text="Select a position" Value="0"></asp:ListItem>
                                                        </asp:DropDownList>

                                                          <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="staff"
                                                            ControlToValidate="ddlStaffingPositionID" InitialValue="0"
                                                            ErrorMessage="Position is required"></asp:RequiredFieldValidator>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="" class="col-sm-3 control-label">Start Time <span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">

                                                       <telerik:RadTimePicker ID="PositionStartTimePicker" runat="server" Skin="Bootstrap"></telerik:RadTimePicker>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="" class="col-sm-3 control-label">End Time <span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">

                                                        <telerik:RadTimePicker ID="PositionEndTimePicker" runat="server" Skin="Bootstrap"></telerik:RadTimePicker>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="" class="col-sm-3 control-label">Rate <span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">

                                                        <telerik:RadNumericTextBox ID="RateTextBox" runat="server" NumberFormat-DecimalDigits="2" Culture="en-US" DbValueFactor="1" LabelWidth="64px" Type="Currency" Width="160px" ShowSpinButtons="true" ButtonsPosition="Right">
                                                            <NumberFormat DecimalDigits="2" ZeroPattern="$n"></NumberFormat>

                                                        </telerik:RadNumericTextBox>

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="staff"
                                                            ControlToValidate="RateTextBox"
                                                            ErrorMessage="Rate is required"></asp:RequiredFieldValidator>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="" class="col-sm-3 control-label"># of Positions <span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">

                                                        <telerik:RadNumericTextBox ID="PositionCountTextBox" runat="server" NumberFormat-DecimalDigits="0" MinValue="1" ShowSpinButtons="true" ButtonsPosition="Right" InterceptArrowKeys="true" AllowRounding="true" Value="1">
                                                        </telerik:RadNumericTextBox>

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="staff"
                                                            ControlToValidate="PositionCountTextBox"
                                                            ErrorMessage="Positions is required"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                            </div>

                                            <asp:LinqDataSource ID="getPositionList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                EntityTypeName="" OrderBy="positionTitle" TableName="tblStaffingPositions">
                                            </asp:LinqDataSource>

                                        </div>
                                    </telerik:RadWizardStep>
                                    

                                    <telerik:RadWizardStep Title="Budget" ID="FinishTab">


                                        <div class="col-md-12" style="min-height: 250px;" id="FinishTab2">

                                            <div class="form-horizontal">

                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label">Purchase Order Number:</label>
                                                    <div class="col-sm-3">
                                                        <%--<asp:TextBox ID="PONumberTextBox" runat="server" CssClass="form-control" />--%>

                                                        <%--<telerik:RadDropDownList ID="PONumberDropDown" runat="server" DataSourceID="getPOs" DataValueField="purchaseOrderID" DataTextField="purchaseOrderNumber" DefaultMessage="Select PO Number" Width="190px">
                                                        </telerik:RadDropDownList>--%>

                                                        <telerik:RadComboBox  ID="PONumberComboBox" runat="server" DataSourceID="getPOs"
                                                            DataTextField="purchaseOrderNumber" Width="200px" AllowCustomText="false" MarkFirstMatch="true"
                                                            DataValueField="purchaseOrderID" AppendDataBoundItems="false" EmptyMessage="Select a PO Number">
                                                        </telerik:RadComboBox>

                                                <asp:LinqDataSource ID="getPOs" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblPurchaseOrders" Where="supplierID == @supplierID">
                                                    <WhereParameters>
                                                        <asp:QueryStringParameter QueryStringField="supplierID" Name="supplierID" Type="Int32"></asp:QueryStringParameter>
                                                    </WhereParameters>
                                                </asp:LinqDataSource>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label">Distributor:</label>
                                                    <div class="col-sm-3">
                                                        <asp:TextBox ID="DistributorTextBox" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label">Requested By:</label>
                                                    <div class="col-sm-3">
                                                        <asp:TextBox ID="RequestedTextBox" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>


                                                <asp:PlaceHolder ID="SupplierBudgetPlaceHolder" runat="server"></asp:PlaceHolder>


                                                
                                            </div>

                                        </div>

                                        <div class="col-md-12">                                            
                                            <p class="pull-right"><strong>You are almost done! Click Finish to add the event.</strong></p> 
                                        </div>
                                           

                                    </telerik:RadWizardStep>


                                </WizardSteps>

                            </telerik:RadWizard>

                        </div>
                    </div>


                    <%--<div id="loading">
                        <div class="widget stacked">
                        <div class="widget-content" style="padding-top: 20px; padding-bottom: 40px;">
                            <i class="fa fa-refresh fa-spin-2x fa-2x fa-fw" style="color:#0670cd;"></i><br /><br />
                            <p style="font-size:22px;">Please wait</p><br />
                            <p style="font-size:18px;">This will take a few seconds</p>
                        </div>
                        </div>
                    </div>--%>


                </div>
            </div>

</asp:Panel>



    </div>



    <asp:LinqDataSource ID="GetCityList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" OrderBy="city" TableName="qryAccountCityLists" Where="marketID == @marketID">
        <WhereParameters>
            <asp:ControlParameter ControlID="MarketList" PropertyName="SelectedValue" Name="marketID" Type="Int32"></asp:ControlParameter>
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="GetStateList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" OrderBy="city" TableName="qryStateListbyMarketIDs" Where="marketID == @marketID">
        <WhereParameters>
            <asp:ControlParameter ControlID="MarketList" PropertyName="SelectedValue" Name="marketID" Type="Int32"></asp:ControlParameter>
        </WhereParameters>
    </asp:LinqDataSource>


    <asp:LinqDataSource ID="GetAccountListbyMarketSearch" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" OrderBy="accountName" TableName="qryViewAccounts" Where="marketID == @marketID">
        <WhereParameters>

            <asp:ControlParameter ControlID="MarketList" Name="marketID" PropertyName="SelectedValue" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>


    <!-- Where="clientID == @clientID && marketID == @marketID" -->

    <!-- <asp:ControlParameter ControlID="HiddenClientID" Name="clientID" PropertyName="Value" Type="Int32" /> -->


    <asp:LinqDataSource ID="GetMarketList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" OrderBy="marketName" TableName="qryMarketsbyClients" Where="clientID == @clientID">
        <WhereParameters>
            <asp:ControlParameter ControlID="HiddenClientID" Name="clientID" PropertyName="Value" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    
   <%-- <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [getBrandsbySupplier] WHERE ([supplierID] = @supplierID)  ORDER BY [brandName]">
        <SelectParameters>
            <asp:ControlParameter ControlID="supplierIDComboBox" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>--%>



    <asp:LinqDataSource ID="GetEventTypeList" runat="server"
        ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" OrderBy="eventTypeName" TableName="qryEventTypeByClients" Where="clientID == @clientID">
        <WhereParameters>
            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:HiddenField ID="HiddenClientID" runat="server" />





</asp:Content>
