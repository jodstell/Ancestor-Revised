<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewMarkets.aspx.vb" Inherits="EventManagerApplication.ViewMarkets" %>
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
            

             <div class="col-md-12">
                <h2>Markets</h2>
                 <hr />

                 <telerik:RadGrid ID="MarketList" runat="server" DataSourceID="getMarkets">
                     <MasterTableView AutoGenerateColumns="False" DataKeyNames="marketID" DataSourceID="getMarkets">
                         <Columns>

                             <telerik:GridTemplateColumn>
                                 <ItemTemplate>
                                     <a href='/admin/regions/editmarket?MarketID=<%# Eval("MarketID")%>' style="color:white" class="btn btn-xs btn-primary">Edit</a>
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>

                                                        
                             <telerik:GridBoundColumn DataField="marketName" 
                                 FilterControlAltText="Filter marketName column" HeaderText="marketName" SortExpression="marketName" UniqueName="marketName">
                                 <ColumnValidationSettings>
                                     <ModelErrorMessage Text="" />
                                 </ColumnValidationSettings>
                             </telerik:GridBoundColumn>
                             <telerik:GridCheckBoxColumn DataField="active" DataType="System.Boolean" FilterControlAltText="Filter active column" HeaderText="active" SortExpression="active" UniqueName="active">
                             </telerik:GridCheckBoxColumn>
                             <telerik:GridBoundColumn DataField="regionID" DataType="System.Int32" FilterControlAltText="Filter regionID column" HeaderText="regionID" SortExpression="regionID" UniqueName="regionID">
                                 <ColumnValidationSettings>
                                     <ModelErrorMessage Text="" />
                                 </ColumnValidationSettings>
                             </telerik:GridBoundColumn>

                             <telerik:GridTemplateColumn>
                                 <ItemTemplate>
                                     <asp:Label ID="AccountsLabel" runat="server" Text='<%# getAccountsCount(Eval("marketID"))%>' />
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>

                         </Columns>
                     </MasterTableView>
                 </telerik:RadGrid>

                 <asp:LinqDataSource ID="getMarkets" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="marketName" TableName="tblMarkets" Where="regionID == @regionID">
                     <WhereParameters>
                         <asp:QueryStringParameter DefaultValue="1" Name="regionID" QueryStringField="RegionID" Type="Int32" />
                     </WhereParameters>
                 </asp:LinqDataSource>

            </div>

        </div>


      </div>
</asp:Content>
