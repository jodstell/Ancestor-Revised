<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="NewActivityType.aspx.vb" Inherits="EventManagerApplication.NewActivityType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container">

        <div class="row">
            <div class="col-md-12">

                <div style="margin: 0 0 15px 0">
                    <h2>New Activity Type 
                    </h2>
                    <p>
                        Use this form to add a new activity type.  Complete each section below and click on the Next button to continue to the next tab.<br />
                        Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                    </p>

                    <asp:Label ID="msgLabel" runat="server" />

                </div>

                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

                    <div class="widget stacked">
                        <div class="widget-content">

                            <asp:TextBox ID="tempGUID" runat="server" Visible="false" />

                            <telerik:RadWizard ID="NewActivityTypeWizard" runat="server" DisplayCancelButton="true" DisplayProgressBar="false" Skin="Bootstrap">
                                <WizardSteps>
                                    <telerik:RadWizardStep Title="Details" ValidationGroup="Details">

                                        <div class="col-md-12">
                                            <div class="form-horizontal">

                                                <div class="form-group">

                                                    <label for="ActivityTypeNameTextBox" class="col-sm-2 control-label">Activity Type Title: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-4">

                                                        <asp:TextBox ID="ActivityTypeNameTextBox" runat="server" CssClass="form-control input-sm" />
                                                        <asp:RequiredFieldValidator ID="ActivityTypeNameTextBoxRequiredFieldValidator" runat="server"
                                                            ErrorMessage="This field is required." CssClass="errorlabel" ControlToValidate="ActivityTypeNameTextBox"
                                                            Display="Dynamic" ValidationGroup="Details"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ActiveTextBox" class="col-sm-2 control-label">Active: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-8">
                                                        <asp:DropDownList ID="ActiveTextBox" runat="server" CssClass="form-control" Width="100px">
                                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <span id="helpBlock1" class="help-block">Select Yes to enable this Event Type for the current client.</span>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                    </telerik:RadWizardStep>
                                    <telerik:RadWizardStep Title="Questions">

                                        <div class="col-md-12">
                                            


                                        </div>

                                    </telerik:RadWizardStep>

                                    
                                    
                                </WizardSteps>
                            </telerik:RadWizard>

                        </div>

                    </div>

                </telerik:RadAjaxPanel>





            </div>
        </div>
    </div>

</asp:Content>
