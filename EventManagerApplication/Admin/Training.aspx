<%@ Page Title="Training" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Training.aspx.vb" Inherits="EventManagerApplication.Training1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Theme/css/custom.css" rel="stylesheet" />

         <style>

        .RadGrid_Bootstrap .rgHeader, .RadGrid_Bootstrap th.rgResizeCol, .RadGrid_Bootstrap .rgHeaderWrapper {
            background-color: #3399cc;
        }

        .RadGrid_Bootstrap .rgHeader, .RadGrid_Bootstrap .rgHeader a {
            font-weight: bold;
            color: #fff;
        }

    </style>

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">

        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="CourseGrid">

                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="CourseGrid"></telerik:AjaxUpdatedControl>

                </UpdatedControls>

            </telerik:AjaxSetting>

        </AjaxSettings>

    </telerik:RadAjaxManager>

   <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Training</h2>
                <hr />


                <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" SelectedIndex="0">
                    <Tabs>
                        <telerik:RadTab Text="Courses"></telerik:RadTab>
                        <telerik:RadTab Text="Tests"></telerik:RadTab>
                        <telerik:RadTab Text="Reports"></telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>

                <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0">
                    <telerik:RadPageView ID="RadPageView1" runat="server">

                        <telerik:RadGrid ID="CourseGrid" runat="server" DataSourceID="getCourseList" GroupPanelPosition="Top" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" PageSize="10" CellSpacing="-1" GridLines="none">
                            
                            <PagerStyle Mode="NumericPages"></PagerStyle>

                            <MasterTableView DataSourceID="getCourseList" AutoGenerateColumns="False" DataKeyNames="courseID" EnableHierarchyExpandAll="true" AllowMultiColumnSorting="True" CommandItemDisplay="Top">
                            <CommandItemTemplate>
                                 
                                    <div style="padding: 3px 0 3px 5px">
                                         

                                                            <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export to Excel</asp:LinkButton>
                                                       
                                        </div>
                                 
                                        </CommandItemTemplate>

                                <DetailTables>

                                   <telerik:GridTableView EnableHierarchyExpandAll="true" DataKeyNames="CurriculumGroupID" DataSourceID="getCurriculumGroups" Width="100%"
                                    runat="server">

                                <ParentTableRelation>

                                        <telerik:GridRelationFields DetailKeyField="courseID" MasterKeyField="courseID"></telerik:GridRelationFields>

                                    </ParentTableRelation>

                                       <DetailTables>

                            <telerik:GridTableView EnableHierarchyExpandAll="true" DataKeyNames="CurriculumGroupID" DataSourceID="getCurriculum" Width="100%"

                                runat="server">

                                <ParentTableRelation>

                                    <telerik:GridRelationFields DetailKeyField="CurriculumGroupID" MasterKeyField="CurriculumGroupID"></telerik:GridRelationFields>

                                </ParentTableRelation>

                                <Columns>
                                     <telerik:GridBoundColumn SortExpression="CurriculumTitle" HeaderText="CurriculumTitle" HeaderButtonType="TextButton"
                                            DataField="CurriculumTitle" UniqueName="CurriculumTitle">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn SortExpression="TotalCompleted" HeaderText="Completed" HeaderButtonType="TextButton"
                                            DataField="TotalCompleted" UniqueName="TotalCompleted">
                                        </telerik:GridBoundColumn>


                                    </Columns>

                                </telerik:GridTableView>

                        </DetailTables>


                                    <Columns>
                                        <telerik:GridBoundColumn SortExpression="Title" HeaderText="Brand Name" HeaderButtonType="TextButton"
                                            DataField="Title" UniqueName="Title">
                                        </telerik:GridBoundColumn>
                                        </Columns>

                                <PagerStyle Position="TopAndBottom" />

                                </telerik:GridTableView>
                            </DetailTables>
                                
                                <Columns>

                                    <telerik:GridBoundColumn DataField="CourseCode" ReadOnly="True" HeaderText="CourseCode" SortExpression="CourseCode" UniqueName="CourseCode" FilterControlAltText="Filter CourseCode column"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="CourseTitle" ReadOnly="True" HeaderText="Brand School" SortExpression="CourseTitle" UniqueName="CourseTitle" FilterControlAltText="Filter CourseTitle column"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="GroupName" ReadOnly="True" HeaderText="GroupName" SortExpression="GroupName" UniqueName="GroupName" FilterControlAltText="Filter GroupName column"></telerik:GridBoundColumn>
                                    

                                    <telerik:GridBoundColumn DataField="CourseType" ReadOnly="True" HeaderText="CourseType" SortExpression="CourseType" UniqueName="CourseType" FilterControlAltText="Filter CourseType column"></telerik:GridBoundColumn>
                                    

                                    <telerik:GridBoundColumn DataField="CourseCount" ReadOnly="True" HeaderText="CourseCount" SortExpression="CourseCount" UniqueName="CourseCount" FilterControlAltText="Filter CourseCount column"></telerik:GridBoundColumn>


                                    </Columns>

                                 </MasterTableView>
                        <PagerStyle Position="TopAndBottom" />

                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="getCourseList" runat="server" ConnectionString='<%$ ConnectionStrings:MembershipConnection %>' SelectCommand="SELECT CourseID, CourseTitle, CourseCode, SiteID, PrerequisiteID, GroupID, InstructorID, TestID, Description, Enabled, Enrollment, CourseType, Syllabus, CreditsEarned, StartDate, EndDate, EnableAssignments, ShowCourseSubHeading, EnableSideBarAnnouncements, EnableSideBarSupport, IconURL, dbo.GetCurriculumGroupCount(CourseID) AS CourseCount, dbo.GetGroupName(GroupID) as GroupName FROM Course WHERE (SiteID = @SiteID)">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="GigEngyn" Name="SiteID" Type="String"></asp:Parameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="getCurriculumGroups" runat="server" ConnectionString='<%$ ConnectionStrings:MembershipConnection %>' SelectCommand="SELECT CurriculumGroupID, CourseID, Title, RequiredGroupID, StartDate, SortOrder, PreRequisiteRequired, Required, Hold FROM CurriculumGroup WHERE (CourseID = @CourseID)">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="courseID" Name="CourseID" Type="String"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="getCurriculum" runat="server" ConnectionString='<%$ ConnectionStrings:MembershipConnection %>' SelectCommand="SELECT CurriculumID, CurriculumTitle, CurriculumGroupID, CourseID, Text, SortOrder, DesiredOrder, Enabled, ComplexityLevel, Required, Points,
dbo.GetCompletedCurriculumCount(CurriculumID) as TotalCompleted
FROM Curriculum 
WHERE (CurriculumGroupID = @CurriculumGroupID) ORDER BY SortOrder">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="CurriculumGroupID" Name="CurriculumGroupID" Type="String"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>




                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView2" runat="server">RadPageView</telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView3" runat="server">RadPageView</telerik:RadPageView>
                </telerik:RadMultiPage>


                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getCourses" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblBrandTrainings"></asp:LinqDataSource>
            </div>
        </div>
    </div>

         <script type="text/javascript">
         $('#training').addClass('active');
    </script>

</asp:Content>
