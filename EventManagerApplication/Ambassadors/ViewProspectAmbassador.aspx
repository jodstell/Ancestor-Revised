<%@ Page Title="Prospect Ambassador" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewProspectAmbassador.aspx.vb" Inherits="EventManagerApplication.ViewProspectAmbassador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
         .label-standard {
            background-color: #000;
        }

        .form-group {
            margin-bottom: 10px;
        }
</style>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="MainPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="ProductTrainingPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ProductTrainingPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" BackgroundPosition="Top"></telerik:RadAjaxLoadingPanel>

    <div class="container min-height">

        <asp:HiddenField ID="ambassadorUserIDHidden" runat="server" />

        <div class="row">
            <div class="col-xs-12">
                <h2>Brand Ambassador Prospect</h2>
            </div>

            <div class="col-md-6 detail">
                Name:
                <asp:Label ID="AccountNameLabel" Font-Size="Large" runat="server" Font-Bold="true" />
                <br />
                Registration Date:
                    <asp:Label ID="CreatedDateLabel" runat="server" Font-Bold="true" />
                <br />

            </div>



            <div class="col-md-6">
            </div>

        </div>

        <asp:Label ID="msgLabel" runat="server" />

        <hr />

        <div class="row">

            <div class="col-sm-12">


                <asp:Panel ID="MainPanel" runat="server">
                    <asp:Panel ID="DetailPanel" runat="server">

                        <asp:Button  ID="btnBack" runat="server" Text="Back To Prospect Ambassadors" CssClass="btn btn-default" />

                        <div class="pull-right marginbottom10">
                            <asp:Button ID="btnApprove" runat="server" Text="Approve Ambassador" CssClass="btn btn-success" />
                            <asp:Button ID="btnReject" runat="server" Text="Reject Ambassador" CssClass="btn btn-danger" />
                        </div>

                        <div class="widget stacked">
                            <div class="widget-content sm-height">

                                <h3>Overview</h3>
                                <hr />
                                <div class="ambinfo1">
                                    <div class="col-md-1">

                                        <asp:Repeater ID="headshot" runat="server" DataSourceID="getHeadShot1">
                                            <ItemTemplate>
                                                <telerik:RadBinaryImage ID="thumbnailImage" runat="server" CssClass="thumbnail"
                                                    AlternateText="Click to view larger image" ToolTip="Click to view larger image"
                                                    DataValue='<%#IIf(TypeOf (Eval("headShot")) Is DBNull, Nothing, Eval("headShot"))%>'
                                                    Height="105px" Width="90px" ResizeMode="Fit" />

                                            </ItemTemplate>
                                        </asp:Repeater>

                                        <asp:SqlDataSource runat="server" ID="getHeadShot1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                            SelectCommand="SELECT [tblAmbassadorPhoto].[userID], [tblAmbassadorPhoto].[headShot], [tblAmbassadorPhoto].[bodyShot], [tblAmbassador].[ambassadorID] FROM [tblAmbassadorPhoto] JOIN [tblAmbassador] on [tblAmbassadorPhoto].[userID] = [tblAmbassador].[userID] WHERE ([tblAmbassador].[ambassadorID] = @ambassadorID)">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="UserID" Name="ambassadorID" Type="String"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>


                                    </div>

                                    <div class="col-md-3">

                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="FirstNameTextBox" class="col-sm-7 control-label">First Name:</label>
                                                <div class="col-sm-5" style="top: 6px;">

                                                    <asp:Label ID="FirstName" runat="server" />

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="LastNameTextBox" class="col-sm-7 control-label">Last Name:</label>
                                                <div class="col-sm-5" style="top: 6px;">

                                                    <asp:Label ID="LastName" runat="server" />

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="NicknameTextBox" class="col-sm-7 control-label">Middle Name:</label>
                                                <div class="col-sm-5" style="top: 6px;">

                                                    <asp:Label ID="Nickname" runat="server" />

                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <div class="col-md-4">

                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="DateofBirthTextBox" class="col-sm-6 control-label">Date of Birth:</label>
                                                <div class="col-sm-6" style="top: 6px;">

                                                    <asp:Label ID="DateofBirth" runat="server" />

                                                </div>


                                            </div>


                                            <div class="form-group">
                                                <label for="Gender" class="col-sm-6 control-label">Gender:</label>
                                                <div class="col-sm-6" style="top: 6px;">

                                                    <asp:Label ID="Gender" runat="server" />

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="Citizen" class="col-sm-6 control-label">Are you a U.S. Citizen:</label>
                                                <div class="col-sm-6" style="top: 6px;">

                                                    <asp:Label ID="Citizen" runat="server" />

                                                </div>
                                            </div>

                                        </div>

                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="PortalLoginLabel" class="col-sm-5 control-label">Status:</label>
                                                <div class="col-sm-6" style="top: 6px;">
                                                    <asp:Label ID="StatusLabel" runat="server" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="PortalLoginLabel" class="col-sm-5 control-label">Portal Login:</label>
                                                <div class="col-sm-6" style="top: 6px;">
                                                    <asp:Label ID="PortalLoginLabel" runat="server" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="PasswordLabel" class="col-sm-5 control-label">Portal Password:</label>
                                                <div class="col-sm-6" style="top: 6px;">
                                                    <asp:Label ID="PasswordLabel" runat="server" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>

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
                                                <label for="PhoneNumberTextBox" class="col-sm-3 control-label">Phone Number:</label>
                                                <div class="col-sm-9" style="top: 6px;">
                                                    <asp:Label ID="PhoneNumber" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="EmailAddressTextBox" class="col-sm-3 control-label">Email Address:</label>
                                                <div class="col-sm-9" style="top: 6px;">
                                                    <asp:Label ID="EmailAddress" runat="server" Text="Label"></asp:Label>

                                                </div>
                                            </div>



                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

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
                                                    <asp:Label ID="Piersings" runat="server" />
                                                </div>
                                            </div>

                                        </div>

                                    </div>

                                    <div class="col-md-2">
                                        <asp:Repeater ID="bodyShot" runat="server" DataSourceID="getHeadShot1">
                                            <ItemTemplate>
                                                Headshot Image<br />


                                                <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail"
                                                    DataValue='<%#IIf(TypeOf (Eval("headShot")) Is DBNull, Nothing, Eval("headShot"))%>'
                                                    Height="150px" Width="150px" ResizeMode="Fit"  />

                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="getHeadShot1">
                                            <ItemTemplate>
                                                Body Shot Image<br />

                                                <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail"
                                                    DataValue='<%#IIf(TypeOf (Eval("bodyShot")) Is DBNull, Nothing, Eval("bodyShot"))%>'
                                                    Height="150px" Width="150px" ResizeMode="Fit"  />

                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                </div>
                            </div>
                            <!-- End Content -->
                        </div>

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
                                                    <asp:Label ID="WillingMiles" runat="server" />
                                                    miles

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

                        <div class="widget stacked">
                            <div class="widget-content sm-height">
                                <h3>Licenses & Documents</h3>
                                <hr />
                                <div class="ambinfo1">
                                    <div class="col-md-5">
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="UploadCurrentResume" class="col-sm-3 control-label">Current resume:</label>
                                                <div class="col-sm-9" style="padding: 7px;">
                                                    <%--<div class="panel panel-default">
                                                        <div class="panel-body center">
                                                            <i class="fa fa-file-pdf-o fa-5x fa-align-center"></i>
                                                            <br />

                                                            <asp:HyperLink ID="btnDownloadResume" runat="server" CssClass="btn btn-xs btn-primary" Target="_blank">Open Resume</asp:HyperLink>

                                                            <asp:Label ID="ResumeLabel" runat="server" Text="No file uploaded"></asp:Label>
                                                        </div>
                                                    </div>--%>




                        <asp:Repeater ID="ResumeList" runat="server" DataSourceID="getResumeList">
                                    <HeaderTemplate>
                                        <table class="table table-striped">
                                            <tbody>
                                            <tr>

                                                <th>File Name</th>
                                                <th>Date Uploaded</th>
                                            </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>

                                            <td><a href='DocumentsHandler.aspx?fileID=<%# Eval("ambassadorFileID") %>'><%# Eval("documentName") %></a></td>
                                            <td><%# Eval("dateUploaded", "{0:d}") %></td>
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

                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getResumeList" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
                                    TableName="tblAmbassadorDocuments" Where="userID == @userID && category == @category" EnableDelete="True">
                                    <WhereParameters>
                                        <asp:ControlParameter ControlID="ambassadorUserIDHidden" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                                        <asp:Parameter DefaultValue="Resume" Name="category" Type="String"></asp:Parameter>
                                    </WhereParameters>
                                </asp:LinqDataSource>





                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="col-md-7">
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="UploadLicense" class="col-sm-3 control-label">Current sampling license:</label>
                                                <div class="col-sm-9" style="padding: 7px;">
                                                    <%--<div class="panel panel-default">
                                                        <div class="panel-body center">

                                                            <i class="fa fa-file-image-o fa-5x fa-align-center"></i>
                                                            <br />
                                                            <asp:HyperLink ID="btnDownloadLicense" runat="server" CssClass="btn btn-xs btn-primary" Target="_blank">Open License</asp:HyperLink>


                                                            <asp:Label ID="Licenselabel" runat="server" Text="No file uploaded"></asp:Label>
                                                        </div>
                                                    </div>--%>


                            <asp:Repeater ID="LicenseList" runat="server" DataSourceID="getLienseList">
                                    <HeaderTemplate>
                                        <table class="table table-striped">
                                            <tbody>
                                            <tr>
                                                <th>File Name</th>
                                                <th>License Name</th>
                                                <th>Date Uploaded</th>
                                                <th>Expiration Date</th>
                                            </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td><a href='DocumentsHandler.aspx?fileID=<%# Eval("ambassadorFileID") %>'><%# Eval("documentTitle") %></a></td>
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

                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getLienseList" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
                                    TableName="tblAmbassadorDocuments" Where="userID == @userID && category == @category" EnableDelete="True">
                                    <WhereParameters>
                                        <asp:ControlParameter ControlID="ambassadorUserIDHidden" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                                        <asp:Parameter DefaultValue="License" Name="category" Type="String"></asp:Parameter>
                                    </WhereParameters>
                                </asp:LinqDataSource>

                                                    


                                                </div>
                                            </div>



                                            <%--<div class="form-group">
                                                <label for="LicenseExpirationDateTextBox" class="col-sm-3 control-label">License Expiration Date:</label>
                                                <div class="col-sm-6" style="padding: 7px;">
                                                    <asp:Label ID="LicenseExpirationDate" runat="server" Text="No file uploaded"></asp:Label>

                                                </div>
                                            </div>--%>

                                        </div>
                                    </div>
                                </div>

                            </div>
                            <!-- End Content -->
                        </div>

                    </asp:Panel>

                    <asp:Panel ID="ApprovePanel" runat="server" Visible="false">

            <div class="pull-right marginbottom10">
                <asp:Button ID="btnSubmitAmbassador" runat="server" Text="Submit" CssClass="btn btn-success" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default" />
            </div>

                        <asp:Label ID="errorLabel" ForeColor="red" runat="server" />

                        <div class="widget stacked" style="padding: 10px">
                            <div class="widget-content sm-height">

                                <div class="form-horizontal">

                                    <p>Enter the ambassadors login information and assignments.  An automated email will be sent to the new ambassador.</p>

                                    <h3>Login</h3>

                                    <div class="form-group">
                                        <label for="PayrollIDTextBox" class="col-md-2 control-label">Payroll ID/UserName:</label>
                                        <div class="col-md-2">

                                            <asp:TextBox ID="PayrollIDTextBox" runat="server" CssClass="form-control" onchange="validateUser()" /> <asp:Label ID="lblStatus" runat="server" />

                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="PasswordTextBox" class="col-md-2 control-label">Password</label>
                                        <div class="col-md-2">

                                            <asp:TextBox ID="PasswordTextBox" runat="server" CssClass="form-control"></asp:TextBox>

                                        </div>
                                    </div>

                                    <h3>Assignments</h3>


                                    <div class="form-group">
                                        <label for="FirstNameTextBox" class="col-md-2 control-label">Markets</label>
                                        <div class="col-md-3">

                                            <telerik:RadListBox ID="MarketList" runat="server" DataSourceID="GetMarketList" CheckBoxes="True" ShowCheckAll="True" Height="300px" Width="350px"
                                                 DataTextField="marketName" DataValueField="marketID" EnableMarkMatches="true">
                                            </telerik:RadListBox>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetMarketList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="marketName" TableName="tblMarkets" Where="active == @active">
                                                <WhereParameters>
                                                    <asp:Parameter DefaultValue="True" Name="active" Type="Boolean"></asp:Parameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>
                                        </div>
                                    </div>


                                    <br />

                                         <div class="form-group">



                                        <label for="PositionsListBox" class="col-md-2 control-label">Positions</label>
                                        <div class="col-md-3">

                                            <telerik:RadListBox ID="PositionsListBox" runat="server" CheckBoxes="True" ShowCheckAll="True" Height="300px" Width="350px"
                                                DataTextField="positionTitle" DataValueField="staffingPositionID" EnableMarkMatches="true" DataSourceID="GetPositionList">
                                            </telerik:RadListBox>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetPositionList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="positionTitle" TableName="tblStaffingPositions"></asp:LinqDataSource>
                                        </div>
                                    </div>

                                        <%-- <br />

                                     <div class="form-group">
                                        <label for="TypeofBrandstoWork" class="col-sm-2 control-label">Brands</label>
                                        <div class="col-sm-9">

                                            <asp:CheckBox ID="ckbBeer" runat="server" Text="Beer" />
                                            <asp:CheckBox ID="ckbSpirits" runat="server" Text="Spirits" />
                                            <asp:CheckBox ID="ckbWine" runat="server" Text="Wine" />
                                            <asp:CheckBox ID="ckbReadyToDrink" runat="server" Text="Ready to Drink" />
                                            <asp:CheckBox ID="ckbOther" runat="server" Text="Other" />

                                        </div>
                                    </div>--%>

                                    <br />
                                    
                                <h3>Comments</h3>
                                    
                                    <div class="form-group">
                                        <label for="FirstNameTextBox" class="col-md-2 control-label"> Notes (Optional)</label>
                                        <div class="col-md-5">

                                            <telerik:RadTextBox ID="RadTextBox1" runat="server" Width="600px" Height="200px" TextMode="Multiline" CssClass="form-control"></telerik:RadTextBox>

                                        </div>
                                    </div>
                            
                                    <br />

                                    <h3>Email Message</h3>

                                      <div class="form-group">
                                        <label for="FirstNameTextBox" class="col-md-2 control-label"> Personal Message (Optional)</label>
                                        <div class="col-md-5">

                                            <%--<asp:TextBox ID="TextBox7" runat="server" CssClass="form-control"></asp:TextBox>--%>
                                            <telerik:RadTextBox ID="TextBox7" runat="server" Width="600px" Height="200px" TextMode="Multiline" CssClass="form-control"></telerik:RadTextBox>

                                        </div>
                                    </div>

                                    </div>

                                        </div>







                            </div>


            <%--<div class="pull-right marginbottom10">
                <asp:Button ID="btnSubmitAmbassador2" runat="server" Text="Submit" CssClass="btn btn-success"/>
                <asp:Button ID="btnCancel2" runat="server" Text="Cancel" CssClass="btn btn-default"/>
            </div>--%>

            </asp:Panel>

                <asp:Panel ID="RejectPanel" runat="server" Visible="false">

                <div class="pull-right">
                    <asp:Button ID="btnSubmitReject" runat="server" Text="Submit" CssClass="btn btn-success" />
                    <asp:Button ID="btnCancelReject" runat="server" Text="Cancel" CssClass="btn btn-default" />
                </div>
                    
                    <div class="widget stacked">
                        <div class="widget-content sm-height">

                            <h3>Reject Ambassador</h3>
                            <hr />
                            <br />

                            
                            <div class="col-md-12">
                                <h4>Comments</h4>

                                <telerik:RadTextBox ID="CommentTextBox" runat="server" Width="600px" Height="200px" TextMode="Multiline"></telerik:RadTextBox>

                            </div>

                            

                        </div>
                    </div>

                </asp:Panel>

            </asp:Panel>
        </div>
    </div>
    <!-- End Row -->

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
