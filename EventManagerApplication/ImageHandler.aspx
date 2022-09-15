<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ImageHandler.aspx.vb" Inherits="EventManagerApplication.ImageHandler" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div>
    
        <asp:Repeater ID="ReceiptRepeater" runat="server" DataSourceID="ReceiptSqlDataSource">

            <ItemTemplate>
                <telerik:RadBinaryImage runat="server" ID="ReceiptImage" ResizeMode="Fit" Width="600px"
                Height="600px" DataValue='<%#Eval("Image") %>' />
        </ItemTemplate>
            
        </asp:Repeater>

        <asp:SqlDataSource ID="ReceiptSqlDataSource" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
            SelectCommand="SELECT [photoID], [Image] FROM [tblPhoto] WHERE ([photoID] = @photoID)">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="PhotoID" Name="photoID" Type="Int32"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>

       


    </div>
    </form>
</body>
</html>
