<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Media.aspx.vb" Inherits="EventManagerApplication.Media" %>

<%@ Register Src="~/Application/Classroom/UserControls/TitleBlockControl.ascx" TagPrefix="uc1" TagName="TitleBlockControl" %>
<%@ Register Src="~/Application/Classroom/UserControls/ClassRoomNavBar.ascx" TagPrefix="uc1" TagName="ClassRoomNavBar" %>
<%@ Register Src="~/Application/Classroom/UserControls/MyAssignmentsControl.ascx" TagPrefix="uc1" TagName="MyAssignmentsControl" %>
<%@ Register Src="~/Application/Classroom/UserControls/ClassAnnouncementsControl.ascx" TagPrefix="uc1" TagName="ClassAnnouncementsControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .main {
            padding: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container min-height">

        <uc1:TitleBlockControl runat="server" ID="TitleBlockControl" />

    <div class="row">
        <div class="col-md-2">
            <uc1:ClassRoomNavBar runat="server" ID="ClassRoomNavBar" />
        </div>

        <div class="col-md-7">
             <h2 class="hidden-xs"><%: GetWidgetName()%></h2>
             <p><%: GetWidgetDescription()%></p>
            <hr />

            <iframe width="560" height="315" src="https://www.youtube.com/embed/tSmBmos6TVo" frameborder="0" allowfullscreen></iframe>

        </div>

        <div class="col-md-3 col-sidebar-right">

            <uc1:ClassAnnouncementsControl runat="server" ID="ClassAnnouncementsControl" />
<uc1:MyAssignmentsControl runat="server" ID="MyAssignmentsControl" />
        </div>



    </div>

    <script type="text/javascript">
        $('#nav_5').addClass('active');
    </script>

    <script type="text/javascript">
        $('#media').addClass('active');
    </script>

    </div>

</asp:Content>
