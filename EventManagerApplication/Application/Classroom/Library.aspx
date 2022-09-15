<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Library.aspx.vb" Inherits="EventManagerApplication.Library" %>

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
            <%--Start Main Content--%>

                                         <div class="col-md-6">

                                            <div class="feed-subject">
                                            
                                                <h3>Documents</h3>
                                        </div>

                                        <ul class="icons-list">
                                        <telerik:RadListView ID="LibraryFileList" runat="server">
                                            <ItemTemplate>
                                                <li><i class="icon-li fa fa-file-text-o"></i>
                                                    <a href='/FileHandler.aspx?ID=<%# Eval("ID")%>'><%# Eval("FileName")%><%# getFileType(Eval("ContentType"))%></a> 
                                                </li>
                                            </ItemTemplate>

                                            <EmptyDataTemplate>
                                                There are no documents.
                                            </EmptyDataTemplate>
                                        </telerik:RadListView>
                                        </ul>
                                            </div>

                                             <div class="col-md-6 col-sidebar-right">

                                            <div class="feed-subject">
                                            
                                                <h3>Links</h3>
                                                


                                            <ul class="icons-list">
                                            <telerik:RadListView ID="CourseLinksList" runat="server">
                                            <ItemTemplate>
                                                <li><i class="icon-li fa fa-external-link"></i>
                                                    <a href='http://<%# Eval("LinkURL")%>' target="_blank"><%# Eval("LinkURL")%></a> - <%# Eval("LinkTitle")%>
                                                    </li>
                                            </ItemTemplate>
                                                <EmptyDataTemplate>

                                                    There are no links.
                                                </EmptyDataTemplate>
                                             
                                            </telerik:RadListView>
                                            </ul>
                                        </div>
                                        </div>
        
        
        
        
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
        $('#library').addClass('active');
    </script>

    </div>

</asp:Content>
