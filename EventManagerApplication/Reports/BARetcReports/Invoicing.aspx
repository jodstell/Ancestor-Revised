<%@ Page Title="Invoices" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Invoicing.aspx.vb"
    Inherits="EventManagerApplication.Invoicing" %>

<%@ Register Src="~/Reports/UserControls/SideMenuControl.ascx" TagPrefix="uc1" TagName="SideMenuControl" %>

<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .RadComboBox_Bootstrap .rcbInner {
            margin-top: 5px;
        }
    </style>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="MainPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

     <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="InvoiceList" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>

    <asp:Panel ID="MainPanel" runat="server">

        <asp:HiddenField ID="hiddenUserID" runat="server" />
        <asp:HiddenField ID="hiddenClientID" runat="server" />

        <div class="container min-height">
            <div class="row">
                <div class="col-xs-12">
                    <h2>Reporting Dashboard - Reports</h2>
                    <hr />
                </div>
            </div>

            <div class="row">
                <div class="col-md-2">
                    <div class="widget stacked">
                        <uc1:SideMenuControl runat="server" ID="SideMenuControl" />
                    </div>

                </div>

                <div class="col-md-10">
                    <div class="row">
                        <div class="col-md-6">
                            <h3>
                                <asp:Label ID="SelectedSupplierLabel" runat="server" Text="Invoices"></asp:Label></h3>

                        </div>


                        <div class="col-md-6 pull-right">
                            <div class="pull-right">
                                <%--<span><b>Open Invoices</b></span> <span style="font-size:24px">$23,025.00</span><br />--%>
                            </div>


                        </div>

                    </div>







                    <div class="row">
                        <div class="col-md-6">
                            <span style="font-size: 20px">
                                <asp:Label ID="selectedDateLabel" runat="server"></asp:Label></span>

                        </div>


                        <div class="col-md-6 pull-right">
                            <div class="pull-right">
                                <a href="CreateInvoice.aspx" class="btn btn-success"><i class="fa fa-plus" aria-hidden="true"></i> Create Invoices</a>

                            </div>


                        </div>

                    </div>





                    <p style="font-size: 12px;">
                        <asp:Label ID="DateRangeLabel" runat="server" Font-Bold="true" />
                    </p>

                    <div class="widget-content-sidebar sidemenu" style="padding: 15px 5px 15px;">

                        <telerik:RadComboBox RenderMode="Lightweight" ID="SelectedSupplier" runat="server"
                            Label="Supplier:" EmptyMessage="Select Supplier"
                            Height="200px" Width="275px" DataSourceID="GetSupplierList" DataValueField="supplierID" DataTextField="supplierName" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="All Suppliers" Value="0" />
                            </Items>
                        </telerik:RadComboBox>

                        <asp:SqlDataSource runat="server" ID="GetSupplierList" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetSuppliersByUserIDandClientID" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hiddenUserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                                <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>


                            </SelectParameters>
                        </asp:SqlDataSource>



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
                            <DateInput DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%">
                            </DateInput>
                            <Calendar runat="server">
                                <SpecialDays>
                                    <telerik:RadCalendarDay Repeatable="Today">
                                        <ItemStyle CssClass="rcToday" />
                                    </telerik:RadCalendarDay>
                                </SpecialDays>
                            </Calendar>
                        </telerik:RadDatePicker>


                        <telerik:RadComboBox RenderMode="Lightweight" ID="SelectStatus" runat="server"
                            Label="Status:"
                            Height="200px" Width="200px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="All Statuses" Value="0" />
                                <telerik:RadComboBoxItem Text="Draft" Value="Draft" />
                                <telerik:RadComboBoxItem Text="Sent" Value="Sent" />
                                <telerik:RadComboBoxItem Text="Overdue" Value="Overdue" />
                                <telerik:RadComboBoxItem Text="Cancelled" Value="Cancelled" />
                                <telerik:RadComboBoxItem Text="Paid" Value="Paid" />
                            </Items>
                        </telerik:RadComboBox>

                        <asp:Button ID="btnChangeDateRange" runat="server" Text="Filter" CssClass="btn btn-default b1" />


                    </div>

                    <asp:Panel ID="NoDataPanel" runat="server" Visible="false">

                        <div runat="server" id="DefaultMessage" class="alert alert-info" role="alert">Select a supplier and date range above.</div>

                        <asp:Label ID="NoResultLabel" runat="server" />

                    </asp:Panel>



                    <telerik:RadGrid ID="InvoiceList" runat="server" DataSourceID="GetInvoiceListbyDate" AllowPaging="True"
                        AllowSorting="True"
                        ShowFooter="True"
                        ShowStatusBar="true"
                        AllowFilteringByColumn="True"
                        PageSize="20" CellSpacing="-1"
                        FilterType="HeaderContext"
                        EnableHeaderContextMenu="true"
                        EnableHeaderContextFilterMenu="true">

                        <ExportSettings IgnorePaging="true" OpenInNewWindow="true"></ExportSettings>
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="invoiceID" CommandItemDisplay="Top" AllowSorting="true">


                            <NoRecordsTemplate>

                                <br />
                                <div class="col-md-12">
                                    <div class="alert alert-warning" role="alert">
                                        <strong>No Invoices Found.</strong>  Please adjust your filter options.
                                        <br />
                                        <br />
                                        <a href="CreateInvoice.aspx" class="btn btn-default"><i class="fa fa-plus" aria-hidden="true"></i> Click here to Create Invoice</a>
                                        <br />

                                    </div>
                                </div>

                            </NoRecordsTemplate>

                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>

                            <CommandItemTemplate>
                                <div style="padding: 3px 0 3px 5px"></div>
                            </CommandItemTemplate>


                            <Columns>

                                <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewButton">
                                    <ItemStyle Width="40px" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnView" runat="server" CommandArgument='<%# Eval("invoiceID")%>' CommandName="ViewInvoice" ForeColor="white" CssClass="btn btn-primary btn-xs">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>

                                       <br />
                                        <%-- <asp:Label ID="NotificationLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("labelText")%>' />--%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>


                                <telerik:GridBoundColumn DataField="billingInvoiceID" HeaderText="Invoice #" SortExpression="billingInvoiceID" UniqueName="billingInvoiceID" DataType="System.Int32" FilterControlAltText="Filter billingInvoiceID column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="Supplier" HeaderText="Supplier" SortExpression="Supplier" UniqueName="Supplier" FilterControlAltText="Filter Supplier column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="PO" HeaderText="PO #" SortExpression="PO" UniqueName="PO" FilterControlAltText="Filter PO column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="invoiceDate" HeaderText="Invoice Date" SortExpression="invoiceDate" UniqueName="invoiceDate" DataType="System.DateTime" FilterControlAltText="Filter invoiceDate column" DataFormatString="{0:d}"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="dueDate" HeaderText="Due Date" SortExpression="dueDate" UniqueName="dueDate" DataType="System.DateTime" FilterControlAltText="Filter dueDate column" DataFormatString="{0:d}"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="status" HeaderText="Status" SortExpression="status" UniqueName="status" FilterControlAltText="Filter status column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="amount" HeaderText="Amount" SortExpression="amount" UniqueName="amount" DataType="System.Decimal" FilterControlAltText="Filter amount column" DataFormatString="{0:C2}"></telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>

                        <PagerStyle Position="TopAndBottom" />

                    </telerik:RadGrid>


                    <asp:SqlDataSource ID="GetInvoiceListbyDate" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getInvoiceListByDate" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="SelectedSupplier" PropertyName="SelectedValue" Name="supplierID" Type="Int32"></asp:ControlParameter>
                            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                            <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" DbType="Date" Name="startDate"></asp:ControlParameter>
                            <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" DbType="Date" Name="endDate"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>


                </div>
            </div>
        </div>

    </asp:Panel>

</asp:Content>
