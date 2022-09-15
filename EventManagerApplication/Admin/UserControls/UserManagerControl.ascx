<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UserManagerControl.ascx.vb" Inherits="EventManagerApplication.UserManagerControl" %>

<style>
    #ctl00_MainContent_UserManagerControl_RadWindowAdvancedFilter_C {
        overflow: hidden !important;
    }
</style>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

                    <div class="portlet-content">

                        <telerik:RadGrid ID="StaffList" runat="server" 
                            AllowPaging="True"
                            AllowSorting="True"
                            ShowFooter="True"
                            ShowStatusBar="true"
                            AllowFilteringByColumn="True"
                            PageSize="20"
                            AllowCustomPaging="True" CellSpacing="-1"
                            FilterType="HeaderContext"
                            EnableHeaderContextMenu="true"
                            EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="EventDataGrid_FilterCheckListItemsRequested">

                            <MasterTableView DataKeyNames="profileID" DataSourceID="getStaffList" AutoGenerateColumns="False" CommandItemDisplay="Top">
                                <NoRecordsTemplate>

                                    <br />
                                    <div class="col-md-12">
                                        <div class="alert alert-warning" role="alert"><strong>No Results Found.</strong>  Please adjust your filter options.</div>
                                    </div>

                                </NoRecordsTemplate>



                                <CommandItemTemplate>
                                    <div style="padding: 3px 0 3px 5px">
                                        <asp:LinkButton ID="btnAddNew" runat="server" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New User</asp:LinkButton>
                                        <asp:LinkButton ID="btnAdvancedFilters" runat="server" OnClientClick="CreateWindowScriptFilter()" CssClass="btn btn-primary btn-sm" ForeColor="White" Visible="false"><i class="fa fa-filter"></i> Advanced Filters</asp:LinkButton>
                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>
                                        

                                        <div class="pull-right" style="padding-right: 3px">

                                            <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                                        </div>
                                </CommandItemTemplate>

                                <Columns>

                                    <telerik:GridTemplateColumn AllowFiltering="false">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnViewProfile" CommandName="ViewProfile" runat="server" CommandArgument='<%# Eval("UserID")%>' CssClass="btn btn-primary btn-xs" ForeColor="White">
                                                View Profile &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="firstName" HeaderText="First Name" SortExpression="firstName" UniqueName="firstName" FilterControlAltText="Filter firstName column"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="lastName" HeaderText="Last Name" SortExpression="lastName" UniqueName="lastName" FilterControlAltText="Filter lastName column"></telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn HeaderText="Roles">
                                        <ItemTemplate>
                                            <%# getRoles(Eval("UserID")) %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Clients" HeaderText="Clients" SortExpression="Clients" UniqueName="Clients" FilterControlAltText="Filter Clients column"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Markets" HeaderText="Markets" SortExpression="Markets" UniqueName="Markets" FilterControlAltText="Filter Markets column" ItemStyle-Width="20%"></telerik:GridBoundColumn>

                                      <telerik:GridBoundColumn DataField="Suppliers" HeaderText="Suppliers" SortExpression="Suppliers" UniqueName="Suppliers" FilterControlAltText="Filter Suppliers column"></telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="lastLoginDate" HeaderText="Last Login Date" SortExpression="lastLoginDate" UniqueName="lastLoginDate" DataType="System.DateTime" FilterControlAltText="Filter lastActivityDate column"></telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn HeaderText="Online">
                                        <ItemTemplate>
                                            <%# getOnlineStatus(Eval("UserID")) %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                </Columns>
                            </MasterTableView>
                            <PagerStyle Position="TopAndBottom"></PagerStyle>
                        </telerik:RadGrid>


                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getStaffList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="lastLoginDate" TableName="qryViewStaffLists">
                                
                            </asp:LinqDataSource>


                        <asp:Panel ID="AddNewUserPanel" runat="server">


                        </asp:Panel>

                    </div>





    <telerik:RadWindow ID="RadWindowAdvancedFilter" runat="server" Modal="true" VisibleOnPageLoad="false" Width="625px" Height="330px" Behaviors="Close,Move" AutoSize="false" Skin="Bootstrap">
        <ContentTemplate>
            
            <div class="widget stacked">
                            <div class="widget-content">

                                <div class="row" style="margin-bottom: 25px;">
                                    <div class="col-sm-12">
                                        <div class="pull-right btn-group" role="group">
                                            <asp:Button ID="btnApplyFilter2" runat="server" Text="Apply Filter" CausesValidation="True" CssClass="btn btn-primary" />
                                            <asp:Button ID="btnCancelFilter2" runat="server" Text="Cancel" CssClass="btn btn-default" OnClick="btnCancelFilter2_Click" />
                                            <asp:Button ID="btnClearFilter2" runat="server" Text="Clear" CssClass="btn btn-default" />
                                        </div>

                                    </div>
                                </div>

                                <div class="row">
                                    
                                    <div class="col-md-6">
                                        
                                        <h4 style="font-weight: bold; color: #3276B1; margin-bottom: 15px;">Suppliers</h4>
                                                                                
                                    </div>

                                    <div class="col-md-6">


                                        <h4 style="font-weight: bold; color: #3276B1; margin-bottom: 10px;">Markets</h4>
                                        <br />
                                        
                                                                                
                                    </div>

                                </div>

                                <br />

                                
                            </div>
                        </div>
               
        </ContentTemplate>  
    </telerik:RadWindow>
           

</telerik:RadAjaxPanel>


<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        $('#ambassadors').addClass('active');

        function CreateWindowScriptFilter() {
            $find("<%=RadWindowAdvancedFilter.ClientID %>").show();
        }

    </script>
</telerik:RadCodeBlock>
