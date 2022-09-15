<%@ Page Title="Payroll Approved" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="PayrollApproved.aspx.vb" Inherits="EventManagerApplication.PayrollApproved" %>

<%@ Register Src="~/Reports/UserControls/SideMenuControl.ascx" TagPrefix="uc1" TagName="SideMenuControl" %>

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

        .buttonrow {
            height: 50px;
            vertical-align: middle;
        }

        .margin {
            margin-left: 15px;
        }

        /*label {
            width: 125px;
        }*/
    </style>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script>
            function requestStart(sender, args) {

                if (args.get_eventTarget().indexOf("btnExportPayroll") > 0 ||

                args.get_eventTarget().indexOf("btnExportPayroll") > 0)

                    args.set_enableAjax(false);
            }
        </script>
    </telerik:RadScriptBlock>

    <%--    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="requestStart()">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="MainPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="MainPanel"  />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>--%>

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

                    <h3>Approved Payroll</h3>

                    <span style="font-size: 20px">
                        <asp:Label ID="selectedDateLabel" runat="server"></asp:Label></span>
                    <div class="row" style="margin-top: 15px"></div>


                </div>
            </div>


            <div class="row">

                <div class="col-sm-12">

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


                </div>

            </div>


            <asp:Panel runat="server" ID="ApprovedPanel">

                <div class="row">
                    <div class="col-sm-12">
                    <p>Your payroll items are ready to be processed click on the 'Process and Export Payroll' button. 
                         <asp:Label ID="topMsgLabel" runat="server" ForeColor="red" Font-Bold="true"  /></p>
                    </div>
                </div>

                <div class="row" style="padding: 5px 5px 15px;">

                    <div class="col-sm-12">

                    
                        From: <span class="text-danger">*</span>                        
                        <telerik:RadDatePicker ID="fromRadDatePicker" runat="server" Culture="en-US" ShowPopupOnFocus="true" Skin="Bootstrap">
                            <Calendar runat="server">
                                <SpecialDays>
                                    <telerik:RadCalendarDay Repeatable="Today">
                                        <ItemStyle CssClass="rcToday" />
                                    </telerik:RadCalendarDay>
                                </SpecialDays>
                            </Calendar>
                        </telerik:RadDatePicker>
                        
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="errorlabel margin" Display="Dynamic" ValidationGroup="payrolldate"
                        ControlToValidate="fromRadDatePicker" ErrorMessage="From Date is required"></asp:RequiredFieldValidator>
                        

                        To: <span class="text-danger">*</span>                        
                        <telerik:RadDatePicker ID="toRadDatePicker" runat="server" Culture="en-US" ShowPopupOnFocus="true" Skin="Bootstrap">
                            <Calendar runat="server">
                                <SpecialDays>
                                    <telerik:RadCalendarDay Repeatable="Today">
                                        <ItemStyle CssClass="rcToday" />
                                    </telerik:RadCalendarDay>
                                </SpecialDays>
                            </Calendar>
                        </telerik:RadDatePicker>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="errorlabel margin" Display="Dynamic" ValidationGroup="payrolldate"
                        ControlToValidate="toRadDatePicker" ErrorMessage="To Date is required"></asp:RequiredFieldValidator>                        
                        <asp:Button ID="btnChangeDateRange" runat="server" Text="Filter" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Date Range" />


                    <%--<a id='filterbutton' class="filterbutton" href="#">Advanced Filter</a>--%>


                    <div class="btn-group pull-right" role="group" aria-label="...">

                       <asp:Button ID="btnProcessExportPayroll" runat="server" Text="Process and Export Payroll" CssClass="btn btn-success" ValidationGroup="payrolldate" />

                        <a href="/Reports/BARetcReports/PayrollDashboard" class="btn btn-default"><i class="fa fa-chevron-left" aria-hidden="true"></i> Return to Payroll Dashboard</a>
                        
                    </div>
                        </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <telerik:RadGrid ID="ApprovedPaymentsRadGrid" runat="server" CellSpacing="-1" DataSourceID="SqlDataSource1" Skin="Bootstrap"
                            AllowPaging="True" PageSize="50" AllowSorting="True" AllowFilteringByColumn="True" FilterType="HeaderContext" EnableHeaderContextMenu="true" AllowMultiRowSelection="true">
                            <MasterTableView DataSourceID="SqlDataSource1" AutoGenerateColumns="False">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="userName" HeaderText="User Name" SortExpression="userName" UniqueName="userName" FilterControlAltText="Filter userName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="FullName" HeaderText="Ambassador Name" SortExpression="FullName" UniqueName="FullName" FilterControlAltText="Filter FullName column"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="eventDate" HeaderText="Event Date" SortExpression="eventDate" UniqueName="eventDate" FilterControlAltText="Filter eventDate column" DataFormatString="{0:d}"></telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="Hours" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours" DataType="System.Int32" FilterControlAltText="Filter Hours column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Labor" HeaderText="Labor" SortExpression="Labor" UniqueName="Labor" DataType="System.Decimal" DataFormatString="{0:C}" FilterControlAltText="Filter Labor column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Expenses" HeaderText="Expenses" SortExpression="Expenses" UniqueName="Expenses" DataFormatString="{0:C}" DataType="System.Decimal" FilterControlAltText="Filter Expenses column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Bonus" HeaderText="Bonus" SortExpression="Bonus" UniqueName="Bonus" DataType="System.Decimal" DataFormatString="{0:C}" FilterControlAltText="Filter Bonus column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataType="System.Decimal" DataFormatString="{0:C}" FilterControlAltText="Filter Total column"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="work_type_name" HeaderText="work_type_name" SortExpression="work_type_name" UniqueName="work_type_name" FilterControlAltText="Filter work_type_name column" Visible="false"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="quantity" HeaderText="quantity" SortExpression="quantity" UniqueName="quantity" FilterControlAltText="Filter quantity column" Visible="false"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="display_name" HeaderText="display_name" SortExpression="display_name" UniqueName="display_name" FilterControlAltText="Filter display_name column" Visible="false"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="external_worker_id" HeaderText="external_worker_id" SortExpression="external_worker_id" UniqueName="external_worker_id" FilterControlAltText="Filter external_worker_id column" Visible="false"></telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="email" HeaderText="email" SortExpression="email" UniqueName="email" FilterControlAltText="Filter email column" Visible="false"></telerik:GridBoundColumn>





                                </Columns>

                                <NoRecordsTemplate>
                                <br />
                                <div class="col-md-12">
                                    <div class="alert alert-warning" role="alert"><strong>There are no Payments to Approve.</strong>  Go to <a href="/Reports/BARetcReports/PayrollExport">Payroll Extract</a> to select approved payments.</div>
                                </div>
                            </NoRecordsTemplate>

                            </MasterTableView>

                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true"></ExportSettings>

                        </telerik:RadGrid>
                    </div>
                </div>
            </asp:Panel>



            <asp:Panel runat="server" ID="ProcessPanel" Visible="false">

                <div class="row">
                    <div class="col-sm-12">
                    <p>Add the name of your payroll below. Click 'Continue' to create your payroll file.</p>
                    </div>
                </div>

                <div class="row">

                    <div class="col-sm-12">

                        <div style="padding: 5px 5px 15px;">
                            <div class="btn-group pull-right" role="group" aria-label="...">

                                <a href="/Reports/BARetcReports/PayrollDashboard" class="btn btn-default"><i class="fa fa-chevron-left" aria-hidden="true"></i> Return to Payroll Dashboard</a>

                            </div>
                        </div>

                    </div>

                </div>
                <hr />

                    <div class="row">

                        <div class="col-md-12">

                            <h3>Payroll Period</h3>

                            </div>
                        </div>



                            <div class="form-horizontal">

                                <div class="form-group">
                                    <label for="payrollName" class="col-sm-2 control-label">Payroll Name: <span class="text-danger">*</span></label>
                                    <div class="col-sm-3">
                                        <asp:TextBox ID="txtPayrollName" runat="server" CssClass="form-control"></asp:TextBox>

                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="errorlabel" Display="Dynamic" ValidationGroup="payrolldate"
                                            ControlToValidate="txtPayrollName" ErrorMessage="Payroll Name is required"></asp:RequiredFieldValidator>

                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-3">
                                      <asp:Button ID="btnContinue" runat="server" Text="Continue" CssClass="btn btn-primary" ValidationGroup="payrolldate" />
                                    </div>
                                  </div>

                            </div>

            </asp:Panel>



            <asp:Panel runat="server" ID="FinalPanel" Visible="false">

                <div class="row">

                    <div class="col-md-12">

                        <div style="padding: 5px;">
                            <asp:Literal ID="successLabel" runat="server" />
                            <hr />
                        </div>

                    </div>

                </div>


                <div class="center">
                    <div class="row">

                        <div class="col-xs-6 col-sm-3"></div>

                        <div class="col-xs-6 col-sm-3">

                            <div class="buttonrow">
                                <asp:HyperLink ID="btnDownloadCSV" runat="server" CssClass="btn btn-warning btn-group-lg">Download Import CSV File</asp:HyperLink>
                                <%--<asp:Button ID="btnExportPayroll" runat="server" Text="Download EXCEL" CssClass="btn btn-warning btn-group-lg" />--%>
                            </div>

                            <div class="buttonrow">

                                <asp:Label Text="OR" runat="server" Font-Size="Larger" Font-Bold="true" />

                            </div>

                            <div class="buttonrow">

                                <asp:Button ID="btnViewExports" runat="server" Text="View Payroll History" CssClass="btn btn-success" PostBackUrl="~/Reports/BARetcReports/PayrollHistory.aspx" />

                            </div>

                        </div>

                        <div class="col-xs-6 col-sm-3">

                            <div class="buttonrow"></div>
                            <div class="buttonrow">
                                <a href="/Reports/BARetcReports/PayrollDashboard" class="btn btn-default"><i class="fa fa-chevron-left" aria-hidden="true"></i> Return to Payroll Dashboard</a>
                            </div>
                            <div class="buttonrow"></div>
                        </div>

                        <div class="col-xs-6 col-sm-3"></div>
                    </div>
                </div>
            </asp:Panel>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetApprovedPayments_toProcessByDate" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="fromRadDatePicker" PropertyName="SelectedDate" Name="start" Type="DateTime"></asp:ControlParameter>
                    <asp:ControlParameter ControlID="toRadDatePicker" PropertyName="SelectedDate" Name="end" Type="DateTime"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>


            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getApprovedPayroll" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="FullName" TableName="getApprovedPayments_toProcesses" Where="clientID == @clientID">
                <WhereParameters>
                    <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>

                </WhereParameters>
            </asp:LinqDataSource>



            <asp:SqlDataSource ID="getExpenses" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                SelectCommand="SELECT * FROM [qryViewExpensesForBillingSummary] WHERE ([RequirementID] = @RequirementID)">

                <SelectParameters>
                    <asp:SessionParameter SessionField="RequirementID" Name="RequirementID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>



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
