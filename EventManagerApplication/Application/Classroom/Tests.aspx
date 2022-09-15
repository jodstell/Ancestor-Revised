<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Tests.aspx.vb" Inherits="EventManagerApplication.Tests" %>

<%@ Register Src="~/Application/Classroom/UserControls/TitleBlockControl.ascx" TagPrefix="uc1" TagName="TitleBlockControl" %>
<%@ Register Src="~/Application/Classroom/UserControls/ClassRoomNavBar.ascx" TagPrefix="uc2" TagName="ClassRoomNavBar" %>
<%@ Register Src="~/Application/Classroom/UserControls/MyAssignmentsControl.ascx" TagPrefix="uc3" TagName="MyAssignmentsControl" %>
<%@ Register Src="~/Application/Classroom/UserControls/ClassAnnouncementsControl.ascx" TagPrefix="uc4" TagName="ClassAnnouncementsControl" %>
<%@ Register Src="~/Application/Classroom/UserControls/AvailableTestsControl.ascx" TagPrefix="uc5" TagName="AvailableTestsControl" %>
<%@ Register Src="~/Application/Classroom/UserControls/CompletedTestsControl.ascx" TagPrefix="uc6" TagName="CompletedTestsControl" %>


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
            <uc2:ClassRoomNavBar runat="server" ID="ClassRoomNavBar" />
        </div>

        <div class="col-md-7">
             <h2 class="hidden-xs"><%: GetWidgetName()%></h2>
             <p><%: GetWidgetDescription()%></p>
            <hr />

<%--              <asp:Repeater ID="DataList1" runat="server">
                    <HeaderTemplate>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                        <a href="/start?id=<%# Eval("TestID")%>" class="noline">
                            <div class="well bluebox wellbox">
                                <div class="smbox">
                                <div class="icon marginbotton10"><i class="fa fa-check-square-o fa-3x"></i></div>
                                <h4 style="min-height:46px"><%# Eval("Title")%></h4>
                            </div>
                        </div>
                        </a>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                    </FooterTemplate>

                </asp:Repeater>--%>

            <uc5:AvailableTestsControl runat="server" ID="AvailableTestsControl1" />
            <uc6:CompletedTestsControl runat="server" ID="CompletedTestsControl1" />

        </div>

        <div class="col-md-3 col-sidebar-right">

            <uc3:MyAssignmentsControl ID="MyAssignmentsControl1" runat="server" />

            <uc4:ClassAnnouncementsControl ID="ClassAnnouncementsControl1" runat="server" />
        </div>

        



    </div>
        </div>

    <script type="text/javascript">
        $('#nav_5').addClass('active');
    </script>

    <script type="text/javascript">
        $('#tests').addClass('active');
    </script>

</asp:Content>
