<%@ Page Title="New Account" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AddAccount.aspx.vb" Inherits="EventManagerApplication.AddAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .errorlabel {
            padding: 0 10px;
            margin: 5px;
            font-weight: bold;
            color: red;
            font-size: .9em;
        }

        .label-standard {
            background-color: #000;
        }

        .form-group {
            margin-bottom: 10px;
        }


        .rlvI1 {
            font-size: 14px;
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
            display: block;
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

        * + html .riSingle input.riTextBox, * + html .RadForm.rfdTextbox .riSingle input.rfdDecorated[type="text"], .RadInput .riTextBox, .RadInputMgr {
            height: 33px !important;
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

                // Your custom confirmation logic here
                var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                var currentUpdatedControl = "<%= MainPanel.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.show(currentUpdatedControl);
            }

            if (command == "3") {

                // Your custom confirmation logic here
                var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                var currentUpdatedControl = "<%= MainPanel.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.show(currentUpdatedControl);
            }

            }

        })();
    </script>
    <link href="/Theme/css/custom1.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="MainPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManager>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <asp:HiddenField ID="HiddenAccountID" runat="server" />

    <div class="container">

        <asp:Panel ID="MainPanel" runat="server">
        <div class="row">
            <div class="col-md-12">

                <div style="margin: 0 0 15px 0">
                    <h2>New Account</h2>
                    <p>
                        Use this form to add a new account.  Complete each section below and click on the Next button to continue to the next tab.<br />
                        Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                    </p>

                    <asp:Label ID="msgLabel" runat="server" />

                </div>
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

                <div class="widget stacked">
                    <div class="widget-content">

                        <telerik:RadWizard ID="AccountWizard" runat="server" DisplayCancelButton="true" DisplayProgressBar="false" Skin="Bootstrap" OnClientLoad="OnClientLoad" OnClientButtonClicking="OnClientButtonClicking">

                            <WizardSteps>

                                <telerik:RadWizardStep Title="Information" ValidationGroup="information">
                                    <div class="form-horizontal">

                                        <div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="AccountNameTextBox" class="col-sm-4 control-label">Account Name <span class="text-danger">*</span></label>
                                                    <div class="col-sm-8">
                                                        <asp:TextBox ID="AccountNameTextBox" runat="server" CssClass="form-control" TabIndex="3" />
                                                        <asp:RequiredFieldValidator ID="AccountNameTextBoxRequiredFieldValidator" runat="server"
                                                            ErrorMessage="Account Name is required" CssClass="errorlabel" ControlToValidate="AccountNameTextBox"
                                                            Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                    <div class="form-group">
                                                    <label for="CompanyNameTextBox" class="col-sm-4 control-label">Company Name <span class="text-danger">*</span></label>
                                                    <div class="col-sm-8">
                                                        <asp:TextBox ID="CompanyNameTextBox" runat="server" CssClass="form-control" TabIndex="4" />
                                                        <asp:RequiredFieldValidator ID="CompanyNameTextBoxRequiredFieldValidator" runat="server"
                                                            ErrorMessage="Company Name is required" CssClass="errorlabel" ControlToValidate="CompanyNameTextBox"
                                                            Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                  <div class="form-group">
                                                    <label for="DistributorIDTextBox" class="col-sm-4 control-label">Distributor ID</label>
                                                    <div class="col-sm-8">
                                                        <asp:TextBox ID="DistributorIDTextBox" runat="server" CssClass="form-control" TabIndex="7" />
                                                       
                                                    </div>
                                                </div>

                                            </div>

                                             <div class="col-md-6">

                                                <div class="form-group">
                                                    <label for="statusddl" class="col-sm-4 control-label">Account Status <span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">
                                                        <asp:DropDownList ID="statusddl" runat="server" CssClass="form-control" TabIndex="5" AppendDataBoundItems="true">
                                                            <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                                            <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                            <asp:ListItem Text="Previous Active" Value="Previous Active"></asp:ListItem>
                                                            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                                            <asp:ListItem Text="Target" Value="Target"></asp:ListItem>
                                                        </asp:DropDownList>

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="information"
                                                            ControlToValidate="statusddl"
                                                            ErrorMessage="Account Status is required"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="AccountTypeIDTextBox" class="col-sm-4 control-label">Account Type <span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">
                                                        <asp:DropDownList ID="AccountTypeIDTextBox" runat="server" CssClass="form-control" TabIndex="6" AppendDataBoundItems="True" DataSourceID="getAccountType" DataTextField="accountTypeName" DataValueField="accountTypeID">
                                                            <asp:ListItem Text="- Select Account Type -" Value=""></asp:ListItem>
                                                        </asp:DropDownList>

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="information"
                                                            ControlToValidate="AccountTypeIDTextBox"
                                                            ErrorMessage="Account Type is required"></asp:RequiredFieldValidator>

                                                    </div>
                                                </div>

                                               


                                            </div>






                                           <%--  <div class="col-md-6">

                                               <div class="form-group">
                                                    <label for="AccountIDTextBox" class="col-sm-4 control-label">AccountID <span class="text-danger">*</span></label>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="AccountIDTextBox" runat="server" CssClass="form-control" TabIndex="1" />
                                                        <asp:RequiredFieldValidator ID="eventIDTextBoxRequiredFieldValidator" runat="server"
                                                            ErrorMessage="AccountID is required" CssClass="errorlabel" ControlToValidate="AccountIDTextBox"
                                                            Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="VPIDTextBox" class="col-sm-4 control-label">VpID <span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="VPIDTextBox" runat="server" CssClass="form-control" TabIndex="2" />
                                                        <asp:RequiredFieldValidator ID="VPIDTextBoxRequiredFieldValidator" runat="server"
                                                            ErrorMessage="VPID is required" CssClass="errorlabel" ControlToValidate="VPIDTextBox"
                                                            Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                            </div>--%>

                                           


                                        </div>
                                        <!-- end row -->

                                      


                                    </div>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep Title="Address" ValidationGroup="location">
                                    <div class="form-horizontal">

                                        <div>
                                            <!-- column one -->
                                            <div class="col-md-6">


                                                <div class="form-group">
                                                    <label for="streetAddress1TextBox" class="col-sm-4 control-label">Address 1 <span class="text-danger">*</span></label>
                                                    <div class="col-sm-7">
                                                        <asp:TextBox ID="streetAddress1TextBox" runat="server" CssClass="form-control" />

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="streetAddress1TextBox"
                                                            ErrorMessage="Address is required"></asp:RequiredFieldValidator>
                                                    </div>                                                    
                                                </div>

                                                <div class="form-group">
                                                    <label for="streetAddress2TextBox" class="col-sm-4 control-label">Address 2</label>
                                                    <div class="col-sm-7">
                                                        <asp:TextBox ID="streetAddress2TextBox" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="cityTextBox" class="col-sm-4 control-label">City <span class="text-danger">*</span></label>
                                                    <div class="col-sm-7">
                                                        <asp:TextBox ID="cityTextBox" runat="server" CssClass="form-control" />

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="cityTextBox"
                                                            ErrorMessage="City is required"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ddlState" class="col-sm-4 control-label">State <span class="text-danger">*</span></label>
                                                    <div class="col-sm-5">
                                                        <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control">
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
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="ddlState" InitialValue="3"
                                                            ErrorMessage="State is required"></asp:RequiredFieldValidator>
                                                    </div>                                                    
                                                </div>

                                                <div class="form-group">
                                                    <label for="zipCodeTextBox" class="col-sm-4 control-label">Zip <span class="text-danger">*</span></label>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="zipCodeTextBox" runat="server" CssClass="form-control" />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server"
                                                            CssClass="errorlabel" Display="Dynamic" ValidationGroup="location"
                                                            ControlToValidate="zipCodeTextBox"
                                                            ErrorMessage="Zip is required"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="PhoneTextBox" class="col-sm-4 control-label">Phone</label>
                                                    <div class="col-sm-4">
                                                        <%--<asp:TextBox ID="PhoneTextBox" runat="server" CssClass="form-control" />--%>
                                                        <telerik:RadMaskedTextBox RenderMode="Lightweight" ID="PhoneTextBox" runat="server" Mask="(###)###-####" 
                                                        Width="200px" Height="33px"></telerik:RadMaskedTextBox>
                                                    </div>
                                                </div>

                                            </div>

                                            <!-- column two -->
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="neighborhoodTextBox" class="col-sm-4 control-label">Neighborhood</label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="neighborhoodTextBox" runat="server" Text='' CssClass="form-control" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="marketIDTextBox" class="col-sm-4 control-label">Market <span class="text-danger">*</span></label>
                                                    <div class="col-sm-6">
                                                        <asp:DropDownList ID="marketIDddl" runat="server" DataSourceID="getMarketList"
                                                            DataTextField="marketName" DataValueField="marketID" CssClass="form-control">
                                                        </asp:DropDownList>
                                                        
                                                    </div>
                                                </div>

                                                 <div class="form-group">
                    <label for="websiteTextBox" class="col-sm-4 control-label">Website</label>
                    <div class="col-sm-8">
                        <asp:TextBox ID="websiteTextBox" runat="server" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="FacebookTextBox" class="col-sm-4 control-label">Facebook</label>
                    <div class="col-sm-8">
                        <asp:TextBox ID="FacebookTextBox" runat="server"  CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="TwitterTextBox" class="col-sm-4 control-label">Twitter</label>
                    <div class="col-sm-8">
                        <asp:TextBox ID="TwitterTextBox" runat="server"  CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="YelpTextBox" class="col-sm-4 control-label">Yelp</label>
                    <div class="col-sm-8">
                        <asp:TextBox ID="YelpTextBox" runat="server" CssClass="form-control" />
                    </div>
                </div>



                                            </div>

                                        </div>

                                    </div>
                                    <!-- end form -->
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep Title="Contacts">

                                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <telerik:RadListView ID="ContactList" runat="server"
        DataKeyNames="accountContactID" DataSourceID="getContacts" InsertItemPosition="FirstItem">
        <LayoutTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width:100%;">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>D.O.B</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </tbody>
                    <tfoot>
                         <asp:Button ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                          Text="Add New Contact" CssClass="btn btn-xs btn-primary pull-right"></asp:Button>
                    </tfoot>
                </table>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <tr class="rlvI">
                <td><asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title")%>' /></td>
                <td><asp:Label ID="contactNameLabel" runat="server" Text='<%# Eval("contactName")%>' /></td>
                <td><asp:Label ID="contactPhoneLabel" runat="server" Text='<%# Eval("contactPhone")%>' /></td>
                <td><asp:Label ID="ContactEmailLabel" runat="server" Text='<%# Eval("contactEmail")%>' /></td>
                <td><asp:Label ID="DOBLabel" runat="server" Text='<%# Eval("dob")%>' /></td>
                <td><asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" Text="Delete" ToolTip="Delete" /></td>
            </tr>
        </ItemTemplate>

        <EditItemTemplate>
            <tr class="rlvIEdit">
                <td><asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("title")%>' CssClass="form-control"></asp:TextBox></td>
                <td><asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("contactName")%>' CssClass="form-control"></asp:TextBox></td>
                <td><asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("contactPhone")%>' CssClass="form-control"></asp:TextBox></td>
                <td><asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("contactEmail")%>' CssClass="form-control"></asp:TextBox></td>
                <td><asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("dob")%>' CssClass="form-control"></asp:TextBox></td>
                <td  style="width:110px;"> 
                    <div class="btn-group" role="group" aria-label="...">

                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Save" ToolTip="Update" />
                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />  
                        </div>              
                </td>
                

         </EditItemTemplate>

        <InsertItemTemplate>
            <tr class="rlvIEdit">
                <td><asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("title")%>' CssClass="form-control"></asp:TextBox></td>
                <td><asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("contactName")%>' CssClass="form-control"></asp:TextBox></td>
                <td><asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("contactPhone")%>' CssClass="form-control"></asp:TextBox></td>
                <td><asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("contactEmail")%>' CssClass="form-control"></asp:TextBox></td>
                <td><asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("dob")%>' CssClass="form-control"></asp:TextBox></td>
                <td style="width:110px;"> 

                    <div class="btn-group" role="group" aria-label="...">

                    <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save" ToolTip="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                        </div>


                </td>
            </InsertItemTemplate>
        
       
        <EmptyDataTemplate>
            <div class="RadListView RadListView_Default">
                 <table class="table" cellspacing="0" style="width:100%;">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Title</th>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>D.O.B</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="7">
                                <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Contact</strong> button above.</div>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                         <asp:Button ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                          Text="Add New Contact" CssClass="btn btn-xs btn-primary pull-right"></asp:Button>
                    </tfoot>
                </table>
            </div>
        </EmptyDataTemplate>
        
    </telerik:RadListView>
   <asp:HiddenField ID="HiddenField1" runat="server" />

    <asp:LinqDataSource ID="getContacts" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" OrderBy="contactName" 
        TableName="tblAccountContacts" Where="accountID == @accountID">
        <WhereParameters>

            <asp:ControlParameter ControlID="HiddenAccountID" PropertyName="Value" Name="accountID" Type="Int32"></asp:ControlParameter>

        </WhereParameters>
    </asp:LinqDataSource>
  
</telerik:RadAjaxPanel>

                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep Title="Hours">
                                       <div class="col-md-6">
                <h4>Hours of Operation</h4>
                <table class="table" cellspacing="0" style="width: 80%;">
                    <thead>
                        <tr>
                            <th>Day</th>
                            <th>Open</th>
                            <th>Close</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Monday</td>
                            <td>
                                <asp:TextBox ID="monOpenTextBox" runat="server" CssClass="form-control input-sm" Width="95px"  /></td>
                            <td>
                                <asp:TextBox ID="monCloseTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Tueday</td>
                            <td>
                                <asp:TextBox ID="tuesOpenTextBox" runat="server" CssClass="form-control input-sm" Width="95px"  /></td>
                            <td>
                                <asp:TextBox ID="tuesCloseTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Wednesday</td>
                            <td>
                                <asp:TextBox ID="wedOpenTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="wedCloseTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Thursday</td>
                            <td>
                                <asp:TextBox ID="thurOpenTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="thurCloseTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Friday</td>
                            <td>
                                <asp:TextBox ID="friOpenTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="friCloseTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Saturday</td>
                            <td>
                                <asp:TextBox ID="satOpenTextBox" runat="server"  CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="satCloseTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Sunday</td>
                            <td>
                                <asp:TextBox ID="sunOpenTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="sunCloseTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>


            <div class="col-md-6">
                <h4>Busiest Days and Times</h4>
                <table class="table" cellspacing="0" style="width: 80%;">
                    <thead>
                        <tr>
                            <th>Day</th>
                            <th>Open</th>
                            <th>Close</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Monday</td>
                            <td>
                                <asp:TextBox ID="monStartTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="monEndTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Tueday</td>
                            <td>
                                <asp:TextBox ID="tuesStartTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="tuesEndTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Wednesday</td>
                            <td>
                                <asp:TextBox ID="wedStartTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="wedEndTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Thursday</td>
                            <td>
                                <asp:TextBox ID="thurStartTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="thurEndTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Friday</td>
                            <td>
                                <asp:TextBox ID="friStartTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="friEndTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Saturday</td>
                            <td>
                                <asp:TextBox ID="satStartTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="satEndTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Sunday</td>
                            <td>
                                <asp:TextBox ID="sunStartTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="sunEndTextBox" runat="server" CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                    </tbody>

                </table>
            </div>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep Title="Demographics">
                                                <div class="col-md-3">
                <h4>Race Demographics</h4>

                <table class="table" cellspacing="0" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>Race</th>
                            <th>%</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Caucasion</td>
                            <td>
                                <asp:TextBox ID="caucasianTextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>African American</td>
                            <td>
                                <asp:TextBox ID="africanAmericanTextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>Hispanic</td>
                            <td>
                                <asp:TextBox ID="hispanicTextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>Asian</td>
                            <td>
                                <asp:TextBox ID="asianTextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>Other</td>
                            <td>
                                <asp:TextBox ID="otherTextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="col-md-3">
                <h4>Age Demographics</h4>

                <table class="table" cellspacing="0" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>Age Range</th>
                            <th>%</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>21-25</td>
                            <td>
                                <asp:TextBox ID="_21_25TextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>26-30</td>
                            <td>
                                <asp:TextBox ID="_26_30TextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>31-35</td>
                            <td>
                                <asp:TextBox ID="_31_35TextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>36-40</td>
                            <td>
                                <asp:TextBox ID="_36_40TextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>40+</td>
                            <td>
                                <asp:TextBox ID="_40_TextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="col-md-3">
                <h4>Consumer Income</h4>

                <table class="table" cellspacing="0" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>$ Range</th>
                            <th>%</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>$20K-$35K</td>
                            <td>
                                <asp:TextBox ID="income20to35TextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>$36K-$50K</td>
                            <td>
                                <asp:TextBox ID="income36to50TextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>$51K-$75K</td>
                            <td>
                                <asp:TextBox ID="income51to75TextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>$76K-$100K</td>
                            <td>
                                <asp:TextBox ID="income76to100TextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>$100K+</td>
                            <td>
                                <asp:TextBox ID="income100plusTextBox" runat="server" CssClass="form-control input-sm" Width="100px" />
                                    </td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="col-md-3">
                <h4>Gender Demographics</h4>

                <table class="table" cellspacing="0" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>Gender</th>
                            <th>%</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Male</td>
                            <td>
                                <asp:TextBox ID="maleTextBox" runat="server" CssClass="form-control input-sm" Width="100px" /></td>
                        </tr>
                        <tr>
                            <td>Female</td>
                            <td>
                               <asp:TextBox ID="femaleTextBox" runat="server" CssClass="form-control input-sm" Width="100px" />
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep Title="Details">

                                    <div class="form-horizontal">

                                        <div class="col-md-4">

                                            <div class="form-group">
                                                <label for="capacityTextBox" class="col-sm-7 control-label">Account Capacity:</label>
                                                <div class="col-sm-3">
                                                    <telerik:RadNumericTextBox ID="capacityTextBox" MinValue="0" ShowSpinButtons="true" ButtonsPosition="Right" NumberFormat-DecimalDigits="0" runat="server" Skin="Bootstrap" Width="75px" Value="0" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="trafficTextBox" class="col-sm-7 control-label">Average Weekly Trafic:</label>
                                                <div class="col-sm-3">
                                                    <telerik:RadNumericTextBox ID="trafficTextBox" MinValue="0" ShowSpinButtons="true" ButtonsPosition="Right" NumberFormat-DecimalDigits="0" runat="server" Skin="Bootstrap" Width="75px" Value="0" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="barsTextBox" class="col-sm-7 control-label"># of Permament Bars:</label>
                                                <div class="col-sm-3">
                                                    <telerik:RadNumericTextBox ID="barsTextBox" runat="server" MinValue="0" ShowSpinButtons="true" ButtonsPosition="Right" NumberFormat-DecimalDigits="0" Skin="Bootstrap" Width="75px" Value="0" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="barStationsTextBox" class="col-sm-7 control-label"># of Bar Stations:</label>
                                                <div class="col-sm-3">
                                                    <telerik:RadNumericTextBox ID="barStationsTextBox" runat="server" MinValue="0" ShowSpinButtons="true" ButtonsPosition="Right" NumberFormat-DecimalDigits="0" Skin="Bootstrap" Width="75px" Value="0" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-2">



                                            <div class="form-group">
                                                <label for="capacityTextBox" class="col-sm-9 control-label">Patio Seating:</label>
                                                <div class="col-sm-3">
                                                    <asp:CheckBox ID="patioSeatingCheckBox" runat="server" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="liveMusicCheckBox" class="col-sm-9 control-label">Live Music:</label>
                                                <div class="col-sm-3">
                                                    <asp:CheckBox ID="liveMusicCheckBox" runat="server" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="poolTablesCheckBox" class="col-sm-9 control-label">Pool Tables:</label>
                                                <div class="col-sm-3">
                                                    <asp:CheckBox ID="poolTablesCheckBox" runat="server" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="dartsCheckBox" class="col-sm-9 control-label">Darts:</label>
                                                <div class="col-sm-3">
                                                    <asp:CheckBox ID="dartsCheckBox" runat="server" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="arcadeGamesCheckBox" class="col-sm-9 control-label">Arcade Games:</label>
                                                <div class="col-sm-3">
                                                    <asp:CheckBox ID="arcadeGamesCheckBox" runat="server" />
                                                </div>
                                            </div>

                                        </div>


                                        <div class="col-md-6">

                                            <div class="form-group">
                                                <label for="otherGamesTextBox" class="col-sm-4 control-label">Other Games:</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="otherGamesTextBox" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
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

    </div>

    <asp:LinqDataSource ID="getAccountType" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="accountTypeName" TableName="tblAccountTypes" Where="active == @active">
        <WhereParameters>
            <asp:Parameter DefaultValue="True" Name="active" Type="Boolean" />
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="getMarketList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="marketName" TableName="tblMarkets">
    </asp:LinqDataSource>

</asp:Content>
