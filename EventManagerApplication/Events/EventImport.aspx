<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EventImport.aspx.vb" Inherits="EventManagerApplication.EventImport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="HiddenUserID" runat="server" />

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>
        </div>
    </div>

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <asp:Panel ID="Panel1" runat="server">
        <div class="container min-height">
            <div class="row">
                <div class="col-xs-12">

                    <h2>Import History</h2>

                    <asp:Button ID="btnGoBack" runat="server" Text="< Back To Import History List" CssClass="btn btn-default pull-right" PostBackUrl="/events/EventImportHistory" />

                    Supplier Name: <asp:Label ID="SupplierNameLabel" runat="server" Font-Bold="true" /><br />
                    File Name: <asp:HyperLink ID="FileNameHyperLink" runat="server"><asp:Label ID="FileNameLabel" runat="server" />.xlsx</asp:HyperLink>
                    <br />
                    
                </div>
            </div>

            <div class="row margintop20">
                <div class="col-xs-12">

                    <telerik:RadGrid ID="EventDataGrid" runat="server" DataSourceID="getEventsByUserID"
                            AllowPaging="True"
                            AllowSorting="True"
                            ShowFooter="True"
                            ShowStatusBar="true"
                            AllowFilteringByColumn="True"
                            PageSize="20" CellSpacing="-1"
                            FilterType="HeaderContext"
                            EnableHeaderContextMenu="true"
                            EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="EventDataGrid_FilterCheckListItemsRequested"
                            EnableLinqExpressions="False">

                            <ExportSettings IgnorePaging="true" OpenInNewWindow="true" ></ExportSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="eventID" CommandItemDisplay="Top" AllowSorting="true">

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
                                       
                                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ResetGrid" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                        <div class="pull-right" style="padding-right: 3px">

                                            <asp:LoginView ID="LoginView1" runat="server">
                                                <RoleGroups>
                                                    <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking, Accounting, Agency, Client">
                                                        <ContentTemplate>
                                                            <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                                                        </ContentTemplate>
                                                    </asp:RoleGroup>
                                                </RoleGroups>
                                            </asp:LoginView>
                                        </div>
                                </CommandItemTemplate>

                                <Columns>

                                    <telerik:GridTemplateColumn DataField="eventID" HeaderText="Event ID" SortExpression="eventID" UniqueName="eventID" DataType="System.Int32" FilterControlAltText="Filter eventID column"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                    <ItemTemplate>
                                                        <%# Eval("eventID") %> <a href="/events/eventdetails?ID=<%# Eval("eventID") %>" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
                                                        <br />
                                            <asp:Label ID="NotificationLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("labelText")%>' />
                                                    </ItemTemplate>
                                        <ItemStyle  Wrap="false"/>
                                        <HeaderStyle Wrap="false" />
                                                </telerik:GridTemplateColumn>

                                     <telerik:GridBoundColumn DataField="eventID" Visible="false"
                                        FilterControlAltText="Filter eventID column"
                                        HeaderText="Event ID"
                                        SortExpression="eventID" UniqueName="eventID1"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="supplierName"
                                        FilterControlAltText="Filter supplierName column"
                                        HeaderText="Supplier Name"
                                        SortExpression="supplierName" UniqueName="supplierName" FilterControlWidth="150px"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="175px"></HeaderStyle>
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

                                    <telerik:GridTemplateColumn AllowFiltering="true" ShowFilterIcon="false" CurrentFilterFunction="EqualTo"
                                        DataField="eventDate"
                                        UniqueName="eventDate"
                                        HeaderText="Date"
                                        SortExpression="eventDate">
                                        <ItemStyle  Wrap="false"/>
                                        <ItemTemplate>
                                            <%# Eval("eventDate", "{0:d}") %> <%# Eval("startTime", "{0:t}") %> - <%# Eval("endTime", "{0:t}") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridTemplateColumn DataField="statusName" FilterControlAltText="Filter statusName column"
                                        HeaderText="Status" SortExpression="statusName" UniqueName="statusName" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" GroupByExpression="statusName statusID Group By statusName">
                                        <ItemStyle Width="120px" />
                                        <ItemTemplate>
                                            <asp:Image ID="StatusImage" runat="server" ImageUrl='<%#Eval("iconURL") %>' Width="10px" Height="10px" style="margin-bottom: 2px;" />
                                            <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("statusName")%>' /><br />
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("RequestedLabel")%>' />
                                            </ItemTemplate>


                                    </telerik:GridTemplateColumn>

                                     <telerik:GridBoundColumn DataField="statusName" FilterControlAltText="Filter status column"
                                        HeaderText="Status" SortExpression="status" UniqueName="status" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true" Visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="marketName" FilterControlAltText="Filter marketName column"
                                        HeaderText="Market" SortExpression="marketName" UniqueName="marketName" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="eventTypeName" FilterControlAltText="Filter typeName column"
                                        HeaderText="Event Type" SortExpression="eventTypeName" UniqueName="eventTypeName" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="Location" AllowFiltering="true" UniqueName="accountName" DataField="accountName" SortExpression="accountName"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <ItemTemplate>
                                            <a href='/Accounts/AccountDetails?AccountID=<%# Eval("accountID")%>' style="color: cornflowerblue"><%# Eval("accountName")%></a><br />
                                            <%# Eval("address")%><br />
                                            <%# Eval("city")%>, <%# Eval("state")%>
                                        </ItemTemplate>
                                        <ItemStyle Width="160px" />
                                    </telerik:GridTemplateColumn>

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

                            </MasterTableView>

                            <PagerStyle Position="TopAndBottom" />


                        </telerik:RadGrid>

                            <asp:SqlDataSource ID="getEventsByUserID" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                            SelectCommand="getImportedEvents_ByImportID" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenUserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                                <asp:QueryStringParameter Name="importFileID" QueryStringField="ImportID" />
                               
                            </SelectParameters>
                        </asp:SqlDataSource>

                </div>
            </div>


        </div>

        

    </asp:Panel>
</asp:Content>
