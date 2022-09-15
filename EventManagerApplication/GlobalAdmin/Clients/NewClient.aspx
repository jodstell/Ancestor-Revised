<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin.Master" CodeBehind="NewClient.aspx.vb" Inherits="EventManagerApplication.NewClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel runat="server" ID="MainPanel">

        <div class="container">

            <div class="row">
                <div class="col-md-12">

                    <div style="margin: 0 0 15px 0">
                        <h2>New Client 
                        </h2>
                        <p>
                            Use this form to add a new client.  Complete each field below and click on the Save button to continue to add client.<br />
                            Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                        </p>



                    </div>

                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" />

                    <asp:Label ID="msgLabel" runat="server" />

                    <div class="widget stacked">
                        <div class="widget-content min-height">

                            <asp:FormView ID="ClientFormView" runat="server" DataKeyNames="clientID" DefaultMode="Insert" Width="100%" DataSourceID="getClient">
                                <EditItemTemplate>

                                    <div class="contentbox">

                                        <div class="row">

                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label for="ClientNameTextBox">Client Name</label>
                                                    <asp:TextBox ID="ClientNameTextBox" runat="server" CssClass="form-control" Text='<%# Bind("clientName") %>' />
                                                </div>
                                            </div>

                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label for="PhoneTextBox">Phone</label>
                                                    <asp:TextBox ID="PhoneTextBox" runat="server" CssClass="form-control" Text='<%# Bind("phoneNumber") %>'/>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="row">

                                            <div class="col-sm-5">
                                                <div class="form-group">
                                                    <label for="StreetAddressTextBox">Street Address</label>
                                                    <asp:TextBox ID="StreetAddressTextBox" runat="server" CssClass="form-control" Text='<%# Bind("streetAddress") %>' />
                                                </div>
                                            </div>

                                        </div>

                                        <div class="row">

                                            <div class="col-sm-2">
                                                <div class="form-group">
                                                    <label for="SuppliersTextBox">City</label>
                                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Text='<%# Bind("city") %>'></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="col-sm-2">
                                                <div class="form-group">
                                                    <label for="StateTextBox">State</label>
                                                    <asp:DropDownList ID="DashboardTextBox" runat="server" SelectedValue='<%# Bind("state") %>' CssClass="form-control" DataSourceID="LinqDataSource1" DataTextField="StateName" DataValueField="StateCode" AppendDataBoundItems="true">
                                                        <asp:ListItem Value="">Please Select</asp:ListItem>
                                                        <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                        <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblStates"></asp:LinqDataSource>
                                                </div>
                                            </div>

                                            <div class="col-sm-1">
                                                <div class="form-group">
                                                    <label for="DashboardTextBox">Zip Code</label>
                                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Text='<%# Bind("zipCode") %>'></asp:TextBox>
                                                </div>

                                            </div>


                                            <iv class="col-sm-2">
                                                <div class="form-group">
                                                    <label for="CountryTextBox">Country</label>
                                                    <asp:DropDownList ID="CountryTextBox" runat="server" SelectedValue='<%# Bind("country") %>' CssClass="form-control">
                                                        <asp:ListItem Text="United States" Value="United States"></asp:ListItem>
                                                        <asp:ListItem Text="Canada" Value="Canada"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                        </div>
                                    
                                    

                                    <div class="row">

                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label for="ContactNameTextBox">Contact Name</label>
                                                <asp:TextBox ID="ContactNameTextBox" runat="server" CssClass="form-control" Text='<%# Bind("contactPerson") %>'></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label for="ContactPhoneTextBox">Contact Phone</label>
                                                <asp:TextBox ID="ContactPhoneTextBox" runat="server" CssClass="form-control" Text='<%# Bind("contactPhone") %>'></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label for="ContactEmailTextBox">Contact Email</label>
                                                <asp:TextBox ID="ContactEmailTextBox" runat="server" CssClass="form-control" Text='<%# Bind("contactEmail") %>' />
                                                <%--<asp:RequiredFieldValidator ID="emailAdressRequiredFieldValidator" runat="server"
                                                    ErrorMessage="Email Adress is required" CssClass="errorlabel" ControlToValidate="ContactEmailTextBox"
                                                    Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="emailAdressRegularExpressionValidator" runat="server" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
                                                    ControlToValidate="ContactEmailTextBox" ErrorMessage="Invalid Email Format" CssClass="errorlabel" ValidationGroup="information"></asp:RegularExpressionValidator>--%>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="row">

                                        <div class="col-sm-12">
                                            <asp:Button ID="btnUpdateClient" runat="server" CausesValidation="True" CommandName="Insert" Text="Save" CssClass="btn btn-md btn-primary" />
                                            <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                                        </div>
                                    </div>

                                        </div>

                                    </div>

                                </EditItemTemplate>

                            </asp:FormView>

                            <asp:LinqDataSource ID="getClient" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
                                EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblClients"></asp:LinqDataSource>


                        </div>
                    </div>

                </div>

            </div>

        </div>


    </asp:Panel>

</asp:Content>
