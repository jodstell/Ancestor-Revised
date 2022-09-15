<%@ Page Title="Training Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Dashboard.aspx.vb" Inherits="EventManagerApplication.Dashboard1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .div-wrapper {
  position: relative;
  display: inline-block;
  vertical-align: top;
  width: 100%;
  padding: 25px 15px 25px;
  margin: 0;
  text-align: center;
  background: #FFF;
  border: 1px solid #DDD;
  -webkit-border-radius: 4px;
  -webkit-background-clip: padding-box;
  -moz-border-radius: 4px;
  -moz-background-clip: padding;
  border-radius: 4px;
  background-clip: padding-box;
}
.div-wrapper.promoted {
  background-image: -webkit-gradient(linear, left 0%, left 100%, from(#ffffff), to(#ededed));
  background-image: -webkit-linear-gradient(top, #ffffff, 0%, #ededed, 100%);
  background-image: -moz-linear-gradient(top, #ffffff 0%, #ededed 100%);
  background-image: linear-gradient(to bottom, #ffffff 0%, #ededed 100%);
  background-repeat: repeat-x;
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffffff', endColorstr='#ffededed', GradientType=0);
}
.div-wrapper div-help {
  border-bottom: 1px dotted #000;
}
.div-wrapper div-best-value {
  position: absolute;
  top: 0;
  left: 0;
}
.div-wrapper strong.ui-popover {
  border-bottom: 1px dotted #000;
}
.div-wrapper .div-title {
  margin-bottom: 0;
  font-size: 21px;
  font-weight: 600;
  text-transform: uppercase;
}
.div-wrapper .div-inner {
  display: block;
}
.div-wrapper .div-inner .div-label {
  color: #46a546;
  font-size: 32px;
  font-weight: 400;
}
.div-wrapper uldiv-details {
  padding: 0;
  margin: 0 0 2em;
}
.div-wrapper uldiv-details li {
  list-style: none;
  margin: 0 0 1.65em;
}

        .portlet .portlet-content {
            padding: 0px;
        }

        .portlet .portlet-content .alt1 {
            padding: 22px 15px 15px;
        }

        .alt1 {padding: 22px 15px 15px;}

        .alt2 {padding: 22px 15px 15px;
               background-color: #ededed;
        }

    </style>
    <div class="container">


         <div class="row">
            <div class="col-xs-12">
                <h2>Training Dashboard</h2>
                <ol class="breadcrumb">
                    <li><i class="fa fa-home" aria-hidden="true"></i><a href="/"> Dashboard</a></li>
                    <li class="active">Training</li>
                </ol>

            </div>
        </div>

        <asp:Panel ID="SelectPanel" runat="server" Visible="true">
            <div class="row">
            <div class="col-xs-12" style="margin-bottom:25px;">
                <telerik:RadComboBox ID="supplierIDComboBox" runat="server" AllowCustomText="true" MarkFirstMatch="true"
                                                    DataSourceID="GetSupplierList" Width="300px" DataTextField="supplierName" DataValueField="supplierID" EmptyMessage="Select Course">                                                    
                                                </telerik:RadComboBox>

                <asp:Button ID="BtnSelectSupplier" runat="server" Text="Select" CssClass="btn btn-default" />
                <br />
                </div>
                </div>

        <asp:SqlDataSource ID="GetSupplierList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetSuppliersWithCourseByUser" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
            </asp:Panel>

        <asp:Panel ID="MainPanel" runat="server">
                     <div class="row">
            <div class="col-xs-12">

                <h3>
                <asp:Label ID="CourseTitleLabel" runat="server" /></h3>

                <div class="row1">

                                    <div class="col-md-9">


                                        <div class="row">

                                            <div class="col-md-3 col-sm-6">

                                                <div class="div-wrapper">

                                                    <h4 class="div-title">Registered BA's</h4>

                                                    <hr />

                                                    <span class="div-inner">
                                                        <span class="div-label">
                                                            <asp:Label ID="ReqisteredLabel" runat="server" /></span>
                                                    </span>

                                                </div>
                                                <!-- /div -->

                                            </div>
                                            <!-- /.col -->


<%--                                            <div class="col-md-3 col-sm-6">
                                                <div class="div-wrapper">

                                                    <h4 class="div-title">% Completed</h4>

                                                    <hr>

                                                    <span class="div-inner">
                                                        <span class="div-label">??</span> %
                                                    </span>


                                                </div>
                                                

                                            </div>--%>
                                           


                                            <div class="col-md-3 col-sm-6">
                                                <div class="div-wrapper">

                                                    <h4 class="div-title"># of Courses  </h4>

                                                    <hr />

                                                    <span class="div-inner">
                                                        <span class="div-label">
                                                            <asp:Label ID="CourseGroupCountLabel" runat="server" /></span>
                                                    </span>

                                                </div>
                                                <!-- /div -->

                                            </div>
                                            <!-- /.col -->


                                            <div class="col-md-3 col-sm-6">
                                                <div class="div-wrapper">

                                                    <h4 class="div-title"># of Test/Quiz</h4>

                                                    <hr />

                                                    <span class="div-inner">
                                                        <span class="div-label">
                                                            <asp:Label ID="TestCountLabel" runat="server" /></span>
                                                    </span>

                                                </div>
                                                <!-- /div -->

                                            </div>
                                            <!-- /.col -->


                                        </div>
                                        <!-- /.row -->



                                        <div style="margin-top:15px;">


                                            <div class="portlet">

                                                <div class="portlet-header">

                                                    <h3>
                                                        <i class="fa fa-bar-chart-o"></i>
                                                        Course Content/Lesson Plan 
                                                    </h3>

                                                </div>
                                                <!-- /.portlet-header -->

                                                <div class="portlet-content alt1">

                                        <telerik:RadListView ID="CurriculumGroupList" runat="server" ItemPlaceholderID="defaultHolder">

                                            <LayoutTemplate>
                                                            <asp:PlaceHolder ID="defaultHolder" runat="server"></asp:PlaceHolder>
                                            </LayoutTemplate>
                                                        
                                            <AlternatingItemTemplate>
                                                            <div class="alt2">
                                                            <h4><%# Eval("Title")%></h4>
                                               
                                               <asp:Label ID="lblCurriculumGroupID" runat="server" Text='<%# Eval("CurriculumGroupID")%>' Visible="false" />

                                                <%--Curriculum--%>
                                                <asp:Repeater ID="CurriculumGrid" runat="server">
                                            <HeaderTemplate>
                                                <table class="table table-responsive">
                                                    <thead>
                                                        <tr>
                                                            <th></th>
                                                            <th>Title</th>
                                                            <th>Last Week</th>
                                                            <th>This Week</th>
                                                            <th>Last 24 Hours</th>
                                                            <th>Total Completed</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                            </HeaderTemplate>
                                                    
                                            <ItemTemplate>
                                                
                                                <tr>
                                                    <td>
                                                        <%--This button need to be the same as the one on event details--%>
                                                        
                                                        <%--<a class="btn btn-xs btn-tertiary" href='<%# DataBinder.Eval(Container.DataItem, "CurriculumID", "return getLink({0});")%>'>Preview &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>--%>
                                                        
                                                        <asp:HyperLink ID="CurriculumLink2" runat="server" CssClass="btn btn-xs btn-tertiary" onclick='<%# "return getLink(""" + Eval("url") + """);"%>'>Preview &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:HyperLink>

                                                    </td>
                                                    <td style="width: 60%"><%# Eval("CurriculumTitle")%></td>
                                                    <td><%# Eval("lastweek")%></td>
                                                    <td><%# Eval("thisweek")%></td>
                                                    <td><%# Eval("last24hours")%></td>
                                                    <td><%# Eval("Completed")%></td>
                                                    
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
                                                        </AlternatingItemTemplate>

                                            <ItemTemplate>
                                            <div class="alt1">
                                               <h4><%# Eval("Title")%></h4>
                                               
                                               <asp:Label ID="lblCurriculumGroupID" runat="server" Text='<%# Eval("CurriculumGroupID")%>' Visible="false" />

                                                <%--Curriculum--%>
                                                <asp:Repeater ID="CurriculumGrid" runat="server">

                                            <HeaderTemplate>
                                                <table class="table table-responsive">
                                                    <thead>
                                                        <tr>
                                                            <th></th>
                                                            <th>Title</th>
                                                            <th>Last Week</th>
                                                            <th>This Week</th>
                                                            <th>Last 24 Hours</th>
                                                            <th>Total Completed</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                            </HeaderTemplate>
                                                    
                                            <ItemTemplate>
                                                
                                                <tr>
                                                    <td>
                                                        <%--<a class="btn btn-xs btn-tertiary" href='<%# DataBinder.Eval(Container.DataItem, "CurriculumID", "return getLink({0});")%>'>Preview &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>--%>

                                            <asp:HyperLink ID="CurriculumLink2" runat="server" CssClass="btn btn-xs btn-tertiary" onclick='<%# "return getLink(""" + Eval("url") + """);"%>'>Preview &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:HyperLink>
                                                        
                                               </td>
                                                    <td style="width: 60%"><%# Eval("CurriculumTitle")%></td>
                                                    <td><%# Eval("lastweek")%></td>
                                                    <td><%# Eval("thisweek")%></td>
                                                    <td><%# Eval("last24hours")%></td>
                                                    <td><%# Eval("Completed")%></td>
                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                <tr>
                                                    <td colspan="6">
                                                        <asp:Label ID="lblEmptyData"
                                                            Text='<%# Common.ShowAlertNoClose("warning", "There are items to display.")%>' runat="server" Visible="false">
                                                        </asp:Label>
                                                    </td>
                                                </tr>

                                                </tbody>
                                                        </table>
                                            </FooterTemplate>

                                        </asp:Repeater>

                                                
                                            </div>
                                            </ItemTemplate>

                                        </telerik:RadListView>
                                                    
                                                    </div>

                                                </div>
                                                <!-- /.portlet-content -->

                                            </div>
                                            <!-- /.portlet -->

                                        </div>

                    <div class="col-md-3 col-sidebar-right">

                    <h2>Event Guidlines</h2>

                    <ul class="icons-list">
                        <telerik:RadListView ID="LibraryFileList" runat="server">
                            <ItemTemplate>
                                <li><i class="icon-li fa fa-file-pdf-o"></i>
                                    <a href='/FileHandler.aspx?ID=<%# Eval("ID")%>'><%# Eval("FileName")%></a>
                                    <asp:LinkButton ID="btnDeleteFile" runat="server" CommandName="DeleteFile" CommandArgument='<%# Eval("FileID")%>' CssClass="pull-right" Visible="false"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                </li>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                There are no documents for this school.
                            </EmptyDataTemplate>
                        </telerik:RadListView>
                    </ul>
                    <hr />
                    <div class="feed-subject">
                        <h2>Links</h2>
                        <ul class="icons-list">

                            <telerik:RadListView ID="CourseLinksList" runat="server">
                                <ItemTemplate>
                                    <li><i class="icon-li fa fa-external-link"></i>
                                        <a target="_blank" href='http://<%# Eval("LinkURL")%>'><%# Eval("LinkTitle")%></a>
                                        <asp:LinkButton ID="btnDeleteLink" Visible="false" runat="server" CommandName="DeleteLink" CommandArgument='<%# Eval("LinkID")%>' CssClass="pull-right"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                    </li>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    There are no links for this school.
                                </EmptyDataTemplate>
                            </telerik:RadListView>
                        </ul>
                    </div>
                    <hr />
                    <h2>Video/Media</h2>


                    <br />

                    <%--  <div class="widget stacked">
                    <div class="widget-content">
                    <asp:Literal ID="CourseDescriptionLabel" runat="server"></asp:Literal>
                        </div>
                        </div>--%>
                    <%-- <uc3:MyAssignmentsControl ID="MyAssignmentsControl1" runat="server" />

                    <uc4:ClassAnnouncementsControl ID="ClassAnnouncementsControl1" runat="server" />--%>
                </div>
                                   
                                    <div class="col-md-3 col-sidebar-right" style="display:none">

                                        <%--<p>   
                                        <asp:Button ID="BtnToggleEnabled" runat="server" /></p>--%>

                                        <p>

                                            <asp:HyperLink ID="BtnEditCourse" Visible="true" runat="server" Target="_blank" CssClass="btn btn-md btn-primary btn-block"><i class="fa fa-pencil"></i> &nbsp;Edit Course</asp:HyperLink>

                                           <%-- <asp:LinkButton ID="BtnEdit" runat="server" CssClass="btn btn-md btn-primary btn-block"><i class="fa fa-pencil"></i> &nbsp;Edit Course</asp:LinkButton>--%>

                                        </p>

                                       

                                        <br />

                                        <%--<h4>Actions</h4>

                                        <div class="list-group">

                                           

                                            <a href="javascript:;" class="list-group-item">
                                                <i class="fa fa-times"></i>
                                                &nbsp;&nbsp;<strong>Delete</strong> Test
                                            </a>

                                        </div>


                                        <br />--%>

                                        <div class="portlet" style="display:none">

                                            <div class="portlet-header">

                                                <h3>
                                                    <%--<i class="fa fa-compass"></i>--%>
                                                    Test/Quiz Historic Overview
                                                </h3>

                                            </div>
                                            <!-- /.portlet-header -->

                                            <div class="portlet-content">
                                                <div class="alt1">
                                                <asp:Panel ID="NoHistoryPanel" runat="server">
                                                    <div class="alert alert-warning">There is no history to display.</div>
                                                </asp:Panel>

                                                <asp:Panel ID="HistoryPanel" runat="server">


                                                    <div class="progress-stat">

                                                        <div class="stat-header">

                                                            <div class="stat-label">
                                                                Passed Test Rate
                                                            </div>
                                                            <!-- /.stat-label -->

                                                            <div class="stat-value">
                                                               %
                                                            </div>
                                                            <!-- /.stat-value -->

                                                        </div>
                                                        <!-- /stat-header -->

                                                        <div class="progress progress-striped active">
                                                            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="42" aria-valuemin="0" aria-valuemax="100" style=''>
                                                                <span class="sr-only">% Passed</span>
                                                            </div>
                                                        </div>
                                                        <!-- /.progress -->

                                                    </div>
                                                    <!-- /.progress-stat -->


                                                    <div class="progress-stat">

                                                        <div class="stat-header">

                                                            <div class="stat-label">
                                                                Failed Test Rate
                                                            </div>
                                                            <!-- /.stat-label -->

                                                            <div class="stat-value">
                                                                %
                                                            </div>
                                                            <!-- /.stat-value -->

                                                        </div>
                                                        <!-- /stat-header -->

                                                        <div class="progress progress-striped active">
                                                            <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow='10' aria-valuemin="0" aria-valuemax="100" style=''>
                                                                <span class="sr-only">10 % Total Failed Rate</span>
                                                            </div>
                                                        </div>
                                                        <!-- /.progress -->

                                                    </div>
                                                    <!-- /.progress-stat -->



                                                    <div class="progress-stat">

                                                        <div class="stat-header">

                                                            <div class="stat-label">
                                                                Cancel Test Rate
                                                            </div>
                                                            <!-- /.stat-label -->

                                                            <div class="stat-value">
                                                                %
                                                            </div>
                                                            <!-- /.stat-value -->

                                                        </div>
                                                        <!-- /stat-header -->

                                                        <div class="progress progress-striped active">
                                                            <div class="progress-bar progress-bar-secondary" role="progressbar" aria-valuenow="42" aria-valuemin="0" aria-valuemax="100" style=''>
                                                                <span class="sr-only">% Cancelled</span>
                                                            </div>
                                                        </div>
                                                        <!-- /.progress -->

                                                    </div>
                                                    <!-- /.progress-stat -->

                                                    <br />
                                                </asp:Panel>
                                            </div>
                                                </div>
                                            <!-- /.portlet-content -->

                                        </div>
                                        <!-- /.portlet -->

                                    </div>
                                </div>

                </div>


                </div>
                        

        </asp:Panel>


        <asp:Panel ID="Panel1" runat="server" Visible="false">
         <div class="row">
            <div class="col-xs-12">

                

                <div class="jumbotron">
                    
        <h1>Training Currently Unavailable </h1>
        <p class="lead">We are currently in the process of upgrading our Training pages and is unavailable at the moment.</p>
        <p></p>
      </div>


        <%--<a href="http://dashboard.GigEngyn.com" target="_blank">
            Go to GigEngyn </a>--%>

                </div>
             </div>
            </asp:Panel>

    </div>


    <telerik:RadWindowManager runat="server" ID="RadWindowManager1">

        <Windows>

            <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" Skin="Bootstrap"
                Width="675px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                Modal="true">
            </telerik:RadWindow>

        </Windows>

    </telerik:RadWindowManager>


    <script type="text/javascript">

        //function getLink(CurriculumID) {
        //        //alert(CurriculumID);
        //        var win = window.radopen('/Training/ViewCurriculum.aspx?p=1&ID=' + CurriculumID, 'null');
        //        win.center(); win.setSize(700, 700); win.set_status = ' ';
        //        win.SetModal(true);
        //        win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);
        //}

        function getLink(link) {
            //alert(link);
            var win = window.radopen(link, 'null');
            win.center(); win.setSize(700, 700); win.set_status = ' ';
            win.SetModal(true);
            win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);
        }

            
    </script>

</asp:Content>
