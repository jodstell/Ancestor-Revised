<%@ Page Title="View Users" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewUsersList.aspx.vb" Inherits="EventManagerApplication.ViewUsersList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript">
        function CreateWindowScriptFilter() {
            $find("<%=RadWindowAdvancedFilter.ClientID %>").show();
        }

        function ShowEditForm(id, rowIndex) {
            var grid = $find("<%= StaffList.ClientID %>");

            var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
            grid.get_masterTableView().selectItem(rowControl, true);

            window.radopen("/admin/users/userprofile?UserID=" + id, "UserListDialog");
            return false;
        }
        
        function refreshGrid(arg) {
            if (!arg) {
                $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("Rebind");
            }
            else {
                $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("RebindAndNavigate");
            }
        }


    </script>
</telerik:RadScriptBlock>


    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UsersPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="UsersPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UsersPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="StaffList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="StaffList" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>        
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<div class="container">
    <div class="row">
        <div class="col-md-12">

            <h2>Users</h2>
            <hr />

            <div class="widget stacked">
                <div class="widget-content min-height">

<asp:Panel ID="UsersPanel" runat="server">
                        <asp:Button ID="btnBackUsers" runat="server" Text="Back To Site Administration" CssClass="btn btn-default" />


                    <div style="margin-top:10px;">

                        <telerik:RadGrid ID="StaffList" runat="server" DataSourceID="getStaffList"
                            AllowPaging="True"
                            AllowSorting="True"
                            ShowFooter="True"
                            ShowStatusBar="true"
                            AllowFilteringByColumn="True"
                            PageSize="20" CellSpacing="-1"
                            FilterType="HeaderContext"
                            EnableHeaderContextMenu="true"
                            EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="EventDataGrid_FilterCheckListItemsRequested">


                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true"></ExportSettings>

                            <MasterTableView DataKeyNames="userID" DataSourceID="getStaffList" AutoGenerateColumns="False" CommandItemDisplay="Top" AllowSorting="true">
                                <NoRecordsTemplate>

                                    <br />
                                    <div class="col-md-12">
                                        <div class="alert alert-warning" role="alert"><strong>No Results Found.</strong>  Please adjust your filter options.</div>
                                    </div>

                                </NoRecordsTemplate>



                                <CommandItemTemplate>
                                    <div style="padding: 3px 0 3px 5px">
                                        <asp:LinkButton ID="btnAddNew" runat="server" CssClass="btn btn-success btn-sm" ForeColor="White" CommandName="NewUser"> <i class="fa fa-plus"></i> Add New User</asp:LinkButton>
                                        <asp:LinkButton ID="btnAdvancedFilters" runat="server" OnClientClick="CreateWindowScriptFilter()" CssClass="btn btn-primary btn-sm" ForeColor="White" Visible="false"><i class="fa fa-filter"></i> Advanced Filters</asp:LinkButton>
                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>


                                        <div class="pull-right" style="padding-right: 3px">

                                            <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export to Excel</asp:LinkButton>
                                        </div>
                                </CommandItemTemplate>

                                <Columns>

                                    <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewButton">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnViewProfile" CommandName="ViewProfile" runat="server" CommandArgument='<%# Eval("UserID")%>' CssClass="btn btn-primary btn-xs" ForeColor="White">
                                                View Profile &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="firstName" HeaderText="First Name" CurrentFilterFunction="Contains" SortExpression="firstName" UniqueName="firstName" FilterControlAltText="Filter firstName column"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="lastName" HeaderText="Last Name" SortExpression="lastName" CurrentFilterFunction="Contains" UniqueName="lastName" FilterControlAltText="Filter lastName column"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="roleName" HeaderText="Role" SortExpression="roleName" CurrentFilterFunction="Contains" UniqueName="roleName" FilterControlAltText="Filter roleName column"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Clients" HeaderText="Clients" CurrentFilterFunction="Contains" SortExpression="Clients" UniqueName="Clients" FilterControlAltText="Filter Clients column"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Markets" HeaderText="Markets" SortExpression="Markets" UniqueName="Markets" FilterControlAltText="Filter Markets column" ItemStyle-Width="20%"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Suppliers" HeaderText="Suppliers" SortExpression="Suppliers" UniqueName="Suppliers" FilterControlAltText="Filter Suppliers column"></telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="Last Login Date" SortExpression="lastLoginDate" AllowFiltering="false">
                            <ItemTemplate>

                                <asp:Label ID="lastLoginDateLabel" runat="server" Text='<%# GetTimeAdjustment(Eval("lastLoginDate"))%>' />

                            </ItemTemplate>
                        </telerik:GridTemplateColumn>


                                    <telerik:GridTemplateColumn HeaderText="Online">
                                        <ItemTemplate>
                                            <%# getOnlineStatus(Eval("UserID")) %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="DeleteButton">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnDeleteProfile" CommandName="DeleteProfile" runat="server" CommandArgument='<%# Eval("UserID")%>' CssClass="btn btn-danger btn-xs" ForeColor="White" OnClientClick="javascript:if(!confirm('This action will delete the selected user. Are you sure?')){return false;}">
                                                <i class="fa fa-trash"></i>&nbsp;&nbsp;Delete User</asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                </Columns>
                            </MasterTableView>

                            <PagerStyle Position="TopAndBottom"></PagerStyle>

                        </telerik:RadGrid>


                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getStaffList"
                            ContextTypeName="EventManagerApplication.UserDataClassesDataContext"
                            OrderBy="lastLoginDate desc" TableName="qryViewStaffListings">
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


</asp:Panel>

                </div>
            </div>
        </div>
    </div>
</div>


    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" Behaviors="Close,Move">
        <Windows>
            <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Height="700px"
                Width="1200px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" CssClass="windowcss" VisibleStatusbar="false" Behaviors="Close,Move" AutoSizeBehaviors="Height, Width">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    
</asp:Content>
