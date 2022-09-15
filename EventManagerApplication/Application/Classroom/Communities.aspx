<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Communities.aspx.vb" Inherits="EventManagerApplication.Communities" %>

<%@ Register Src="/Application/Classroom/UserControls/TitleBlockControl.ascx" TagName="TitleBlockControl" TagPrefix="uc1" %>
<%@ Register Src="/Application/Classroom/UserControls/ClassRoomNavBar.ascx" TagName="ClassRoomNavBar" TagPrefix="uc2" %>
<%@ Register src="/Application/Classroom/UserControls/MyAssignmentsControl.ascx" tagname="MyAssignmentsControl" tagprefix="uc3" %>
<%@ Register src="/Application/Classroom/UserControls/ClassAnnouncementsControl.ascx" tagname="ClassAnnouncementsControl" tagprefix="uc4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div class="container min-height">

         <uc1:TitleBlockControl ID="TitleBlockControl1" runat="server" />

    <div class="row">
        <div class="col-md-2">
            <uc2:ClassRoomNavBar ID="ClassRoomNavBar1" runat="server" />
        </div>

        <div class="col-md-7">
            <h2><%: GetWidgetName()%></h2>
                    <p><%: GetWidgetDescription()%></p>
            <hr />


            There are no communities to display at this time.  Please check back again later.
        </div>

        <div class="col-md-3 col-sidebar-right">

            <uc3:MyAssignmentsControl ID="MyAssignmentsControl1" runat="server" />

            <uc4:ClassAnnouncementsControl ID="ClassAnnouncementsControl1" runat="server" />
        </div>



    </div>

    <script type="text/javascript">
        $('#nav_5').addClass('active');
    </script>

    <script type="text/javascript">
        $('#summary').addClass('active');
    </script>

         </div>
</asp:Content>
