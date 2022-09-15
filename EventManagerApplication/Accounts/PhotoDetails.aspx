<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PhotoDetails.aspx.vb" Inherits="EventManagerApplication.PhotoDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <telerik:RadFormDecorator runat="server" ID="RadFormDecorator1" Skin="Bootstrap" DecoratedControls="All" />

    <telerik:RadRotator runat="server" ID="RadRotator1" DataSourceID="getImageList"

        Skin="Bootstrap" RotatorType="Buttons" Width="640px" Height="450px" ScrollDirection="Right,Left "

        SlideShowAnimation-Type="Fade" ItemWidth="600px">

        <ItemTemplate>

           <%#SetInitialIndex(Container) %>

            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" ResizeMode="Crop" Width="600px"

                Height="600px" DataValue='<%#Eval("LargeImage") %>'/>

        </ItemTemplate>

    </telerik:RadRotator>


      <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [tblAccountPhoto] WHERE ([accountID] = @accountID)">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="AccountID" Name="accountID" Type="Int32"></asp:QueryStringParameter>
            </SelectParameters>
      </asp:SqlDataSource>

    </div>
    </form>
</body>
</html>
