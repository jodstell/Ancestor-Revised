<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PhotoGallery.aspx.vb" Inherits="EventManagerApplication.PhotoGallery" %>

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


         <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
             SelectCommand="SELECT [photoID], [photoTitle], [photoDescription], [LargeImage], [accountID], [eventID], [brandID] FROM [tblPhoto] WHERE ([eventID] = @eventID)and ([Tag] Is Not Null)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="String"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>

        </div>
    </form>
</body>
</html>
