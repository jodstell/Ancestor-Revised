<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewBrands.aspx.vb" Inherits="EventManagerApplication.ViewBrands" %>

<%@ Register Src="~/UserControls/AdminLeftNavBarControl.ascx" TagPrefix="uc1" TagName="AdminLeftNavBarControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .gridbutton {
    color: white;
}
    </style>
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
                <h2>Brands</h2>
                <hr />

                  <div style="margin-bottom:10px;">
                 <asp:LinkButton ID="btnAddNewBrand" runat="server" CssClass="btn btn-primary btn-md"><i class="fa fa-plus"></i> Add New Brand</asp:LinkButton>
                </div>

                 <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="getBrands">
                     <MasterTableView AutoGenerateColumns="False" DataKeyNames="brandID" DataSourceID="getBrands">
                         <Columns>
                             
                             <telerik:GridTemplateColumn>
                                 <ItemTemplate>
                                     <a href="#" class="btn btn-xs btn-primary" style="color:white">Edit</a>
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>

                             <telerik:GridBoundColumn DataField="brandName" 
                                 FilterControlAltText="Filter brandName column" 
                                 HeaderText="Name" 
                                 SortExpression="brandName" 
                                 UniqueName="brandName">
                                 <ColumnValidationSettings>
                                     <ModelErrorMessage Text="" />
                                 </ColumnValidationSettings>
                             </telerik:GridBoundColumn>

                           <telerik:GridTemplateColumn HeaderText="Supplier Manager">
                               <ItemTemplate>
                                   <asp:Label ID="NumberofEventsLabel" runat="server" Text="Supplier Manager"></asp:Label>
                               </ItemTemplate>
                           </telerik:GridTemplateColumn>

                           <telerik:GridTemplateColumn HeaderText="Number of Events">
                               <ItemTemplate>
                                   <asp:Label ID="NumberofEventsLabel" runat="server" Text="Number of Events"></asp:Label>
                               </ItemTemplate>
                           </telerik:GridTemplateColumn>

                           <telerik:GridTemplateColumn>
                               <ItemTemplate>
                                   <a href="#" class="btn btn-xs btn-primary">Active?</a>
                               </ItemTemplate>
                           </telerik:GridTemplateColumn>

                            
                         </Columns>
                     </MasterTableView>
                 </telerik:RadGrid>
                 <asp:LinqDataSource ID="getBrands" runat="server" 
                     ContextTypeName="EventManagerApplication.DataClassesDataContext" 
                     EntityTypeName="" OrderBy="brandName" TableName="tblBrands">
                 </asp:LinqDataSource>
            </div>
             </div>

            </div>

</asp:Content>
