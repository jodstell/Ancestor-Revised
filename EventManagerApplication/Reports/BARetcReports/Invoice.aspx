<%@ Page Title="Invoice" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Invoice.aspx.vb" 
    Inherits="EventManagerApplication.Invoice" %>

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
            margin: 50px;
            padding: 25px;
            border: 1px solid #808080;
        }

        /*label {
            width: 125px;
        }*/
    </style>

    <script>
        function requestStart(sender, args) {

            if (args.get_eventTarget().indexOf("btnCreatePDF") > 0 ||

            args.get_eventTarget().indexOf("btnCreatePDF") > 0)

                args.set_enableAjax(false);

            if (args.get_eventTarget().indexOf("btnExportExcel") > 0 ||

                args.get_eventTarget().indexOf("btnExportExcel") > 0)

                args.set_enableAjax(false);
        }
    </script>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="requestStart">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>


    <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard - Reports</h2>
                <hr />
            </div>
        </div>

        <div class="row">
            <%-- <div class="col-md-2">
                <div class="widget stacked">
                    <uc1:SideMenuControl runat="server" id="SideMenuControl" />
                </div>

            </div>--%>


            <asp:Panel ID="Panel1" runat="server">
                <div class="col-md-12">

                    <asp:Label ID="lblerror" runat="server" ></asp:Label>

                    <!-- begin form -->

                    <div class="row">
                        <div class="col-md-6">
                            <div class="pull-left">
                                <asp:Button ID="BtnReturn1" runat="server" Text="Go to Dashboard" CssClass="btn btn-default" />

                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="pull-right">
                                <%--<asp:Button ID="Button1" runat="server" Text="Save as Draft" CssClass="btn btn-default" />
                        <asp:Button ID="btnView" runat="server" Text="Add Payments" CssClass="btn btn-default" />--%>

                                <div class="btn-group" role="group" aria-label="...">

                                <asp:Button ID="btnSaveChages" runat="server" Text="Save Changes" CssClass="btn btn-success" />

                                 <asp:LinkButton ID="BtnDeleteInvoice" runat="server" CssClass="btn btn-danger"
                                     OnClientClick="javascript:if(!confirm('This action will delete the invoice. Are you sure?')){return false;}">
                                     <i class="fa fa-trash"></i> Delete Invoice
                                     </asp:LinkButton>

                                <asp:Button ID="btnProcess2" runat="server" Text="Process Invoice" CssClass="btn btn-primary" />

                                <asp:LinkButton ID="btnCreatePDF" runat="server" CssClass="btn btn-default"><i class="fa fa-print"></i> Download PDF</asp:LinkButton>

                                     <asp:LinkButton ID="btnExportExcel" runat="server" CssClass="btn btn-default"><i class="fa fa-file-excel-o"></i> Export to Excel</asp:LinkButton>

                                </div>
                            </div>

                        </div>
                    </div>

                    <hr />

                    <asp:Panel ID="InvoicePanel" runat="server" CssClass="MyInvoiceView">
                        <div class="row">
                            <div class="col-md-12">

                                <div class="col-md-4">
                                    <div class="widget stacked1">
                                        <div class="widget-content1">

                                            <h3>Bill to:</h3>
                                            <hr />

                                            <asp:TextBox ID="BillToTextBox" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox>
                                            <br />

                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 pull-right">

                                    <img src="/images/BARetc.png" />

                                </div>

                            </div>
                        </div>




                        <div class="row">
                            <div class="col-md-12">

                                <div class="col-md-4">
                                    <div class="widget stacked">
                                        <div class="widget-content">
                                            <div class="form-horizontal">

                                                <div class="form-group">
                                                    <asp:Label ID="Date" runat="server" Text="Date" Font-Bold="true" class="col-sm-3 control-label"></asp:Label>

                                                    <div class="col-sm-3">
                                                        <telerik:RadDatePicker ID="DatePicker" runat="server" Culture="en-US">
                                                            <DateInput runat="server" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%"></DateInput>
                                                            <Calendar runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle CssClass="rcToday" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                        </telerik:RadDatePicker>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label ID="InvoiceLabel" runat="server" Text="Invoice #" Font-Bold="true" class="col-sm-3 control-label"></asp:Label>

                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="InvoiceTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label ID="TermsLabel" runat="server" Text="Terms" Font-Bold="true" class="col-sm-3 control-label"></asp:Label>

                                                    <div class="col-sm-6">
                                                        <%--<asp:DropDownList ID="TermsDropDownList" runat="server" CssClass="form-control">
                                                            <asp:ListItem Text="Upon Receipt"></asp:ListItem>
                                                            <asp:ListItem Text="In 14 days"></asp:ListItem>
                                                            <asp:ListItem Text="In 21 days"></asp:ListItem>
                                                        </asp:DropDownList>--%>
                                                        <asp:TextBox ID="TermsTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label ID="PoLabel" runat="server" Text="PO" Font-Bold="true" class="col-sm-3 control-label"></asp:Label>

                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="POTextBox" runat="server" CssClass="form-control" Text=""></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label ID="FeeLabel" runat="server" Text="Late Fee" Font-Bold="true" class="col-sm-3 control-label"></asp:Label>

                                                    <div class="col-sm-6">
                                                        <asp:TextBox ID="LateFeeTextBox" runat="server" CssClass="form-control" Text="5% after 30 days"></asp:TextBox>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="col-md-7 pull-right">
                                    <div class="widget stacked">
                                        <div class="widget-content">

                                            <h3 style="text-align: center;">Please remit payment for all invoices to:</h3>
                                            <hr />

                                            <div class="row">
                                                <div class="col-md-6 center">
                                                    <asp:Label ID="Label5" runat="server" Text="First Republic Bank"></asp:Label><br />
                                                    <asp:Label ID="Label6" runat="server" Text="CapFlow Funding Group Managers, LLC"></asp:Label><br />
                                                    <asp:Label ID="Label7" runat="server" Text="for the account of BARetc LLC"></asp:Label><br />
                                                    <asp:Label ID="Label8" runat="server" Text="Routing # 321081669"></asp:Label><br />
                                                    <asp:Label ID="Label9" runat="server" Text="Account # 80000377656"></asp:Label><br />
                                                </div>


                                                <div class="col-md-6 center">
                                                    <br />
                                                    BARetc LLC<br />
                                                    DEPT CH 16642<br />
                                                    PALATINE, IL 60055-6642<br />

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- End Column -->

                            </div>
                        </div>
                        <!-- End Row -->




                        <div class="row">
                            <div class="col-md-12">





                                <telerik:RadGrid ID="InvoiceGrid" runat="server" CellSpacing="-1" DataSourceID="getInvoiceItems" ShowFooter="true">
                                    <MasterTableView DataKeyNames="eventID" DataSourceID="getInvoiceItems" AutoGenerateColumns="False" EnableHierarchyExpandAll="true" AllowMultiColumnSorting="True">



                                        <DetailTables>
                                            <telerik:GridTableView EnableHierarchyExpandAll="true" DataKeyNames="RequirementID" DataSourceID="getPayrolSummary" Width="100%"
                                                runat="server" AutoGenerateColumns="False" ShowFooter="false">

                                                <ParentTableRelation>

                                                    <telerik:GridRelationFields DetailKeyField="eventID" MasterKeyField="eventID"></telerik:GridRelationFields>

                                                </ParentTableRelation>

                                                <DetailTables>
                                                    <telerik:GridTableView EnableHierarchyExpandAll="true" DataKeyNames="eventID,RequirementID" DataSourceID="getExpenses" Width="100%"
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

                                                <Columns>

                                                    <telerik:GridBoundColumn SortExpression="FullName" HeaderText="Ambassador" HeaderButtonType="TextButton"
                                                        DataField="FullName" UniqueName="FullName">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn SortExpression="positionTitle" HeaderText="Position" HeaderButtonType="TextButton"
                                                        DataField="positionTitle" UniqueName="positionTitle">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn SortExpression="hours" HeaderText="Hours" HeaderButtonType="TextButton"
                                                        DataField="hours" UniqueName="hours">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="billingRate" ReadOnly="True" HeaderText="Billing Rate" SortExpression="billingRate" UniqueName="billingRate" DataType="System.Double" DataFormatString="{0:C}" FilterControlAltText="Filter billingRate column"></telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn SortExpression="Bonus" HeaderText="Bonus" HeaderButtonType="TextButton"
                                                        DataField="Bonus" UniqueName="Bonus" DataType="System.Double" DataFormatString="{0:C}">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn SortExpression="Parking" HeaderText="Parking/Misc" HeaderButtonType="TextButton"
                                                        DataField="Parking" UniqueName="Parking" DataType="System.Double" DataFormatString="{0:C}">
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn SortExpression="Sampling" HeaderText="Sampling" HeaderButtonType="TextButton"
                                                        DataField="Sampling" UniqueName="Sampling" DataType="System.Double" DataFormatString="{0:C}">
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn DataField="TotalBillableLabor" ReadOnly="True" HeaderText="Total Labor" SortExpression="TotalBillableLabor" UniqueName="TotalBillableLabor" DataType="System.Double" DataFormatString="{0:C}" FilterControlAltText="Filter TotalBillableLabor column"></telerik:GridBoundColumn>

                                                    


                                                </Columns>
                                                <PagerStyle Position="TopAndBottom" />

                                            </telerik:GridTableView>
                                        </DetailTables>


                                        <Columns>

                                            <telerik:GridTemplateColumn UniqueName="ViewEvent">
                                                <ItemTemplate>
                                                    <a href='/Events/EventDetails?ID=<%# Eval("eventID")%>' class="btn btn-primary btn-xs" style="color: #fff" target="_blank">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="eventDate" HeaderText="Date" SortExpression="eventDate" UniqueName="eventDate" DataType="System.DateTime" DataFormatString="{0:d}" FilterControlAltText="Filter eventDate column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Location" ReadOnly="True" HeaderText="Market" SortExpression="Location" UniqueName="Location" FilterControlAltText="Filter Location column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="EventType" ReadOnly="True" HeaderText="Event Type" SortExpression="EventType" UniqueName="EventType" FilterControlAltText="Filter EventType column"></telerik:GridBoundColumn>





                                            <telerik:GridBoundColumn DataField="startTime" HeaderText="Start" SortExpression="startTime" UniqueName="startTime" DataType="System.DateTime" DataFormatString="{0:t}" FilterControlAltText="Filter startTime column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="EndTime" HeaderText="End" SortExpression="EndTime" UniqueName="EndTime" DataType="System.DateTime" DataFormatString="{0:t}" FilterControlAltText="Filter EndTime column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Suplier" ReadOnly="True" HeaderText="Suplier" SortExpression="Suplier" UniqueName="Suplier" FilterControlAltText="Filter Suplier column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Brands" ReadOnly="True" HeaderText="Brands" SortExpression="Brands" UniqueName="Brands" FilterControlAltText="Filter Brands column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Account" ReadOnly="True" HeaderText="Account" SortExpression="Account" UniqueName="Account" FilterControlAltText="Filter Account column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Hours" ReadOnly="True" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours" DataType="System.Double" FilterControlAltText="Filter Hours column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Bonus" ReadOnly="True" HeaderText="Bonus" SortExpression="Bonus" UniqueName="Bonus" DataType="System.Double" DataFormatString="{0:C}" Aggregate="Sum" FilterControlAltText="Filter Bonus column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Parking" ReadOnly="True" HeaderText="Parking/Misc" SortExpression="Parking" UniqueName="Parking" DataType="System.Double" DataFormatString="{0:C}" Aggregate="Sum" FilterControlAltText="Filter Parking column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Sampling" ReadOnly="True" HeaderText="Sampling" SortExpression="Sampling" UniqueName="Sampling" DataType="System.Double" DataFormatString="{0:C}" Aggregate="Sum" FilterControlAltText="Filter Sampling column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="TotalLabor" ReadOnly="True" HeaderText="Total Labor" SortExpression="TotalLabor" UniqueName="TotalLabor" DataType="System.Double" DataFormatString="{0:C}" Aggregate="Sum" FilterControlAltText="Filter TotalLabor column"></telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn UniqueName="ViewEvent" Visible="false">
                                                <ItemTemplate>
                                                    <a href='/Events/EventDetails?ID=<%# Eval("eventID")%>' class="btn btn-default btn-xs"  target="_blank">Remove</a>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>




                                <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False">
                                    <MasterTableView>
                                        <Columns>

                                            <telerik:GridBoundColumn DataField="eventID" ReadOnly="True" HeaderText="Event ID" SortExpression="eventID" UniqueName="eventID" FilterControlAltText="Filter eventID column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Budget/PO" ReadOnly="True" HeaderText="Budget/PO" SortExpression="Budget/PO" UniqueName="Budget/PO" FilterControlAltText="Filter Budget/PO column"></telerik:GridBoundColumn>

                  <telerik:GridBoundColumn DataField="Wholesaler" ReadOnly="True" HeaderText="Wholesaler" SortExpression="Wholesaler" UniqueName="Wholesaler" FilterControlAltText="Filter Wholesaler column"></telerik:GridBoundColumn>

                                                  <telerik:GridBoundColumn DataField="Requestor" ReadOnly="True" HeaderText="Requestor" SortExpression="Requestor" UniqueName="Requestor" FilterControlAltText="Filter Requestor column"></telerik:GridBoundColumn>

<telerik:GridBoundColumn DataField="Location" ReadOnly="True" HeaderText="Market" SortExpression="Location" UniqueName="Location" FilterControlAltText="Filter Location column"></telerik:GridBoundColumn>


<telerik:GridBoundColumn DataField="EventType" ReadOnly="True" HeaderText="Event Type" SortExpression="EventType" UniqueName="EventType" FilterControlAltText="Filter EventType column"></telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="eventDate" HeaderText="Date" SortExpression="eventDate" UniqueName="eventDate" DataType="System.DateTime" DataFormatString="{0:d}" FilterControlAltText="Filter eventDate column"></telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="startTime" HeaderText="Start" SortExpression="startTime" UniqueName="startTime" DataType="System.String" FilterControlAltText="Filter startTime column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="EndTime" HeaderText="End" SortExpression="EndTime" UniqueName="EndTime" DataType="System.String" FilterControlAltText="Filter EndTime column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Suplier" ReadOnly="True" HeaderText="Suplier" SortExpression="Suplier" UniqueName="Suplier" FilterControlAltText="Filter Suplier column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Brands" ReadOnly="True" HeaderText="Brands" SortExpression="Brands" UniqueName="Brands" FilterControlAltText="Filter Brands column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Account" ReadOnly="True" HeaderText="Account" SortExpression="Account" UniqueName="Account" FilterControlAltText="Filter Account column"></telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="Address" ReadOnly="True" HeaderText="Address" SortExpression="Address" UniqueName="Address" FilterControlAltText="Filter Address column"></telerik:GridBoundColumn>
                                            
                                            <telerik:GridBoundColumn DataField="City" ReadOnly="True" HeaderText="City" SortExpression="City" UniqueName="City" FilterControlAltText="Filter City column"></telerik:GridBoundColumn>

                                            
                                      <telerik:GridBoundColumn DataField="State" ReadOnly="True" HeaderText="State" SortExpression="State" UniqueName="State" FilterControlAltText="Filter State column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Hours" ReadOnly="True" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours" DataType="System.Double" FilterControlAltText="Filter Hours column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Bonus" ReadOnly="True" HeaderText="Bonus" SortExpression="Bonus" UniqueName="Bonus" DataType="System.Double" DataFormatString="{0:C}" Aggregate="Sum" FilterControlAltText="Filter Bonus column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Parking" ReadOnly="True" HeaderText="Parking/Misc" SortExpression="Parking" UniqueName="Parking" DataType="System.Double" DataFormatString="{0:C}" Aggregate="Sum" FilterControlAltText="Filter Parking column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Sampling" ReadOnly="True" HeaderText="Sampling" SortExpression="Sampling" UniqueName="Sampling" DataType="System.Double" DataFormatString="{0:C}" Aggregate="Sum" FilterControlAltText="Filter Sampling column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Labor" ReadOnly="True" HeaderText="Labor" SortExpression="Labor" UniqueName="Labor" DataType="System.Double" DataFormatString="{0:C}" Aggregate="Sum" FilterControlAltText="Filter Labor column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Total" ReadOnly="True" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataType="System.Double" DataFormatString="{0:C}" Aggregate="Sum" FilterControlAltText="Filter Total column"></telerik:GridBoundColumn>

                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>

                                <asp:SqlDataSource runat="server" ID="getInvoiceItems" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getInvoiceItems" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:QueryStringParameter QueryStringField="ID" Name="invoiceID" Type="Int32"></asp:QueryStringParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource runat="server" ID="getPayrolSummary" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="ViewBillingSummaryByEvent" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter SessionField="eventID" Name="eventID" Type="Int32"></asp:SessionParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="getExpenses" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                    SelectCommand="SELECT * FROM [qryViewExpensesForBillingSummary] WHERE ([RequirementID] = @RequirementID)">

                                    <SelectParameters>
                                        <asp:SessionParameter SessionField="RequirementID" Name="RequirementID" Type="Int32"></asp:SessionParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>


                            </div>
                        </div>

                        <div class="row">



                            <div class="col-md-6">
                                 <asp:Button ID="btnAddEvent" runat="server" Text="+ Add Event" CssClass="btn btn-xs btn-success" Visible="false" />
                            </div>




                            <div class="col-md-6">

                                <table class="table table-bordered pull-right" style="width: 300px; margin-top: 20px;">
                                    <tr>
                                        <td>Sub Total</td>
                                        <td>
                                            <asp:Label ID="SubTotalLabel" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td>Agency Fee
                                        <asp:Label ID="AgencyFeeLabel" runat="server" /></td>
                                        <td>
                                            <asp:Label ID="AgencyFeeTotalLabel" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td>Total Due</td>
                                        <td>
                                            <asp:Label ID="TotalLabel" runat="server" Font-Bold="true" /></td>
                                    </tr>
                                </table>

                            </div>
                        </div>



                        <div class="row">
                            <div class="col-md-12">


                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <asp:Label ID="Label10" runat="server" Text="Terms" Font-Bold="true" class="col-sm-1 control-label"></asp:Label>

                                        <div class="col-sm-9">
                                            <asp:TextBox ID="AdditionalTermsTextBox" runat="server" CssClass="form-control" Text="" TextMode="MultiLine" Rows="6"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </asp:Panel>
                    <!-- end -->

                    <hr />

                    <div class="row">
                        <div class="col-md-6">
                            <div class="pull-left">
                                <asp:Button ID="btnReturn" runat="server" Text="Go to Dashboard" CssClass="btn btn-default" PostBackUrl="/Reports/BARetcReports/Invoicing?LoadState=Yes" />

                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="pull-right">
                                <%--<asp:Button ID="Button1" runat="server" Text="Save as Draft" CssClass="btn btn-default" />
                        <asp:Button ID="btnView" runat="server" Text="Add Payments" CssClass="btn btn-default" />--%>

                                <asp:Button ID="btnProcess" runat="server" Text="Process Invoice" CssClass="btn btn-primary" />


                                <%--<telerik:RadButton ID="btnDownLoad" RenderMode="Lightweight" runat="server" Skin="Bootstrap" Text="Download PDF"
                                    AutoPostBack="false" UseSubmitBehavior="false">
                                </telerik:RadButton>--%>
                            </div>

                        </div>
                    </div>


                    <%--<hr />

                <h3>History</h3>--%>
                </div>
            </asp:Panel>
        </div>

    </div>

    <telerik:RadWindowManager runat="server" ID="RadWindowManager1">

        <Windows>

            <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" NavigateUrl="/PhotoGallery.aspx" Skin="Bootstrap"
                Width="675px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                Modal="true">
            </telerik:RadWindow>

        </Windows>

    </telerik:RadWindowManager>


    <telerik:RadClientExportManager runat="server" ID="RadClientExportManager1"></telerik:RadClientExportManager>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script>
            var $ = $telerik.$;

            function exportPDF() {
                $find('<%=RadClientExportManager1.ClientID%>').exportPDF($(".MyInvoiceView"));
            }

        </script>
    </telerik:RadScriptBlock>

</asp:Content>
