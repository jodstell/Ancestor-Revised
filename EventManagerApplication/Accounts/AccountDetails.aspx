<%@ Page Title="Account Details" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" MaintainScrollPositionOnPostback="true"
    CodeBehind="AccountDetails.aspx.vb" Inherits="EventManagerApplication.Account_Details" %>

<%@ Register Src="~/Accounts/UserControls/AccountInformationControl.ascx" TagPrefix="uc1" TagName="AccountInformationControl" %>
<%@ Register Src="~/Accounts/UserControls/AccountHoursControl.ascx" TagPrefix="uc1" TagName="AccountHoursControl" %>
<%@ Register Src="~/Accounts/UserControls/BrandTrackerControl.ascx" TagPrefix="uc1" TagName="BrandTrackerControl" %>
<%@ Register Src="~/Accounts/UserControls/ActivitiesControl.ascx" TagPrefix="uc1" TagName="ActivitiesControl" %>
<%@ Register Src="~/Accounts/UserControls/UpcomingEventsControl.ascx" TagPrefix="uc1" TagName="UpcomingEventsControl" %>
<%@ Register Src="~/Accounts/UserControls/PreviousEventsControl.ascx" TagPrefix="uc1" TagName="PreviousEventsControl" %>
<%@ Register Src="~/Accounts/UserControls/AccountDemographicsControl.ascx" TagPrefix="uc1" TagName="AccountDemographicsControl" %>
<%@ Register Src="~/Accounts/UserControls/AccountDetailsControl.ascx" TagPrefix="uc1" TagName="AccountDetailsControl" %>
<%--<%@ Register Src="~/Accounts/UserControls/AccountImagesControl.ascx" TagPrefix="uc1" TagName="AccountImagesControl" %>--%>
<%@ Register Src="~/Accounts/UserControls/AccountNotesControl.ascx" TagPrefix="uc1" TagName="AccountNotesControl" %>
<%@ Register Src="~/Accounts/UserControls/AccountContacts.ascx" TagPrefix="uc1" TagName="AccountContacts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .widget .widget-content {
            padding-top: 5px;
        }

        .nav-tabs, .nav-pills {
            margin-bottom: 1px;
        }

        .table th, .table td {
            border-top: none !important;
        }
    </style>

    <style>

.DropZone1 {

    width: 100%;
    height: 90px;
    background-color: #357A2B;
    border-color: #CCCCCC;
    float: left;
    text-align: center;
    font-size: 16px;
    color: white;
    margin-bottom: 25px;
}



.demo-container .RadAsyncUpload {
    margin-left: 250px;
    margin-bottom: 28px;
}



.demo-container .RadUpload .ruUploadProgress {
    width: 230px;
    display: inline-block;
    overflow: hidden;
    text-overflow: ellipsis;
}



.demo-container .ruFakeInput {
    width: 200px;
}

.btnbox {
    padding-top: 25px;
    text-align: right;
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
</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManagerProxy3" runat="server" ClientEvents-OnResponseEnd="formatCheckBox">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnUpload">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ButtonPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="ViewPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="UploadPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="PhotoListView" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="btnCancelUpload">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ButtonPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="ViewPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="UploadPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="PhotoListView" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="PhotoListView">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ViewPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="ViewPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ViewPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="AddPhotoButton">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ButtonPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="ViewPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="UploadPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>

</telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>


    <asp:HiddenField ID="LatitudeTextBox" runat="server" />
    <asp:HiddenField ID="LongtitudeTextBox" runat="server" />
    <asp:HiddenField ID="LocationTextBox" runat="server" />

    <script type='text/javascript' src='http://www.bing.com/mapspreview/sdk/mapcontrol?branch=experimental&callback=GetMap' async defer></script>


    <asp:Panel ID="Panel1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2 style="font-weight: bold;">Account Details</h2>
                    <ol class="breadcrumb">
                        <li><i class="fa fa-home" aria-hidden="true"></i><a href="/"> Dashboard</a></li>
                        <li><a href="/Accounts/ViewAccounts?LoadState=Yes" onclick="ShowLoadingPanel()">Accounts</a></li>
                        <li class="active">Account Details</li>
                    </ol>
                </div>

                <div class="col-md-6 detail">
                    Account Name:
                <asp:Label ID="AccountNameLabel" runat="server" Font-Bold="true" Font-Size="Large" />
                    <br />
                    Created Date:
                    <asp:Label ID="CreatedDateLabel" runat="server" Font-Bold="true" />
                    <br />
                    Last Update:
                    <asp:Label ID="LastUpdateLabel" runat="server" Font-Bold="true" />
                    <br />
                </div>

                <div class="col-md-6">
                    Account ID:
                <asp:Label ID="AccountIDLabel" runat="server" Font-Bold="true" /><br />
                    VpID: <asp:Label ID="VpidLabel" runat="server" Font-Bold="true" />
                </div>
            </div>
            <!-- /row -->

            <hr />

            <asp:Panel ID="DetailPanel" runat="server">

            <div class="row">

                <div class="col-md-12">

                    <h3 style="color: black; font-weight: bold;">Account Information
                    <asp:LoginView ID="LoginView_AddButton" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, Accounting">
                                <ContentTemplate>

                                    <div class="btn-group  pull-right" role="group" aria-label="...">
                                    <a href="/Accounts/ViewAccounts?LoadState=Yes" class="btn btn-md btn-default" onclick="ShowLoadingPanel()"><i class="fa fa-chevron-left" aria-hidden="true"></i> Go to Accounts</a>

                                    <%--<a href='/Events/NewEvent?AccountID=<%= Request.QueryString("AccountID") %>' class="btn btn-md btn-success"><i class="fa fa-plus"></i> Add New Event</a>--%>

                                    </div>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>

                    </h3>
                    <div class="bs-example">
                        <ul id="myTab" class="nav nav-tabs">
                            <li class="active"><a href="#information" data-toggle="tab">Information</a></li>
                            <li class=""><a href="#contacts" data-toggle="tab">Contacts</a></li>
                            <li class=""><a href="#hours" data-toggle="tab">Hours</a></li>
                            <li class=""><a href="#demographics" data-toggle="tab">Demographics</a></li>
                            <li class=""><a href="#details" data-toggle="tab">Details</a></li>
                            <li class=""><a href="#notes" data-toggle="tab">Notes</a></li>
                        </ul>
                    </div>

                    <div class="tab-content">

                        <!-- Information Tab -->
                        <div class="tab-pane fade active in" id="information">
                            <div class="widget stacked">

                                <div class="widget-content">

                                    <div class="col-md-6">
                                        <!-- start account information control -->
                                        <uc1:AccountInformationControl runat="server" ID="AccountInformationControl" />



<asp:LinqDataSource ID="getAccountInformation" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableUpdate="True" EntityTypeName="" TableName="tblAccounts" Where="accountID == @accountID">
    <WhereParameters>
        <asp:QueryStringParameter Name="accountID" QueryStringField="AccountID" Type="Int32" />
    </WhereParameters>
</asp:LinqDataSource>


                                        <!-- end account information control -->
                                    </div>

                                    <div id="mapColumn" class="col-md-6">

                                        <div class="widget stacked">

                                            <div class="widget-content">

                                                <div style="margin-bottom: 10px;">
                                                    <div>

                                                        <asp:Label ID="AccountNameLabel1" Font-Bold="true" Font-Size="Large" runat="server" />
                                                    </div>
                                                    <div>
                                                        <asp:Label ID="AccountAddressLabel1" runat="server" />
                                                    </div>
                                                </div>


                                                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                                <asp:Panel ID="MapErrorPanel" runat="server" Visible="false">
                                                    <div class="alert alert-danger" role="alert"><strong>There was a problem loading the map!</strong><br />The location coordinates are not correct.  Use the form below to make corrections the address.</div>

                                                    <div class="widget stacked">

                                            <div class="widget-content">

                                                <div class="form-horizontal">
                                                   <p>Fields marked with asterisk (<span class="text-danger">*</span>) are required.</p>

                                                <div class="form-group">
                    <label for="streetAddress1TextBox" class="col-sm-3 control-label">Address 1 <span class="text-danger">*</span></label>
                    <div class="col-sm-7">
                        <asp:TextBox ID="streetAddress1TextBox" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="streetAddress1TextBoxRequiredFieldValidator" runat="server"
                                                            ErrorMessage="This field can not be blank!" CssClass="errorlabel" ControlToValidate="streetAddress1TextBox"
                                                            Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                        <p class="help-block">The address can not contain PO Boxes. This field is required!</p>

                    </div>
                </div>

                <div class="form-group">
                    <label for="streetAddress2TextBox" class="col-sm-3 control-label">Address 2</label>
                    <div class="col-sm-7">
                        <asp:TextBox ID="streetAddress2TextBox" runat="server" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="cityTextBox" class="col-sm-3 control-label">City <span class="text-danger">*</span></label>
                    <div class="col-sm-7">
                        <asp:TextBox ID="cityTextBox" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                            ErrorMessage="This field can not be blank!" CssClass="errorlabel" ControlToValidate="cityTextBox"
                                                            Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                        <p class="help-block">This is a required field!</p>
                    </div>
                </div>

                <div class="form-group">
                    <label for="stateTextBox" class="col-sm-3 control-label">State <span class="text-danger">*</span></label>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="DropDownListState" runat="server" CssClass="form-control">
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

                    </div>
                </div>

                <div class="form-group">
                    <label for="zipCodeTextBox" class="col-sm-3 control-label">Zip <span class="text-danger">*</span></label>
                    <div class="col-sm-7">
                        <asp:TextBox ID="zipCodeTextBox" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                            ErrorMessage="This field can not be blank!" CssClass="errorlabel" ControlToValidate="zipCodeTextBox"
                                                            Display="Dynamic" ValidationGroup="information"></asp:RequiredFieldValidator>
                        <p class="help-block">The zip code must contain 5 didgets. This is a required field!</p>
                    </div>
                </div>

                                                    <asp:Label ID="Label1" runat="server" />

                                                    <br />

                                                    <asp:Label ID="Label2" runat="server" />

                                                    <div class="form-group">
                    <label for="zipCodeTextBox" class="col-sm-3 control-label"></label>
                    <div class="col-sm-7">
                        <asp:Button ID="btnFixCoordinates" runat="server" Text="Fix Coordinates" CssClass="btn btn-success" ValidationGroup="information" CausesValidation="true" />
                    </div>
                </div>



</div>

                                                </div>
                                                        </div>
                                                </asp:Panel>
                                                    </telerik:RadAjaxPanel>

                                                 <asp:Panel ID="MapPanel" runat="server" Visible="true">
                                                <div id='mapDiv' style="position: relative; width: 100%; height: 50%;"></div>
                                                     </asp:Panel>

                                                <asp:Label ID="geoLocationLabel" runat="server" />
                                                <asp:Button ID="btnUpdateCoordinates" runat="server" Text="Update Coordinates" CssClass="btn btn-link pull-right" />




                                            </div>
                                        </div>

                                        <%--<div style="margin-top: 5px;">
                                            <asp:FormView ID="SocialInformationForm" runat="server" DataSourceID="getSocial">
                                                <ItemTemplate>
                                                    <div>
                                                        <label>Website:</label>
                                                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("website")%>' Target="_blank" Text='<%# Eval("website")%>' />

                                                    </div>
                                                    <div>
                                                        <label>Facebook:</label>
                                                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("facebook")%>' Target="_blank" Text='<%# Eval("facebook")%>' />
                                                    </div>
                                                    <div>
                                                        <label>Twitter:</label>
                                                        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# Eval("twitter")%>' Target="_blank" Text='<%# Eval("twitter")%>' />
                                                    </div>
                                                    <div>
                                                        <label>Yelp:</label>
                                                        <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl='<%# Eval("yelp") %>' Target="_blank" Text='<%# Eval("yelp") %>' />
                                                    </div>
                                                </ItemTemplate>
                                            </asp:FormView>

                                            <asp:LinqDataSource ID="getSocial" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblAccounts" Where="accountID == @accountID">
                                                <WhereParameters>
                                                    <asp:QueryStringParameter Name="accountID" QueryStringField="AccountID" Type="Int32" />
                                                </WhereParameters>
                                            </asp:LinqDataSource>


                                        </div>--%>

                                    </div>
                                </div>

                            </div>




                        </div>

                        <!-- Contacts Tab -->
                        <div class="tab-pane fade" id="contacts">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <!-- start account contacts control -->
                                    <uc1:AccountContacts runat="server" ID="AccountContacts" />
                                    <!-- end account contacts control -->
                                </div>
                            </div>
                        </div>

                        <!-- Hours Tab -->
                        <div class="tab-pane fade" id="hours">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <div class="">
                                        <!-- start account hours control -->
                                        <uc1:AccountHoursControl runat="server" ID="AccountHoursControl" />
                                        <!-- end account hours control -->

                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Demographics Tab -->
                        <div class="tab-pane fade" id="demographics">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <!-- start account demographics control -->
                                    <uc1:AccountDemographicsControl runat="server" ID="AccountDemographicsControl" />
                                    <!-- end account demographics control -->
                                </div>
                            </div>
                        </div>

                        <!-- Details Tab -->
                        <div class="tab-pane fade" id="details">
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <div class="col-md-5">
                                        <!-- start account details control -->
                                        <uc1:AccountDetailsControl runat="server" ID="AccountDetailsControl" />
                                        <!-- end account details control -->
                                    </div>


                                    <div class="col-md-7" id="accountPhotosControl" runat="server">
                                        <!-- start account images control -->
                                        <%--<uc1:AccountImagesControl runat="server" ID="AccountImagesControl" />--%>
                                        <!-- end account images control -->



                                        <asp:Panel ID="ButtonPanel" runat="server">
<div class="pull-right" style="margin-bottom:20px">
            <asp:LinkButton ID="AddPhotoButton" runat="server" CssClass="btn btn-success btn-sm" Style="margin: 12px 0 12px 0"><i class="fa fa-plus"></i> Add New Photo</asp:LinkButton>

                </div>
</asp:Panel>

                                        <div class="widget stacked" style="margin-top:25px;">
    <div id="maindiv" class="widget-content" style="padding: 25px">

                                        <asp:Panel ID="UploadPanel" runat="server" Visible="false">
        <div class="demo-container size-wide">
            <h2>Photos</h2>
        <p>
            Upload your photos here using the file uploader or the drop box below.
        </p>

        <telerik:RadAsyncUpload runat="server" ID="RadAsyncUpload1" MultipleFileSelection="Automatic" DropZones=".DropZone1,#DropZone2" />


        <div class="DropZone1">

            <br />
            <br />

            <p>Drop Files Here</p>

        </div>

            <div class="btnbox">
            <asp:Button ID="btnUpload" runat="server" Text="Upload Photos" CssClass="btn btn-md btn-primary" /> <asp:Button ID="btnCancelUpload" runat="server" Text="Cancel" CssClass="btn btn-md btn-default" />
</div>

    </div>
</asp:Panel>


        <asp:Panel ID="ViewPanel" runat="server">

            <asp:Label ID="errorLabel" runat="server" />



            <div class="row">
            <telerik:RadListView runat="server" ID="PhotoListView" DataSourceID="getImageList" Skin="Bootstrap"
                                            AllowPaging="true" DataKeyNames="photoID" OverrideDataSourceControlSorting="true">

                                            <LayoutTemplate>


                                                    <div class="clearFix"></div>

                                                    <asp:Panel ID="itemPlaceholder" runat="server">
                                                    </asp:Panel>

                                                    <div class="clearFix">
                                                    </div>


                                            </LayoutTemplate>

                <EmptyDataTemplate>
                    <div class="RadListView RadListView_Default">

                        <div class="alert alert-warning" role="alert">There are no photos to be displayed.  To add a new items click on the <strong>Add New Photos</strong> button above.</div>

                    </div>
                </EmptyDataTemplate>

                                            <ItemTemplate>

                                                <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                     <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                DataValue='<%#Eval("Image") %>' Height='130px' Width="130px"
                                                 ResizeMode="Crop" AlternateText="Click to view larger image" ToolTip="Click to view larger image" onclick='<%#CreateWindowScript(Eval("accountID"), Eval("photoID")) %>' />

                                                    <div style="margin-top: -30px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">
                                                        <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" Text="Delete" CssClass="txt" />

                                                    </div>
                                                </div>
                                            </ItemTemplate>

                                            <AlternatingItemTemplate>

                                                <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">
                                         <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                        DataValue='<%#Eval("Image") %>' Height='130px' Width="130px"
                                                        ResizeMode="Crop" AlternateText="Click to view larger image" ToolTip="Click to view larger image" onclick='<%#CreateWindowScript(Eval("accountID"), Eval("photoID")) %>' />
                                                    <div style="margin-top: -30px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">

                                                        <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" Text="Delete" CssClass="txt" />

                                                    </div>

                                                </div>

                                            </AlternatingItemTemplate>
                                        </telerik:RadListView>
                </div>

        <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT * FROM [tblAccountPhoto] WHERE ([accountID] = @accountID)">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="AccountID" Name="accountID" Type="Int32"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>


        </asp:Panel>

        </div>
                                            </div>

        <telerik:RadWindowManager runat="server" ID="RadWindowManager1">

        <Windows>

            <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" Skin="Bootstrap"
                Width="675px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                Modal="true">
            </telerik:RadWindow>

        </Windows>

    </telerik:RadWindowManager>

                                        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">


<script>

    (function () {

        var $;

        var demo = window.demo = window.demo || {};



        demo.initialize = function () {

            $ = $telerik.$;



            if (!Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {

                $(".qsf-demo-canvas").html("<strong>Your browser does not support Drag and Drop. Please take a look at the info box for additional information.</strong>");

            }

            else {

                $(document).bind({ "drop": function (e) { e.preventDefault(); } });



                var dropZone1 = $(document).find(".DropZone1");

                dropZone1.bind({ "dragenter": function (e) { dragEnterHandler(e, dropZone1); } })

                         .bind({ "dragleave": function (e) { dragLeaveHandler(e, dropZone1); } })

                         .bind({ "drop": function (e) { dropHandler(e, dropZone1); } });



                var dropZone2 = $(document).find("#DropZone2");

                dropZone2.bind({ "dragenter": function (e) { dragEnterHandler(e, dropZone2); } })

                         .bind({ "dragleave": function (e) { dragLeaveHandler(e, dropZone2); } })

                         .bind({ "drop": function (e) { dropHandler(e, dropZone2); } });

            }

        };



        function dropHandler(e, dropZone) {

            dropZone[0].style.backgroundColor = "#357A2B";

        }



        function dragEnterHandler(e, dropZone) {

            var dt = e.originalEvent.dataTransfer;

            var isFile = (dt.types != null && (dt.types.indexOf ? dt.types.indexOf('Files') != -1 : dt.types.contains('application/x-moz-file')));

            if (isFile || $telerik.isSafari5 || $telerik.isIE10Mode || $telerik.isOpera)

                dropZone[0].style.backgroundColor = "#000000";

        }



        function dragLeaveHandler(e, dropZone) {

            if (!$telerik.isMouseOverElement(dropZone[0], e.originalEvent))

                dropZone[0].style.backgroundColor = "#357A2B";

        }





    })();
</script>


<script>

        function containerMouseover(sender) {
            sender.getElementsByTagName("div")[0].style.display = "";
        }

        function containerMouseout(sender) {
            sender.getElementsByTagName("div")[0].style.display = "none";
        }
    </script>

    </telerik:RadScriptBlock>




                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Notes Tab -->
                        <div class="tab-pane fade" id="notes">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <!-- start account notes control -->
                                    <uc1:AccountNotesControl runat="server" ID="AccountNotesControl" />
                                    <!-- end account notes control -->
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- End Tab Content -->

                    <asp:LinqDataSource ID="getAccountDetail" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblAccounts" Where="accountID == @accountID">
                        <WhereParameters>
                            <asp:QueryStringParameter DefaultValue="228679" Name="accountID" QueryStringField="AccountID" Type="Int32" />
                        </WhereParameters>
                    </asp:LinqDataSource>

                </div>

            </div>


            <div class="row" id="brandTracker" runat="server">

                <div class="col-md-12">
                    <h3 style="color: black; font-weight: bold;">Brand Tracker</h3>
                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="brandtracker">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <uc1:BrandTrackerControl runat="server" ID="BrandTrackerControl" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>


            <div class="row" id="activitieslist" runat="server">
                <div class="col-md-12">
                    <h3 style="color: black; font-weight: bold;">Activities</h3>
                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="activities">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <uc1:ActivitiesControl runat="server" ID="ActivitiesControl" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <h3 style="color: black; font-weight: bold;">Events</h3>
                    <div class="bs-example">
                        <ul id="myTab2" class="nav nav-tabs">
                            <li class="active"><a href="#upcoming" data-toggle="tab">Upcoming <span class="badge">
                                <asp:Label ID="UpcomingEventsCountLabel" runat="server" /></span></a></li>
                            <li class=""><a href="#previous" data-toggle="tab">Previous <span class="badge">
                                <asp:Label ID="PreviousEventsCountLabel" runat="server" /></span></a></li>
                        </ul>
                    </div>

                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="upcoming">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <uc1:UpcomingEventsControl runat="server" ID="UpcomingEventsControl" />
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="previous">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <uc1:PreviousEventsControl runat="server" ID="PreviousEventsControl" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            </asp:Panel>


        </div>
    </asp:Panel>



    <script type="text/javascript">
        var map = null;
        var trafficLayer;
        var directionsManager;
        var directionsErrorEventObj;
        var directionsUpdatedEventObj;
        var a = null;
        var b = null;

        $(document).ready(function () {

            GetMap();

        });

        function GetMap() {

             var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'

            // Initialize the map
            map = new Microsoft.Maps.Map(document.getElementById("mapDiv"),
                       {
                           credentials: bingkey,
                       });

            loadTrafficModule();
            addPushpinWithOptions();
        }

        $("#tab1").click(function () {

            clearDisplay();
            GetMap();
            $('#routePanel').hide();

        });

        $("#tab2").click(function () {

            $('#accountTab a:first').tab('show');

            $('#tab1').removeClass('active');
            $('#tab2').addClass('active');
            $('#routePanel').show();

        });




        function addPushpinWithOptions() {
            var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();

            var offset = new Microsoft.Maps.Point(0, 5);
            var pushpinOptions = { text: '', visible: true, textOffset: offset };
            var pushpin = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(lat, long), pushpinOptions);
            map.setView({ center: new Microsoft.Maps.Location(lat, long), zoom: 12 });
            map.entities.push(pushpin);
        }



        function createDirectionsManager() {
            var displayMessage;
            if (!directionsManager) {
                directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
                displayMessage = 'Directions Module loaded\n';
                displayMessage += 'Directions Manager loaded';
            }
            //  alert(displayMessage);
            directionsManager.resetDirections();
            directionsErrorEventObj = Microsoft.Maps.Events.addHandler(directionsManager, 'directionsError', function (arg) { alert(arg.message) });
            directionsUpdatedEventObj = Microsoft.Maps.Events.addHandler(directionsManager, 'directionsUpdated', function () { alert('Directions updated') });
        }

      <%--  function createDrivingRoute() {

            var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();

            var FromAddress = $('#<%=txtFromAddress.ClientID%>').val();
            var ToAddress = $('#<%=AccountAddressLabel1.ClientID%>').text();
            var ToLocation = $('#<%=LocationTextBox.ClientID%>').val();

            if (!directionsManager) { createDirectionsManager(); }
            directionsManager.resetDirections();
            // Set Route Mode to driving
            directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
            var seattleWaypoint = new Microsoft.Maps.Directions.Waypoint({ address: FromAddress });
            directionsManager.addWaypoint(seattleWaypoint);
            var tacomaWaypoint = new Microsoft.Maps.Directions.Waypoint({ address: ToLocation, location: new Microsoft.Maps.Location(lat, long) });
            directionsManager.addWaypoint(tacomaWaypoint);
            // Set the element in which the itinerary will be rendered
            directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('directionsItinerary') });
            alert('Calculating directions...');
            directionsManager.calculateDirections();
        }--%>

        function createDirections() {

            if (!directionsManager) {
                Microsoft.Maps.loadModule('Microsoft.Maps.Directions', { callback: createDrivingRoute });
            }
            else {
                createDrivingRoute();
            }
        }


        /// reset

        function resetDirections() {
            if (!directionsManager) { createDirectionsManager(); }
            directionsManager.resetDirections();
            // alert('Directions cleared (Waypoints cleared, map/itinerary cleared, request and render options reset to default values)');
        }

        if (!directionsManager) {
            Microsoft.Maps.loadModule('Microsoft.Maps.Directions', { callback: resetDirections });
        }
        else {
            resetDirections();
        }

        // clear display

        function clearDisplay() {
            if (!directionsManager) { createDirectionsManager(); }
            directionsManager.clearDisplay();
            // alert('Directions cleared (map/itinerary cleared, Waypoints preserved, request and render options preserved)');
        }

        if (!directionsManager) {
            Microsoft.Maps.loadModule('Microsoft.Maps.Directions', { callback: clearDisplay });
        }
        else {
            clearDisplay();
        }

        // show traffic layer

        function trafficModuleLoaded() {
            setMapView();
        }
        function loadTrafficModule() {
            Microsoft.Maps.loadModule('Microsoft.Maps.Traffic', { callback: trafficModuleLoaded });
        }
        function setMapView() {
            var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();

            map.setView({ zoom: 10, center: new Microsoft.Maps.Location(lat, long) })
        }

        function showTrafficLayer() {

            trafficLayer = new Microsoft.Maps.Traffic.TrafficLayer(map);
            // show the traffic Layer
            trafficLayer.show();
            $("#hideTraffic").show();
            $("#showTraffic").hide();
        }


        // hide traffic layer

        function hideTrafficLayer() {
            // hide the traffic Layer
            trafficLayer.hide();
            $("#hideTraffic").hide();
            $("#showTraffic").show();
        }


    </script>

 <script src="/Scripts/jquery-1.10.2.js"></script>

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






</asp:Content>
