<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewSuppliers.aspx.vb" Inherits="EventManagerApplication.ViewSuppliers" %>

<%@ Register Src="~/UserControls/AdminLeftNavBarControl.ascx" TagPrefix="uc1" TagName="AdminLeftNavBarControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h2>Administration</h2>
                <br />

            </div>
        </div>

        <div class="row">
           <div class="col-sm-3 col-lg-2">

                <uc1:AdminLeftNavBarControl runat="server" id="AdminLeftNavBarControl" />

            </div>

             <div class="col-sm-9 col-lg-10">
                <h2>Suppliers</h2>
                <hr />

                 
                <div style="margin-bottom:10px;">
                 <asp:LinkButton ID="btnAddNewSupplier" runat="server" CssClass="btn btn-primary btn-md"><i class="fa fa-plus"></i> Add New Supplier</asp:LinkButton>
                </div>

                 <telerik:RadGrid ID="SupplierList" runat="server" DataSourceID="getSuppliers">
                     <MasterTableView AutoGenerateColumns="False" DataKeyNames="supplierID" DataSourceID="getSuppliers">
                         <Columns>

                             <telerik:GridTemplateColumn>
                                 <ItemTemplate>
                                     <a href='SupplierDetails?SupplierID=<%# Eval("supplierID")%>' class="btn btn-xs btn-primary" style="color:white">View</a>
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>

                             <telerik:GridBoundColumn DataField="supplierID" DataType="System.Int32" FilterControlAltText="Filter supplierID column" HeaderText="supplierID" ReadOnly="True" SortExpression="supplierID" UniqueName="supplierID">
                                 <ColumnValidationSettings>
                                     <ModelErrorMessage Text="" />
                                 </ColumnValidationSettings>
                             </telerik:GridBoundColumn>

                             <telerik:GridBoundColumn DataField="supplierName" FilterControlAltText="Filter supplierName column" HeaderText="supplierName" SortExpression="supplierName" UniqueName="supplierName">
                                 <ColumnValidationSettings>
                                     <ModelErrorMessage Text="" />
                                 </ColumnValidationSettings>
                             </telerik:GridBoundColumn>

                             <telerik:GridCheckBoxColumn DataField="active" DataType="System.Boolean" FilterControlAltText="Filter active column" HeaderText="active" SortExpression="active" UniqueName="active">
                             </telerik:GridCheckBoxColumn>
                         </Columns>
                     </MasterTableView>
                 </telerik:RadGrid>
                 <asp:LinqDataSource ID="getSuppliers" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="supplierName" TableName="tblSuppliers">
                 </asp:LinqDataSource>
            </div>
        </div>

        </div>

</asp:Content>
