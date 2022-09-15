<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewRegions.aspx.vb" Inherits="EventManagerApplication.ViewRegions" %>
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
            <div class="col-md-3">

            </div>

             <div class="col-md-9">
                <h2>Regions</h2>
                 <hr />

                 <telerik:RadGrid ID="RegionsList" runat="server" DataSourceID="getRegions">
                     <MasterTableView AutoGenerateColumns="False" DataKeyNames="regionID" DataSourceID="getRegions">
                         <Columns>

                             <telerik:GridTemplateColumn>
                                 <ItemTemplate>
<div class="btn-group btn-group-xs" role="group" aria-label="...">
                                     <a href='/admin/regions/viewmarkets?RegionID=<%# Eval("RegionID")%>' style="color:white" class="btn btn-primary">View</a>
                                 <a href='/admin/regions/viewmarkets?RegionID=<%# Eval("RegionID")%>' class="btn btn-default">Edit</a>
</div>
                                 
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>

                             <telerik:GridBoundColumn DataField="regionName" 
                                 FilterControlAltText="Filter regionName column" HeaderText="Region" SortExpression="regionName" UniqueName="regionName">
                                 <ColumnValidationSettings>
                                     <ModelErrorMessage Text="" />
                                 </ColumnValidationSettings>
                             </telerik:GridBoundColumn>

                             <telerik:GridTemplateColumn HeaderText="Markets In Region">
                                 <ItemTemplate>
                                     <asp:Label ID="MarketCountLabel" runat="server" Text='<%# getMarketCount(Eval("RegionID"))%>' />
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>
                         </Columns>
                     </MasterTableView>
                 </telerik:RadGrid>
                 <asp:LinqDataSource ID="getRegions" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="regionName" TableName="tblRegions">
                 </asp:LinqDataSource>
            </div>

        </div>


      </div>
</asp:Content>
