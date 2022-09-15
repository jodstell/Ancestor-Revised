<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AccountDemographicsControl.ascx.vb" Inherits="EventManagerApplication.AccountDemographicsControl" %>


<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="AccountDemographicsList2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="AccountDemographicsList2" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>


<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <asp:Panel runat="server" ID="AccountDemographicsList2">
    <asp:FormView ID="AccountDemographicsList" runat="server" DataKeyNames="accountDemographicID" DataSourceID="getAccountDemographics" Width="100%">


        <EditItemTemplate>

            <div style="margin: 12px 0 12px 0">
                <asp:LoginView ID="LoginView_AddButton" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                                <ContentTemplate>
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-primary btn-sm" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default btn-sm" />
                                    </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>
            </div>
            <div class="clearfix"></div>
            <div class="col-md-3">
                <h3>Race Demographics</h3>

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
                                <%--<asp:TextBox ID="caucasianTextBox" runat="server" Text='<%# Bind("caucasian") %>' CssClass="form-control input-sm" Width="100px" />--%>
                        <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" DbValue='<%# Bind("caucasian") %>' Width="100px" NumberFormat-DecimalDigits="0" DataType="Int32" Type="Percent">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>African American</td>
                            <td>
                                <%--<asp:TextBox ID="africanAmericanTextBox" runat="server" Text='<%# Bind("africanAmerican") %>' CssClass="form-control input-sm" Width="100px" />--%>
                        <telerik:RadNumericTextBox ID="RadNumericTextBox2" runat="server" NumberFormat-DecimalDigits="0" Width="100px" DbValue='<%# Bind("africanAmerican") %>' DataType="Int32" Type="Percent">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Hispanic</td>
                            <td>
                                <%--<asp:TextBox ID="hispanicTextBox" runat="server" Text='<%# Bind("hispanic") %>' CssClass="form-control input-sm" Width="100px" />--%>
                        <telerik:RadNumericTextBox ID="RadNumericTextBox3" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("hispanic") %>' Width="100px" DataType="Int32" Type="Percent">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Asian</td>
                            <td>
                                <%--<asp:TextBox ID="asianTextBox" runat="server" Text='<%# Bind("asian") %>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox4" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("asian") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Other</td>
                            <td>
                                <%--<asp:TextBox ID="otherTextBox" runat="server" Text='<%# Bind("other") %>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox5" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("other") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="col-md-3">
                <h3>Age Demographics</h3>

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
                                <%--<asp:TextBox ID="_21_25TextBox" runat="server" Text='<%# Bind("_21_25") %>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox6" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("_21_25") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>26-30</td>
                            <td>
                                <%--<asp:TextBox ID="_26_30TextBox" runat="server" Text='<%# Bind("_26_30") %>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox7" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("_26_30") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>31-35</td>
                            <td>
                                <%--<asp:TextBox ID="_31_35TextBox" runat="server" Text='<%# Bind("_31_35") %>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox8" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("_31_35") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>36-40</td>
                            <td>
                                <%--<asp:TextBox ID="_36_40TextBox" runat="server" Text='<%# Bind("_36_40") %>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox9" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("_36_40") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>40+</td>
                            <td>
                                <%--<asp:TextBox ID="_40_TextBox" runat="server" Text='<%# Bind("_40_") %>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox10" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("_40_") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="col-md-3">
                <h3>Consumer Income</h3>

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
                                <%--<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("income20to35")%>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox11" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("income20to35") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>$36K-$50K</td>
                            <td>
                                <%--<asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("income36to50")%>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox12" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("income36to50") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>$51K-$75K</td>
                            <td>
                                <%--<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("income51to75")%>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox13" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("income51to75") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>$76K-$100K</td>
                            <td>
                                <%--<asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("income76to100")%>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox14" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("income76to100") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>$100K+</td>
                            <td>
                                <%--<asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("income100plus")%>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox15" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("income100plus") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="col-md-3">
                <h3>Gender Demographics</h3>

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
                                <%--<asp:TextBox ID="maleTextBox" runat="server" Text='<%# Bind("male") %>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox16" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("male") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Female</td>
                            <td>
                                <%--<asp:TextBox ID="femaleTextBox" runat="server" Text='<%# Bind("female") %>' CssClass="form-control input-sm" Width="100px" />--%>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox17" runat="server" NumberFormat-DecimalDigits="0" DbValue='<%# Bind("female") %>' Width="100px" Type="Percent" DataType="Int32">
                        </telerik:RadNumericTextBox>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>

        </EditItemTemplate>

        <ItemTemplate>
            <div class="pull-right">
                <asp:LoginView ID="LoginView_AddButton" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                                <ContentTemplate>
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CssClass="btn btn-default btn-sm" CommandName="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                                    </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>
            </div>
            <div class="clearfix"></div>

            <div class="col-md-3">
                <h3>Race Demographics</h3>

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
                                <asp:Label ID="caucasianLabel" runat="server" Text='<%# Bind("caucasian") %>' /></td>
                        </tr>
                        <tr>
                            <td>African American</td>
                            <td>
                                <asp:Label ID="africanAmericanLabel" runat="server" Text='<%# Bind("africanAmerican") %>' /></td>
                        </tr>
                        <tr>
                            <td>Hispanic</td>
                            <td>
                                <asp:Label ID="hispanicLabel" runat="server" Text='<%# Bind("hispanic") %>' /></td>
                        </tr>
                        <tr>
                            <td>Asian</td>
                            <td>
                                <asp:Label ID="asianLabel" runat="server" Text='<%# Bind("asian") %>' /></td>
                        </tr>
                        <tr>
                            <td>Other</td>
                            <td>
                                <asp:Label ID="otherLabel" runat="server" Text='<%# Bind("other") %>' /></td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="col-md-3">
                <h3>Age Demographics</h3>

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
                                <asp:Label ID="_21_25Label" runat="server" Text='<%# Bind("_21_25") %>' /></td>
                        </tr>
                        <tr>
                            <td>26-30</td>
                            <td>
                                <asp:Label ID="_26_30Label" runat="server" Text='<%# Bind("_26_30") %>' /></td>
                        </tr>
                        <tr>
                            <td>31-35</td>
                            <td>
                                <asp:Label ID="_31_35Label" runat="server" Text='<%# Bind("_31_35") %>' /></td>
                        </tr>
                        <tr>
                            <td>36-40</td>
                            <td>
                                <asp:Label ID="_36_40Label" runat="server" Text='<%# Bind("_36_40") %>' /></td>
                        </tr>
                        <tr>
                            <td>40+</td>
                            <td>
                                <asp:Label ID="_40_Label" runat="server" Text='<%# Bind("_40_") %>' /></td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="col-md-3">
                <h3>Consumer Income</h3>

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
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("income20to35")%>' /></td>
                        </tr>
                        <tr>
                            <td>$36K-$50K</td>
                            <td>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("income36to50")%>' /></td>
                        </tr>
                        <tr>
                            <td>$51K-$75K</td>
                            <td>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("income51to75")%>' /></td>
                        </tr>
                        <tr>
                            <td>$76K-$100K</td>
                            <td>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("income76to100")%>' /></td>
                        </tr>
                        <tr>
                            <td>$100K+</td>
                            <td>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("income100plus")%>' /></td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="col-md-3">
                <h3>Gender Demographics</h3>

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
                                <asp:Label ID="maleLabel" runat="server" Text='<%# Bind("male") %>' /></td>
                        </tr>
                        <tr>
                            <td>Female</td>
                            <td>
                                <asp:Label ID="femaleLabel" runat="server" Text='<%# Bind("female") %>' /></td>
                        </tr>

                    </tbody>
                </table>
            </div>

        </ItemTemplate>


    </asp:FormView>
</asp:Panel>

    <asp:LinqDataSource ID="getAccountDemographics" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableUpdate="True" EntityTypeName="" TableName="tblAccountDemographics" Where="accountID == @accountID">
        <WhereParameters>
            <asp:QueryStringParameter Name="accountID" QueryStringField="AccountID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

</telerik:RadAjaxPanel>


