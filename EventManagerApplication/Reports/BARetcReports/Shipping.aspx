<%@ Page Title="Shipping Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Shipping.aspx.vb" Inherits="EventManagerApplication.Shipping" %>
<%@ Register Src="~/Reports/UserControls/SideMenuControl.ascx" TagPrefix="uc1" TagName="SideMenuControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <style>
        .table {
            margin-bottom: 0px;
        }
    </style>

    <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard - Reports</h2>
                
                <asp:Panel ID="BreadCrumbPanel" runat="server">
                    <ol class="breadcrumb">
                        <li><i class="fa fa-home" aria-hidden="true"></i>&nbsp;<a href="/">Dashboard</a></li>
                        <li>
                            <asp:HyperLink ID="ReturnLink1" runat="server" NavigateUrl="/Reports/Dashboard">Reports</asp:HyperLink></li>
                        <li class="active">Shipping</li>
                    </ol>
                </asp:Panel>

            </div>
        </div>

        <div class="row">
            

            <div class="col-md-12">

                

                 <h3>Shipping</h3>
                <span style="font-size:20px"><asp:Label ID="selectedDateLabel" runat="server"></asp:Label></span>

                  <p style="font-size: 12px;">
                    <asp:Label ID="DateRangeLabel" runat="server" Font-Bold="true" /></p>

                <div class="widget-content-sidebar sidemenu" style="padding: 15px 5px 15px;">

                <strong> From:</strong>

                <telerik:RadDatePicker ID="FromDatePicker" runat="server">
                    <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>
                </telerik:RadDatePicker>

                <strong> To:</strong>
                 <telerik:RadDatePicker ID="ToDatePicker" runat="server">
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
                    <%--<asp:Button ID="btnViewWeek" runat="server" Text="Week" CssClass="btn btn-success" />
                    <asp:Button ID="btnViewMonth" runat="server" Text="Month" CssClass="btn btn-default" />--%>
                </div>
            </div>

               <%-- <asp:Panel ID="MainPanel" runat="server">

                    <div runat="server" id="DefaultMessage" class="alert alert-info" role="alert">Select a report and date range above.</div>

                    <asp:Label ID="NoResultLabel" runat="server" />

                </asp:Panel>--%>
 

            
                <div class="row">

                <div class="col-md-12">

                                  



                                <telerik:RadGrid ID="ShippingCostsGrid" runat="server" DataSourceID="GetShippingCosts"
                                    AllowPaging="True"
                                    AllowSorting="True"
                                    ShowFooter="True"
                                    ShowStatusBar="true"
                                    AllowFilteringByColumn="True"
                                    PageSize="20" CellSpacing="-1"
                                    FilterType="HeaderContext"
                                    EnableHeaderContextMenu="true"
                                    EnableHeaderContextFilterMenu="true">
                                    <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ></ExportSettings>
                                    <MasterTableView DataKeyNames="kitID" DataSourceID="GetShippingCosts" AutoGenerateColumns="False" CommandItemDisplay="Top" AllowSorting="true">
                                      
                                        <NoRecordsTemplate>

                                    <br />
                                    <div class="col-md-12">
                                        <div class="alert alert-warning" role="alert"><strong>No items found.</strong>  Please adjust your filter options.</div>
                                    </div>

                                </NoRecordsTemplate>

                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </RowIndicatorColumn>

                                        <CommandItemTemplate>
                                    <div style="padding: 3px 0 3px 5px">
                                        
                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ResetGrid" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                        <div class="pull-right" style="padding-right: 3px">

                                    <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                                                        
                                        </div>
                                </CommandItemTemplate>

                                        <Columns>
                                            
                                            <telerik:GridBoundColumn DataField="shipTo" HeaderText="Recipient" SortExpression="shipTo" UniqueName="shipTo" FilterControlAltText="Filter shipTo column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ShippingVendorName" HeaderText="Shipping Vendor Name" SortExpression="ShippingVendorName" UniqueName="ShippingVendorName" FilterControlAltText="Filter ShippingVendorName column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="shippingCity" HeaderText="City" SortExpression="shippingCity" UniqueName="shippingCity" FilterControlAltText="Filter shippingCity column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="shippingState" HeaderText="State" SortExpression="shippingState" UniqueName="shippingState" FilterControlAltText="Filter shippingState column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="supplierName" HeaderText="Reference
                                                Name" SortExpression="supplierName" UniqueName="supplierName" FilterControlAltText="Filter supplierName column"></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="shippingCost" HeaderText="Shipping" SortExpression="shippingCost" UniqueName="shippingCost" DataType="System.Decimal" FilterControlAltText="Filter shippingCost column" DataFormatString="{0:c}" ></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="handlingFee" HeaderText="Fulfilment" SortExpression="handlingFee" UniqueName="handlingFee" DataType="System.Decimal" FilterControlAltText="Filter handlingFee column" DataFormatString="{0:c}" ></telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Total" ReadOnly="True" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataType="System.Decimal" FilterControlAltText="Filter Total column" DataFormatString="{0:c}" ></telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>

                                    <PagerStyle Position="TopAndBottom" />

                                </telerik:RadGrid>





                                <asp:SqlDataSource runat="server" ID="GetShippingCosts" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getShippingCosts" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="fromDate" Type="DateTime"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="toDate" Type="DateTime"></asp:ControlParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                                       
                    

                    </div>



                <div class="row">
                    <div class="col-md-12">

                   
</div>
                  
                </div>



               



        </div>
     </div>
    </div>

</asp:Content>
