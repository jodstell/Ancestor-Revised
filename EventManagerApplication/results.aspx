<%@ Page Title="Test Results" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="results.aspx.vb" Inherits="EventManagerApplication.results" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        window.history.forward(); function noBack() { window.history.forward(); }

    </script>

    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

        <link href="css/pages/dashboard.css" rel="stylesheet" />

        <asp:HiddenField ID="HF_SessionID" runat="server" />
        <asp:HiddenField ID="HF_QuizID" runat="server" />
        <asp:HiddenField ID="HF_Question" runat="server" />
        <asp:HiddenField ID="HF_UserName" runat="server" />
        <asp:HiddenField ID="HF_SiteID" runat="server" />

        <div class="container" style="min-height: 580px">

            <div class="row">
                <div class="col-md-12">
                    <h1>
                        <asp:Label ID="QuizTitle" runat="server" Font-Bold="True" Text="Label"></asp:Label></h1>
                </div>
            </div>

            <div class="row">

                <div class="col-md-7">

                    <div class="widget stacked">
                        <div class="widget-content">

                            <div class="stat stat-chart">
                                <asp:Literal ID="ResultsLabel" runat="server" />
                            </div>
                            <br />

                            <p>
                                <asp:Label ID="StatusLabel" runat="server" />

                                <asp:Label ID="errorLabel" runat="server" CssClass="errormessage" />
                            </p>

                            <p>
                                <asp:Label ID="RetakeLabel" runat="server" Visible="false" />
                            </p>


                            <asp:Button ID="BtnContinue" runat="server" Text="Continue >>" CssClass="btn btn-lg btn-primary pull-right" />



                        </div>
                    </div>

                    <div class="widget stacked">
                        <div class="widget-content">
                            <h3>Results</h3>
                            <asp:Repeater ID="TestHistoryGrid" runat="server">

                                <HeaderTemplate>
                                    <table class="table table-striped ">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Question</th>
                                                <th style="width: 120px;">Result</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <th><%# Eval("QuestionID")%></th>
                                        <td><%# Eval("Title")%></td>
                                        <td style="text-wrap: none"><%# Eval("FormatedResult")%></td>

                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <tr>
                                        <td colspan="6">
                                            <asp:Label ID="lblEmptyData"
                                                Text='<%# Common.ShowAlertNoClose("warning", "There are no test results to display.")%>' runat="server" Visible="false">
                                            </asp:Label>
                                        </td>
                                    </tr>

                                    </tbody>
                                                        </table>
                                </FooterTemplate>

                            </asp:Repeater>
                        </div>
                    </div>

                </div>

                <div class="col-md-5 col-xs-12">
                    <div class="widget stacked">
                        <div class="widget-content">

                            <div class="stats">

                                <div class="stat">
                                    <span class="stat-value">
                                        <asp:Label ID="NumberQuestions" runat="server" /></span>
                                    Total Questions
                                </div>
                                <!-- /stat -->

                                <div class="stat">
                                    <span class="stat-value">
                                        <asp:Label ID="NumberCorrect" runat="server" /></span>
                                    Correct Answers
                                </div>
                                <!-- /stat -->

                                <div class="stat">
                                    <span class="stat-value">
                                        <asp:Label ID="Grade" runat="server" /></span>
                                    Grade Required to Pass
                                </div>
                                <!-- /stat -->



                            </div>
                            <!-- /stats -->

                            <div id="chart-stats" class="stats">



                                <div class="stat">

                                    <span class="stat-value">
                                        <asp:Label ID="PointsAvailableText" runat="server" /></span>
                                    Available Points
                                </div>
                                <!-- /stat -->

                                <div class="stat">
                                    <span class="stat-value">
                                        <asp:Label ID="PointsEarnedText" runat="server" /></span>
                                    Earned Points
                                </div>
                                <!-- /stat -->


                                <!-- /substat -->

                                <div class="stat stat-time">

                                    <span class="stat-value">
                                        <asp:Label ID="ElapTime" runat="server" /></span>
                                    Total Time on Test
                                </div>
                                <!-- /substat -->

                            </div>
                            <!-- /substats -->


                        </div>
                    </div>
                </div>


            </div>





            <asp:Panel ID="ResultsPanel" runat="server" Visible="false">

                <div class="row">
                    <div class="col-md-12">
                        <div class="widget stacked">
                            <div class="widget-content">

                                <h3>Question Details</h3>
                                <div class="col-md-6">








                                    <asp:GridView ID="resultGrid" runat="server" DataKeyNames="QuestionID" SelectedIndex="0" CssClass="table table-bordered"
                                        AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateSelectButton="True" Width="555px">

                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" CssClass="generaltext" HorizontalAlign="Center" />
                                        <Columns>

                                            <asp:BoundField DataField="Title" HeaderText="Question" />
                                            <asp:BoundField DataField="FormatedResult" HeaderText="Result" />
                                        </Columns>
                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="boldtext" />
                                        <EditRowStyle BackColor="#999999" />
                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    </asp:GridView>
                                </div>

                                <div class="col-md-6">
                                    <asp:DetailsView ID="answerDetails" runat="server" CellPadding="4" ForeColor="#333333"
                                        GridLines="None" Height="45px" Width="552px" DataSourceID="GetAnswerList" AutoGenerateRows="False">
                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" CssClass="generaltext" />
                                        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" CssClass="boldtext" Width="100px" />
                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#999999" />
                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                        <Fields>
                                            <asp:BoundField DataField="QuestionOrder" HeaderText="Question No.:" />

                                            <asp:TemplateField HeaderText="Question:">
                                                <ItemTemplate>
                                                    <%# Eval("Title").ToString() %>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="Answer1" HeaderText="Answer 1:" />
                                            <asp:BoundField DataField="Answer2" HeaderText="Answer 2:" />
                                            <asp:BoundField DataField="Answer3" HeaderText="Answer 3:" />
                                            <asp:BoundField DataField="Answer4" HeaderText="Answer 4:" />
                                            <asp:TemplateField></asp:TemplateField>
                                            <asp:BoundField DataField="CorrectAnswer" HeaderText="Correct Answer:" />
                                            <asp:BoundField DataField="AnswerExplanation" HeaderText="Explanation:" />
                                        </Fields>
                                    </asp:DetailsView>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </asp:Panel>

        </div>

        <asp:SqlDataSource ID="GetAnswerList" runat="server" ConnectionString="<%$ ConnectionStrings:LMSConnection %>"
            SelectCommand="SELECT [Title], [Answer1], [Answer2], [Answer3], [QuestionID], [QuestionOrder], [Answer4], [CorrectAnswer], [AnswerExplanation], [QuizID] FROM [Questions] WHERE ([QuizID] = @QuizID) ORDER BY [QuestionOrder]">
            <SelectParameters>
                <asp:ControlParameter Name="QuizID" ControlID="HF_QuizID" />
            </SelectParameters>
        </asp:SqlDataSource>



        <asp:GridView ID="GridView1" runat="server" DataKeyNames="QuestionID" SelectedIndex="0"
            AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None"
            AutoGenerateSelectButton="True" Width="555px"
            DataSourceID="al2" Visible="false">
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="QuestionID" HeaderText="Question" />
                <asp:BoundField DataField="CorrectAnswer" HeaderText="Correct Answer" />
                <asp:BoundField DataField="UserAnswer" HeaderText="Your Answer" />
                <asp:BoundField DataField="Result" HeaderText="Result" />
            </Columns>
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" CssClass="generaltext" HorizontalAlign="Center" />
            <EditRowStyle BackColor="#999999" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="boldtext" />
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        </asp:GridView>




        <asp:SqlDataSource ID="getSiteInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LMSConnection %>" SelectCommand="SELECT SiteID, HostName, CompanyName, SiteDescription, SiteName, SiteManager, Location, ContactEmailAddress FROM Site WHERE (SiteID = @SiteID)">
            <SelectParameters>
                <asp:ControlParameter Name="QuizID" ControlID="HF_QuizID" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="getUserInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LMSConnection %>" SelectCommand="SELECT ApplicantID, dbGUID, FirstName, LastName, ISNULL(Phone, '') AS Phone, ISNULL(EmailAddress, '') AS EmailAddress, Address, ISNULL(City, '') AS City, ISNULL(State, '') AS State, ISNULL(Zip, '') AS Zip, ISNULL(CellPhone, '') AS CellPhone, ISNULL(DOB, '') AS DOB, db1, SSN FROM Applicants WHERE (dbGUID = @GUID)">
            <SelectParameters>
                <asp:ControlParameter Name="GUID" ControlID="HF_UserName" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="al2" runat="server" ConnectionString="<%$ ConnectionStrings:LMSConnection %>"
            SelectCommand="SELECT QuizID, QuestionID, CorrectAnswer, UserAnswer, CASE WHEN CorrectAnswer = UserAnswer THEN 'Correct' ELSE 'Incorrect' END AS Result FROM AnswerList WHERE (TestSessionID = @TestSessionID)">
            <SelectParameters>
                <asp:ControlParameter Name="TestSessionID" ControlID="HF_SessionID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:TextBox ID="HiddenUserName" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="HiddenGUID" runat="server" Visible="False"></asp:TextBox><br />

    </telerik:RadAjaxPanel>

    <script type="text/javascript">
        $('img').each(function () {
            $(this).addClass('img-responsive');
        })
    </script>

</asp:Content>
