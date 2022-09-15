<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AccountHoursControl.ascx.vb" Inherits="EventManagerApplication.AccountHoursControl" %>


<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="AccountHours2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="AccountHours2" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

 <asp:Panel runat="server" ID="AccountHours2">
    <asp:FormView ID="AccountHours" runat="server" DataKeyNames="accountHoursID" DataSourceID="getAccountHours" Width="100%">
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

            <div class="col-md-6">
                <h3>Hours of Operation</h3>
                <table class="table" cellspacing="0" style="width: 80%;">
                    <thead>
                        <tr>
                            <th>Day</th>
                            <th>Open</th>
                            <th>Close</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Monday</td>
                            <td>
                                <asp:TextBox ID="monOpenTextBox" runat="server" Text='<%# Bind("monOpen") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="monCloseTextBox" runat="server" Text='<%# Bind("monClose") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Tueday</td>
                            <td>
                                <asp:TextBox ID="tuesOpenTextBox" runat="server" Text='<%# Bind("tuesOpen") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="tuesCloseTextBox" runat="server" Text='<%# Bind("tuesClose") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Wednesday</td>
                            <td>
                                <asp:TextBox ID="wedOpenTextBox" runat="server" Text='<%# Bind("wedOpen") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="wedCloseTextBox" runat="server" Text='<%# Bind("wedClose") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Thursday</td>
                            <td>
                                <asp:TextBox ID="thurOpenTextBox" runat="server" Text='<%# Bind("thurOpen") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="thurCloseTextBox" runat="server" Text='<%# Bind("thurClose") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Friday</td>
                            <td>
                                <asp:TextBox ID="friOpenTextBox" runat="server" Text='<%# Bind("friOpen") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="friCloseTextBox" runat="server" Text='<%# Bind("friClose") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Saturday</td>
                            <td>
                                <asp:TextBox ID="satOpenTextBox" runat="server" Text='<%# Bind("satOpen") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="satCloseTextBox" runat="server" Text='<%# Bind("satClose") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Sunday</td>
                            <td>
                                <asp:TextBox ID="sunOpenTextBox" runat="server" Text='<%# Bind("sunOpen") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="sunCloseTextBox" runat="server" Text='<%# Bind("sunClose") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>


            <div class="col-md-6">
                <h3>Busiest Days and Times</h3>
                <table class="table" cellspacing="0" style="width: 80%;">
                    <thead>
                        <tr>
                            <th>Day</th>
                            <th>Open</th>
                            <th>Close</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Monday</td>
                            <td>
                                <asp:TextBox ID="monStartTextBox" runat="server" Text='<%# Bind("monStart") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="monEndTextBox" runat="server" Text='<%# Bind("monEnd") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Tueday</td>
                            <td>
                                <asp:TextBox ID="tuesStartTextBox" runat="server" Text='<%# Bind("tuesStart") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="tuesEndTextBox" runat="server" Text='<%# Bind("tuesEnd") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Wednesday</td>
                            <td>
                                <asp:TextBox ID="wedStartTextBox" runat="server" Text='<%# Bind("wedStart") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="wedEndTextBox" runat="server" Text='<%# Bind("wedEnd") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Thursday</td>
                            <td>
                                <asp:TextBox ID="thurStartTextBox" runat="server" Text='<%# Bind("thurStart") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="thurEndTextBox" runat="server" Text='<%# Bind("thurEnd") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Friday</td>
                            <td>
                                <asp:TextBox ID="friStartTextBox" runat="server" Text='<%# Bind("friStart") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="friEndTextBox" runat="server" Text='<%# Bind("friEnd") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Saturday</td>
                            <td>
                                <asp:TextBox ID="satStartTextBox" runat="server" Text='<%# Bind("satStart") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="satEndTextBox" runat="server" Text='<%# Bind("satEnd") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                        <tr>
                            <td>Sunday</td>
                            <td>
                                <asp:TextBox ID="sunStartTextBox" runat="server" Text='<%# Bind("sunStart") %>' CssClass="form-control input-sm" Width="95px" /></td>
                            <td>
                                <asp:TextBox ID="sunEndTextBox" runat="server" Text='<%# Bind("sunEnd") %>' CssClass="form-control input-sm" Width="95px" /></td>
                        </tr>
                    </tbody>

                </table>
            </div>

        </EditItemTemplate>

        <ItemTemplate>
            <div class="pull-right" style="margin: 12px 0 12px 0">
                <asp:LoginView ID="LoginView_AddButton" runat="server">
                    <RoleGroups>
                        <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, BrandMarketer">
                            <ContentTemplate>
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-default btn-sm"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                            </ContentTemplate>
                        </asp:RoleGroup>
                    </RoleGroups>
                </asp:LoginView>
            </div>

            <div class="clearfix"></div>

            <div class="col-md-6">
                <h3>Hours of Operation</h3>
                <table class="table" cellspacing="0" style="width: 80%;">
                    <thead>
                        <tr>
                            <th>Day</th>
                            <th>Open</th>
                            <th>Close</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Monday</td>
                            <td>
                                <asp:Label ID="monOpenLabel" runat="server" Text='<%# Bind("monOpen") %>' /></td>
                            <td>
                                <asp:Label ID="monCloseLabel" runat="server" Text='<%# Bind("monClose") %>' /></td>
                        </tr>
                        <tr>
                            <td>Tueday</td>
                            <td>
                                <asp:Label ID="tuesOpenLabel" runat="server" Text='<%# Bind("tuesOpen") %>' /></td>
                            <td>
                                <asp:Label ID="tuesCloseLabel" runat="server" Text='<%# Bind("tuesClose") %>' /></td>
                        </tr>
                        <tr>
                            <td>Wednesday</td>
                            <td>
                                <asp:Label ID="wedOpenLabel" runat="server" Text='<%# Bind("wedOpen") %>' /></td>
                            <td>
                                <asp:Label ID="wedCloseLabel" runat="server" Text='<%# Bind("wedClose") %>' /></td>
                        </tr>
                        <tr>
                            <td>Thursday</td>
                            <td>
                                <asp:Label ID="thurOpenLabel" runat="server" Text='<%# Bind("thurOpen") %>' /></td>
                            <td>
                                <asp:Label ID="thurCloseLabel" runat="server" Text='<%# Bind("thurClose") %>' /></td>
                        </tr>
                        <tr>
                            <td>Friday</td>
                            <td>
                                <asp:Label ID="friOpenLabel" runat="server" Text='<%# Bind("friOpen") %>' /></td>
                            <td>
                                <asp:Label ID="friCloseLabel" runat="server" Text='<%# Bind("friClose") %>' /></td>
                        </tr>
                        <tr>
                            <td>Saturday</td>
                            <td>
                                <asp:Label ID="satOpenLabel" runat="server" Text='<%# Bind("satOpen") %>' /></td>
                            <td>
                                <asp:Label ID="satCloseLabel" runat="server" Text='<%# Bind("satClose") %>' /></td>
                        </tr>
                        <tr>
                            <td>Sunday</td>
                            <td>
                                <asp:Label ID="sunOpenLabel" runat="server" Text='<%# Bind("sunOpen") %>' /></td>
                            <td>
                                <asp:Label ID="sunCloseLabel" runat="server" Text='<%# Bind("sunClose") %>' /></td>
                        </tr>
                    </tbody>

                </table>
            </div>


            <div class="col-md-6">
                <h3>Busiest Days and Times</h3>

                <table class="table" cellspacing="0" style="width: 80%;">
                    <thead>
                        <tr>
                            <th>Day</th>
                            <th>Open</th>
                            <th>Close</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Monday</td>
                            <td>
                                <asp:Label ID="monStartLabel" runat="server" Text='<%# Bind("monStart") %>' /></td>
                            <td>
                                <asp:Label ID="monEndLabel" runat="server" Text='<%# Bind("monEnd") %>' /></td>
                        </tr>
                        <tr>
                            <td>Tueday</td>
                            <td>
                                <asp:Label ID="tuesStartLabel" runat="server" Text='<%# Bind("tuesStart") %>' /></td>
                            <td>
                                <asp:Label ID="tuesEndLabel" runat="server" Text='<%# Bind("tuesEnd") %>' /></td>
                        </tr>
                        <tr>
                            <td>Wednesday</td>
                            <td>
                                <asp:Label ID="wedStartLabel" runat="server" Text='<%# Bind("wedStart") %>' /></td>
                            <td>
                                <asp:Label ID="wedEndLabel" runat="server" Text='<%# Bind("wedEnd") %>' /></td>
                        </tr>
                        <tr>
                            <td>Thursday</td>
                            <td>
                                <asp:Label ID="thurStartLabel" runat="server" Text='<%# Bind("thurStart") %>' /></td>
                            <td>
                                <asp:Label ID="thurEndLabel" runat="server" Text='<%# Bind("thurEnd") %>' /></td>
                        </tr>
                        <tr>
                            <td>Friday</td>
                            <td>
                                <asp:Label ID="friStartLabel" runat="server" Text='<%# Bind("friStart") %>' /></td>
                            <td>
                                <asp:Label ID="friEndLabel" runat="server" Text='<%# Bind("friEnd") %>' /></td>
                        </tr>
                        <tr>
                            <td>Saturday</td>
                            <td>
                                <asp:Label ID="satStartLabel" runat="server" Text='<%# Bind("satStart") %>' /></td>
                            <td>
                                <asp:Label ID="satEndLabel" runat="server" Text='<%# Bind("satEnd") %>' /></td>
                        </tr>
                        <tr>
                            <td>Sunday</td>
                            <td>
                                <asp:Label ID="sunStartLabel" runat="server" Text='<%# Bind("sunStart") %>' /></td>
                            <td>
                                <asp:Label ID="sunEndLabel" runat="server" Text='<%# Bind("sunEnd") %>' /></td>
                        </tr>
                    </tbody>
                </table>

            </div>

        </ItemTemplate>
    </asp:FormView>
</asp:Panel>
    <asp:LinqDataSource ID="getAccountHours" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EnableUpdate="True" EntityTypeName="" TableName="tblAccountHours" Where="accountID == @accountID">
        <WhereParameters>
            <asp:QueryStringParameter Name="accountID" QueryStringField="AccountID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>


</telerik:RadAjaxPanel>
