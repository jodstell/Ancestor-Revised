<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="LessonPlan.aspx.vb" Inherits="EventManagerApplication.LessonPlan" %>

<%@ Register Src="/Application/Classroom/UserControls/TitleBlockControl.ascx" TagName="TitleBlockControl" TagPrefix="uc1" %>
<%@ Register Src="/Application/Classroom/UserControls/ClassRoomNavBar.ascx" TagName="ClassRoomNavBar" TagPrefix="uc2" %>
<%@ Register Src="/Application/Classroom/UserControls/MyAssignmentsControl.ascx" TagName="MyAssignmentsControl" TagPrefix="uc3" %>
<%@ Register Src="/Application/Classroom/UserControls/ClassAnnouncementsControl.ascx" TagName="ClassAnnouncementsControl" TagPrefix="uc4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .main {
            padding: 15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
        .dataGroup {
            margin-bottom: 5px;
            padding-left: 0;
        }

        .listLayout {
            width: 100%;
            margin: 15px;
            padding: 20px;
            font: normal 13px/26px "Segoe UI", "Trebuchet MS", sans-serif;
            color: #000000;
        }

        /*RadKistView data item*/

        .rlv0 {
            float: left;
            min-width: 150px;
            width: 100%;
            min-height: 140px;
            margin: 4px;
            border-radius: 4px;
            box-shadow: 0 0 4px rgba(0,0,0,0.2);
            background: #f1f1f1;
            padding-right: 5px;
        }

            .rlv0 .category {
                padding-top: 10px;
                padding-left: 12px;
                line-height: 22px;
                color: #808080;
            }

                .rlv0 .category .bold_text {
                    font-weight: bold;
                    font-size: 16px;
                }

            .rlv0 .model {
                margin-bottom: 7px;
                line-height: 35px;
                color: #ffffff;
                font-weight: bold;
                background: #3399cc;
                border-radius: 4px 4px 0 0;
            }


        .rlvI {
            float: left;
            min-width: 150px;
            width: 100%;
            min-height: 140px;
            margin: 4px;
            border-radius: 4px;
            box-shadow: 0 0 4px rgba(0,0,0,0.2);
            background: #3399cc;
            padding-right: 5px;
        }

            .rlvI .category {
                padding-top: 10px;
                padding-left: 12px;
                line-height: 22px;
                color: white;
            }

                .rlvI .category .bold_text {
                    font-weight: bold;
                    font-size: 16px;
                }

            .rlvI .model {
                margin-bottom: 7px;
                line-height: 35px;
                color: #ffffff;
                font-weight: bold;
                background: #3399cc;
                border-radius: 4px 4px 0 0;
            }



        .rlvII {
            float: left;
            min-width: 150px;
            width: 100%;
            min-height: 140px;
            margin: 4px;
            border-radius: 4px;
            box-shadow: 0 0 4px rgba(0,0,0,0.2);
            background: rgba(0,0,0,0.2);
            padding-right: 5px;
        }

            .rlvII .category {
                padding-top: 10px;
                padding-left: 12px;
                line-height: 22px;
                color: #808080;
            }

                .rlvII .category .bold_text {
                    font-weight: bold;
                    font-size: 16px;
                }

            .rlvII .model {
                margin-bottom: 7px;
                line-height: 35px;
                color: #ffffff;
                font-weight: bold;
                background: #3399cc;
                border-radius: 4px 4px 0 0;
            }


        .rlvIII {
            float: left;
            min-width: 150px;
            width: 100%;
            min-height: 140px;
            margin: 4px;
            border-radius: 4px;
            box-shadow: 0 0 4px rgba(0,0,0,0.2);
            background: #419641;
            padding-right: 5px;
        }

            .rlvIII .category {
                padding-top: 10px;
                padding-left: 12px;
                line-height: 22px;
                color: white;
            }

                .rlvIII .category .bold_text {
                    font-weight: bold;
                    font-size: 16px;
                }

            .rlvIII .model {
                margin-bottom: 7px;
                line-height: 35px;
                color: #ffffff;
                font-weight: bold;
                background: #419641;
                border-radius: 4px 4px 0 0;
            }
    </style>

    <link href="styles/reports.css" rel="stylesheet" />




    <div class="container min-height">

        <uc1:TitleBlockControl ID="TitleBlockControl1" runat="server" />

        <div class="row">
            <%--<div class="col-md-2">
           <uc2:ClassRoomNavBar ID="ClassRoomNavBar1" runat="server" />
            
        </div>--%>


            <div class="">

                <div class="col-md-9">
                    <h2 class="hidden-xs"><%: GetWidgetName()%></h2>
                    <p><%: GetWidgetDescription()%></p>


                    <hr />
                    <asp:Label ID="PercentCompetedLabel" runat="server" Text='<%# GetPercentCompeted() %>'></asp:Label>
                    <div class="row">

                        <div class="col-md-12">
                            <asp:Panel ID="StartTestPanel" runat="server">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="col-lg-7">
                                            <i class="fa fa-check-circle fa-3x pull-left fa-border "></i>You have completed the curriculum.<br />
                                            Now you can take the course test.
                                        </div>
                                        <div class="col-lg-5">
                                            <asp:Button ID="btnTakeTest" runat="server" Text="Start Test"
                                                CssClass="btn btn-lg btn-primary btn-block pull-right" />
                                            <br />
                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>

                            <asp:Panel ID="ResultsPanel" runat="server">
                                <div class="panel panel-default">
                                    <div class="panel-body">

                                        <div class="col-lg-7">
                                            <i class="fa fa-check-circle fa-3x pull-left fa-border "></i>
                                            <h4>You have completed this course.</h4>
                                        </div>

                                        <div class="col-lg-5">
                                            <h3>Score: <%: TestResult() %></h3>
                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>


                            <telerik:RadListView ID="CurriculumGroupList" runat="server" ItemPlaceholderID="defaultHolder">
                                <LayoutTemplate>
                                    <asp:PlaceHolder ID="defaultHolder" runat="server"></asp:PlaceHolder>
                                </LayoutTemplate>
                                <ItemSeparatorTemplate>
                                    <hr />
                                </ItemSeparatorTemplate>
                                <ItemTemplate>
                                    <div class="row">
                                        <div class="col-sm-6">

                                            <h4 id="GroupTitle" style=""><%# Eval("Title")%></h4>

                                            <!-- show required curriculum -->


                                            <h4>
                                                <asp:Label ID="RequiredGroupTitleLabel" runat="server" Text='<%# GetRequiredGroupName(Eval("RequiredGroupID")) %>' visible='<%# HideRequiredText(Eval("RequiredGroupID")) %>'></asp:Label></h4>



                                            <div style="clear: both"></div>

                                            <!-- this is required to connect the child grid to the parent -->
                                            <asp:Label ID="lblCurriculumGroupID" runat="server" Text='<%# Eval("CurriculumGroupID")%>' Visible="false" />

                                        </div>


                                        <div class="col-sm-6">
                                            <div class="pull-right">

                                                <!-- show progress and completed count -->
                                                <div id="trophy" runat="server" class="fa-stack fa-lg" visible='<%# HideTrophy(Eval("CurriculumGroupID")) %>'>
                                                    <i class="fa fa-circle fa-stack-2x"></i>
                                                    <i class="fa fa-trophy fa-stack-1x fa-inverse"></i>
                                                </div>
                                                <asp:Label ID="CompletedCountLabel" runat="server" Text='<%# GetRemainingCountByGroup(Eval("CurriculumGroupID")) %>'></asp:Label>


                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">

                                        <!-- child grid Curriculum -->
                                        <asp:Repeater ID="CurriculumGrid" runat="server">
                                            <HeaderTemplate>
                                            </HeaderTemplate>
                                            <ItemTemplate>

                                                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-3">
                                                    <asp:HyperLink ID="btnAction" runat="server" NavigateUrl='<%# Eval("CurriculumID ", "/application/course/curriculum?ID={0}&p=1") %>' Enabled='<%# Eval("RequiredGroupCompleted")%>'>
                                                        <div class="dataGroup">
                                                            <div class='<%# getBackground(Eval("CurriculumID"), Eval("RequiredGroupCompleted"))%>'>
                                                                <div class="category">
                                                                    <span class="bold_text"><i class='<%# getIcon(Eval("CurriculumID"))%>'></i>
                                                                        <br />
                                                                        <%#Eval("CurriculumTitle")%></span>
                                                                    <p class="tight"><%# Eval("Text")%></p>
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# getTestResult(Eval("CurriculumID"))%>'></asp:Label>
                                                                    <asp:Label ID="Label2" runat="server" Text='<%# GetCurriculumStatus(Eval("CurriculumID"))%>'></asp:Label>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </asp:HyperLink>
                                                </div>


                                            </ItemTemplate>

                                            <FooterTemplate>
                                            </FooterTemplate>

                                        </asp:Repeater>


                                    </div>
                                </ItemTemplate>

                                <EmptyDataTemplate>
                                    <div class="alert alert-warning" role="alert">There are no courses available.  Please check back again.</div>
                                </EmptyDataTemplate>
                                
                            </telerik:RadListView>
                        </div>
                    </div>

                    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="EventManagerApplication.LMSDataClassesDataContext" EntityTypeName="" TableName="Curriculums" Where="CourseID == @CourseID &amp;&amp; Required == @Required" OrderBy="SortOrder">
                        <WhereParameters>
                            <asp:QueryStringParameter Name="CourseID" QueryStringField="CourseID" Type="String" />
                            <asp:Parameter DefaultValue="True" Name="Required" Type="Boolean" />
                        </WhereParameters>
                    </asp:LinqDataSource>
                </div>

                <div class="col-md-3 col-sidebar-right">

                    <h2>Event Guidlines</h2>

                    <ul class="icons-list">
                        <telerik:RadListView ID="LibraryFileList" runat="server">
                            <ItemTemplate>
                                <li><i class="icon-li fa fa-file-pdf-o"></i>
                                    <a href='/FileHandler.aspx?ID=<%# Eval("ID")%>'><%# Eval("FileName")%></a>
                                    <asp:LinkButton ID="btnDeleteFile" runat="server" CommandName="DeleteFile" CommandArgument='<%# Eval("FileID")%>' CssClass="pull-right" Visible="false"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                </li>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                There are no documents for this school.
                            </EmptyDataTemplate>
                        </telerik:RadListView>
                    </ul>
                    <hr />
                    <div class="feed-subject">
                        <h2>Links</h2>
                        <ul class="icons-list">

                            <telerik:RadListView ID="CourseLinksList" runat="server">
                                <ItemTemplate>
                                    <li><i class="icon-li fa fa-external-link"></i>
                                        <a target="_blank" href='http://<%# Eval("LinkURL")%>'><%# Eval("LinkTitle")%></a>
                                        <asp:LinkButton ID="btnDeleteLink" Visible="false" runat="server" CommandName="DeleteLink" CommandArgument='<%# Eval("LinkID")%>' CssClass="pull-right"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                    </li>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    There are no links for this school.
                                </EmptyDataTemplate>
                            </telerik:RadListView>
                        </ul>
                    </div>
                    <hr />
                    <h2>Video/Media</h2>


                    <br />

                    <%--  <div class="widget stacked">
                    <div class="widget-content">
                    <asp:Literal ID="CourseDescriptionLabel" runat="server"></asp:Literal>
                        </div>
                        </div>--%>
                    <%-- <uc3:MyAssignmentsControl ID="MyAssignmentsControl1" runat="server" />

                    <uc4:ClassAnnouncementsControl ID="ClassAnnouncementsControl1" runat="server" />--%>
                </div>

            </div>


        </div>

    </div>



    <script type="text/javascript">
        $('#lessonplan').addClass('active');
    </script>
</asp:Content>
