<%@ Page Title="Register" Language="vb" AutoEventWireup="false" MasterPageFile="~/Master.Master" CodeBehind="Register.aspx.vb" Inherits="EventManagerApplication.Register" %>

<%@ Import Namespace="EventManagerApplication" %>
<%@ Import Namespace="Microsoft.AspNet.Identity" %>
<%@ Register Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" TagPrefix="CuteWebUI" %>


<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <style>
          div.RadUpload .ruBrowse {
            background-position: 0 -23px;
            width: 110px;
        }

        .form-group {
        margin-bottom: 10px;
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

        .uploadergrid {
           display: none !important;
       }

        .HeadBodyShotClass {
            display: none;
        }

        

        @media screen and (min-width: 280px) and (max-width: 980px) {
            .RadWizard_Bootstrap .rwzBreadCrumb {
                visibility: collapse !important;
            }
        }

        @media screen and (min-width: 980px) and (max-width: 1450px) {
            .phoneWidth {
                width: 50% !important;
            }
        }
        
        /*@media screen and (min-width: 280px) and (max-width: 1450px) {
            .navbar > .container .navbar-brand, .navbar > .container-fluid .navbar-brand {
                margin-left: 0px;
            }
        }*/

        @media screen and (min-width: 750px) and (max-width: 980px) {
            .photoMobile {
                width: 66% !important;
                left: 14vw !important;
            }
        }

        @media screen and (min-width: 280px) and (max-width: 1010px) {
            .availabilityPhone {
                width: 80% !important;
            }
        }

        @media screen and (min-width: 750px) and (max-width: 1150px) {
            .documensMobile {
                width: 90% !important;
            }
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

                // Your custom confirmation logic here
                var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                var currentUpdatedControl = "<%= RegistrationWizard.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.show(currentUpdatedControl);
            }

            }

        })();


        <%--function validateUpload(sender, args) {
            var upload = $find("<%= HeadShotPanel.ClientID %>");
            var upload1 = $find("<%= BodyshotPanel.ClientID %>");

            if (upload.visible = true)
                args.IsValid = true;
            else 
                args.IsValid = false;
        }--%>



        function containerMouseover(sender) {
            sender.getElementsByTagName("div")[0].style.display = "";
        }

        function containerMouseout(sender) {
            sender.getElementsByTagName("div")[0].style.display = "none";
        }

    </script>


    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="PanelDocuments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelDocuments" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="ResumeList" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="LicenseList" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="UploadResumePanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UploadResumePanel" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="UploadLicensePanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UploadLicensePanel" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings> 

        
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="UploadAttachments1Panel" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>                    
                    <telerik:AjaxUpdatedControl ControlID="UploadAttachments2Panel" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="HeadShotPanel"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="BodyshotPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
                     
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" Skin="Bootstrap" />


    <asp:HiddenField ID="tempUserID" runat="server" />

    <asp:Label ID="lbluserID" runat="server" Visible="false"></asp:Label>


    <div class="container min-height">

        <div class="row ">

            <div class="col-sm-12">
                <div style="margin: 25px 0 15px 0">
                    <h2>Brand Ambassador Registration</h2>
                    <p>Complete each sections below and click on the Next button to continue to the next tab.<br /> Fields marked with asterisk (<span class="text-danger">*</span>) are required.</p>
                </div>
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" ></telerik:RadAjaxLoadingPanel>

                <div class="widget stacked">
                    <div class="widget-content">

                        <asp:Label ID="msgLabel" runat="server" />

                        <telerik:RadWizard ID="RegistrationWizard" runat="server" DisplayCancelButton="true" DisplayProgressBar="false" Skin="Bootstrap"
                            OnClientLoad="OnClientLoad" OnClientButtonClicking="OnClientButtonClicking">

                            <Localization Finish="Finish & Submit Form" />

                    <WizardSteps>

                        <telerik:RadWizardStep Title="Overview" ValidationGroup="overview" CausesValidation="true">

                            <h3>Overview Information</h3>

                            <hr />

                            <div class="col-md-5">
                                <div class="form-horizontal">

                                    <div class="form-group">
                                        <label for="FirstNameTextBox" class="col-sm-4 control-label">First Name: <span class="text-danger">*</span></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="form-control" />
                                             <asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" runat="server"
                                                ErrorMessage="First Name is required." CssClass="errorlabel" ControlToValidate="FirstNameTextBox"
                                                Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="NicknameTextBox" class="col-sm-4 control-label">Middle Name:</label>
                                        <div class="col-sm-8">
                                            <asp:TextBox ID="NicknameTextBox" runat="server" CssClass="form-control" />

                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="LastNameTextBox" class="col-sm-4 control-label">Last Name: <span class="text-danger">*</span></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="form-control" />
                                             <asp:RequiredFieldValidator ID="LastNameRequiredFieldValidator" runat="server"
                                                ErrorMessage="Last Name is required." CssClass="errorlabel" ControlToValidate="LastNameTextBox"
                                                Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="col-md-7">
                                <div class="form-horizontal">

                                    <div class="form-group">
                                        <label for="DateofBirthTextBox" class="col-sm-4 control-label">Date of Birth: <span class="text-danger">*</span></label>
                                        <div class="col-sm-8">
                                            
                                            <div class="col-xs-12 col-md-4 phoneWidth" style="padding-left: 0; padding-bottom: 5px;">

                                                <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-control" Width="150px">
                                                    <asp:ListItem Text="Month" Value="" />
                                                    <asp:ListItem Text="January" Value="1" />
                                                    <asp:ListItem Text="Febrauary" Value="2" />
                                                    <asp:ListItem Text="March" Value="3" />
                                                    <asp:ListItem Text="April" Value="4" />
                                                    <asp:ListItem Text="May" Value="5" />
                                                    <asp:ListItem Text="June" Value="6" />
                                                    <asp:ListItem Text="July" Value="7" />
                                                    <asp:ListItem Text="August" Value="8" />
                                                    <asp:ListItem Text="September" Value="9" />
                                                    <asp:ListItem Text="October" Value="10" />
                                                    <asp:ListItem Text="November" Value="11" />
                                                    <asp:ListItem Text="December" Value="12" />
                                                </asp:DropDownList>

                                                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorMonth" runat="server" ControlToValidate="ddlMonth"
                                                        ErrorMessage="Select a Month" ValidationGroup="overview" CssClass="errorlabel" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>

                                            <div class="col-xs-10 col-md-4 phoneWidth" style="padding-left: 0; padding-bottom: 5px;">
                                                <asp:DropDownList ID="ddlDay" runat="server" CssClass="form-control" Width="150px">
                                                    <asp:ListItem Text="Day" Value=""></asp:ListItem>
                                                    <asp:ListItem>1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                    <asp:ListItem>4</asp:ListItem>
                                                    <asp:ListItem>5</asp:ListItem>
                                                    <asp:ListItem>6</asp:ListItem>
                                                    <asp:ListItem>7</asp:ListItem>
                                                    <asp:ListItem>8</asp:ListItem>
                                                    <asp:ListItem>9</asp:ListItem>
                                                    <asp:ListItem>10</asp:ListItem>
                                                    <asp:ListItem>11</asp:ListItem>
                                                    <asp:ListItem>12</asp:ListItem>
                                                    <asp:ListItem>13</asp:ListItem>
                                                    <asp:ListItem>14</asp:ListItem>
                                                    <asp:ListItem>15</asp:ListItem>
                                                    <asp:ListItem>16</asp:ListItem>
                                                    <asp:ListItem>17</asp:ListItem>
                                                    <asp:ListItem>18</asp:ListItem>
                                                    <asp:ListItem>19</asp:ListItem>
                                                    <asp:ListItem>20</asp:ListItem>
                                                    <asp:ListItem>21</asp:ListItem>
                                                    <asp:ListItem>22</asp:ListItem>
                                                    <asp:ListItem>23</asp:ListItem>
                                                    <asp:ListItem>24</asp:ListItem>
                                                    <asp:ListItem>25</asp:ListItem>
                                                    <asp:ListItem>26</asp:ListItem>
                                                    <asp:ListItem>27</asp:ListItem>
                                                    <asp:ListItem>28</asp:ListItem>
                                                    <asp:ListItem>29</asp:ListItem>
                                                    <asp:ListItem>30</asp:ListItem>
                                                    <asp:ListItem>31</asp:ListItem>
                                                </asp:DropDownList>

                                                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorDay" runat="server" ControlToValidate="ddlDay"
                                                        ErrorMessage="Select a Day" ValidationGroup="overview" CssClass="errorlabel" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>

                                            <div class="col-xs-10 col-md-4 phoneWidth" style="padding-left: 0">
                                                <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-control" Width="150px">
                                                </asp:DropDownList>

                                                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorYear" runat="server" ControlToValidate="ddlYear"
                                                        ErrorMessage="Select a Year" ValidationGroup="overview" CssClass="errorlabel" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>


                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="Gender" class="col-sm-4 control-label">Gender: <span class="text-danger">*</span></label>
                                        <div class="col-sm-8">

                                            <asp:DropDownList ID="GenderDropDownList" runat="server" CssClass="form-control" Width="175px">
                                                <asp:ListItem Value="">Please Select</asp:ListItem>
                                                <asp:ListItem Value="Male">Male</asp:ListItem>
                                                <asp:ListItem Value="Female">Female</asp:ListItem>
                                            </asp:DropDownList>

                                             <asp:RequiredFieldValidator ID="GenderRequiredFieldValidator" runat="server"
                                                ErrorMessage="Gender is required." CssClass="errorlabel" ControlToValidate="GenderDropDownList"
                                                Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="Citizen" class="col-sm-4 control-label">Are you a U.S. Citizen: <span class="text-danger">*</span></label>
                                        <div class="col-sm-8">

                                            <asp:DropDownList ID="CitizenDropDownList" runat="server" CssClass="form-control" Width="100px">
                                                <asp:ListItem Value="True">Yes</asp:ListItem>
                                                <asp:ListItem Value="False">No</asp:ListItem>
                                            </asp:DropDownList>

                                             <asp:RequiredFieldValidator ID="CitizenRequiredFieldValidator" runat="server"
                                                ErrorMessage="Citizen is required." CssClass="errorlabel" ControlToValidate="CitizenDropDownList"
                                                Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                </div>

                            </div>

                        </telerik:RadWizardStep>


                        <telerik:RadWizardStep Title="Contact Information" ValidationGroup="contact" CausesValidation="true">

                            <h3>Contact Information</h3>

                            <hr />

                            <div class="col-md-6">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <label for="Address1TextBox" class="col-sm-4 control-label">Address 1: <span class="text-danger">*</span></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox ID="Address1TextBox" runat="server" CssClass="form-control" />
                                            <asp:RequiredFieldValidator ID="Address1RequiredFieldValidator" runat="server"
                                                ErrorMessage="Address 1 is required." CssClass="errorlabel" ControlToValidate="Address1TextBox"
                                                Display="Dynamic" ValidationGroup="contact"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="Address2TextBox" class="col-sm-4 control-label">Address 2:</label>
                                        <div class="col-sm-8">
                                            <asp:TextBox ID="Address2TextBox" runat="server" CssClass="form-control" />

                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="CityTextBox" class="col-sm-4 control-label">City: <span class="text-danger">*</span></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox ID="CityTextBox" runat="server" CssClass="form-control" />
                                              <asp:RequiredFieldValidator ID="CityRequiredFieldValidator" runat="server"
                                                ErrorMessage="City is required." CssClass="errorlabel" ControlToValidate="CityTextBox"
                                                Display="Dynamic" ValidationGroup="contact"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="State" class="col-sm-4 control-label">State: <span class="text-danger">*</span></label>
                                        <div class="col-sm-8">

                                            <asp:DropDownList ID="StateDropDownList" runat="server" CssClass="form-control" Width="175px">
                                                <asp:ListItem Value="">Please Select</asp:ListItem>
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

                                             <asp:RequiredFieldValidator ID="StateRequiredFieldValidator" runat="server"
                                                ErrorMessage="State is required." CssClass="errorlabel" ControlToValidate="StateDropDownList"
                                                Display="Dynamic" ValidationGroup="contact"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="ZipTextBox" class="col-sm-4 control-label">Zip: <span class="text-danger">*</span></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox ID="ZipTextBox" runat="server" CssClass="form-control" Width="120px"  />
                                            <asp:RequiredFieldValidator ID="ZipRequiredFieldValidator" runat="server"
                                                ErrorMessage="Zip is required." CssClass="errorlabel" ControlToValidate="ZipTextBox"
                                                Display="Dynamic" ValidationGroup="contact"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="ZipTextBox" runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+" CssClass="errorlabel" Display="Dynamic"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>

                                </div>

                            </div>

                            <div class="col-md-6">
                                <div class="form-horizontal">

                                    <div class="form-group">
                                        <label for="PhoneNumberTextBox" class="col-sm-4 control-label">Phone Number: <span class="text-danger">*</span></label>
                                        <div class="col-sm-8">

                                            <telerik:RadMaskedTextBox RenderMode="Lightweight" ID="PhoneNumberTextBox" runat="server" Mask="(###)###-####" Width="222px" CssClass="form-control"></telerik:RadMaskedTextBox>
                                            <asp:RequiredFieldValidator ID="PhoneNumberRequiredFieldValidator" runat="server"
                                                ErrorMessage="Phone Number is required." CssClass="errorlabel" ControlToValidate="PhoneNumberTextBox"
                                                Display="Dynamic" ValidationGroup="contact"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="EmailAddressTextBox" class="col-sm-4 control-label">Email Address: <span class="text-danger">*</span></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox ID="EmailAddressTextBox" runat="server" CssClass="form-control" />
                                             <asp:RequiredFieldValidator ID="EmailAddressRequiredFieldValidator" runat="server"
                                                ErrorMessage="Email Address is required." CssClass="errorlabel" ControlToValidate="EmailAddressTextBox"
                                                Display="Dynamic" ValidationGroup="contact"></asp:RequiredFieldValidator>

                                            <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="EmailAddressTextBox" CssClass="errorlabel" ErrorMessage="Invalid Email Format" ValidationGroup="contact"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>

                                </div>

                            </div>

                        </telerik:RadWizardStep>


                        <telerik:RadWizardStep Title="Appearance" ValidationGroup="appearance" CausesValidation="true">
                            <div class="row1">
                                <h3>Appearance</h3>

                                <hr />

                                <div class="col-md-4">

                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label for="Height" class="col-sm-4 control-label">Height: </label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="HeightDropDownList" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="">Please Select</asp:ListItem>
                                                    <asp:ListItem Value="4ft 6in">4ft 6in</asp:ListItem>
                                                    <asp:ListItem Value="4ft 7in">4ft 7in</asp:ListItem>
                                                    <asp:ListItem Value="4ft 8in">4ft 8in</asp:ListItem>
                                                    <asp:ListItem Value="4ft 9in">4ft 9in</asp:ListItem>
                                                    <asp:ListItem Value="4ft 10in">4ft 10in</asp:ListItem>
                                                    <asp:ListItem Value="4ft 11in">4ft 11in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 0in">5ft 0in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 1in">5ft 1in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 2in">5ft 2in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 3in">5ft 3in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 4in">5ft 4in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 5in">5ft 5in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 6in">5ft 6in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 7in">5ft 7in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 8in">5ft 8in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 9in">5ft 9in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 10in">5ft 10in</asp:ListItem>
                                                    <asp:ListItem Value="5ft 11in">5ft 11in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 0in">6ft 0in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 1in">6ft 1in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 2in">6ft 2in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 3in">6ft 3in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 4in">6ft 4in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 6in">6ft 6in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 6in">6ft 6in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 7in">6ft 7in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 8in">6ft 8in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 9in">6ft 9in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 10in">6ft 10in</asp:ListItem>
                                                    <asp:ListItem Value="6ft 11in">6ft 11in</asp:ListItem>
                                                    <asp:ListItem Value="7ft 0in">7ft 0in</asp:ListItem>
                                                </asp:DropDownList>


                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="Weight" class="col-sm-4 control-label">Weight: </label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="WeightDropDownList" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="">Please Select</asp:ListItem>
                                                    <asp:ListItem Value="80lbs">80lbs</asp:ListItem>
                                                    <asp:ListItem Value="85lbs">85lbs</asp:ListItem>
                                                    <asp:ListItem Value="90lbs">90lbs</asp:ListItem>
                                                    <asp:ListItem Value="95lbs">95lbs</asp:ListItem>
                                                    <asp:ListItem Value="100lbs">100lbs</asp:ListItem>
                                                    <asp:ListItem Value="105lbs">105lbs</asp:ListItem>
                                                    <asp:ListItem Value="110lbs">110lbs</asp:ListItem>
                                                    <asp:ListItem Value="115lbs">115lbs</asp:ListItem>
                                                    <asp:ListItem Value="120lbs">120lbs</asp:ListItem>
                                                    <asp:ListItem Value="125lbs">125lbs</asp:ListItem>
                                                    <asp:ListItem Value="130lbs">130lbs</asp:ListItem>
                                                    <asp:ListItem Value="135lbs">135lbs</asp:ListItem>
                                                    <asp:ListItem Value="140lbs">140lbs</asp:ListItem>
                                                    <asp:ListItem Value="145lbs">145lbs</asp:ListItem>
                                                    <asp:ListItem Value="150lbs">150lbs</asp:ListItem>
                                                    <asp:ListItem Value="155lbs">155lbs</asp:ListItem>
                                                    <asp:ListItem Value="160lbs">160lbs</asp:ListItem>
                                                    <asp:ListItem Value="165lbs">165lbs</asp:ListItem>
                                                    <asp:ListItem Value="170lbs">170lbs</asp:ListItem>
                                                    <asp:ListItem Value="175lbs">175lbs</asp:ListItem>
                                                    <asp:ListItem Value="180lbs">180lbs</asp:ListItem>
                                                    <asp:ListItem Value="185lbs">185lbs</asp:ListItem>
                                                    <asp:ListItem Value="190lbs">190lbs</asp:ListItem>
                                                    <asp:ListItem Value="195lbs">195lbs</asp:ListItem>
                                                    <asp:ListItem Value="200lbs">200lbs</asp:ListItem>
                                                    <asp:ListItem Value="205lbs">205lbs</asp:ListItem>
                                                    <asp:ListItem Value="210lbs">210lbs</asp:ListItem>
                                                    <asp:ListItem Value="215lbs">215lbs</asp:ListItem>
                                                    <asp:ListItem Value="220lbs">220lbs</asp:ListItem>
                                                    <asp:ListItem Value="225lbs">225lbs</asp:ListItem>
                                                    <asp:ListItem Value="230lbs">230lbs</asp:ListItem>
                                                    <asp:ListItem Value="235lbs">235lbs</asp:ListItem>
                                                    <asp:ListItem Value="240lbs">240lbs</asp:ListItem>
                                                    <asp:ListItem Value="245lbs">245lbs</asp:ListItem>
                                                    <asp:ListItem Value="250lbs">250lbs</asp:ListItem>
                                                    <asp:ListItem Value="255lbs">255lbs</asp:ListItem>
                                                    <asp:ListItem Value="260lbs">260lbs</asp:ListItem>
                                                </asp:DropDownList>


                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="HairColor" class="col-sm-4 control-label">Hair Color:</label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="HairColorDropDownList" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="">Please Select</asp:ListItem>
                                                    <asp:ListItem Value="Bald">Bald</asp:ListItem>
                                                    <asp:ListItem Value="Black">Black</asp:ListItem>
                                                    <asp:ListItem Value="Blonde">Blonde</asp:ListItem>
                                                    <asp:ListItem Value="Brunette">Brunette</asp:ListItem>
                                                    <asp:ListItem Value="Other">Other</asp:ListItem>
                                                    <asp:ListItem Value="Red">Red</asp:ListItem>
                                                    <asp:ListItem Value="White">White</asp:ListItem>
                                                </asp:DropDownList>


                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="EyeColor" class="col-sm-4 control-label">Eye Color:</label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="EyeColorDropDownList" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="">Please Select</asp:ListItem>
                                                    <asp:ListItem Value="Blue">Blue</asp:ListItem>
                                                    <asp:ListItem Value="Brown">Brown</asp:ListItem>
                                                    <asp:ListItem Value="Green">Green</asp:ListItem>
                                                    <asp:ListItem Value="Hazel">Hazel</asp:ListItem>
                                                    <asp:ListItem Value="Other">Other</asp:ListItem>
                                                    <asp:ListItem Value="Purple">Purple</asp:ListItem>
                                                </asp:DropDownList>


                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="Piercings" class="col-sm-4 control-label">Piercings:</label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="PiercingsDropDownList" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="True">Yes</asp:ListItem>
                                                    <asp:ListItem Value="False" Selected="True">No</asp:ListItem>
                                                </asp:DropDownList>


                                            </div>
                                        </div>

                                    </div>

                                </div>


                                <asp:Panel ID="Panel1" runat="server">
                            
                                <div class="col-md-4">
                                    <div class="form-horizontal">
                                        <div class="form-group">

                                            <div class="col-sm-12 photoMobile">
                                                <strong>Upload your Head Shot Image: <span class="text-danger">*</span></strong><br />
                                                <br />
                                                <div class="panel panel-default">
                                                    <div class="panel-body">
                                                        <%-- <p>Your headshot is the main photo on your profile. It's a closely-cropped picture of your head and shoulders and is the first picture people will see when they view your profile. </p>--%>
                                                        <p>You can upload a JPG, GIF or PNG File.  File size limit is 4 MB.</p>

                                                        <%--<telerik:RadAsyncUpload ID="headShotUpload" runat="server" MultipleFileSelection="Disabled" MaxFileInputsCount="1" Skin="Bootstrap"
                                                            HideFileInput="true" Width="300px">
                                                            <Localization Select="Select Image" />
                                                        </telerik:RadAsyncUpload>--%>

                                                        <div class="row" style="margin-left: 5px;">
                                                        <asp:Panel ID="HeadShotPanel" runat="server" Visible="false">

                                                <asp:Repeater ID="headshot1" runat="server" DataSourceID="getHeadShot2">
                                                    <ItemTemplate>

                                                    <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail"
                                                            DataValue='<%#IIf(TypeOf (Eval("headShot")) Is DBNull, Nothing, Eval("headShot"))%>'
                                                            Height="180px" Width="180px" ResizeMode="Fit" />

                                                        <%--<div style="margin-top: -30px; position: absolute; display: none; width: <%#150/1.5 %>px;">
                                                            <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("headShot") %>' runat="server"                     Text="Delete" CssClass="txt" />--%>
                                                        </div>

                                                    </div>

                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                            
                                            <asp:SqlDataSource ID="getHeadShot2" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [headshot], [bodyshot] FROM [tblAmbassadorPhoto] WHERE ([userID] = @userID)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="tempUserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                                        </asp:Panel>
                                                        </div>

                                                        <div class="row" style="margin-left: 10px;">

                                                            <asp:Panel ID="UploadAttachments1Panel" runat="server">
                                                                <CuteWebUI:UploadAttachments ID="UploadAttachments1" OnFileUploaded="UploadAttachments1_HeadShot" runat="server" DropZoneID="DropPanel" InsertButtonStyle-CssClass="btn btn-default" InsertText="Select Image" CancelAllMsg=" " ProgressPanelWidth="200" MultipleFilesUpload="False">
                                                                    <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="4168" />
                                                                </CuteWebUI:UploadAttachments>
                                                            </asp:Panel>
                                                        </div>
                                                        
                                                    </div>
                                                </div>


                                                <asp:Label ID="errorLabel" runat="server" />

                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                ErrorMessage="Head Shot and Body Shot Images are required." CssClass="errorlabel" ControlToValidate="HeadBodyShot"
                                                Display="Dynamic" ValidationGroup="appearance"></asp:RequiredFieldValidator>--%>

                                                <asp:TextBox ID="HeadBodyShot" runat="server" Width="0px" Height="0px" CssClass="HeadBodyShotClass"></asp:TextBox>

                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-horizontal">


                                        <div class="form-group">

                                            <div class="col-sm-12 photoMobile">
                                                <strong>Upload your Body Shot Image: <span class="text-danger">*</span></strong><br />
                                                <br />
                                                <div class="panel panel-default">
                                                    <div class="panel-body">
                                                        <%-- <p>Your headshot is the main photo on your profile. It's a closely-cropped picture of your head and shoulders and is the first picture people will see when they view your profile. </p>--%>
                                                        <p>You can upload a JPG, GIF or PNG File. File size limit is 4 MB.</p>


                                                        <%--<telerik:RadAsyncUpload ID="bodyShotUpload" MultipleFileSelection="Disabled" MaxFileInputsCount="1" runat="server" Skin="Bootstrap"
                                                            HideFileInput="true" Width="300px">
                                                            <Localization Select="Select Image" />
                                                        </telerik:RadAsyncUpload>--%>




                                                        <div class="row" style="margin-left: 5px;">
                                                        <asp:Panel ID="BodyshotPanel" runat="server" Visible="false">

                                                <asp:Repeater ID="bodyShot2" runat="server" DataSourceID="getHeadShot2">
                                                    <ItemTemplate>

                                                    <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail"
                                                            DataValue='<%#IIf(TypeOf (Eval("bodyShot")) Is DBNull, Nothing, Eval("bodyShot"))%>'
                                                            Height="180px" Width="180px" ResizeMode="Fit" />

                                                        <%--<div style="margin-top: -30px; position: absolute; display: none; width: <%#150/1.5 %>px;">
                                                            <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("bodyShot") %>' runat="server"                     Text="Delete" CssClass="txt" />--%>
                                                        </div>

                                                    </div>

                                                    </ItemTemplate>
                                                </asp:Repeater>

                                                        </asp:Panel>
                                                        </div>


                                                        <asp:Panel ID="UploadAttachments2Panel" runat="server">
                                                        <div class="row" style="margin-left: 10px;">
                                            <CuteWebUI:UploadAttachments ID="UploadAttachments2" OnFileUploaded="UploadAttachments2_BodyShot" runat="server" DropZoneID="DropPanel" InsertButtonStyle-CssClass="btn btn-default" InsertText="Select Image" CancelAllMsg=" " ProgressPanelWidth="200" MultipleFilesUpload="False">
                                                <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="4168" />
                                            </CuteWebUI:UploadAttachments>
                                                            </div>
                                                            </asp:Panel>
                                                        
                                                    </div>
                                                </div>


                                            </div>
                                        </div>

                                    </div>
                                    
                                </div>
                                
                                </asp:Panel>

                            </div>

                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep Title="Availability" ValidationGroup="availability" CausesValidation="true">

                            <h3>Availability
                            </h3>

                            <hr />
                            <div class="col-md-12">
                                <div class="form-horizontal">

                                    <div class="form-group">
                                        <label for="AvailabilityDate" class="col-sm-5 control-label">Availability Date: <span class="text-danger">*</span></label>
                                        <div class="col-sm-7">
                                            <div class="col-xs-4 col-md-4 availabilityPhone" style="padding-left: 0; padding-bottom: 5px;">

                                                <asp:DropDownList ID="ddlMonthAD" runat="server" CssClass="form-control" Width="135px">
                                                    <asp:ListItem Text="January" Value="1" Selected="True"/>
                                                    <asp:ListItem Text="Febrauary" Value="2" />
                                                    <asp:ListItem Text="March" Value="3" />
                                                    <asp:ListItem Text="April" Value="4" />
                                                    <asp:ListItem Text="May" Value="5" />
                                                    <asp:ListItem Text="June" Value="6" />
                                                    <asp:ListItem Text="July" Value="7" />
                                                    <asp:ListItem Text="August" Value="8" />
                                                    <asp:ListItem Text="September" Value="9" />
                                                    <asp:ListItem Text="October" Value="10" />
                                                    <asp:ListItem Text="November" Value="11" />
                                                    <asp:ListItem Text="December" Value="12" />
                                                </asp:DropDownList>

                                            </div>

                                            <div class="col-xs-4 col-md-4 availabilityPhone" style="padding-left: 0; padding-bottom: 5px;">
                                                <asp:DropDownList ID="ddlDayAD" runat="server" CssClass="form-control" Width="135px">
                                                    <asp:ListItem Selected="True">1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                    <asp:ListItem>4</asp:ListItem>
                                                    <asp:ListItem>5</asp:ListItem>
                                                    <asp:ListItem>6</asp:ListItem>
                                                    <asp:ListItem>7</asp:ListItem>
                                                    <asp:ListItem>8</asp:ListItem>
                                                    <asp:ListItem>9</asp:ListItem>
                                                    <asp:ListItem>10</asp:ListItem>
                                                    <asp:ListItem>11</asp:ListItem>
                                                    <asp:ListItem>12</asp:ListItem>
                                                    <asp:ListItem>13</asp:ListItem>
                                                    <asp:ListItem>14</asp:ListItem>
                                                    <asp:ListItem>15</asp:ListItem>
                                                    <asp:ListItem>16</asp:ListItem>
                                                    <asp:ListItem>17</asp:ListItem>
                                                    <asp:ListItem>18</asp:ListItem>
                                                    <asp:ListItem>19</asp:ListItem>
                                                    <asp:ListItem>20</asp:ListItem>
                                                    <asp:ListItem>21</asp:ListItem>
                                                    <asp:ListItem>22</asp:ListItem>
                                                    <asp:ListItem>23</asp:ListItem>
                                                    <asp:ListItem>24</asp:ListItem>
                                                    <asp:ListItem>25</asp:ListItem>
                                                    <asp:ListItem>26</asp:ListItem>
                                                    <asp:ListItem>27</asp:ListItem>
                                                    <asp:ListItem>28</asp:ListItem>
                                                    <asp:ListItem>29</asp:ListItem>
                                                    <asp:ListItem>30</asp:ListItem>
                                                    <asp:ListItem>31</asp:ListItem>
                                                </asp:DropDownList>

                                            </div>

                                            <div class="col-xs-4 col-md-4 availabilityPhone" style="padding-left: 0">
                                                <asp:DropDownList ID="ddlYearAD" runat="server" CssClass="form-control" Width="135px">
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                ErrorMessage="Year is required." CssClass="errorlabel" ControlToValidate="ddlYearAD"
                                                Display="Dynamic" ValidationGroup="availability"></asp:RequiredFieldValidator>
                                            </div>


                                        </div>
                                    </div>



                                    <div class="form-group">
                                        <label for="LGBTAccounts" class="col-sm-5 control-label">Can you work LGBT Accounts:</label>
                                        <div class="col-sm-7">

                                            <asp:DropDownList ID="LGBTAccountsDropDownList" runat="server" CssClass="form-control" Width="120px">
                                                <asp:ListItem Value="True">Yes</asp:ListItem>
                                                <asp:ListItem Value="False">No</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                    </div>



                                    <div class="form-group">
                                        <label for="ReliableTransportation" class="col-sm-5 control-label">Do you have reliable transportation:</label>
                                        <div class="col-sm-7">

                                            <asp:DropDownList ID="ReliableTransportation" runat="server" CssClass="form-control" Width="150px">
                                                <asp:ListItem Value="True">Yes</asp:ListItem>
                                                <asp:ListItem Value="False">No</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                    </div>



                                    <div class="form-group">
                                        <label for="WillingMiles" class="col-sm-5 control-label">
                                            How many miles from your current location would you
                                            be willing to travel for an event:</label>
                                        <div class="col-sm-7">

                                            <asp:DropDownList ID="WillingMilesDropDownList" runat="server" CssClass="form-control" Width="190px">
                                                <asp:ListItem Value="" Text="- Select Distance -"></asp:ListItem>
                                                <asp:ListItem Value="50">Less than 50 miles</asp:ListItem>
                                                <asp:ListItem Value="100">Less than 100 miles</asp:ListItem>
                                                <asp:ListItem Value="200">Less than 200 miles</asp:ListItem>
                                                <asp:ListItem Value="500">No more than 500</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label for="Smartphone" class="col-sm-5 control-label">Do you have a Smartphone:</label>
                                        <div class="col-sm-7">

                                            <asp:DropDownList ID="SmartphoneDropDownList" runat="server" CssClass="form-control" Width="120px">
                                                <asp:ListItem Value="True">Yes</asp:ListItem>
                                                <asp:ListItem Value="False">No</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="SmartphoneOS" class="col-sm-5 control-label">Smartphone OS:</label>
                                        <div class="col-sm-7">

                                            <asp:DropDownList ID="SmartphoneOSDropDownList" runat="server" CssClass="form-control" Width="250px">
                                                <asp:ListItem Value="" Text="- Please Select -"></asp:ListItem>
                                                <asp:ListItem Value="Apple">Apple iOS</asp:ListItem>
                                                <asp:ListItem Value="Android">Android (Google Inc.)</asp:ListItem>
                                                <asp:ListItem Value="BlackBerry">BlackBerry (Research In Motion)</asp:ListItem>
                                                <asp:ListItem Value="Bada">Bada (Samsung Electronics)</asp:ListItem>
                                                <asp:ListItem Value="MeeGo OS">MeeGo OS (Nokia and Intel)</asp:ListItem>
                                                <asp:ListItem Value="MPalm">Palm OS</asp:ListItem>
                                                <asp:ListItem Value="Symbian">Symbian OS (Nokia)</asp:ListItem>
                                                <asp:ListItem Value="Windows">Microsoft's Windows Phone</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                    </div>



                                </div>
                            </div>

                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep Title="Licenses & Documents" ValidationGroup="licenses" CausesValidation="true">

                            <%--<div class="col-md-6">
                                <div class="form-horizontal">

                                    <div class="col-sm-12">
                                        <strong>Upload a current resume:</strong><br />
                                        <br />
                                        <div class="panel panel-default">
                                            <div class="panel-body">

                                                <p>You can upload a DOC, DOCX, PDF, RTF, TXT, ODT, or WPS file. File size limit is 4 MB.</p>


                                                <telerik:RadAsyncUpload ID="resumeUpload" MultipleFileSelection="Automatic" runat="server" Skin="Bootstrap"
                                                    HideFileInput="true" Width="300px">
                                                    <Localization Select="Select File" />
                                                </telerik:RadAsyncUpload>
                                            </div>
                                        </div>


                                    </div>


                                </div>
                            </div>--%>

                            <div class="col-md-12">
                                <div class="form-horizontal">
                                     <div class="form-group">


        <asp:Panel runat="server" ID="PanelDocuments">

                                <h3>Licenses & Documents</h3>
                            <hr />

                    <div class="col-md-12">

                        <div class="col-sm-6 documensMobile">
                        <b>Current Resume</b><br />

                        <asp:Repeater ID="ResumeList" runat="server" DataSourceID="getResumeList">
                            <HeaderTemplate>
                                <table class="table table-striped">
                                    <tbody>
                                    <tr>
                                                
                                        <th>File Name</th>
                                        <th>Date Uploaded</th>
                                        <th></th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                            
                                    <td><%# Eval("documentName") %></td>
                                    <td><%# Eval("dateUploaded", "{0:d}") %></td>
                                    <td>
                                        <asp:Button ID="btnDeleteFile" runat="server" Text="Delete" CommandName="DeleteFile" CommandArgument='<%# Eval("ambassadorFileID") %>' CssClass="btn btn-sm btn-danger" /></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>

                                    <asp:Label ID="lblEmptyData"
                                        Text='<%# Common.ShowAlertNoClose("warning", "There are no documents uploaded.")%>'  runat="server" Visible="false">
                                    </asp:Label>


                            </FooterTemplate>
                        </asp:Repeater>

                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getResumeList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblAmbassadorDocuments" Where="userID == @userID && category == @category" EnableDelete="True">
                            <WhereParameters>
                                <asp:ControlParameter ControlID="tempUserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                                <asp:Parameter DefaultValue="Resume" Name="category" Type="String"></asp:Parameter>
                            </WhereParameters>
                        </asp:LinqDataSource>



                        <asp:Button ID="btnOpenUpload1" runat="server" Text="Upload Resume" CssClass="btn btn-sm btn-primary" />
                            </div>

                        <div class="col-sm-6 documensMobile">
                        <b>Sampling license</b><br />

                        <asp:Repeater ID="LicenseList" runat="server" DataSourceID="getLienseList">
                            <HeaderTemplate>
                                <table class="table table-striped">
                                    <tbody>
                                    <tr>
                                        <th>File Name</th>
                                        <th class="hidden-xs">License Name</th>
                                        <th>Date Uploaded</th>
                                        <th>Expiration Date</th>
                                        <th></th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("documentTitle") %></td>
                                    <td class="hidden-xs"><%# Eval("documentName") %></td>
                                    <td><%# Eval("dateUploaded", "{0:d}") %></td>
                                    <td><%# Eval("expirationDate", "{0:d}") %></td>
                                    <td><asp:Button ID="btnDeleteFile" runat="server" Text="Delete" CommandName="DeleteFile" CommandArgument='<%# Eval("ambassadorFileID") %>' CssClass="btn btn-sm btn-danger" /></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>

                                <asp:Label ID="lblEmptyData"
                                        Text='<%# Common.ShowAlertNoClose("warning", "There are no documents uploaded.")%>'  runat="server" Visible="false">
                                    </asp:Label>
                            </FooterTemplate>
                        </asp:Repeater>

                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getLienseList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblAmbassadorDocuments" Where="category == @category && userID == @userID" EnableDelete="True">
                            <WhereParameters>
                                <asp:Parameter DefaultValue="License" Name="category" Type="String"></asp:Parameter>
                                <asp:ControlParameter ControlID="tempUserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                            </WhereParameters>
                        </asp:LinqDataSource>

                            <asp:Button ID="btnOpenUpload2" runat="server" Text="Upload License" CssClass="btn btn-sm btn-primary" />
                            </div>

                    </div>

                             </asp:Panel>


        <asp:Panel ID="UploadResumePanel" runat="server" Visible="false">

                            <h3>Upload Resume</h3>

                            <p>Use the form below to upload your resume.</p>
            
                        <div class="col-sm-4 documensMobile">
                            <div class="panel panel-default">
                                <div class="panel-body">

                                    <p>You can upload a DOC, DOCX, PDF, RTF, TXT, ODT, or WPS file. <br />File size limit is 2 MB.</p>

                                    <telerik:RadAsyncUpload ID="resumeUpload" MultipleFileSelection="Disabled" runat="server" Skin="Bootstrap"
                                        HideFileInput="true" Width="300px" MaxFileInputsCount="1">
                                        <Localization Select="Select File" />
                                    </telerik:RadAsyncUpload>

                                    <span class="allowed-attachments">Select file to upload </span>



                                    <div class="margintop20">
                                    <asp:Button ID="btnUploadResume" runat="server" Text="Upload File" CssClass="btn btn-primary" />
                                    <asp:Button ID="btnCancelUploadResume" runat="server" Text="Cancel" CssClass="btn btn-default" />
                                    </div>

                                </div>
                            </div>
                        </div>

        </asp:Panel>


        <asp:Panel ID="UploadLicensePanel" runat="server" Visible="false">
            
                    <h3>Upload License</h3>

                    <p>Use the form below to upload your license.</p>

                    <div class="col-sm-4 documensMobile">
                        <div class="panel panel-default">
                                <div class="panel-body">

                            <p>You can upload a DOC, DOCX, PDF, RTF, TXT, JPG,, GIF or PNG file. <br />File size limit is 2 MB.</p>

                                <telerik:RadAsyncUpload ID="LicenseUpload2" MultipleFileSelection="Disabled" runat="server" Skin="Bootstrap"
                                    HideFileInput="true" Width="300px" MaxFileInputsCount="1">
                                    <Localization Select="Select File" />
                                </telerik:RadAsyncUpload>

                                <span class="allowed-attachments">Select file to upload </span>

                                    <div class="form-horizontal">

                                        <div class="form-group">
                                        <label for="LicenseNameTextBox" class="col-sm-5 control-label">License Name: <span class="text-danger">*</span></label>
                                        <div class="col-sm-7">
                                            <asp:TextBox ID="LicenseNameTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="LicenseNameTextBoxFieldValidator" runat="server"
                                ErrorMessage="License Name is required." CssClass="errorlabel" ControlToValidate="LicenseNameTextBox"
                                Display="Dynamic" ValidationGroup="uploadLicense"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                        <label for="ExpirationTextBox" class="col-sm-5 control-label">Expiration Date: <span class="text-danger">*</span></label>
                                        <div class="col-sm-7">
                                            <asp:TextBox ID="ExpirationTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="ExpirationTextBoxRequiredFieldValidator" runat="server"
                                ErrorMessage="Expiration Date is required." CssClass="errorlabel" ControlToValidate="ExpirationTextBox"
                                Display="Dynamic" ValidationGroup="uploadLicense"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="margintop20">
                                    <asp:Button ID="btnUploadLicense" runat="server" Text="Upload File" CausesValidation="true" ValidationGroup="uploadLicense" CssClass="btn btn-primary" />
                                    <asp:Button ID="btnCancelUploadLicense" runat="server" Text="Cancel" CausesValidation="false" CssClass="btn btn-default" />
                                    </div>

                                </div>
                        </div>
                </div>
                        
    </asp:Panel>




                                         <%--<asp:Panel ID="LicensePanel" runat="server">
                                            <div class="col-sm-12">
                                                <strong>Upload an image of your current sampling license:</strong><br />
                                                <br />

                                                <asp:Button ID="btnOpenUpload2" runat="server" Text="Upload License" CssClass="btn btn-sm btn-primary" />
                                                <div class="panel panel-default">
                                                    <div class="panel-body">
                                                        <p>You can upload a JPG, GIF or PNG File. File size limit is 4 MB.</p>


                                                        <telerik:RadAsyncUpload ID="licenseUpload" MultipleFileSelection="Automatic" runat="server" Skin="Bootstrap"
                                                            HideFileInput="true" Width="300px">
                                                            <Localization Select="Select Image" />
                                                        </telerik:RadAsyncUpload>
                                                    </div>
                                                </div>


                                            </div>
                                        </asp:Panel>--%>
                                         
                                        </div>



                                </div>
                            </div>

                            <%--<div class="col-md-12">
                                <div class="form-horizontal">

                                    <div class="form-group">
                                        <label for="LicenseExpirationDateTextBox" class="col-sm-8 control-label">License Expiration Date:</label>
                                        <div class="col-sm-4">

                                            <telerik:RadDateInput RenderMode="Lightweight" ID="LicenseExpirationDateTextBox" runat="server" Width="150px" Culture="en-US"
                                                 EmptyMessage="Enter valid date" InvalidStyleDuration="100">
                                            </telerik:RadDateInput>

                                            <asp:RequiredFieldValidator ErrorMessage="Enter a valid date" ControlToValidate="LicenseExpirationDateTextBox" runat="server"
                                                ID="LicenseDateValidator" CssClass="errorlabel" ValidationGroup="licenses" Enabled="false" />     

                                        </div>
                                    </div>

                                </div>
                            </div>--%>

                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep Title="Assignments" ValidationGroup="assignments" CausesValidation="true">

                            <h3>Assignments</h3>
                            <hr />
                            <div class="col-sm-12">

                            <div class="form-horizontal">

                                    <div class="form-group">
                                        <label for="TypeofBrandstoWork" class="col-sm-3 control-label">Which brands do you want to work with?</label>
                                        <div class="col-sm-9">

                                            <asp:CheckBox ID="ckbBeer" runat="server" Text="Beer" />
                                            <asp:CheckBox ID="ckbSpirits" runat="server" Text="Spirits" />
                                            <asp:CheckBox ID="ckbWine" runat="server" Text="Wine" />
                                            <asp:CheckBox ID="ckbReadyToDrink" runat="server" Text="Ready to Drink" />
                                            <asp:CheckBox ID="ckbOther" runat="server" Text="Other" />

                                        </div>
                                    </div>






                                    <div class="form-group">

                                        <label for="TypeofPromotions" class="col-sm-3 control-label">What type of promotions are you most interested in?</label>
                                        <div class="col-sm-9">

                                            <asp:CheckBox ID="ckbRetailOffPremise" runat="server" Text="Retail/Off-premise" />
                                            <asp:CheckBox ID="ckbBarOnPremise" runat="server" Text="Bar/On-Premise" />
                                            <asp:CheckBox ID="ckbTradeShow" runat="server" Text="Trade Show" />
                                            <asp:CheckBox ID="ckbSecretShopper" runat="server" Text="Secret Shopper/Audit" />
                                            <br />
                                            <asp:CheckBox ID="ckbGolfCourse" runat="server" Text="Golf course" />
                                            <asp:CheckBox ID="ckbSportsVenue" runat="server" Text="Sports Venue" />
                                            <asp:CheckBox ID="ckbConvention" runat="server" Text="Convention" />
                                            <asp:CheckBox ID="ckbResturant" runat="server" Text="Resturant" />
                                            <asp:CheckBox ID="ckbGroceryStore" runat="server" Text="Grocery Store" />

                                        </div>

                                    </div>

                                </div>

                                </div>

                        </telerik:RadWizardStep>

                    </WizardSteps>
                </telerik:RadWizard>


    <asp:Panel ID="ConfirmationPanel" runat="server" Visible="false">

        <div class="row">

		<div class="col-md-12">

			<div class="error-container">
								<br /><br />	<br />
				<h2>The registration form has been submitted.</h2>
                <br />

				<div class="error-details">
					Thank you for your interest in working with GigEngyn as a Brand Ambassador. A company representative will contact you.
					<br />
				</div> <!-- /error-details -->

				<div class="error-actions">
					<a href="/" class="btn btn-primary btn-lg">
						<i class="icon-chevron-left"></i>
						&nbsp;
						Go to our website
					</a>

							<br />	<br />	<br />
				</div> <!-- /error-actions -->

			</div> <!-- /error-container -->

		</div> <!-- /span12 -->

	</div>

    </asp:Panel>


            <asp:Panel ID="ExistingRegistrationPanel" runat="server" Visible="false">

                <div class="row">

		            <div class="col-md-12">

			            <div class="error-container">
								            <br /><br />	<br />
				            <h2>The email address has already been submitted.</h2>
                            <br />

				            <div class="error-details">
					            Thank you for your interest in working with GigEngyn as a Brand Ambassador. A company representative will contact you.
					            <br />
				            </div> <!-- /error-details -->

				            <div class="error-actions">
					            <a href="/" class="btn btn-primary btn-lg">
						            <i class="icon-chevron-left"></i>
						            &nbsp;
						            Go to our website
					            </a>

							            <br />	<br />	<br />
				            </div> <!-- /error-actions -->

                            <div class="error-actions">
                                <div class="error-details">
                                    If you want to go back and change the email click on button down below.
                                </div>
                                
                                <br />
                                <asp:Button ID="btnGoToForm" runat="server" Text="Go Back to the Form" CssClass="btn btn-primary btn-lg" />

							            <br />	<br />	<br />
				            </div>

			            </div> <!-- /error-container -->

		            </div> <!-- /span12 -->

	            </div>

            </asp:Panel>



                        </div>

                    </div>

            </div>
        </div>
    </div>












   <%-- <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <h4>Create a new account</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                <asp:
        runat="server" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="The email field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="The password field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirm password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-default" />
            </div>
        </div>
    </div>--%>
</asp:Content>
