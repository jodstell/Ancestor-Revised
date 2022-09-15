<%@ Page Title="Edit Ambassador" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditAmbassador.aspx.vb" MaintainScrollPositionOnPostback="true" Inherits="EventManagerApplication.EditAmbassador" %>

<%@ Register Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" TagPrefix="CuteWebUI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style>
        .uploadergrid {
           display: none !important;
       }

    .AjaxUploaderCancelAllButton {
           display: none !important;
       }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../Theme/css/custom1.css" rel="stylesheet" />
    <link href="../Theme/css/custom.css" rel="stylesheet" />

    <!-- custom list box css  -->
    <link href="css/ListBox.css" rel="stylesheet" />

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="AssignmentPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="AssignmentPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="UploadAttachmentsHead">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="HeadShotPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="UploadAttachmentsBody">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="BodyShotPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" />


    <div class="container">

        <div class="row ">

            <div class="col-sm-12">

                <h3 style="color: black; font-weight: bold;">Ambassador Information</h3>

                <asp:Label ID="msgLabel" runat="server" />
                
                <%--<asp:ValidationSummary ID="MyValidationSummary" runat="server"
                       ShowMessageBox="true"
                       ShowSummary="false"  />--%>
                

                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" Text="Save Changes" CssClass="btn btn-primary" ValidationGroup="overview" />
                <asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" Text="Cancel" CssClass="btn btn-default" />
               
                                <asp:LinkButton ID="btnReactivate" runat="server" CssClass="btn btn-success pull-right">Reactivate</asp:LinkButton>
                                <asp:LinkButton ID="btnTerminate" runat="server" CausesValidation="False" CssClass="btn btn-danger pull-right"  
                                    OnClientClick="javascript:if(!confirm('This action will terminated this ambassador. Are you sure?')){return false;}" >
                                <i class="fa fa-ban" aria-hidden="true"></i> Terminate</asp:LinkButton>
                            

                <p>Use the tabs below to edit the ambassabors detail and settings.  Click "Save Changes" to update the system.</p>

                <hr />



                <telerik:RadTabStrip ID="RadTabStrip1" runat="server"
                    MultiPageID="RadMultiPage1" SelectedIndex="0">
                    <Tabs>
                        <telerik:RadTab Text="Overview"></telerik:RadTab>
                        <telerik:RadTab Text="Contact Information"></telerik:RadTab>
                        <telerik:RadTab Text="Appearance"></telerik:RadTab>
                        <telerik:RadTab Text="Availability"></telerik:RadTab>
                        <telerik:RadTab Text="Licenses & Documents"></telerik:RadTab>
                        <telerik:RadTab Text="Assignments"></telerik:RadTab>
                        <telerik:RadTab Text="Notes"></telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>

                <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0">
                    <!-- Overview tab -->
                    <telerik:RadPageView runat="server" ID="RadPageView1">
                        <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Overview</h3>
                                <hr />
                                <div class="col-md-5">

                                    <div class="form-horizontal">

                                         <div class="form-group">
                                            <label for="PayrollIDTextBox" class="col-sm-3 control-label">Portal Login: <span class="text-danger">*</span></label>
                                            <div class="col-sm-5">
                                                <asp:TextBox ID="PayrollIDTextBox" runat="server" CssClass="form-control" onchange="validateUser()" /> <asp:Label ID="lblStatus" runat="server" />
                                               <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                ErrorMessage="Portal Login is required." CssClass="errorlabel" ControlToValidate="PayrollIDTextBox"
                                                Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="FirstNameTextBox" class="col-sm-3 control-label">First Name: <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="form-control" />
                                                <asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" runat="server"
                                                    ErrorMessage="First Name is required." CssClass="errorlabel" ControlToValidate="FirstNameTextBox"
                                                    Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <%--<div class="form-group">
                                            <label for="MiddleNameTextBox" class="col-sm-3 control-label">Middle Name: </label>
                                            <div class="col-sm-9">
                                                <asp:TextBox ID="MiddleNameTextBox" runat="server" CssClass="form-control" />
                                               
                                            </div>
                                        </div>--%>


                                        <div class="form-group">
                                            <label for="NicknameTextBox" class="col-sm-3 control-label">Middle Name: </label>
                                            <div class="col-sm-9">
                                                <asp:TextBox ID="NicknameTextBox" runat="server" CssClass="form-control" />
                                               
                                            </div>
                                        </div>


                                        <div class="form-group">
                                            <label for="LastNameTextBox" class="col-sm-3 control-label">Last Name: <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
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
                                            <label for="Gender" class="col-sm-4 control-label">Gender: <span class="text-danger">*</span></label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="GenderDropDownList" runat="server" CssClass="form-control" Width="100px">
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
                                            <label for="Citizen" class="col-sm-4 control-label">Are you a U.S. Citizen: <span class="text-danger">*</span></label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="CitizenDropDownList" runat="server" CssClass="form-control" Width="100px">
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
                            <!-- End Content -->
                        </div>
                    </telerik:RadPageView>

                    <!-- Contact Information tab -->
                    <telerik:RadPageView runat="server" ID="RadPageView2">
                        <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Contact Information</h3>
                                <hr />
                                <div class="col-md-6">
                                    <div class="form-horizontal">
                                        <!-- Address -->
                                        <div class="form-group">
                                            <label for="Address1TextBox" class="col-sm-3 control-label">Address 1: <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <asp:TextBox ID="Address1TextBox" runat="server" CssClass="form-control" />
                                                <asp:RequiredFieldValidator ID="Address1RequiredFieldValidator" runat="server"
                                                    ErrorMessage="Address 1 is required." CssClass="errorlabel" ControlToValidate="Address1TextBox"
                                                    Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <!-- Address -->
                                        <div class="form-group">
                                            <label for="Address2TextBox" class="col-sm-3 control-label">Address 2:</label>
                                            <div class="col-sm-9">
                                                <asp:TextBox ID="Address2TextBox" runat="server" CssClass="form-control" />

                                            </div>
                                        </div>

                                        <!-- City -->
                                        <div class="form-group">
                                            <label for="CityTextBox" class="col-sm-3 control-label">City: <span class="text-danger">*</span></label>
                                            <div class="col-sm-4">
                                                <asp:TextBox ID="CityTextBox" runat="server" CssClass="form-control" />
                                                <asp:RequiredFieldValidator ID="CityRequiredFieldValidator" runat="server"
                                                    ErrorMessage="City is required." CssClass="errorlabel" ControlToValidate="CityTextBox"
                                                    Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <!-- State -->
                                        <div class="form-group">
                                            <label for="State" class="col-sm-3 control-label">State: <span class="text-danger">*</span></label>
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

                                        <!-- Zip -->
                                        <div class="form-group">
                                            <label for="ZipTextBox" class="col-sm-3 control-label">Zip: <span class="text-danger">*</span></label>
                                            <div class="col-sm-2">
                                                <asp:TextBox ID="ZipTextBox" runat="server" CssClass="form-control" Width="120px" />
                                                <asp:RequiredFieldValidator ID="ZipRequiredFieldValidator" runat="server"
                                                    ErrorMessage="Zip is required." CssClass="errorlabel" ControlToValidate="ZipTextBox"
                                                    Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-horizontal">
                                        <!-- Phone -->
                                        <div class="form-group">
                                            <label for="PhoneNumberTextBox" class="col-sm-3 control-label">Phone Number: <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                            <telerik:RadMaskedTextBox RenderMode="Lightweight" ID="PhoneNumberTextBox" runat="server" Mask="(###)###-####" Width="222px">
                                            </telerik:RadMaskedTextBox>

                                            <asp:RequiredFieldValidator ID="PhoneNumberRequiredFieldValidator" runat="server"
                                                ErrorMessage="Phone Number is required." CssClass="errorlabel" ControlToValidate="PhoneNumberTextBox"
                                                Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <!-- email -->
                                        <div class="form-group">
                                            <label for="EmailAddressTextBox" class="col-sm-3 control-label">Email Address: <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <asp:TextBox ID="EmailAddressTextBox" runat="server" CssClass="form-control" />
                                                <asp:RequiredFieldValidator ID="EmailAddressRequiredFieldValidator" runat="server"
                                                    ErrorMessage="Email Address is required." CssClass="errorlabel" ControlToValidate="EmailAddressTextBox"
                                                    Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                                    ControlToValidate="EmailAddressTextBox" CssClass="errorlabel" ErrorMessage="Invalid Email Format" ValidationGroup="overview" Display="Dynamic"></asp:RegularExpressionValidator>

                                            </div>
                                        </div>

                                        <!-- latitude -->
                                        <div class="form-group">
                                            <label for="latitudeTextBox" class="col-sm-3 control-label">Latitude: <span class="text-danger">*</span></label>
                                            <div class="col-sm-6">
                                                <asp:TextBox ID="latitudeTextBox" runat="server" CssClass="form-control" />
                                            </div>
                                        </div>

                                        <!-- longtitude -->
                                        <div class="form-group">
                                            <label for="longtitudeTextBox" class="col-sm-3 control-label">Longtitude: <span class="text-danger">*</span></label>
                                            <div class="col-sm-6">
                                                <asp:TextBox ID="longtitudeTextBox" runat="server" CssClass="form-control" />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label"></label>
                                            <div class="col-sm-6">
                                                <asp:Button ID="btnUpdateGeoCoords" runat="server" Text="Update Coordinates" CssClass="btn btn-warning btn-sm" />
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </telerik:RadPageView>

                    <!--Appearance Tab -->
                    <telerik:RadPageView runat="server" ID="RadPageView3">
                        <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Appearance</h3>
                                <hr />
                                <div class="col-md-4">

                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label for="Height" class="col-sm-4 control-label">Height: </label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="HeightDropDownList" runat="server" CssClass="form-control" Width="120px">
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
                                            <label for="Weight" class="col-sm-4 control-label">Weight: </label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="WeightDropDownList" runat="server" CssClass="form-control" Width="120px">
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
                                            <label for="HairColor" class="col-sm-4 control-label">Hair Color:</label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="HairColorDropDownList" runat="server" CssClass="form-control" Width="120px">
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

                                        <div class="form-group">
                                            <label for="EyeColor" class="col-sm-4 control-label">Eye Color:</label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="EyeColorDropDownList" runat="server" CssClass="form-control" Width="120px">
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
                                            <label for="Piersings" class="col-sm-4 control-label">Piercings:</label>
                                            <div class="col-sm-8">

                                                <asp:DropDownList ID="PiersingsDropDownList" runat="server" CssClass="form-control" Width="120px">
                                                    <asp:ListItem Value=""></asp:ListItem>
                                                    <asp:ListItem Value="True">Yes</asp:ListItem>
                                                    <asp:ListItem Value="False">No</asp:ListItem>
                                                </asp:DropDownList>


                                            </div>
                                        </div>

                                    </div>

                                </div>

                                <div class="col-md-4">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label for="HeadImage" class="col-sm-4 control-label">Head Shot Image:</label>
                                            <div class="col-sm-8">
                                                
                                    <asp:Panel ID="HeadShotPanel" runat="server">

                                                <asp:Repeater ID="headshot" runat="server" DataSourceID="getHeadShot1">
                                                    <ItemTemplate>
                                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail"
                                                            DataValue='<%#IIf(TypeOf (Eval("headShot")) Is DBNull, Nothing, Eval("headShot"))%>'
                                                            Height="150px" Width="150px" ResizeMode="Fit" />
                                                    </ItemTemplate>
                                                </asp:Repeater>


                                    <asp:Panel ID="HeadPanel" runat="server" Visible="false">
                                        <asp:Image ID="ImageHead" runat="server" Width="45%" Height="45%" ImageAlign="Middle" />
                                    </asp:Panel>
                   
                                    <asp:Label ID="lblInfoHead" runat="server" Visible="false">
                                    <span class="help-block"><strong style="font-size: 14px;">Click the Save Changes button to save the image.</strong></span>
                                    </asp:Label>

                                        </asp:Panel>

                                                <asp:SqlDataSource runat="server" ID="getHeadShot1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [headShot], [bodyShot] FROM [tblAmbassadorPhoto] WHERE ([userID] = @userID)">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>


                                                <%--<telerik:RadAsyncUpload ID="RadAsyncUpload12" runat="server" MultipleFileSelection="Disabled" MaxFileInputsCount="1" Skin="Bootstrap" HideFileInput="true">
                                                </telerik:RadAsyncUpload>--%>


                                        <asp:Label ID="lblPathHead" runat="server" Visible="false"></asp:Label>

                            <CuteWebUI:UploadAttachments ID="UploadAttachmentsHead" OnFileUploaded="UploadAttachments1_Head" runat="server" InsertButtonStyle-CssClass="btn btn-default" InsertText="Select Image" CancelAllMsg=" " MultipleFilesUpload="False" ShowProgressBar="false" ShowProgressInfo="false" CancelButtonStyle-CssClass="uploadergrid" UploadingMsg=" ">
                                <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="6168" />
                            </CuteWebUI:UploadAttachments>

                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-horizontal">


                                        <div class="form-group">
                                            <label for="BodyImage" class="col-sm-4 control-label">Body Shot Image:</label>
                                            <div class="col-sm-8">

                                                <asp:Panel ID="BodyShotPanel" runat="server">

                                                <asp:Repeater ID="bodyShot" runat="server" DataSourceID="getHeadShot1">
                                                    <ItemTemplate>
                                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail" DataValue='<%#IIf(TypeOf (Eval("bodyShot")) Is DBNull, Nothing, Eval("bodyShot"))%>' Height="150px" Width="150px" ResizeMode="Fit" />
                                                    </ItemTemplate>
                                                </asp:Repeater>


                                    <asp:Panel ID="BodyPanel" runat="server" Visible="false">
                                        <asp:Image ID="ImageBody" runat="server" Width="45%" Height="45%" ImageAlign="Middle" />
                                    </asp:Panel>
                   
                                    <asp:Label ID="lblInfoBody" runat="server" Visible="false">
                                    <span class="help-block"><strong style="font-size: 14px;">Click the Save Changes button to save image.</strong></span>
                                    </asp:Label>

                                                </asp:Panel>
                                                <%--<telerik:RadAsyncUpload ID="bodyShotUpload2" MultipleFileSelection="Disabled" MaxFileInputsCount="1" runat="server" Skin="Bootstrap" HideFileInput="true">
                                                </telerik:RadAsyncUpload>--%>


                                <asp:Label ID="lblPathBody" runat="server" Visible="false"></asp:Label>

                    <CuteWebUI:UploadAttachments ID="UploadAttachmentsBody" OnFileUploaded="UploadAttachments1_Body" runat="server" InsertButtonStyle-CssClass="btn btn-default" InsertText="Select Image" CancelAllMsg=" " MultipleFilesUpload="False" ShowProgressBar="false" ShowProgressInfo="false" CancelButtonStyle-CssClass="uploadergrid" UploadingMsg=" ">
                        <ValidateOption AllowedFileExtensions="jpeg,jpg,gif,png" MaxSizeKB="6168" />
                    </CuteWebUI:UploadAttachments>

                                            </div>
                                        </div>

                                    </div>

                                </div>

                            </div>
                            <!-- End Content -->
                        </div>




                    </telerik:RadPageView>

                    <!--Availablity Tab -->
                    <telerik:RadPageView runat="server" ID="RadPageView4">
                        <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Availability</h3>
                                <hr />
                                <div class="form-horizontal">

                                    <div class="form-group">
                                        <label for="AvailabilityDate" class="col-sm-5 control-label">Availability Date: </label>
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
                                        <label for="LGBTAccounts" class="col-sm-5 control-label">Can you work LGBT Accounts:</label>
                                        <div class="col-sm-7">

                                            <asp:DropDownList ID="LGBTAccountsDropDownList" runat="server" CssClass="form-control" Width="120px">
                                                <asp:ListItem Value=""></asp:ListItem>
                                                <asp:ListItem Value="True">Yes</asp:ListItem>
                                                <asp:ListItem Value="False">No</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                    </div>



                                    <div class="form-group">
                                        <label for="ReliableTransportation" class="col-sm-5 control-label">Do you have reliable transportation:</label>
                                        <div class="col-sm-7">

                                            <asp:DropDownList ID="ReliableTransportation" runat="server" CssClass="form-control" Width="120px">
                                                <asp:ListItem Value=""></asp:ListItem>
                                                <asp:ListItem Value="True">Yes</asp:ListItem>
                                                <asp:ListItem Value="False">No</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                    </div>



                                    <div class="form-group">
                                        <label for="WillingMiles" class="col-sm-5 control-label">
                                            How many miles from your current location would you 
                                            be willing to travel for an event:</label>
                                        <div class="col-sm-3">

                                            <asp:DropDownList ID="WillingMilesDropDownList" runat="server" CssClass="form-control">
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
                                                <asp:ListItem Value=""></asp:ListItem>
                                                <asp:ListItem Value="True">Yes</asp:ListItem>
                                                <asp:ListItem Value="False">No</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="SmartphoneOS" class="col-sm-5 control-label">Smartphone OS:</label>
                                        <div class="col-sm-7">

                                            <asp:DropDownList ID="SmartphoneOSDropDownList" runat="server" CssClass="form-control">
                                                <asp:ListItem Text="Please Select" Value=""></asp:ListItem>
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
                            <!-- End Content -->
                        </div>
                    </telerik:RadPageView>

                    <!-- Licenses Tab -->
                    <telerik:RadPageView runat="server" ID="RadPageView5">
                        <div class="widget stacked">
                            <div class="widget-content sm-height">

                                <asp:Panel runat="server" ID="PanelDocuments">

                                <h3>License & Documents</h3>
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

                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getResumeList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblAmbassadorDocuments" Where="userID == @userID && category == @category" EnableDelete="True">
                                    <WhereParameters>
                                        <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
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
                                                <th>Exiration Date</th>
                                                <th></th>
                                            </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td><a href='DocumentsHandler.aspx?fileID=<%# Eval("ambassadorFileID") %>'><%# Eval("documentTitle") %></td>
                                            <td><%# Eval("documentName") %></td>
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
                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                        </WhereParameters>
                                </asp:LinqDataSource>

                                    <asp:Button ID="btnOpenUpload2" runat="server" Text="Upload License" CssClass="btn btn-sm btn-primary" />
                                    </div>

                             </asp:Panel>



        <asp:Panel ID="UploadResumePanel" runat="server" Visible="false">

                            <h3>Upload Resume</h3>

                            <p>Use the form below to upload your resume.</p>

                        <div class="col-sm-4">
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

                    <div class="col-sm-4">
                        <div class="panel panel-default">
                                <div class="panel-body">

                            <p>You can upload a DOC, DOCX, PDF, RTF, TXT, JPG,, GIF or PNG file. <br />File size limit is 2 MB.</p>

                                <telerik:RadAsyncUpload ID="LicenseUpload2" MultipleFileSelection="Automatic" runat="server" Skin="Bootstrap"
                                    HideFileInput="true" Width="300px">
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
                                Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                        <label for="ExpirationTextBox" class="col-sm-5 control-label">Expiration Date: <span class="text-danger">*</span></label>
                                        <div class="col-sm-7">
                                            <asp:TextBox ID="ExpirationTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="ExpirationTextBoxRequiredFieldValidator" runat="server"
                                ErrorMessage="Expiration Date is required." CssClass="errorlabel" ControlToValidate="ExpirationTextBox"
                                Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
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

          
                            </div>
                            <!-- End Content -->
                        </div>
                    </telerik:RadPageView>

                    <!-- Assignments Tab -->
                    <telerik:RadPageView runat="server" ID="RadPageView6">

                        <div class="widget stacked">
                            <div class="widget-content">
                                <h3>Assignments</h3>
                                <hr />
                                <div class="form-horizontal">

                                    <div class="form-group">
                                        <%--<label for="TypeofBrandstoWork" class="col-sm-3 control-label">Brands:</label>
                                        <div class="col-sm-9">

                                            <asp:CheckBox ID="ckbBeer" runat="server" Text="Beer" />
                                            <asp:CheckBox ID="ckbSpirits" runat="server" Text="Spirits" />
                                            <asp:CheckBox ID="ckbWine" runat="server" Text="Wine" />
                                            <asp:CheckBox ID="ckbReadyToDrink" runat="server" Text="Ready to Drink" />
                                            <asp:CheckBox ID="ckbOther" runat="server" Text="Other" />

                                        </div>--%>


                                        <label class="col-sm-3 control-label">Team:</label>
                                        <div class="col-sm-9" style="top: 6px;">

                                            <telerik:RadComboBox ID="TeamComboBox" runat="server" DataSourceID="GetTeamList" DataTextField="teamName" 
                                                DataValueField="teamID" Width="400px" AppendDataBoundItems="true">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="None" Value="0" Selected="true" />
                                                </Items>
                                            </telerik:RadComboBox>


                                            <p>Teams should be assigned to users who are in the Agency role.</p>

                                            <p>Warning! Assigning a user to a team will limit their view of events to only events within the team.</p>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetTeamList" 
                                                ContextTypeName="EventManagerApplication.DataClassesDataContext" 
                                                OrderBy="teamName" TableName="tblTeams" Where="active == @active">
                                                <WhereParameters>
                                                    <asp:Parameter DefaultValue="True" Name="active" Type="Boolean"></asp:Parameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>

                                        </div>

                                    </div>

                                  <%--  <div class="form-group">

                                        <label for="TypeofPromotions" class="col-sm-3 control-label">Promotions:</label>
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

                                    </div>--%>

                                    <asp:HiddenField ID="HF_SelectedItemID" runat="server" />

                                    <asp:Panel ID="AssignmentPanel" runat="server">
                                    <%--<div class="form-group">
                                        <label for="inputEmail3" class="col-sm-3 control-label">Clients Assigned:</label>
                                        <div class="col-sm-9">

                                            <div class="list-containers">

                                                <div class="list-container size-thin">
                                                    <div class="title">
                                                        Available Clients
                                                    </div>
                                                    <telerik:RadListBox ID="ClientList" runat="server"
                                                        TransferToID="SelectedClientsList"
                                                        AllowTransferOnDoubleClick="True"
                                                        EnableDragAndDrop="True"
                                                        ButtonSettings-AreaWidth="35px" Height="200px" Width="225px"
                                                        DataKeyField="clientID"
                                                        DataSortField="clientName"
                                                        DataSourceID="getClientList"
                                                        DataTextField="clientName"
                                                        DataValueField="clientID"
                                                        AllowTransfer="True"
                                                        AutoPostBackOnTransfer="true"
                                                        Skin="Bootstrap">
                                                        <ButtonSettings ShowTransferAll="false" />

                                                    </telerik:RadListBox>
                                                </div>

                                                

                                                <div class="list-container size-thin">

                                                    <div class="title">
                                                        Selected Clients
                                                    </div>
                                                    <telerik:RadListBox runat="server" ID="SelectedClientsList"
                                                        OnInserted="SelectedClientsList_Inserted" OnDeleted="SelectedClientsList_Deleted"
                                                        DataSourceID="getAmbassadorClients"
                                                        AllowDelete="True"
                                                        DataKeyField="clientID"
                                                        DataTextField="clientName"
                                                        DataValueField="clientID"
                                                        DataSortField="clientName"
                                                        AutoPostBackOnDelete="true"
                                                        Height="200px" Width="225px" Skin="Bootstrap">
                                                    </telerik:RadListBox>

                                                    <asp:SqlDataSource ID="getClientList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAvailableClientsForAmbassador" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                    <asp:SqlDataSource ID="getAmbassadorClients" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAmbassadorClients" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                </div>

                                            </div>


                                        </div>
                                    </div>--%>

                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-3 control-label">Positions Assigned</label>
                                        <div class="col-sm-9">

                                            <div class="list-containers">

                                                <div class="list-container size-thin">
                                                    <div class="title">
                                                        Available Positions
                                                    </div>
                                                    <telerik:RadListBox ID="PositionList" runat="server"
                                                        TransferToID="AmbassadorPositionList"
                                                        AllowTransferOnDoubleClick="True"
                                                        EnableDragAndDrop="True"
                                                        ButtonSettings-AreaWidth="35px" Height="200px" Width="225px"
                                                        DataKeyField="staffingPositionID"
                                                        DataSortField="positionTitle"
                                                        DataSourceID="getAvailablePositionList"
                                                        DataTextField="positionTitle"
                                                        DataValueField="staffingPositionID"
                                                        AllowTransfer="True"
                                                        AutoPostBackOnTransfer="true"
                                                        Skin="Bootstrap">
                                                        <ButtonSettings ShowTransferAll="false" />

                                                    </telerik:RadListBox>
                                                </div>

                                                <asp:HiddenField ID="HF_SelectedPosition" runat="server" />

                                                <div class="list-container size-thin">

                                                    <div class="title">
                                                        Selected Positions
                                                    </div>
                                                    <telerik:RadListBox runat="server" ID="AmbassadorPositionList" OnInserted="AmbassadorPositionList_Inserted" OnDeleted="AmbassadorPositionList_Deleted"
                                                        DataSourceID="getAmbassadorPositionList"
                                                        AllowDelete="True"
                                                        DataKeyField="staffingPositionID"
                                                        DataTextField="positionTitle"
                                                        DataValueField="staffingPositionID"
                                                        DataSortField="positionTitle"
                                                        AutoPostBackOnDelete="true"
                                                        Height="200px" Width="225px" Skin="Bootstrap">
                                                    </telerik:RadListBox>

                                                    <asp:SqlDataSource ID="getAvailablePositionList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAvailablePositionsForAmbassador" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                    <asp:SqlDataSource ID="getAmbassadorPositionList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAmbassadorPosition" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                </div>

                                            </div>


                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-3 control-label">Markets Assigned</label>
                                        <div class="col-sm-9">

                                            <div class="list-containers">

                                                <div class="list-container size-thin">
                                                    <div class="title">
                                                        Available Markets
                                                    </div>
                                                    <telerik:RadListBox ID="RadListBox3" runat="server"
                                                        TransferToID="AmbassadorMarketsList"
                                                        AllowTransferOnDoubleClick="True"
                                                        EnableDragAndDrop="True"
                                                        ButtonSettings-AreaWidth="35px" Height="200px" Width="225px"
                                                        DataKeyField="marketID"
                                                        DataSortField="marketName"
                                                        DataSourceID="getAvailableMarketList"
                                                        DataTextField="marketName"
                                                        DataValueField="marketID"
                                                        AllowTransfer="True"
                                                        AutoPostBackOnTransfer="true"
                                                        Skin="Bootstrap">
                                                        <ButtonSettings ShowTransferAll="false" />

                                                    </telerik:RadListBox>
                                                </div>

                                                <div class="list-container size-thin">

                                                    <div class="title">
                                                        Selected Markets
                                                    </div>
                                                    <telerik:RadListBox runat="server" ID="AmbassadorMarketsList" OnInserted="AmbassadorMarketsList_Inserted" OnDeleted="AmbassadorMarketsList_Deleted"
                                                        DataSourceID="getAmbassadorMarkets"
                                                        AllowDelete="True"
                                                        DataKeyField="marketID"
                                                        DataTextField="marketName"
                                                        DataValueField="marketID"
                                                        DataSortField="marketName"
                                                        AutoPostBackOnDelete="true"
                                                        Height="200px" Width="225px" Skin="Bootstrap">
                                                    </telerik:RadListBox>

                                                    <asp:SqlDataSource ID="getAvailableMarketList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAvailableMarketsForAmbassador" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                    <asp:SqlDataSource ID="getAmbassadorMarkets" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAmbassadorMarkets" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                </div>

                                            </div>


                                        </div>
                                    </div>

                                        </asp:Panel>

                                </div>





                            </div>
                            <!-- End Content -->
                        </div>

                    </telerik:RadPageView>

                    <!-- Notes Tab -->
                    <telerik:RadPageView runat="server" ID="RadPageView7">

                        <div class="widget stacked">
                            <div class="widget-content">
                                <h3>Notes</h3>
                                <hr />

                                <div class="form-horizontal">
                                    <div class="form-group">

                                        <div class="col-sm-12">
                                        <telerik:RadListView ID="NoteList" runat="server" DataSourceID="getAmbassadorNotes" DataKeyNames="ambassadorNoteID">

                                            <LayoutTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">

                                                        <tbody>
                                                            <tr></tr>
                                                            <tr id="itemPlaceholder" runat="server">
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-xs btn-success pull-right" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>" OnClick="btnInsert_Click"><i class="fa fa-plus"></i>  Add New Note</asp:LinkButton>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </LayoutTemplate>

                                            <ItemTemplate>
                                                <tr class="rlvI">
                                                    <td>
                                                        <%--<asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-xs btn-default" ToolTip="Edit" OnClick="EditButton_Click"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>--%>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("comment")%>' />

                                                        <div class="notefooter">
                                                            Created by:
                                                            <asp:Label ID="dateLabel" runat="server" Text='<%#Common.GetFullName(Eval("createdBy"))%>' />
                                                            on
                                                            <asp:Label ID="byLabel" runat="server" Text='<%# Common.GetTimeAdjustment(Eval("createdDate"))%>' />
                                                        </div>

                                                    </td>
                                                    <td style="padding-right: 40px;">
                                                        <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" Text="Delete" ToolTip="Delete" OnClick="DeleteButton_Click" OnClientClick="javascript:if(!confirm('This action will delete the note. Are you sure?')){return false;}" /></td>
                                                </tr>
                                            </ItemTemplate>

                                            <EditItemTemplate>
                                                <tr class="rlvIEdit">
                                                    <td></td>
                                                    <td>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("comment")%>' CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox></td>
                                                    <td>
                                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Update" ToolTip="Update" OnClick="UpdateButton2_Click" />
                                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" OnClick="CancelButton2_Click" />
                                                    </td>
                                            </EditItemTemplate>

                                            <InsertItemTemplate>
                                                <tr class="rlvIEdit">
                                                    <td></td>
                                                    <td>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("comment")%>' CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox></td>
                                                    <td>
                                                        <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" OnClick="UpdateButton2_Click"  />
                                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" OnClick="CancelButton2_Click" />
                                                    </td>
                                            </InsertItemTemplate>

                                            <EmptyDataTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">

                                                        <tbody>
                                                            <tr>
                                                                <td colspan="7">
                                                                    <div class="alert alert-warning" role="alert">There are no items to be displayed. To add a new item click on the <strong>Add New Note</strong> button above.</div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-xs btn-success pull-right" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>" OnClick="btnInsert_Click"><i class="fa fa-plus"></i>  Add New Note</asp:LinkButton>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </EmptyDataTemplate>

                                        </telerik:RadListView>
                                        </div>


                                <asp:LinqDataSource ID="getAmbassadorNotes" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
                                    EntityTypeName="" OrderBy="createdDate desc" TableName="tblAmbassadorNotes" Where="userID == @userID" 
                                    EnableDelete="True" EnableInsert="True" EnableUpdate="True">
                                    <WhereParameters>
                                        <asp:QueryStringParameter QueryStringField="userID" Name="userID" Type="String"></asp:QueryStringParameter>
                                    </WhereParameters>
                                </asp:LinqDataSource>

                                    </div>
                                </div>
                            </div>
                        </div>

                    </telerik:RadPageView>
                </telerik:RadMultiPage>

                <!-- End Tab Panel -->

            </div>
        </div>

    </div>

     <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

    <script type="text/javascript">
    function validateUser() {
    var id = document.getElementById('<%= PayrollIDTextBox.ClientID %>').value;

    $.ajax({
        type: "POST",
        url: "/ClientService.asmx/validateUserName",
        data: '{"userName": "' + id + '"}',
        contentType: 'application/json; charset=utf-8',
        processData: false,
        dataType: "json",
        success: function (response) {
            var users = eval(response.d);
            var html = "";
            $.each(users, function () {
                var msg = $("#<%=lblStatus.ClientID%>")[0];
                switch (this.IsValid) {

                case 1:
                msg.style.display = "block";
                msg.style.color = "red";
                msg.innerHTML = "<i class='fa fa-exclamation-circle' aria-hidden='true'></i> User Name already exists.";
                break;
                case 0:
                msg.style.display = "block";
                msg.style.color = "green";
                msg.innerHTML = "<i class='fa fa-check-circle' aria-hidden='true'></i> User Name Available";
                break;
                }
            });

        },
        error: function (a, b, c) {
            // alert("something went wrong")
        }
    });

        }
</script>

        </telerik:RadScriptBlock>

</asp:Content>
