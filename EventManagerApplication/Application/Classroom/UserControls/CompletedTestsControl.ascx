<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CompletedTestsControl.ascx.vb" Inherits="EventManagerApplication.CompletedTestsControl" %>

<asp:HiddenField ID="GUID" runat="server" />
<asp:HiddenField ID="SiteID" runat="server" />

<div class="panel panel-success">

                    <div class="panel-heading">
                       
                        <h3 class="panel-title"> <i class="icon-th-list"></i> <asp:Label ID="CompletedTestLabel" runat="server" Text="<%$ Resources:Resource, CompletedTestLabel %>" />  <asp:Label ID="Label1" runat="server"></asp:Label></h3>
                    </div>
                    <!-- /widget-header -->

                    <div class="panel-body">

                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="LinqDataSource1" EmptyDataText="There are no completed tests."
                             CssClass="table table-striped table-bordered">
      <EmptyDataTemplate>
          There are no completed tests.
      </EmptyDataTemplate>
        <Columns>

            <asp:TemplateField HeaderText="">
                <ItemTemplate>
            <a href="/application/tests/testresults?ID=<%# Eval("TestSessionID")%>" class="btn btn-xs btn-primary">
                                            <i class="btn-icon-only icon-ok">
                                                <asp:Label ID="ViewButton" runat="server" Text="<%$ Resources:Resource, ViewButton %>" /></i>
                                        </a>

                    </ItemTemplate>
                </asp:TemplateField>

            <asp:BoundField DataField="Title" HeaderText="Test Name" SortExpression="Title">
                <ItemStyle Font-Bold="true" />
            </asp:BoundField>

           
            <asp:TemplateField HeaderText="Date">
                <ItemTemplate>
                    <%# GetTimeAdjustment(Eval("DateTimeCompleted"))%>
                </ItemTemplate>
            </asp:TemplateField>
          

             <asp:TemplateField HeaderText="Score">
                <ItemTemplate>
                    <span class="label label-success">
                                        <%# Eval("Score", "{0:D}")%>% </span>
                </ItemTemplate>
            </asp:TemplateField>

           <%-- <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%#getPrerequisiteResult(Eval("prerequisite"), Eval("dbGUID"))%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# getPreReqTest(Eval("PreReqResult"), Eval("PreReqTitle")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>
        </Columns>
    </asp:GridView>

                        

                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="EventManagerApplication.LMSDataClassesDataContext" TableName="baretc_TestResults" Where="Result == @Result && UserName == @UserName && CourseID == @CourseID">
                            <WhereParameters>
                                <asp:Parameter DefaultValue="Passed" Name="Result" Type="String"></asp:Parameter>
                                <asp:ControlParameter ControlID="GUID" PropertyName="Value" Name="UserName" Type="String"></asp:ControlParameter>
                                <asp:QueryStringParameter QueryStringField="CourseID" Name="CourseID" Type="String"></asp:QueryStringParameter>
                            </WhereParameters>
                        </asp:LinqDataSource>
                    </div>
                    <!-- /widget-content -->
                </div>

<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MembershipConnection %>"
    SelectCommand="SELECT Test.QuizID, Test.Title, TestScores.Score, TestScores.TestSessionID, TestScores.DateTimeCompleted, Site.PassingGrade, CASE WHEN TestScores.Score &gt;= Site.PassingGrade THEN 'Passed' WHEN TestScores.Score IS NULL THEN 'Take Test' WHEN TestScores.Score &lt; Site.PassingGrade AND GETDATE() &gt;= DATEADD(hh , Site.RetakeTestHrs , TestScores.DateTimeCompleted) THEN 'Retake Test' ELSE 'Retake Test' END AS Result, Test.Enabled, Applicants.dbGUID, TestScores.UserName, Applicants.SiteID FROM (SELECT MAX(UserTestID) AS UserTestID FROM TestScores AS TestScores_1 WHERE (UserName = @UserName) GROUP BY TestID, UserName) AS RecentTestScores INNER JOIN TestScores ON RecentTestScores.UserTestID = TestScores.UserTestID RIGHT OUTER JOIN Applicants INNER JOIN Test ON Applicants.SiteID = Test.SiteID INNER JOIN Site ON Applicants.SiteID = Site.SiteID ON TestScores.UserName = Applicants.dbGUID AND TestScores.TestID = Test.QuizID WHERE (Applicants.dbGUID = @UserName) AND (Applicants.SiteID = @SiteID) AND (Test.Enabled = 1) AND (CASE WHEN TestScores.Score &gt;= Site.PassingGrade THEN 'Passed' WHEN TestScores.Score IS NULL THEN 'Take Test' WHEN TestScores.Score &lt; Site.PassingGrade AND GETDATE() &gt;= DATEADD(hh , Site.RetakeTestHrs , TestScores.DateTimeCompleted) THEN 'Retake Test' ELSE 'Retake Test' END = 'Passed')">
    <SelectParameters>
        <asp:ControlParameter ControlID="GUID" Name="UserName" PropertyName="Value" />
        <asp:ControlParameter ControlID="SiteID" Name="SiteID" PropertyName="Value" />
    </SelectParameters>
</asp:SqlDataSource>
