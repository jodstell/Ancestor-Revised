<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AccountInformationControl.ascx.vb" Inherits="EventManagerApplication.AccountInformationControl" %>

<style>
    .form-group {
        margin-bottom: 10px;
    }

    label {
        width: 125px;
    }

    .btn {
        line-height: 1.4 !important;
    }
</style>


<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel21" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<asp:Panel ID="Panel1" runat="server">
    <div class="row">
        <div class="col-md-12">
            <asp:Label ID="msgLabel" runat="server" />
        </div>
    </div>

    <asp:FormView ID="AccountInformation" runat="server" DataKeyNames="accountID" DataSourceID="getAccountInformation" Width="100%">
        <EditItemTemplate>

            <style>
                #mapColumn {
                    display: none;
                }
            </style>

            <div class="row">
                <div class="col-md-12">

                    <div style="margin: 12px 0 12px 0">
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-primary btn-sm" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
                            CommandName="Cancel" Text="Cancel" CssClass="btn btn-default btn-sm" />
                    </div>

                    <p>Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                        </p>


                    <div class="form-horizontal">

                        <div class="form-group">
                            <label for="accountNameTextBox" class="col-sm-3 control-label">Account Name <span class="text-danger">*</span></label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="accountNameTextBox" runat="server" Text='<%# Bind("accountName") %>' CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="errorlabel" Display="Dynamic" ControlToValidate="accountNameTextBox" ErrorMessage="Account Name is required" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="DBANameTextBox" class="col-sm-3 control-label">DBA Name</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="DBANameTextBox" runat="server" Text='<%# Bind("DBAName") %>' CssClass="form-control" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="accountIDLabel1" class="col-sm-3 control-label">Account Type <span class="text-danger">*</span></label>
                            <div class="col-sm-9">

                                <telerik:RadDropDownList ID="RadDropDownList2" runat="server" SelectedValue='<%# Bind("accountTypeID") %>' AppendDataBoundItems="True" DataSourceID="getAccountType" DataTextField="accountTypeName" DataValueField="accountTypeID" Width="200px">
                                    
                                </telerik:RadDropDownList>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="errorlabel" Display="Dynamic" ControlToValidate="RadDropDownList2" ErrorMessage="Account Type is required">
                                </asp:RequiredFieldValidator>

                                <span>

                                    <span class="inlineLabel" style="font-weight:bold !important;">Account Status</span>
                                    <telerik:RadDropDownList ID="RadDropDownList1" runat="server" SelectedValue='<%# Bind("status")%>' AppendDataBoundItems="true">
                                        <Items>
                                            <telerik:DropDownListItem Text="- Select -" Value=""></telerik:DropDownListItem>
                                            <telerik:DropDownListItem Text="Active" Value="Active"></telerik:DropDownListItem>
                                            <telerik:DropDownListItem Text="Previous Active" Value="Previous Active"></telerik:DropDownListItem>
                                            <telerik:DropDownListItem Text="Pending" Value="Pending"></telerik:DropDownListItem>
                                            <telerik:DropDownListItem Text="Target" Value="Target"></telerik:DropDownListItem>
                                        </Items>
                                    </telerik:RadDropDownList>
                                </span>



                            </div>
                        </div>

                        <div class="form-spacer"></div>

                        <div class="form-group">
                            <label for="brandChampionCheckBox" class="col-sm-3 control-label">Brand Champion</label>
                            <div class="col-sm-7">
                                <asp:CheckBox ID="brandChampionCheckBox" runat="server" Checked='<%# Bind("brandChampion") %>' />
                                <span id="helpBlock" class="help-block">Check if this Account is a Brand Champion.</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phoneTextBox" class="col-sm-3 control-label">Phone</label>
                            <div class="col-sm-7">

                                <telerik:RadMaskedTextBox RenderMode="Lightweight" ID="PhoneNumberTextBox" runat="server" Mask="(###) ###-####" Text='<%# Bind("phone") %>' Height="35px">
                                </telerik:RadMaskedTextBox>
                                
                            </div>
                        </div>

                        <div class="form-spacer"></div>

                        <div class="form-group">
                            <label for="streetAddress1TextBox" class="col-sm-3 control-label">Address 1 <span class="text-danger">*</span></label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="streetAddress1TextBox" runat="server" Text='<%# Bind("streetAddress1") %>' CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="errorlabel" Display="Dynamic" ControlToValidate="streetAddress1TextBox" ErrorMessage="Address 1 is required" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="streetAddress2TextBox" class="col-sm-3 control-label">Address 2</label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="streetAddress2TextBox" runat="server" Text='<%# Bind("streetAddress2") %>' CssClass="form-control" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="cityTextBox" class="col-sm-3 control-label">City <span class="text-danger">*</span></label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="errorlabel" Display="Dynamic" ControlToValidate="cityTextBox" ErrorMessage="City is required" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="stateTextBox" class="col-sm-3 control-label">State <span class="text-danger">*</span></label>
                            <div class="col-sm-9">

                                <telerik:RadDropDownList ID="DropDownListState1" runat="server" DataTextField="stateName" DataValueField="stateCode" SelectedValue='<%# Bind("state") %>' DataSourceID="GetStateList">
                                </telerik:RadDropDownList>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="errorlabel" Display="Dynamic" ControlToValidate="DropDownListState1" ErrorMessage="State is required" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>


                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetStateList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="StateName" TableName="tblStates"></asp:LinqDataSource>

                                <span class="inlineLabel" style="font-weight:bold !important;">Zip <span class="text-danger">*</span></span>

                                <telerik:RadMaskedTextBox RenderMode="Lightweight" ID="RadMaskedTextBox1" runat="server" Mask="#####" Text='<%# Bind("zipCode") %>'
                                  Height="35px">
                                </telerik:RadMaskedTextBox>

                                <div style="margin-left: 45.5% !important;">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="errorlabel" Display="Static" ControlToValidate="RadMaskedTextBox1" ErrorMessage="Zip is required" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>
                                    </div>





                            </div>
                        </div>



                        <div class="form-spacer"></div>

                        <div class="form-group">
                            <label for="neighborhoodTextBox" class="col-sm-3 control-label">Neighborhood</label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="neighborhoodTextBox" runat="server" Text='<%# Bind("neighborhood") %>' CssClass="form-control" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="marketIDTextBox" class="col-sm-3 control-label">Market <span class="text-danger">*</span></label>
                            <div class="col-sm-7">


                                <telerik:RadDropDownList ID="marketIDddl1" runat="server" DataSourceID="getMarketList" SelectedValue='<%# Bind("marketID") %>'
                                    DataTextField="marketName" DataValueField="marketID">
                                </telerik:RadDropDownList>

                            </div>
                        </div>

                        <div class="form-spacer"></div>

                        <div class="form-group">
                            <label for="distributorNameTextBox" class="col-sm-3 control-label">Distributor Name</label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="distributorNameTextBox" runat="server" Text='<%# Bind("distributorName") %>' CssClass="form-control" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="distributorIDTextBox" class="col-sm-3 control-label">Distributor ID</label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="distributorIDTextBox" runat="server" Text='<%# Bind("distributorID") %>' CssClass="form-control" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="supplierIDTextBox" class="col-sm-3 control-label">Supplier ID</label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="supplierIDTextBox" runat="server" Text='<%# Bind("supplierID") %>' CssClass="form-control" />
                            </div>
                        </div>

                        <div class="form-spacer"></div>

                        <div class="form-group">
                            <label for="websiteTextBox" class="col-sm-3 control-label">Website</label>
                            <div class="col-sm-7">
                                <div class="input-group">
                                    <span class="input-group-addon" id="basic-addon3">http://</span>
                                    <asp:TextBox ID="websiteTextBox" runat="server" Text='<%# Bind("website")%>' CssClass="form-control" />



                                </div>

                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="websiteTextBox" SetFocusOnError="true"
                                    Text="Invalid URL" ValidationExpression="[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$" runat="server" CssClass="errorlabel" />

                            </div>
                        </div>

                        <div class="form-group">
                            <label for="FacebookTextBox" class="col-sm-3 control-label">Facebook</label>
                            <div class="col-sm-7">
                                <div class="input-group">
                                    <span class="input-group-addon" id="basic-addon43">http://</span>
                                    <asp:TextBox ID="FacebookTextBox" runat="server" Text='<%# Bind("facebook")%>' CssClass="form-control" />



                                </div>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="FacebookTextBox" SetFocusOnError="true"
                                    Text="Invalid URL" ValidationExpression="[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$" runat="server" CssClass="errorlabel" />

                            </div>
                        </div>

                        <div class="form-group">
                            <label for="TwitterTextBox" class="col-sm-3 control-label">Twitter</label>
                            <div class="col-sm-7">
                                <div class="input-group">
                                    <span class="input-group-addon" id="basic-addon">http://</span>
                                    <asp:TextBox ID="TwitterTextBox" runat="server" Text='<%# Bind("twitter")%>' CssClass="form-control" />


                                </div>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="TwitterTextBox" SetFocusOnError="true"
                                    Text="Invalid URL" ValidationExpression="[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$" runat="server" CssClass="errorlabel" />


                            </div>
                        </div>

                        <div class="form-group">
                            <label for="YelpTextBox" class="col-sm-3 control-label">Yelp</label>
                            <div class="col-sm-7">
                                <div class="input-group">
                                    <span class="input-group-addon" id="basic-addon6">http://</span>
                                    <asp:TextBox ID="YelpTextBox" runat="server" Text='<%# Bind("yelp") %>' CssClass="form-control" />


                                </div>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate="YelpTextBox" SetFocusOnError="true"
                                    Text="Invalid URL" ValidationExpression="[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$" runat="server" CssClass="errorlabel" />
                            </div>
                        </div>


                    </div>

                    <div style="margin: 12px 0 12px 0">
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-primary btn-sm" />
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False"
                            CommandName="Cancel" Text="Cancel" CssClass="btn btn-default btn-sm" />
                    </div>
                    <!-- end form -->
                </div>
            </div>
            <!-- end row -->


        </EditItemTemplate>

        <ItemTemplate>

            <div class="btn-group pull-right" role="group" aria-label="..." style="margin: 12px 0 24px 0">

                <asp:LoginView ID="LoginView_EditButton" runat="server">
                    <RoleGroups>
                        <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                            <ContentTemplate>
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-default"><i class="fa fa-pencil"></i> Edit Details</asp:LinkButton>
                            </ContentTemplate>
                        </asp:RoleGroup>
                    </RoleGroups>
                </asp:LoginView>

                
                <asp:LoginView ID="LoginView_DeleteButton" runat="server">
                    <RoleGroups>
                        <asp:RoleGroup Roles="Administrator, Recruiter/Booking">
                            <ContentTemplate>
                                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="DeleteAccount" CommandArgument='<%# Eval("accountID") %>' Text="Delete"
                                    CssClass="btn btn-danger" OnClientClick="javascript:if(!confirm('This action will delete the selected account and all the history. Are you sure?')){return false;}">
                                        <i class="fa fa-trash"></i> Delete Account</asp:LinkButton>
                            </ContentTemplate>
                        </asp:RoleGroup>
                    </RoleGroups>
                </asp:LoginView>




            </div>

            <div class="clearfix"></div>

            <!-- start column here -->
            <div class="row">
                <div class="col-md-6">
                    <div>
                        <label>Account Name:</label>
                        <asp:Label ID="accNameLabel" runat="server" Text='<%# Bind("accountName") %>' />
                    </div>
                    <div>
                        <label>Company Name:</label>
                        <asp:Label ID="CompanyNameLabel" runat="server" Text='<%# Bind("DBAName") %>' />
                    </div>
                    <div>
                        <label>Account ID:</label>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("accountID")%>' />
                    </div>
                    <div>
                        <label>Account Status:</label>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("status")%>' />
                    </div>
                    <div>
                        <label>Account Type:</label>
                        <asp:Label ID="accountTypeLabel" runat="server" Text='<%#Common.getAccountTypeName(Eval("accountTypeID"))%>' />
                    </div>

                    <br />
                </div>
                <!-- -->
                <div class="col-md-6">
                    <div>
                        <label>Address 1:</label>
                        <asp:Label ID="streetAddress1Label" runat="server" Text='<%# Bind("streetAddress1") %>' />
                    </div>
                    <div>
                        <label>Address 2:</label>
                        <asp:Label ID="streetAddress2Label" runat="server" Text='<%# Bind("streetAddress2") %>' />
                    </div>
                    <div>
                        <label>City:</label>
                        <asp:Label ID="cityLabel" runat="server" Text='<%# Bind("city") %>' />
                    </div>
                    <div>
                        <label>State:</label>
                        <asp:Label ID="stateLabel" runat="server" Text='<%# Bind("state") %>' />
                    </div>
                    <div>
                        <label>Zip:</label>
                        <asp:Label ID="zipCodeLabel" runat="server" Text='<%# Bind("zipCode") %>' />
                    </div>

                    <br />

                </div>
                <!-- -->
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div>
                        <label>Neighborhood:</label>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("neighborhood") %>' />
                    </div>
                    <div>
                        <label>Market:</label>
                        <asp:Label ID="MarketLabel" runat="server" Text='<%# Common.getMarketName(Eval("marketID"))%>' />
                    </div>

                    <br />

                    <div>
                        <label>Distributer Name:</label>
                        <asp:Label ID="distributorNameLabel" runat="server" Text='<%# Bind("distributorName") %>' />
                    </div>
                    <div>
                        <label>Distributer's ID:</label>
                        <asp:Label ID="distributorIDLabel" runat="server" Text='<%# Bind("distributorID") %>' />
                    </div>
                    <br />

                    <div>
                        <label>Supplier ID:</label>
                        <asp:Label ID="supplierIDLabel" runat="server" Text='<%# Bind("supplierID") %>' />
                    </div>

                    <div>
                        <label>Brand Champion:</label>
                        <asp:CheckBox ID="liveMusicCheckBox" runat="server" Checked='<%# Bind("brandChampion") %>' Enabled="false" />
                    </div>

                </div>

                <div class="col-md-6" style="margin-bottom:15px;">
                    <div>
                        <label>Phone:</label>

                        <asp:Label ID="Label3" runat="server" Text='<%# Common.FormatPhoneNumber(Eval("phone")) %>' />
                    </div>

                    <asp:Panel ID="WebsitePanel" runat="server" Visible='<%# HasValue(Eval("website"))%>'>
                        <div>
                            <i class="fa fa-globe" aria-hidden="true"></i> <a href='http://<%# Eval("website")%>' target="_blank">Website</a>
                        </div>
                    </asp:Panel>
                   
                    <asp:Panel ID="Panel2" runat="server" Visible='<%# HasValue(Eval("facebook"))%>'>
                     <div>
                        <i class="fa fa-facebook-official" aria-hidden="true"></i> <a href='http://<%# Eval("facebook")%>' target="_blank">Facebook</a>
                    </div>
                        </asp:Panel>

                    <asp:Panel ID="Panel3" runat="server" Visible='<%# HasValue(Eval("twitter"))%>'>
                    <div>
                        <i class="fa fa-twitter" aria-hidden="true"></i> <a href='http://<%# Eval("twitter")%>' target="_blank">Twitter</a>
                    </div>
                        </asp:Panel>

                    <asp:Panel ID="Panel4" runat="server" Visible='<%# HasValue(Eval("yelp"))%>'>
                    <div>
                        <i class="fa fa-yelp" aria-hidden="true"></i> <a href='http://<%# Eval("yelp")%>' target="_blank">Yelp</a>
                    </div>
                        </asp:Panel>

                </div>
            </div>

        </ItemTemplate>

    </asp:FormView>
    <asp:LinqDataSource ID="getAccountInformation" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableUpdate="True" EntityTypeName="" TableName="tblAccounts" Where="accountID == @accountID">
        <WhereParameters>
            <asp:QueryStringParameter Name="accountID" QueryStringField="AccountID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>


</asp:Panel>

<asp:LinqDataSource ID="getAccountType" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="accountTypeName" TableName="tblAccountTypes" Where="active == @active">
    <WhereParameters>
        <asp:Parameter DefaultValue="True" Name="active" Type="Boolean" />
    </WhereParameters>
</asp:LinqDataSource>







<asp:LinqDataSource ID="getMarketList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="marketName" TableName="tblMarkets">
</asp:LinqDataSource>


