<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewTestQuestions.aspx.vb" Inherits="EventManagerApplication.ViewTestQuestions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Test Questions</title>
    <link href="../Theme/css/base-admin-3.css" rel="stylesheet" />
    <link href="../Theme/css/bootstrap.css" rel="stylesheet" />
    <link href="../Theme/css/custom.css" rel="stylesheet" />


    

</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

        <style>

        .RadGrid_Bootstrap .rgHeader, .RadGrid_Bootstrap th.rgResizeCol, .RadGrid_Bootstrap .rgHeaderWrapper {
            background-color: #3399cc;
        }

        .RadGrid_Bootstrap .rgHeader, .RadGrid_Bootstrap .rgHeader a {
            font-weight: bold;
            color: #fff;
        }

    </style>

    <div class="container">

        <div class="row">
            <div class="col-sm-12">
                <h3>
                <asp:Label ID="TestTitleLabel" runat="server" /></h3>

            </div>

        </div>

        <div class="row">
            <div class="col-sm-12">

        <div class="feature col-xs-4 col-sm-4 center">
                       
                            <div class="well bluebox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="TotalQuestionsLabel" runat="server"  /></h2>
                                <h5 class="text-center">Number of<br />Questions
                                    </h5>
                            </div>
            </div>

               
                <div class="feature col-xs-4 col-sm-4 center">
             <div class="well redbox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="TimeLimitLabel" runat="server"  /> Minutes</h2>
                                <h5 class="text-center">Time <br />Limit
                                    </h5>
                            </div>
                    </div>
                <div class="feature col-xs-4 col-sm-4 center">
             <div class="well greenbox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="PassingGradeLabel" runat="server"  />%</h2>
                                <h5 class="text-center">Passing<br />Grade
                                    </h5>
                            </div>
                        
                    </div>
                </div>
            </div>

         <div class="row">
            <div class="col-sm-12">

                <h4>Questions</h4>

        <telerik:RadGrid ID="RadGrid1" runat="server" GroupPanelPosition="Top" DataSourceID="getQuestions" Skin="Bootstrap">
            <MasterTableView DataSourceID="getQuestions" AutoGenerateColumns="False">
                <Columns>
                    <telerik:GridBoundColumn DataField="Title" HeaderText="Question" SortExpression="Title" UniqueName="Title" FilterControlAltText="Filter Title column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="QuestionType" HeaderText="Question Type" SortExpression="QuestionType" UniqueName="QuestionType" FilterControlAltText="Filter QuestionType column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Points" HeaderText="Points" SortExpression="Points" UniqueName="Points" DataType="System.Int32" FilterControlAltText="Filter Points column"></telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>

                </div>
             </div>

        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getQuestions" ContextTypeName="EventManagerApplication.LMSDataClassesDataContext" TableName="baretc_qryQuestions" Where="TestID == @TestID">
            <WhereParameters>
                <asp:QueryStringParameter QueryStringField="TestID" Name="TestID" Type="String"></asp:QueryStringParameter>
            </WhereParameters>
        </asp:LinqDataSource>
    </div>
    </form>
</body>
</html>
