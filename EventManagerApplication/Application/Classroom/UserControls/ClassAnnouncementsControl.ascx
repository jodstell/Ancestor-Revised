<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ClassAnnouncementsControl.ascx.vb" Inherits="EventManagerApplication.ClassAnnouncementsControl" %>

<link href="/theme/js/plugins/msgbox/jquery.msgbox.css" rel="stylesheet" />

<script type="text/javascript">
    //<![CDATA[
    function openRadWin(id) {
        radopen("announcementdetails.aspx?id=" + id, "RadWindow1");
    }
    //]]>                                                                        
</script>

<div class="well">
    <h4>Course Announcements</h4>

    <asp:Repeater ID="AnnouncementsList" runat="server">
        <HeaderTemplate>
            <ul class="icons-list text-md">
        </HeaderTemplate>
        <ItemTemplate>
            <li><i class='icon-li fa fa-newspaper-o'></i>
                <strong><a href="#" onclick="openRadWin('<%# Eval("AnnouncementID")%>'); return false;"><%# Eval("Title")%></a>
                </strong>
                <br />
            </li>
        </ItemTemplate>
        <FooterTemplate>
            </ul>

            <asp:Label ID="lblEmptyData"
              Text="There are no announcements." runat="server" Visible="false">
            </asp:Label>

        </FooterTemplate>
    </asp:Repeater>

    
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"
        EnableShadow="true" Behaviors="Close,Move, Resize" VisibleStatusbar="false" >
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server" Title="New Alert" Height="425px"
                Width="575px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false"
                Modal="true"  />
        </Windows>
    </telerik:RadWindowManager>

    </div>