<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AddCategoryTypeControl.ascx.vb" Inherits="EventManagerApplication.AddCategoryTypeControl" %>

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

    .RadListBox {
        min-width: 100%;
        margin-top: 5px;
    }
</style>

<asp:Label ID="TempCategoryIDHiddenField1" runat="server" Visible="false"></asp:Label>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

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

        <telerik:RadListBox ID="CategoryTypeList" runat="server"
            DataSourceID="getTempCategoryTypeList"
            DataKeyField="tempBrandCategoryID"
            DataTextField="categoryTypeName"
            DataValueField="tempID"
            DataSortField="tempID"
            AllowTransferOnDoubleClick="false"
            EnableDragAndDrop="false"
            ButtonSettings-AreaWidth="35px" Height="200px" Width="200px"
            AutoPostBack="true"
            AllowTransfer="false"
            AutoPostBackOnTransfer="true" Skin="Bootstrap" Style="top: 0px; left: 0px">
            <ButtonSettings ShowTransferAll="false" />
        </telerik:RadListBox>

    </div>

    <div class="list-container size-thin">

        <div class="title">
            Variety
        </div>

        <div>

            <div class="input-group input-group-sm">
                <asp:TextBox ID="VarietyTextBox" runat="server" CssClass="form-control" ValidationGroup="details2"></asp:TextBox>
                <span class="input-group-btn">
                    <asp:Button ID="BtnAddVariety" runat="server" Text="Add" CssClass="btn btn-default" ValidationGroup="details2" />
                </span>
            </div>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                ErrorMessage="Variety is required" CssClass="errorlabel" ControlToValidate="VarietyTextBox"
                Display="Dynamic" ValidationGroup="details2"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Please, select a Category Type!" ControlToValidate="CategoryTypeList" CssClass="errorlabel"
                Display="Dynamic" ValidationGroup="details2" />
            <!-- /input-group -->

        </div>

        <telerik:RadListBox ID="SubCategoryTypeList" runat="server"
            DataKeyField="tempID"
            DataTextField="tempSubCategoryName"
            DataValueField="tempBrandCategorySubTypeID"
            DataSortField="tempSubCategoryName"
            AllowDelete="True"
            AutoPostBack="true"
            AutoPostBackOnDelete="true"
            Height="200px" Width="225px" Skin="Bootstrap">
        </telerik:RadListBox>

    </div>

</div>

<div style="margin: 15px 0 15px 0">
    <asp:Label ID="msgLabel" runat="server" />
</div>

<asp:HiddenField ID="HF_SelectedItemID" runat="server" />

<asp:SqlDataSource ID="getTempCategoryTypeList" runat="server"
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
    SelectCommand="SELECT tempBrandCategoryID, tempID, categoryTypeName FROM tempBrandCategoryType
                        WHERE tempBrandCategoryID = @tempBrandCategoryID
                        ORDER BY categoryTypeName">
    <SelectParameters>
        <asp:ControlParameter ControlID="TempCategoryIDHiddenField1" Name="tempBrandCategoryID" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="getTempSubCategoryList" runat="server"
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
    SelectCommand="SELECT tempBrandCategoryID, categoryTypeName FROM tempBrandCategoryType
                        WHERE tempBrandCategoryID = @tempBrandCategoryID
                        ORDER BY categoryTypeName">
    <SelectParameters>
        <asp:ControlParameter ControlID="TempCategoryIDHiddenField1" Name="tempBrandCategoryID" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>

</telerik:RadAjaxPanel>
