<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Training.aspx.vb" Inherits="EventManagerApplication.Training" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h2>Training</h2>
                <hr />


                <h3>Courses & Tests</h3>

                <telerik:RadGrid ID="CoursesList" runat="server" DataSourceID="getCourses" GroupPanelPosition="Top">
                    <MasterTableView DataKeyNames="brandTrainingID" DataSourceID="getCourses" AutoGenerateColumns="False">
                        <Columns>
                            <telerik:GridBoundColumn DataField="brandTrainingID" ReadOnly="True" HeaderText="brandTrainingID" SortExpression="brandTrainingID" UniqueName="brandTrainingID" DataType="System.Int32" FilterControlAltText="Filter brandTrainingID column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="brandID" HeaderText="brandID" SortExpression="brandID" UniqueName="brandID" DataType="System.Int32" FilterControlAltText="Filter brandID column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="curriculumID" HeaderText="curriculumID" SortExpression="curriculumID" UniqueName="curriculumID" FilterControlAltText="Filter curriculumID column"></telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>

                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getCourses" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblBrandTrainings"></asp:LinqDataSource>
            </div>
        </div>
    </div>

</asp:Content>
