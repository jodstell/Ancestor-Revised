<%@ Page Title="Payroll Paid" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="PayrollPaid.aspx.vb" Inherits="EventManagerApplication.PayrollPaid" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <style>
        .RadGrid_Bootstrap .rgHeader, .RadGrid_Bootstrap th.rgResizeCol, .RadGrid_Bootstrap .rgHeaderWrapper {
            background-color: #3399cc;
        }

            .RadGrid_Bootstrap .rgHeader, .RadGrid_Bootstrap .rgHeader a {
                font-weight: bold;
                color: #fff;
            }

        .widget .widget-content {
            padding-top: 5px;
        }

        .nav-tabs, .nav-pills {
            margin-bottom: 1px;
        }

        .table th, .table td {
            border-top: none !important;
        }

        .form-group {
            margin-bottom: 10px;
        }

        .MyInvoiceView {
            padding: 25px;
        }

        /*label {
            width: 125px;
        }*/
    </style>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="MainPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="MainPanel"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
          
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <asp:Panel ID="MainPanel" runat="server">

        <div class="container min-height">
            <div class="row">
                <div class="col-xs-12">
                    <h2>Reporting Dashboard - Reports</h2>
                    <hr />
                </div>
            </div>

            <div class="row">


                <div class="col-md-12">


                    <h3>Paid Payroll</h3>

                    <span style="font-size: 20px">
                        <asp:Label ID="selectedDateLabel" runat="server" Text="This is a history of all the payments that have been made YTD."></asp:Label></span>
                    <div class="row" style="margin-top:15px"></div>

                    <div class="row">

                <%--<div class="col-sm-12">

                    <div class="feature col-sx-4 col-sm-2 center">
                        
                            <div class="well blackbox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="TotalCountLabel" runat="server" /></h2>
                                <h5 class="text-center">Total<br />
                                    Events</h5>
                            </div>
                        
                    </div>
                    <div class="feature col-sx-4 col-sm-2 center">
                        
                            <div class="well bluebox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="AmbassadorCountLabel" runat="server" /></h2>
                                <h5 class="text-center">Number of<br />
                                    Ambassadors</h5>
                            </div>
                        
                    </div>


                    <div class="feature col-sx-4 col-sm-2 center">
                      

                            <div class="well orangebox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="TotalHoursLabel" runat="server" /></h2>
                                <h5 class="text-center">Total<br />
                                    Hours</h5>
                            </div>
                       
                    </div>

                    <div class="feature col-sx-4 col-sm-2 center">
                       
                            <div class="well greenbox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="TotalPayrollLabel" runat="server" /></h2>
                                <h5 class="text-center">Total<br />
                                    Payroll</h5>
                            </div>
                        
                    </div>

                    <div class="feature col-sx-4 col-sm-2 center">
                        
                            <div class="well darkbluebox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="AgeragePayLabel" runat="server" /></h2>
                                <h5 class="text-center">Average Event<br />
                                    Cost</h5>
                            </div>
                       
                    </div>

                    <div class="feature col-sx-2 col-sm-1 center">
                        
                           
                       
                    </div>


                    <div class="feature col-sx-2 col-sm-1">
                        
                           
                       
                    </div>


                </div>--%>

            </div>


                <div class="row" style="padding: 15px 5px 15px;">

                    <div class="col-sm-12">
                       <%-- <asp:Button ID="btnExportPayroll" runat="server" Text="Export Payroll" CssClass="btn btn-warning" />--%>

                        <%--<a id='filterbutton' class="filterbutton" href="#">Advanced Filter</a>--%>


                        <div class="btn-group pull-right" role="group" aria-label="...">

                            <a href="/Reports/BARetcReports/PayrollDashboard" class="btn btn-default"><i class="fa fa-chevron-left" aria-hidden="true"></i> Return to Payroll Dashboard</a>
                        </div>
                    </div>
                </div>


                    <telerik:RadGrid ID="PaidPaymentsRadGrid" runat="server" CellSpacing="-1" DataSourceID="SqlDataSource1" Skin="Bootstrap" 
                        AllowPaging="True" PageSize="50" AllowSorting="True" AllowFilteringByColumn="True" FilterType="HeaderContext" 
                        EnableHeaderContextMenu="true" AllowMultiRowSelection="true">
                        <MasterTableView DataSourceID="SqlDataSource1" AutoGenerateColumns="False">
                            <Columns>
                                <telerik:GridBoundColumn DataField="userName" HeaderText="User Name" SortExpression="userName" UniqueName="userName" FilterControlAltText="Filter userName column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FullName" HeaderText="Ambassador Name" SortExpression="FullName" UniqueName="FullName" FilterControlAltText="Filter FullName column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Hours" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours" DataType="System.Int32" FilterControlAltText="Filter Hours column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Labor" HeaderText="Labor" SortExpression="Labor" UniqueName="Labor" DataType="System.Decimal" DataFormatString="{0:C}" FilterControlAltText="Filter Labor column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Expenses" HeaderText="Expenses" SortExpression="Expenses" UniqueName="Expenses" DataFormatString="{0:C}" DataType="System.Decimal" FilterControlAltText="Filter Expenses column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Bonus" HeaderText="Bonus" SortExpression="Bonus" UniqueName="Bonus" DataType="System.Decimal" DataFormatString="{0:C}" FilterControlAltText="Filter Bonus column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataType="System.Decimal" DataFormatString="{0:C}" FilterControlAltText="Filter Total column"></telerik:GridBoundColumn>
                            </Columns>


                            <NoRecordsTemplate>
                                <br />
                                <div class="col-md-12">
                                    <div class="alert alert-warning" role="alert"><strong>There are no Payments to Show.</div>
                                </div>
                            </NoRecordsTemplate>

                        </MasterTableView>
                    </telerik:RadGrid>

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                        SelectCommand="SELECT * FROM [getPaidPayments] ORDER BY [FullName]"></asp:SqlDataSource>

                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getPaidPayroll"
                        ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="FullName"
                        TableName="getPaidPayments">
                    </asp:LinqDataSource>
                    


                    <asp:SqlDataSource ID="getExpenses" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                        SelectCommand="SELECT * FROM [qryViewExpensesForBillingSummary] WHERE ([RequirementID] = @RequirementID)">

                        <SelectParameters>
                            <asp:SessionParameter SessionField="RequirementID" Name="RequirementID" Type="Int32"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>



                </div>

            </div>

        </div>

    </asp:Panel>


    <telerik:RadWindowManager runat="server" ID="RadWindowManager1">

        <Windows>

            <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" NavigateUrl="/PhotoGallery.aspx" Skin="Bootstrap"
                Width="675px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                Modal="true">
            </telerik:RadWindow>

        </Windows>

    </telerik:RadWindowManager>


</asp:Content>

