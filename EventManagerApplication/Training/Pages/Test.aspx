<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Test.aspx.vb" Inherits="EventManagerApplication.Test2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .rbDecorated
{
padding-left: 2px !important;/* this could be increased if you want to have more space between the left button edge and the text  */
text-align: left !important;
white-space:normal;
}
    </style>
   
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>

              <telerik:AjaxSetting AjaxControlID="buttonNext_med">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="buttonNext_med" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>

             <telerik:AjaxSetting AjaxControlID="buttonNext_sm">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="buttonNext_sm" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>

        </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <asp:HiddenField ID="HF_SessionID" runat="server" />
    <asp:HiddenField ID="HF_QuizID" runat="server" />
    <asp:HiddenField ID="HF_Question" runat="server" />
    <asp:HiddenField ID="HF_UserName" runat="server" />
    <asp:HiddenField ID="HF_SiteID" runat="server" />
    <asp:HiddenField ID="HF_Points" runat="server" />

    <asp:Panel ID="Panel1" runat="server">
     <div class="container main">

        <div class="row">
            <div class="col-md-12">
                <div class="pull-right">
                    <asp:Button ID="btnQuit" runat="server" Text="Quit/Exit Test" CssClass="btn btn-med btn-default" />

                    <asp:Literal ID="lit_Timer" runat="server" /><br />
                </div>
                <h1>
                    <asp:Label ID="TestTitleLabel" runat="server" /></h1>

            </div>
        </div>

         <div class="row">

            <div class="widget-content">

                <div class="col-md-7">
                    <div class="widget stacked">
                        <div class="widget-content mobileBox">
                            <h4><strong>Question #
                                                    <asp:Label ID="QuestionNumberLabel" runat="server" />
                                of
                                                    <asp:Label ID="TotalQuestionsLabel" runat="server" /></strong></h4>

                            <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                                <div class="progress">
                                   <div class="progress-bar" role="progressbar" aria-valuenow='<%: CurrentQuestionNumber()%>' aria-valuemin="0" aria-valuemax="100" style='<%: CurrentTotalNumber() %>'>
                                    <span class="sr-only"><%: CurrentTotalNumber() %> Complete (success)</span>
                                 </div>

                                </div>
                            </telerik:RadCodeBlock>


                            <div style="font-size: 1.4em">
                                <asp:Label ID="QuestionLabel" runat="server"  />
                            </div>

                        </div>
                    </div>




                </div>



                <div class="col-md-5">
                    <div class="widget stacked">
                        <div class="widget-content">
                            <h4>
                                <asp:Label ID="SelectLabel" runat="server" /></h4>
                            <div style="font-size: 1.1em; margin-bottom:20px;">

                                <asp:Button ID="BtnAnswer1" runat="server" CssClass="btn btn-lg btn-default btn-block rbDecorated" OnClick="GetResult_Click" />

                                <asp:Button ID="BtnAnswer2" runat="server" CssClass="btn btn-lg btn-default btn-block rbDecorated" OnClick="GetResult_Click" />

                                <asp:Button ID="BtnAnswer3" runat="server" CssClass="btn btn-lg btn-default btn-block rbDecorated" OnClick="GetResult_Click" />

                                <asp:Button ID="BtnAnswer4" runat="server" CssClass="btn btn-lg btn-default btn-block rbDecorated" OnClick="GetResult_Click" />

                                <asp:Button ID="BtnAnswer5" runat="server" CssClass="btn btn-lg btn-default btn-block rbDecorated" OnClick="GetResult_Click" />

                                <asp:Button ID="BtnAnswer6" runat="server" CssClass="btn btn-lg btn-default btn-block rbDecorated" OnClick="GetResult_Click" />

                            </div>

                            <div style="font-size: 1.1em; margin-bottom:20px;">
                                <asp:Label ID="TargetPoints" runat="server" Font-Size="Large" Visible="false" />
                                <asp:Label ID="ResultLabel" runat="server" Font-Size="Large" Visible="false" />
                                <asp:Label ID="PointsLabel" runat="server" Font-Size="Large" Visible="false" />
                                <asp:Label ID="PassedLabel" runat="server" Font-Size="Large" Text="Incorrect" Visible="false" />

                                <asp:Label ID="HiddenUserAnswer" runat="server" Visible="false" />

                            </div>

                            <div class="visible-xs">
                            <div class="btn-group" role="group" aria-label="..." style="width:100%">
                             
                              
                               <asp:Button ID="buttonNext_sm" runat="server" Text="Next Question >>" CssClass="btn btn-sm btn-primary" Visible="true"  Width="38%" OnClick="Next_Click" />



                            </div>
                                </div>

                            <div class="hidden-xs">

                            <div class="col-md-12">
                                <asp:Button ID="buttonNext_med" runat="server" Text="Next Question >>" CssClass="btn btn-lg btn-primary btn-block" Visible="true" OnClick="Next_Click" />
                            </div>

                            <div class="clear">&nbsp;</div>
                           

                            <div class="col-md-6">
                                
                            </div>
                            <div class="col-md-6">
                                
                            </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>

      </div>
     </asp:Panel>
</asp:Content>
