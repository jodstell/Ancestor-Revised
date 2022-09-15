<%@ Page Title="Add Supplier" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="NewSupplier.aspx.vb" Inherits="EventManagerApplication.NewSupplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <style type="text/css">
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

        .form-group {
            margin-bottom: 10px;
        }
    </style>

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

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel2">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel2" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>  

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel3">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel3" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>  
</telerik:RadAjaxManager>
    
<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>


    <asp:Panel ID="MainPanel" runat="server">

        <div class="container">

            <div class="row">
                <div class="col-md-12">

                    <div style="margin: 0 0 15px 0">
                        <h2>New Supplier
                        </h2>
                        <p>
                            Use this form to add a new supplier.  Complete each section below and click on the Next button to continue to the next tab.<br />
                            Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                        </p>

                    </div>



                    <asp:Label ID="msgLabel" runat="server" />

                    <div class="widget stacked">
                        <div class="widget-content min-height">

                            <asp:TextBox ID="tempGUID" runat="server" Visible="false" />


                            <telerik:RadWizard ID="NewSupplierWizard" runat="server" DisplayCancelButton="true" DisplayProgressBar="false" Skin="Bootstrap" OnClientButtonClicking="OnClientButtonClicking" OnClientLoad="OnClientLoad">
                                <WizardSteps>
                                    <telerik:RadWizardStep Title="Default Information" ValidationGroup="information">

                                        <div class="col-md-12">

                                            <h3>Supplier Information</h3>

                                            <hr />


                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                </div>

                                                <div class="form-group">
                                                    <label for="SupplierNameTextBox" class="col-sm-2 control-label">Name: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="SupplierNameTextBox" runat="server" CssClass="form-control input-sm" />

                                                        <asp:RequiredFieldValidator ID="userNameRequiredFieldValidator" runat="server"
                                                        ErrorMessage="Name is required" CssClass="errorlabel" ControlToValidate="SupplierNameTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="SupplierAddress1TextBox" class="col-sm-2 control-label">Supplier Address 1: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="SupplierAddress1TextBox" runat="server" CssClass="form-control input-sm" />

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                        ErrorMessage="Address 1 is required" CssClass="errorlabel" ControlToValidate="SupplierAddress1TextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="SupplierAddress2TextBox" class="col-sm-2 control-label">Supplier Address 2:</label>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="SupplierAddress2TextBox" runat="server" CssClass="form-control input-sm" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="CityTextBox" class="col-sm-2 control-label">City: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-3">
                                                        <asp:TextBox ID="CityTextBox" runat="server" CssClass="form-control input-sm" />

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                        ErrorMessage="City is required" CssClass="errorlabel" ControlToValidate="CityTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="StateTextBox" class="col-sm-2 control-label">State: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-3">
                                                        <asp:DropDownList ID="StateTextBox" runat="server" CssClass="form-control">
                                                            <asp:ListItem Text="-- Select State --" Value="" Selected="True"></asp:ListItem>
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

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                        ErrorMessage="State is required" CssClass="errorlabel" ControlToValidate="StateTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ZipTextBox" class="col-sm-2 control-label">Zip: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-2">
                                                        <asp:TextBox ID="ZipTextBox" runat="server" Width="90px" CssClass="form-control input-sm" />

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                        ErrorMessage="Zip is required" CssClass="errorlabel" ControlToValidate="ZipTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                 <div class="form-group">
                                            <label class="col-sm-2 control-label">Booking Request URL:</label>
                                            <div class="col-sm-4">
                                                <div class="input-group">
                                                  <span class="input-group-addon">http://events.gigengyn.com/Event_Request/</span>
                                                    <asp:TextBox ID="BookingRequestURLTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                </div>
                                                <span id="helpBlock" class="help-block">Add a short abbreviated name of the supplier.</span>
                                            </div>
                                        </div>

                                            </div>
                                        </div>

                                    </telerik:RadWizardStep>
                                    <telerik:RadWizardStep Title="Associated Brands">

                                        <div class="col-md-12">

                                            <h3>Associated Brands</h3>

                                            <hr />

                                            <asp:Panel ID="Panel3" runat="server">

                                            <div class='control-group'>

                                                <div class="list-containers">

                                                    <div class="list-container size-thin">
                                                        <div class="title">
                                                            Available Brands
                                                        </div>


                                                        <telerik:RadListBox ID="AssociatedBrandsList" runat="server"
                                                            TransferToID="SelectedBrandsList"
                                                            AllowTransferOnDoubleClick="true"
                                                            EnableDragAndDrop="true"
                                                            ButtonSettings-AreaWidth="35px" Height="200px" Width="330px"
                                                            AutoPostBack="false"
                                                            AllowTransfer="True"
                                                            AutoPostBackOnTransfer="true" Skin="Bootstrap" Style="top: 0; left: 0"
                                                            DataKeyField="brandID" DataSortField="brandName"
                                                            DataSourceID="getBrands" DataTextField="brandName" DataValueField="brandID">
                                                        </telerik:RadListBox>

                                                        <asp:LinqDataSource ID="getBrands" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" Select="new (brandID, brandName)" TableName="tblBrands" OrderBy="brandName" Where="clientID == @clientID">
                                                            <WhereParameters>
                                                                <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
                                                            </WhereParameters>
                                                        </asp:LinqDataSource>

                                                    </div>
                                                    <div class="list-container size-thin">

                                                        <div class="title">
                                                            Associated Brands
                                                        </div>

                                                        <telerik:RadListBox runat="server" ID="SelectedBrandsList"
                                                            DataKeyField="brandID"
                                                            DataSortField="brandName"
                                                            DataTextField="brandName"
                                                            DataValueField="brandID"
                                                            AllowDelete="True"
                                                            AutoPostBack="false"
                                                            AutoPostBackOnDelete="true"
                                                            Height="200px" Width="325px" Skin="Bootstrap">
                                                        </telerik:RadListBox>
                                                    </div>

                                                </div>
                                            </div>

                                            </asp:Panel>

                                        </div>

                                        <asp:HiddenField ID="HF_SelectedItemID" runat="server" />

                                    </telerik:RadWizardStep>

                                   <%-- <telerik:RadWizardStep Title="Roles">
                                        <div class="col-md-12">
                                            <h3>Roles</h3>

                                            <hr />

                                            <p>This feature has not been completed.</p>
                                            <p>Please continue to the next section.</p>
                                            <p></p>
                                        </div>


                                    </telerik:RadWizardStep>--%>

                                    <telerik:RadWizardStep Title="Billing Rates" ValidationGroup="billing">
                                        <div class="col-md-12">
                                            <h3>Billing Rates</h3>

                                            <hr />
                                            <h4>Event Types</h4>

                                            <asp:Panel ID="Panel1" runat="server">
                                            <telerik:RadListView ID="BillingRates_EventTypeList" runat="server" DataKeyNames="BillingRateID"
                                                DataSourceID="getBillingRates_EventType" InsertItemPosition="FirstItem">

                                                <LayoutTemplate>
                                                    <div class="RadListView RadListView_Metro1">
                                                        <asp:LinkButton ID="btnInsert3" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                            CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New</asp:LinkButton>

                                                        <div id="itemPlaceholder" runat="server">
                                                        </div>
                                                    </div>
                                                </LayoutTemplate>

                                                <ItemTemplate>
                                                    <div class="rlvI1">
                                                        <%--<asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                                            CssClass="btn btn-xs btn-primary" Text="Edit" ToolTip="Edit" />--%>

                                                        &nbsp;<asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" Text="Remove" ToolTip="Remove" />

                                                        &nbsp;<asp:Label ID="RelatedItemIDLabel" runat="server" Text='<%# getEventTypeName(Eval("RelatedItemID"))%>' />:
                                                &nbsp;$<asp:Label ID="RateLabel" runat="server" Text='<%# Eval("Rate") %>' />/<asp:Label ID="BillingRateTypeLabel" runat="server" Text='<%# Eval("BillingRateType") %>' />

                                                    </div>
                                                </ItemTemplate>

                                                <EditItemTemplate>
                                                    <div class="rlvIEdit1">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">

                                                                <div class="form-horizontal" style="width: 50%;">
                                                                    <div class="form-group">
                                                                        <label for="ddlActivity" class="col-sm-2 control-label">Activity</label>
                                                                        <div class="col-sm-10">
                                                                            <asp:DropDownList ID="ddlActivity" runat="server" CssClass="form-control input-sm"
                                                                                DataSourceID="getEventTypeList" AppendDataBoundItems="true" DataTextField="eventTypeName" DataValueField="eventTypeID" SelectedValue='<%# Eval("RelatedItemID") %>'>
                                                                                <asp:ListItem Text="-- Select Activity --" Value="">
                                                                                </asp:ListItem>
                                                                            </asp:DropDownList>

                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                                                                ErrorMessage="Activity is required" CssClass="errorlabel" ControlToValidate="ddlActivity"
                                                                                Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label for="RateTextBox" class="col-sm-2 control-label">Rate</label>
                                                                        <div class="col-sm-5">
                                                                            <div class="input-group input-group-sm">
                                                                                <span class="input-group-addon">$</span>
                                                                                <%--<asp:TextBox ID="RateTextBox" runat="server" CssClass="form-control"
                                                                                    Text='<%# Bind("Rate") %>' TextMode="Number" />--%>
                                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="RateTextBox" Value="0" 
                                                                                Type="Number" MinValue="0" Width="180px" NumberFormat-DecimalDigits="0" DisplayText='<%# Bind("Rate")%>' />
                                                                                <span class="input-group-addon">Hour</span>
                                                                            </div>

                                                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                                                                ErrorMessage="Rate is required" CssClass="errorlabel" ControlToValidate="RateTextBox"
                                                                                Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>--%>
                                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid number" 
                                                                                CssClass="errorlabel" ControlToValidate="RateTextBox" Display="Dynamic" ValidationGroup="billing" 
                                                                                ValidationExpression="^\d+$" />

                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-sm-2 control-label"></label>
                                                                        <div class="col-sm-10">
                                                                            <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-xs btn-primary" ValidationGroup="billing" />
                                                                            <asp:Button ID="btnCancelUpdate" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-xs btn-default" />
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </EditItemTemplate>

                                                <InsertItemTemplate>

                                                    <div class="rlvIEdit1">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">

                                                                <h5>Add new billing rate:</h5>

                                                                <div class="form-horizontal">
                                                                    <div class="form-group">
                                                                        <label for="ddlActivity1" class="col-sm-2 control-label">Activity</label>
                                                                        <div class="col-sm-4">
                                                                            <asp:DropDownList ID="ddlActivity1" runat="server" CssClass="form-control input-sm"
                                                                                DataSourceID="getEventTypeList" AppendDataBoundItems="true" DataTextField="eventTypeName"
                                                                                DataValueField="eventTypeID" SelectedValue='<%# Bind("RelatedItemID") %>'>
                                                                                <asp:ListItem Text="-- Select Activity --" Value="">
                                                                                </asp:ListItem>
                                                                            </asp:DropDownList>

                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                                                ErrorMessage="Activity is required" CssClass="errorlabel" ControlToValidate="ddlActivity1"
                                                                                Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label for="txtRate1" class="col-sm-2 control-label">Rate</label>
                                                                        <div class="col-sm-2">
                                                                            <div class="input-group input-group-sm">
                                                                                <span class="input-group-addon">$</span>
                                                                                <%--<asp:TextBox ID="txtRate1" runat="server" CssClass="form-control"
                                                                                    Text='<%# Bind("Rate")%>' TextMode="Number" ValidationGroup="billing" />--%>
                                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtRate1" Value="0" 
                                                                                        Type="Number" MinValue="0" Width="120px" NumberFormat-DecimalDigits="0" DisplayText='<%# Bind("Rate")%>' />
                                                                                <span class="input-group-addon">Hour</span>
                                                                            </div>

                                                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                                                                ErrorMessage="Rate is required" CssClass="errorlabel" ControlToValidate="txtRate1"
                                                                                Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>--%>
                                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid number" 
                                                                                CssClass="errorlabel" ControlToValidate="txtRate1" Display="Dynamic" ValidationGroup="billing" 
                                                                                ValidationExpression="^\d+$" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-sm-2 control-label"></label>
                                                                        <div class="col-sm-10">
                                                                            <asp:Button ID="btnInsert1" runat="server" CommandName="PerformInsert" Text="Save" CssClass="btn btn-xs btn-primary" ValidationGroup="billing" />
                                                                            <asp:Button ID="btnCancelInsert1" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-xs btn-default" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>

                                                </InsertItemTemplate>

                                                <EmptyDataTemplate>
                                                    <div>
                                                        <div class="marginbotton10">
                                                            <asp:LinkButton ID="btnInsert2" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                                Text="Add" CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New</asp:LinkButton>
                                                        </div>
                                                        <br />
                                                        <br />
                                                        <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New</strong> button above.</div>
                                                    </div>
                                                </EmptyDataTemplate>


                                            </telerik:RadListView>
                                            </asp:Panel>


                                            <asp:LinqDataSource ID="getBillingRates_EventType" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tempSupplierBillingRates" Where="tempSupplierID == @tempSupplierID &amp;&amp; RateType == @RateType">
                                                <WhereParameters>
                                                    <asp:ControlParameter PropertyName="Text" ControlID="tempGUID" Type="String" Name="tempSupplierID" />
                                                    <asp:Parameter DefaultValue="1" Name="RateType" Type="Int32" />
                                                </WhereParameters>
                                            </asp:LinqDataSource>

                                            <asp:LinqDataSource ID="getEventTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="eventTypeName" TableName="qryEventTypeByClients" Where="clientID == @clientID">
                                                <WhereParameters>
                                                    <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>

                                        </div>

                                        <div class="col-md-12">
                                            <hr />
                                            <h4>Agency Fees</h4>

                                            <table class="table tight_table" style="width: 600px">
                                                <tbody>
                                                    <tr>

                                                        <th style="width: 155px">Fee</th>
                                                        <th style="width: 60px">Rate</th>
                                                        <th></th>
                                                    </tr>
                                                    <tr>

                                                        <td style="width: 200px">Management Fee</td>
                                                        <td style="width: 60px">


                                                            <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="ManagementFeeNumericTextBox" Value="0" Type="Percent" MinValue="0" MaxValue="100" Width="100px" NumberFormat-DecimalDigits="0" />

                                                          <%--  <div class="input-group input-group-sm">

                                                                <asp:TextBox ID="ManagementFeeTextBox" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                                <span class="input-group-addon">%</span>
                                                            </div>--%>
                                                        </td>
                                                        <td><asp:RequiredFieldValidator ID="ManagementFeeRequiredFieldValidator" runat="server"
                                                        ErrorMessage="The value can not be blank" CssClass="errorlabel" ControlToValidate="ManagementFeeNumericTextBox"
                                                        Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator></td>
                                                    </tr>
                                                    <tr>

                                                        <td>Sampling/Product Spend Fee</td>
                                                        <td>
                                                            <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="SamplingFeeNumericTextBox" Value="0" 
                                                                Type="Percent" MinValue="0" MaxValue="100" Width="100px" NumberFormat-DecimalDigits="0" />


                                                        </td>
                                                        <td><asp:RequiredFieldValidator ID="SamplingFeeRequiredFieldValidator" runat="server"
                                                        ErrorMessage="The value can not be blank" CssClass="errorlabel" ControlToValidate="SamplingFeeNumericTextBox"
                                                        Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator></td>
                                                    </tr>
                                                    <tr>

                                                        <td>POS Storage</td>
                                                        <td>

                                                            <div class="input-group input-group-sm">
                                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="POSNumberBox" Value="0" Type="Currency" MinValue="0" 
                                                        Width="100px" NumberFormat-DecimalDigits="0" />
                                                                    <span class="input-group-addon">/Month</span>
                                                                </div>

                                                        </td>
                                                        <td> <asp:RequiredFieldValidator ID="POSNumberBoxRequiredFieldValidator" runat="server"
                                                        ErrorMessage="The value can not be blank" CssClass="errorlabel" ControlToValidate="POSNumberBox"
                                                        Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator></td>
                                                    </tr>
                                                </tbody>
                                            </table>


                                        </div>

                                        <div class="col-md-12">
                                            <hr />
                                            <h4>Market Surcharges</h4>
                                            
                                            <asp:Panel ID="Panel2" runat="server">

                                            <telerik:RadListView ID="BillingRates_MarketSurchargeList" runat="server" DataKeyNames="BillingRateID"
                                                DataSourceID="getBillingRates_Market" InsertItemPosition="FirstItem">

                                                <LayoutTemplate>
                                                    <div class="RadListView RadListView_Metro1">

                                                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                            CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New</asp:LinkButton>


                                                        <div id="itemPlaceholder" runat="server">
                                                        </div>
                                                    </div>
                                                </LayoutTemplate>

                                                <ItemTemplate>
                                                    <div class="rlvI1">
                                                        <%--<asp:Button ID="EditButton2" runat="server" CausesValidation="False" CommandName="Edit"
                                                            CssClass="btn btn-xs btn-primary" Text="Edit" ToolTip="Edit" />--%>
                                                        &nbsp;<asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" Text="Remove" ToolTip="Remove" />
                                                        &nbsp;<asp:Label ID="RelatedItemIDLabel" runat="server" Text='<%# getMarketName(Eval("RelatedItemID"))%>' />:
                                                &nbsp;$<asp:Label ID="RateLabel" runat="server" Text='<%# Eval("Rate") %>' />/<asp:Label ID="MarketLabel" runat="server" Text='<%# Eval("BillingRateType") %>' />

                                                    </div>
                                                </ItemTemplate>

                                                <EditItemTemplate>
                                                    <div class="rlvIEdit1">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">


                                                                <div class="form-horizontal" style="width: 50%;">
                                                                    <div class="form-group">
                                                                        <label for="ddlMarkets" class="col-sm-2 control-label">Market</label>
                                                                        <div class="col-sm-10">
                                                                            <asp:DropDownList ID="ddlMarkets" runat="server" CssClass="form-control input-sm"
                                                                                DataSourceID="getMarketList" AppendDataBoundItems="true"
                                                                                DataTextField="marketName" DataValueField="marketID"
                                                                                SelectedValue='<%# Eval("RelatedItemID") %>'>
                                                                                <asp:ListItem Text="-- Select Market --" Value="">
                                                                                </asp:ListItem>
                                                                            </asp:DropDownList>

                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                                                                ErrorMessage="Market is required" CssClass="errorlabel" ControlToValidate="ddlMarkets"
                                                                                Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label for="RateTextBox" class="col-sm-2 control-label">Rate</label>
                                                                        <div class="col-sm-5">
                                                                            <div class="input-group input-group-sm">
                                                                                <span class="input-group-addon">$</span>
                                                                                <%--<asp:TextBox ID="RateTextBox" runat="server" CssClass="form-control"
                                                                                    Text='<%# Bind("Rate") %>' TextMode="Number" />--%>
                                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="RateTextBox" Value="0" 
                                                                                Type="Number" MinValue="0" Width="180px" NumberFormat-DecimalDigits="0" DisplayText='<%# Bind("Rate")%>' />
                                                                                <span class="input-group-addon">Hour</span>
                                                                            </div>

                                                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                                                                ErrorMessage="Rate is required" CssClass="errorlabel" ControlToValidate="RateTextBox"
                                                                                Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>--%>
                                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid number" 
                                                                                CssClass="errorlabel" ControlToValidate="RateTextBox" Display="Dynamic" ValidationGroup="billing" 
                                                                                ValidationExpression="^\d+$" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-sm-2 control-label"></label>
                                                                        <div class="col-sm-10">
                                                                            <asp:Button ID="btnUpdate3" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-xs btn-primary" ValidationGroup="billing" />
                                                                            <asp:Button ID="btnCancelUpdate3" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-xs btn-default" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </EditItemTemplate>

                                                <InsertItemTemplate>

                                                    <div class="rlvIEdit1">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">

                                                                <h5>Add new billing rate:</h5>

                                                                <div class="form-horizontal">
                                                                    <div class="form-group">
                                                                        <label for="ddlMarkets2" class="col-sm-2 control-label">Market</label>
                                                                        <div class="col-sm-4">
                                                                            <asp:DropDownList ID="ddlMarkets" runat="server" CssClass="form-control input-sm"
                                                                                DataSourceID="getMarketList" AppendDataBoundItems="true"
                                                                                DataTextField="marketName" DataValueField="marketID"
                                                                                SelectedValue='<%# Bind("RelatedItemID") %>'>
                                                                                <asp:ListItem Text="-- Select Market --" Value="">
                                                                                </asp:ListItem>
                                                                            </asp:DropDownList>

                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                                                                ErrorMessage="Market is required" CssClass="errorlabel" ControlToValidate="ddlMarkets"
                                                                                Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label for="txtRate" class="col-sm-2 control-label">Rate</label>
                                                                        <div class="col-sm-2">
                                                                            <div class="input-group input-group-sm">
                                                                                <span class="input-group-addon">$</span>
                                                                                <%--<asp:TextBox ID="txtRate5" runat="server" CssClass="form-control"
                                                                                    Text='<%# Bind("Rate")%>' TextMode="Number" />--%>
                                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtRate5" Value="0" 
                                                                                Type="Number" MinValue="0" Width="120px" NumberFormat-DecimalDigits="0" DisplayText='<%# Bind("Rate")%>' />
                                                                                <span class="input-group-addon">Hour</span>
                                                                            </div>

                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                                                                ErrorMessage="Rate is required" CssClass="errorlabel" ControlToValidate="txtRate5"
                                                                                Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid number" 
                                                                                CssClass="errorlabel" ControlToValidate="txtRate5" Display="Dynamic" ValidationGroup="billing" 
                                                                                ValidationExpression="^\d+$" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-sm-2 control-label"></label>
                                                                        <div class="col-sm-10">
                                                                            <asp:Button ID="btnInsertMarketSurcharge" runat="server" CommandName="PerformInsert" Text="Save" CssClass="btn btn-xs btn-primary" ValidationGroup="billing" />
                                                                            <asp:Button ID="btnCancelInsert" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-xs btn-default" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>

                                                </InsertItemTemplate>

                                                <EmptyDataTemplate>
                                                    <div class="RadListView RadListView_Metro1">

                                                        <asp:LinkButton ID="btnInsert1" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                            CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New</asp:LinkButton>
                                                        <br />
                                                        <br />

                                                        <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New</strong> button above.</div>
                                                    </div>
                                                </EmptyDataTemplate>

                                            </telerik:RadListView>

                                            </asp:Panel>


                                            <asp:LinqDataSource ID="getMarketList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                EntityTypeName="" OrderBy="marketName" TableName="tblMarkets">
                                            </asp:LinqDataSource>

                                            <asp:LinqDataSource ID="getBillingRates_Market" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tempSupplierBillingRates" Where="tempSupplierID == @tempSupplierID &amp;&amp; RateType == @RateType">
                                                <WhereParameters>
                                                    <asp:ControlParameter PropertyName="Text" ControlID="tempGUID" Type="String" Name="tempSupplierID" />
                                                    <asp:Parameter DefaultValue="3" Name="RateType" Type="Int32" />
                                                </WhereParameters>
                                            </asp:LinqDataSource>

                                            <asp:LinqDataSource ID="getMarketSurcharge" runat="server"
                                                ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                EnableDelete="True" EnableInsert="True" EnableUpdate="True"
                                                EntityTypeName="" TableName="tempSupplierBillingRates" Where="RateType == @RateType && tempSupplierID == @tempSupplierID">
                                                <WhereParameters>
                                                    <asp:Parameter DefaultValue="3" Name="RateType" Type="Int32" />
                                                    <asp:ControlParameter PropertyName="Text" ControlID="tempGUID" Type="String" Name="tempSupplierID" />
                                                </WhereParameters>
                                            </asp:LinqDataSource>

                                        </div>

                                    </telerik:RadWizardStep>
                                    <telerik:RadWizardStep Title="Billing Contact">
                                        <div class="col-md-12">

                                            <h3>Billing Contact</h3>

                                            <hr />

                                            <div class="col-sm-6">

                                                <div class="form-horizontal">

                                                    <div class="form-group">
                                                        <label for="ContactNameTextBox" class="col-sm-4 control-label">Contact Name:</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="ContactNameTextBox" runat="server" CssClass="form-control input-sm" Text='<%# Eval("contactName")%>' />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="ContactEmailTextBox" class="col-sm-4 control-label">Email:</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="ContactEmailTextBox" runat="server" CssClass="form-control input-sm" Text='<%# Eval("contactEmail")%>' />
                                                        </div>
                                                    </div>


                                                </div>
                                            </div>

                                            <div class="col-sm-6">
                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label for="PhoneNumberTextBox" class="col-sm-4 control-label">Phone Number:</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="PhoneNumberTextBox" runat="server" CssClass="form-control input-sm" Text="" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="SupplierWebSiteTextBox" class="col-sm-4 control-label">Supplier Web Site:</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="SupplierWebSiteTextBox" runat="server" CssClass="form-control input-sm" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <br />

                                        <div class="col-md-12">


                                            <div class="col-md-5">
                                                <div class="col-md-12">
                                                    <div class="form-horizontal">
                                                        <div class="form-group">

                                                            <div class="col-md-12">
                                                                <strong><span class="control-label">Invioce Header/Bill To:</span></strong>
                                                                <asp:TextBox ID="InvoiceHeaderTextBox" TextMode="multiline" runat="server"
                                                                    Height="130px" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-7">

                                                <div class="form-horizontal">
                                                    <h4></h4>
                                                    <br />
                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-4 control-label">Billing Contact Name:</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="billingContactName" runat="server"
                                                                CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="BillingContactEmailTextBox" class="col-sm-4 control-label">Billing Contact Email:</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="BillingContactEmailTextBox" runat="server" CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="BillingContactPhoneTextBox" class="col-sm-4 control-label">Billing Contact Phone #:</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="BillingContactPhoneTextBox" runat="server" CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                </div>



                                            </div>


                                        </div>
                                    </telerik:RadWizardStep>
                                    <telerik:RadWizardStep Title="Documents">
                                        <div class="col-md-12">
                                            <h3>Documents</h3>

                                            <hr />

                                            <p>Upload related Contracts and Purchase Orders.</p>
                                            <p>
                                                You may upload the following files types: pdf, doc, docx, xls, xlsx, csv, txt, jpg, jpeg, png, and gif.



                                            </p>

                                            <div class="well">

                                                <h4 class="additional-text">Select multiple files at a time and upload them</h4>

                                                <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server"></telerik:RadAsyncUpload>




                                            </div>

                                            <p></p>
                                            <p>Click on the Finish button to add this supplier.</p>

                                        </div>
                                    </telerik:RadWizardStep>
                                </WizardSteps>
                            </telerik:RadWizard>





                        </div>





                    </div>



                </div>
            </div>




            <asp:LinqDataSource ID="getMarkets" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblMarkets">
            </asp:LinqDataSource>

            <asp:LinqDataSource ID="getEventTypes" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblEventTypes">
            </asp:LinqDataSource>

        </div>

    </asp:Panel>


</asp:Content>
