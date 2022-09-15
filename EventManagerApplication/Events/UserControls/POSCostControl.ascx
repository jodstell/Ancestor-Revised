<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="POSCostControl.ascx.vb" Inherits="EventManagerApplication.POSCostControl" %>



<div class="row" style="padding: 0 15px 0 15px;">
    <div class="col-sm-12 col-md-12">

        <p>
            <asp:Label ID="ShippingStatusLabel" runat="server" />
        </p>

    </div>
    
</div>



<asp:Panel ID="MainPanel" runat="server">
<div class="row" style="padding: 0 15px 0 15px;">



    <div class="col-sm-12 col-md-12">
        <strong>POS Kit</strong>
        <asp:Repeater ID="POSItemsRepeater" runat="server" DataSourceID="getKitItems">
            <HeaderTemplate>

                <table class="table compacttable">
                    <tr>
                        <th>Qty</th>
                        <th>Item/Category</th>

                        <th class="pull-right">Price</th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <%#Eval("qty") %>
                    </td>
                    <td>
                        <%#Eval("itemName") %>
                    </td>

                    <td class="pull-right">$<%#Eval("total") %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>


        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getKitItems" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryGetPosKitItems" Where="eventID == @eventID">
            <WhereParameters>
                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
            </WhereParameters>
        </asp:LinqDataSource>

       
        <asp:Label ID="ShippingLabel" runat="server" Font-Bold="true" Text="Shipping" /><br />

        <asp:Repeater ID="ShippingRepeater" runat="server" DataSourceID="getShippingCost">
            <HeaderTemplate>

                <table class="table compacttable">
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <%#Eval("description") %>
                    </td>
                    <td class="pull-right">
                        $<%#Eval("cost") %>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>


        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getShippingCost" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryGetPosShippingCosts" Where="eventID == @eventID && category == @category">
            <WhereParameters>
                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                <asp:Parameter DefaultValue="Shipping" Name="category" Type="String"></asp:Parameter>
            </WhereParameters>
        </asp:LinqDataSource>
   
       <asp:Label ID="LogisticsLabel" runat="server" Font-Bold="true" Text="Logistics/Handling" />

        <asp:Repeater ID="LogisticsRepeater" runat="server" DataSourceID="getHandlingCost">
            <HeaderTemplate>

                <table class="table compacttable">
            </HeaderTemplate>
            <ItemTemplate>
                 <tr>
                    <td>
                        <%#Eval("description") %>
                    </td>
                    <td class="pull-right">
                        $<%#Eval("cost") %>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>

          <asp:LinqDataSource runat="server" EntityTypeName="" ID="getHandlingCost" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryGetPosShippingCosts" Where="eventID == @eventID && category == @category">
            <WhereParameters>
                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                <asp:Parameter DefaultValue="Handling" Name="category" Type="String"></asp:Parameter>
            </WhereParameters>
        </asp:LinqDataSource>

<hr style="border-top: 1px solid #333;">

        <table class="table">
            
           
                 <tr>
                    <td>
                        <strong>Total:</strong>
                    </td>
                    <td class="pull-right">
                        <strong>$<asp:Label ID="TotalCostLabel" runat="server" /></strong>
                    </td>
                </tr>
           
                </table>

    </div>

    
</div>





</asp:Panel>


