<%@ Page Title="New User" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="NewUser.aspx.vb" Inherits="EventManagerApplication.NewUser1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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

            }

        })();
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <link href="../../Theme/css/custom.css" rel="stylesheet" />

    <style>
    .RadInput .riTextBox {
        height: 100%;
    }

    #ctl00_MainContent_AddUserControl_AccountWizard .rwzNav .rwzLI .rwzRight .RadWizard_Bootstrap .rwzButton .rwzNext {
        background-color: #337ab7;
    }
 </style>


<%--    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="AccountWizard">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="AccountWizard" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>--%>

<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="MainPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>


        <div class="container">

<asp:Panel runat="server" ID="MainPanel">

        <div class="row">
            <div class="col-xs-12">
                <h2>Administration</h2>
            </div>
        </div>

        <div class="row">

            <div class="col-md-12">

                <h2>New User</h2>




                <div class="widget stacked">
                    <div class="widget-content">

                        <telerik:RadWizard ID="AccountWizard" runat="server" DisplayCancelButton="True" DisplayProgressBar="False" Skin="Bootstrap" Width="98%"
                            OnClientLoad="OnClientLoad" OnClientButtonClicking="OnClientButtonClicking">

                            <WizardSteps>

                                <telerik:RadWizardStep Title="Information" ValidationGroup="information" CausesValidation="true">
                                    <div class="form-horizontal">

                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label for="userNameTextBox" class="col-sm-5 control-label">User Name<span class="text-danger">*</span></label>

                                                <div class="col-md-7">
                                                    <asp:TextBox ID="userNameTextBox" runat="server" CssClass="form-control" onchange="validateUser()" /> <asp:Label ID="lblStatus" runat="server" />

                                                    <asp:RequiredFieldValidator ID="userNameRequiredFieldValidator" runat="server"
                                                        ErrorMessage="User Name is required" CssClass="errorlabel" ControlToValidate="userNameTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>


                                                </div>
                                            </div>


                                            <div class="form-group">
                                                <label for="passwordTextBox" class="col-sm-5 control-label">Password<span class="text-danger">*</span></label>

                                                <div class="col-md-7">
                                                    <asp:TextBox ID="passwordTextBox" runat="server" CssClass="form-control"  />

                                                    <%--TextMode="Password"--%>

                                                    <asp:RequiredFieldValidator ID="passwordRequiredFieldValidator" runat="server"
                                                        ErrorMessage="Password is required" CssClass="errorlabel" ControlToValidate="passwordTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="emailAdressTextBox" class="col-sm-5 control-label">Email Address<span class="text-danger">*</span></label>

                                                <div class="col-md-7">
                                                    <asp:TextBox ID="emailAdressTextBox" runat="server" CssClass="form-control" onchange="validateEmail()" /> <asp:Label ID="lblEmailValid" runat="server" />
                                                    <asp:RequiredFieldValidator ID="emailAdressRequiredFieldValidator" runat="server"
                                                        ErrorMessage="Email Adress is required" CssClass="errorlabel" ControlToValidate="emailAdressTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="emailAdressRegularExpressionValidator" runat="server" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
                                                        ControlToValidate="emailAdressTextBox" ErrorMessage="Invalid Email Format" CssClass="errorlabel" ValidationGroup="information"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep Title="Details" ValidationGroup="details" CausesValidation="true">

                                    <div class="form-horizontal">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label for="firstNameTextBox" class="col-sm-5 control-label">First Name<span class="text-danger">*</span></label>

                                                <div class="col-md-7">
                                                    <asp:TextBox ID="firstNameTextBox" runat="server" CssClass="form-control" />
                                                    <asp:RequiredFieldValidator ID="firstNameRequiredFieldValidator" runat="server"
                                                        ErrorMessage="First Name is required" CssClass="errorlabel" ControlToValidate="firstNameTextBox"
                                                        Display="Dynamic" ValidationGroup="details"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="lastNameTextBox" class="col-sm-5 control-label">Last Name<span class="text-danger">*</span></label>

                                                <div class="col-md-7">
                                                    <asp:TextBox ID="lastNameTextBox" runat="server" CssClass="form-control" />
                                                    <asp:RequiredFieldValidator ID="lastNameRequiredFieldValidator" runat="server"
                                                        ErrorMessage="Last Name is required" CssClass="errorlabel" ControlToValidate="lastNameTextBox"
                                                        Display="Dynamic" ValidationGroup="details"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                             <div class="form-group">
                                                <label for="phoneNumberTextBox" class="col-sm-5 control-label">Phone Number</label>

                                                <div class="col-md-7">
                                                    <telerik:RadMaskedTextBox RenderMode="Lightweight" ID="phoneNumberTextBox" runat="server" Mask="(###)###-####">
                                            </telerik:RadMaskedTextBox>


                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="timeZoneDDL" class="col-sm-5 control-label">Time Zone</label>

                                                <div class="col-md-7">
                                                    <asp:DropDownList ID="ddlTimeZone" runat="server"
                                                        AppendDataBoundItems="True" CssClass="form-control" DataSourceID="getTimeZones"
                                                        DataTextField="DisplayName" DataValueField="Id">
                                                        <asp:ListItem Text="Select a TimeZone" Value="" />
                                                    </asp:DropDownList>
                                                    <asp:LinqDataSource ID="getTimeZones" runat="server"
                                                        ContextTypeName="EventManagerApplication.LMSDataClassesDataContext"
                                                        EntityTypeName="" OrderBy="TimeZoneID" TableName="TimeZones"></asp:LinqDataSource>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep Title="Roles" ValidationGroup="roles" CausesValidation="true">

                                    <div class="form-horizontal">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">Roles:</label>
                                                <div class="col-sm-9" style="top: 6px;">
                                                    <p>Assign this user to roles.</p>

                                                    <asp:RadioButtonList ID="RoleRadioButtonList" runat="server" Font-Bold="false">
                                                        <asp:ListItem Text="Administrator" Value="Administrator"></asp:ListItem>
                                                        <asp:ListItem Text="Accounting" Value="Accounting"></asp:ListItem>
                                                        <asp:ListItem Text="Agency" Value="Agency"></asp:ListItem>
                                                        <asp:ListItem Text="Client" Value="Client"></asp:ListItem>
                                                        <asp:ListItem Text="Event Manager" Value="EventManager"></asp:ListItem>
                                                        <asp:ListItem Text="Recruiter/Booking" Value="Recruiter/Booking"></asp:ListItem>
                                                        <asp:ListItem Text="Brand Marketer" Value="BrandMarketer"></asp:ListItem>
                                                    </asp:RadioButtonList>

                                                    <%--<telerik:RadListBox ID="RolesListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="100%" Font-Bold="false">
                                                        <Items>
                                                            <telerik:RadListBoxItem Text="Administrator" Value="Administrator" />
                                                            <telerik:RadListBoxItem Text="Accounting" Value="Accounting" />
                                                            <telerik:RadListBoxItem Text="Agency" Value="Agency" />
                                                            <telerik:RadListBoxItem Text="Client" Value="Client" />
                                                            <telerik:RadListBoxItem Text="Event Manager" Value="EventManager" />
                                                            <telerik:RadListBoxItem Text="Recruiter/Booking" Value="Recruiter/Booking" />
                                                        </Items>
                                                    </telerik:RadListBox>--%>
                                                </div>
                                            </div>



                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">Team:</label>
                                                <div class="col-sm-9" style="top: 6px;">

                                                    <telerik:RadComboBox ID="TeamComboBox" runat="server" DataSourceID="GetTeamList" DataTextField="teamName" 
                                                        DataValueField="teamID" EmptyMessage="Select a Team" Width="400px" AppendDataBoundItems="true">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="None" Value="0" />
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






                                        </div>

                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">Clients:</label>
                                                <div class="col-sm-9" style="top: 6px;">
                                                    <p>Assign the user to clients.</p>

                                                    <asp:CheckBox ID="EnableAllClientsCheckBox" runat="server" Text="Enable All Clients" AutoPostBack="true" />

                                                    <telerik:RadListBox ID="ClientListBox" runat="server" CheckBoxes="true" Width="100%" Font-Bold="false" DataSourceID="GetClientList"  DataTextField="clientName" DataValueField="clientID">
                                                    </telerik:RadListBox>
                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetClientList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="clientID" TableName="tblClients"></asp:LinqDataSource>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep Title="Assignments" ValidationGroup="markets" CausesValidation="true">

                                    <div class="form-horizontal">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">Markets:</label>
                                                <div class="col-sm-9" style="top: 6px;">
                                                    <p>Assign this user to market.</p>

                                                    <asp:CheckBox ID="EnableAllMarketsCheckBox" runat="server" Text="Enable All Markets" AutoPostBack="true" />

                                                    <telerik:RadListBox ID="MarketListBox" runat="server" CheckBoxes="true" Width="100%" Font-Bold="false" DataSourceID="GetMarketList" DataTextField="marketName" DataValueField="marketID" Height="350px">
                                                    </telerik:RadListBox>
                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetMarketList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="marketName" TableName="tblMarkets" Where="active == @active">
                                                        <WhereParameters>
                                                            <asp:Parameter DefaultValue="True" Name="active" Type="Boolean"></asp:Parameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">Suppliers:</label>
                                                <div class="col-sm-9" style="top: 6px;">
                                                    <p>Assign the user to suppliers.</p>

                                                    <asp:CheckBox ID="EnableAllSupplierCheckBox" runat="server" Text="Enable All Suppliers" />

                                                    <telerik:RadListBox ID="SupplierListBox" runat="server" CheckBoxes="true" Width="100%" Font-Bold="false" DataSourceID="GetSupplier" DataTextField="supplierName" DataValueField="supplierID" Height="350px">
                                                    </telerik:RadListBox>

                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetSupplier" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="supplierName" TableName="tblSuppliers"></asp:LinqDataSource>

                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <asp:Label ID="msgLabel" runat="server" />

                                </telerik:RadWizardStep>

                            </WizardSteps>
                        </telerik:RadWizard>


                        </div>
                    </div>

                </div>

            </div>
</asp:Panel>
            </div>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

    <script type="text/javascript">
    function validateUser() {
    var id = document.getElementById('<%= userNameTextBox.ClientID %>').value;

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
                default:
                    msg.style.display  =  "block";
                    msg.style.color  =  "red";
                    msg.innerHTML  =  "<i class='fa fa-exclamation-circle' aria-hidden='true'></i> User Name already exists.";
                    break;
                }
            });

        },
        error: function (a, b, c) {
            // alert("something went wrong")
        }
    });






                }

        function validateEmail() {
            var id = document.getElementById('<%= emailAdressTextBox.ClientID %>').value;

            $.ajax({
                type: "POST",
                url: "/ClientService.asmx/validateUserEmail",
                data: '{"email": "' + id + '"}',
                contentType: 'application/json; charset=utf-8',
                processData: false,
                dataType: "json",
                success: function (response) {
                    var users = eval(response.d);
                    var html = "";
                    $.each(users, function () {
                        var msg = $("#<%=lblEmailValid.ClientID%>")[0];
                switch (this.IsValid) {

                    case  1:
                        msg.style.display  =  "block";
                        msg.style.color  =  "red";
                        msg.innerHTML  =  "<i class='fa fa-exclamation-circle' aria-hidden='true'></i> Email Address is already used.";
                        break;
                    case  0:
                        msg.style.display = "block";
                        msg.style.color = "green";
                        msg.innerHTML = "<i class='fa fa-check-circle' aria-hidden='true'></i> Email Address is Available";
                        break;
                    default:
                        msg.style.display = "block";
                        msg.style.color = "red";
                        msg.innerHTML = "<i class='fa fa-exclamation-circle' aria-hidden='true'></i> Email Address is already used.";
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

    <script>

        //$(document).ready(function () {

        //    var id = "jons@bletsianlms.com"

        //    $.ajax({
        //        type: "POST",
        //        url: "/ClientService.asmx/validateUserName",
        //        data: '{"userName": "' + id + '"}',
        //        contentType: 'application/json; charset=utf-8',
        //        processData: false,
        //        dataType: "json",
        //        success: function (response) {
        //            var users = eval(response.d);
        //            var html = "";
        //            $.each(users, function () {
        //                alert(this.IsValid);

        //            });

        //        },
        //        error: function (a, b, c) {
        //           // alert("something went wrong")
        //        }
        //    });

        //})
    </script>

</asp:Content>
