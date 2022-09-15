<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="POSKitsControl.ascx.vb" Inherits="EventManagerApplication.POSKitsControl" %>

<%--<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">--%>

<div class="row" style="padding: 15px;">


    <div class="col-sm-12 col-md-12">

        <p></p>


        <asp:Label ID="EventTypeName" runat="server" Font-Bold="true" /><br />

        <telerik:RadListBox RenderMode="Lightweight" ID="POSItemList" runat="server" CheckBoxes="true" ShowCheckAll="true" Width="100%" Font-Bold="false">
            </telerik:RadListBox>

        
    </div>
</div>

<div class="row" style="padding:  0 15px 10px 15px;">
    <div class="col-sm-12 col-md-12">

        <asp:Label ID="labelForKits" runat="server" Font-Bold="true" Text="Would you like to have a kit shipped for event?" />

    </div>
    <div class="col-sm-12 col-md-12">

        <asp:RadioButtonList ID="KitRequested" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
            <asp:ListItem Text="No" Value="False"></asp:ListItem>
        </asp:RadioButtonList>
                
    </div>

</div>


<div class="row" style="padding:  0 15px 10px 15px;">
<div class="col-sm-12 col-md-12">
    <strong>Ship to:</strong><br />
    <telerik:RadComboBox ID="SendToList" runat="server" Width="250px">
        <Items>
            <telerik:RadComboBoxItem Text="Brand Ambassador" />
            <telerik:RadComboBoxItem Text="Event Location" />
            <telerik:RadComboBoxItem Text="FedEx Office" />
        </Items>
    </telerik:RadComboBox>
</div>
    </div>


<div class="row" style="padding: 0 15px 10px 15px;">
    <div class="col-sm-12 col-md-12">
        <strong>Shipping Notes:</strong><br />

        <telerik:RadTextBox ID="NotesTextBox" runat="server" Width="100%" Height="90px" TextMode="MultiLine"></telerik:RadTextBox>
    </div>
</div>

<div class="row" style="padding: 15px;">
    <div class="col-sm-12 col-md-12">
        <div class="pull-right">
            <asp:Button ID="btnSavePosKitRequest" runat="server" Text="Save" CssClass="btn btn-primary" />
        </div>

        

    </div>

    <div class="col-sm-12 col-md-12">
<asp:Label ID="SuccessLabel" runat="server" />
        </div>

</div>

<%--    </telerik:RadAjaxPanel>--%>