<%@ Page Title="User Profile" Language="vb" AutoEventWireup="false" MasterPageFile="~/Master.Master" CodeBehind="UserProfile.aspx.vb" Inherits="EventManagerApplication.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Theme/css/custom.css" rel="stylesheet" />

    <style>
        .navbar.navbar-inverse {
            display: none !important;
        }

        .label-standard {
            background-color: #000;
        }

        .form-group {
            margin-bottom: 10px;
        }


        .rlvI1 {
            font-size: 24px;
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
            display: none;
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

        .form-horizontal {
            padding-top: 20px;
        }
    </style>

    <script type="text/javascript">
        // close the div in 5 secs
        window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version
            $("#messageHolder").fadeOut("slow", null);
        }


    </script>

    <script type="text/javascript">
            function CloseAndRebind(args)
            {
                GetRadWindow().BrowserWindow.refreshGrid(args);
                GetRadWindow().close();
            }
 
            function GetRadWindow()
            {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)
 
                return oWindow;
            }
 
            function CancelEdit()
            {
                GetRadWindow().close();
            }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">

     <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    
     <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel2">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel2" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

    <%--<AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="RoleRadioButtonList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel2" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>--%>
</telerik:RadAjaxManager>



<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>


    <div class="container" style="width: 1165px;">
        
        <div class="row">

            <div class="col-md-12">

                <h2>User Profile</h2>


                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>

                <div class="pull-right">
                    <asp:Button ID="btnReturn" runat="server" Text="Go back to Users" CssClass="btn btn-default" />
                </div>




                <div class="tabbable">

                <ul id="MainTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                    <li class="active"><a href="#information" data-toggle="tab">Information</a></li>
                    <li class=""><a href="#roles" data-toggle="tab">Roles</a></li>
                    <li class=""><a href="#assignments" data-toggle="tab">Suppliers</a></li>
                    <li class=""><a href="#markets" data-toggle="tab">Markets</a></li>
                    <li class=""><a href="#teams" data-toggle="tab">Teams</a></li>
                    <li class=""><a href="#password" data-toggle="tab">Password</a></li>

                    <%--<li class="pull-right btn btn-default"><a href="/admin/siteadministration?LoadState=Yes#users">
                        <i class="fa fa-chevron-left" aria-hidden="true"></i> Go back to Users</a></li>--%>
                </ul>

                <div class="tab-content tab-container">

                <div class="tab-pane active" id="information">

                <asp:Panel runat="server" ID="MainPanel">
                    <div class="widget stacked">
                        <div class="widget-content min-height">



                            <div class="form-horizontal">

                                <div class="col-md-12">

                                    <div class="col-md-4">

                                        <div class="form-group">
                                            <label for="FirstNameTextBox" class="col-sm-6 control-label">User Name:</label>
                                            <div class="col-sm-6" style="top: 6px;">

                                                <asp:Label ID="UserName" runat="server" />

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="FirstNameTextBox" class="col-sm-6 control-label">Portal Password:</label>
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


                                        <div class="form-group">
                                            <label for="LastLoginTextBox" class="col-sm-6 control-label">User ID:</label>
                                            <div class="col-sm-6" style="top: 6px;">

                                                <asp:Label ID="UserIDLabel" runat="server" />

                                            </div>
                                        </div>


                                    </div>


                                    <div class="col-md-7">

                                        <div class="form-group">
                                            <label for="FirstNameTextBox" class="col-sm-4 control-label">First Name: <span class="text-danger">*</span></label>
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

                                               <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                        ErrorMessage="Phone Number is required" CssClass="errorlabel" ControlToValidate="phoneNumberTextBox"
                                                        Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>--%>

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
                                            <asp:Button ID="btnSave" runat="server" Text="Update" CssClass="btn btn-primary" CausesValidation="true" ValidationGroup="information" />
                                        </div>
                                    </div>

                                    </div>

                                    <div class="col-ms-1"></div>




                                </div>


                               

                            </div>



                        </div>
                    </div>

                </asp:Panel>
                </div>


                <div class="tab-pane" id="roles">
                <asp:Panel ID="Panel2" runat="server">
                    <div class="widget stacked">
                        <div class="widget-content min-height">

<asp:HiddenField ID="HF_SelectedItemID" runat="server" />

                            <div class="form-horizontal">

                                    <div class="row">
                                <div class="col-md-12">
                                <div class="form-group">
                                        <label for="EnableAllClientsCheckBox" class="col-sm-2 control-label">Roles:</label>
                                        <div class="col-sm-10" style="top: 6px;">
                                                                                        

                                            <p>Add or remove this user from roles.</p>
                                            <asp:RadioButtonList ID="RoleRadioButtonList" runat="server" AutoPostBack="true">
                                                <asp:ListItem Text="Administrator" Value="Administrator"></asp:ListItem>
                                                <asp:ListItem Text="Accounting" Value="Accounting"></asp:ListItem>
                                                <asp:ListItem Text="Agency" Value="Agency"></asp:ListItem>
                                                <asp:ListItem Text="Client" Value="Client"></asp:ListItem>
                                                <asp:ListItem Text="Event Manager" Value="EventManager"></asp:ListItem>
                                                <asp:ListItem Text="Recruiter/Booking" Value="Recruiter/Booking"></asp:ListItem>
                                                <asp:ListItem Text="Brand Marketer" Value="BrandMarketer"></asp:ListItem>
                                            </asp:RadioButtonList>
                                            <%--<p><asp:CheckBox ID="ckAdmin" runat="server" AutoPostBack="true" /> Administrator</p>
                                            <p><asp:CheckBox ID="ckAccounting" runat="server" AutoPostBack="true" /> Accounting</p>
                                            <p><asp:CheckBox ID="ckAgency" runat="server" AutoPostBack="true" /> Agency</p>
                                            <p><asp:CheckBox ID="ckClient" runat="server" AutoPostBack="true" /> Client</p>
                                            <p><asp:CheckBox ID="ckEventManager" runat="server" AutoPostBack="true" /> Event Manager</p>
                                            <p><asp:CheckBox ID="ckRecuiter" runat="server" AutoPostBack="true" /> Recruiter/Booking</p>--%>
                                            <br />
                                        </div>
                                    </div>
                                </div>
                                        </div>

                                    <div class="row">
                                <div class="col-md-12">
                                <div class="form-group">
                                    <label for="EnableAllClientsCheckBox" class="col-sm-2 control-label">Clients Assigned:</label>
                                    <div class="col-sm-10" style="top: 6px;">

                                        <asp:CheckBox ID="EnableAllClientsCheckBox" runat="server" Text="Enable All Clients" AutoPostBack="true" />

                                        <div id="clientsPanel" runat="server" class="list-containers">

                                            <div class="list-container size-thin">
                                                <div class="title">
                                                    Available Clients
                                                </div>

                                                <telerik:RadListBox ID="ClientList" runat="server"
                                                    TransferToID="SelectedClientList"
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

                                            <asp:SqlDataSource ID="getClientList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAvailableClientForStaff" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>


                                            <div class="list-container size-thin">

                                                <div class="title">
                                                    Selected Clients
                                                </div>

                                                <telerik:RadListBox runat="server" ID="SelectedClientList"
                                                    OnInserted="SelectedClientList_Inserted" OnDeleted="SelectedClientList_Deleted"
                                                    DataSourceID="getStaffClient"
                                                    AllowDelete="True"
                                                    DataKeyField="clientID"
                                                    DataTextField="clientName"
                                                    DataValueField="clientID"
                                                    DataSortField="clientName"
                                                    AutoPostBackOnDelete="true"
                                                    Height="200px" Width="225px" Skin="Bootstrap">
                                                </telerik:RadListBox>

                                            </div>

                                            <asp:SqlDataSource ID="getStaffClient" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getStaffClient" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

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


                <div class="tab-pane" id="assignments">
                <asp:Panel ID="Panel1" runat="server">

                    <div class="widget stacked">
                        <div class="widget-content min-height">



                            <div class="form-horizontal">

                                <div class="row">
                                <div class="col-md-12" style="padding-left: 0px !important; padding-right: 0px !important;">
                                <div class="form-group">
                                    <label for="EnableAllSupplierCheckBox" class="col-sm-2 control-label">Suppliers Assigned:</label>
                                    <div class="col-sm-10" style="top: 6px;">

                                        <asp:CheckBox ID="EnableAllSupplierCheckBox" runat="server" Text="Enable All Suppliers" AutoPostBack="true" />

                                        <div id="SuppliersPanel" runat="server"  class="list-containers">

                                            <div class="list-container size-thin">
                                                <div class="title">
                                                    Available Suppliers
                                                </div>
                                                <telerik:RadListBox ID="SupplierList" runat="server"
                                                    TransferToID="SelectedSupplierList"
                                                    AllowTransferOnDoubleClick="True"
                                                    EnableDragAndDrop="True"
                                                    ButtonSettings-AreaWidth="35px" Height="200px" Width="225px"
                                                    DataKeyField="supplierID"
                                                    DataSortField="supplierName"
                                                    DataSourceID="getSupplierList"
                                                    DataTextField="supplierName"
                                                    DataValueField="supplierID"
                                                    AllowTransfer="True"
                                                    AutoPostBackOnTransfer="true"
                                                    Skin="Bootstrap">
                                                    <ButtonSettings ShowTransferAll="false" />

                                                </telerik:RadListBox>
                                            </div>


                                            <asp:SqlDataSource ID="getSupplierList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAvailableSupplierForStaff" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>


                                            <div class="list-container size-thin">

                                                <div class="title">
                                                    Selected Suppliers
                                                </div>

                                                <telerik:RadListBox runat="server" ID="SelectedSupplierList"
                                                    OnInserted="SelectedSupplierList_Inserted" OnDeleted="SelectedSupplierList_Deleted"
                                                    DataSourceID="getStaffSupplier"
                                                    AllowDelete="True"
                                                    DataKeyField="supplierID"
                                                    DataTextField="supplierName"
                                                    DataValueField="supplierID"
                                                    DataSortField="supplierName"
                                                    AutoPostBackOnDelete="true"
                                                    Height="200px" Width="225px" Skin="Bootstrap">
                                                </telerik:RadListBox>

                                            </div>


                                            <asp:SqlDataSource ID="getStaffSupplier" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getStaffSuppliers" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

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


                     <div class="tab-pane" id="markets">


                    <div class="widget stacked">
                        <div class="widget-content min-height">
                            <div class="form-horizontal">
                            <div class="row">
                                <div class="col-md-12">
                                <div class="form-group">
                                    <label for="EnableAllMarketsCheckBox" class="col-sm-2 control-label">Markets Assigned:</label>
                                    <div class="col-sm-10" style="top: 6px;">

                                        <asp:CheckBox ID="EnableAllMarketsCheckBox" runat="server" Text="Enable All Markets" AutoPostBack="true" />

                                        <div id="MarketsPanel" runat="server" class="list-containers">

                                            <div class="list-container size-thin">
                                                <div class="title">
                                                    Available Markets
                                                </div>

                                                <telerik:RadListBox ID="MarketList" runat="server"
                                                    TransferToID="SelectedMarketList"
                                                    AllowTransferOnDoubleClick="True"
                                                    EnableDragAndDrop="True"
                                                    ButtonSettings-AreaWidth="35px" Height="200px" Width="225px"
                                                    DataKeyField="marketID"
                                                    DataSortField="marketName"
                                                    DataSourceID="getMarketList"
                                                    DataTextField="marketName"
                                                    DataValueField="marketID"
                                                    AllowTransfer="True"
                                                    AutoPostBackOnTransfer="true"
                                                    Skin="Bootstrap">
                                                    <ButtonSettings ShowTransferAll="false" />

                                                </telerik:RadListBox>

                                            </div>

                                            <asp:SqlDataSource ID="getMarketList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAvailableMarketForStaff" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                            <div class="list-container size-thin">

                                                <div class="title">
                                                    Selected Markets
                                                </div>

                                                <telerik:RadListBox runat="server" ID="SelectedMarketList"
                                                    OnInserted="SelectedMarketList_Inserted" OnDeleted="SelectedMarketList_Deleted"
                                                    DataSourceID="getStaffMarket"
                                                    AllowDelete="True"
                                                    DataKeyField="marketID"
                                                    DataTextField="marketName"
                                                    DataValueField="marketID"
                                                    DataSortField="marketName"
                                                    AutoPostBackOnDelete="true"
                                                    Height="200px" Width="225px" Skin="Bootstrap">
                                                </telerik:RadListBox>

                                            </div>

                                            <asp:SqlDataSource ID="getStaffMarket" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getStaffMarket" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </div>


                                    </div>
                                </div>
                                </div>
                                </div>
                                </div>
                            </div>
                        </div>
                         </div>

                    <div class="tab-pane" id="teams">


                        <div class="widget stacked">
                            <div class="widget-content min-height">
                                <div class="form-horizontal">

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="EnableAllMarketsCheckBox" class="col-sm-2 control-label">Teams Assigned:</label>
                                                <div class="col-sm-5" style="top: 6px;">

                                                    <telerik:RadComboBox ID="TeamComboBox" runat="server" DataSourceID="GetTeamList" DataTextField="teamName" 
                                                        DataValueField="teamID" EmptyMessage="Select a Team" Width="400px" AppendDataBoundItems="true">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="None" Value="0" />
                                                        </Items>
                                                    </telerik:RadComboBox>

                                                   <%-- <telerik:RadListBox ID="TeamsListBox" runat="server" CheckBoxes="true" Width="100%" Font-Bold="false" DataSourceID="GetTeamList" 
                                                        DataTextField="teamName" DataValueField="teamID" Height="350px" >
                                                    </telerik:RadListBox>--%>

                                                    <p>Teams should be assigned to users who are in the Agency role.</p>

                                                    <p>Warning! Assigning a user to a team will limit their view of events to only events within the team.</p>

                                                    <asp:Button ID="btnUpdateTeams" runat="server" Text="Update"  CssClass="btn btn-primary pull-right" />

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
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                     <div class="tab-pane" id="password">


                    <div class="widget stacked">
                        <div class="widget-content min-height">

                            <div class="col-md-6">

                                <div class="form-horizontal">

                                            <asp:Label Text="Change Password" runat="server" Font-Bold="true" Font-Size="Large" />

                                            <br />

                                            <div class="form-group">
                                                <label for="FirstNameTextBox" class="col-sm-4 control-label">New Password: <span class="text-danger">*</span></label>
                                                <div class="col-sm-8" style="top: 6px;">

                                                    <asp:TextBox ID="NewPasswordTextBox" runat="server" CssClass="form-control" />

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="FirstNameTextBox" class="col-sm-4 control-label">Confirm: <span class="text-danger">*</span></label>
                                                <div class="col-sm-8" style="top: 6px;">

                                                    <asp:TextBox ID="ConfirmTextBox" runat="server" CssClass="form-control" />

                                            <asp:CompareValidator runat="server" ID="CompareValidator1" controltovalidate="ConfirmTextBox" controltocompare="NewPasswordTextBox"
                                                operator="Equal" errormessage="Must match the new password text box." CssClass="errorlabel" ValidationGroup="password" />

                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                                        ErrorMessage="Repeat the password please." CssClass="errorlabel" ControlToValidate="ConfirmTextBox"
                                                        Display="Dynamic" ValidationGroup="password"></asp:RequiredFieldValidator>

                                                </div>
                                            </div>

                                            <div class="form-group pull-right">
                                                <div class="col-sm-12">
                                                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" ValidationGroup="password" CausesValidation="true" />
                                                </div>
                                            </div>

                                    </div>
                            </div>

                            </div>
                        </div>
                         </div>
                </div>

                </div>


            </div>

        </div>

    </div>



</asp:Content>
