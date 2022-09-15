<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AvailableTestsControl.ascx.vb" Inherits="EventManagerApplication.AvailableTestsControl" %>

  <style>
      .panel-body {
     padding: 3px; 
}
  </style>

                <div class="panel panel-primary">

                    <div class="panel-heading">
                        
                        <h3 class="panel-title"><i class="icon-th-list"></i> <asp:Label ID="CurrentTestsAvailableLabel" runat="server" Text="<%$ Resources:Resource, CurrentTestsAvailableLabel %>" /></h3>
                    </div>
                    <!-- /widget-header -->

                    <div class="panel-body">

                                               




                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EmptyDataText="There are currently no tests available."
                             CssClass="table table-striped table-bordered">
      <EmptyDataTemplate>
          There are currently no tests available.
      </EmptyDataTemplate>
        <Columns>

            <asp:HyperLinkField DataNavigateUrlFields="TestID" ControlStyle-CssClass="btn btn-xs btn-success"
                DataNavigateUrlFormatString="/Start?id={0}"
                DataTextField="TestResult">
                <ItemStyle HorizontalAlign="Center" Width="95px" Font-Bold="True" />
            </asp:HyperLinkField>

            <asp:BoundField DataField="Title" HeaderText="Test Name" SortExpression="Title">
                <ItemStyle Font-Bold="true" />
            </asp:BoundField>

           

          

             <asp:TemplateField HeaderText="Passing Grade">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# String.Format("{0} %", Eval("PassingGrade"))%>'></asp:Label>
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



                        </div>
                    <!-- /widget-content -->
                </div>
                <!-- /widget -->


<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MembershipConnection %>"
    SelectCommand="baretc_CurentAvailableTestsByCourse" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="GUID" Name="UserName" PropertyName="Value" />
        <asp:QueryStringParameter QueryStringField="CourseID" Name="CourseID" Type="String"></asp:QueryStringParameter>

    </SelectParameters>
    </asp:SqlDataSource>



    <asp:HiddenField ID="GUID" runat="server" />
    <asp:HiddenField ID="SiteID" runat="server" />