<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Dashboard.aspx.vb" Inherits="EventManagerApplication.Dashboard3" %>

<%@ Register Src="/Application/Classroom/UserControls/TitleBlockControl.ascx" TagName="TitleBlockControl" TagPrefix="uc1" %>
<%@ Register Src="/Application/Classroom/UserControls/MyAssignmentsControl.ascx" TagName="MyAssignmentsControl" TagPrefix="uc2" %>
<%@ Register Src="/Application/Classroom/UserControls/ClassAnnouncementsControl.ascx" TagName="ClassAnnouncementsControl" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style>
        .main {
            padding: 10px;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container min-height">
        

      <uc1:TitleBlockControl ID="TitleBlockControl1" runat="server" />

    <div class="col-md-9">

        <asp:Repeater ID="Row1Dashboard" runat="server">
            <HeaderTemplate>
                <div class="row">
            </HeaderTemplate>
            <ItemTemplate>
                 <div class="col-sm-4 col-md-4">
                   <a href="<%# Eval("PageURL")%>?CourseID=<%: Request.QueryString("CourseID")%>">
                        <div class='well <%# Eval("Color")%> smbox'>
                            <div class="icon marginbotton5"><i class='<%# getIcon(Eval("Icon"))%> fa-3x'></i></div>
                            <h4 class="noline">
                                <%# MyCulture.getCulture(Eval("WidgetID"), "Title", Session("MyCulture"), Eval("Title"))%>
                                
                                </h4>
                            <div class="rowbox2">
                            <p class="tight"><%# Eval("DescriptionText")%></p></div>
                        </div>
                    </a>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>


         <asp:Repeater ID="Row2Dashboard" runat="server">
            <HeaderTemplate>
                <div class="row">
            </HeaderTemplate>
            <ItemTemplate>
                 <div class="col-sm-3 col-md-3">
                   <a href="<%# Eval("PageURL")%>?CourseID=<%: Request.QueryString("CourseID")%>">
                        <div class='well <%# Eval("Color")%> smbox'>
                            <div class="icon marginbotton5"><i class='<%# getIcon(Eval("Icon"))%> fa-3x'></i></div>
                            <h4 class="noline"><%--<%# Eval("Title")%>--%>
                                <%# MyCulture.getCulture(Eval("WidgetID"), "Title", Session("MyCulture"), Eval("Title"))%>
                                <%--<%# Eval("WidgetID")%>--%>

                            </h4>
                            <div class="rowbox3">
                            <p class="tight"><%# Eval("DescriptionText")%></p></div>
                        </div>
                    </a>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>
        

        <div class="row">
            <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-body">

                <h3><asp:Label ID="ClassAnnouncements" runat="server" Text="<%$ Resources:Resource, ClassAnnouncements %>" ></asp:Label>
                    &nbsp;</h3>
                <asp:Repeater ID="AnnouncementsList" runat="server">
                    <HeaderTemplate>
                        <ul class="icons-list">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li>
                            <strong><%# Eval("Title")%></strong><br />
                            <%# Eval("Description") %>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>
                        </ul>
                        <asp:Label ID="lblEmptyData"
                         Text="There are no announcements." runat="server" Visible="false">
                        </asp:Label>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
                </div>
            <div class="col-md-12">

        <div class="panel panel-default">
            <div class="panel-body">

                <asp:PlaceHolder ID="CourseDescriptionHolder" runat="server"></asp:PlaceHolder>
                <asp:PlaceHolder ID="CourseSyllabusHolder" runat="server"></asp:PlaceHolder>
            </div>
        </div>

                </div>

            </div>

    </div>
    <!-- /span8 -->


    <div class="col-md-3">

        <%--      		<div class="well">

      			<h4>About the Classroom</h4>

				<p>This feature is not currently available with this subscription.</p>

      		</div>--%>

        <asp:PlaceHolder ID="CourseDates" runat="server" />

       

       
    <h4>Knowledge-Based Resources</h4>
            

<%--    <asp:Repeater ID="Repeater1" runat="server">
        <HeaderTemplate>--%>
            <div class="list-group">
        <%--</HeaderTemplate>
        <ItemTemplate>--%>
         
                <a href="#" class="list-group-item">
            <i class='icon-li fa fa-caret-right'></i>
            &nbsp;&nbsp;<strong>PRODUCT KNOWLEDGE</strong></a>

        <%--</ItemTemplate>
        <FooterTemplate>--%>
            </div>

          <%--  <asp:Label ID="lblEmptyData"
              Text="There are no announcements." runat="server" Visible="false">
            </asp:Label>

        </FooterTemplate>
    </asp:Repeater>--%>

           
         <uc2:MyAssignmentsControl ID="MyAssignmentsControl1" runat="server" />

        <uc3:ClassAnnouncementsControl ID="ClassAnnouncementsControl1" runat="server" />
          

        <asp:Panel ID="SupportPanel" runat="server">
        <div class="widget widget-plain">
            <div class="widget-content">
                <a href="/application/support/contactsupport" class="btn btn-primary btn-support-contact"><asp:Label ID="ContactSupportButton" runat="server" Text="<%$ Resources:Resource, ContactSupportButton %>" /></a>
            </div>
            <!-- /widget-content -->
        </div>
        <!-- /widget -->
        </asp:Panel>

    </div>
    <!-- /span4 -->


    <!-- /row -->

        </div>
</asp:Content>
