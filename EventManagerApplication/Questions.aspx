<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" MaintainScrollPositionOnPostback="true" CodeBehind="Questions.aspx.vb" Inherits="EventManagerApplication.Questions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .main {
            padding: 15px;
        }

        @media (min-width: 200px) and (max-width: 980px) {

            .subnavbar {
                margin-bottom: .5em;
            }

            h3 {
                margin-top: 3px;
            }

            h1 {
                font-size: 24px;
            }

            .mobileBox {
                min-height: 5px !important;
            }
        }

        .mobileBox {
            min-height: 425px;
        }
    </style>

    <script type="text/javascript">
        window.history.forward(); function noBack() { window.history.forward(); }

    </script>

    <style type="text/css">
        .checkedlabel {
            background-color: #E9E9E9;
        }

        .hover {
            background-color: #E9E9E9;
        }
    </style>

    <link href="/css/timeTo.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.10.2.js"></script>

    <asp:HiddenField ID="HF_SessionID" runat="server" />
    <asp:HiddenField ID="HF_QuizID" runat="server" />
    <asp:HiddenField ID="HF_Question" runat="server" />
    <asp:HiddenField ID="HF_UserName" runat="server" />
    <asp:HiddenField ID="HF_SiteID" runat="server" />
    <asp:HiddenField ID="HF_Points" runat="server" />


    <%-- <asp:Timer ID="Timer1" runat="server" Interval="1000" />--%>
    <%--  <asp:HiddenField ID="hid_Ticker" runat="server" Value="0" />--%>


    <%-- <asp:Panel ID="Panel2" runat="server">

</asp:Panel>--%>



    <div class="container main">

        <div class="row">
            <div class="col-md-12">
                <div class="pull-right">
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

                            <div class="progress">
                               <div class="progress-bar" role="progressbar" aria-valuenow='<%: CurrentQuestionNumber()%>' aria-valuemin="0" aria-valuemax="100" style='<%: CurrentTotalNumber() %>'>
                            <span class="sr-only"><%: CurrentTotalNumber() %> Complete (success)</span>
                        </div>

                            </div>

                            <div style="font-size: 1.4em">
                                <asp:Label ID="QuestionLabel" runat="server" />
                            </div>

                        </div>
                    </div>




                </div>



                <div class="col-md-5">
                    <div class="widget stacked">
                        <div class="widget-content">
                            <h4>Select answer</h4>
                            <div style="font-size: 1.1em">

                                <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                                </asp:RadioButtonList>

                                <asp:Panel ID="RadioPanel" runat="server">
                                    <div class="checkbox">
                                        <label>
                                            <asp:RadioButton ID="RadioButton1" GroupName="q" runat="server" />
                                        </label>
                                    </div>


                                    <div class="checkbox">
                                        <label>
                                            <asp:RadioButton ID="RadioButton2" GroupName="q" runat="server" />
                                        </label>
                                    </div>

                                    <div class="checkbox">
                                        <label>
                                            <asp:RadioButton ID="RadioButton3" GroupName="q" runat="server" />
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <asp:RadioButton ID="RadioButton4" GroupName="q" runat="server" />
                                        </label>
                                    </div>

                                    <div class="checkbox">
                                        <label>
                                            <asp:RadioButton ID="RadioButton5" GroupName="q" runat="server" />
                                        </label>
                                    </div>

                                    <div class="checkbox">
                                        <label>
                                            <asp:RadioButton ID="RadioButton6" GroupName="q" runat="server" /><br />
                                        </label>
                                    </div>



                                </asp:Panel>

                                <asp:Panel runat="server" ID="TxtFillPanel" Style="min-height: 150px" Visible="false">

                                    <asp:TextBox ID="TxtFillIn" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>

                                </asp:Panel>

                            </div>

                            <div class="visible-xs">
                            <div class="btn-group" role="group" aria-label="..." style="width:100%">
                              <asp:Button ID="Button3" runat="server" Text="Quit/Exit" CssClass="btn btn-sm btn-default" Width="24%"  OnClientClick="return confirm('Click OK to exit this test.  Your answers will not be saved!');" OnClick="cancel_Click" />
                              <asp:Button ID="Button2" runat="server" Text="<< Previous Question" CssClass="btn btn-sm btn-warning" Width="38%" OnClick="PreviousQuestion_Click" />
                               <asp:Button ID="button1" runat="server" Text="Next Question >>" CssClass="btn btn-sm btn-success " OnClientClick="stopTimer()" Width="38%" OnClick="buttonNext_Click" />
                            </div>
                                </div>

                            <div class="hidden-xs">
                            <div class="col-md-12">
                                <asp:Button ID="buttonNext" runat="server" Text="Next Question >>" CssClass="btn btn-lg btn-success btn-block" OnClientClick="stopTimer()" OnClick="buttonNext_Click" />
                            </div>

                            <div class="clear">&nbsp;</div>
                            <div class="col-md-12">
                                <asp:Button ID="PreviousQuestion" runat="server" Text="<< Previous Question" CssClass="btn btn-med btn-warning btn-block" OnClick="PreviousQuestion_Click" />
                            </div>

                            <div class="clear">&nbsp;</div>

                            <div class="col-md-6">
                                <asp:Button ID="ScoreTest" runat="server" Text="Score Test" CssClass="btn btn-med btn-default btn-block" />
                            </div>
                            <div class="col-md-6">
                                <asp:Button ID="cancel" runat="server" Text="Quit/Exit" CssClass="btn btn-med btn-default btn-block" OnClientClick="return confirm('Click OK to exit this test.  Your answers will not be saved!');" OnClick="cancel_Click" />
                            </div>
                            </div>

                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>



    <script src="/Scripts/jquery-1.10.2.js"></script>

<%--    <link href="/skins/square/blue.css" rel="stylesheet" />
    <script src="/js/icheck.js"></script>--%>

    <link href="skins/square/blue.css" rel="stylesheet" />
    <script src="js/icheck.js"></script>

    <script>
        $(document).ready(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '30%' // optional

            });
        });
    </script>







    <asp:Label ID="LastQuestionLabel" runat="server"></asp:Label>




    <br />





    <asp:TextBox ID="txtTimeRemaining" runat="server" Width="24px" Visible="false"></asp:TextBox>

    <br />
    <asp:Label ID="ErrorLabel" runat="server"></asp:Label><br />





    <asp:HiddenField ID="TxtRemainingSeconds" runat="server" />

    <asp:TextBox ID="HiddenUserAnswer" runat="server" Width="39px" Visible="False"></asp:TextBox>
    <asp:TextBox ID="SavedAnswer" runat="server" Width="33px" Visible="False"></asp:TextBox>
    <asp:TextBox ID="HiddenCorrectAnswer" runat="server" Width="36px" Visible="False"></asp:TextBox>





    <asp:SqlDataSource ID="getPreviousAnswer" runat="server" ConnectionString="<%$ ConnectionStrings:LMSConnection %>"
        SelectCommand="SELECT COALESCE (UserAnswer, 0) AS Expr1 FROM AnswerList WHERE (TestSessionID = @TestSessionID) AND (QuizID = @QuizID) AND (QuestionID = @QuestionID)">
        <SelectParameters>
            <asp:Parameter Name="TestSessionID" />
            <asp:Parameter Name="QuizID" />
            <asp:Parameter Name="QuestionID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="getQuestionDetails" runat="server" ConnectionString="<%$ ConnectionStrings:LMSConnection %>"
        SelectCommand="SELECT QuestionID, QuestionOrder, Title, Answer1, Answer2, Answer3, Answer4, Answer5, Answer5 AS Expr1, CorrectAnswer FROM Questions WHERE (QuizID = @QuizID) AND (QuestionOrder = @Question) ORDER BY QuestionOrder">
        <SelectParameters>

            <asp:ControlParameter DefaultValue="0" Name="QuizID" ControlID="HF_QuizID"
                Type="Int32" />
            <asp:ControlParameter DefaultValue="" Name="Question" ControlID="HF_Question" />
        </SelectParameters>
    </asp:SqlDataSource>





    <style type='text/css'>
        .hid {
            display: none;
        }
    </style>





    <script type="text/javascript">
        $('img').each(function () {
            $(this).addClass('img-responsive');
        })
    </script>


    <script type="text/javascript">
        $('#SubNavPanel11').addClass('hid');
    </script>

</asp:Content>
