<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ActivitiesControl.ascx.vb" Inherits="EventManagerApplication.ActivitiesControl" %>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <div class="pull-right">

        <div class="dropdown">
  <button class="btn btn-sm btn-success dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
    <i class="fa fa-plus"></i> Add New Activity <span class="caret"></span>
  </button>

            <asp:Repeater ID="btnAddNew" runat="server" DataSourceID="getActivityTypeList">
                <HeaderTemplate>
                 <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                </HeaderTemplate>

                <ItemTemplate>

<li><a href='/accounts/newactivity?AccountID=<%= Request.QueryString("AccountID") %>&Mode=New&ActivityTypeID=<%# Eval("activityTypeID") %>'><%# Eval("activityName") %></a></li>
                </ItemTemplate>


                <FooterTemplate>
</ul>
                </FooterTemplate>
            </asp:Repeater>


</div>

    </div>

     <asp:LinqDataSource ID="getActivityTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="activityName" TableName="qryViewActivityTypeByClients" Where="clientID == @clientID">
        <WhereParameters>
            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
        </WhereParameters>
    </asp:LinqDataSource>




    <asp:Repeater ID="ActivitiesList" runat="server" DataSourceID="getActivities">
        <HeaderTemplate>
            <table class="table" cellspacing="0" style="width: 100%;">
                <thead>
                    <tr>
                        <th style="width: 7%;">&nbsp;</th>
                        <th style="width: 20%;">Date</th>
                        <th style="width: 20%;">Type</th>
                        <th style="width: 53%;">Status</th>
                    </tr>
                </thead>                 
        </HeaderTemplate>
        <ItemTemplate>
            <tr class="rlvI">
                <td>

                    <div class="btn-group" role="group">

                        <a href="/accounts/editactivity?ActivityID=<%# Eval("accountActivityID")%>&AccountID=<%# Request.QueryString("AccountID")%>&Mode=View"
                            class="btn btn-primary btn-xs"style="color: #fff">View &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>

                       <%-- <asp:LoginView ID="LoginView_AddButton" runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, Accounting">
                                    <ContentTemplate>
                                        <a href="/accounts/editactivity?ActivityID=<%# Eval("accountActivityID")%>&AccountID=<%# Request.QueryString("AccountID")%>&Mode=Edit"
                                            class="btn btn-xs btn-primary">Edit</a>
                                    </ContentTemplate>
                                </asp:RoleGroup>
                            </RoleGroups>
                        </asp:LoginView>

                        <asp:LoginView ID="LoginView1" runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles="Administrator, EventManager, Accounting">
                                    <ContentTemplate>
                                        <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger"
                                            Text="Delete" ToolTip="Delete" OnClientClick="javascript:if(!confirm('This action will delete the selected activity. Are you sure?')){return false;}" />
                                    </ContentTemplate>
                                </asp:RoleGroup>
                            </RoleGroups>
                        </asp:LoginView>--%>

                    </div>

                </td>
                <td>
                    <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("activityDate", "{0:D}")%>' />
                </td>
                <td>
                    <asp:Label ID="typeLabel" runat="server" Text='<%# Eval("ActivityName")%>' />
                </td>

                 <td>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("status")%>' />
                </td>

                 
            </tr>
        </ItemTemplate>
        <FooterTemplate>
                                    
            </tbody>
            
            </table>

            <div style='margin: 8px;'>
        <asp:Label ID="lblEmptyData" Text='<%# Common.ShowAlertNoClose("warning", "There are no activity to display.")%>' runat="server" Visible="false"></asp:Label> 
                </div>

        </FooterTemplate>

    </asp:Repeater>



    <asp:LinqDataSource ID="getActivities" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="qryGetAccountActivities" Where="accountID == @accountID" OrderBy="activityDate desc">
        <WhereParameters>
            <asp:QueryStringParameter Name="accountID" QueryStringField="AccountID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>


</telerik:RadAjaxPanel>
