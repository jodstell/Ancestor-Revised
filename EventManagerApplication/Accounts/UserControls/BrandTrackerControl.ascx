<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandTrackerControl.ascx.vb" Inherits="EventManagerApplication.BrandTrackerControl" %>


<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>


<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <style>
        .centered-cell {
            text-align: center;
        }
    </style>
<asp:Panel ID="Panel1" runat="server">
    <telerik:RadListView ID="BrandTrackingList" DataSourceID="getAccountsBrandTrcker" runat="server"
        DataKeyNames="accountBrandTrackerID" InsertItemPosition="FirstItem">
        <LayoutTemplate>
            <div class="RadListView RadListView_Default">

                <div style="margin-bottom: 10px">
                    <asp:LoginView ID="LoginView_AddButton" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Administrator, BrandMarketer">
                                <ContentTemplate>
                                    <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert"
                                        CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New Brand</asp:LinkButton>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>
                </div>

                <div class="clearfix" style="padding-top: 10px; height: 34px;"></div>
                <div id="itemPlaceholder" runat="server" style="padding-top: 10px"></div>

            </div>
        </LayoutTemplate>
        <ItemTemplate>

            <h3>
                <asp:Label ID="brandIDLabel" runat="server" Text='<%# getBrandName(Eval("brandID"))%>' />
                <asp:LoginView ID="LoginView_AddButton" runat="server">
                    <RoleGroups>
                        <asp:RoleGroup Roles="Administrator, BrandMarketer">
                            <ContentTemplate>
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-sm btn-default pull-right" ToolTip="Edit" ><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                            </ContentTemplate>
                        </asp:RoleGroup>
                    </RoleGroups>
                </asp:LoginView>
            </h3>

            <table class="table" cellspacing="0" style="width: 100%;">
                <thead>

                    <tr>

                        <th>Brand Presence</th>
                        <th class="centered-cell">Cocktail List</th>
                        <th class="centered-cell">Shot List</th>
                        <th class="centered-cell">Happy Hour/Special Menu</th>
                        <th class="centered-cell">Table Tent</th>
                        <th class="centered-cell">Chalkboard</th>
                        <th class="centered-cell">Well</th>
                        <th class="centered-cell">Back Bar</th>
                        <th>
                            <asp:Button ID="DeleteButton" Visible="false" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" Text="Delete" ToolTip="Delete" /></th>
                    </tr>
                </thead>
                <tbody>

                    <tr class="rlvI">
                        <td><strong>First Visit</strong></td>

                        <td class="centered-cell">
                            <asp:Label ID="FirstVisitLabel1" runat="server" Text='<%# formatBoolean(Eval("firstvisit_cocktailList"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label15" runat="server" Text='<%# formatBoolean(Eval("firstvisit_shotList"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label9" runat="server" Text='<%# formatBoolean(Eval("firstvisit_menus"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label10" runat="server" Text='<%# formatBoolean(Eval("firstvisit_tableTent"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label11" runat="server" Text='<%# formatBoolean(Eval("firstvisit_chalkboard"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label12" runat="server" Text='<%# formatBoolean(Eval("firstvisit_well"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label13" runat="server" Text='<%# formatBoolean(Eval("firstvisit_backBar"))%>' />
                        </td>
                        <td></td>
                    </tr>

                    <tr class="rlvI">
                        <td><strong>Currently</strong></td>

                        <td class="centered-cell">
                            <asp:Label ID="Label1" runat="server" Text='<%# formatBoolean(Eval("currently_cocktailList"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label2" runat="server" Text='<%# formatBoolean(Eval("currently_shotList"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label3" runat="server" Text='<%# formatBoolean(Eval("currently_menus"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label4" runat="server" Text='<%# formatBoolean(Eval("currently_tableTent"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label5" runat="server" Text='<%# formatBoolean(Eval("currently_chalkboard"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label6" runat="server" Text='<%# formatBoolean(Eval("currently_well"))%>' />
                        </td>
                        <td class="centered-cell">
                            <asp:Label ID="Label7" runat="server" Text='<%# formatBoolean(Eval("currently_backBar"))%>' />
                        </td>

                        <td></td>
                    </tr>

                </tbody>
                <tfoot>
                </tfoot>
            </table>

        </ItemTemplate>

        <EditItemTemplate>
            <table class="table" cellspacing="0" style="width: 100%;">
                <thead>

                    <tr>

                        <th>Brand Presence</th>
                        <th>Cocktail List</th>
                        <th>Shot List</th>
                        <th>Happy Hour/Special Menu</th>
                        <th>Table Tent</th>
                        <th>Chalkboard</th>
                        <th>Well</th>
                        <th>Back Bar</th>
                        <th>
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Update" />
                            <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                        </th>
                    </tr>
                </thead>
                <tbody>

                    <tr class="rlvIEdit">
                        <td><strong>First Visit</strong></td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("firstvisit_cocktailList")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("firstvisit_shotList")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList3" runat="server" SelectedValue='<%# Bind("firstvisit_menus")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList4" runat="server" SelectedValue='<%# Bind("firstvisit_tableTent")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList5" runat="server" SelectedValue='<%# Bind("firstvisit_chalkboard")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList6" runat="server" SelectedValue='<%# Bind("firstvisit_well")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList7" runat="server" SelectedValue='<%# Bind("firstvisit_backBar")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td></td>

                    </tr>

                    <tr class="rlvIEdit">
                        <td><strong>Currently</strong></td>
                        <td>
                            <asp:DropDownList ID="DropDownList8" runat="server" SelectedValue='<%# Bind("currently_cocktailList")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList9" runat="server" SelectedValue='<%# Bind("currently_shotList")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList10" runat="server" SelectedValue='<%# Bind("currently_menus")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList11" runat="server" SelectedValue='<%# Bind("currently_tableTent")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList12" runat="server" SelectedValue='<%# Bind("currently_chalkboard")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList13" runat="server" SelectedValue='<%# Bind("currently_well")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList14" runat="server" SelectedValue='<%# Bind("currently_backBar")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>

        </EditItemTemplate>
        <InsertItemTemplate>
            Brand:
                    <asp:DropDownList ID="BrandsDropDownList" runat="server" SelectedValue='<%# Bind("brandID")%>' Width="400px"
                        DataSourceID="getBrands" DataTextField="brandName" DataValueField="brandID" CssClass="form-control">
                    </asp:DropDownList>

            <table class="table" cellspacing="0" style="width: 100%;">
                <thead>

                    <tr>

                        <th>Brand Presence</th>
                        <th>Cocktail List</th>
                        <th>Shot List</th>
                        <th>Happy Hour/Special Menu</th>
                        <th>Table Tent</th>
                        <th>Chalkboard</th>
                        <th>Well</th>
                        <th>Back Bar</th>
                        <th>
                            <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" />
                            <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                        </th>
                    </tr>
                </thead>
                <tbody>

                    <tr class="rlvIEdit">
                        <td><strong>First Visit</strong></td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("firstvisit_cocktailList")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("firstvisit_shotList")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList3" runat="server" SelectedValue='<%# Bind("firstvisit_menus")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList4" runat="server" SelectedValue='<%# Bind("firstvisit_tableTent")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList5" runat="server" SelectedValue='<%# Bind("firstvisit_chalkboard")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList6" runat="server" SelectedValue='<%# Bind("firstvisit_well")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList7" runat="server" SelectedValue='<%# Bind("firstvisit_backBar")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td></td>

                    </tr>

                    <tr class="rlvIEdit">
                        <td><strong>Currently</strong></td>
                        <td>
                            <asp:DropDownList ID="DropDownList8" runat="server" SelectedValue='<%# Bind("currently_cocktailList")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList9" runat="server" SelectedValue='<%# Bind("currently_shotList")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList10" runat="server" SelectedValue='<%# Bind("currently_menus")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList11" runat="server" SelectedValue='<%# Bind("currently_tableTent")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList12" runat="server" SelectedValue='<%# Bind("currently_chalkboard")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList13" runat="server" SelectedValue='<%# Bind("currently_well")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="DropDownList14" runat="server" SelectedValue='<%# Bind("currently_backBar")%>' CssClass="form-control input-sm" AppendDataBoundItems="true">
                                <asp:ListItem Text="- Select -" Value=""></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>

            <hr />
        </InsertItemTemplate>
        <EmptyDataTemplate>
            <div class="RadListView RadListView_Default">
                <table class="table" cellspacing="0" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Cocktail List</th>
                            <th>Shot List</th>
                            <th>Happy Hour/Special Menu</th>
                            <th>Table Tent</th>
                            <th>Chalkboard</th>
                            <th>Well</th>
                            <th>Back Bar</th>
                            <th>&nbsp;</t>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="9">
                                <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Brand</strong> button above.</div>


                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                            CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New Brand</asp:LinkButton>
                    </tfoot>
                </table>


            </div>
        </EmptyDataTemplate>

    </telerik:RadListView>

    </asp:Panel>

    <asp:LinqDataSource ID="getAccountsBrandTrcker" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblAccountBrandTrackers" Where="accountID == @accountID">
        <WhereParameters>
            <asp:QueryStringParameter Name="accountID" QueryStringField="AccountID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="getBrands" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="brandName" TableName="tblBrands" Where="clientID == @clientID">
        <WhereParameters>

           <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
        </WhereParameters>
    </asp:LinqDataSource>



    <asp:HiddenField ID="ClientIDHiddenField" runat="server" />

</telerik:RadAjaxPanel>
