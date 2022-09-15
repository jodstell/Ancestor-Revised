<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandsControl.ascx.vb" Inherits="EventManagerApplication.BrandsControl" %>


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







    <div class="list-containers">

        <div id="list1" class="list-container size-thin">
            <div class="title">
                Available Brands
            </div>
            <telerik:RadListBox ID="AssociatedBrandsList" runat="server"
                TransferToID="SelectedBrandsList"
                AllowTransferOnDoubleClick="True"
                EnableDragAndDrop="True"
                ButtonSettings-AreaWidth="35px" Height="200px" Width="350px"
                DataKeyField="DataKeyID" DataSortField="brandName"
                DataSourceID="SqlDataSource1"
                DataTextField="brandName"
                DataValueField="brandID"
                
                AllowTransfer="True"
                >
                <ButtonSettings ShowTransferAll="false" />

            </telerik:RadListBox>
        </div>

        <div id="list2" class="list-container size-thin">

            <div class="title">
                Associated Brands
            </div>
            <telerik:RadListBox runat="server" ID="SelectedBrandsList" 
                OnInserted="SelectedBrandsList_Inserted1" OnDeleted="SelectedBrandsList_Deleted1"
                AllowDelete="True"
                
                DataSourceID="getBrandsbySupplier"
                DataKeyField="supplierBrandID"
                DataTextField="brandName"
                DataValueField="brandID"
                DataSortField="brandName"
                
                Height="200px" Width="350px">
            </telerik:RadListBox>

        </div>

    </div>
    <div style="margin: 15px 0 15px 0">
        <asp:Label ID="msgLabel" runat="server" />
    </div>

    <asp:HiddenField ID="HF_SelectedItemID" runat="server" />




<asp:LinqDataSource ID="getSelectedBrands" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="brandName" TableName="getBrandsbySuppliers" Where="supplierID == @supplierID">
    <WhereParameters>
        <asp:QueryStringParameter Name="supplierID" QueryStringField="SupplierID" Type="Int32" />
    </WhereParameters>
</asp:LinqDataSource>

<asp:LinqDataSource ID="getBrands" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" Select="new (brandID, brandName)" TableName="tblBrands" OrderBy="brandName">
</asp:LinqDataSource>

<asp:SqlDataSource ID="getBrandsbySupplier" runat="server"
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
    InsertCommand="INSERT INTO tblSupplierBrands(supplierID, brandID) VALUES (@supplierID, @brandID)"
    SelectCommand="SELECT * FROM [getBrandsbySupplier] WHERE ([supplierID] = @supplierID)"
    DeleteCommand="DELETE FROM [tblSupplierBrands] WHERE ([supplierBrandID] = @supplierBrandID)">
    <DeleteParameters>
        <asp:Parameter Name="supplierBrandID" />
    </DeleteParameters>
    <InsertParameters>
        <asp:QueryStringParameter Name="supplierID" QueryStringField="SupplierID" />
        <asp:Parameter Name="brandID" />
    </InsertParameters>
    <SelectParameters>
        <asp:QueryStringParameter Name="supplierID" QueryStringField="SupplierID" />
    </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
    SelectCommand="SELECT brandID AS DataKeyID, brandID AS InsertID, brandID, brandName FROM tblBrands 
WHERE (clientID = @clientID and brandID NOT IN (select brandID from getBrandsbySupplier where getBrandsbySupplier.supplierID = @supplierID)) 
ORDER BY brandName">
    <SelectParameters>
        <asp:QueryStringParameter Name="ClientID" QueryStringField="ClientID" />
        <asp:QueryStringParameter Name="supplierID" QueryStringField="SupplierID" />
    </SelectParameters>
</asp:SqlDataSource>
