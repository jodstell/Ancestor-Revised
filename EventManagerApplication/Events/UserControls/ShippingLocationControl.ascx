<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ShippingLocationControl.ascx.vb" Inherits="EventManagerApplication.ShippingLocationControl" %>


<asp:HiddenField ID="Hidden_POSLatitude" runat="server" Visible="true" />
<asp:HiddenField ID="HIdden_POSLongtitude" runat="server" Visible="true" />

<div class="row" style="padding: 15px;">
    <div class="col-sm-12 col-md-12">

        <p>
            <asp:Label ID="ShippingStatusLabel" runat="server" />
        </p>

    </div>
    
</div>


<asp:Panel ID="ShippingPanel" runat="server">
<div class="row" style="padding:  0 15px 0 15px;">

    <div class="col-sm-6 col-md-7">

        <asp:Label ID="EventTypeName" runat="server" Font-Bold="true" />

        <asp:Repeater ID="POSItems" runat="server" DataSourceID="getKitItems">
            <HeaderTemplate>

                <table class="table compacttable">
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


    </div>

    <div class="col-sm-5 col-md-5">

        <strong>Shipping Address:</strong><br />
        
        <asp:Label ID="ShippingAddressLabel" runat="server" /><br />
        <asp:Label ID="AttLabel" runat="server" /><br />
        <br />

        <asp:Label ID="ShippedViaLabel" runat="server" /><br />
        <asp:Label ID="ShippedTypeLabel" runat="server" /><br />
        <asp:Label ID="TrackingLabel" runat="server" />


    </div>
</div>

</asp:Panel>


 