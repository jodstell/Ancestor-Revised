<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Master.Master" CodeBehind="RequestEvent.aspx.vb" Inherits="EventManagerApplication.RequestEvent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link href="/Theme/css/custom1.css" rel="stylesheet" />

    <style>
        .label-standard {
            background-color: #000;
        }

        .form-group {
            margin-bottom: 10px;
        }

        .rwzContent {
            overflow: hidden !important;
        }

        .nomargin {
            margin-bottom: 2px !important;
        }

        .jumbotron {
    text-align: center;
    background-color: transparent;
}
        .container .jumbotron, .container-fluid .jumbotron {
    padding-right: 15px;
    padding-left: 15px;
    border-radius: 6px;
}
        .jumbotron .sub {
     font-size: small;
 }
        /*@media screen and (min-width:768px)*/
.container .jumbotron, .container-fluid .jumbotron {
    padding-right: 60px;
    padding-left: 60px;
}

.alert .glyphicon{
    display:table-cell;
}

.alert div,
.alert span{
    padding-left: 5px;
    display:table-cell;
}


    </style>

    <div class="container min-height">

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>

                <telerik:AjaxSetting AjaxControlID="FormPanel">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="FormPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="StartDateTimePicker"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="EndDateTimePicker"></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>

                <telerik:AjaxSetting AjaxControlID="IntroductionPanel">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="IntroductionPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>



        <asp:Panel ID="IntroductionPanel" runat="server">

            <div class="row" style="margin-top: 35px;">
                <div class="col-sm-12">
            <h3>Welcome <asp:Label ID="SupplierNameLabel" runat="server" /></h3>

                    <asp:Label ID="welcomeLabel" runat="server" />

                </div>
            </div>

             <div class="jumbotron">


                 <hr />
        <h1>Make a Booking!</h1>

        <p class="lead">It has never been easier to book your event.  Click here to get started.</p>
               <p> <i class="fa fa-calendar fa-4x" aria-hidden="true"></i></p>
        <p>
            <asp:Button ID="btnBookEvent" runat="server" CssClass="btn btn-lg btn-success" Text="Book an Event Today!" />
            </p>
      </div>

            <div class="row center">
        <div class="col-lg-4">
            <i class="fa fa-external-link fa-4x" aria-hidden="true"></i>
          <h2>Visit our Website</h2>
          <%--<p class="text-danger">As of v9.1.2, Safari exhibits a bug in which resizing your browser horizontally causes rendering errors in the justified nav that are cleared upon refreshing.</p>--%>
          <p>Check out all the projects that we are working on. </p>
          <p><a class="btn btn-primary" role="button" href="#">Go to Website »</a></p>
        </div>


        <div class="col-lg-4">
            <i class="fa fa-sign-in fa-4x" aria-hidden="true"></i>
          <h2>Go to Portal</h2>
          <p>Log in to the event portal.</p>
          <p><a class="btn btn-primary" role="button" href="#">Go to Portal »</a></p>
       </div>
        <div class="col-lg-4">
            <i class="fa fa-phone fa-4x" aria-hidden="true"></i>

          <p><a class="btn btn-primary" role="button" href="#">Request Callback »</a></p>
        </div>



      </div>

            <hr />
        </asp:Panel>

        <asp:Panel ID="FormPanel" runat="server" Visible="false">

            <asp:HiddenField ID="supplierID" runat="server" />
            <asp:HiddenField ID="clientID" runat="server" />

            <div class="row">

                <div class="col-sm-12">
                    <div style="margin: 25px 0 15px 0">
                        <h2>Request Event</h2>
                        <p>
                            Complete each sections below and click on the Next button to continue to the next tab.<br />
                            Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                        </p>
                    </div>


                    <div class="widget stacked">
                        <div class="widget-content">

                           <telerik:RadWizard ID="EventWizard" runat="server" DisplayCancelButton="true" DisplayProgressBar="false" OnClientLoad="OnClientLoad"
                               OnClientButtonClicking="OnClientButtonClicking" OnActiveStepChanged="RadWizard1_ActiveStepChanged">
                                <WizardSteps>

                                    <telerik:RadWizardStep Title="Event Details" ValidationGroup="details">

                                        <div class="col-md-8">
                                            <div class="form-horizontal">

                                                <div class="form-group">
                                                    <label for="eventTitleTextBox" class="col-sm-3 control-label">Name of Event: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">
                                                        <asp:TextBox ID="eventTitleTextBox" runat="server" CssClass="form-control" />
                                                        <asp:RequiredFieldValidator ID="EventNameRequiredFieldValidator" runat="server"
                                                            ErrorMessage="Event Name is required" CssClass="errorlabel" ControlToValidate="eventTitleTextBox"
                                                            Display="Dynamic" ValidationGroup="details"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                 <div class="form-group">
                                                    <label for="eventTitleTextBox" class="col-sm-3 control-label">Type of Event: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">
                                                        <telerik:RadDropDownList ID="RadDropDownList1"  runat="server">
                                                            <Items>
                                                                <telerik:DropDownListItem Text="Bar On-Premise" Value="262" />
                                                                <telerik:DropDownListItem Text="Retail Off-Premise" Value="261" />
                                                            </Items>
                                                        </telerik:RadDropDownList>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="eventTitleTextBox" class="col-sm-3 control-label">Description: </label>
                                                    <div class="col-sm-9">
                                                        <asp:TextBox ID="DescriptionTextBox" runat="server" CssClass="form-control" TextMode="multiline" Rows="6" ></asp:TextBox>
                                                    </div>
                                                </div>



                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label">Event Date: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">
                                                        <telerik:RadDatePicker ID="EventDatePicker" runat="server" Culture="en-US" ShowPopupOnFocus="true"
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
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="details"
                                                            ControlToValidate="EventDatePicker"
                                                            ErrorMessage="Event Date is required"></asp:RequiredFieldValidator>


                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="StartDateTimePicker" class="col-sm-3 control-label">Start Time: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">
                                                        <telerik:RadDateTimePicker ID="StartDateTimePicker" Culture="en-US" runat="server" Skin="Bootstrap" Width="230px">
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
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="details"
                                                            ControlToValidate="StartDateTimePicker"
                                                            ErrorMessage="Start Time is required"></asp:RequiredFieldValidator>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="EndDateTimePicker" class="col-sm-3 control-label">End Time: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-9">
                                                        <telerik:RadDateTimePicker ID="EndDateTimePicker" Culture="en-US" runat="server" Skin="Bootstrap" Width="230px">
                                                            <Calendar runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle CssClass="rcToday" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                        </telerik:RadDateTimePicker>


                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="details"
                                                            ControlToValidate="EndDateTimePicker"
                                                            ErrorMessage="End Time is required"></asp:RequiredFieldValidator>

                                                        <asp:CompareValidator ID="dateCompareValidator" runat="server" ControlToValidate="EndDateTimePicker"
                                                            ValidationGroup="eventdate" CssClass="errorlabel"
                                                            ControlToCompare="StartDateTimePicker" Operator="GreaterThan" Type="String" ErrorMessage="The end date must be after the start date.">

                                                        </asp:CompareValidator>

                                                    </div>
                                                </div>


                                                 <asp:PlaceHolder ID="SupplierBudgetPlaceHolder" runat="server"></asp:PlaceHolder>



                                            </div>

                                        </div>
                                    </telerik:RadWizardStep>

                                    <telerik:RadWizardStep Title="Brands" ValidationGroup="brands">

                                        <div class="col-md-8">
                                            <p>Select the brands that you wish to present at the event.</p>
                                            <div class="form-horizontal">

                                                <div class="form-group">
                                                    <div class="col-sm-9">
                                                        <telerik:RadListBox RenderMode="Lightweight" ID="BrandListBox" runat="server" CheckBoxes="true" ShowCheckAll="true" Width="500px"
                                                            Height="350px" DataTextField="brandName" DataValueField="brandID" DataSourceID="getSupplierList">
                                                        </telerik:RadListBox>


                                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="ValidationCriteria"
                                                            ErrorMessage="Brand is required" CssClass="errorlabel" ValidationGroup="brands"></asp:CustomValidator>

                                                        <telerik:RadScriptBlock runat="server" ID="RadScriptBlock">
                                                            <script type="text/javascript">
                                                                function ValidationCriteria(source, args)
                                                                {
                                                                    var listbox = $find('<%= BrandListBox.ClientID %>');
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
                                                            <asp:ControlParameter ControlID="supplierID" PropertyName="Value" Name="supplierID" Type="Int32"></asp:ControlParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                </div>
                                            </div>
                                        </div>

                                    </telerik:RadWizardStep>

                                    <telerik:RadWizardStep Title="Location" ValidationGroup="location">
                                        <div class="col-md-8">

                                        <div class="form-horizontal">

                                                    <div class="form-group">
                                                            <label for="LocationNameTextBox" class="col-sm-3 control-label">Location Name: <span class="text-danger">*</span></label>
                                                            <div class="col-sm-9">
                                                            <asp:TextBox ID="LocationNameTextBox" runat="server" CssClass="form-control" />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                                ErrorMessage="Event Name is required" CssClass="errorlabel" ControlToValidate="LocationNameTextBox"
                                                                Display="Dynamic" ValidationGroup="location"></asp:RequiredFieldValidator>
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
                                        </div>

                                            </div>

                                    </telerik:RadWizardStep>

                                    <telerik:RadWizardStep Title="Confirmation" ValidationGroup="confirm">

                                        <div class="col-md-12">
                                            <div class="form-horizontal">

                                            <div class="col-md-7">
                                                <div class="form-horizontal">

                                                    <div class="form-group nomargin">
                                                        <label class="col-sm-6 control-label" style="font-size:27px;">Please review the following:</label>
                                                        <div class="col-sm-7" style="padding-top: 8px;">
                                                            <%--<asp:Label ID="EventDescriptionLabel" runat="server" />--%>
                                                        </div>
                                                    </div>

                                                    <div class="form-group nomargin">
                                                        <label class="col-sm-5 control-label">Event Name:</label>
                                                        <div class="col-sm-7" style="padding-top: 8px;">
                                                           <asp:Label ID="EventNameLabel" runat="server" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group nomargin">
                                                        <label class="col-sm-5 control-label">Event Type:</label>
                                                        <div class="col-sm-7" style="padding-top: 8px;">
                                                           <asp:Label ID="EventTypeLabel" runat="server" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group nomargin">
                                                        <label class="col-sm-5 control-label">Date:</label>
                                                        <div class="col-sm-7" style="padding-top: 8px;">
                                                           <asp:Label ID="EventDateLabel" runat="server" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group nomargin">
                                                        <label class="col-sm-5 control-label">Brands:</label>
                                                        <div class="col-sm-7" style="padding-top: 8px;">
                                                           <asp:Label ID="lblBrands" runat="server" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group nomargin">
                                                           <asp:Label ID="lblDescription" runat="server" CssClass="col-sm-5 control-label" Visible="false"><strong>Description:</strong></asp:Label>
                                                        <div class="col-sm-7" style="padding-top: 8px;">
                                                           <asp:Label ID="EventDescriptionLabel" runat="server" />
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="form-horizontal">

                                                    <div class="form-group nomargin">
                                                        <label class="col-sm-6 control-label"></label>
                                                        <div class="col-sm-6" style="padding-top: 8px;">
                                                            <asp:Label ID="Label1" runat="server" /><br />
                                                            <asp:Label ID="Label2" runat="server" Visible="false" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group nomargin">
                                                        <label class="col-sm-6 control-label">Where:</label>
                                                        <div class="col-sm-6" style="padding-top: 8px;">
                                                            <asp:Label ID="AccountNameLabel" runat="server" />
                                                            <asp:Label ID="AccountCityStateLabel" runat="server" Visible="false" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group nomargin">
                                                        <label class="col-sm-6 control-label">City:</label>
                                                        <div class="col-sm-6" style="padding-top: 8px;">
                                                            <asp:Label ID="AccountCityLabel" runat="server" />
                                                            <asp:Label ID="AccountAddressLabel" runat="server" Visible="false" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group nomargin">
                                                        <label class="col-sm-6 control-label">State:</label>
                                                        <div class="col-sm-6" style="padding-top: 8px;">
                                                            <asp:Label ID="AccountStateLabel" runat="server" />
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                            </div>
                                       </div>

                                        <div class="col-md-12">
                                        <hr />

                                        <div class="form-horizontal">
                                            <div class="form-group nomargin">

                                                <asp:Panel ID="AlertPanel" runat="server">
                                                  <div class="col-xs-12 alert alert-warning">
                        <div class="glyphicon glyphicon-exclamation-sign"></div>
                        <div>Thank you for your event request! This event is less than two weeks from today. We will do our best to staff it with the best Brand Ambassador we can. Please be aware that we reserve to right decline the event if we cannot staff it in time.</div></div>
                                                    </asp:Panel>

                                                    <label class="col-sm-6 control-label" style="font-size:27px;padding-right: 3%;">Click on Finish button to Submit your request:</label>
                                                    <div class="col-sm-7" style="padding-top: 8px;">
                                                    </div>
                                            </div>
                                        </div>

                                        </div>


                                        <div class="col-md-12 pull-right" style="padding-left: 50%;">
                                            <div class="form-horizontal">

                                                <div class="form-group nomargin">
                                                    <label for="LocationNameTextBox" class="col-sm-7 control-label">Full Name: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-5" style="margin-bottom: 5px;">
                                                        <asp:TextBox ID="fullNameTextBox" runat="server" CssClass="form-control" />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server"
                                                            ErrorMessage="Your full name is required" CssClass="errorlabel" ControlToValidate="fullNameTextBox"
                                                            Display="Dynamic" ValidationGroup="confirm"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group nomargin">
                                                    <label for="LocationNameTextBox" class="col-sm-7 control-label">E-mail Address: <span class="text-danger">*</span></label>
                                                        <div class="col-sm-5">
                                                            <asp:TextBox ID="userEmailAddressTextBox" runat="server" CssClass="form-control" />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server"
                                                                ErrorMessage="E-mail address is required" CssClass="errorlabel" ControlToValidate="userEmailAddressTextBox"
                                                                Display="Dynamic" ValidationGroup="confirm"></asp:RequiredFieldValidator>

                                                            <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                ControlToValidate="userEmailAddressTextBox" CssClass="errorlabel" ErrorMessage="Invalid Email Format" ValidationGroup="confirm"></asp:RegularExpressionValidator>
                                                        </div>
                                                </div>

                                            </div>
                                        </div>


                                    </telerik:RadWizardStep>

                                </WizardSteps>
                            </telerik:RadWizard>


                        </div>
                    </div>

                </div>

            </div>

        </asp:Panel>




        <asp:Panel runat="server" ID="NotBelongHerePanel" Visible="false">

          <div class="row">

				<div class="col-md-12" style="margin-top:60px">

					<div class="error-container">

						<div class="error-code">
							Oops!
						</div> <!-- /.error-code -->

						<div class="error-details">
							<h3>This Request Event Link is Bad




</h3>
							<br />
							<p><strong>What should I do:</strong></p>


							<ul class="icons-list">
								<li>
									<i class="icon-li fa fa-check-square-o"></i>
									you can try refreshing the page, the problem may be temporary
								</li>
								<li>
									<i class="icon-li fa fa-check-square-o"></i>
									if you entered the url by hand, double check that it is correct
								</li>
								<li>
									<i class="icon-li fa fa-check-square-o"></i>
									Nothing! we've been notified of the problem and will do our best to make sure it doesn't happen again!
								</li>
							</ul>
						</div> <!-- /.error-details -->

					</div> <!-- /.error -->

				</div> <!-- /.col-md-12 -->

			</div>

        </asp:Panel>


    </div>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
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

            }

        })();

    </script>
    </telerik:RadScriptBlock>


</asp:Content>
