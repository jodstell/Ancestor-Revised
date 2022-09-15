<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ImageEditor.aspx.vb" Inherits="EventManagerApplication.ImageEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="jQueryRotate.js"></script>
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>

    <div class="container">

        <asp:Image ID="Image1" ImageUrl="~/Gallery/Clock.jpg" runat="server" Width="300px" />

        <img src="Clock.jpg" id="image" width="300px" />

        <br />

        <input type="button" value="click"  />

        <asp:Button ID="Button1" runat="server" Text="Rotate Right" />


    </div>

    <script>
        var value = 0
        $("#image").rotate({
            bind:
            {
                click: function () {
                    value += 90;
                    $(this).rotate({ animateTo: value })
                }
            }
        });
       

    </script>

</asp:Content>
