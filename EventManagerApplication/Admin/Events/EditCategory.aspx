<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditCategory.aspx.vb" Inherits="EventManagerApplication.EditCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            max-width: 280px;
        }

        .list-container {
            margin: 0px auto;
            padding: 10px;
            border: 1px solid #E2E4E7;
            background-color: #F5F7F8;
        }

        .RadListBox {
            min-width: 100%;
            margin-top: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

                <div style="margin: 0 0 15px 0">
                    <h2>Client:
                <asp:Label ID="ClientNameLabel" runat="server" Font-Bold="true" />

                    </h2>
                    <h3>Category Details:
                    <asp:Label ID="CategoryNameLabel" Font-Bold="true" runat="server" /></h3>
                    <asp:Label ID="ModifiedByLabel" runat="server" />
                </div>

                <div class="row">
                    <div id="messageHolder">
                        <asp:Literal ID="msgLabel" runat="server" />
                    </div>
                </div>

            </div>
        </div>



        <telerik:RadScriptBlock ID="RadScriptBlock_activityName" runat="server">
            <div class="pull-right secondarytab">
                <a href="/admin/ClientDetails?ClientID=<%= Common.GetCurrentClientID()%>&LoadState=Yes#eventtab/teams" class="btn btn-default" style="line-height: 1.4;">
                    <i class="fa fa-angle-double-left"></i>&nbsp;Client Overview</a>
            </div>
        </telerik:RadScriptBlock>


        <div class="widget stacked">
            <div class="widget-content min-height">

                <div class="row">
                    <div class="col-md-12">
                        <h2>Default Information</h2>

                        <asp:LinkButton ID="BtnSave" runat="server" Text="Save Changes" CssClass="btn btn-md btn-primary"></asp:LinkButton>
                        <asp:LinkButton ID="BtnCancel" runat="server" Text="Cancel" CssClass="btn btn-md btn-default"></asp:LinkButton>
                        <hr />

                        <div class="form-horizontal">

                            <div class="form-group">
                                <label for="CategoryNameTextBox" class="col-sm-2 control-label">Category Name: <span class="text-danger">*</span></label>

                                <div class="col-sm-6">
                                    <asp:TextBox ID="CategoryNameTextBox" runat="server" CssClass="form-control" />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ErrorMessage="Category Name is required" CssClass="errorlabel" ControlToValidate="CategoryNameTextBox"
                                        Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                </div>
                            </div>



                            <div class="form-group">
                                <label for="CategoryNameTextBox" class="col-sm-2 control-label">Type: <span class="text-danger">*</span></label>
                                <div class="col-sm-10">

                                    <div class="list-containers">

                                        <div class="list-container size-thin">

                                            <div class="title">
                                                Category Type
                                            </div>

                                            <div>

                                                <div class="input-group input-group-sm">
                                                    <asp:TextBox ID="CategoryTypeTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                    <span class="input-group-btn">
                                                        <asp:Button ID="BtnAddCategoryType" runat="server" Text="Add" CssClass="btn btn-default" ValidationGroup="details" />
                                                    </span>
                                                </div>
                                                <asp:RequiredFieldValidator ID="CategoryTypeRequiredFieldValidator" runat="server"
                                                    ErrorMessage="Category Type is required" CssClass="errorlabel" ControlToValidate="CategoryTypeTextBox"
                                                    Display="Dynamic" ValidationGroup="details"></asp:RequiredFieldValidator>
                                                <!-- /input-group -->

                                            </div>

                                            <telerik:RadListBox ID="CategoryTypeList" runat="server" OnSelectedIndexChanged="CategoryTypeList_SelectedIndexChanged"
                                                DataSourceID="getCategoryTypeList"
                                                DataKeyField="BrandCategoryTypeID"
                                                DataTextField="name"
                                                DataValueField="BrandCategoryTypeID"
                                                DataSortField="name"
                                                AllowDelete="True"
                                                AutoPostBack="true"
                                                AutoPostBackOnDelete="true"
                                                Height="200px" Width="225px" Skin="Bootstrap">
                                            </telerik:RadListBox>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getCategoryTypeList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblBrandCategoryTypes" Where="brandCategoryID == @brandCategoryID">
                                                <WhereParameters>
                                                    <asp:QueryStringParameter QueryStringField="BrandCategoryID" Name="brandCategoryID" Type="Int32"></asp:QueryStringParameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>

                                        </div>

                                        <div class="list-container size-thin">

                                            <div class="title">
                                                Variety
                                            </div>

                                            <div>

                                                <div class="input-group input-group-sm">
                                                    <asp:TextBox ID="VarietyTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                    <span class="input-group-btn">
                                                        <asp:Button ID="BtnAddVariety" runat="server" Text="Add" CssClass="btn btn-default"  ValidationGroup="details2" />
                                                    </span>
                                                </div>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                    ErrorMessage="Variety is required" CssClass="errorlabel" ControlToValidate="VarietyTextBox"
                                                    Display="Dynamic" ValidationGroup="details2"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Please, select a Category Type!" ControlToValidate="CategoryTypeList" CssClass="errorlabel"
                                                    Display="Dynamic" ValidationGroup="details2"/>
                                                <!-- /input-group -->

                                            </div>

                                            <telerik:RadListBox ID="SubCategoryTypeList" runat="server"
                                                DataKeyField="BrandCategoryTypeID"
                                                DataTextField="subCategoryName"
                                                DataValueField="brandCategoryTypeID"
                                                DataSortField="subCategoryName"
                                                AllowDelete="True"
                                                AutoPostBack="true"
                                                AutoPostBackOnDelete="true"
                                                Height="200px" Width="225px" Skin="Bootstrap">
                                            </telerik:RadListBox>

                                        </div>


                                    </div>
                                    <!--end col-sm-6-->

                                </div>
                                <!-- end list containers-->


                            </div>
                            <!--end form-group-->
                        </div>
                        <!--end form-horizontal-->
                    </div>
                    <!--end col-md-12-->

                </div>
                <!--end row-->

            </div>
            <!--end widget-content min-height-->
        </div>
        <!--end widget stacked-->

    </div>
    <!--end container-->
</asp:Content>
