<%@ Page Title="Configuration" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ClientDetails.aspx.vb" Inherits="EventManagerApplication.Clients" %>

<%@ Register Src="~/Admin/EventTypeControl.ascx" TagPrefix="uc1" TagName="EventTypeControl" %>
<%@ Register Src="~/Admin/SupplierListControl.ascx" TagPrefix="uc1" TagName="SupplierListControl" %>
<%@ Register Src="~/Admin/BrandsListControl.ascx" TagPrefix="uc1" TagName="BrandsListControl" %>
<%@ Register Src="~/Admin/UserControls/AccountActivitiesControl.ascx" TagPrefix="uc1" TagName="AccountActivitiesControl" %>
<%@ Register Src="~/Admin/UserControls/ClientAccountTypeControl.ascx" TagPrefix="uc1" TagName="ClientAccountTypeControl" %>
<%@ Register Src="~/Admin/UserControls/ClientMarketControl.ascx" TagPrefix="uc1" TagName="ClientMarketControl" %>
<%@ Register Src="~/Admin/UserControls/BrandGroupsControl.ascx" TagPrefix="uc1" TagName="BrandGroupsControl" %>
<%@ Register Src="~/Admin/UserControls/TeamsListControl.ascx" TagPrefix="uc1" TagName="TeamsListControl" %>
<%@ Register Src="~/Admin/UserControls/PortalBrandingControl.ascx" TagPrefix="uc1" TagName="PortalBrandingControl" %>
<%@ Register Src="~/Admin/UserControls/CategoriesControl.ascx" TagPrefix="uc1" TagName="CategoriesControl" %>
<%@ Register Src="~/Admin/UserControls/ProductsListControl.ascx" TagPrefix="uc1" TagName="ProductsListControl" %>
<%@ Register Src="~/Admin/UserControls/PackageSizeControl.ascx" TagPrefix="uc1" TagName="PackageSizeControl" %>
<%@ Register Src="~/Admin/UserControls/ShippingMethodsControl.ascx" TagPrefix="uc1" TagName="ShippingMethodsControl" %>
<%@ Register Src="~/Admin/UserControls/CategoryControl.ascx" TagPrefix="uc1" TagName="CategoryControl" %>








<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="css/clients.css" rel="stylesheet" />

    <script type="text/javascript">
        // close the div in 5 secs
        window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version
            $("#messageHolder").fadeOut("slow", null);
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row">
            <div id="messageHolder">
                <asp:Literal ID="msgLabel" runat="server" />
            </div>
        </div>


        <div class="row">
            <div class="col-md-12">

                <div style="margin: 0 0 15px 0">
                    <h2>Configuration:
                        <asp:Label ID="ClientNameLabel" runat="server" Font-Bold="true" /></h2>
                </div>

                <div class="tabbable">

                    <ul id="MainTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                        <li class="active"><a href="#detailstab" data-toggle="tab">Details</a></li>
                        <li class=""><a href="#supplierstab" data-toggle="tab">Suppliers</a></li>
                        <li class=""><a href="#eventtab" data-toggle="tab">Events Type</a></li>
                        <li class=""><a href="#marketstab" data-toggle="tab">Markets</a></li>
                        <li class=""><a href="#accounttab" data-toggle="tab">Accounts</a></li>

                        <%--<li class="pull-right secondarytab"><a href="/admin/siteadministration"><i class="fa fa-angle-double-left"></i>&nbsp;Site Administration</a></li>--%>
                    </ul>

                    <div class="tab-content tab-container">

                        <!-- Client Details Tab -->
                        <div class="tab-pane active" id="detailstab">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <div class="col-sm-12">
                                        <h2>Details</h2>
                                        <hr />

                                        <asp:FormView ID="ClientFormView" runat="server" DataKeyNames="clientID" DefaultMode="Edit" Width="100%" DataSourceID="getClient">
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
                                                                <asp:TextBox ID="PhoneTextBox" runat="server" CssClass="form-control" Text='<%# Bind("phoneNumber") %>' />
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
                                            EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblClients" Where="clientID == @clientID">
                                            <WhereParameters>
                                                <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>
                                    </div>
                                </div>
                            </div>

                        </div>


                        <!-- Suppliers Tab -->
                        <div class="tab-pane" id="supplierstab">

                            <!-- Suppliers List -->
                            <div class="tab-pane nested" id="suppliers">
                                <div class="widget stacked">
                                    <div class="widget-content min-height">
                                        <div class="col-sm-12">
                                            <!-- SupplierList Control -->
                                            <uc1:SupplierListControl runat="server" ID="SupplierListControl" />

                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>


                        <!-- Events Tab -->
                        <div class="tab-pane" id="eventtab">

                            <div class="tabbable tabs-left">

                                <div class="tab-content tab-info">
                                    <!-- Event Type -->
                                    <div class="tab-pane active" id="eventype">
                                        <div class="widget stacked">
                                            <div class="widget-content">
                                                <div class="col-sm-12">
                                                    <h2>Event Type</h2>
                                                    <hr />
                                                    <uc1:EventTypeControl runat="server" ID="EventTypeControl" />

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <!-- Markets Tab -->
                        <div class="tab-pane" id="marketstab">
                            <div class="widget stacked">
                                <div class="widget-content min-height">
                                    <div class="col-sm-12">
                                        <h2>Markets</h2>
                                        <hr />
                                        <uc1:ClientMarketControl runat="server" ID="ClientMarketControl" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Accounts Tabs -->
                        <div class="tab-pane" id="accounttab">

                            <!-- Account Tyes Tab -->
                                    <div class="tab-pane" id="accounttypes">
                                        <div class="widget stacked">
                                            <div class="widget-content min-height">
                                                <div class="col-sm-12">
                                                    <h2>Account Types</h2>
                                                    <hr />
                                                    <uc1:ClientAccountTypeControl runat="server" ID="ClientAccountTypeControl" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>



                           <%-- <div class="tabbable tabs-left">

                                <ul id="accountTab" class="nav nav-tabs sec" style="margin-bottom: 3px; border-bottom: 0">
                                    <li class="secondarytab active"><a href="#markets" data-toggle="tab">Markets <span class="badge">
                                        <asp:Label ID="MarketCountLabel" runat="server" /></span></a></li>
                                    <li class="secondarytab"><a href="#accounttypes" data-toggle="tab">Account Types <span class="badge">
                                        <asp:Label ID="AccountTypeCountLabel" runat="server" /></span></a></li>
                                    <li class="secondarytab"><a href="#accountactivities" data-toggle="tab">Account Activities <span class="badge">14</span></a></li>
                                </ul>

                                <div class="tab-content tab-info">



                                    

                                    <!-- Account Activities Tab -->
                                    <div class="tab-pane" id="accountactivities">
                                        <div class="widget stacked">
                                            <div class="widget-content min-height">
                                                <div class="col-sm-12">
                                                    <h2>Account Activities</h2>
                                                    <hr />
                                                    <uc1:AccountActivitiesControl runat="server" ID="AccountActivitiesControl" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                </div>
                            </div>--%>
                        </div>

                    </div>
                </div>
            </div>



        </div>





        <asp:LinqDataSource ID="getClientConfig" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableUpdate="True" EntityTypeName="" TableName="tblClients" Where="clientID == @clientID">
            <WhereParameters>
                <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
            </WhereParameters>
        </asp:LinqDataSource>


    </div>

    <script>

        $(document).ready(function () {

            handleTabLinks();
        });

        function handleTabLinks() {
            if (window.location.hash == '') {
                window.location.hash = window.location.hash + '#_';
            }
            var hash = window.location.hash.split('#')[1];
            var prefix = '_';
            var hpieces = hash.split('/');
            for (var i = 0; i < hpieces.length; i++) {
                var domelid = hpieces[i].replace(prefix, '');
                var domitem = $('a[href=#' + domelid + '][data-toggle=tab]');
                if (domitem.length > 0) {
                    domitem.tab('show');
                }
            }
            $('a[data-toggle=tab]').on('shown', function (e) {
                if ($(this).hasClass('nested')) {
                    var nested = window.location.hash.split('/');
                    window.location.hash = nested[0] + '/' + e.target.hash.split('#')[1];
                } else {
                    window.location.hash = e.target.hash.replace('#', '#' + prefix);
                }
            });
        }


        function onClientNameChange() {
            $('#clientNameText').addClass("has-success");
            $('#box1').removeClass('fade');
            return false;
        }


    </script>
</asp:Content>
