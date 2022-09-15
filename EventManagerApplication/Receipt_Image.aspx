<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Receipt_Image.aspx.vb" Inherits="EventManagerApplication.Recipt_Image" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <style>
   html
  {
      /*added to prevent scroll bars in radwindow*/
   overflow: hidden;
  }
</style>

    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    

        <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <telerik:RadFormDecorator runat="server" ID="RadFormDecorator1" Skin="Bootstrap" DecoratedControls="All" />

        <asp:Label ID="msgLabel" runat="server" />

        <asp:Repeater ID="ReceiptRepeater" runat="server" DataSourceID="ReceiptSqlDataSource">

            <ItemTemplate>
                <telerik:RadBinaryImage runat="server" ID="ReceiptImage" ResizeMode="Fit" Width="600px"
                Height="600px" DataValue='<%#Eval("receipt") %>' />
        </ItemTemplate>
            
        </asp:Repeater>

        <asp:SqlDataSource ID="ReceiptSqlDataSource" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
            SelectCommand="SELECT [receipt] FROM [tblEventExpense] WHERE ([eventExpenseID] = @eventExpenseID)">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="eventExpenseID" Name="eventExpenseID" Type="Int32"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>


    </div>
    </form>
</body>
</html>
