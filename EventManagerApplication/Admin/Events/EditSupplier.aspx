<%@ Page Title="Supplier Details" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" MaintainScrollPositionOnPostback="true" CodeBehind="EditSupplier.aspx.vb" Inherits="EventManagerApplication.EditSupplier" %>

<%@ Register Src="~/Admin/BillingRatesControl.ascx" TagPrefix="uc1" TagName="BillingRatesControl" %>
<%--
<%@ Register Src="~/Admin/SupplierDocumentsControl.ascx" TagPrefix="uc1" TagName="SupplierDocumentsControl" %>--%>

<%@ Register Src="~/Admin/BrandsControl.ascx" TagPrefix="uc1" TagName="BrandsControl" %>
<%@ Register Src="~/Admin/UserControls/SupplierBrandsListControl.ascx" TagPrefix="uc1" TagName="SupplierBrandsListControl" %>

<%@ Register Src="~/Admin/UserControls/BrandStaffingPositionControl.ascx" TagPrefix="uc1" TagName="BrandStaffingPositionControl" %>
<%@ Register Src="~/Admin/UserControls/BrandExecutionControl.ascx" TagPrefix="uc1" TagName="BrandExecutionControl" %>
<%@ Register Src="~/Admin/UserControls/BrandCategoryControl.ascx" TagPrefix="uc1" TagName="BrandCategoryControl" %>
<%@ Register Src="~/Admin/UserControls/BrandRoleAssociationControl.ascx" TagPrefix="uc1" TagName="BrandRoleAssociationControl" %>
<%@ Register Src="~/Admin/UserControls/BrandEventTasksControl.ascx" TagPrefix="uc1" TagName="BrandEventTasksControl" %>
<%@ Register Src="~/Admin/UserControls/BrandDocumentControl.ascx" TagPrefix="uc1" TagName="BrandDocumentControl" %>
<%@ Register Src="~/Admin/UserControls/AssociatedSuppliersControl.ascx" TagPrefix="uc1" TagName="AssociatedSuppliersControl" %>
<%@ Register Src="~/Admin/UserControls/BrandPosInformationControl.ascx" TagPrefix="uc1" TagName="BrandPosInformationControl" %>
<%@ Register Src="~/Admin/UserControls/BrandPOSItemsControl.ascx" TagPrefix="uc1" TagName="BrandPOSItemsControl" %>
<%@ Register Src="~/Admin/UserControls/RecapQuestionsControl.ascx" TagPrefix="uc1" TagName="RecapQuestionsControl" %>
<%@ Register Src="~/Admin/UserControls/BrandProcuctsControl.ascx" TagPrefix="uc1" TagName="BrandProcuctsControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .label-standard {
            background-color: #000;
        }

        .form-group {
            margin-bottom: 10px;
        }


        .rlvI1 {
            font-size: 14px;
            border-bottom: 0px solid;
            padding-top: 5px;
            padding-bottom: 3px;
        }

        .rlvIEdit1 {
            width: 400px;
            margin: 15px;
        }

        .RadListView_Metro {
            margin: 5px;
        }

        .RadListView div.rlvI, .RadListView div.rlvA, .RadListView div.rlvISel, .RadListView div.rlvIEmpty, .RadListView div.rlvIEdit1 {
            border-bottom: 0px solid;
        }
    </style>


    <style type="text/css">
        div.RadListBox .rlbTransferTo,
        div.RadListBox .rlbTransferToDisabled,
        div.RadListBox .rlbTransferAllToDisabled,
        div.RadListBox .rlbTransferAllTo {
            display: none;
        }

        .title {
            font-size: 14px;
            padding-bottom: 0px;
        }

        .list-containers .list-container {
            text-align: left;
            display: inline-block;
            vertical-align: top;
        }

        .background-silk .demo-container {
            background-color: #F3F3F3;
        }

        .list-container.size-thin {
            max-width: 380px;
        }

        .list-container {
            margin: 0px auto;
            padding: 10px;
            border: 1px solid #E2E4E7;
            background-color: #F5F7F8;
        }
    </style>

    <script type="text/javascript">
        // close the div in 5 secs
        window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version
            $("#messageHolder").fadeOut("slow", null);
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Label ID="HiddenBrandID" runat="server" Visible="false"></asp:Label>

    <link href="../../Theme/css/custom.css" rel="stylesheet" />

    <telerik:RadPersistenceManager runat="server" ID="RadPersistenceManager1">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="RadTabStrip1" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RecapListPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RecapListPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="NewQuestionPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="NewQuestionPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RecapListPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="NewQuestionPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="POPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="EditPOPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="POPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="AddNewPOPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="EditPOPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="EditPOPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="POPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="AddNewPOPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="AddNewPOPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="POPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>


            <telerik:AjaxSetting AjaxControlID="DistributorsPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="EditDistributorsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="DistributorsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="AddDistributorsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="EditDistributorsPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="EditDistributorsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="DistributorsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="EditDistributorMarketList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="EditDistributorMarketList" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="AddDistributorMarketList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="AddDistributorMarketList" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="AddDistributorsPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="AddDistributorsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="DistributorsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>


    <%--Start Main Container--%>
    <div class="container" id="MainContainer">

        <%--Start HeaderRow--%>
        <div class="row" id="HeaderRow">
            <div class="col-md-12">

                <div style="margin: 0 0 15px 0">
                    <h2>Client:
                        <asp:Label ID="ClientNameLabel" runat="server" Font-Bold="true" />

                    </h2>
                    <h3>Supplier:
                            <asp:Label ID="SupplierNameLabel" Font-Bold="true" runat="server" /></h3>
                    <asp:Label ID="ModifiedByLabel" runat="server" />
                </div>

                <div class="row">
                    <div id="messageHolder">
                        <asp:Literal ID="msgLabel" runat="server" />
                    </div>
                </div>

            </div>
        </div>
        <%--End HeaderRow--%>

        <asp:Panel ID="Panel1" runat="server">
            <div class="row">

                <div class="col-md-12">

                    <div class="pull-right secondarytab"><a href="/admin/ClientDetails?ClientID=<%= Common.GetCurrentClientID()%>&LoadState=Yes#supplierstab/suppliers" class="btn btn-default" style="line-height: 1.4;"><i class="fa fa-angle-double-left"></i>&nbsp;Client Overview</a></div>

                    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="RadMultiPage1">
                        <Tabs>
                            <telerik:RadTab Text="Default Information"></telerik:RadTab>
                            <telerik:RadTab Text="Brands"></telerik:RadTab>
                            <telerik:RadTab Text="Billing Rates"></telerik:RadTab>
                            <telerik:RadTab Text="Billing Contact" Visible="false"></telerik:RadTab>
                            <telerik:RadTab Text="Contracts/Documents"></telerik:RadTab>
                            <telerik:RadTab Text="Program/Event Tracking"></telerik:RadTab>
                            <telerik:RadTab Text="Budgets/PO's"></telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>

                    <!-- Default Information Tab -->
                    <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0">
                        <telerik:RadPageView ID="RadPageView1" runat="server">

                            <div class="widget stacked">
                                <div class="widget-content min-height">
                                    <h2>Default Information</h2>
                                     
                                    <!-- Begin Edit Supplier Form -->

                                    <asp:FormView ID="SupplierDetailForm" runat="server" DefaultMode="Edit" DataKeyNames="supplierID" DataSourceID="getSupplier" Width="100%">
                                        <EditItemTemplate>

                                            <asp:Button ID="btnUpdateBillingContact" runat="server" Text="Save Changes" CommandName="Update" CssClass="btn btn-md btn-primary" />

                                            <asp:LinkButton ID="BtnDeleteSupplier" runat="server" CssClass="btn btn-md btn-danger pull-right"
                                        OnClientClick="javascript:if(!confirm('This action will delete the selected supplier. Are you sure?')){return false;}">
                                        <i class="fa fa-trash" aria-hidden="true"></i> Delete</asp:LinkButton>
                                            <hr />

                                            <div class="row">

                                                <div class="col-md-6">

                                                    <div class="col-md-11">
                                                        <div class="form-horizontal">
                                                            <div class="form-group">
                                                                <label for="SupplierNameTextBox" class="col-sm-5 control-label">Supplier Name: <span class="text-danger">*</span></label>

                                                                <div class="col-sm-7">
                                                                    <asp:TextBox ID="SupplierNameTextBox" runat="server" Text='<%# Bind("supplierName")%>' CssClass="form-control" />

                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                                        ErrorMessage="Supplier Name is required" CssClass="errorlabel" ControlToValidate="SupplierNameTextBox"
                                                                        Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>


                                            </div>


                                            <div class="row">

                                                <div class="col-md-6">

                                                    <div class="col-md-12">
                                                        <h3>Corporate Address</h3>
                                                    </div>

                                                    <div class="col-md-11">
                                                        <div class="form-horizontal">
                                                            <div class="form-group">
                                                            </div>


                                                            <div class="form-group">
                                                                <label for="#" class="col-sm-5 control-label">Supplier Address 1:</label>
                                                                <div class="col-sm-7">
                                                                    <asp:TextBox ID="supplierAddress1" runat="server" CssClass="form-control" Text='<%# Bind("supplierAddress1")%>' />
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="#" class="col-sm-5 control-label">Supplier Address 2:</label>
                                                                <div class="col-sm-7">
                                                                    <asp:TextBox ID="supplierAddress2" runat="server" CssClass="form-control" Text='<%# Bind("supplierAddress2")%>' />
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="#" class="col-sm-5 control-label">City:</label>
                                                                <div class="col-sm-7">
                                                                    <asp:TextBox ID="supplierCity" runat="server" CssClass="form-control" Text='<%# Bind("supplierCity")%>' />
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="#" class="col-sm-5 control-label">State:</label>
                                                                <div class="col-sm-7">
                                                                    <asp:TextBox ID="supplierState" runat="server" Width="45px" CssClass="form-control" Text='<%# Bind("supplierState")%>' />
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="#" class="col-sm-5 control-label">Zip:</label>
                                                                <div class="col-sm-7">
                                                                    <asp:TextBox ID="supplierZip" runat="server" Width="90px" CssClass="form-control" Text='<%# Bind("supplierZip")%>' />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>


                                                <div class="col-md-6">

                                                    <div class="col-md-12">
                                                        <h3>Primary Contact</h3>
                                                    </div>

                                                    <div class="col-md-11">
                                                        <div class="form-horizontal">

                                                            <div class="form-group">
                                                                <label for="ContactName" class="col-sm-5 control-label">Contact Name:</label>
                                                                <div class="col-sm-7">
                                                                    <asp:TextBox ID="contactName" runat="server" CssClass="form-control" Text='<%# Bind("contactName")%>' />
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="#" class="col-sm-5 control-label">Email:</label>
                                                                <div class="col-sm-7">
                                                                    <asp:TextBox ID="contactEmail" runat="server" CssClass="form-control" Text='<%# Bind("contactEmail")%>' />
                                                                    <asp:RegularExpressionValidator ID="emailAdressRegularExpressionValidator" runat="server"
                                                                        ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" ControlToValidate="contactEmail"
                                                                        ErrorMessage="Invalid Email Format" CssClass="errorlabel" ValidationGroup="information" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </div>
                                                            </div>



                                                            <div class="form-group">
                                                                <label for="#" class="col-sm-5 control-label">Phone Number:</label>
                                                                <div class="col-sm-7">
                                                                    <telerik:RadMaskedTextBox RenderMode="Lightweight" ID="phoneNumber" runat="server" Mask="(###)###-####" Text='<%# Bind("supplierPhone")%>'>
                                                                    </telerik:RadMaskedTextBox>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="#" class="col-sm-5 control-label">Supplier Web Site:</label>
                                                                <div class="col-sm-7">
                                                                    <asp:TextBox ID="supplierWebSite" runat="server" CssClass="form-control" Text='<%# Bind("supplierWebSite")%>' />
                                                                </div>
                                                            </div>



                                                        </div>
                                                    </div>

                                                </div>

                                            </div>

                                            <hr />


                                            <div class="row">


                                                <div class="col-md-5">
                                                    <div class="col-md-12">
                                                        <div class="form-horizontal">
                                                            <div class="form-group">

                                                                <div class="col-md-12">
                                                                    <h3>Invioce Header/Bill To:</h3>
                                                                    <asp:TextBox ID="invoiceHeader" TextMode="multiline" runat="server"
                                                                        Height="130px" CssClass="form-control" Text='<%# Bind("invoiceHeader")%>' />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-7">

                                                    <div class="form-horizontal">
                                                        <h3></h3>
                                                        <br />
                                                        <div class="form-group">
                                                            <label for="#" class="col-sm-4 control-label">Billing Contact Name:</label>
                                                            <div class="col-sm-8">
                                                                <asp:TextBox ID="billingContactName" runat="server" Width="360px" CssClass="form-control" Text='<%# Bind("billingContactName")%>' />
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="#" class="col-sm-4 control-label">Billing Contact Email:</label>
                                                            <div class="col-sm-8">
                                                                <asp:TextBox ID="billingContactEmail" runat="server" Width="360px" CssClass="form-control" Text='<%# Bind("billingContactEmail")%>' />
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                                    ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" ControlToValidate="billingContactEmail"
                                                                    ErrorMessage="Invalid Email Format" CssClass="errorlabel" ValidationGroup="information" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="#" class="col-sm-4 control-label">Billing Contact Phone #:</label>
                                                            <div class="col-sm-8">
                                                                <%--<asp:TextBox ID="billingContactPhone" runat="server" Width="360px" CssClass="form-control" Text='<%# Bind("billingContactPhone")%>' />--%>
                                                                <telerik:RadMaskedTextBox RenderMode="Lightweight" ID="RadMaskedTextBox1" runat="server" Mask="(###)###-####" Text='<%# Bind("billingContactPhone")%>'>
                                                                </telerik:RadMaskedTextBox>
                                                            </div>
                                                        </div>



                                                    </div>



                                                </div>


                                            </div>
                                            <!-- End Row -->
                                            <hr />

                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <h3>Billing Notes</h3>
                                                    <asp:TextBox ID="billingNotes" TextMode="multiline" runat="server" Width="1058px" Height="100px" CssClass="form-control" Text='<%# Bind("billingNotes")%>' />
                                                </div>
                                            </div>

                                        </EditItemTemplate>
                                    </asp:FormView>

                                </div>
                            </div>

                        </telerik:RadPageView>

                        <!-- Brands Tab -->
                        <telerik:RadPageView ID="RadPageView7" runat="server">
                            <div class="widget stacked">
                                <div class="widget-content  min-height">

                                    <h2>Brands</h2>
                                    <hr />

                                    <telerik:RadGrid ID="BrandsList" runat="server"
                                        AllowPaging="True"
                                        AllowSorting="True"
                                        ShowFooter="True"
                                        ShowStatusBar="true"
                                        AllowFilteringByColumn="True"
                                        PageSize="20" CellSpacing="-1"
                                        FilterType="HeaderContext"
                                        EnableHeaderContextMenu="true"
                                        EnableHeaderContextFilterMenu="true"
                                        DataSourceID="getBrandsBySupplier">

                                        <%--OnFilterCheckListItemsRequested="BrandsList_FilterCheckListItemsRequested"--%>


                                        <ClientSettings AllowDragToGroup="True"></ClientSettings>

                                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="brandID" DataSourceID="getBrandsBySupplier" CommandItemDisplay="Top" AllowPaging="true" AllowSorting="true">


                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>

                                            <CommandItemTemplate>
                                                <div style="padding: 3px 0 3px 5px">
                                                    <asp:LinkButton ID="btnAddNew" runat="server" CommandName="AddNew" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Brand</asp:LinkButton>
                                                    <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                                    <div class="pull-right" style="padding-right: 3px">
                                                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export CSV</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </CommandItemTemplate>

                                            <Columns>

                                                <telerik:GridTemplateColumn AllowFiltering="false" EnableHeaderContextMenu="false">
                                                    <ItemStyle Width="75px" />
                                                    <ItemTemplate>

                                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black" CommandArgument='<%# Eval("brandID") %>' CommandName="EditBrand"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>

                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn DataField="brandName"
                                                    FilterControlAltText="Filter brandName column"
                                                    HeaderText="Name"
                                                    SortExpression="brandName"
                                                    UniqueName="brandName"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    FilterCheckListEnableLoadOnDemand="true">
                                                    <ColumnValidationSettings>
                                                        <ModelErrorMessage Text="" />
                                                    </ColumnValidationSettings>

                                                    <FilterTemplate>

                                                        <telerik:RadComboBox ID="RadComboBox_brandName" DataSourceID="getBrandList" DataTextField="brandName" AllowCustomText="true" MarkFirstMatch="true"
                                                            DataValueField="brandName" Height="200px" Width="320px" AppendDataBoundItems="true"
                                                            SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("brandName").CurrentFilterValue%>'
                                                            runat="server" OnClientSelectedIndexChanged="brandNameIndexChanged">
                                                            <Items>
                                                                <telerik:RadComboBoxItem Text="All" />
                                                            </Items>
                                                        </telerik:RadComboBox>

                                                        <telerik:RadScriptBlock ID="RadScriptBlock_brandName" runat="server">

                                                            <script type="text/javascript">
                                                                function brandNameIndexChanged(sender, args) {
                                                                    var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                                                    tableView.filter("brandName", args.get_item().get_value(), "EqualTo");
                                                                }
                                                            </script>

                                                        </telerik:RadScriptBlock>

                                                    </FilterTemplate>

                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="supplier"
                                                    FilterControlAltText="Filter supplier column"
                                                    HeaderText="Supplier"
                                                    SortExpression="supplier"
                                                    UniqueName="supplier"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    FilterCheckListEnableLoadOnDemand="true">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Category"
                                                    FilterControlAltText="Filter Category column"
                                                    HeaderText="# of Products"
                                                    SortExpression="Category"
                                                    UniqueName="Category"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    FilterCheckListEnableLoadOnDemand="true">
                                                </telerik:GridBoundColumn>

                                                 <telerik:GridBoundColumn DataField="NumberEvents"
                                                    FilterControlAltText="Filter NumberEvents column"
                                                    HeaderText="# of Events"
                                                    SortExpression="NumberEvents"
                                                    UniqueName="NumberEvents" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Type"
                                                    FilterControlAltText="Filter Type column"
                                                    HeaderText="Brand Start Date"
                                                    SortExpression="Type"
                                                    UniqueName="Type" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    FilterCheckListEnableLoadOnDemand="true">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Variety"
                                                    FilterControlAltText="Filter Variety column"
                                                    HeaderText="Brand End Date"
                                                    SortExpression="Variety"
                                                    UniqueName="Variety" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    FilterCheckListEnableLoadOnDemand="true">
                                                </telerik:GridBoundColumn>



<%--                                                <telerik:GridBoundColumn DataField="upc"
                                                    FilterControlAltText="Filter upc column"
                                                    HeaderText="UPC"
                                                    SortExpression="upc"
                                                    UniqueName="upc" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    FilterCheckListEnableLoadOnDemand="true">
                                                </telerik:GridBoundColumn>--%>


                                            </Columns>

                                        </MasterTableView>

                                        <PagerStyle Position="TopAndBottom" />


                                    </telerik:RadGrid>

                                    <asp:LinqDataSource ID="getBrandsBySupplier" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="qryGetBrandsBySupplers" Where="supplierID == @supplierID">
                                        <WhereParameters>
                                            <asp:QueryStringParameter QueryStringField="SupplierID" Name="supplierID" Type="Int32"></asp:QueryStringParameter>
                                        </WhereParameters>
                                    </asp:LinqDataSource>




                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getBrandbyClientList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="brandName"
                                        TableName="qryGetBrands" Where="clientID == @clientID">
                                        <WhereParameters>
                                            <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
                                        </WhereParameters>
                                    </asp:LinqDataSource>

                                    <asp:SqlDataSource ID="getBrandList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT brandName, clientID FROM tblBrands WHERE (clientID = @clientID) ORDER BY brandName"
                                        runat="server">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID"></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                                    <asp:SqlDataSource ID="getCategoryList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT Category, clientID FROM qryGetBrands WHERE (clientID = @clientID) and Category is not null ORDER BY Category"
                                        runat="server">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID"></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                    <asp:SqlDataSource ID="getBrandGroupNameList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT brandGroupName, clientID FROM qryGetBrands WHERE (clientID = @clientID) ORDER BY brandGroupName"
                                        runat="server">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID"></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                                    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

                                        <script type="text/javascript">
                                            function requestStart(sender, args) {
                                                if (args.get_eventTarget().indexOf("btnExport") >= 0) {
                                                    args.set_enableAjax(false);
                                                }
                                            }


                                            function clearColumnFilter(columnName) {
                                                var masterTable = $find("<%= BrandsList.ClientID %>").get_masterTableView();
                                                masterTable.filter(columnName, "", Telerik.Web.UI.GridFilterFunction.NoFilter);
                                            }



                                        </script>

                                    </telerik:RadScriptBlock>

                                </div>
                            </div>
                        </telerik:RadPageView>

                        <!-- Billing Rates Tab -->
                        <telerik:RadPageView ID="RadPageView2" runat="server">
                            <div class="widget stacked">
                                <div class="widget-content min-height">

                                    <uc1:BillingRatesControl runat="server" ID="BillingRatesControl" />

                                </div>
                            </div>
                        </telerik:RadPageView>

                        <!-- Billing Contact -->
                        <telerik:RadPageView ID="RadPageView3" runat="server" Visible="false">


                            <div class="widget stacked">
                                <div class="widget-content min-height">
                                    <h2>Billing Contact</h2>



                                </div>
                            </div>

                        </telerik:RadPageView>

                        <!-- Contracts/POs/Docs Tab -->
                        <telerik:RadPageView ID="RadPageView4" runat="server">
                            <div class="widget stacked">
                                <div class="widget-content min-height">
                                    <h2>Contracts/Documents</h2>
                                    <hr />

                                    <div class="col-md-12">

                                        <p>Upload related Contracts and Documents.</p>
                                        <p>
                                            You may upload the following files types: pdf, doc, docx, xls, xlsx, csv, txt, jpg, jpeg, png, and gif.

                                        </p>

                                        <div class="well">

                                            <h4 class="additional-text">Select multiple files at a time and upload them</h4>
                                            <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server"></telerik:RadAsyncUpload>
                                            <asp:Button ID="btnUpload" runat="server" Text="Upload File(s)" CssClass="btn btn-primary" />

                                        </div>


                                    </div>


                                    <div class="col-md-12">


                                        <telerik:RadGrid ID="DocumentsGrid" runat="server" CellSpacing="-1" DataSourceID="getSupplierDocuments">
                                            <MasterTableView DataKeyNames="DocumentID" DataSourceID="getSupplierDocuments" AutoGenerateColumns="False">

                                                <NoRecordsTemplate>

                                                    <br />
                                                    <div class="col-md-12">
                                                        <div class="alert alert-warning" role="alert"><strong>No document uploaded.</strong>  Use the file uploader above to add your files.</div>
                                                    </div>

                                                </NoRecordsTemplate>

                                                <Columns>
                                                    <telerik:GridTemplateColumn>
                                                        <ItemTemplate>
                                                            <a class="btn btn-default" style="color: black" href='fileHandler.aspx?ID=<%# Eval("DocumentID") %>'><i class="fa fa-download" aria-hidden="true"></i>Download</a>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>



                                                    <telerik:GridBoundColumn DataField="DocumentName" HeaderText="Document Name" SortExpression="DocumentName" UniqueName="DocumentName" FilterControlAltText="Filter DocumentName column"></telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Uploaded By" SortExpression="ModifiedBy" UniqueName="ModifiedBy" FilterControlAltText="Filter ModifiedBy column">
                                                        <ItemTemplate>
                                                            <asp:Label ID="ModifiedByLabel" runat="server" Text='<%# GetFullName(Eval("ModifiedBy")) %>' />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridBoundColumn DataField="ModifiedDate" HeaderText="Uploaded Date" SortExpression="ModifiedDate" UniqueName="ModifiedDate" DataType="System.DateTime" FilterControlAltText="Filter ModifiedDate column"></telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn>
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger" CommandArgument='<%# Eval("DocumentID") %>' CommandName="DeleteFile" ForeColor="white"><i class="fa fa-trash" aria-hidden="true"></i> Delete</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getSupplierDocuments" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblSupplierDocuments" Where="SupplierID == @SupplierID">
                                            <WhereParameters>
                                                <asp:QueryStringParameter QueryStringField="SupplierID" Name="SupplierID" Type="Int32"></asp:QueryStringParameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>
                                    </div>

                                </div>
                            </div>
                        </telerik:RadPageView>

                        <!-- Budget Tracking Tab -->
                        <telerik:RadPageView ID="RadPageView5" runat="server">

                            <div class="widget stacked">
                                <div class="widget-content min-height">
                                    <h2>Program/Event Tracking</h2>
                                    <hr />

                                    <asp:Label ID="msgLabel1" runat="server" />


                                    <asp:Panel ID="RecapListPanel" runat="server">


                                        <telerik:RadListView ID="SupplierBudgetList" runat="server"
                                            DataKeyNames="supplierBudgetQuestionID" InsertItemPosition="LastItem" DataSourceID="getSupplierBudgetQuestions">
                                            <LayoutTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">
                                                        <thead>
                                                            <tr>
                                                                <th></th>
                                                                <th>Question</th>
                                                                <th>Question Type</th>
                                                                <th>Required</th>
                                                                <th></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr id="itemPlaceholder" runat="server">
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <asp:LinkButton ID="btnInsert" runat="server" CommandName="AddQuestion" Visible="<%# Not Container.IsItemInserted %>"
                                                                CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New Question</asp:LinkButton>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td style="width: 150px">
                                                        <div class="btn-group" role="group" aria-label="...">
                                                            <asp:LinkButton ID="EditButton1" runat="server" CausesValidation="False" CssClass="btn btn-default btn-sm" ToolTip="Edit" CommandName="EditQuestion" CommandArgument='<%# Eval("supplierBudgetQuestionID")%>'> <i class="fa fa-pencil"></i> Edit</asp:LinkButton>

                                                            <asp:LinkButton ID="DeleteButton1" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-sm btn-danger" ToolTip="Delete" OnClientClick="javascript:if(!confirm('This action will delete the selected question. Are you sure?')){return false;}"><i class="fa fa-trash"></i> Delete</asp:LinkButton>

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="questionLabel" runat="server" Text='<%# Eval("question")%>' />
                                                    </td>
                                                    <td>
                                                        <%# Eval("questionType")%>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("required")%>' /></td>
                                                    <td class="pull-right">

                                                        <div class="btn-group" role="group" aria-label="...">
                                                            <asp:LinkButton ID="btnMoveDown" runat="server" OnClick="movedown" CommandArgument='<%# Eval("supplierBudgetQuestionID")%>' CssClass="btn btn-default btn-sm" ToolTip="Move Down" Enabled='<%# ShowLastButton(Eval("supplierBudgetQuestionID"))%>'><i class="fa fa-arrow-down"></i> Move Down</asp:LinkButton>

                                                            <asp:LinkButton ID="btnMoveUp" runat="server" OnClick="moveup" CommandArgument='<%# Eval("supplierBudgetQuestionID")%>' CssClass="btn btn-default btn-sm" ToolTip="Move Up" Enabled='<%# ShowFirstButton(Eval("supplierBudgetQuestionID"))%>'><i class="fa fa-arrow-up"></i> Move Up</asp:LinkButton>
                                                        </div>






                                                    </td>



                                                </tr>
                                            </ItemTemplate>

                                            <EditItemTemplate>
                                                <tr class="rlvIEdit">

                                                    <td colspan="4">

                                                        <div class="form-horizontal">
                                                            <div class="form-group">
                                                                <label for="ColumnNameTextBox" class="col-sm-2 control-label">Question</label>
                                                                <div class="col-sm-8">
                                                                    <asp:TextBox ID="ColumnNameTextBox" runat="server" Text='<%# Bind("question")%>' CssClass="form-control" />
                                                                </div>
                                                            </div>



                                                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Update" />
                                                            <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />

                                                        </div>




                                                    </td>


                                                </tr>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                            </InsertItemTemplate>
                                            <EmptyDataTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">
                                                        <thead>
                                                            <tr>

                                                                <th>Question</th>
                                                                <th>&nbsp;</th>
                                                                <th>&nbsp;</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td colspan="5">

                                                                    <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add</strong> button above.</div>

                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <%--<asp:Button ID="btnInsert" runat="server" CommandName="AddQuestion" Visible="<%# Not Container.IsItemInserted %>"
                                Text="Add New Question" CssClass="btn btn-xs btn-primary pull-right"></asp:Button>--%>
                                                            <asp:LinkButton ID="btnInsert" runat="server" CommandName="AddQuestion" Visible="<%# Not Container.IsItemInserted %>"
                                                                CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Question</asp:LinkButton>
                                                        </tfoot>
                                                    </table>


                                                </div>
                                            </EmptyDataTemplate>

                                        </telerik:RadListView>

                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getSupplierBudgetQuestions" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" OrderBy="sortOrder" TableName="tblSupplierBudgetQuestions" Where="supplierID == @supplierID">
                                            <WhereParameters>
                                                <asp:QueryStringParameter QueryStringField="SupplierID" Name="supplierID" Type="Int32"></asp:QueryStringParameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>

                                    </asp:Panel>

                                    <asp:Panel ID="NewQuestionPanel" runat="server" Visible="false" Style="margin-top: 15px;">

                                        <asp:Label ID="Hidden_recapQuestionID" runat="server" Text="Label" Visible="false"></asp:Label>
                                        <asp:Label ID="Hidden_SortOrder" runat="server" Text="Label" Visible="false"></asp:Label>

                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label for="ColumnNameTextBox" class="col-sm-2 control-label">Question</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="ColumnNameTextBox" runat="server" CssClass="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="RequiredFieldTextBox" class="col-sm-2 control-label">Required Field</label>
                                                <div class="col-sm-8">
                                                    <asp:RadioButtonList ID="RequiredFieldTextBox" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                        <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                        <asp:ListItem Text="No" Value="False" Selected="True"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                    <span id="helpBlock2" class="help-block">Require that this column contains information.</span>



                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="columnTypeList" class="col-sm-2 control-label">Column Type</label>
                                                <div class="col-sm-10">
                                                    <asp:RadioButtonList ID="columnTypeList" runat="server" AutoPostBack="true">
                                                        <asp:ListItem Text="Single line of text" Value="text"></asp:ListItem>
                                                        <asp:ListItem Text="Multiple lines of text" Value="multiline"></asp:ListItem>
                                                        <asp:ListItem Text="Yes/No (radio button)" Value="yes/no"></asp:ListItem>
                                                        <asp:ListItem Text="Choice (menu to choose from)" Value="choice"></asp:ListItem>
                                                        <asp:ListItem Text="Number (1, 1.0, 100)" Value="number"></asp:ListItem>
                                                        <asp:ListItem Text="Date" Value="date"></asp:ListItem>
                                                        <asp:ListItem Text="Time" Value="time"></asp:ListItem>
                                                        <asp:ListItem Text="Currency ($)" Value="currency"></asp:ListItem>
                                                        <asp:ListItem Text="Label" Value="label"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div>



                                            <!-- Text Option -->
                                            <asp:Panel ID="DescriptionPanel" runat="server">
                                                <div class="form-group">
                                                    <label for="txtDescription" class="col-sm-2 control-label">Description Text</label>
                                                    <div class="col-sm-8">
                                                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control"></asp:TextBox>
                                                        <span id="helpBlock" class="help-block">Specify detailed options for the type of information you selected.</span>
                                                    </div>
                                                </div>

                                            </asp:Panel>

                                            <!-- Multiple Lines Option -->
                                            <asp:Panel ID="MultilinePanel" runat="server" Visible="false">
                                                <div class="form-group">
                                                    <label for="txtLines" class="col-sm-2 control-label">Number of lines for text</label>
                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="txtLines" runat="server" Text="4" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </asp:Panel>


                                            <!-- Choice Option -->
                                            <asp:Panel ID="ChoicePanel" runat="server" Visible="false">

                                                <div class="form-group">
                                                    <label for="txtChioces" class="col-sm-2 control-label">Choices</label>
                                                    <div class="col-sm-2">
                                                        <asp:TextBox ID="txtChioces" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control"></asp:TextBox>
                                                        <span id="helpBlock3" class="help-block">Type each choice on a separate line.</span>


                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="DisplayOptions" class="col-sm-2 control-label">Display Options</label>
                                                    <div class="col-sm-10">
                                                        <asp:RadioButtonList ID="DisplayOptions" runat="server">
                                                            <asp:ListItem Selected="True" Text="Drop-Down Menu" Value="drop"></asp:ListItem>
                                                            <asp:ListItem Text="Radio Buttons" Value="radio"></asp:ListItem>
                                                            <asp:ListItem Text="Checkboxes (allow multiple selections)" Value="check"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>

                                            </asp:Panel>

                                            <!-- Choice Option -->
                                            <asp:Panel ID="YesNoPanel" runat="server" Visible="false">

                                                <div class="form-group">
                                                    <label for="ckbYesNo" class="col-sm-2 control-label">Default Value</label>
                                                    <div class="col-sm-4">

                                                        <asp:RadioButtonList ID="ckbYesNo" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="Yes" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="No"></asp:ListItem>
                                                        </asp:RadioButtonList>


                                                    </div>
                                                </div>
                                            </asp:Panel>


                                            <!-- Number Option -->
                                            <asp:Panel ID="NumberPanel" runat="server" Visible="false">

                                                <div class="form-group">
                                                    <label for="txtDecimalPlace" class="col-sm-2 control-label">Number of decimal places</label>
                                                    <div class="col-sm-1">
                                                        <asp:DropDownList ID="txtDecimalPlace" runat="server" CssClass="form-control">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="txtDefaultNumber" class="col-sm-2 control-label">Default value</label>
                                                    <div class="col-sm-1">
                                                        <asp:TextBox ID="txtDefaultNumber" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="DisplayOptions" class="col-sm-2 control-label">Show as percentage</label>
                                                    <div class="col-sm-10">
                                                        <asp:RadioButtonList ID="ckbPercentage" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                            <asp:ListItem Text="No" Selected="True" Value="False"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                        (for example, 50%)
                                                    </div>
                                                </div>

                                            </asp:Panel>

                                            <!-- Date Option -->
                                            <asp:Panel ID="DatePanel" runat="server" Visible="false">
                                                <div class="form-group">
                                                    <label for="ckbDateFormat" class="col-sm-2 control-label">Date and Time Format</label>
                                                    <div class="col-sm-10">
                                                        <asp:RadioButtonList ID="ckbDateFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="Date Only" Selected="True" Value="Date"></asp:ListItem>
                                                            <asp:ListItem Text="Date & Time" Value="DateTime"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>

                                                </div>

                                                <div class="form-group">
                                                    <label for="DisplayOptions" class="col-sm-2 control-label">Display Format</label>
                                                    <div class="col-sm-10">
                                                        <asp:RadioButtonList ID="ckbDateDisplayFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="Standard" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Friendly"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>

                                                </div>

                                                <div class="form-group">
                                                    <label for="ckbDateDefualtValue" class="col-sm-2 control-label">Default Value</label>
                                                    <div class="col-sm-10">
                                                        <asp:RadioButtonList ID="ckbDateDefualtValue" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="None" Selected="True" Value="None"></asp:ListItem>
                                                            <asp:ListItem Text="Current Date" Value="Current"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>

                                                </div>

                                            </asp:Panel>

                                            <!-- Date Option -->
                                            <asp:Panel ID="TimePanel" runat="server" Visible="false">
                                                <div class="form-group">
                                                    <label for="ckbTimeFormat" class="col-sm-2 control-label">Time Format</label>
                                                    <div class="col-sm-10">
                                                        <asp:RadioButtonList ID="ckbTimeFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="12 hours" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="24 hours"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>

                                                </div>
                                            </asp:Panel>

                                            <!-- Currency Option -->
                                            <asp:Panel ID="CurrencyPanel" runat="server" Visible="false">
                                            </asp:Panel>


                                            <div class="form-group">
                                                <label for="accountNameTextBox" class="col-sm-2 control-label"></label>
                                                <div class="col-sm-6">
                                                    <asp:Button ID="btnUpdateQuestion" runat="server" Text="Update" CssClass="btn btn-primary" Visible="false" />
                                                    <asp:Button ID="btnInsertQuestion" runat="server" Text="Save" CssClass="btn btn-primary" />
                                                    <asp:Button ID="btnCancelNewQuestion" runat="server" Text="Cancel" CssClass="btn btn-default" />
                                                </div>
                                            </div>
                                        </div>

                                        <%--             <telerik:RadNotification ID="RadNotification1" runat="server" EnableRoundedCorners="true" Skin="Black"
        EnableShadow="true" Title="Alert"  Width="300" Height="100">
        </telerik:RadNotification>--%>
                                    </asp:Panel>

                                </div>
                            </div>

                        </telerik:RadPageView>

                        <!-- Event Tracking Tab -->
                        <telerik:RadPageView ID="RadPageView6" runat="server">

                            <div class="widget stacked">
                                <div class="widget-content min-height">
                                    <h2>Budgets/PO's</h2>
                                    <hr />


                                    <asp:Panel ID="POPanel" runat="server">

                                        <telerik:RadListView ID="PurchaseOrdersListView" runat="server" DataSourceID="getPurchaseOrders" DataKeyNames="purchaseOrderID">

                                            <LayoutTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">
                                                        <thead>
                                                            <tr>
                                                                <th></th>
                                                                <th>PO #</th>
                                                                <th>PO Amount</th>
                                                                <th>PO Balance</th>
                                                                <th>Requestor</th>
                                                                <th>Requestor Email</th>
                                                                <th>Date Issued</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr id="itemPlaceholder" runat="server">
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <asp:LinkButton ID="btnInsert" runat="server" CommandName="AddPO" Visible="<%# Not Container.IsItemInserted %>" CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New Budget/PO's</asp:LinkButton>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </LayoutTemplate>

                                            <ItemTemplate>

                                                <tr>
                                                    <td style="width: 150px">
                                                        <div class="btn-group" role="group" aria-label="...">

                                                            <asp:LinkButton ID="EditButton1" runat="server" CausesValidation="False" CssClass="btn btn-default btn-sm" ToolTip="Edit" CommandName="EditPO" CommandArgument='<%# Eval("purchaseOrderID")%>'> <i class="fa fa-pencil"></i> Edit</asp:LinkButton>

                                                            <asp:LinkButton ID="DeleteButton1" runat="server" CausesValidation="False" CommandName="Delete" CommandArgument='<%# Eval("purchaseOrderID")%>' CssClass="btn btn-sm btn-danger" ToolTip="Delete" OnClientClick="javascript:if(!confirm('This action will delete the selected Budget/PO's. Are you sure?')){return false;}"><i class="fa fa-trash"></i> Delete</asp:LinkButton>

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="PONumberLabel" runat="server" Text='<%# Eval("purchaseOrderNumber")%>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="POAmountLabel" runat="server" Text='<%# Eval("poAmount", "{0:C}")%>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="POBalanceLabel" runat="server" Text='<%# Eval("poBalance", "{0:C}")%>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="RequestorLabel" runat="server" Text='<%# Eval("requestorName")%>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="RequestorEmailLabel" runat="server" Text='<%# Eval("requestorEmail")%>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="PODateLabel" runat="server" Text='<%# Eval("dateIssued", "{0:d}")%>' />
                                                    </td>

                                                </tr>

                                            </ItemTemplate>

                                            <EmptyDataTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">
                                                        <thead>
                                                            <tr>
                                                                <th>&nbsp;</th>
                                                                <th>PO #</th>
                                                                <th>PO Amount</th>
                                                                <th>PO Balance</th>
                                                                <th>Requestor</th>
                                                                <th>Requestor Email</th>
                                                                <th>Date Issued</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td colspan="7">

                                                                    <div class="alert alert-warning" role="alert">There are no items to be displayed. To add a new Budget/POs click on the <strong>Add</strong> button above</div>

                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <asp:LinkButton ID="btnInsert" runat="server" CommandName="AddPO" Visible="<%# Not Container.IsItemInserted %>" CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New Budget/PO's</asp:LinkButton>
                                                        </tfoot>
                                                    </table>


                                                </div>
                                            </EmptyDataTemplate>

                                        </telerik:RadListView>

                                        <asp:LinqDataSource ID="getPurchaseOrders" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblPurchaseOrders" Where="supplierID == @supplierID" EnableDelete="True" EnableInsert="True" EnableUpdate="True">
                                            <WhereParameters>
                                                <asp:QueryStringParameter QueryStringField="SupplierID" Name="supplierID" Type="Int32"></asp:QueryStringParameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>

                                    </asp:Panel>


                                    <asp:Panel ID="AddNewPOPanel" runat="server" Visible="false">

                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label for="AddPONumberTextBox" class="col-sm-2 control-label">PO #</label>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="AddPONumberTextBox" runat="server" CssClass="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="AddPOAmountTextBox" class="col-sm-2 control-label">PO Amount</label>
                                                <div class="col-sm-4">
                                                    <%--<asp:TextBox ID="AddPOAmountTextBox" runat="server" CssClass="form-control" />--%>

                                                    <telerik:RadNumericTextBox ID="AddPOAmountTextBox" runat="server" Type="Currency" CssClass="form-control" MinValue="0" Value="0">
                                                    </telerik:RadNumericTextBox>
                                                    <asp:RequiredFieldValidator ID="SamplingFeeRequiredFieldValidator" runat="server"
                                                        ErrorMessage="The value can not be blank" CssClass="errorlabel" ControlToValidate="AddPOAmountTextBox"
                                                        Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="AddPOBalanceTextBox" class="col-sm-2 control-label">PO Balance</label>
                                                <div class="col-sm-4">
                                                    <%--<asp:TextBox ID="AddPOBalanceTextBox" runat="server" CssClass="form-control" />--%>

                                                    <telerik:RadNumericTextBox ID="AddPOBalanceTextBox" runat="server" Type="Currency" CssClass="form-control" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                        ErrorMessage="The value can not be blank" CssClass="errorlabel" ControlToValidate="AddPOBalanceTextBox"
                                                        Display="Dynamic" ValidationGroup="overview"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="AddPORequestorTextBox" class="col-sm-2 control-label">Requestor</label>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="AddPORequestorTextBox" runat="server" CssClass="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="AddPORequestorEmailTextBox" class="col-sm-2 control-label">Requestor Email</label>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="AddPORequestorEmailTextBox" runat="server" CssClass="form-control" />

                                                    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="AddPORequestorEmailTextBox" CssClass="errorlabel" ErrorMessage="Invalid Email Format" ValidationGroup="overview" Display="Dynamic"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="AddPODateTextBox" class="col-sm-2 control-label">Date Issued</label>
                                                <div class="col-sm-4">
                                                    <%--<asp:TextBox ID="AddPODateTextBox" runat="server" CssClass="form-control" />--%>

                                                    <telerik:RadDatePicker ID="AddPODateTextBox" runat="server"></telerik:RadDatePicker>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="ColumnNameTextBox" class="col-sm-2 control-label"></label>
                                                <div class="col-sm-4">
                                                    <div class="">

                                                        <asp:Button ID="btnSaveAddPO" runat="server" Text="Save" CssClass="btn btn-primary" ValidationGroup="overview" />
                                                        <asp:Button ID="btnCancelAddPO" runat="server" Text="Cancel" CssClass="btn btn-default" />

                                                    </div>

                                                    <asp:Label ID="ErrorLabel" runat="server" />

                                                </div>
                                            </div>
                                        </div>

                                    </asp:Panel>


                                    <asp:Panel ID="EditPOPanel" runat="server" Visible="false">


                                        <asp:Label ID="lblpurchaseOrderID" runat="server" Visible="false"></asp:Label>

                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label for="ColumnNameTextBox" class="col-sm-2 control-label">PO #</label>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="EditPONumberTextBox" runat="server" CssClass="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="ColumnNameTextBox" class="col-sm-2 control-label">PO Amount</label>
                                                <div class="col-sm-4">
                                                    <%--<asp:TextBox ID="EditPOAmountTextBox" runat="server" CssClass="form-control" />--%>

                                                    <telerik:RadNumericTextBox ID="EditPOAmountTextBox" runat="server" Type="Currency" CssClass="form-control">
                                                    </telerik:RadNumericTextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                        ErrorMessage="The value can not be blank" CssClass="errorlabel" ControlToValidate="EditPOAmountTextBox"
                                                        Display="Dynamic" ValidationGroup="POS"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="ColumnNameTextBox" class="col-sm-2 control-label">PO Balance</label>
                                                <div class="col-sm-4">
                                                    <%--<asp:TextBox ID="EditPOBalanceTextBox" runat="server" CssClass="form-control" />--%>

                                                    <telerik:RadNumericTextBox ID="EditPOBalanceTextBox" runat="server" Type="Currency" CssClass="form-control">
                                                    </telerik:RadNumericTextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                        ErrorMessage="The value can not be blank" CssClass="errorlabel" ControlToValidate="EditPOBalanceTextBox"
                                                        Display="Dynamic" ValidationGroup="POS"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="ColumnNameTextBox" class="col-sm-2 control-label">Requestor</label>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="EditPORequestorTextBox" runat="server" CssClass="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="ColumnNameTextBox" class="col-sm-2 control-label">Requestor Email</label>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="EditPORequestorEmailTextBox" runat="server" CssClass="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="ColumnNameTextBox" class="col-sm-2 control-label">Date Issued</label>
                                                <div class="col-sm-4">
                                                    <%--<asp:TextBox ID="EditPODateTextBox" runat="server" CssClass="form-control" />--%>

                                                    <telerik:RadDatePicker ID="EditPODateTextBox" runat="server"></telerik:RadDatePicker>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="ColumnNameTextBox" class="col-sm-2 control-label"></label>
                                                <div class="col-sm-4">
                                                    <div class="">

                                                        <asp:Button ID="btnSaveEditPO" runat="server" Text="Update" CssClass="btn btn-primary" ValidationGroup="POS" />
                                                        <asp:Button ID="btnCancelEditPO" runat="server" Text="Cancel" CssClass="btn btn-default" />

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </asp:Panel>



                                    <div style="margin-top: 40px;">

                                        <h2>Wholesalers/Distributors</h2>
                                        <hr />


                                        <asp:Panel ID="DistributorsPanel" runat="server">

                                            <telerik:RadListView ID="DistributorsListView" runat="server" DataSourceID="getDistributors" DataKeyNames="distributorID">

                                                <LayoutTemplate>
                                                    <div class="RadListView RadListView_Default">
                                                        <table class="table" cellspacing="0" style="width: 100%;">
                                                            <thead>
                                                                <tr>
                                                                    <th></th>
                                                                    <th>Wholesalers/Distributors Name</th>
                                                                    <th>Market</th>
                                                                    <th>City</th>
                                                                    <th></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr id="itemPlaceholder" runat="server">
                                                                </tr>
                                                            </tbody>
                                                            <tfoot>
                                                                <asp:LinkButton ID="btnInsert" runat="server" CommandName="AddDistributor" Visible="<%# Not Container.IsItemInserted %>" CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New Wholesalers/Distributors</asp:LinkButton>
                                                            </tfoot>
                                                        </table>
                                                    </div>
                                                </LayoutTemplate>

                                                <ItemTemplate>

                                                    <tr>
                                                        <td style="width: 150px">
                                                            <div class="btn-group" role="group" aria-label="...">

                                                                <asp:LinkButton ID="EditButton1" runat="server" CausesValidation="False" CssClass="btn btn-default btn-sm" ToolTip="Edit" CommandName="EditDistributor" CommandArgument='<%# Eval("distributorID")%>'> <i class="fa fa-pencil"></i> Edit</asp:LinkButton>

                                                                <asp:LinkButton ID="DeleteButton1" runat="server" CausesValidation="False" CommandName="Delete" CommandArgument='<%# Eval("distributorID")%>' CssClass="btn btn-sm btn-danger" ToolTip="Delete" OnClientClick="javascript:if(!confirm('This action will delete the selected Budget/PO's. Are you sure?')){return false;}"><i class="fa fa-trash"></i> Delete</asp:LinkButton>

                                                            </div>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="DistributorNameLabel" runat="server" Text='<%# Eval("distributorName")%>' />
                                                        </td>
                                                        <td>

                                                            <asp:Label ID="DistributorMarketLabel" runat="server" Text='<%# Eval("marketID")%>' Visible="false" />


                                                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="getMarket">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="DistributorMarketLabel" runat="server" Text='<%# Eval("marketName")%>' />
                                                                </ItemTemplate>
                                                            </asp:Repeater>

                                                            <%--<asp:ListBox ID="ListBox1" runat="server" DataSourceID=""></asp:ListBox>--%>

                                                            <asp:LinqDataSource ID="getMarket" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblMarkets" Where="marketID == @marketID">
                                                                <WhereParameters>
                                                                    <asp:ControlParameter ControlID="DistributorMarketLabel" PropertyName="Text" Name="marketID" Type="Int32"></asp:ControlParameter>
                                                                </WhereParameters>
                                                            </asp:LinqDataSource>

                                                        </td>
                                                        <td>
                                                            <asp:Label ID="DistributorCityLabel" runat="server" Text='<%# Eval("city")%>' />
                                                        </td>
                                                        <td></td>

                                                    </tr>

                                                </ItemTemplate>

                                                <EmptyDataTemplate>
                                                    <div class="RadListView RadListView_Default">
                                                        <table class="table" cellspacing="0" style="width: 100%;">
                                                            <thead>
                                                                <tr>
                                                                    <th>&nbsp;</th>
                                                                    <th>Wholesalers/Distributors Name</th>
                                                                    <th>Market</th>
                                                                    <th>City</th>
                                                                    <th>&nbsp;</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td colspan="5">

                                                                        <div class="alert alert-warning" role="alert">There are no items to be displayed. To add a new Wholesalers/Distributors click on the <strong>Add</strong> button above</div>

                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                            <tfoot>
                                                                <asp:LinkButton ID="btnInsert" runat="server" CommandName="AddDistributor" Visible="<%# Not Container.IsItemInserted %>" CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>  Add New Wholesalers/Distributors</asp:LinkButton>
                                                            </tfoot>
                                                        </table>


                                                    </div>
                                                </EmptyDataTemplate>

                                            </telerik:RadListView>

                                            <asp:LinqDataSource ID="getDistributors" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblDistributors" Where="supplierID == @supplierID">
                                                <WhereParameters>
                                                    <asp:QueryStringParameter QueryStringField="SupplierID" Name="supplierID" Type="Int32"></asp:QueryStringParameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>

                                        </asp:Panel>


                                        <asp:Panel ID="AddDistributorsPanel" runat="server" Visible="false">

                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                    <label for="ColumnNameTextBox" class="col-sm-2 control-label">Wholesalers/Distributors Name</label>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="AddDistributorNameTextBox" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ColumnNameTextBox" class="col-sm-2 control-label">Market</label>
                                                    <div class="col-sm-4">

                                                        <%--<asp:DropDownList ID="AddDistributorMarketList" runat="server" AutoPostBack="true"
                                                        DataSourceID="GetMarketList" DataTextField="marketName"
                                                        DataValueField="marketID" CssClass="form-control" AppendDataBoundItems="true">
                                                        <asp:ListItem Text="-- Select Market to Search --" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>--%>


                                                        <telerik:RadComboBox ID="AddDistributorMarketList" runat="server" DataSourceID="GetMarketList" DataTextField="marketName" DataValueField="marketID" Width="200px" EmptyMessage="Select Market" AllowCustomText="true" MarkFirstMatch="true">
                                                            <Items>
                                                                <telerik:RadComboBoxItem Value="0" Text="-- Select Market to Search --" />
                                                            </Items>
                                                        </telerik:RadComboBox>


                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ColumnNameTextBox" class="col-sm-2 control-label">City</label>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="AddDistributorCityTextBox" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ColumnNameTextBox" class="col-sm-2 control-label"></label>
                                                    <div class="col-sm-4">
                                                        <div class="">

                                                            <asp:Button ID="btnSaveDistributor" runat="server" Text="Save" CssClass="btn btn-primary" />
                                                            <asp:Button ID="btnCancelAddDistributor" runat="server" Text="Cancel" CssClass="btn btn-default" />

                                                        </div>

                                                    </div>
                                                </div>
                                            </div>

                                        </asp:Panel>


                                        <asp:Panel ID="EditDistributorsPanel" runat="server" Visible="false">

                                            <asp:Label ID="lbldistributor" runat="server" Visible="false"></asp:Label>

                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                    <label for="ColumnNameTextBox" class="col-sm-2 control-label">Wholesalers/Distributors Name</label>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="EditDistributorNameTextBox" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ColumnNameTextBox" class="col-sm-2 control-label">Market</label>
                                                    <div class="col-sm-4">

                                                        <%--<telerik:RadDropDownList ID="RadDropDownList1" runat="server" DataSourceID="GetMarketList" DataTextField="marketName" DataValueField="marketID" Width="200px">
                                                        <Items>
                                                            <telerik:DropDownListItem Value="0" Text="-- Select Market to Search --" />
                                                        </Items>
                                                    </telerik:RadDropDownList>--%>


                                                        <telerik:RadComboBox ID="EditDistributorMarketList" runat="server" DataSourceID="GetMarketList" DataTextField="marketName" DataValueField="marketID" Width="200px" EmptyMessage="Select Market" AllowCustomText="true" MarkFirstMatch="true">
                                                            <Items>
                                                                <telerik:RadComboBoxItem Value="0" Text="-- Select Market to Search --" />
                                                            </Items>
                                                        </telerik:RadComboBox>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ColumnNameTextBox" class="col-sm-2 control-label">City</label>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="EditDistributorCityTextBox" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ColumnNameTextBox" class="col-sm-2 control-label"></label>
                                                    <div class="col-sm-4">
                                                        <div class="">

                                                            <asp:Button ID="btnUpdateDistributor" runat="server" Text="Update" CssClass="btn btn-primary" />
                                                            <asp:Button ID="btnCancelEditDistributor" runat="server" Text="Cancel" CssClass="btn btn-default" />

                                                        </div>

                                                    </div>
                                                </div>
                                            </div>

                                        </asp:Panel>

                                    </div>
                                </div>
                            </div>


                        </telerik:RadPageView>

                    </telerik:RadMultiPage>

                </div>
            </div>
        </asp:Panel>

        <%--Edit Brand--%>
        <asp:Panel ID="EditBrandsPanel" runat="server" Visible="false">
            <div class="widget stacked">

                <div class="row">
                    <div class="col-md-12">

                        <div class="tabbable">

                            <ul id="MainTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                                <li class="active"><a href="#defaulttab" data-toggle="tab">Information</a></li>
                                <li><a href="#executiontab" data-toggle="tab">Event Execution</a></li>
                                <%--<li class=""><a href="#productstab" data-toggle="tab">Products</a></li>--%>
                                <li class=""><a href="#staffingtab" data-toggle="tab">Staffing</a></li>
                                <li class=""><a href="#eventtaskstab" data-toggle="tab">Event Tasks</a></li>
                                <li class=""><a href="#recaptab" data-toggle="tab">Recap Questions</a></li>
                                <li class=""><a href="#postab" data-toggle="tab">POS</a></li>
                                <li class=""><a href="#documentstab" data-toggle="tab">Documents</a></li>

                                <li class="pull-right secondarytab">
                                    <asp:Button ID="btnRetun" runat="server" Text="<< Supplier " CssClass="btn btn-md btn-default" />
                                </li>
                            </ul>

                            <div class="tab-content tab-container">
                                <!-- Client Details Tab -->
                                <div class="tab-pane active" id="defaulttab">
                                    <div class="widget stacked">
                                        <div class="widget-content min-height">
                                            <h2>
                                                <asp:Label ID="BrandNameLabel" runat="server" /></h2>

                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                    <div class="col-sm-12">
                                                        <asp:Button ID="btnUpdateBrand" runat="server" Text="Save Changes" CssClass="btn btn-md btn-primary" />
                                                        <asp:Button ID="btnCancelUpdateBrand" runat="server" Text="Cancel" CssClass="btn btn-md btn-default" />
                                                    </div>
                                                </div>
                                            </div>

                                            <hr />

                                            <asp:Panel runat="server" ID="InformationPanel2">
                                                <div class="form-horizontal">

                                                    <div class="form-group">
                                                        <label for="BrandNameTextBox" class="col-sm-2 control-label">Brand Name:</label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="BrandNameTextBox" runat="server" CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                    <asp:HiddenField ID="HiddenBrandGroupID" runat="server" />

                                                    <div class="form-group">
                                                        <label for="ActiveTextBox" class="col-sm-2 control-label">Active:</label>
                                                        <div class="col-sm-2">
                                                            <asp:DropDownList ID="ActiveTextBox" runat="server" CssClass="form-control" Width="150px">
                                                                <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                                <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                            </asp:DropDownList>

                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="StartDateTextBox1" class="col-sm-2 control-label">Brand Start Date:</label>
                                                        <div class="col-sm-10">
                                                            <div class="form-inline">

                                                                <telerik:RadDatePicker ID="StartDateDatePicker" runat="server" Skin="Bootstrap"></telerik:RadDatePicker>

                                                                <label for="EndDateTextBox1" class="control-label" style="padding-right: 15px; padding-left: 20px;">Brand End Date:</label>
                                                                <telerik:RadDatePicker ID="EndDateDatePicker" runat="server" Skin="Bootstrap"></telerik:RadDatePicker>

                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="DataViewEndDateTextBox1" class="col-sm-2 control-label">Data View End Date:</label>
                                                        <div class="col-sm-2">
                                                            <telerik:RadDatePicker ID="DataViewEndDateDatePicker" runat="server" Skin="Bootstrap"></telerik:RadDatePicker>
                                                        </div>
                                                    </div>
                                                   
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </div>

                                </div>

                                <!-- event execution Tab -->
                                <div class="tab-pane" id="executiontab">
                                    <div class="widget stacked">
                                        <div class="widget-content">
                                            <h2>Event Execution Details</h2>
                                            <hr />

                                            <uc1:BrandExecutionControl runat="server" ID="BrandExecutionControl" />
                                        </div>
                                    </div>
                                </div>


                                <!-- brand category Tab -->
                                <%--<div class="tab-pane" id="categorytab">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <h2>Brand Category</h2>
                                    <hr />

                                    <uc1:BrandCategoryControl runat="server" ID="BrandCategoryControl" />
                                </div>
                            </div>

                        </div>--%>

                                <div class="tab-pane" id="productstab">
                                    <div class="widget stacked">
                                        <div class="widget-content">
                                            <h2>Products</h2>
                                            <hr />
                                            <%--<uc1:BrandProcuctsControl runat="server" ID="BrandProcuctsControl" />--%>
                                        </div>
                                    </div>

                                </div>

                                <!-- role association Tab -->
                                <%--<div class="tab-pane" id="rolestab">
                                    <div class="widget stacked min-height">
                                        <div class="widget-content">
                                            <h2>Role Association</h2>
                                            <hr />

                                            <uc1:BrandRoleAssociationControl runat="server" ID="BrandRoleAssociationControl" />
                                        </div>
                                    </div>
                                </div>--%>

                                <!-- staffing Tab -->
                                <div class="tab-pane" id="staffingtab">
                                    <div class="widget stacked">
                                        <div class="widget-content">
                                            <h2>Staffing Details</h2>
                                            <hr />

                                            <uc1:BrandStaffingPositionControl runat="server" ID="BrandStaffingPositionControl" />

                                        </div>
                                    </div>
                                </div>

                                <!-- event tasks Tab -->
                                <div class="tab-pane" id="eventtaskstab">
                                    <div class="widget stacked">
                                        <div class="widget-content">
                                            <h2>Event Tasks</h2>
                                            <hr />

                                            <uc1:BrandEventTasksControl runat="server" ID="BrandEventTasksControl" />
                                        </div>
                                    </div>
                                </div>

                                <!-- documents Tab -->
                                <div class="tab-pane" id="documentstab">
                                    <div class="widget stacked">
                                        <div class="widget-content">
                                            <h2>Files/Documents</h2>
                                            <hr />

                                            <uc1:BrandDocumentControl runat="server" ID="BrandDocumentControl" />
                                        </div>
                                    </div>
                                </div>

                                <!-- recap questions Tab -->
                                <div class="tab-pane" id="recaptab">
                                    <div class="widget stacked">
                                        <div class="widget-content">
                                            <h2>Recap Questions</h2>
                                            <hr />

                                            <uc1:RecapQuestionsControl runat="server" ID="RecapQuestionsControl" />

                                        </div>
                                    </div>
                                </div>

                                <!-- pos Tab -->
                                <div class="tab-pane" id="postab">
                                    <div class="widget stacked">
                                        <div class="widget-content">
                                            <h2>POS Items</h2>
                                            <hr />

                                            <uc1:BrandPOSItemsControl runat="server" ID="BrandPOSItemsControl" />


                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>


            </div>


        </asp:Panel>

        <%--New Brands--%>
        <asp:Panel ID="NewBrandsPanel" runat="server" Visible="false">
        </asp:Panel>
    </div>
    <%--End Main Container--%>


    <asp:LinqDataSource ID="GetMarketList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" OrderBy="marketName" TableName="qryMarketsbyClients" Where="clientID == @clientID">
        <WhereParameters>
            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
        </WhereParameters>
    </asp:LinqDataSource>


    <asp:LinqDataSource ID="getSupplier" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EnableUpdate="True" EntityTypeName="" TableName="tblSuppliers"
        Where="supplierID == @supplierID">
        <WhereParameters>
            <asp:QueryStringParameter Name="supplierID" QueryStringField="SupplierID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>


    <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Text="Your changes were updated successfully!" Title="Success" TitleIcon="info"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>


    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script>
            function resetEventCourseList() {
                var supplierID = <%=Request.QueryString("SupplierID")%>


                    $.ajax({
                        type: "POST",
                        url: "/ClientService.asmx/ResetTrainingCourse",
                        data: "{ 'supplierID': '" + supplierID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            //alert("You have been checked in");

                        },
                        error: function (request, status, error) {
                            alert(request.responseText);
                        },

                        complete: function (response) {
                            alert("The events have been updated!");
                        }

                    });

            }
        </script>
    </telerik:RadCodeBlock>

</asp:Content>
