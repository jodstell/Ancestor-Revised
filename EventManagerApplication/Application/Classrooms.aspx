<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Classrooms.aspx.vb" Inherits="EventManagerApplication.Classrooms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .main {
            padding: 25px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container min-height">

        <div class="row">

            <h1>Brand Ambassador Training</h1>

            <h4>Training and Development</h4>

            <br />

            <div class="marginbotton20">

                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                            <a href="/application/classroom/lessonplan?CourseID=<%# Eval("CourseID")%>" class="noline">
                                <div class="well bluebox smbox">
                                    <div class="icon marginbotton10">
                                       <%-- <i class="fa fa-desktop fa-3x"></i>--%>

                                        <img src='<%# Eval("IconURL")%>' class="pull-left brand-icon" height="63px" />
                                    </div>
                                    <div style="height: 44px;">
                                        <h4><%# Eval("CourseTitle")%></h4>
                                    </div>
                                    <div class="sub-title2">
                                        <%# getWidgetName(Eval("CourseID"), "LessonPLan")%> (<%# countLessons(Eval("CourseID"))%>), <%# getWidgetName(Eval("CourseID"), "Tests")%> (<%# countTests(Eval("CourseID"))%>)
                                    </div>
                                    <div><%# getWidgetName(Eval("CourseID"), "Media")%> (0), <%# getWidgetName(Eval("CourseID"), "Library")%> (<%# countFiles(Eval("CourseID"))%>)</div>
                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                    </FooterTemplate>

                </asp:Repeater>





            </div>
            <br />
            <br />
        </div>

        <hr />

        <div class="row">

            <h1>
                <asp:Label ID="TabNameLabel" runat="server" /></h1>

            <h4>
                <asp:Label ID="TabDescLabel" runat="server" /></h4>

            <br />


            <div class="marginbotton10">

                <asp:Repeater ID="DataList1" runat="server">
                    <HeaderTemplate>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                            <a href="/application/classroom/lessonplan?CourseID=<%# Eval("CourseID")%>" class="noline">
                                <div class="well bluebox smbox">
                                    <div class="icon marginbotton10">
                                        <%--<i class="fa fa-desktop fa-3x"></i>--%>

                                        <img src='<%# getIcon(Eval("CourseID"))%>' class="pull-left brand-icon" height="63px" />
                                    </div>
                                    <div style="height: 44px;">
                                        <h4><%# getCourseTitle(Eval("CourseID"))%></h4>
                                    </div>
                                    <div class="sub-title2">
                                        <%# getWidgetName(Eval("CourseID"), "LessonPlan")%> (<%# countLessons(Eval("CourseID"))%>), <%# getWidgetName(Eval("CourseID"), "Tests")%> (<%# countTests(Eval("CourseID"))%>)
                                    </div>
                                    <div><%# getWidgetName(Eval("CourseID"), "Media")%> (0), <%# getWidgetName(Eval("CourseID"), "Library")%> (<%# countFiles(Eval("CourseID"))%>)</div>
                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                    </FooterTemplate>

                </asp:Repeater>


                
                <br />
                <br />

            </div>

        </div>
    </div>
</asp:Content>
