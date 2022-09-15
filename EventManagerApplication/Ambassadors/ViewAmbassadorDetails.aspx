<%@ Page Title="Ambassador Details" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewAmbassadorDetails.aspx.vb" MaintainScrollPositionOnPostback="true" Inherits="EventManagerApplication.ViewAmbassadorDetails" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

        @media screen and (min-width:1000px) and (max-width:1470px) {
	        .col-md-2 {
            width: 29.667%;
            }
        }

         @media screen and (min-width:760px) and (max-width:1000px) {
	        .specialWidth {
            width: 33%;
            }
        }

        .overflow {
    height: 375px;
    overflow: auto;
}

        
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">

    <AjaxSettings>

        <telerik:AjaxSetting AjaxControlID="ActiveListPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ActiveListPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="btnUpdate">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ChangePasswordPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="btnCancel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ChangePasswordPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        
        <telerik:AjaxSetting AjaxControlID="btnChangePass">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
                <telerik:AjaxUpdatedControl ControlID="ChangePasswordPanel" LoadingPanelID="RadAjaxLoadingPanel2" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>

</telerik:RadAjaxManager>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

 <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Transparency="30" MinDisplayTime="300">

            <div class="loadingspinner" >
                 <i id="Image1" class="fa fa-refresh fa-spin-2x fa-2x fa-fw" style="color:#0670cd;"></i>
            </div>

        </telerik:RadAjaxLoadingPanel>


    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <script type="text/javascript">
        // close the div in 5 secs
        window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version
            $("#messageHolder").fadeOut("slow", null);
        }
    </script>

    </telerik:RadScriptBlock>

    <link href="viewAmbassador.css" rel="stylesheet" />

    <asp:Panel ID="Panel1" runat="server">

    <div class="container min-height">

        <div class="row">
            <div id="messageHolder">
                <asp:Literal ID="msgLabel2" runat="server" />
            </div>
        </div>


        <div class="row">
            <div class="col-xs-12">
                <h2>Brand Ambassador Details</h2>
            </div>

            <div class="col-md-6 detail">
                Name:
                <asp:Label ID="AccountNameLabel" Font-Size="Large" runat="server" Font-Bold="true" />
                <br />
                Created Date:
                    <asp:Label ID="CreatedDateLabel" runat="server" Font-Bold="true" />
                <br />
                Last Update:
                    <asp:Label ID="LastUpdateLabel" runat="server" Font-Bold="true" />
                <br />
                Last Login:
                <asp:Label ID="ActivityDateLabel" runat="server" Font-Bold="true" />
            </div>



            <div class="col-md-6">

                <asp:Panel ID="ButtonPanel" runat="server">
                                         <div class="btn-group pull-right" role="group">
                                            <asp:LinkButton ID="btnReactivate" runat="server" CssClass="btn btn-success">Reactivate</asp:LinkButton>
                                            <a href="EditAmbassador?UserID=<%= Request.QueryString("UserID") %>" class="btn btn-default"><i class="fa fa-pencil"></i> Edit Ambassador</a>
                                            <asp:LinkButton ID="btnChangePass" runat="server" CssClass="btn btn-default">Change Password</asp:LinkButton>
                                            <asp:LinkButton ID="btnDeleteAmbassador" runat="server" CssClass="btn btn-danger" OnClientClick="javascript:if(!confirm('This action will delete the selected ambassador and assignments. Are you sure?')){return false;}"><i class="fa fa-trash" aria-hidden="true"></i>
                             Delete</asp:LinkButton>
                                            </div>

               </asp:Panel>
            </div>

        </div>

<asp:Panel ID="MainPanel" runat="server">

    <br />
        <asp:Label ID="msgLabel" runat="server" />

        <hr />

        

        <div class="row">

            <div class="col-sm-12">

                <h3 style="color: black; font-weight: bold;">Ambassador Information</h3>

                <div class="pull-right secondarytab"><a href="/ambassadors/ActiveList?LoadState=Yes" onclick="ShowLoadingPanel()" class="btn btn-default" style="line-height: 1.4;"><i class="fa fa-chevron-left" aria-hidden="true"></i> Go to Brand Ambassadors</a>
                </div>
                <br />
                <br />

                <div class="bs-example">
                    <ul id="myTab" class="nav nav-tabs">
                        <li class="active"><a href="#overview" data-toggle="tab">Overview</a></li>
                        <li class=""><a href="#contactInformation" data-toggle="tab">Contact Information</a></li>
                        <li class=""><a href="#appearance" data-toggle="tab">Appearance</a></li>
                        <li class=""><a href="#availability" data-toggle="tab">Availability</a></li>
                        <li class=""><a href="#licenses" data-toggle="tab">Licenses & Documents</a></li>
                        <li class=""><a href="#assignments" data-toggle="tab">Assignments</a></li>
                        <li class=""><a href="#notes" data-toggle="tab">Notes</a></li>
                    </ul>
                </div>

                <div class="tab-content">
                    <div class="tab-pane fade active in" id="overview">
                        <div class="widget stacked">
                            <div class="widget-content sm-height">

                                <h3>Overview</h3>
                                <hr />
                                <div class="ambinfo1">

                                    <div class="col-md-1" >

                                        <asp:Repeater ID="headshot" runat="server" DataSourceID="getHeadShot1">
                                            <ItemTemplate>
                                                <telerik:RadBinaryImage ID="thumbnailImage" runat="server" CssClass="thumbnail"
                                                    AlternateText="Click to view larger image" ToolTip="Click to view larger image"
                                                    DataValue='<%#IIf(TypeOf (Eval("headShot_thumbnail")) Is DBNull, Nothing, Eval("headShot"))%>'
                                                    Height="120px" Width="120px" ResizeMode="Crop"  onclick='<%#CreateWindowScript(Eval("userID"), 1)%>' />

                                            </ItemTemplate>
                                        </asp:Repeater>

                                        <asp:SqlDataSource runat="server" ID="getHeadShot1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                            SelectCommand="SELECT [userID], [headShot_thumbnail], [headShot], [bodyShot] FROM [tblAmbassadorPhoto] WHERE ([userID] = @userID)">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>


                                    </div>

                                    <div class="col-md-2">

                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="FirstNameTextBox" class="col-sm-7 control-label">First Name:</label>
                                                <div class="col-sm-5" style="top: 6px;">

                                                    <asp:Label ID="FirstName" runat="server" />

                                                </div>
                                            </div>


                                            <div class="form-group">
                                                <label for="NicknameTextBox" class="col-sm-7 control-label">Middle Name:</label>
                                                <div class="col-sm-5" style="top: 6px;">

                                                    <asp:Label ID="Nickname" runat="server" />

                                                </div>
                                            </div>


                                            <div class="form-group">
                                                <label for="LastNameTextBox" class="col-sm-7 control-label">Last Name:</label>
                                                <div class="col-sm-5" style="top: 6px;">

                                                    <asp:Label ID="LastName" runat="server" />

                                                </div>
                                            </div>
                                            

                                        </div>

                                    </div>

                                    <div class="col-md-4">

                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="DateofBirthTextBox" class="col-sm-7 control-label">Date of Birth:</label>
                                                <div class="col-sm-5" style="top: 6px;">

                                                    <asp:Label ID="DateofBirth" runat="server" />

                                                </div>


                                            </div>


                                            <div class="form-group">
                                                <label for="Gender" class="col-sm-7 control-label">Gender:</label>
                                                <div class="col-sm-5" style="top: 6px;">

                                                    <asp:Label ID="Gender" runat="server" />

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="Citizen" class="col-sm-7 control-label">U.S. Citizen:</label>
                                                <div class="col-sm-5" style="top: 6px;">

                                                    <asp:Label ID="Citizen" runat="server" />

                                                </div>
                                            </div>

                                        </div>

                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="PortalLoginLabel" class="col-sm-7 control-label">Status:</label>
                                                <div class="col-sm-5" style="top: 6px;">
                                                    <asp:Label ID="StatusLabel" runat="server" />
                                                </div>
                                            </div>

                                             <div class="form-group">
                                                <label for="PortalLoginLabel" class="col-sm-7 control-label">Portal Login:</label>
                                                <div class="col-sm-5" style="top: 6px;">
                                                    <asp:Label ID="PortalLoginLabel" runat="server" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="PasswordLabel" class="col-sm-7 control-label">Portal Password:</label>
                                                <div class="col-sm-5" style="top: 6px;">
                                                    <asp:Label ID="PasswordLabel" runat="server" />
                                                </div>
                                            </div>
                                    </div>
                                </div>

                                    <div class="col-md-2">
                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label for="CheckBox1" class="col-sm-8 control-label">Email Confirmed:</label>
                                                <div class="col-sm-4">
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Enabled="false" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="AddressVerifiedCheckBox" class="col-sm-8 control-label">Address Verified:</label>
                                                <div class="col-sm-4">
                                                    <asp:CheckBox ID="AddressVerifiedCheckBox" runat="server"  Enabled="false" />
                                                </div>
                                            </div>
                                        </div>

                                        </div>

                                </div>

                                </div>
                            </div>
                        </div>                                        
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="contactInformation">
                        <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Contact Information</h3>
                                <hr />
                                <div class="ambinfo1">
                                    <div class="col-md-4">

                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label for="Address1TextBox" class="col-sm-5 control-label">Address 1:</label>
                                                <div class="col-sm-7" style="top: 6px;">

                                                    <asp:Label ID="Address1" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="Address2TextBox" class="col-sm-5 control-label">Address 2:</label>
                                                <div class="col-sm-7" style="top: 6px;">
                                                    <asp:Label ID="Address2" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="CityTextBox" class="col-sm-5 control-label">City:</label>
                                                <div class="col-sm-7" style="top: 6px;">
                                                    <asp:Label ID="City" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>

                                                                                        <div class="form-group">
                                                <label for="State" class="col-sm-5 control-label">State:</label>
                                                <div class="col-sm-7" style="top: 6px;">
                                                    <asp:Label ID="State" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="ZipTextBox" class="col-sm-5 control-label">Zip:</label>
                                                <div class="col-sm-7" style="top: 6px;">
                                                    <asp:Label ID="Zip" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>


                                        </div>

                                    </div>
                                    <div class="col-md-7">

                                        <div class="form-horizontal">

                                           <div class="form-group">
                                                <label for="PhoneNumberTextBox" class="col-sm-5 control-label">Phone Number:</label>
                                                <div class="col-sm-7" style="top: 6px;">
                                                    <asp:Label ID="PhoneNumber" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="EmailAddressTextBox" class="col-sm-5 control-label">Email Address:</label>
                                                <div class="col-sm-7" style="top: 6px;">
                                                    <asp:Label ID="EmailAddress" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>



                                        </div>

                                    </div>
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="appearance">
                        <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <div class="ambinfo1">
                                    <h3>Appearance</h3>
                                    <hr />
                                    <div class="col-md-4">

                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="Height" class="col-sm-4 control-label">Height:</label>
                                                <div class="col-sm-8" style="top: 6px;">
                                                    <asp:Label ID="Height" runat="server" />

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="Weight" class="col-sm-4 control-label">Weight:</label>
                                                <div class="col-sm-8" style="top: 6px;">
                                                    <asp:Label ID="Weight" runat="server" />

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="HairColor" class="col-sm-4 control-label">Hair Color:</label>
                                                <div class="col-sm-8" style="top: 6px;">
                                                    <asp:Label ID="HairColor" runat="server" />

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="EyeColor" class="col-sm-4 control-label">Eye Color:</label>
                                                <div class="col-sm-8" style="top: 6px;">
                                                    <asp:Label ID="EyeColor" runat="server" />

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="Piercings" class="col-sm-4 control-label">Piercings:</label>
                                                <div class="col-sm-8" style="top: 6px;">
                                                    <asp:Label ID="Piercings" runat="server" />
                                                </div>
                                            </div>

                                        </div>

                                    </div>

                                    <div class="col-md-2">
                                        <asp:Repeater ID="bodyShot" runat="server" DataSourceID="getHeadShot1">
                                            <ItemTemplate>
                                                Headshot Image<br />


                                                <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail"
                                                    DataValue='<%#IIf(TypeOf (Eval("headShot_thumbnail")) Is DBNull, Nothing, Eval("headShot"))%>'
                                                    Height="150px" Width="150px" ResizeMode="Fit" onclick='<%#CreateWindowScript(Eval("userID"), 1)%>'
                                                    AlternateText="Click to view larger image" ToolTip="Click to view larger image" />

                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="getHeadShot1">
                                            <ItemTemplate>
                                                Body Shot Image<br />

                                                <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail"
                                                    DataValue='<%#IIf(TypeOf (Eval("bodyShot")) Is DBNull, Nothing, Eval("bodyShot"))%>'
                                                    Height="150px" Width="150px" ResizeMode="Fit" onclick='<%#CreateWindowScript(Eval("userID"), 2)%>'
                                                    AlternateText="Click to view larger image" ToolTip="Click to view larger image" />

                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="availability">
                        <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Availablity</h3>
                                <hr />
                                <div class="ambinfo1">
                                    <div class="form-horizontal">


                                        <div class="col-md-4">

                                            <div class="form-group">
                                                <label for="AvailabilityDate" class="col-sm-7 control-label">Availability Date:</label>
                                                <div class="col-sm-5" style="top: 9px;">

                                                    <asp:Label ID="AvailabilityDate" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="ReliableTransportation" class="col-sm-7 control-label" style="top: 6px;">Reliable transportation:</label>
                                                <div class="col-sm-5" style="top: 9px;">
                                                    <asp:Label ID="ReliableTransportation" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>

                                             <div class="form-group">
                                                <label for="LGBTAccounts" class="col-sm-7 control-label" style="top: 6px;">Can work LGBT Accounts:</label>
                                                <div class="col-sm-5" style="top: 6px;">
                                                    <asp:Label ID="LGBTAccounts" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="WillingMiles" class="col-sm-7 control-label">
                                                    Distance from event:</label>
                                                <div class="col-sm-5" style="top: 9px;">
                                                    <asp:Label ID="WillingMiles" runat="server" /> miles

                                                </div>
                                            </div>


                                            </div>

                                        <div class="col-md-4">

                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="Smartphone" class="col-sm-7 control-label">Do you have a Smartphone:</label>
                                                <div class="col-sm-5" style="top: 6px;">
                                                    <asp:Label ID="Smartphone" runat="server" />

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="SmartphoneOS" class="col-sm-7 control-label">Smartphone OS:</label>
                                                <div class="col-sm-5" style="top: 6px;">
                                                    <asp:Label ID="SmartphoneOS" runat="server" />

                                                </div>
                                            </div>



                                        </div>

                                    </div>

                                    </div>




                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="licenses">
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
                                                </td>
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
                                        <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                        <asp:Parameter DefaultValue="Resume" Name="category" Type="String"></asp:Parameter>
                                    </WhereParameters>
                                </asp:LinqDataSource>




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
                                            <td><a href='DocumentsHandler.aspx?fileID=<%# Eval("ambassadorFileID") %>'><%# Eval("documentTitle") %></td>
                                            <td><%# Eval("documentName") %></td>
                                            <td><%# Eval("dateUploaded", "{0:d}") %></td>
                                            <td><%# Eval("expirationDate", "{0:d}") %></td>
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


                                    </div>

                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="assignments">
                        <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Assignments</h3>
                                <hr />
                                <div class="">
                                         <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="TypeofBrandstoWork" class="col-sm-5 control-label">Team:</label>
                                                <div class="col-sm-7">


                                                        <asp:Label ID="lblTeam" runat="server"></asp:Label>



                                                    <%--<asp:Repeater ID="BrandCategoryList" runat="server" DataSourceID="getAmabassadorBrands">
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
                                                    </asp:Repeater>--%>



                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getAmabassadorBrands" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="ambassadorBrandsID" TableName="qryAmbassodorBrandTypeByUsers" Where="userName == @userName">
                                                        <WhereParameters>
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userName" Type="String"></asp:QueryStringParameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>
                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getAmbassador" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblAmbassadorBrandCategoryTypes" Where="userName == @userName">
                                                        <WhereParameters>
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userName" Type="String"></asp:QueryStringParameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>

                                                </div>
                                            </div>


                                             <%--<div class="form-group">
                                                <label for="TypeofPromotions" class="col-sm-5 control-label">Type of promotions:</label>
                                                <div class="col-sm-7">

                                                    <asp:Repeater ID="PromotionCategoryList" runat="server" DataSourceID="getAmbassadorEventType">
                                                        <HeaderTemplate>
                                                            <ul class="special">
                                                        </HeaderTemplate>

                                                        <ItemTemplate>
                                                            <li>

                                                                <asp:Label ID="Label1" runat="server" Text='<%# getEventCategoryName(Eval("eventTypeID")) %>'></asp:Label></li>


                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </ul>
                                                        </FooterTemplate>
                                                    </asp:Repeater>

                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getAmbassadorEventType" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblAmbassadorEventTypes" Where="userName == @userName">
                                                        <WhereParameters>
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userName" Type="String"></asp:QueryStringParameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>


                                                </div>
                                            </div>--%>


                                        </div>



                                        <div class="col-md-4">

                                            <div class="form-group">
                                                <label for="AmbassadorClientList" class="col-sm-3 control-label">Positions:</label>
                                                <div class="col-sm-9 specialWidth">

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
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                </div>
                                            </div>



                                        </div>

                                    <%--<div class="col-md-3">
                                         <div class="form-group">
                                                <label for="AmbassadorClientList" class="col-sm-4 control-label">Clients:</label>
                                                <div class="col-sm-8">

                                                    <asp:Repeater ID="AmbassadorClientList" runat="server" DataSourceID="getAmabassadorClients">
                                                        <HeaderTemplate>
                                                            <ul class="special">
                                                        </HeaderTemplate>

                                                        <ItemTemplate>
                                                            <li>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("clientName") %>'></asp:Label></li>


                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </ul>
                                                        </FooterTemplate>
                                                    </asp:Repeater>

                                                    <asp:SqlDataSource ID="getAmabassadorClients" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAmbassadorClients" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                </div>
                                            </div>
                                    </div>--%>

                                    <div class="col-md-4">
                                        <div class="form-group">
                                                <label for="AmabassadorMarketList" class="col-sm-3 control-label">Markets:</label>
                                                <div class="col-sm-9 specialWidth">

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
                                                            <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                </div>
                                            </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="notes">
                        <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Notes</h3>
                                <hr />

                                <div class="col-md-6">
                                        <div class="form-group">
                                                <label for="NotesList" class="col-sm-2 control-label">Notes:</label>
                                                <div class="col-sm-10">

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
                                                           
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </LayoutTemplate>

                                            <ItemTemplate>
                                                <tr class="rlvI">
                                                    <td>
                                                                                                    
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
                                                    <td>
                                                       
                                                </tr>
                                            </ItemTemplate>

                                            <EditItemTemplate>
                                                <tr class="rlvIEdit">
                                                    <td></td>
                                                    <td>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("comment")%>' CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox></td>
                                                    <td>
                                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Update" ToolTip="Update" />
                                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                                                    </td>
                                            </EditItemTemplate>

                                            <InsertItemTemplate>
                                                <tr class="rlvIEdit">
                                                    <td></td>
                                                    <td>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("comment")%>' CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox></td>
                                                    <td>
                                                        <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" />
                                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                                                    </td>
                                            </InsertItemTemplate>

                                            <EmptyDataTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">

                                                        <tbody>
                                                            <tr>
                                                                <td colspan="7">
                                                                    <div class="alert alert-warning" role="alert">There are no items to be displayed.</div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                           
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </EmptyDataTemplate>

                                        </telerik:RadListView>

                                                </div>
                                        </div>
                                </div>



                                <asp:LinqDataSource ID="getAmbassadorNotes" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
                                    EntityTypeName="" OrderBy="createdDate desc" TableName="tblAmbassadorNotes" Where="userID == @userID">
                                    <WhereParameters>
                                        <asp:QueryStringParameter QueryStringField="userID" Name="userID" Type="String"></asp:QueryStringParameter>
                                    </WhereParameters>
                                </asp:LinqDataSource>

                            </div>
                        </div>
                    </div>
                    <!-- End tab -->

                </div>
                <!-- End Tab Panel -->

            </div>
        </div>

</asp:Panel>

<asp:Panel ID="ChangePasswordPanel" runat="server" Visible="false">

    <hr />

            <div class="row">
                <div class="col-sm-6">

                    <div class="widget stacked">
                            <div class="widget-content sm-height">

                                <h3>Change Password</h3>
                                <hr />


                                <div class="form-horizontal">

                                    <div class="form-group" style="padding-bottom: 20px;">
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
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default" />
                                        </div>
                                    </div>

                                </div>

                                <asp:Label ID="errorLabel" runat="server" ForeColor="red" />

                            </div>
                        </div>                    

                </div>
            </div>
        </asp:Panel>

        <div class="row ">

            <div class="col-sm-6">

                <h3 style="color: black; font-weight: bold;">Events</h3>
                <div class="bs-example">
                    <ul id="eventsTab" class="nav nav-tabs">
                        <li class="active"><a href="#recap" data-toggle="tab">Needs Recap <span class="badge"><asp:Label ID="RecapCountLabel" runat="server" /></span></a></li>
                        <li class=""><a href="#upcoming" data-toggle="tab">Upcoming <span class="badge"><asp:Label ID="UpcomingCountLabel" runat="server" /></span></a></li>
                        <li class=""><a href="#previous" data-toggle="tab">Previous <span class="badge"><asp:Label ID="PreviousCountLabel" runat="server" /></span></a></li>

                    </ul>
                </div>

                <div class="tab-content">
                    <div class="tab-pane fade active in" id="recap">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12 tight">

                                    <telerik:RadListView ID="NeedsRecapEventsList" runat="server" DataSourceID="getNeedsRecapList"
                                        AllowPaging="False" Skin="Bootstrap">
                                        <LayoutTemplate>
                                            <div class="overflow" style="padding-right: 15px;">
                                            <table class="table table-striped">
                                                <tbody>
                                                    <tr>
                                                        <th>Event</th>
                                                        <th>Date</th>
                                                        <th>Hours</th>
                                                        <th>Position</th>
                                                        <th>Rate</th>
                                                    </tr>

                                                    <tr runat="server" id="itemPlaceholder"></tr>

                                                </tbody>
                                            </table>
                                            </div>
                                            <%--<telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPagerProducts" runat="server" PagedControlID="NeedsRecapEventsList" PageSize="10">
                                                <Fields>
                                                    <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                                                    <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                                                    <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
                                                </Fields>
                                            </telerik:RadDataPager>--%>

                                        </LayoutTemplate>


                                        <ItemTemplate>
                                            <tr>

                                                <td>
                                                    <a href='/Events/EventDetails?ID=<%# Eval("eventID") %>' onclick="ShowLoadingPanel()"><%# Eval("supplierName") %>
                                                        <br />

                                                        <asp:Label ID="AccountNameLabel" runat="server" Text='<%# Eval("accountName") %>'></asp:Label>

                                                       <%-- <asp:HyperLink ID="AccountNameHyperLink" runat="server" CssClass="text-success" NavigateUrl='<%# Eval("accountID", "/Accounts/AccountDetails?AccountID={0}") %>' Visible='<%# Eval("EnableLink") %>'><%# Eval("accountName") %></asp:HyperLink>--%>

                                                </td>
                                                <td><%# Eval("eventDate", "{0:d}") %><br />
                                                    <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span>

                                                </td>
                                                <td style="text-align: center"><%# Eval("hours") %></td>
                                                <td><%# Eval("positionTitle") %></td>
                                                <td><%# Eval("rate", "{0:c}") %></td>
                                            </tr>
                                        </ItemTemplate>


                                        <EmptyDataTemplate>
                                           <div class="alert alert-warning" role="alert">
                                                There are no recap needed to display.

                                            </div>
                                        </EmptyDataTemplate>

                                    </telerik:RadListView>

                                    <asp:SqlDataSource ID="getNeedsRecapList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                        SelectCommand="GetNeedsRecapEventsListByUserID" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="userID" QueryStringField="userID" Type="String" />
                                            <asp:SessionParameter SessionField="CurrentUserID" Name="LoggedInUserID" Type="String"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="upcoming">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12 tight">
                                    <telerik:RadListView ID="UpcomingEventsList" runat="server" DataSourceID="getUpcomingEventList" AllowPaging="False" Skin="Bootstrap">
                                        <LayoutTemplate>
                                            <div class="overflow" style="padding-right: 15px;">
                                            <table class="table table-striped">
                                                <tbody>
                                                    <tr>
                                                        <th>Event</th>
                                                        <th>Date</th>
                                                        <th>Hours</th>
                                                        <th class="hidden-xs">Position</th>
                                                        <th>Rate</th>
                                                    </tr>

                                                    <tr runat="server" id="itemPlaceholder"></tr>

                                                </tbody>
                                            </table>
                                            </div>
                                           <%-- <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPagerProducts" runat="server" PagedControlID="UpcomingEventsList" PageSize="10">
                                                <Fields>
                                                    <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                                                    <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                                                    <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
                                                </Fields>
                                            </telerik:RadDataPager>--%>

                                        </LayoutTemplate>

                                        <ItemTemplate>

                                            <tr>
                                                <td>
                                                    <a href='/Events/EventDetails?ID=<%# Eval("eventID") %>' onclick="ShowLoadingPanel()"><%# Eval("supplierName") %></a><br />

                                                        <asp:Label ID="AccountNameLabel" runat="server" Text='<%# Eval("accountName") %>'></asp:Label>

                                                       <%-- <asp:HyperLink ID="AccountNameHyperLink" runat="server" CssClass="text-success" NavigateUrl='<%# Eval("accountID", "/Accounts/AccountDetails?AccountID={0}") %>' Visible='<%# Eval("EnableLink") %>'><%# Eval("accountName") %></asp:HyperLink>--%>


                                                </td>
                                                <td><%# Eval("eventDate", "{0:d}") %><br />
                                                    <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span></td>
                                                <td style="text-align: center"><%# Eval("hours") %></td>
                                                <td class="hidden-xs"><%# Eval("positionTitle") %></td>
                                                <td><%# Eval("rate", "{0:c}") %></td>
                                            </tr>

                                        </ItemTemplate>


                                        <EmptyDataTemplate>
                                            <%--<asp:Label ID="lblEmptyData"
                Text='<%# Common.ShowAlertNoClose("warning", "There are no upcoming events to display.")%>' runat="server">
            </asp:Label>--%>

                                            <div class="alert alert-warning" role="alert">
                                                There are no upcoming events to display.

                                            </div>

                                        </EmptyDataTemplate>



                                    </telerik:RadListView>

                                    <asp:SqlDataSource ID="getUpcomingEventList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                        SelectCommand="GetCurrentEventsByAmbassadorsByUserID" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="userID" QueryStringField="userID" Type="String" />
                                            <asp:SessionParameter SessionField="CurrentUserID" Name="LoggedInUserID" Type="String"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>




                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="previous">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12 tight">

                                    <telerik:RadListView ID="PreviousEvents" runat="server" DataSourceID="getPreviousEventList" AllowPaging="False" Skin="Bootstrap">
                                        
                                        <LayoutTemplate>
                                            <div class="overflow" style="padding-right: 15px;">
                                            <table class="table table-striped">
                                                <tbody>
                                                    <tr>
                                                        <th>Event</th>
                                                        <th>Date</th>
                                                        <th>Hours</th>
                                                        <th>Position</th>
                                                        <th>Rate</th>
                                                    </tr>

                                                    <tr runat="server" id="itemPlaceholder"></tr>

                                                </tbody>
                                            </table>
                                            </div>
                                            <%--<telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPagerProducts" runat="server" PagedControlID="PreviousEvents" PageSize="10">
                                                <Fields>
                                                    <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                                                    <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                                                    <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
                                                </Fields>
                                            </telerik:RadDataPager>--%>

                                        </LayoutTemplate>


                                        <ItemTemplate>

                                            <tr>
                                                

                                                <td>
                                                    <a href='/Events/EventDetails?ID=<%# Eval("eventID") %>' onclick="ShowLoadingPanel()"><%# Eval("supplierName") %></a><br />

                                                   <asp:Label ID="AccountNameLabel" runat="server" Text='<%# Eval("accountName") %>'></asp:Label>

                                                        <%--<asp:HyperLink ID="AccountNameHyperLink" runat="server" CssClass="text-success" NavigateUrl='<%# Eval("accountID", "/Accounts/AccountDetails?AccountID={0}") %>' Visible='<%# Eval("EnableLink") %>'><%# Eval("accountName") %></asp:HyperLink>--%>

                                                </td>
                                                <td><%# Eval("eventDate", "{0:d}") %><br />
                                                    <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span></td>
                                                <td style="text-align: center"><%# Eval("hours") %></td>
                                                <td><%# Eval("positionTitle") %></td>
                                                <td><%# Eval("rate", "{0:c}") %></td>
                                            </tr>

                                        </ItemTemplate>


                                        <EmptyDataTemplate>

                                            <div class="alert alert-warning" role="alert">
                                                There are no previous events to display.
                                            </div>

                                        </EmptyDataTemplate>

                                    </telerik:RadListView>


                                     <asp:SqlDataSource ID="getPreviousEventList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                        SelectCommand="GetPastEventsByAmbassadorsByUserID" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="userID" QueryStringField="userID" Type="String" />
                                            <asp:SessionParameter SessionField="CurrentUserID" Name="LoggedInUserID" Type="String"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>



                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                </div>

            </div>
            <!-- End Row -->

            <div class="col-sm-6">

                <h3 style="color: black; font-weight: bold;">Payments</h3>
                <div class="bs-example">
                    <ul id="paymentsTab" class="nav nav-tabs">
                        <li class="active"><a href="#scheduled" data-toggle="tab">Scheduled</a></li>
                        <li class=""><a href="#processing" data-toggle="tab">Processing</a></li>
                        <li class=""><a href="#paid" data-toggle="tab">Paid</a></li>

                    </ul>
                </div>

                <div class="tab-content">
                    <div class="tab-pane fade active in" id="scheduled">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12 tight">
                                    <telerik:RadListView ID="ScheduledPaymantList" runat="server" DataSourceID="getScheduledPayments" DataKeyNames="RequirementID" AllowPaging="false" Skin="Bootstrap">
                                        <LayoutTemplate>
                                            <div class="overflow" style="padding-right: 15px;">
                                                <table class="table table-striped">
                                                    <tbody>
                                                        <tr>
                                                            <th>Event</th>
                                                            <th>Date</th>
                                                            <th class="hidden-xs">Hours</th>
                                                            <th class="hidden-xs">Labor</th>
                                                            <th class="hidden-xs">Expenses</th>
                                                            <th>Total</th>
                                                            <th class="hidden-xs">Payment #</th>
                                                        </tr>

                                                        <tr runat="server" id="itemPlaceholder"></tr>

                                                    </tbody>
                                                </table>

                                            </div>
                                            <%--        <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPagerProducts" runat="server" PagedControlID="SechedulesPaymantList" PageSize="10">
            <Fields>
                <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
            </Fields>
        </telerik:RadDataPager>--%>
                                        </LayoutTemplate>

                                        <ItemTemplate>

                                            <tr>
                                                <td><a href='/Events/EventDetails?ID=<%# Eval("eventID") %>' onclick="ShowLoadingPanel()"><%# Eval("supplierName") %></a><br />
                                                    <asp:Label ID="AccountNameLabel" runat="server" Text='<%# Eval("accountName") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="paymentDateLabel" runat="server" Text='<%# Eval("paymentDate", "{0:d}") %>'></asp:Label>
                                                </td>
                                                <td class="hidden-xs">
                                                    <asp:Label Text='<%# Eval("hours") %>' runat="server" ID="hoursLabel" /></td>
                                                <td class="hidden-xs">
                                                    <asp:Label Text='<%# Eval("Labor", "{0:c}") %>' runat="server" ID="LaborLabel" /></td>
                                                <td class="hidden-xs">
                                                    <asp:Label Text='<%# Eval("expenses", "{0:c}") %>' runat="server" ID="expensesLabel" /></td>
                                                <td>
                                                    <asp:Label Text='<%# Eval("Total", "{0:c}") %>' runat="server" ID="TotalLabel" /></td>
                                                <td class="hidden-xs">
                                                    <asp:Label ID="paymentIDLabel" runat="server" Text='<%# Eval("paymentID") %>' /></td>
                                            </tr>



                                        </ItemTemplate>



                                        <EmptyDataTemplate>



                                            <div class="alert alert-warning" role="alert">
                                                There are no scheduled payments to display.

                                            </div>



                                        </EmptyDataTemplate>

                                    </telerik:RadListView>


                                <asp:SqlDataSource runat="server" ID="getScheduledPayments" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="ViewScheduledPaymentsByAmbassador" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:QueryStringParameter  Name="userID" QueryStringField="UserID" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource runat="server" ID="getPendingPayments" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="ViewPendingPaymentsByAmbassador" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:QueryStringParameter  Name="userID" QueryStringField="UserID" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>






                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="processing">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12 tight">
                                    <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="getPendingPayments" DataKeyNames="RequirementID" AllowPaging="false" Skin="Bootstrap">
                            <LayoutTemplate>
                                <div class="overflow" style="padding-right: 15px;">
                                <table class="table table-striped">
                                    <tbody>
                                        <tr>
                                            <th>Event</th>
                                            <th>Date</th>
                                            <th>Hours</th>
                                            <th>Labor</th>
                                            <th>Expenses</th>
                                            <th>Total</th>
                                            <th>Payment #</th>
                                        </tr>

                                        <tr runat="server" id="itemPlaceholder"></tr>

                                    </tbody>
                                </table>
                                    </div>
                                <%--<telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPagerProducts" runat="server" PagedControlID="SechedulesPaymantList" PageSize="10">
                                    <Fields>
                                        <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                                        <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                                        <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
                                    </Fields>
                                </telerik:RadDataPager>--%>
                            </LayoutTemplate>

                            <ItemTemplate>

                                <tr>
                                    <td><a href='/Events/EventDetails?ID=<%# Eval("eventID") %>' onclick="ShowLoadingPanel()"><%# Eval("supplierName") %></a><br />
                                           <asp:Label ID="AccountNameLabel" runat="server" Text='<%# Eval("accountName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="paymentDateLabel" runat="server" Text='<%# Eval("paymentDate", "{0:d}") %>'></asp:Label>
                                        </td>
                                    <td>
                                        <asp:Label Text='<%# Eval("hours") %>' runat="server" ID="hoursLabel" /></td>
                                    <td>
                                        <asp:Label Text='<%# Eval("Labor", "{0:c}") %>' runat="server" ID="LaborLabel" /></td>
                                    <td>
                                        <asp:Label Text='<%# Eval("expenses", "{0:c}") %>' runat="server" ID="expensesLabel" /></td>
                                    <td><asp:Label Text='<%# Eval("Total", "{0:c}") %>' runat="server" ID="TotalLabel" /></td>
                                    <td>
                                        <asp:Label ID="paymentIDLabel" runat="server" Text='<%# Eval("paymentID") %>' /></td>
                                </tr>



                            </ItemTemplate>



                            <EmptyDataTemplate>



                        <div class="alert alert-warning" role="alert">
                            There are no payments processing to display.

                        </div>



                            </EmptyDataTemplate>

                        </telerik:RadListView>


                            <asp:SqlDataSource runat="server" ID="getPendingPayments1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="ViewPendingPaymentsByAmbassador" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:QueryStringParameter  Name="userID" QueryStringField="UserID" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>



                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="paid">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12 tight">
                                    <telerik:RadListView ID="RadListView2" runat="server" DataSourceID="getpaidPayments" DataKeyNames="RequirementID" AllowPaging="false" Skin="Bootstrap">
    <LayoutTemplate>
        <div class="overflow" style="padding-right: 15px;">
        <table class="table table-striped">
            <tbody>
                <tr>
                    <th>Event</th>
                    <th>Date</th>
                    <th>Hours</th>
                    <th>Labor</th>
                    <th>Expenses</th>
                    <th>Total</th>
                    <th>Payment #</th>
                </tr>

                <tr runat="server" id="itemPlaceholder"></tr>

            </tbody>
        </table>
            </div>
        <%--<telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPagerProducts" runat="server" PagedControlID="SechedulesPaymantList" PageSize="10">
            <Fields>
                <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
            </Fields>
        </telerik:RadDataPager>--%>
    </LayoutTemplate>

    <ItemTemplate>

        <tr>
            <td><a href='/Events/EventDetails?ID=<%# Eval("eventID") %>' onclick="ShowLoadingPanel()"><%# Eval("supplierName") %></a> <br />
                 <asp:Label ID="AccountNameLabel" runat="server" Text='<%# Eval("accountName") %>'></asp:Label>
            </td>
            <td>
                <asp:Label ID="paymentDateLabel" runat="server" Text='<%# Eval("paymentDate", "{0:d}") %>'></asp:Label>
                </td>
            <td>
                <asp:Label Text='<%# Eval("hours") %>' runat="server" ID="hoursLabel" /></td>
            <td>
                <asp:Label Text='<%# Eval("Labor", "{0:c}") %>' runat="server" ID="LaborLabel" /></td>
            <td>
                <asp:Label Text='<%# Eval("expenses", "{0:c}") %>' runat="server" ID="expensesLabel" /></td>
            <td><asp:Label Text='<%# Eval("Total", "{0:c}") %>' runat="server" ID="TotalLabel" /></td>
            <td>
                <asp:Label ID="paymentIDLabel" runat="server" Text='<%# Eval("paymentID") %>' /></td>
        </tr>



    </ItemTemplate>



    <EmptyDataTemplate>



<div class="alert alert-warning" role="alert">
    There are no paid payments to display.

</div>



    </EmptyDataTemplate>

</telerik:RadListView>


                                    <asp:SqlDataSource runat="server" ID="getpaidPayments" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="ViewPaidPaymentsByAmbassador" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="UserID" QueryStringField="UserID" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>




                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                </div>

            </div>
            <!-- End Row -->



        </div>

        <div class="row ">

            <div class="col-sm-12">

                <h3 style="color: black; font-weight: bold;">Product Training</h3>
                <div class="bs-example">
                    <ul id="trainingTab" class="nav nav-tabs">
                        <li class="active"><a href="#activecourses" data-toggle="tab">Supplier/Brand Schools</a></li>
                        <%--<li><a href="#completedcourses" data-toggle="tab">Completed Courses</a></li>--%>
                        <%--<li class=""><a href="#availabletests" data-toggle="tab">Available Tests</a></li>--%>
                        <li class=""><a href="#completedtests" data-toggle="tab">Tests Scores</a></li>

                    </ul>
                </div>

                <div class="tab-content">
                    <div class="tab-pane fade active in" id="activecourses">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">

                                    <asp:Panel ID="ActiveListPanel" runat="server">


                                        <telerik:RadGrid ID="ActiveCourseList" runat="server" AutoGenerateColumns="False"
                                        DataSourceID="GetTrainingResults" AllowPaging="true" AllowSorting="true">


                                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="CourseID" CommandItemDisplay="None" AllowSorting="true">

                                                <NoRecordsTemplate>

                                                    <br />
                                                    <div class="col-md-12">
                                                        <div class="alert alert-warning" role="alert"><strong>No Schools Found.</strong>  Please adjust your filter options.</div>
                                                    </div>

                                                </NoRecordsTemplate>

                                                <RowIndicatorColumn>
                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                </RowIndicatorColumn>

                                                <Columns>

                                    <telerik:GridTemplateColumn>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary btn-xs" ForeColor="White" PostBackUrl='<%# Eval("CourseID", "/Ambassadors/TrainingDetails?CourseID={0}&UserID=" & Request.QueryString("UserID")) %>'>
                                                View Details &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>

                                                        <br />


                                                        <%--<%# getRequiredCurriculumCount(Eval("CourseID")) %>--%>
                                        </ItemTemplate>
                                        <ItemStyle Width="160px" />
                                    </telerik:GridTemplateColumn>
                                                    
                                            <telerik:GridBoundColumn DataField="CourseTitle" HeaderText="Brand Training" SortExpression="CourseTitle">

                                            </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Percent Complete">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label2" runat="server" Text='<%# calculatPersentComplete(Eval("CurriculumCount"), Eval("CurriculumCompletedCount")) %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    
                                                    <telerik:GridTemplateColumn HeaderText="Quiz/Tests">
                                                        <ItemTemplate>
                                                           <b><%# Eval("PassedCount") %></b> out of <b><%# Eval("TestCount") %></b> Complete
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                   
                                                    
                                                </Columns>

                                            </MasterTableView>

                                            <PagerStyle Position="TopAndBottom" />


                                        </telerik:RadGrid>


                                    <%--<asp:GridView ID="ActiveCourseList1" runat="server" AutoGenerateColumns="False" EmptyDataText="There are currently no tests available."
                                        CssClass="table table-striped table-bordered" DataKeyNames="CourseID" DataSourceID="GetTrainingResults" AllowPaging="true" AllowSorting="true">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary btn-xs" PostBackUrl="~/Ambassadors/TrainingDetails.aspx">View Details &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>

                                                    <br />



                                                    <%# getRequiredCurriculumCount(Eval("CourseID")) %>

                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="CourseTitle" HeaderText="Brand Training" SortExpression="CourseTitle"></asp:BoundField>

                                            <asp:TemplateField HeaderText="Percent Complete">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# calculatPersentComplete(Eval("CurriculumCount"), Eval("CurriculumCompletedCount")) %>'></asp:Label>
                                               </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Quiz/Tests">
                                                <ItemTemplate><b><%# Eval("PassedCount") %></b> out of <b><%# Eval("TestCount") %></b> Complete</ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Average Score">
                                                <ItemTemplate>-</ItemTemplate>
                                            </asp:TemplateField>


                                            <asp:TemplateField HeaderText="Video/Media">
                                                <ItemTemplate>0</ItemTemplate>

                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Event Guidlines">
                                                <ItemTemplate>2</ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                        <EmptyDataTemplate>
                                            There are currently no tests available.
                                        </EmptyDataTemplate>
                                        <Columns>
                                        </Columns>

                                        <PagerSettings Position="TopAndBottom" />
                                        
                                    </asp:GridView>--%>

                                    </asp:Panel>

                                    <asp:SqlDataSource ID="GetTrainingResults" runat="server" ConnectionString='<%$ ConnectionStrings:LMSConnection %>' SelectCommand="BrandTrainingResultByUserID" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:SessionParameter SessionField="CurrentUserName" Name="UserName" Type="String"></asp:SessionParameter>
                                            
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetActiveCourseList" ContextTypeName="EventManagerApplication.LMSDataClassesDataContext" TableName="Courses" Where="SiteID == @SiteID">
                                        <WhereParameters>
                                            <asp:Parameter DefaultValue="GigEngyn" Name="SiteID" Type="String"></asp:Parameter>
                                        </WhereParameters>
                                    </asp:LinqDataSource>
                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="completedcourses">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    There are no completed courses.

                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="availabletests">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">


                                      <%--<asp:GridView ID="AvailableTestList" runat="server" AutoGenerateColumns="False" DataSourceID="getAvailableTests" EmptyDataText="There are currently no tests available."
                             CssClass="table table-striped table-bordered">--%>
      <EmptyDataTemplate>
          There are currently no tests available.
      </EmptyDataTemplate>
        <Columns>

            <asp:HyperLinkField DataNavigateUrlFields="TestID" ControlStyle-CssClass="btn btn-xs btn-success"
                DataNavigateUrlFormatString="/Start?id={0}"
                DataTextField="TestResult">
                <ItemStyle HorizontalAlign="Center" Width="95px" Font-Bold="True" />
            </asp:HyperLinkField>

            <asp:BoundField DataField="Title" HeaderText="Test Name" SortExpression="Title">
                <ItemStyle Font-Bold="true" />
            </asp:BoundField>





             <asp:TemplateField HeaderText="Passing Grade">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# String.Format("{0} %", Eval("PassingGrade"))%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

           <%-- <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%#getPrerequisiteResult(Eval("prerequisite"), Eval("dbGUID"))%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# getPreReqTest(Eval("PreReqResult"), Eval("PreReqTitle")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>
        </Columns>
    </asp:GridView>

                                    <%--<asp:SqlDataSource ID="GetAvailableTests" runat="server" ConnectionString="<%$ ConnectionStrings:MembershipConnection %>"
    SelectCommand="baretc_CurentAvailableTestsByAmbassador" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="GUID" Name="UserName" PropertyName="Value" />

    </SelectParameters>
    </asp:SqlDataSource>--%>

                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->

                    <div class="tab-pane fade in" id="completedtests">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <div class="col-md-12">
                                    <asp:GridView ID="CompletedTestsList" runat="server" AutoGenerateColumns="False" DataSourceID="LinqDataSource1" EmptyDataText="There are no completed tests."
                                        CssClass="table table-striped table-bordered">
                                        <EmptyDataTemplate>
                                            There are no completed tests.
                                        </EmptyDataTemplate>
                                        <Columns>

                                            <asp:TemplateField HeaderText="">
                                                <ItemTemplate>
                                                    <a href="ViewTestResults?ID=<%# Eval("TestSessionID")%>" class="btn btn-xs btn-primary">
                                      View Details &nbsp;&nbsp;<i class="fa fa-chevron-right"></i>
                                        </a>

                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="Title" HeaderText="Test Name" SortExpression="Title">
                                                <ItemStyle Font-Bold="true" />
                                            </asp:BoundField>


                                            <asp:TemplateField HeaderText="Date">
                                                <ItemTemplate>
                                                    <%#Common.GetTimeAdjustment(Eval("DateTimeCompleted"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>


                                            <asp:TemplateField HeaderText="Score">
                                                <ItemTemplate>
                                                    <span class="label label-success">
                                                        <%# Eval("Score", "{0:D}")%>% </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>


                                        </Columns>
                                    </asp:GridView>


 <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="EventManagerApplication.LMSDataClassesDataContext" TableName="baretc_TestResults" Where="Result == @Result && UserName == @UserName">
                            <WhereParameters>
                                <asp:Parameter DefaultValue="Passed" Name="Result" Type="String"></asp:Parameter>
                                <asp:ControlParameter ControlID="GUID" PropertyName="Value" Name="UserName" Type="String"></asp:ControlParameter>

                            </WhereParameters>
                        </asp:LinqDataSource>


                                </div>
                            </div>
                            <!-- End Content -->
                        </div>
                        <!-- End Widget -->
                    </div>
                    <!-- End tab -->



                </div>

            </div>

        </div>

                

    </div>

    </asp:Panel>

     <telerik:RadWindowManager runat="server" ID="RadWindowManager1">

                        <Windows>
                            <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" NavigateUrl="/Profile_Image.aspx" Skin="Bootstrap"
                                Width="675px" Height="530px" AutoSize="true" Behaviors="Close,Move" ShowContentDuringLoad="false"
                                Modal="true">
                            </telerik:RadWindow>

                        </Windows>

                    </telerik:RadWindowManager>

    <asp:HiddenField ID="Guid" runat="server" />


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

      <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
         <script type="text/javascript">
            function ShowLoadingPanel() {
                    var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                    var currentUpdatedControl = "<%= Panel1.ClientID %>";
                    loadingPanel.set_modal(true);
                    loadingPanel.show(currentUpdatedControl);
                }
         </script>
     </telerik:RadScriptBlock>

</asp:Content>
