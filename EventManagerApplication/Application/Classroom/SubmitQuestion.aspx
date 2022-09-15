<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="SubmitQuestion.aspx.vb" Inherits="EventManagerApplication.SubmitQuestion" %>

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


            <div class="form-horizontal">

                  
                        <h3>Send Message</h3>

                <br />


                        <div class="form-group">
                            <label class="col-sm-2 control-label">Message to </label>
                            <div class="col-sm-6">
                            <asp:TextBox ID="txtTo" runat="server" CssClass="form-control" ReadOnly />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">Subject </label>
                            <div class="col-md-10">
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" Required Width="100%" />
                           
                            </div>
                        </div>

                        <div class="form-group">
                        
                            <label class="col-sm-2 control-label">Message</label>
                            <div class="col-md-10">
                            <telerik:RadEditor ID="txtMessage" runat="server" ToolsFile="BasicTools.xml" RenderMode="Lightweight" Width="100%" ImageManager-EnableAsyncUpload="true"
                              ContentAreaCssFile="~/Theme/css/bootstrap.min.css" 
                              DialogHandlerUrl="~/Telerik.Web.UI.DialogHandler.axd" IsSkinTouch="true" NewLineMode="P" EditModes="Design" >
                            </telerik:RadEditor>

                            </div>
                       </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label"></label>
                        <div class="col-md-10">
                           
                            <asp:Button ID="BtnSendMessage" runat="server" Text="Send Message" CssClass="btn btn-primary" />
                            <asp:Button ID="BtnCancelMessage" runat="server" Text="Cancel" CssClass="btn btn-default" />
                        </div>

                    </div>

                        <div class="col-md-9">
                            <asp:Label ID="msgLabel" runat="server" />
                        </div>
                    </div>




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
        $('#summary').addClass('active');
    </script>
</asp:Content>
