<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssociatedSuppliersControl.ascx.vb" Inherits="EventManagerApplication.AssociatedSuppliersControl" %>

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

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <div class="list-containers">

        <div class="list-container size-thin">
            <div class="title">
                Available Suppliers
            </div>

<telerik:RadListBox ID="AvailableSuppliers" runat="server" 
    DataSourceID="SqlDataSource2"
        DataKeyField="supplierID"
        DataTextField="supplierName"
        DataValueField="supplierID"
        DataSortField="supplierName"
     TransferToID="SelectedSuppliers"
     AllowTransferOnDoubleClick="true"
     EnableDragAndDrop="true"
     ButtonSettings-AreaWidth="35px" Height="200px" Width="230px"
     AutoPostBack="true"
     AllowTransfer="True"
     AutoPostBackOnTransfer="true" Skin="Bootstrap" style="top: 0px; left: 0px">
    <ButtonSettings ShowTransferAll="false" />
</telerik:RadListBox>

             </div>

        <div class="list-container size-thin">

            <div class="title">
                Associated Suppliers
            </div>
     
<telerik:RadListBox ID="SelectedSuppliers" runat="server"  OnInserted="SelectedSuppliers_Inserted1" OnDeleted="SelectedSuppliers_Deleted1"
    DataSourceID="SqlDataSource1"
        DataKeyField="supplierID"
        DataTextField="supplierName"
        DataValueField="supplierID"
        DataSortField="supplierName"
     AllowDelete="True"
        AutoPostBack="true"
        AutoPostBackOnDelete="true"
        Height="200px" Width="225px" Skin="Bootstrap"

    >
</telerik:RadListBox>

            </div>

    </div>

<div style="margin: 15px 0 15px 0">
        <asp:Label ID="msgLabel" runat="server" />
    </div>

    <asp:HiddenField ID="HF_SelectedItemID" runat="server" />

    <asp:SqlDataSource ID="SqlDataSource2" runat="server"
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
    SelectCommand="SELECT supplierID AS DataKeyID, supplierID AS InsertID, supplierID, supplierName FROM tblSupplier
WHERE (supplierID NOT IN (select supplierID from getAllSuppliersbyBrands where getAllSuppliersbyBrands.brandID = @brandID)) 
ORDER BY supplierName">
        <SelectParameters>
            <asp:QueryStringParameter Name="brandID" QueryStringField="BrandID" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
        SelectCommand="getSuppliersbyBrandID" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="BrandID" QueryStringField="BrandID" Type="Int32" />
            <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>

</telerik:RadAjaxPanel>