<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Notes.aspx.vb" Inherits="EventManagerApplication.Notes" %>

<%@ Register Src="/Application/Classroom/UserControls/TitleBlockControl.ascx" TagName="TitleBlockControl" TagPrefix="uc1" %>
<%@ Register Src="/Application/Classroom/UserControls/ClassRoomNavBar.ascx" TagName="ClassRoomNavBar" TagPrefix="uc2" %>
<%@ Register src="/Application/Classroom/UserControls/MyAssignmentsControl.ascx" tagname="MyAssignmentsControl" tagprefix="uc3" %>
<%@ Register src="/Application/Classroom/UserControls/ClassAnnouncementsControl.ascx" tagname="ClassAnnouncementsControl" tagprefix="uc4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .main {
            padding: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

      <script type="text/javascript">


        function createnote() {
            

            var username = "barbara@virtuallearningol.com"
            var note = "This is our first note from the webservice"


            $.ajax({
                type: "POST",
                url: "/ClientService.asmx/CreateNote",
                data: "{ 'username': '" + username + "', 'note': '" + note + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                error: OnError
            });

        }

        function OnSuccess(data, status) {
            //            alert(data.d); 
        }

        function OnError(request, status, error) {
            alert(request.statusText);
        }

    </script>

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

            <a href="#" onclick="createnote()">Create Note</a><br />

            There are no notes to display at this time.  Please check back again later.
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
