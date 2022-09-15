<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Profile_Image.aspx.vb" Inherits="EventManagerApplication.Profile_Image" %>

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

        <asp:Repeater ID="HeadshotRepeater" runat="server" DataSourceID="getHeadShot1" Visible="false">
            <ItemTemplate>
                <telerik:RadBinaryImage runat="server" ID="HeadshotImage" ResizeMode="Fit" Width="600px"
                Height="600px" DataValue='<%#Eval("headShot") %>' SavedImageName='<%# getHeadShotFileName(Eval("UserID")) %>' />
        </ItemTemplate>

        </asp:Repeater>

  
        <asp:Repeater ID="BodyshotRepeater" runat="server" DataSourceID="getHeadShot2" Visible="false">
            <ItemTemplate>
                <telerik:RadBinaryImage runat="server" ID="BodyshotImage" ResizeMode="Fit" Width="600px"
                        Height="600px" DataValue='<%#Eval("bodyShot") %>' SavedImageName='<%# getBodyShotFileName(Eval("UserID")) %>' />
                        </ItemTemplate>
        </asp:Repeater>


        <asp:SqlDataSource ID="getHeadShot2" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [userID], [bodyShot] FROM [tblAmbassadorPhoto] WHERE ([userID] = @userID)">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="getHeadShot1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
             SelectCommand="SELECT [userID], [headShot] FROM [tblAmbassadorPhoto] WHERE ([userID] = @userID)">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="UserID" Name="userID" Type="String"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>
        
    
    </div>
    </form>
</body>
</html>
