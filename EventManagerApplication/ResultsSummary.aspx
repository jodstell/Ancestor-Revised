<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ResultsSummary.aspx.vb" Inherits="EventManagerApplication.ResultsSummary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

      <div class="container">

        <div class="row">

            <div class="col-md-12">

                <h1>Test:
                    <asp:Label ID="TestTitleLabel" runat="server" /></h1>

                <div class="widget stacked">

                    <div class="widget-header">
                        <i class="icon-th-large"></i>
                        <h3>Test Summary</h3>

                    </div>
                    <!-- /widget-header -->

                    <div class="widget-content">
         
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="getBlankAnswers">
                    <HeaderTemplate>
                        
                        <h3>Warning! You did not anwer the following questions:</h3><br />
                    </HeaderTemplate>
                    <ItemTemplate>
                         Question # 
                         <asp:Label ID="Label2" runat="server" Text='<%# Eval("QuestionID") %>'></asp:Label>: 
                         <asp:Label ID="Label1" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                         <asp:LinkButton ID="LinkButton1" runat="server"></asp:LinkButton>

                         <a href="Questions.aspx?SessionID=<%#Eval("SessionID")%>&Question=<%#Eval("QuestionID")%>">Answer this question</a>
                        <br />
                    </ItemTemplate> 
                    <FooterTemplate>
                    <br />
                        
                    </FooterTemplate>
                    </asp:Repeater>

                        </div>

                   

                    </div>


                </div>
            <div class="col-md-12">
 <asp:Label ID="StatusLabel" runat="server"></asp:Label><br />
                    <asp:Button ID="ScoreTest" runat="server" Text="Score Test" OnClick="ScoreTest_Click" CssClass="btn btn-lg btn-success"  />
                </div>

            </div>
            </div>
    
            
    <asp:SqlDataSource ID="getBlankAnswers" runat="server" ConnectionString="<%$ ConnectionStrings:LMSConnection %>"
                        SelectCommand="SELECT AnswerList.QuestionID, Questions.Title, AnswerList.UserAnswer, AnswerList.TestSessionID AS SessionID, AnswerList.QuizID, TestScores.UserName AS GUID, Applicants.SiteID FROM AnswerList INNER JOIN Questions ON AnswerList.QuestionID = Questions.QuestionOrder AND AnswerList.QuizID = Questions.QuizID INNER JOIN TestScores ON AnswerList.TestSessionID = TestScores.TestSessionID INNER JOIN Applicants ON TestScores.UserName = Applicants.dbGUID WHERE (AnswerList.TestSessionID = @SessionID) AND (AnswerList.UserAnswer = 0)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="SessionID" QueryStringField="SessionID" />
                        </SelectParameters>
                    </asp:SqlDataSource>


         

    <asp:SqlDataSource ID="getTestInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LMSConnection %>"
        SelectCommand="SELECT Test.Title, Test.TimeLimit, TotalQuestions_byQuizID.TotalQuestions FROM Test INNER JOIN TotalQuestions_byQuizID ON Test.QuizID = TotalQuestions_byQuizID.QuizID WHERE (Test.QuizID = @QuizID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="QuizID" QueryStringField="QuizID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
