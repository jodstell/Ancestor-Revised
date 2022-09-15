<%@ Page Title="Add New Event" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AddNewEvent.aspx.vb" Inherits="EventManagerApplication.AddNewEvent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .RadWizard_Bootstrap .rwzPrevious {
            visibility: hidden;
        }

        .RadWizard_Bootstrap .rwzFinish {
            visibility:hidden;
        }

        .form-group {
            margin-bottom: 10px !important;
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


        })();
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="AddNewEventPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="AddNewEventPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<div class="container">
<asp:Panel ID="AddNewEventPanel" runat="server">
        
        <div class="row">
            <div class="col-xs-12">

                <div style="margin: 0 0 15px 0">
                    <h2>New Event:</h2>

                        Use this form to add a new event.  Complete each sections below and click on the Next button to continue to the next tab.<br />
                        Fields marked with asterisk (<span class="text-danger">*</span>) are required.

                </div>

            </div>
        </div>

        <div class="widget stacked">
            <div class="widget-content">

                <telerik:RadWizard ID="EventWizard" runat="server" DisplayNavigationBar="true" DisplayNavigationButtons="true" DisplayCancelButton="true" DisplayProgressBar="false" OnClientLoad="OnClientLoad">

                                <WizardSteps>


                                    <telerik:RadWizardStep Title="Event Information" ValidationGroup="details" CausesValidation="true">

                                    <div class="row" style="margin-left: 0px; margin-right: 0px; min-height: 400px;">
                                            
                                    <%--<h3>Please select a supplier</h3>--%>

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

                                        <div class="form-group">
                                            <label for="EventTypeIDTextBox" class="col-sm-3 control-label">Event Type <span class="text-danger">*</span></label>
                                            <div class="col-sm-5">

                                                <telerik:RadComboBox  ID="EventTypeIDComboBox" runat="server" DataSourceID="GetEventTypeList" AutoPostBack="false"
                                                    DataTextField="eventTypeName" Width="300px" AllowCustomText="false" MarkFirstMatch="true" EmptyMessage="Select Event Type" DataValueField="eventTypeID" AppendDataBoundItems="false">
                                                </telerik:RadComboBox>

                                                
                                                <%--<span class="help-block">Select the event type.  This is required!</span>--%>

                                                <asp:RequiredFieldValidator ID="EventTypeIDTextBoxRequiredFieldValidator" runat="server"
                                                    CssClass="errorlabel" Display="Dynamic" ValidationGroup="details"
                                                    ControlToValidate="EventTypeIDComboBox"
                                                    ErrorMessage="Event Type is required"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>


                                        <asp:LinqDataSource ID="GetEventTypeList" runat="server"
                                            ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                            EntityTypeName="" OrderBy="eventTypeName" TableName="qryEventTypeByClients" Where="clientID == @clientID">
                                            <WhereParameters>
                                                <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>

                                        <div class="form-group">
                                            <label for="EventTypeIDTextBox" class="col-sm-3 control-label">Team</label>
                                            <div class="col-sm-5">

                                                <telerik:RadComboBox  ID="TeamComboBox" runat="server" DataSourceID="GetTeamList" AutoPostBack="false"
                                                    DataTextField="teamName" Width="300px" AllowCustomText="false" EmptyMessage="Select a Team"
                                                    DataValueField="teamID" AppendDataBoundItems="false" MarkFirstMatch="true">
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
                                                    DataSourceID="getSupplierList" Width="300px" DataTextField="supplierName" DataValueField="supplierID" EmptyMessage="Select Supplier">                                                    
                                                </telerik:RadComboBox>

                                                <%--<asp:CompareValidator ID="supplierIDComparevalidator" ErrorMessage="Supplier is required"           ControlToValidate="supplierIDComboBox" runat="server" CssClass="errorlabel" Operator="NotEqual" 
                                                    ValueToCompare="Select Supplier" ValidationGroup="details" />--%>

                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                CssClass="errorlabel" Display="Dynamic" ValidationGroup="details"
                                                ControlToValidate="supplierIDComboBox"
                                                ErrorMessage="Supplier is required"></asp:RequiredFieldValidator>


                                                <asp:SqlDataSource ID="getSupplierList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetSuppliersByUserIDandClientID" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                                        <asp:SessionParameter SessionField="CurrentClientID" Name="clientID" Type="Int32"></asp:SessionParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>

                                                <%--<asp:LinqDataSource ID="getSuppliers" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                    EntityTypeName="" OrderBy="supplierName" TableName="tblSuppliers">
                                                </asp:LinqDataSource>--%>
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
                                            
                                    </div>

                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Brands" ValidationGroup="brands" CausesValidation="True">

                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Dates & Times" ValidationGroup="eventdate" CausesValidation="True">

                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Event Details" CausesValidation="false">

                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Location" ValidationGroup="location" CausesValidation="true">

                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Staff Requirements" ValidationGroup="staff" CausesValidation="true">

                                    </telerik:RadWizardStep>


                                    <telerik:RadWizardStep Title="Budget" ID="FinishTab">

                                    </telerik:RadWizardStep>


                                </WizardSteps>

                            </telerik:RadWizard>

            </div>
        </div>



</asp:Panel>
</div>

</asp:Content>
