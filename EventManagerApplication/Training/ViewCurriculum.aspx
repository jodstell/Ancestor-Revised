<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewCurriculum.aspx.vb" Inherits="EventManagerApplication.ViewCurriculum" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Training</title>
     <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" /> 

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" />

      <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" />

    
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet" />
    <link href="/theme/css/font-awesome.min.css" rel="stylesheet" />        
    
    <link href="/theme/css/ui-lightness/jquery-ui-1.10.0.custom.min.css" rel="stylesheet" />
    
    <link href="/theme/css/base-admin-3.css" rel="stylesheet" />
    <link href="/theme/css/base-admin-3-responsive.css" rel="stylesheet" />
    
    <link href="/theme/css/pages/dashboard.css" rel="stylesheet" />   

    <link href="/theme/css/custom.css" rel="stylesheet" />

</head>
<body style="margin:10px 10px 15px 0">
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

<%--        <div class="modal-header">        
        <h4 class="modal-title">View Curriculum</h4>
    </div>--%>

        <div class="modal-body">

    <div class="container1">

        <div id="mainpanel1" class="row1">

           <div class="">

            <div class="widget stacked1">
                <div class="widget-content1">

                    <div style="margin-bottom:5px;">

                        

                     <asp:Button ID="btnPrev" runat="server" Text="< Previous" CssClass="btn btn-default pull-left" />
                        <asp:Button ID="btnNext" runat="server" Text="Next >" CssClass="btn btn-primary pull-right" />

                    </div>

                    

                    <div class="clearfix"></div>

                    <div style="margin-top: 10px">

                    <asp:Repeater ID="CurriculumFormView" runat="server">
                        <ItemTemplate>
                              <asp:Panel ID="ContentType1" runat="server" Visible='<%# GetContentType(Eval("CurriculumListID"), "1")%>' >
                                  
                                  <asp:Label ID="TextLabel" runat="server" Text='<%# Eval("Text") %>'  />
                               </asp:Panel>


                             <asp:Panel ID="ContentType2" runat="server" Visible='<%# GetContentType(Eval("CurriculumListID"), "2")%>'>

                                 <telerik:RadMediaPlayer ID="RadMediaPlayer1" runat="server" 
                                                 Height="360px" Width="100%" RenderMode="Auto" 
                                                 BannerCloseButtonToolTip="Close"
                                                 Source='<%# Eval("VideoURL") %>'>
                                                </telerik:RadMediaPlayer>
                                  </asp:Panel>

                            <asp:Panel ID="ContentType3" runat="server" Visible='<%# GetContentType(Eval("CurriculumListID"), "3")%>'>

                                <p><%# Eval("EmbedCode")%></p>

                            </asp:Panel>

                            <asp:Panel ID="ContentType4" runat="server" Visible='<%# GetContentType(Eval("CurriculumListID"), "4")%>'>
                                <div style="min-height: 250px">
                                <h3>Anser the following question:<br /><br /></h3>

                                <h4><asp:Label ID="Label1" runat="server" Text='<%# Eval("Text") %>'  /></h4>

                                      
                                 </div>

                                </asp:Panel>

                            <asp:Panel ID="Panel5" runat="server" Visible='<%# GetContentType(Eval("CurriculumListID"), "5")%>'>
                                                <h3>Assignment</h3>

                                                <div class="portlet">
                                                    <div class="portlet-content">

                                                <div class="form-horizontal" role="form">

                                                <div class="form-group">
                                                <label class="col-md-2">Title</label>
                                                <div class="col-sm-10"><strong><%# Eval("Title")%></strong></div>
                                                </div>

                                                <div class="form-group">
                                                <label class="col-md-2">Date Due</label>
                                                <%--<div class="col-sm-10"><%# getDueDate(Eval("AssignmentID"))%></div>--%>
                                                </div>

                                                <div class="form-group">
                                                <label class="col-md-2">Description</label>
                                                <div class="col-sm-10"><%# Eval("Text")%></div>
                                                </div>

                                                </div>
</div>
                                                    </div>
                                               
                                            </asp:Panel>


                        </ItemTemplate>
                    </asp:Repeater>
                        </div>
                          
                         <h4><strong>Page #
                         <asp:Label ID="PageNumberLabel" runat="server" />
                        of
                        <asp:Label ID="TotalPagesLabel" runat="server" /></strong></h4>

                    <div class="progress">
                        <div class="progress-bar" role="progressbar" aria-valuenow='<%= CurrentPageNumber()%>' aria-valuemin="0" aria-valuemax="100" style='<%= CurrentTotalNumber() %>'>
                            <span class="sr-only"><%= CurrentTotalNumber() %> Complete (success)</span>
                        </div>
                    </div>                      
                   

                </div>
            </div>


        </div>

                   
        

        
        

    </div>
    </div>

            </div>

        <div class="modal-footer">
        <%--<button id="btnClose" type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
            <%--<asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn btn-default" OnClientClick="window.close(); return false;" />--%>
    </div>	
    </form>
</body>
</html>
