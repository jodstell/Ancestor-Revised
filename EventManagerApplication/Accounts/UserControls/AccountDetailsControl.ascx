<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AccountDetailsControl.ascx.vb" Inherits="EventManagerApplication.AccountDetailsControl" %>

<style>
    .form-group {
        margin-bottom: 10px;
    }

    label {
        width: 125px;
    }

    .lab2 {
        width: 175px;
    }

    .RadInput .riSelect {
        right: 12px !important;
    }
</style>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy2" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel22" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<asp:Panel ID="Panel1" runat="server">

    <asp:FormView ID="FormView1" runat="server" DataKeyNames="accountDetailID" DataSourceID="getAccountDetails" Width="100%">
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

            <div class="form-horizontal">

                <div class="form-group">
                    <label for="capacityTextBox" class="col-sm-5 control-label">Account Capacity:</label>
                    <div class="col-sm-3">
                        <%--<asp:TextBox ID="capacityTextBox" runat="server" Text='<%# Bind("capacity") %>' CssClass="form-control" TextMode="Number" />--%>
                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="RadNumericTextBox1" MinValue="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" DisplayText='<%# Bind("capacity") %>' Width="100px"></telerik:RadNumericTextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="trafficTextBox" class="col-sm-5 control-label">Average Weekly Trafic:</label>
                    <div class="col-sm-3">
                        <%--<asp:TextBox ID="trafficTextBox" runat="server" Text='<%# Bind("traffic")%>' CssClass="form-control" TextMode="Number" />--%>
                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="RadNumericTextBox2" MinValue="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" DisplayText='<%# Bind("traffic") %>' Width="100px"></telerik:RadNumericTextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="barsTextBox" class="col-sm-5 control-label"># of Permament Bars:</label>
                    <div class="col-sm-3">
                        <%--<asp:TextBox ID="barsTextBox" runat="server" Text='<%# Bind("bars") %>' CssClass="form-control" TextMode="Number" />--%>
                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="RadNumericTextBox3" MinValue="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" DisplayText='<%# Bind("bars") %>' Width="100px"></telerik:RadNumericTextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="barStationsTextBox" class="col-sm-5 control-label"># of Bar Stations:</label>
                    <div class="col-sm-3">
                   <%--<asp:TextBox ID="barStationsTextBox" runat="server" Text='<%# Bind("barStations") %>' CssClass="form-control" TextMode="Number" />--%>
                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="RadNumericTextBox4" MinValue="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" DisplayText='<%# Bind("barStations") %>' Width="100px"></telerik:RadNumericTextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="capacityTextBox" class="col-sm-5 control-label">Patio Seating:</label>
                    <div class="col-sm-7">
                        <asp:CheckBox ID="patioSeatingCheckBox" runat="server" Checked='<%# Bind("patioSeating") %>' />
                    </div>
                </div>

                <div class="form-group">
                    <label for="liveMusicCheckBox" class="col-sm-5 control-label">Live Music:</label>
                    <div class="col-sm-7">
                        <asp:CheckBox ID="liveMusicCheckBox" runat="server" Checked='<%# Bind("liveMusic")%>' />
                    </div>
                </div>
                <div class="form-group">
                    <label for="poolTablesCheckBox" class="col-sm-5 control-label">Pool Tables:</label>
                    <div class="col-sm-7">
                        <asp:CheckBox ID="poolTablesCheckBox" runat="server" Checked='<%# Bind("poolTables")%>' />
                    </div>
                </div>
                <div class="form-group">
                    <label for="dartsCheckBox" class="col-sm-5 control-label">Darts:</label>
                    <div class="col-sm-7">
                        <asp:CheckBox ID="dartsCheckBox" runat="server" Checked='<%# Bind("darts") %>' />
                    </div>
                </div>
                <div class="form-group">
                    <label for="arcadeGamesCheckBox" class="col-sm-5 control-label">Arcade Games:</label>
                    <div class="col-sm-7">
                        <asp:CheckBox ID="arcadeGamesCheckBox" runat="server" Checked='<%# Bind("arcadeGames") %>' />
                    </div>
                </div>

                <div class="form-group">
                    <label for="otherGamesTextBox" class="col-sm-5 control-label">Other Games:</label>
                    <div class="col-sm-7">
                        <asp:TextBox ID="otherGamesTextBox" runat="server" Text='<%# Bind("otherGames")%>' CssClass="form-control" TextMode="MultiLine" Rows="4" />
                    </div>
                </div>

            </div>



        </EditItemTemplate>

        <ItemTemplate>

            <div class="pull-right">
                <asp:LoginView ID="LoginView_AddButton" runat="server">
                    <RoleGroups>
                        <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                            <ContentTemplate>
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-default btn-sm" Style="margin: 12px 0 12px 0"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                            </ContentTemplate>
                        </asp:RoleGroup>
                    </RoleGroups>
                </asp:LoginView>
            </div>

            <div class="clearfix"></div>

            <div>
                <label class="lab2">Account Capacity:</label>            
                    <asp:Label ID="capacityLabel" runat="server" Text='<%# Bind("capacity") %>' />
            </div>
            <div>
                <label class="lab2">Average Weekly Traffic:</label>
                <asp:Label ID="trafficLabel" runat="server" Text='<%# Bind("traffic") %>' />
            </div>
            <div>
                <label class="lab2"># of Permament Bars:</label>
                <asp:Label ID="barsLabel" runat="server" Text='<%# Bind("bars") %>' />
            </div>
            <div>
                <label class="lab2"># of Bar Stations:</label>
                <asp:Label ID="barStationsLabel" runat="server" Text='<%# Bind("barStations") %>' />
            </div>
            <div>
                <label class="lab2">Patio Seating:</label>
                <asp:CheckBox ID="patioSeatingCheckBox" runat="server" Checked='<%# Bind("patioSeating") %>' Enabled="false" />
            </div>
            <div>
                <label class="lab2">Live Music:</label>
                <asp:CheckBox ID="liveMusicCheckBox" runat="server" Checked='<%# Bind("liveMusic") %>' Enabled="false" />
            </div>
            <div>
                <label class="lab2">Pool Tables:</label>
                <asp:CheckBox ID="poolTablesCheckBox" runat="server" Checked='<%# Bind("poolTables") %>' Enabled="false" />
            </div>
            <div>
                <label class="lab2">Darts:</label>
                <asp:CheckBox ID="dartsCheckBox" runat="server" Checked='<%# Bind("darts") %>' Enabled="false" />
            </div>
            <div>
                <label class="lab2">Arcade Games:</label>
                <asp:CheckBox ID="arcadeGamesCheckBox" runat="server" Checked='<%# Bind("arcadeGames") %>' Enabled="false" />
            </div>
            <div>
                <label class="lab2">Other Games:</label>
                <asp:Label ID="otherGamesLabel" runat="server" Text='<%# Bind("otherGames") %>' />
            </div>

        </ItemTemplate>
    </asp:FormView>

</asp:Panel>

<asp:LinqDataSource ID="getAccountDetails" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableUpdate="True" EntityTypeName="" TableName="tblAccountDetails" Where="accountID == @accountID">
    <WhereParameters>
        <asp:QueryStringParameter Name="accountID" QueryStringField="AccountID" Type="Int32" />
    </WhereParameters>
</asp:LinqDataSource>




