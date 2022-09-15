<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ExportDemo.aspx.vb" Inherits="EventManagerApplication.ExportDemo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">

                    <!-- Date Filter -->
            <asp:Panel runat="server" ID="DatePanel">
            <div style="margin-bottom: 15px;">
                From:
                <telerik:RadDatePicker ID="FromDatePicker" runat="server">
                    <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>
                </telerik:RadDatePicker>
                To:
                <telerik:RadDatePicker ID="ToDatePicker" runat="server">
                    <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>
                </telerik:RadDatePicker>
                <asp:Button ID="btnChangeDateRange" runat="server" Text="Go" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Date Range" />


                 <div class="btn-group pull-right viewbuttons" role="group" aria-label="..." style="margin-right: 20px;">
                    <asp:Button ID="btnViewWeek" runat="server" Text="Week" CssClass="btn btn-success ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Current Week" />
                    <asp:Button ID="btnViewMonth" runat="server" Text="Month" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Current Month" />



                </div>

                </div>
            </asp:Panel>


            <div class="demo-container">
        <telerik:RadButton RenderMode="Lightweight" Text="Download" ID="Download" CssClass="downloadButton" OnClick="Download_Click" runat="server" />
        <br />
        <br />

<%--        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" GridLines="None"
            OnNeedDataSource="RadGrid1_NeedDataSource" AutoGenerateColumns="false" AllowPaging="true">
            <MasterTableView>
                <Columns>
                    <telerik:GridBoundColumn DataField="ProductID" HeaderText="#">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ProductName" HeaderText="Product Name"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UnitPrice" HeaderText="Unit Price">
                        <HeaderStyle HorizontalAlign="Right" />
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UnitsInStock" HeaderText="Units In Stock">
                        <HeaderStyle HorizontalAlign="Right" />
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SubTotal" HeaderText="Sub Total">
                        <HeaderStyle HorizontalAlign="Right" />
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>--%>

                <telerik:RadGrid ID="AssignmentsGrid" runat="server" AllowPaging="True" 
                            AllowSorting="True"
                            ShowFooter="True"
                            ShowStatusBar="true"
                            AllowFilteringByColumn="True"
                            PageSize="20" CellSpacing="-1"
                            FilterType="HeaderContext"
                            EnableHeaderContextMenu="true"
                            EnableHeaderContextFilterMenu="true"
                            EnableLinqExpressions="False">

                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ></ExportSettings>
                            <MasterTableView AutoGenerateColumns="False"  DataKeyNames="eventID" CommandItemDisplay="Top" AllowSorting="true">
                                <NoRecordsTemplate>

                                    <br />
                                    <div class="col-md-12">
                                        <div class="alert alert-warning" role="alert"><strong>No Events Found.</strong>  Please adjust your filter options.</div>
                                    </div>

                                </NoRecordsTemplate>

                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </RowIndicatorColumn>

                               <CommandItemTemplate>
                                    <div style="padding: 3px 0 3px 5px">

                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                        <div class="pull-right" style="padding-right: 3px">

                                        <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>

                                        </div>
                                </CommandItemTemplate>

                                <Columns>
                                    <telerik:GridTemplateColumn DataField="eventID" HeaderText="Event ID" SortExpression="eventID" UniqueName="eventID" DataType="System.Int32" FilterControlAltText="Filter eventID column"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                        <ItemTemplate>
                                            <%# Eval("eventID") %> <a href="/events/eventdetails?ID=<%# Eval("eventID") %>" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
                                        </ItemTemplate>
                                        <ItemStyle  Wrap="false"/>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="eventID" Visible="false"
                                        FilterControlAltText="Filter eventID column"
                                        HeaderText="Event ID"
                                        SortExpression="eventID" UniqueName="eventIDexcel"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                    </telerik:GridBoundColumn>

                                    
                                    <telerik:GridTemplateColumn DataField="AmbassadorName"
                                        FilterControlAltText="Filter AmbassadorName column"
                                        HeaderText="Ambassador Name"
                                        SortExpression="AmbassadorName" UniqueName="AmbassadorNameExcel"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" Visible="false" >
                                        <ItemTemplate>
                                            <%# Eval("AmbassadorName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="AmbassadorName"
                                        FilterControlAltText="Filter AmbassadorName column"
                                        HeaderText="Ambassador Email"
                                        SortExpression="AmbassadorName" UniqueName="AmbassadorEmailExcel"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" Visible="false" >
                                        <ItemTemplate>
                                            <%# Eval("EmailAddress") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridTemplateColumn DataField="AmbassadorName"
                                        FilterControlAltText="Filter AmbassadorName column"
                                        HeaderText="Ambassador Name"
                                        SortExpression="AmbassadorName" UniqueName="AmbassadorName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" >
                                        <ItemTemplate>
                                            <b><%# Eval("AmbassadorName") %></b>

                                            <asp:HyperLink ID="HyperLink1" Target="_blank" runat="server" Visible='<%# Eval("showBALink") %>'
                                                NavigateUrl='<%#"/ambassadors/ViewAmbassadorDetails?UserID=" & Eval("ID") %>'>  <i class="fa fa-external-link" aria-hidden="true"></i></asp:HyperLink>
                                            
                                            <br />
                                            <a href="mailTo:<%# Eval("EmailAddress") %>"><%# Eval("EmailAddress") %></a><br />
                                            <%# Eval("Phone") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Phone" Visible="false"
                                        FilterControlAltText="Filter Phone column"
                                        HeaderText="Phone"
                                        SortExpression="Phone" UniqueName="PhoneExcel"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false" 
                                        DataFormatString="{0:(###)###-####}" HtmlEncode="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                        <ItemStyle Wrap="false" />
                                        <HeaderStyle Wrap="false" />
                                    </telerik:GridBoundColumn>



                                    <telerik:GridBoundColumn DataField="supplierName"
                                        FilterControlAltText="Filter supplierName column"
                                        HeaderText="Supplier Name"
                                        SortExpression="supplierName" UniqueName="supplierName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Wrap="false" />
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="brands" FilterControlAltText="Filter brandName column"
                                        HeaderText="Brands" SortExpression="brands" UniqueName="brands"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn AllowFiltering="true" ShowFilterIcon="false" CurrentFilterFunction="EqualTo" Visible="false"
                                        DataField="eventDate"
                                        UniqueName="eventDate"
                                        HeaderText="Date"
                                        SortExpression="eventDate">
                                        <ItemStyle  Wrap="false"/>
                                        <ItemTemplate>
                                            <%# Eval("eventDate") %> <%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridBoundColumn DataField="shortEventDate" HeaderText="Date" SortExpression="shortEventDate" UniqueName="shortEventDate" DataType="System.String" FilterControlAltText="Filter shortEventDate column" FilterCheckListEnableLoadOnDemand="true">
                                        <ItemStyle Width="60px" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="shortStartTime" HeaderText="Start" SortExpression="shortStartTime" UniqueName="shortStartTime" DataType="System.String" FilterControlAltText="Filter shortStartTime column" CurrentFilterFunction="EqualTo" FilterCheckListEnableLoadOnDemand="true">
                                        <ItemStyle Width="70px" Wrap="false" />
                                    </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="shortEndTime" HeaderText="End" SortExpression="shortEndTime" UniqueName="shortEndTime" DataType="System.String" FilterControlAltText="Filter shortEndTime column" CurrentFilterFunction="EqualTo" FilterCheckListEnableLoadOnDemand="true">
                                                <ItemStyle Width="70px" Wrap="false" />
                                            </telerik:GridBoundColumn>


                                   <%-- <telerik:GridTemplateColumn HeaderText="Training" UniqueName="Training" >
                                        <ItemTemplate>

                                            <%# getTrainingResult(Eval("eventID"), Eval("UserID")) %>

                                        </ItemTemplate>
                                        <HeaderStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>--%>

                                    <%--<telerik:GridTemplateColumn HeaderText="Training" UniqueName="TrainingExcel" Visible="false">
                                        <ItemTemplate>

                                            <%# getTrainingResultNostyle(Eval("eventID"), Eval("UserID")) %>

                                        </ItemTemplate>
                                        <HeaderStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>--%>


                                    <telerik:GridBoundColumn DataField="checkInTime"
                                        FilterControlAltText="Filter checkInTime column"
                                        HeaderText="Check-In Time"
                                        SortExpression="checkInTime" UniqueName="checkInTime"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Wrap="false" />
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

<%--                                    <telerik:GridTemplateColumn HeaderText="POS" AllowFiltering="true" UniqueName="PosStatus" DataField="PosStatus" SortExpression="PosStatus"
                                        FilterCheckListEnableLoadOnDemand="false">
                                        <ItemTemplate>
                                            <%# Eval("PosStatus") %><br />

                                            <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" NavigateUrl='<%# getTracking(Eval("eventID")) %>' Visible='<%# Eval("showtrackingLink") %>'>Check Status <i class="fa fa-external-link" aria-hidden="true"></i></asp:HyperLink><br />
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("shippingAddress") %>' Visible='<%# Eval("showtrackingLink") %>' /><br />
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("shippingAddress2") %>' Visible='<%# Eval("showtrackingLink") %>' />

                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>

                                    <telerik:GridTemplateColumn HeaderText="POS" AllowFiltering="true" UniqueName="PosStatusExcel" DataField="PosStatus" SortExpression="PosStatus"
                                        FilterCheckListEnableLoadOnDemand="false" Visible="false">
                                        <ItemTemplate>
                                            <%# Eval("PosStatus") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                   <%-- <telerik:GridTemplateColumn HeaderText="Location" AllowFiltering="true" UniqueName="accountName" DataField="accountName" SortExpression="accountName"
                                        FilterCheckListEnableLoadOnDemand="false">
                                        <ItemTemplate>
                                            <a href='/Accounts/AccountDetails?AccountID=<%# getVpid(Eval("locationID"))%>' style="color: cornflowerblue"><%# getLocationName(Eval("locationID"))%></a><br />
                                            <%# getLocationAddress(Eval("locationID"))%>
                                        </ItemTemplate>
                                        <ItemStyle Width="160px" />
                                    </telerik:GridTemplateColumn>--%>


                                    <telerik:GridBoundColumn DataField="accountName" FilterControlAltText="Filter accountName1 column"
                                        HeaderText="Account Name" SortExpression="accountName1" UniqueName="accountName1" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" Visible="False">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                     </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="address" FilterControlAltText="Filter address column"
                                        HeaderText="Address" SortExpression="address" UniqueName="address" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" Visible="False">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                     </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="city" FilterControlAltText="Filter city column"
                                        HeaderText="City" SortExpression="city" UniqueName="city" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" Visible="False">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="state" FilterControlAltText="Filter state column"
                                        HeaderText="State" SortExpression="state" UniqueName="state" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" Visible="False">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    </Columns>

                                <PagerStyle Position="TopAndBottom" />

                            </MasterTableView>
                        </telerik:RadGrid>
    </div>

    </div>
</asp:Content>
