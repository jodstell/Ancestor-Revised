<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AddUserControl.ascx.vb" Inherits="EventManagerApplication.AddUserControl" %>

<style>
    .RadInput .riTextBox {
        height: 100%;
    }

    #ctl00_MainContent_AddUserControl_AccountWizard .rwzNav .rwzLI .rwzRight .RadWizard_Bootstrap .rwzButton .rwzNext {
        background-color: #337ab7;
    }
 </style>

<div class="container">

        <div class="row">
            <div class="col-md-12">

                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>



                <%--<div class="widget stacked">
                    <div class="widget-content">--%>

                        <telerik:RadWizard ID="AccountWizard" runat="server" DisplayCancelButton="True" DisplayProgressBar="False" Skin="Bootstrap" Width="98%">

                            <WizardSteps>

                                <telerik:RadWizardStep Title="Information" ValidationGroup="information">
                                    <div class="form-horizontal">

                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label for="userNameTextBox" class="col-sm-5 control-label">User Name<span class="text-danger">*</span></label>

                                                <div class="col-md-7">
                                                    <asp:TextBox ID="userNameTextBox" runat="server" CssClass="form-control" />
                                                    <asp:RequiredFieldValidator ID="userNameRequiredFieldValidator" runat="server"
                                                        ErrorMessage="User Name is required" CssClass="errorlabel" ControlToValidate="userNameTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="passwordTextBox" class="col-sm-5 control-label">Password<span class="text-danger">*</span></label>

                                                <div class="col-md-7">
                                                    <asp:TextBox ID="passwordTextBox" runat="server" CssClass="form-control" TextMode="Password" />
                                                    <asp:RequiredFieldValidator ID="passwordRequiredFieldValidator" runat="server"
                                                        ErrorMessage="Password is required" CssClass="errorlabel" ControlToValidate="passwordTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="emailAdressTextBox" class="col-sm-5 control-label">Email Address<span class="text-danger">*</span></label>

                                                <div class="col-md-7">
                                                    <asp:TextBox ID="emailAdressTextBox" runat="server" CssClass="form-control" />
                                                    <asp:RequiredFieldValidator ID="emailAdressRequiredFieldValidator" runat="server"
                                                        ErrorMessage="Email Adress is required" CssClass="errorlabel" ControlToValidate="emailAdressTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="emailAdressRegularExpressionValidator" runat="server" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" 
                                                        ControlToValidate="emailAdressTextBox" ErrorMessage="Invalid Email Format" CssClass="errorlabel"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep Title="Details" ValidationGroup="details">

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

                                <telerik:RadWizardStep Title="Roles" ValidationGroup="roles">

                                    <div class="form-horizontal">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">Roles:</label>
                                                <div class="col-sm-9" style="top: 6px;">
                                                    <p>Assign this user to roles.</p>
                                                    <telerik:RadListBox ID="RolesListBox" runat="server" CheckBoxes="true" ShowCheckAll="false" Width="100%" Font-Bold="false">
                                                        <Items>
                                                            <telerik:RadListBoxItem Text="Administraor" Value="Administrator" />
                                                            <telerik:RadListBoxItem Text="Accounting" Value="Accounting" />
                                                            <telerik:RadListBoxItem Text="Agency" Value="Agency" />
                                                            <telerik:RadListBoxItem Text="Client" Value="Client" />
                                                            <telerik:RadListBoxItem Text="Event Manager" Value="Event Manager" />
                                                            <telerik:RadListBoxItem Text="Recruiter/Booking" Value="Recruiter/Booking" />
                                                        </Items>
                                                    </telerik:RadListBox>
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

                                <telerik:RadWizardStep Title="Assignments" ValidationGroup="markets">

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

                                </telerik:RadWizardStep>

                            </WizardSteps>
                        </telerik:RadWizard>
                    <%--</div>
                </div>--%>



            </div>
        </div>
    </div>
