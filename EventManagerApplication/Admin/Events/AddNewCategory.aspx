<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AddNewCategory.aspx.vb" Inherits="EventManagerApplication.AddNewCategory" %>

<%@ Register Src="~/Admin/UserControls/AddCategoryTypeControl.ascx" TagPrefix="uc1" TagName="AddCategoryTypeControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .form-group {
            margin-bottom: 10px;
        }

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

        .label-standard {
            background-color: #000;
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-12">

                <div style="margin: 0 0 15px 0">
                    <h2>Client:
                <asp:Label ID="ClientNameLabel" runat="server" Font-Bold="true" />

                    </h2>
                    <h3><asp:Label ID="HeaderLabel" runat="server" Text="Add Category"></asp:Label></h3>
                </div>

                <div class="row">
                    <div id="messageHolder">
                        <asp:Literal ID="msgLabel" runat="server" />
                    </div>
                </div>

            </div>
        </div>

        <asp:Panel ID="Panel1" runat="server">
            <div class="widget stacked">
                <div class="widget-content">

                    <div class="row">
                        <div class="col-md-12">
                            <%--<h3></h3>
                            <hr />--%>

                            <div class="form-horizontal">

                                <asp:Panel ID="AddCategoryPanel" runat="server">

                                    <div class="form-group">
                                        <label for="CategoryNameTextBox" class="col-sm-2 control-label">Category Name: <span class="text-danger">*</span></label>

                                        <div class="col-sm-6">
                                            <asp:TextBox ID="CategoryNameTextBox" runat="server" CssClass="form-control" />

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                ErrorMessage="Category Name is required" CssClass="errorlabel" ControlToValidate="CategoryNameTextBox"
                                                Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                     <div class="row">
                                        <div class="col-md-12">
                                            <div class="pull-right">
                                                <asp:LinkButton ID="btnSave" runat="server" Text="Save" CssClass="btn btn-md btn-primary" ValidationGroup="billing"></asp:LinkButton>

                                                <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-md btn-default"></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>

                                    </asp:Panel>

                                <asp:Panel ID="SubCategoryPanel" runat="server" Visible="false">


                                    <div class="form-group">

                                        <label for="ActiveComboBox" class="col-sm-2 control-label">Sub Categories:</label>

                                        <div class="col-sm-6">

                                           
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

                                                <telerik:RadListBox ID="CategoryTypeList" runat="server"
                                                    DataSourceID="getCategoryTypeList"
                                                    DataKeyField="BrandCategoryTypeID"
                                                    DataTextField="name"
                                                    DataValueField="BrandCategoryTypeID"
                                                    DataSortField="name"
                                                    AllowTransferOnDoubleClick="false"
                                                    EnableDragAndDrop="false"
                                                    ButtonSettings-AreaWidth="35px" Height="200px" Width="200px"
                                                    AutoPostBack="true"
                                                    AllowTransfer="false"
                                                    AutoPostBackOnTransfer="true" Skin="Bootstrap" Style="top: 0px; left: 0px">
                                                    <ButtonSettings ShowTransferAll="false" />
                                                </telerik:RadListBox>

                                                <asp:SqlDataSource ID="getCategoryTypeList" runat="server"
                                                    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                                                    SelectCommand="SELECT * FROM tblBrandCategoryType WHERE BrandCategoryID = @BrandCategoryID ORDER BY name">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="CategoryIDLabel" Name="BrandCategoryID" PropertyName="Text" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>

                                            </div>


                                        </div>

                                        <div class="col-sm-10">

                                            <asp:Label ID="CategoryIDLabel" runat="server" />

                                            

                                        </div>

                                    </div>

                                   

                                

                                

                                    <div class="form-group">

                                        <label for="ActiveComboBox" class="col-sm-2 control-label">Sub Categories:</label>

                                        

                                    </div>
                                </asp:Panel>

                            </div>




                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="pull-right">
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
