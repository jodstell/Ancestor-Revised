<%@ Page Title="Payroll Rejected" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="PayrollRejected.aspx.vb" Inherits="EventManagerApplication.PayrollRejected" %>
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


                    <h3>Rejected Payroll</h3>

                    <span style="font-size: 20px">
                        <asp:Label ID="selectedDateLabel" runat="server"></asp:Label></span>
                    <div class="row" style="margin-top:15px"></div>

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


                    <div style="padding: 15px 5px 15px;">

                        <strong>From:</strong>

                        <telerik:RadDatePicker ID="FromDatePicker" runat="server" Culture="en-US" SelectedDate="2016-03-01">
                            <DateInput runat="server" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%">
                            </DateInput>
                            <Calendar runat="server">
                                <SpecialDays>
                                    <telerik:RadCalendarDay Repeatable="Today">
                                        <ItemStyle CssClass="rcToday" />
                                    </telerik:RadCalendarDay>
                                </SpecialDays>
                            </Calendar>
                        </telerik:RadDatePicker>

                        <strong>To:</strong>
                        <telerik:RadDatePicker ID="ToDatePicker" runat="server" Culture="en-US" SelectedDate="2016-03-31">
                            <DateInput runat="server" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%">
                            </DateInput>
                            <Calendar runat="server">
                                <SpecialDays>
                                    <telerik:RadCalendarDay Repeatable="Today">
                                        <ItemStyle CssClass="rcToday" />
                                    </telerik:RadCalendarDay>
                                </SpecialDays>
                            </Calendar>
                        </telerik:RadDatePicker>

                        <asp:Button ID="btnChangeDateRange" runat="server" Text="Go" CssClass="btn btn-default" />

                        <%--<a id='filterbutton' class="filterbutton" href="#">Advanced Filter</a>--%>


                        <div class="btn-group pull-right" role="group" aria-label="...">

                            <a href="/Reports/BARetcReports/PayrollDashboard" class="btn btn-default"><i class="fa fa-chevron-left" aria-hidden="true"></i> Return to Payroll Dashboard</a>
                        </div>
                    </div>

                    


                    <telerik:RadGrid ID="PendingPaymentsRadGrid" runat="server" DataSourceID="getPayroll" Skin="Bootstrap"
                        AllowPaging="True" PageSize="50" AllowSorting="True" AllowFilteringByColumn="True" FilterType="HeaderContext" EnableHeaderContextMenu="true" AllowMultiRowSelection="true" CellSpacing="-1">

                        <ClientSettings EnableRowHoverStyle="True" EnablePostBackOnRowClick="True" AllowDragToGroup="True">
                        </ClientSettings>

                        <MasterTableView DataSourceID="getPayroll" DataKeyNames="RequirementID" AutoGenerateColumns="False" CommandItemDisplay="Top" EnableHierarchyExpandAll="true"
                            Font-Size="10">

                            <DetailTables>
                                <telerik:GridTableView EnableHierarchyExpandAll="true" DataKeyNames="RequirementID" DataSourceID="getExpenses" Width="100%"
                                    runat="server" AutoGenerateColumns="False" ShowFooter="false">

                                    <NoRecordsTemplate>

                                        <p style="padding-left: 15px">There are no expenses to display.</p>

                                    </NoRecordsTemplate>
                                    <ParentTableRelation>

                                        <telerik:GridRelationFields DetailKeyField="RequirementID" MasterKeyField="RequirementID"></telerik:GridRelationFields>

                                    </ParentTableRelation>

                                    <Columns>



                                        <telerik:GridTemplateColumn>
                                            <ItemTemplate>
                                                <asp:Label ID="btnViewReciept" runat="server" Text="View Receipt" CssClass="btn btn-sm btn-default" OnClick='<%#CreateReceiptScript(Eval("eventExpenseID"))%>' Visible='<%# Eval("enabled") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridBoundColumn DataField="expenseType" ReadOnly="True" HeaderText="Expense Type" SortExpression="expenseType" UniqueName="expenseType" FilterControlAltText="Filter expenseType column"></telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="description" ReadOnly="True" HeaderText="Description" SortExpression="Description" UniqueName="description" FilterControlAltText="Filter description column"></telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="amount" ReadOnly="True" HeaderText="Amount" SortExpression="amount" UniqueName="amount" FilterControlAltText="Filter amount column" DataType="System.Double" DataFormatString="{0:C}"></telerik:GridBoundColumn>
                                    </Columns>

                                </telerik:GridTableView>

                            </DetailTables>


                            <NoRecordsTemplate>
                                <br />
                                <div class="col-md-12">
                                    <div class="alert alert-warning" role="alert"><strong>There are no Pending Payments.</strong>  Please adjust your filter options.</div>
                                </div>
                            </NoRecordsTemplate>

                            <Columns>

                                <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1">
                                </telerik:GridClientSelectColumn>

                                <telerik:GridTemplateColumn AllowFiltering="false" ItemStyle-Wrap="false">
                                    <ItemStyle Width="40" />
                                    <ItemTemplate>
                                                    <a href='/Events/EventDetails?ID=<%# Eval("eventID")%>' class="btn btn-primary btn-xs" style="color: #fff" target="_blank">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>
                                                </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridBoundColumn DataField="RequirementID" HeaderText="RequirementID" SortExpression="RequirementID" UniqueName="RequirementID" FilterControlAltText="Filter RequirementID column" Visible="false"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="FullName" HeaderText="Ambassador Name" SortExpression="FullName" UniqueName="FullName" FilterControlAltText="Filter FullName column"></telerik:GridBoundColumn>

                                <telerik:GridTemplateColumn HeaderText="Event Date">
                                    <ItemTemplate>
                                        <%# Eval("eventDate", "{0:d}") %><br />
                                        <span style="font-size: smaller"><%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridBoundColumn DataField="supplierName" HeaderText="Supplier Name" SortExpression="supplierName" UniqueName="supplierName" FilterControlAltText="Filter supplierName column"></telerik:GridBoundColumn>



                                <telerik:GridTemplateColumn HeaderText="Event Location">
                                    <ItemTemplate>
                                        <%# Eval("accountName") %><br />
                                        <%-- <%# Eval("streetAddress1") %><br />
                                                                <%# Eval("city") %>, <%# Eval("state") %>--%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>



                                <telerik:GridBoundColumn DataField="hours" HeaderText="Hours" SortExpression="hours" UniqueName="hours" FilterControlAltText="Filter hours column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="rate" HeaderText="Rate" SortExpression="rate" UniqueName="rate" FilterControlAltText="Filter rate column" DataFormatString="{0:c}"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="bonus" HeaderText="Bonus" SortExpression="bonus" UniqueName="bonus" DataType="System.Decimal" FilterControlAltText="Filter bonus column" DataFormatString="{0:c}"></telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="labor" HeaderText="Labor" SortExpression="labor" UniqueName="labor" DataType="System.Decimal" FilterControlAltText="Filter labor column" DataFormatString="{0:c}"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="expenses" HeaderText="Expenses" SortExpression="expenses" UniqueName="expenses" FilterControlAltText="Filter expenses column" DataFormatString="{0:c}"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" FilterControlAltText="Filter Total column" DataFormatString="{0:c}"></telerik:GridBoundColumn>


                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 3px 0 3px 5px">

                                    <div class="btn-group" role="group" aria-label="...">
                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-sm btn-success" CommandName="Approve" CommandArgument='<%# Eval("RequirementID") %>' ForeColor="White"><i class="fa fa-check-square" aria-hidden="true"></i> Approve Selected</asp:LinkButton>

                                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-sm btn-danger" CommandName="Reject" ForeColor="White"><i class="fa fa-times-circle" aria-hidden="true"></i> Deny Selected</asp:LinkButton>

                                    </div>

                                    <div class="pull-right" style="padding-right: 3px">
                                        <asp:LinkButton Visible="false" ID="btnExport" runat="server" CommandName="ExportToCSV" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export to Excel</asp:LinkButton>
                                    </div>
                                </div>
                            </CommandItemTemplate>




                        </MasterTableView>

                        <PagerStyle Position="TopAndBottom" />

                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">

                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />

                        </ClientSettings>

                    </telerik:RadGrid>

                    <telerik:RadGrid ID="ApprovedPaymentsRadGrid" runat="server" CellSpacing="-1" DataSourceID="getApprovedPayroll" Skin="Bootstrap" RenderMode="Lightweight"
                        AllowPaging="True" PageSize="50" AllowSorting="True" AllowFilteringByColumn="True" FilterType="HeaderContext" EnableHeaderContextMenu="true" AllowMultiRowSelection="true" Visible="false">
                        <MasterTableView DataSourceID="getApprovedPayroll" AutoGenerateColumns="False">
                            <Columns>
                                <telerik:GridBoundColumn DataField="FullName" HeaderText="FullName" SortExpression="FullName" UniqueName="FullName" FilterControlAltText="Filter FullName column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Hours" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours" DataType="System.Int32" FilterControlAltText="Filter Hours column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Labor" HeaderText="Labor" SortExpression="Labor" UniqueName="Labor" DataType="System.Decimal" DataFormatString="{0:C}" FilterControlAltText="Filter Labor column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Expenses" HeaderText="Expenses" SortExpression="Expenses" UniqueName="Expenses" DataFormatString="{0:C}" DataType="System.Decimal" FilterControlAltText="Filter Expenses column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Bonus" HeaderText="Bonus" SortExpression="Bonus" UniqueName="Bonus" DataType="System.Decimal" DataFormatString="{0:C}" FilterControlAltText="Filter Bonus column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataType="System.Decimal" DataFormatString="{0:C}" FilterControlAltText="Filter Total column"></telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getApprovedPayroll" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="FullName" TableName="getApprovedPayments_toProcesses" Where="paymentID == @paymentID">
                        <WhereParameters>
                            <asp:SessionParameter SessionField="PaymentID" Name="paymentID" Type="Int32"></asp:SessionParameter>

                        </WhereParameters>
                    </asp:LinqDataSource>
                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getPayroll" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryViewRejectedPayments" OrderBy="FullName" Where="eventDate >= @eventDate && eventDate <= @eventDate1 && clientID == @clientID">
                        <WhereParameters>
                            <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="eventDate" Type="DateTime"></asp:ControlParameter>
                            <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="eventDate1" Type="DateTime"></asp:ControlParameter>
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

