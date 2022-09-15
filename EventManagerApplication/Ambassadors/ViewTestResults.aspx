<%@ Page Title="Test Results" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewTestResults.aspx.vb" Inherits="EventManagerApplication.ViewTestResults" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="HF_UserName" runat="server" />
    <asp:HiddenField ID="HF_UserID" runat="server" />

        <div class="container min-height">

         <div class="row">
            <div class="col-xs-12">
                <h2>Test Results</h2>

                  <ol class="breadcrumb">
                        <li><i class="fa fa-home" aria-hidden="true"></i><a href="/"> Dashboard</a></li>
                        <li><a href='/Ambassadors/ViewAmbassadorDetails?UserID=<%: getUserID()%>' onclick="ShowLoadingPanel()">Ambassador Details</a></li>
                        <li><a href='/Ambassadors/TrainingDetails?CourseID=<%: getCourseID() %>&UserID=<%: getUserID()%>' onclick="ShowLoadingPanel()">Training Details</a></li>
                        <li class="active">Test Results</li>
                    </ol>

            </div>

            <div class="col-md-12 detail">
                
                <div class="pull-right secondarytab"><a href='/Ambassadors/TrainingDetails?CourseID=<%: getCourseID() %>&UserID=<%: getUserID()%>' onclick="ShowLoadingPanel()" class="btn btn-default" style="line-height: 1.4;"><i class="fa fa-chevron-left" aria-hidden="true"></i> Go to Training Details</a>
                </div>

                <br /><br />
                           <h3>
                            <%: getTestName() %>
                                <span class='<%: getResultBadge(getTestResult())%>'><%: getTestResult()%>&nbsp;&nbsp;<span class="badge-lg pull-right"><%: getTestScore()%> %</span></span>
                           </h3>

            </div>

             <hr />
             </div><!-- /.row -->
            <hr />
                             <div class="row">

                    <div class="col-md-4 col-sm-4">

                        <h4>Ambassador Information</h4>

                        <table class="table">
                            <tbody>
                                <tr>
                                    <td style="width: 90px">
                                        <asp:Repeater ID="headshot" runat="server" DataSourceID="getHeadShot">
                                            <ItemTemplate>
                                                <telerik:RadBinaryImage ID="thumbnailImage" runat="server" CssClass="thumbnail"
                                                    AlternateText="Click to view larger image" 
                                                    DataValue='<%#IIf(TypeOf (Eval("headShot_thumbnail")) Is DBNull, Nothing, Eval("headShot"))%>'
                                                    Height="90px" Width="90px" ResizeMode="Crop" />

                                            </ItemTemplate>
                                        </asp:Repeater>

                                        <asp:SqlDataSource runat="server" ID="getHeadShot" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                            SelectCommand="SELECT [userID], [headShot_thumbnail], [headshot] FROM [tblAmbassadorPhoto] WHERE ([userID] = @userID)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="HF_UserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>

                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td>
                                        <h4><%: getStudentName()%></h4>
                                            
                                            

                                    </td>
                                </tr>
                            </tbody>
                        </table>



                    </div>
                    <!-- /.col -->

                    <div class="col-md-5 col-sm-5">

                        <h4>Test Details</h4>

                        <table class="table table-bordered table-striped">
                            <tbody>
                                <tr>
                                    <td>Test Score:</td>
                                    <td><%: getTestScore()%>%
                                    </td>
                                </tr>
                                <tr>
                                    <td>Passing Score:</td>
                                    <td><%: getPassingScore()%>%</td>
                                 </tr>
                               
                                 <tr> 
                                    <td>Date:</td>
                                    <td><%: String.Format("{0:MM/dd/yyyy hh:mm tt}", getTestDate())%></td>
                                 </tr>
                                

                                <tr>
                                    <td>Time on Test:</td>
                                    <td><%: getTestTime()%> ??? Minutes</td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                    <!-- /.col -->

                    <div class="col-md-3 col-sm-3">

                    <ul class="nav nav-pills nav-stacked">
                      <li class="blue">
                        <a href="#" style="cursor:text">
                          <span class="badge pull-right"><%: getTotalQuestions()%></span>
                          Total Questions
                        </a>
                      </li>
                    </ul>



                    <ul class="nav nav-pills nav-stacked">
                      <li class="green">
                        <a href="#" style="cursor:text">
                          <span class="badge pull-right"><%: getTotalCorrect()%></span>
                          Correct Answers
                        </a>
                      </li>
                    </ul>



                    <ul class="nav nav-pills nav-stacked">
                      <li class="red">
                        <a href="#" style="cursor:text">
                          <span class="badge pull-right"><%: getTotalIncorrect()%></span>
                          Incorrect Answers
                        </a>
                      </li>
                    </ul>

                    </div>


                  

                </div>
                <!-- /.row -->
<hr />
                             <div class="row">

<div class="col-md-3 col-md-push-9">

                        <h4> Actions</h4>
						
						<div class="list-group">

							<%--<a href="javascript:;" class="list-group-item">
								<i class="fa fa-envelope"></i> 
								&nbsp;&nbsp;<strong>Send</strong> Link
							</a>--%>

<%--							<a href="javascript:;" class="list-group-item">
								<i class="fa fa-print"></i>
								&nbsp;&nbsp;<strong>Print</strong> Test
							</a>--%>

<%--							<a href="javascript:;" class="list-group-item">
								<i class="fa fa-copy"></i>
								&nbsp;&nbsp;<strong>Duplicate</strong> Test
							</a>--%>

                                <asp:LinkButton ID="BtnDeteteTest" runat="server" CssClass="list-group-item"
                                    OnClientClick="javascript:if(!confirm('This action will delete the selected test. Are you sure?')){return false;}">
								<i class="fa fa-times"></i>
								&nbsp;&nbsp;<strong>Delete</strong> Test Results
							</asp:LinkButton>

						</div>

                    </div>
                    <div class="col-md-9 col-md-pull-3">

                    

                <h4>Answer List</h4>

                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource2">
                    <ItemTemplate>


                        <table class="table table-bordered table-striped">
                            <tr>
                                <td colspan="4" bgcolor="#d5d5d5" height="50" valign="middle">
                                    <strong>Question # <%# Eval("QuestionOrder") %> - <%# Eval("Title") %></strong></td>
                            </tr>
                            <tr>
                                <td width="4%" align="center" valign="top" bgcolor="#e5e5e5">Option</td>
                                <td width="8%" align="center" valign="top" bgcolor="#e5e5e5">Correct<br>
                                    Answer</td>
                                <td width="8%" align="center" valign="top" bgcolor="#e5e5e5">User<br>
                                    Answer</td>
                                <td width="85%" valign="top" bgcolor="#e5e5e5">&nbsp;Option Text</td>
                            </tr>
                            <tr>
                                <td width="4%" height="20">&nbsp;1.</td>
                                <td width="8%" align="center">&nbsp;

            <asp:Image ID="Image1" runat="server" ImageUrl="/images/grncheck.gif" Visible='<%# Eval("CorrectAnswer") = 1 %>' />
                                </td>
                                <td width="8%" align="center">&nbsp;
		<asp:Image ID="Image2" runat="server" ImageUrl='<%# getImage(Eval("UserAnswer"),Eval("CorrectAnswer"),1) %>' /></td>
                                <td width="85%">&nbsp;<%# Eval("Answer1") %></td>
                            </tr>
                            <tr>
                                <td width="4%" height="20">&nbsp;2.</td>
                                <td width="8%" align="center">&nbsp;
		<asp:Image ID="Image3" runat="server" ImageUrl="/images/grncheck.gif" Visible='<%# Eval("CorrectAnswer") = 2 %>' /></td>
                                <td width="8%" align="center">&nbsp;
		<asp:Image ID="Image6" runat="server" ImageUrl='<%# getImage(Eval("UserAnswer"),Eval("CorrectAnswer"),2) %>' />
                                </td>
                                <td width="85%">&nbsp;<%# Eval("Answer2") %></td>
                            </tr>
                            <tr>
                                <td width="4%" height="20">&nbsp;3.</td>
                                <td width="8%" align="center">&nbsp;
		<asp:Image ID="Image4" runat="server" ImageUrl="/images/grncheck.gif" Visible='<%# Eval("CorrectAnswer") = 3 %>' /></td>
                                <td width="8%" align="center">&nbsp;
		<asp:Image ID="Image7" runat="server" ImageUrl='<%# getImage(Eval("UserAnswer"),Eval("CorrectAnswer"),3) %>' />
                                </td>
                                <td width="85%">&nbsp;<%# Eval("Answer3") %></td>
                            </tr>
                            <tr>
                                <td width="4%" height="20">&nbsp;4.</td>
                                <td width="8%" align="center">&nbsp;
		<asp:Image ID="Image5" runat="server" ImageUrl="/images/grncheck.gif" Visible='<%# Eval("CorrectAnswer") = 4 %>' /></td>
                                <td width="8%" align="center">&nbsp;
		<asp:Image ID="Image8" runat="server" ImageUrl='<%# getImage(Eval("UserAnswer"),Eval("CorrectAnswer"),4) %>' />
                                </td>
                                <td width="85%">&nbsp;<%# Eval("Answer4") %></td>
                            </tr>

                             <tr>
                                <td width="4%" height="20">&nbsp;5.</td>
                                <td width="8%" align="center">&nbsp;
		<asp:Image ID="Image9" runat="server" ImageUrl="/images/grncheck.gif" Visible='<%# Eval("CorrectAnswer") = 5 %>' /></td>
                                <td width="8%" align="center">&nbsp;
		<asp:Image ID="Image10" runat="server" ImageUrl='<%# getImage(Eval("UserAnswer"), Eval("CorrectAnswer"), 5) %>' />
                                </td>
                                <td width="85%">&nbsp;<%# Eval("Answer5") %></td>
                            </tr>

                             <tr>
                                <td width="4%" height="20">&nbsp;6.</td>
                                <td width="8%" align="center">&nbsp;
		<asp:Image ID="Image11" runat="server" ImageUrl="/images/grncheck.gif" Visible='<%# Eval("CorrectAnswer") = 6 %>' /></td>
                                <td width="8%" align="center">&nbsp;
		<asp:Image ID="Image12" runat="server" ImageUrl='<%# getImage(Eval("UserAnswer"), Eval("CorrectAnswer"), 6) %>' />
                                </td>
                                <td width="85%">&nbsp;<%# Eval("Answer6") %></td>
                            </tr>
                        </table>

                        <br />
                        <br />
                    </ItemTemplate>
                </asp:DataList>

                        </div>
                    
                </div>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LMSConnection %>"
                    SelectCommand="prTestResultsDetail" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="TestSessionID" QueryStringField="ID" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="VirtualTestingOLDashboard.DataClassesDataContext" EntityTypeName="" TableName="Applicants" Where="dbGUID == @dbGUID">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="HF_UserName" Name="dbGUID" PropertyName="Value" Type="String" />
                    </WhereParameters>
                </asp:LinqDataSource>

             

             </div>

</asp:Content>
