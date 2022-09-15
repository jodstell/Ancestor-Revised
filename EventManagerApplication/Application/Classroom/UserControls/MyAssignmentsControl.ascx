<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="MyAssignmentsControl.ascx.vb" Inherits="EventManagerApplication.MyAssignmentsControl" %>

<asp:Repeater ID="RightNavBar" runat="server">
    <HeaderTemplate>
        <div class="list-group">
    </HeaderTemplate>

    <ItemTemplate>
        <a href="<%# String.Format(Eval("PageURL")).ToLower%>?CourseID=<%: Request.QueryString("CourseID")%>" class="list-group-item">
            <i class='<%# getIcon(Eval("Icon"))%>'></i>
            &nbsp;&nbsp;<strong><%# Eval("Title")%></strong></a>
    </ItemTemplate>

    <FooterTemplate>
        </div>
    </FooterTemplate>
</asp:Repeater>


<asp:Panel ID="QuestionPanel" runat="server" class="hidden-xs">
<div class="cpl-md-12 marginbotton10">
    <asp:LinkButton ID="btnAskQuestion" runat="server" CssClass="btn btn-secondary btn-block"><i class="fa fa-plus-square"></i>&nbsp;<asp:Label ID="Label1" runat="server" Text="<%$ Resources:Resource, AskAQuestionButton %>" /></asp:LinkButton>
</div>
</asp:Panel>

<asp:Panel ID="AssignmentPanel" runat="server">
    <div class="well">
        <h4>Current Assignments</h4>

        <asp:Repeater ID="MyAssignmentList" runat="server">
            <HeaderTemplate>
                <ul class="icons-list text-md">
            </HeaderTemplate>

            <ItemTemplate>

                <li>
                    <i class='icon-li fa fa-cloud-upload'></i>
                    <asp:LinkButton ID="btnViewAssignment" Font-Bold="true" CommandName="ViewAssignment" CommandArgument='<%# Eval("AssignmentID")%>' runat="server"><%# Eval("Title")%></asp:LinkButton>
                    <p>
                        <asp:Label ID="lblDate" runat="server" Text='<%# Eval("DueDate") %>'></asp:Label>
                        <%# String.Format("{0:D}", Eval("DueDate"))%>
                    </p>
                </li>

            </ItemTemplate>
            <FooterTemplate>
                </ul>
                <asp:Label ID="lblEmptyData" runat="server" Text="There are no current assignments" Visible="false" />
            </FooterTemplate>
        </asp:Repeater>



    </div>
</asp:Panel>
