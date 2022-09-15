<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Dropbox.aspx.vb" Inherits="EventManagerApplication.Dropbox" %>

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
            <asp:LinkButton ID="btnUploadFile" runat="server" CssClass="btn btn-secondary"><i class="fa fa-cloud-upload"></i>&nbsp;Upload Document</asp:LinkButton>
            <hr />


            <h3>Assignment Documents</h3>

                    <asp:Repeater ID="MyAssignmentUploads" runat="server">
                        <HeaderTemplate>
                             <table class="table table-responsive">
                                <thead>
                                    <tr>
                                        <th>File Name</th>
                                        <th>Assignment Name</th>
                                        <th>Date Submitted</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td nowrap><i class="icon-li fa fa-file-text-o"></i><a href='FileHandler.aspx?ID=<%# Eval("ID")%>'>&nbsp;<%# Eval("FileName") %></a></td>
                                <td><%# Eval("Title") %></td>
                                <td><%# String.Format("{0:D}", Eval("DateUploaded"))%></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>

                            </table>
                        </FooterTemplate>
                    
                   

                        </asp:Repeater>
            





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
        $('#dropbox').addClass('active');
    </script>

        </div>
</asp:Content>
