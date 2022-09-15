<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Master.Master" CodeBehind="Curriculum.aspx.vb" Inherits="EventManagerApplication.Curriculum2" %>



    <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

     <style type="text/css">
          @media (min-width: 200px) and (max-width: 980px) {

               .subnavbar {
            margin-bottom: .5em;
        }

             .nomobile {
                 display: none;
             }

             .mobile {
                 display: inline !important;
                 
             }

             #mobileRow  {
margin-top: 0;
padding-top: 0;
             }
        }


         .main {
            padding: 0 5px 5px 5px;
        }

        .checkedlabel {
            background-color: #E9E9E9;
        }

        .hover {
            background-color: #E9E9E9;
        }

        .img-responsive {
           margin: 0 auto;
        }

       

       
        
#commentpanel {
display: none;
}

#notepanel {
display: none;
}

#working {
    display:none;
}
    </style>


    <script src="/Scripts/jquery-1.10.2.js"></script>
    <link href="../Classroom/styles/curriculum.css" rel="stylesheet" />

     <div class="container min-height" style="margin-top:50px;">

    <h3><%: GetCourseName()%></h3>
    <h5><%: GetCurriculumName() %></h5>

    <div id="mainpanel" class="row">
        <div class="col-md-8">

            <div class="widget stacked">
                <div class="widget-content">

                    <asp:Repeater ID="CurriculumFormView" runat="server">
                        <ItemTemplate>
                              <asp:Panel ID="ContentType1" runat="server" Visible='<%# GetContentType(Eval("CurriculumListID"), "1")%>'>
                                  
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
                                                <div class="col-sm-10"><%# getDueDate(Eval("AssignmentID"))%></div>
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

<div id="mobileRow" class="row mobile" style="display:none;">
                    <div class="btn-group" role="group" aria-label="..." style="width:100%">
  
<asp:Button ID="Button3" runat="server" OnClick="btnCancel_Click" OnClientClick="javascript:if(!confirm('This action will cancel the lesson and will return to lesson plan. Are you sure?')){return false;}" Text="Quit" CssClass="btn btn-sm btn-default" width="24%" />
<asp:LinkButton ID="buttonPrev4" runat="server" OnClick="buttonPrev_Click" CssClass="btn btn-sm btn-primary" width="38%"><i class="fa fa-chevron-left" aria-hidden="true"></i>  Previous Page</asp:LinkButton>
<asp:LinkButton ID="buttonNext2" runat="server" OnClick="buttonNext_Click"  CssClass="btn btn-sm btn-success" width="38%">Next Page  <i class="fa fa-chevron-right" aria-hidden="true"></i></asp:LinkButton>
</div>
                    
                    
                        
                    </div>      

                        <p><b><strong>Page #
                         <asp:Label ID="PageNumberLabel" runat="server" />
                         of
                         <asp:Label ID="TotalPagesLabel" runat="server" /></strong>
                        </b></p>

                    <div class="progress">
                        <div class="progress-bar" role="progressbar" aria-valuenow='<%: CurrentPageNumber()%>' aria-valuemin="0" aria-valuemax="100" style='<%: CurrentTotalNumber() %>'>
                            <span class="sr-only"><%: CurrentTotalNumber() %> Complete (success)</span>
                        </div>
                    </div>                      
                   
                
                </div>
            </div>


        </div>

        <div class="col-md-4 nomobile">
            <div class="widget stacked">
                <div class="widget-content">

                    <asp:Panel ID="AnswerPanel1" runat="server" >

                        <h4>Select answer</h4>

                        <br />

                        
                        <div style="font-size: 1.1em">
                            
                                                    <asp:Panel ID="RadioPanel" runat="server">
                                                        <div class="checkbox">
                                                            <label>
                                                                <asp:RadioButton ID="Anwser1" GroupName="q1" runat="server"  />
                                                            </label>
                                                        </div>


                                                        <div class="checkbox">
                                                            <label>
                                                                <asp:RadioButton ID="Anwser2" GroupName="q1" runat="server" />
                                                            </label>
                                                        </div>

                                                        <div class="checkbox">
                                                            <label>
                                                                <asp:RadioButton ID="Anwser3" GroupName="q1" runat="server" />
                                                            </label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label>
                                                                <asp:RadioButton ID="Anwser4" GroupName="q1" runat="server"  />
                                                            </label>
                                                        </div>
                                                        </asp:Panel>
                                                    
                                                        <br />
                                                        
                                                        <asp:Label ID="ResultLabel" runat="server" />

                                                        <br />
                                                        <asp:Button ID="btnFindAnswer" runat="server" Text="Submit" CssClass="btn btn-lg btn-primary btn-block" />
                                                        <asp:Button ID="btnContinue" runat="server" Text="Next Page >>" CssClass="btn btn-lg btn-primary btn-block" Visible="false" />
                                                        
                            
                        <asp:Button ID="btnCancel2" runat="server" Text="Quit & Return to Lesson Plan" CssClass="btn btn-lg btn-secondary btn-block" />
                    
                            
                                                    </div>
                           
                    </asp:Panel>
                    
                    <asp:Panel ID="AssessmentPanel" runat="server" Visible="false">

                    <h3>Self Assessment</h3>

                    <div class="checkbox">
                        <label>
                            <asp:RadioButton ID="RadioButton1" GroupName="q" runat="server" Text=" I don't get it" />
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <asp:RadioButton ID="RadioButton2" GroupName="q" runat="server" Text=" I think I understand." />
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <asp:RadioButton ID="RadioButton3" GroupName="q" runat="server" Text=" I understand this." />
                        </label>
                    </div>

                    <hr />

                    <div class="col-md-12 col-xs-12 marginbotton10">
                        <a id="btnAddComment" Class="btn btn-info"><i class="fa fa-comment"></i>&nbsp;Submit a Comment</a>

                        <%--<a id="btnAddNote" class="btn btn-info"><i class="fa fa-pencil-square "></i>&nbsp;Create a Note</a>--%>
                    </div>

                    <hr />


                    <div class="col-md-12 marginbotton5">
                        <asp:Button ID="buttonNext" runat="server" OnClick="buttonNext_Click" Text="Next Page >>" CssClass="btn btn-lg btn-primary btn-block" />
                    </div>
                    <%--<div class="clear">&nbsp;</div>--%>
                    <div class="col-md-12 marginbotton5">
                        <asp:Button ID="buttonPrev" runat="server" OnClick="buttonPrev_Click" Text="<< Previous Page" CssClass="btn btn-lg btn-default btn-block" />
                    </div>

                         <%--<div class="clear">&nbsp;</div>--%>
                    <div class="col-md-12">
                        <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Quit & Return to Lesson Plan" CssClass="btn btn-lg btn-secondary btn-block" />
                    </div>

                    <div class="clear">&nbsp;</div>

                        </asp:Panel>

                    <asp:Panel ID="AssignmentPanel" runat="server" Visible="false">

                        <div class="col-md-12 col-xs-12 marginbotton10">
                        <a id="btnAddComment" class="btn btn-info"><i class="fa fa-comment"></i>&nbsp;Submit a Comment</a>

                        <%--<a id="btnAddNote" class="btn btn-info"><i class="fa fa-pencil-square "></i>&nbsp;Create a Note</a>--%>
                    </div>

                    <hr />


                    <div class="col-md-12 marginbotton5">
                        <asp:Button ID="buttonNext3" runat="server" OnClick="buttonNext_Click" Text="Next Page >>" CssClass="btn btn-lg btn-primary btn-block" />
                    </div>
                    <%--<div class="clear">&nbsp;</div>--%>
                    <div class="col-md-12 marginbotton5">
                        <asp:Button ID="buttonPrev3" runat="server" OnClick="buttonPrev_Click" Text="<< Previous Page" CssClass="btn btn-lg btn-default btn-block" />
                    </div>

                         <%--<div class="clear">&nbsp;</div>--%>
                    <div class="col-md-12">
                        <asp:Button ID="btnCancel3" runat="server" OnClick="btnCancel_Click" Text="Quit & Return to Lesson Plan" CssClass="btn btn-lg btn-secondary btn-block" />
                    </div>

                    <div class="clear">&nbsp;</div>

                    </asp:Panel>


                </div>
            </div>
        </div>
        

    </div>

    <div id="commentpanel">
        <div class="col-md-12">
            <strong>Add your comment</strong>
            <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="8" Width="100%" CssClass="form-control"></asp:TextBox><br />
            <a href="#" id="btnCloseComment" class="btn btn-info">Save Comment & Close</a><br />
            Your comment will be sent to the instructor.
        </div>
    </div>

    <div id="notepanel">
        <div class="col-md-12">
            <strong>Add your note</strong>
            <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" Rows="8" Width="100%" CssClass="form-control"></asp:TextBox><br />
            <a href="#" id="btnCloseNote" class="btn btn-info">Save Note & Close</a><br />
            Your note will be saved to your notes folder.
        </div>
    </div>

    <div id="working">
        <i class="fa fa-circle-o-notch fa-spin"></i> Working on it...
    </div>

    <script src="/Scripts/jquery-1.10.2.js"></script>

    <link href="/skins/square/blue.css" rel="stylesheet" />
    <script src="/js/icheck.js"></script>

    <script>

        $("#btnCloseComment").click(function () {
            $("#commentpanel").hide();
            $("#working").show();
            $("#working").delay(1200).hide("fast", function() {
                $("#mainpanel").show();
            });
        });

        $("#btnAddComment").click(function () {
            $("#mainpanel").hide();
            $("#commentpanel").show();
        });

        $("#btnCloseNote").click(function () {
            $("#notepanel").hide();
            $("#working").show();
            $("#working").delay(1200).hide("fast", function () {
                $("#mainpanel").show();
            });
        });

        $("#btnAddNote").click(function () {
            $("#mainpanel").hide();
            $("#notepanel").show();
        });

        $(document).ready(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '30%' // optional

            });
        });
    </script>

    <script type="text/javascript">
        $('img').each(function () {
            $(this).addClass('img-reponsive');
        })
    </script>

         </div>

</asp:Content>
