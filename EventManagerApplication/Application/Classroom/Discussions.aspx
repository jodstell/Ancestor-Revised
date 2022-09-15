<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Discussions.aspx.vb" Inherits="EventManagerApplication.Discussions" %>

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
            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
             <h2 class="hidden-xs"><%: GetWidgetName()%></h2>
             <p><%: GetWidgetDescription()%></p>
            <hr />
            </telerik:RadScriptBlock>

            <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server">
                <asp:Panel ID="DiscussionsPanel" runat="server">
                   
                  <%--  <asp:LinkButton ID="btnAddNewTopic" runat="server" CssClass="btn btn-primary"><i class="fa fa-plus-square"></i>&nbsp;Add New Topic</asp:LinkButton>
                    <hr />--%>

                    <div class="portlet">

                        <div class="portlet-header">

                            <h3>
                                <i class="glyphicon glyphicon-comment"></i>
                                Discussion Topics
                            </h3>

                        </div>
                        <!-- /.portlet-header -->

                        <div class="portlet-content">


                            <%--<div class="row">--%>
                            <table class="table table-responsive">
                                <thead>
                                    <tr>
                                        <th>Discussion</th>
                                        <th>Started by</th>
                                        <th>Replies</th>
                                        <th>Last Posts</th>
                                    </tr>
                                </thead>
                                <telerik:RadListView ID="TopicList" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btnViewTopic" CommandName="ViewTopic" CommandArgument='<%# Eval("TopicID") %>' runat="server"><i class="glyphicon glyphicon-comment"></i>&nbsp;<%# Eval("Title") %></asp:LinkButton>
                                            </td>
                                            <td>
                                                <i class="fa fa-user"></i>&nbsp<%# getUserFullName(Eval("CreatedBy")) %>
                                            </td>
                                            <td><%# getRelpiesCount(Eval("TopicID")) %></td>
                                            <td><%# getLastPost(Eval("TopicID")) %><br />
                                                <%# getLastPostDate(Eval("TopicID"))%></td>
                                        </tr>
                                    </ItemTemplate>
                                </telerik:RadListView>



                                <tbody>
                            </table>
                            <%--</div>--%>
                        </div>
                    </div>
                    <br />
                </asp:Panel>
                <asp:Panel ID="AddTopicPanel" runat="server" Visible="false">
                </asp:Panel>

                <asp:Panel ID="ViewTopicPanel" runat="server" Visible="false">
                    <h2>
                        <asp:Label ID="lblTopicTitle" runat="server" /></h2>
                    <hr />
                    <asp:LinkButton ID="btnViewAllTopics" runat="server" CssClass="btn btn-primary">View All Topics</asp:LinkButton>
                    <hr />

                    <div class="portlet">

                        <div class="portlet-content">
                            <p>
                                <i class="fa fa-user"></i>&nbsp<asp:Label ID="lblTopicAuthor" runat="server" /><br />
                                <asp:Label ID="lblDate" runat="server" />
                            </p>
                            <p>
                                <asp:Label ID="lblTopicBody" runat="server" /></p>

                            <br />
                            <asp:LinkButton ID="btnReplytoTopic" runat="server" CssClass="btn btn-secondary pull-right">Reply</asp:LinkButton>

                        </div>
                    </div>

                    <telerik:RadListView ID="TopicThreadList" runat="server" ItemPlaceholderID="defaultHolder">
                        <LayoutTemplate>
                            <asp:PlaceHolder ID="defaultHolder" runat="server"></asp:PlaceHolder>
                        </LayoutTemplate>
                        <InsertItemTemplate>

                            <p>This is the insert template</p>

                            <asp:LinkButton ID="btnCancel1" runat="server" CommandName="Cancel" CssClass="btn btn-secondary pull-right">Cancel</asp:LinkButton>

                        </InsertItemTemplate>
                        <ItemTemplate>
                            <div class="portlet" style="margin-left: 30px;">
                                <div class="portlet-content">

                                    <p>
                                        <%# buildUserLink(Eval("CreatedBy")) %><br />
                                        <%# GetTimeAdjustment(Eval("CreatedDate"))%>
                                    </p>
                                    <div><%# Eval("BodyText") %></div>

                                    <asp:Label ID="lblThreadID" runat="server" Text='<%# Eval("ThreadID") %>' Visible="false" />
                                    <asp:LinkButton ID="btnReplytoThread" CommandName="ReplytoThread" runat="server" CssClass="btn btn-secondary pull-right">Reply</asp:LinkButton>
                                    <br />
                                    <br />

                                    <telerik:RadListView ID="ThreadList" runat="server" DataKeyNames="ThreadID"
                                        ItemPlaceholderID="nestedHolder">
                                        <LayoutTemplate>
                                            <asp:PlaceHolder ID="nestedHolder" runat="server"></asp:PlaceHolder>
                                        </LayoutTemplate>

                                        <ItemTemplate>
                                            <div class="portlet" style="margin-left: 30px; margin-top: 15px;">
                                                <div class="portlet-content">
                                                    <p>
                                                        <%# buildUserLink(Eval("CreatedBy"))%><br />
                                                        <%# GetTimeAdjustment(Eval("CreatedDate")) %>
                                                    </p>
                                                    <div><%# Eval("BodyText") %></div>
                                                </div>
                                            </div>
                                        </ItemTemplate>

                                    </telerik:RadListView>



                                </div>
                            </div>
                        </ItemTemplate>
                    </telerik:RadListView>

                </asp:Panel>

                <asp:Panel ID="TopicReplyPanel" runat="server" Visible="False">
                    <h2>Create Reply</h2>
                    <hr />
                    <asp:LinkButton ID="btnSaveTopicReply" runat="server" CssClass="btn btn-primary">Save Reply</asp:LinkButton>
                    
                    add cancel button
                    <hr />

                   <telerik:RadEditor ID="RadEditorInstructions" runat="server" Width="100%" DialogHandlerUrl="~/Telerik.Web.UI.DialogHandler.axd"
                                                ToolsFile="DiscussionTools.xml" ContentAreaCssFile="/StyleSheet.css" IsSkinTouch="true" NewLineMode="P" RenderMode="Mobile"
                                                ImageManager-EnableAsyncUpload="true">
                                            </telerik:RadEditor>

                </asp:Panel>

            </telerik:RadAjaxPanel>
        </div>

        <div class="col-md-3 col-sidebar-right">

            <uc1:ClassAnnouncementsControl runat="server" ID="ClassAnnouncementsControl" />
            <uc1:MyAssignmentsControl runat="server" ID="MyAssignmentsControl" />
        </div>



    </div>

        </div>

    <script type="text/javascript">
        $('#nav_5').addClass('active');
    </script>

    <script type="text/javascript">
        $('#discussions').addClass('active');
    </script>

</asp:Content>
