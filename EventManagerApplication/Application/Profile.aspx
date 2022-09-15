<%@ Page Title="Profile" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Profile.aspx.vb" Inherits="EventManagerApplication.Profile" %>

<%@ Register Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" TagPrefix="CuteWebUI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="../Theme/css/custom1.css" rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../Theme/css/custom1.css" rel="stylesheet" />
    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="Profile.css" rel="stylesheet" />

    <style>
        #headshotButton {
            display: none;
        }

         #bodyshotButton {
            display: none;
        }

         .uploadergrid {
           display: none !important;
       }
    </style>

    <script>

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
                        return ("This file exceeds the maximum allowed size of 2 MB.");
                    }
                }
                else {
                    return ("not correct extension.");
                }
            }

            function createError(erorMessage) {
                var input = '<span class="errorlabel" style="color: red;">' + erorMessage + ' </span>';
                return input;
            }



        })();

    </script>

<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="MainPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="RadNotification1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManager>



<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" BackgroundPosition="Center"></telerik:RadAjaxLoadingPanel>


    <div class="container min-height">


        <div class="row">
            <div class="col-md-12">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>
        </div>
        <!--End Row-->


        <asp:Panel ID="MainPanel" runat="server">

         <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Height="140px"
            Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500"
            Position="BottomRight" OffsetX="-30" OffsetY="-70" ShowCloseButton="true"  Text="Your changes were updated successfully!" Title="Success" TitleIcon="info"
            KeepOnMouseOver="true">
        </telerik:RadNotification>

        <div class="row">
            <%--<div class="visible-xs visible-sm">--%>
            <div class="col-xs-12">

                <h2>My Profile</h2>

                   <p>Please keep your personal information up-to-date! Use the forms below to upload your profile photo's, licenses and resume.</p>

                <asp:Panel ID="ProfilePanel" runat="server">


         <div class="row" style="margin-bottom:15px;">
            <div class="col-sm-12">
                                
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" Text="Save Changes" CssClass="btn btn-primary" ValidationGroup="overview" />
                <asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" Text="Cancel" CssClass="btn btn-default" />
                
            </div>
        </div>

<!-- Overview -->
                <asp:Panel ID="OverviewPanel" runat="server">
                    <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Overview</h3>
                                <hr />


                                 <div class="col-sm-5">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                    <label class="col-sm-5 control-label">First Name: <span class="text-danger">*</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox runat="server" ID="FirstNameTextBox" CssClass="form-control"/>

                                    <asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" runat="server"
                                        ErrorMessage="First Name is required." CssClass="errorlabel" ControlToValidate="FirstNameTextBox"
                                        Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                </div>
                                        </div>

                                        <div class="form-group">
                            <label for="NicknameTextBox" class="col-sm-5 control-label">Middle Name: </label>
                                            <div class="col-sm-7">
                            <asp:TextBox runat="server" ID="MiddleNameTextBox" CssClass="form-control"/>
                                                </div>
                                            </div>

                                        <div class="form-group">
                            <label for="LastNameTextBox" class="col-sm-5 control-label">Last Name: <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                            <asp:TextBox runat="server" ID="LastNameTextBox" CssClass="form-control"/>

                                                <asp:RequiredFieldValidator ID="LastNameRequiredFieldValidator" runat="server"
                                        ErrorMessage="Last Name is required." CssClass="errorlabel" ControlToValidate="LastNameTextBox"
                                        Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                                </div>
                                        </div>


                                    </div>
                                </div>

                                 <div class="col-sm-7">
                                    <div class="form-horizontal">

                                            <div class="form-group">
                                <label for="DateofBirthTextBox" class="col-sm-5 control-label">Date of Birth: <span class="text-danger">*</span></label>
                                            <div class="col-sm-7" style="margin-bottom: -45px;">

                                                <div class="col-xs-4 col-md-4" style="padding-left: 0">

                                            <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-control">
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
                                                ErrorMessage="Select a Month" ForeColor="Red" ValidationGroup="overview" CssClass="errorlabel"></asp:RequiredFieldValidator>
                                        </div>

                                        <div class="col-xs-3 col-md-3" style="padding-left: 0">
                                            <asp:DropDownList ID="ddlDay" runat="server" CssClass="form-control">
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
                                                ErrorMessage="Select a Day" ForeColor="Red" ValidationGroup="overview" CssClass="errorlabel"></asp:RequiredFieldValidator>
                                        </div>

                                        <div class="col-xs-4 col-md-4" style="padding-left: 0">
                                            <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-control">
                                            </asp:DropDownList>

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorYear" runat="server" ControlToValidate="ddlYear"
                                                ErrorMessage="Select a Year" ForeColor="Red" ValidationGroup="overview" CssClass="errorlabel"></asp:RequiredFieldValidator>
                                        </div>
                                                        
                                            </div>
                                                </div>



                                        <div class="form-group">
                                <label for="Gender" class="col-sm-5 control-label">Gender: <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                            <asp:DropDownList ID="GenderDropDownList" runat="server" CssClass="form-control" Width="120px">
                                            <asp:ListItem Value=""></asp:ListItem>
                                            <asp:ListItem Value="Male">Male</asp:ListItem>
                                            <asp:ListItem Value="Female">Female</asp:ListItem>
                                        </asp:DropDownList>

                                                <asp:RequiredFieldValidator ID="GenderRequiredFieldValidator" runat="server"
                                            ErrorMessage="Gender is required." CssClass="errorlabel" ControlToValidate="GenderDropDownList"
                                            Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                        <div class="form-group">
                                <label for="Citizen" class="col-sm-5 control-label">Are you a U.S. Citizen: <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <asp:DropDownList ID="CitizenDropDownList" runat="server" CssClass="form-control" Width="120px">
                                            <asp:ListItem Value=""></asp:ListItem>
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

                                
                            </div>
                    </div>
                </asp:Panel>

<!-- Contact Information -->
                <asp:Panel ID="ContactPanel" runat="server">
                    <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Contact Information</h3>
                                <hr />


                                    <div class="col-xs-12">
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                        <label for="AddressVerifiedCheckBox" class="col-sm-2 control-label">Address Verified:</label>
                                        <div class="col-sm-10">
                                            <asp:CheckBox ID="AddressVerifiedCheckBox" runat="server"  Enabled="false" />
                                            <asp:Button ID="BtnValidateAddress" runat="server" Text="Verify Address" CssClass="btn btn-sm btn-warning" Visible="false" />
                                            <div><asp:Label ID="ValidateHelpLabel" runat="server" CssClass="form-text text-muted" Text="We could not verify your address. Please correct the address below and click the Verify Address button." /></div>
                                                    
                                        </div>
                                    </div>

                                            <div class="form-group">
                                        <label class="col-sm-2 control-label">Address1: <span class="text-danger">*</span></label>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="Address1TextBox" runat="server" CssClass="form-control" />

                                        <asp:RequiredFieldValidator ID="Address1RequiredFieldValidator" runat="server"
                                            ErrorMessage="Address 1 is required." CssClass="errorlabel" ControlToValidate="Address1TextBox"
                                            Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                    </div>
                                            </div>

                                            <div class="form-group">
                                <label for="LastNameTextBox" class="col-sm-2 control-label">Address2: </label>
                                                <div class="col-sm-4">
                                <asp:TextBox ID="Address2TextBox" runat="server" CssClass="form-control" />

                                                    </div>
                                            </div>

                                            <div class="form-group">
                                <label for="NicknameTextBox" class="col-sm-2 control-label">City: <span class="text-danger">*</span></label>
                                                <div class="col-sm-4">
                                <asp:TextBox ID="CityTextBox" runat="server" CssClass="form-control" />

                                        <asp:RequiredFieldValidator ID="CityRequiredFieldValidator" runat="server"
                                            ErrorMessage="City is required." CssClass="errorlabel" ControlToValidate="CityTextBox"
                                            Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>


                                            <div class="form-group">
                                <label for="NicknameTextBox" class="col-sm-2 control-label">State: <span class="text-danger">*</span></label>
                                                <div class="col-sm-4">

                                        <asp:DropDownList ID="StateDropDownList" runat="server" CssClass="form-control">
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
                                            Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>

                                                    </div>
                                                </div>


                                            <div class="form-group">
                                <label for="NicknameTextBox" class="col-sm-2 control-label">Zip: <span class="text-danger">*</span></label>
                                                <div class="col-sm-3">
                                <asp:TextBox ID="ZipTextBox" runat="server" CssClass="form-control" Width="120px" />

                                        <asp:RequiredFieldValidator ID="ZipRequiredFieldValidator" runat="server"
                                            ErrorMessage="Zip is required." CssClass="errorlabel" ControlToValidate="ZipTextBox"
                                            Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>


                                                    <hr />

                                            <div class="form-group">

                                <label for="DateofBirthTextBox" class="col-sm-2 control-label">Phone: <span class="text-danger">*</span></label>
                                            <div class="col-sm-4">

                                    <telerik:RadMaskedTextBox RenderMode="Lightweight" ID="phoneNumberTextBoxambass" runat="server" Mask="(###)###-####" Width="222px">
                                    </telerik:RadMaskedTextBox>

                                    <asp:RequiredFieldValidator ID="PhoneNumberRequiredFieldValidator" runat="server"
                                        ErrorMessage="Phone Number is required." CssClass="errorlabel" ControlToValidate="phoneNumberTextBoxambass"
                                        Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                <label for="Gender" class="col-sm-2 control-label">EmailAddress: <span class="text-danger">*</span></label>
                                            <div class="col-sm-4">
                                <asp:TextBox ID="EmailAddressTextBox" runat="server" CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="EmailAddressRequiredFieldValidator" runat="server"
                                            ErrorMessage="Email Address is required." CssClass="errorlabel" ControlToValidate="EmailAddressTextBox"
                                            Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                            ControlToValidate="EmailAddressTextBox" CssClass="errorlabel" ErrorMessage="Invalid Email Format" ValidationGroup="overview" Display="Dynamic"></asp:RegularExpressionValidator>
                                                </div>

                                            </div>


                                        </div>
                                    </div>


                                    
                            </div>
                    </div>
                </asp:Panel>

<!-- Appearance -->
                <asp:Panel ID="AppearancePanel" runat="server">
                    <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Appearance</h3>
                                <hr />

                                <div class="col-md-12">
                                    <div id="AppearanceMessageHolder">
                                        <asp:Literal ID="AppearanceMessageLabel" runat="server" />
                                    </div>
                                </div>


                                 <div class="col-xs-4">

                                    <div class="form-horizontal">

                                                    <div class="form-group">
                                                <label class="col-sm-5 control-label">Height: </label>
                                                        <div class="col-sm-6">
                                                <asp:DropDownList ID="HeightDropDownList" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value=""></asp:ListItem>
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
                                        <label for="LastNameTextBox" class="col-sm-5 control-label">Weight: </label>
                                            <div class="col-sm-6">
                                                <asp:DropDownList ID="WeightDropDownList" runat="server" CssClass="form-control">
                                        <asp:ListItem Value=""></asp:ListItem>
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
                                        <label for="NicknameTextBox" class="col-sm-5 control-label">Hair Color: </label>
                                                        <div class="col-sm-6">
                                                            <asp:DropDownList ID="HairColorDropDownList" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value=""></asp:ListItem>
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

                                                </div>
                                     
                                 </div> <!-- end column -->

                                 <div class="col-xs-8">

                                    <div class="form-horizontal">
                                            <div class="form-group">
                                        <label for="NicknameTextBox" class="col-sm-2 control-label">Eye Color: </label>
                                                        <div class="col-sm-3">
                                                            <asp:DropDownList ID="EyeColorDropDownList" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value=""></asp:ListItem>
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
                                        <label for="NicknameTextBox" class="col-sm-2 control-label">Piercings: </label>
                                                        <div class="col-sm-3">
                                                 <asp:DropDownList ID="PiersingsDropDownList" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value=""></asp:ListItem>
                                                    <asp:ListItem Value="True">Yes</asp:ListItem>
                                                    <asp:ListItem Value="False">No</asp:ListItem>
                                                </asp:DropDownList>
                                                            </div>
                                                        </div>




                                  </div>

                                </div> <!-- end column -->
                                        
                                <div class="row">
                                    <div class="col-xs-12">
                                    </div>
                                </div>

                                <hr />

                            <div id="photospanel" class="row" runat="server" style="margin-top: 20px;">

                                <div class="col-xs-6">

                                <div class="form-group">
                                            <label for="HeadImage" class="col-sm-4 control-label">Head Shot Image:</label>
                                            <div class="col-sm-8">

                                                <asp:Repeater ID="headshot1" runat="server" DataSourceID="getHeadShot2">
                                                    <ItemTemplate>
                                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail"
                                                            DataValue='<%#IIf(TypeOf (Eval("headShot")) Is DBNull, Nothing, Eval("headShot"))%>'
                                                            Height="150px" Width="150px" ResizeMode="Fit" />


                                                    </ItemTemplate>
                                                </asp:Repeater>

                                                <asp:SqlDataSource runat="server" ID="getHeadShot2" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [headShot], [bodyShot] FROM [tblAmbassadorPhoto] WHERE ([userID] = @userID)">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="userID" SessionField="CurrentUserID" Type="String" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>

                                               <%--<span style="font-weight: bold;">Change Head Shot</span> --%>
                                <%--<telerik:RadAsyncUpload ID="HeadShotUploader" runat="server" MultipleFileSelection="Disabled" MaxFileInputsCount="1" Skin="Bootstrap"
                                                    HideFileInput="true" OnClientFileUploaded="OnClientFileUploaded">
                                                </telerik:RadAsyncUpload>--%>

                                                 <CuteWebUI:UploadAttachments ID="UploadAttachments1" OnFileUploaded="UploadAttachments1_HeadShot" runat="server" DropZoneID="DropPanel" InsertButtonStyle-CssClass="btn btn-default" InsertText="Select Image" CancelAllMsg=" " ProgressPanelWidth="200" MultipleFilesUpload="False">
                                                <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="4168" />                                               
                                            </CuteWebUI:UploadAttachments>

<%--<div id="headshotButton">
                                <asp:Button ID="btnUploadNewHeadShot" runat="server" Text="Submit" CssClass="btn btn-sm btn-success" />
                                   </div>--%>
                                            </div>
                                        </div>

                                </div>


                                <div class="col-xs-6">
                                    
                                <div class="form-group">
                                            <label for="BodyImage" class="col-sm-4 control-label">Body Shot Image:</label>
                                            <div class="col-sm-8">

                                                <asp:Repeater ID="bodyShot2" runat="server" DataSourceID="getHeadShot2">
                                                    <ItemTemplate>
                                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail" DataValue='<%#IIf(TypeOf (Eval("bodyShot")) Is DBNull, Nothing, Eval("bodyShot"))%>' Height="150px" Width="150px" ResizeMode="Fit" />
                                                    </ItemTemplate>
                                                </asp:Repeater>

                                                <%--<span style="font-weight: bold;">Change Body Shot</span> --%>
                                <%--<telerik:RadAsyncUpload ID="BodyShotUploader" runat="server" MultipleFileSelection="Disabled" MaxFileInputsCount="1" Skin="Bootstrap"
                                                    HideFileInput="true" OnClientFileUploaded="OnClientFileUploaded2">
                                                </telerik:RadAsyncUpload>

                                <div id="bodyshotButton">
                                <asp:Button ID="btnUploadNewBodyShot" runat="server" Text="Submit" CssClass="btn btn-sm btn-success" />
                                                </div>--%>

                                                <CuteWebUI:UploadAttachments ID="UploadAttachments2" OnFileUploaded="UploadAttachments2_BodyShot" runat="server" DropZoneID="DropPanel" InsertButtonStyle-CssClass="btn btn-default" InsertText="Select Image" CancelAllMsg=" " ProgressPanelWidth="200" MultipleFilesUpload="False">
                                                <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="4168" />
                                            </CuteWebUI:UploadAttachments>


                                            </div>
                                        </div>

                                </div>

                             </div>

                                

                            </div>
                    </div>
                </asp:Panel>

<!-- Availability -->
                <asp:Panel ID="AvailabilityPanel" runat="server">
                    <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Availability</h3>
                                <hr />


                                    <div class="col-xs-12">
                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                <label class="col-sm-4 control-label">Availability Date: </label>
                                            <div class="col-sm-5">

                                                <div class="col-xs-4 col-md-4" style="padding-left: 0">

                                                <asp:DropDownList ID="ddlMonthAD" runat="server" CssClass="form-control">
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

                                            </div>

                                            <div class="col-xs-3 col-md-3" style="padding-left: 0">
                                                <asp:DropDownList ID="ddlDayAD" runat="server" CssClass="form-control">
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

                                            </div>

                                            <div class="col-xs-4 col-md-4" style="padding-left: 0">
                                                <asp:DropDownList ID="ddlYearAD" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="Year" Value=""></asp:ListItem>
                                                </asp:DropDownList>

                                            </div>

                                            </div>
                                                    </div>

                                                    <div class="form-group">
                                        <label for="LastNameTextBox" class="col-sm-4 control-label">Can you work LGBT Accounts: </label>
                                                        <div class="col-sm-8">
                                            <asp:DropDownList ID="LGBTAccountsDropDownList" runat="server" CssClass="form-control" Width="120px">
                                                <asp:ListItem Value="True">Yes</asp:ListItem>
                                                <asp:ListItem Value="False">No</asp:ListItem>
                                            </asp:DropDownList>

                                                            </div>
                                                    </div>

                                                    <div class="form-group">
                                        <label for="NicknameTextBox" class="col-sm-4 control-label">Do you have reliable transportation: </label>
                                                        <div class="col-sm-8">
                                            <asp:DropDownList ID="ReliableTransportation" runat="server" CssClass="form-control" Width="120px">
                                                <asp:ListItem Value="True">Yes</asp:ListItem>
                                                <asp:ListItem Value="False">No</asp:ListItem>
                                            </asp:DropDownList>

                                                            </div>
                                                        </div>

                                                    <div class="form-group">
                                        <label for="NicknameTextBox" class="col-sm-4 control-label">How many miles from your current location would you be willing to travel for an event: </label>
                                                        <div class="col-sm-4">
                                            <%--<asp:DropDownList ID="WillingMilesDropDownList" runat="server" CssClass="form-control">
                                                <asp:ListItem Text="- Select Distance -" Value=""></asp:ListItem>
                                                <asp:ListItem Value="50">Less than 50 miles</asp:ListItem>
                                                <asp:ListItem Value="100">Less than 100 miles</asp:ListItem>
                                                <asp:ListItem Value="200">Less than 200 miles</asp:ListItem>
                                                <asp:ListItem Value="500">No more than 500</asp:ListItem>
                                            </asp:DropDownList>--%>

                                            <telerik:RadComboBox ID="WillingMilesRadComboBox" runat="server" EmptyMessage="Select Distance" Width="250px">
                                                <Items>
                                                    <telerik:RadComboBoxItem Value="50" Text="Less than 50 miles" />
                                                    <telerik:RadComboBoxItem Value="100" Text="Less than 100 miles" />
                                                    <telerik:RadComboBoxItem Value="200" Text="Less than 200 miles" />
                                                    <telerik:RadComboBoxItem Value="500" Text="No more than 500" />
                                                </Items>
                                            </telerik:RadComboBox>

                                                            </div>
                                                        </div>

                                                    <div class="form-group">
                                        <label for="NicknameTextBox" class="col-sm-4 control-label">Do you have a Smartphone: </label>
                                                        <div class="col-sm-8">
                                            <asp:DropDownList ID="SmartphoneDropDownList" runat="server" CssClass="form-control" Width="120px">
                                                <asp:ListItem Value="True">Yes</asp:ListItem>
                                                <asp:ListItem Value="False">No</asp:ListItem>
                                            </asp:DropDownList>

                                                            </div>
                                                        </div>

                                                    <div class="form-group">
                                        <label for="NicknameTextBox" class="col-sm-4 control-label">Smartphone OS: </label>
                                                        <div class="col-sm-3">

                                            <%--<asp:DropDownList ID="SmartphoneOSDropDownList" runat="server" CssClass="form-control">
                                                <asp:ListItem Text="Please Select" Value=""></asp:ListItem>
                                                <asp:ListItem Value="Apple">Apple iOS</asp:ListItem>
                                                <asp:ListItem Value="Android">Android (Google Inc.)</asp:ListItem>
                                                <asp:ListItem Value="BlackBerry">BlackBerry (Research In Motion)</asp:ListItem>
                                                <asp:ListItem Value="Bada">Bada (Samsung Electronics)</asp:ListItem>
                                                <asp:ListItem Value="MeeGo OS">MeeGo OS (Nokia and Intel)</asp:ListItem>
                                                <asp:ListItem Value="MPalm">Palm OS</asp:ListItem>
                                                <asp:ListItem Value="Symbian">Symbian OS (Nokia)</asp:ListItem>
                                                <asp:ListItem Value="Windows">Microsoft's Windows Phone</asp:ListItem>
                                            </asp:DropDownList>--%>

                                            <telerik:RadComboBox ID="SmartphoneOSRadComboBox" runat="server" EmptyMessage="Please Select" Width="250px">
                                                <Items>
                                                    <telerik:RadComboBoxItem Value="Apple" Text="Apple iOS" />
                                                    <telerik:RadComboBoxItem Value="Android" Text="Android (Google Inc.)" />
                                                    <telerik:RadComboBoxItem Value="BlackBerry" Text="BlackBerry (Research In Motion)" />
                                                    <telerik:RadComboBoxItem Value="Bada" Text="Bada (Samsung Electronics)" />
                                                    <telerik:RadComboBoxItem Value="MeeGo OS" Text="MeeGo OS (Nokia and Intel)" />
                                                    <telerik:RadComboBoxItem Value="MPalm" Text="Palm OS" />
                                                    <telerik:RadComboBoxItem Value="Symbian" Text="Symbian OS (Nokia)" />
                                                    <telerik:RadComboBoxItem Value="Windows" Text="Microsoft's Windows Phone" />
                                                </Items>
                                            </telerik:RadComboBox>

                                                            </div>
                                                        </div>

                                                </div>
                                            </div>


                            </div>
                    </div>
                </asp:Panel>

<!-- Licenses & Documents -->
                <asp:Panel ID="LicensesPanel" runat="server">
                    <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Licenses & Documents</h3>
                                <hr />


                                <div class="col-sm-6">
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

                                            <td><a href='DocumentsHandler.aspx?fileID=<%# Eval("ambassadorFileID") %>'><%# Eval("documentName") %></a></td>
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

                                <br />

                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getResumeList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblAmbassadorDocuments" Where="userID == @userID && category == @category" EnableDelete="True">
                                    <WhereParameters>
                                        <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                        <asp:Parameter DefaultValue="Resume" Name="category" Type="String"></asp:Parameter>
                                    </WhereParameters>
                                </asp:LinqDataSource>



                                <asp:Button ID="btnOpenUpload1" runat="server" Text="Upload Resume" CssClass="btn btn-sm btn-primary" />
                                    </div>

                                <div class="col-sm-6">
                                <b>Sampling license</b><br />

                                <asp:Repeater ID="LicenseList" runat="server" DataSourceID="getLienseList">
                                    <HeaderTemplate>
                                        <table class="table table-striped">
                                            <tbody>
                                            <tr>
                                                <th>File Name</th>
                                                <th>License Name</th>
                                                <th>Date Uploaded</th>
                                                <th>Expiration Date</th>
                                                <th></th>
                                            </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td><a href='DocumentsHandler.aspx?fileID=<%# Eval("ambassadorFileID") %>'><%# Eval("documentTitle") %></a></td>
                                            <td><%# Eval("documentName") %></td>
                                            <td><%# Eval("dateUploaded", "{0:d}") %></td>
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

                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getLienseList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblAmbassadorDocuments" Where="userID == @userID && category == @category" EnableDelete="True">
                                    <WhereParameters>
                                        <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                        <asp:Parameter DefaultValue="License" Name="category" Type="String"></asp:Parameter>
                                    </WhereParameters>
                                </asp:LinqDataSource>

                                    <asp:Button ID="btnOpenUpload2" runat="server" Text="Upload License" CssClass="btn btn-sm btn-primary" />
                                    </div>

                            </div>
                    </div>
                </asp:Panel>

<!-- Assignments -->
                <asp:Panel ID="AssignmentsPanel" runat="server">
                    <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Assignments</h3>
                                <hr />

                                <div style="padding-left: 15px;">
                                <b>Brand Types</b>
                                 <asp:Repeater ID="BrandCategoryList" runat="server" DataSourceID="getAmabassadorBrands">
                                                        <HeaderTemplate>
                                                            <ul class="special">
                                                        </HeaderTemplate>

                                                        <ItemTemplate>
                                                            <li>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("categoryName") %>'></asp:Label></li>


                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </ul>
                                                        </FooterTemplate>
                                                    </asp:Repeater>

                                               <asp:LinqDataSource runat="server" EntityTypeName="" ID="getAmabassadorBrands" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="ambassadorBrandsID" TableName="qryAmbassodorBrandTypeByUsers" Where="userName == @userName">
                                                        <WhereParameters>
                                                            <asp:SessionParameter SessionField="CurrentUserID" Name="userName" />
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>
</div>

                                <div style="padding-left: 15px;">
                                <b>Positions</b>
                                <asp:Repeater ID="AmabassadorPositionList" runat="server" DataSourceID="getAmabassadorPositions">
                                                        <HeaderTemplate>
                                                            <ul class="special">
                                                        </HeaderTemplate>

                                                        <ItemTemplate>
                                                            <li>
                                                                <asp:Label ID="AmabassadorPositionLabel" runat="server" Text='<%# Eval("positionTitle") %>'></asp:Label></li>


                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </ul>
                                                        </FooterTemplate>
                                                    </asp:Repeater>

                                                    <asp:SqlDataSource ID="getAmabassadorPositions" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAmbassadorPosition" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="UserID" SessionField="CurrentUserID" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                </div>

                                <div style="padding-left: 15px;">

                                <b>Markets</b>
                                 <asp:Repeater ID="AmabassadorMarketList" runat="server" DataSourceID="getAmabassadorMarkets">
                                                        <HeaderTemplate>
                                                            <ul class="special">
                                                        </HeaderTemplate>

                                                        <ItemTemplate>
                                                            <li>
                                                                <asp:Label ID="marketNameLabel" runat="server" Text='<%# Eval("marketName") %>'></asp:Label></li>


                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </ul>
                                                        </FooterTemplate>
                                                    </asp:Repeater>

                                                    <asp:SqlDataSource ID="getAmabassadorMarkets" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAmbassadorMarkets" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="UserID" SessionField="CurrentUserID" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                    </div>

                            </div>
                    </div>
                </asp:Panel>

                    </asp:Panel>

            </div>
            <%--</div>--%>
        </div>
        <%--end profile view--%>



        <asp:Panel ID="UploadResumePanel" runat="server" Visible="false">

             <div class="widget stacked">
                <div class="widget-content sm-height">

                            <h3>Upload Resume</h3>

                            <p>Use the form below to upload your resume.</p>

                        <div class="col-sm-4">
                            <div class="panel panel-default">
                                <div class="panel-body">

                                    <p>You can upload a DOC, DOCX, PDF, RTF, TXT, ODT, or WPS file. <br />File size limit is 2 MB.</p>

                                    <telerik:RadAsyncUpload ID="resumeUpload" MultipleFileSelection="Automatic" runat="server" Skin="Bootstrap"
                                        HideFileInput="true" Width="300px" AllowedFileExtensions="doc,docx,pdf,rtf,txt,odt,wps" MaxFileSize="2097152" OnClientValidationFailed="validationFailed" UploadedFilesRendering="BelowFileInput">
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


                    </div>
                 </div>


        </asp:Panel>

        <asp:Panel ID="UploadLicensePanel" runat="server" Visible="false">

            <div class="widget stacked">
                <div class="widget-content sm-height">

                    <h3>Upload License</h3>

                    <p>Use the form below to upload your license.</p>

                    <div class="col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-body">

                            <p>You can upload a DOC, DOCX, PDF, RTF, TXT, JPG, GIF or PNG file. <br />File size limit is 2 MB.</p>

                                <telerik:RadAsyncUpload ID="LicenseUpload2" MultipleFileSelection="Automatic" runat="server" Skin="Bootstrap"
                                    HideFileInput="true" Width="300px" AllowedFileExtensions="doc,docx,pdf,rtf,txt,jpg,gif,png,jpeg,PNG" MaxFileSize="2097152" 
                                    OnClientValidationFailed="validationFailed" UploadedFilesRendering="BelowFileInput" MaxFileInputsCount="1">
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
            </div>
        </div>

    </asp:Panel>




</asp:Panel>

    <asp:Panel runat="server" ID="StaffPanel" Visible="false">

        <div class="row">
            <div class="col-md-12">

                <h2>My Profile</h2>

                   <p>Please keep your personal information up-to-date!</p>

            <div class="widget stacked">
                <div class="widget-content min-height" style="padding: 35px;">

                            <div class="form-horizontal">

                                <div class="col-md-12">

                                    <div class="col-md-4">

                                        <div class="form-group">
                                            <label class="col-sm-6 control-label">User Name:</label>
                                            <div class="col-sm-6" style="top: 6px;">

                                                <asp:Label ID="UserName" runat="server" />

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-6 control-label">Portal Password:</label>
                                            <div class="col-sm-6" style="top: 6px;">

                                                <asp:Label ID="PortalPassword" runat="server" />

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="LastLoginTextBox" class="col-sm-6 control-label">Last login Date:</label>
                                            <div class="col-sm-6" style="top: 6px;">

                                                <asp:Label ID="LastLoginDate" runat="server" />

                                            </div>
                                        </div>


                                    </div>


                                    <div class="col-md-7">

                                        <div class="form-group">
                                            <label class="col-sm-4 control-label">First Name: <span class="text-danger">*</span></label>
                                            <div class="col-sm-8" style="top: 6px;">

                                                <asp:TextBox ID="FirstName" runat="server" CssClass="form-control" />

                                                <asp:RequiredFieldValidator ID="userNameRequiredFieldValidator" runat="server"
                                                        ErrorMessage="First Name is required" CssClass="errorlabel" ControlToValidate="FirstName"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="LastNameTextBox" class="col-sm-4 control-label">Last Name: <span class="text-danger">*</span></label>
                                            <div class="col-sm-8" style="top: 6px;">

                                                <asp:TextBox ID="LastName" runat="server" CssClass="form-control" />

                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                        ErrorMessage="Last Name is required" CssClass="errorlabel" ControlToValidate="LastName"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                       <div class="form-group">
                                            <label for="phoneNumberTextBox" class="col-sm-4 control-label">Phone Number: </label>

                                            <div class="col-md-5" style="padding-top: 5px;">
                                                <telerik:RadMaskedTextBox RenderMode="Lightweight" ID="phoneNumberTextBox" runat="server" Mask="(###) ###-####">
                                        </telerik:RadMaskedTextBox>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="EmailTextBox" class="col-sm-4 control-label">Email: <span class="text-danger">*</span></label>
                                            <div class="col-sm-8" style="top: 6px;">

                                                <asp:TextBox ID="EmailTextBox" runat="server" CssClass="form-control" />

                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                        ErrorMessage="Email is required" CssClass="errorlabel" ControlToValidate="EmailTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="timeZoneDDL" class="col-sm-4 control-label">Time Zone: <span class="text-danger">*</span></label>

                                            <div class="col-md-8">
                                                <asp:DropDownList ID="ddlTimeZone" runat="server"
                                                    AppendDataBoundItems="True" CssClass="form-control" DataSourceID="getTimeZones"
                                                    DataTextField="DisplayName" DataValueField="Id">
                                                    <asp:ListItem Text="Select a TimeZone" Value="" />
                                                </asp:DropDownList>
                                                <asp:LinqDataSource ID="getTimeZones" runat="server"
                                                    ContextTypeName="EventManagerApplication.LMSDataClassesDataContext"
                                                    EntityTypeName="" OrderBy="TimeZoneID" TableName="TimeZones"></asp:LinqDataSource>

                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                        ErrorMessage="Time Zone is required" CssClass="errorlabel" ControlToValidate="ddlTimeZone"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <div class="form-group pull-right" style="padding-right:10px;">
                                        <div class="col-sm-12">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" CausesValidation="true" ValidationGroup="information" />
                                        </div>
                                    </div>

                                    </div>

                                </div>


                            </div>



                        </div>
            </div>

            </div>
        </div>

    </asp:Panel>

</div>




    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

        <link href="/skins/square/green-red.css" rel="stylesheet" />
    <script src="/js/icheck.js"></script>

    <script>
        $(document).ready(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '30%' // optional

            });
        });

        function formatCheckBox() {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '30%' // optional

            });
        }
    </script>
        <script>
             // close the div in 5 secs
            window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version
            $("#messageHolder").fadeOut("slow", null);
        }

        function OnClientFileUploaded(sender, args) {
            var contentType = args.get_fileInfo().ContentType;

            $("#headshotButton").show();


            //alert(contentType);
        }

        function OnClientFileUploaded2(sender, args) {
            var contentType = args.get_fileInfo().ContentType;

            $("#bodyshotButton").show();


            //alert(contentType);
        }

        function CallClientShow() {

                var notification = $find("<%=RadNotification1.ClientID %>");

                notification.show();

            }


            </script>
     </telerik:RadScriptBlock>



</asp:Content>
