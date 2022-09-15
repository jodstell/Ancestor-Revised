<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AccountActivitiesControl.ascx.vb" Inherits="EventManagerApplication.AccountActivitiesControl" %>



<asp:Label ID="msgLabel" runat="server" />

    <asp:Panel ID="GridPanel" runat="server">
        <telerik:RadGrid ID="ActivityTypeList" runat="server" DataSourceID="getActivityTypebyClientList"
            AllowSorting="True"
            AllowPaging="True"
            ShowFooter="True"
            ShowStatusBar="true"
            AllowCustomPaging="True"
            Skin="Bootstrap"
            AllowFilteringByColumn="True"
            CellSpacing="-1"
            PageSize="20">

            <PagerStyle Position="TopAndBottom" />

            <MasterTableView AutoGenerateColumns="False" DataKeyNames="activityTypeID" CommandItemDisplay="Top" DataSourceID="getActivityTypebyClientList">

                <RowIndicatorColumn>
                    <HeaderStyle Width="20px"></HeaderStyle>
                </RowIndicatorColumn>

                <CommandItemTemplate>
                    <div style="padding: 3px 0 3px 5px">
                        <asp:LinkButton ID="btnAddNew" runat="server" CommandName="AddNew" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Account Activity</asp:LinkButton>
                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                        <div class="pull-right" style="padding-right: 3px">
                            <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                        </div>
                </CommandItemTemplate>

                <Columns>

                    <telerik:GridTemplateColumn AllowFiltering="false">
                        <ItemStyle Width="75px" />
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="activityName"
                        FilterControlAltText="Filter activityName column"
                        HeaderText="Name"
                        SortExpression="activityName"
                        UniqueName="activityName">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>

                        <FilterTemplate>

                            <telerik:RadComboBox ID="RadComboBox_activityName" DataSourceID="getEventTypeList" DataTextField="activityName"
                                DataValueField="activityName" Height="200px" Width="320px" AppendDataBoundItems="true"
                                SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("activityName").CurrentFilterValue%>'
                                runat="server" OnClientSelectedIndexChanged="activityNameIndexChanged">
                                <Items>
                                    <telerik:RadComboBoxItem Text="All" />
                                </Items>
                            </telerik:RadComboBox>

                            <telerik:RadScriptBlock ID="RadScriptBlock_activityName" runat="server">

                                <script type="text/javascript">
                                    function activityNameIndexChanged(sender, args) {
                                        var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                    tableView.filter("activityName", args.get_item().get_value(), "EqualTo");
                                }
                                </script>

                            </telerik:RadScriptBlock>

                        </FilterTemplate>

                    </telerik:GridBoundColumn>


                    <telerik:GridTemplateColumn HeaderText="Active" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <ItemTemplate>
                            <asp:LinkButton ID="BtnActive" runat="server" CommandName="SetActive" CommandArgument='<%# Eval("activityTypeID") %>' ForeColor="White">
                                <asp:Label ID="ActiveLabel" runat="server" />
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>


                    <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-xs btn-danger" ForeColor="White" CommandName="DeleteActivityType" CommandArgument='<%# Eval("activityTypeID") %>'
                                OnClientClick="javascript:if(!confirm('This action will delete the selected activity type for All clients. Are you sure?')){return false;}"><i class="fa fa-trash" aria-hidden="true"></i> Delete</asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </asp:Panel>

<asp:Panel ID="AddNewItemPanel" runat="server" Visible="false">

    <div class="row">
        <div class="col-xs-12">
            <h2>Add Activity Type</h2>

            <p>
                Use this form to add a new activity type.  Complete each section below and click on the Next button to continue to the next tab.<br />
                Fields marked with asterisk (<span class="text-danger">*</span>) are required.
            </p>

        </div>
    </div>

    <asp:Label ID="msgLabel2" runat="server" />


    <div class="form-horizontal">
        <h3>Settings</h3>

        <div class="form-group">
            <label for="accountNameTextBox" class="col-sm-2 control-label">Activity Name</label>
            <div class="col-sm-4">
                <asp:TextBox ID="accountNameTextBox" runat="server" Text='' CssClass="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label for="accountNameTextBox" class="col-sm-2 control-label">Active</label>
            <div class="col-sm-2">
                <asp:DropDownList ID="ActiveList" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Yes"></asp:ListItem>
                    <asp:ListItem Text="No"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="form-group">
            <label for="accountNameTextBox" class="col-sm-2 control-label">Display Order</label>
            <div class="col-sm-2">
                <asp:TextBox ID="TextBox2" runat="server" Text='0' CssClass="form-control" />
            </div>
        </div>

        <br />

        <h3>Columns</h3>

    </div>


</asp:Panel>


<asp:Button ID="Button1" runat="server" Text="Button" />


<script type="text/javascript">
    function requestStart(sender, args) {
        if (args.get_eventTarget().indexOf("btnExport") >= 0) {
            args.set_enableAjax(false);
        }
    }


</script>

<asp:LinqDataSource runat="server" EntityTypeName="" ID="getActivityTypebyClientList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="activityName" TableName="tblActivityTypes" Where="isDeleted == @isDeleted">
    <WhereParameters>
        <asp:Parameter DefaultValue="False" Name="isDeleted" Type="Boolean"></asp:Parameter>
    </WhereParameters>
</asp:LinqDataSource>

  
    <asp:SqlDataSource ID="getEventTypeList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT activityName FROM tblActivityType"
        runat="server">
        
    </asp:SqlDataSource>


