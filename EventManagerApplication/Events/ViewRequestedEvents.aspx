<%@ Page Title="View Requested Events" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewRequestedEvents.aspx.vb" Inherits="EventManagerApplication.ViewRequestedEvents" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

</telerik:RadAjaxManager>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <asp:Panel ID="Panel1" runat="server">

        <div class="container">
            <div class="row">
                <div class="col-md-12">

                    <h2>Requested Events</h2>

                    <ol class="breadcrumb">
                      <li><i class="fa fa-home" aria-hidden="true"></i><a href="/"> Dashboard</a></li>
                      <li><asp:HyperLink ID="ReturnLink1" runat="server" NavigateUrl="/Events/ViewEvents">Events</asp:HyperLink></li>
                      <li class="active">Requested Events</li>
                    </ol>

                </div>
            </div>
        </div>



        <%--The Requested events grid--%>
        <asp:Panel ID="GridPanel" runat="server" CssClass="GridPanelCss">
          <div class="container">
            <div class="row">
                <div class="col-md-12">


                                    <div style="margin-bottom:8px;">
                                        <p>Select each event that you want to approve and click on the 'Approve Selected Events' button, or click the 'View' button to approve each event individually.   <asp:Label ID="topMsgLabel" runat="server" ForeColor="red" Font-Bold="true"  /></p>
                                    <asp:Button ID="btnCreateEvents" runat="server" Text="Approve Selected Events" CssClass="btn btn-primary" />


                                    </div>

                    <telerik:RadGrid ID="RequestedEventsGrid" runat="server" DataSourceID="qryGetRequestedEvents" AllowMultiRowSelection="true"
                        AllowPaging="True"
                        AllowSorting="True"
                        AllowFilteringByColumn="True"
                        ShowFooter="True"
                        ShowStatusBar="true"
                        PageSize="20" CellSpacing="-1"
                        FilterType="HeaderContext"
                        EnableHeaderContextMenu="true"
                        EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="EventDataGrid_FilterCheckListItemsRequested">
                        <MasterTableView DataKeyNames="requestedEventID" AutoGenerateColumns="False" AllowSorting="true">

                            <NoRecordsTemplate>
                                    <br />
                                    <div class="col-md-12">
                                        <div class="alert alert-warning" role="alert"><strong>No Requested Events Found.</strong></div>
                                    </div>
                            </NoRecordsTemplate>

                            <RowIndicatorColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>


                            <Columns>

                                <telerik:GridTemplateColumn UniqueName="CheckBoxTemplateColumn">
              <ItemTemplate>
                <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="ToggleRowSelection"
                  AutoPostBack="True" />
              </ItemTemplate>
              <HeaderTemplate>
                <asp:CheckBox ID="headerChkbox" runat="server" OnCheckedChanged="ToggleSelectedState"
                  AutoPostBack="True" />
              </HeaderTemplate>
            </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewButton">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>

                                            <asp:LinkButton ID="btnViewEvent" runat="server" CssClass="btn btn-primary btn-xs" ForeColor="White" CommandName="ViewEvent"
                                                CommandArgument='<%# Eval("requestedEventID")%>'>View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>

                                            <br />
                                         </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                 <telerik:GridBoundColumn DataField="requestedEventID" Visible="false"
                                        FilterControlAltText="Filter requestedEventID column"
                                        HeaderText="requestedEventID"
                                        UniqueName="requestedEventID">

                                </telerik:GridBoundColumn>

                                 <telerik:GridBoundColumn DataField="requestType"
                                        FilterControlAltText="Filter requestType column"
                                        HeaderText="Source"
                                        UniqueName="requestType">

                                </telerik:GridBoundColumn>


                                <telerik:GridBoundColumn DataField="eventTitle" Visible="false"
                                        FilterControlAltText="Filter eventTitle column"
                                        HeaderText="Event Title"
                                        SortExpression="supplierName" UniqueName="supplierName" FilterControlWidth="150px"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="175px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>


                                <telerik:GridTemplateColumn HeaderText="Requested Location">
                                    <ItemStyle Wrap="false" />
                                    <ItemTemplate>
                                        <%# Eval("locationName") %><br />
                                        <%# Eval("locationAddress") %><br />
                                        <%# Eval("locationCity") %>, <%# Eval("locationState") %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Matched Account">
                                    <ItemStyle Wrap="false" />
                                    <ItemTemplate><span style="color:green">
                                        <%# getAccountName(Eval("matchedLocationID")) %><br />
                                        <%# getAccountAddress(Eval("matchedLocationID")) %><br />
                                        <%# getAccountCity(Eval("matchedLocationID")) %>, <%# getAccountState(Eval("matchedLocationID")) %></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

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

                                                             <telerik:GridBoundColumn DataField="CreatedBy" Visible="false"
                                        FilterControlAltText="Filter CreatedBy column"
                                        HeaderText="Request By"
                                        SortExpression="CreatedBy" UniqueName="CreatedBy" FilterControlWidth="150px"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="175px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                             <telerik:GridBoundColumn DataField="CreatedByEmail" Visible="false"
                                        FilterControlAltText="Filter CreatedByEmail column"
                                        HeaderText="Request By Email"
                                        SortExpression="CreatedByEmail" UniqueName="CreatedByEmail" FilterControlWidth="150px"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="175px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>



                                <telerik:GridBoundColumn DataField="Brands" FilterControlAltText="Filter brandName column"
                                    HeaderText="Brands" SortExpression="brands" UniqueName="Brands"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    FilterCheckListEnableLoadOnDemand="true">
                                    <ColumnValidationSettings>
                                        <ModelErrorMessage Text="" />
                                    </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                                <telerik:GridDateTimeColumn
                                        AllowFiltering="false"
                                        DataField="eventDate"
                                        UniqueName="eventDate"
                                        HeaderText="Date"
                                        SortExpression="eventDate"
                                        PickerType="None"
                                        ShowFilterIcon="false"
                                        DataFormatString="{0:D}">
                                        <HeaderStyle Width="160px"></HeaderStyle>
                                        <ItemStyle Width="160px" />
                                </telerik:GridDateTimeColumn>

                                <telerik:GridBoundColumn DataField="eventTypeName" FilterControlAltText="Filter typeName column"
                                        HeaderText="Event Type" SortExpression="eventTypeName" UniqueName="eventTypeName" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                                <telerik:GridTemplateColumn AllowFiltering="false" AllowSorting="false" ShowFilterIcon="false"  UniqueName="DeleteButton">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>

                                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-xs" ForeColor="White" 
                                                CommandName="DeleteEvent"
                                                CommandArgument='<%# Eval("requestedEventID")%>' OnClientClick="javascript:if(!confirm('This action will delete the selected request. Are you sure?')){return false;}"
><i class="fa fa-trash"></i>&nbsp;&nbsp;Delete</asp:LinkButton>

                                            <br />
                                         </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                 <telerik:GridBoundColumn DataField="latitude" FilterControlAltText="Filter latitude column" Visible="false"
                                        HeaderText="latitude" SortExpression="latitude" UniqueName="latitude" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="longitude" FilterControlAltText="Filter longitude column" Visible="false"
                                        HeaderText="longitude" SortExpression="longitude" UniqueName="longitude" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="matchedLocationID" FilterControlAltText="Filter matchedLocationID column" Visible="false"
                                        HeaderText="matchedLocationID" SortExpression="matchedLocationID" UniqueName="matchedLocationID" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                            </Columns>

                        </MasterTableView>

                        <ClientSettings AllowColumnsReorder="true">

                        </ClientSettings>

                        <PagerStyle Position="TopAndBottom" />

                    </telerik:RadGrid>

                    <%--<asp:SqlDataSource ID="qryGetRequestedEvents" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                        SelectCommand="SELECT [requestedEventID], [locationName], [locationAddress], [locationCity], [locationState], [clientID], [eventTitle], [eventDate], [startTime], [endTime], [supplierName], [Brands], [eventTypeName], [CreatedBy], [CreatedByEmail], [latitude], [longitude], [matchedLocationID], [hours], [labelText], [requestType] FROM [qryGetRequestedEvents] WHERE ([matchedLocationID] <> @matchedLocationID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="matchedLocationID" Type="Int32"></asp:Parameter>
                        </SelectParameters>
                    </asp:SqlDataSource>--%>

                    <asp:SqlDataSource ID="qryGetRequestedEvents" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                        SelectCommand="SELECT [requestedEventID], [locationName], [locationAddress], [locationCity], [locationState], [clientID], [eventTitle], [eventDate], [startTime], [endTime], [supplierName], [Brands], [eventTypeName], [CreatedBy], [CreatedByEmail], [latitude], [longitude], [matchedLocationID], [hours], [labelText], [requestType] FROM [qryGetRequestedEvents] WHERE (([matchedLocationID] <> @matchedLocationID) AND ([clientID] = @clientID))">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="matchedLocationID" Type="Int32"></asp:Parameter>
                            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>


                    <asp:Panel ID="NoMatchPanel" runat="server">

                       <div style="margin-bottom:8px; margin-top:45px">
                                        <p>The following did not have a positive location match.  Click the 'View' button to search for the location and approve each event individually.   <asp:Label ID="Label1" runat="server" ForeColor="red" Font-Bold="true"  /></p>



                                    </div>

                    <telerik:RadGrid ID="RequestedEventsGrid_NoMatch" runat="server" DataSourceID="qryGetRequestedEvents_NoMatch"
                        AllowPaging="True"
                        AllowSorting="True"
                        AllowFilteringByColumn="True"
                        ShowFooter="True"
                        ShowStatusBar="true"
                        PageSize="20" CellSpacing="-1"
                        FilterType="HeaderContext"
                        EnableHeaderContextMenu="true"
                        EnableHeaderContextFilterMenu="true">
                        <MasterTableView DataKeyNames="requestedEventID" AutoGenerateColumns="False" AllowSorting="true">

                            <NoRecordsTemplate>
                                    <br />
                                    <div class="col-md-12">
                                        <div class="alert alert-warning" role="alert"><strong>No Requested Events Found.</strong></div>
                                    </div>
                            </NoRecordsTemplate>

                            <RowIndicatorColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>


                            <Columns>


                                <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewButton">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>

                                            <asp:LinkButton ID="btnViewEvent" runat="server" CssClass="btn btn-primary btn-xs" ForeColor="White" CommandName="ViewEvent"
                                                CommandArgument='<%# Eval("requestedEventID")%>'>View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>

                                            <br />
                                         </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                  <telerik:GridBoundColumn DataField="requestType"
                                        FilterControlAltText="Filter requestType column"
                                        HeaderText="Source"
                                        UniqueName="requestType">

                                </telerik:GridBoundColumn>


                                <telerik:GridBoundColumn DataField="eventTitle"
                                        FilterControlAltText="Filter eventTitle column"
                                        HeaderText="Event Title"
                                        SortExpression="supplierName" UniqueName="supplierName" FilterControlWidth="150px"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="175px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                                <telerik:GridTemplateColumn HeaderText="Requested Location">
                                    <HeaderStyle Wrap="false" />
                                    <ItemStyle Wrap="false" />
                                    <ItemTemplate>
                                        <%# Eval("locationName") %><br />
                                        <%# Eval("locationAddress") %><br />
                                        <%# Eval("locationCity") %>, <%# Eval("locationState") %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Matched Account">
                                    <HeaderStyle Wrap="false" />
                                    <ItemStyle Wrap="false" />
                                    <ItemTemplate>
                                        <span style="color:red">
                                        Could not find match</span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

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

                                                             <telerik:GridBoundColumn DataField="CreatedBy" Visible="false"
                                        FilterControlAltText="Filter CreatedBy column"
                                        HeaderText="Request By"
                                        SortExpression="CreatedBy" UniqueName="CreatedBy" FilterControlWidth="150px"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="175px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                             <telerik:GridBoundColumn DataField="CreatedByEmail" Visible="false"
                                        FilterControlAltText="Filter CreatedByEmail column"
                                        HeaderText="Request By Email"
                                        SortExpression="CreatedByEmail" UniqueName="CreatedByEmail" FilterControlWidth="150px"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="175px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>



                                <telerik:GridBoundColumn DataField="Brands" FilterControlAltText="Filter brandName column"
                                    HeaderText="Brands" SortExpression="brands" UniqueName="Brands"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    FilterCheckListEnableLoadOnDemand="true">
                                    <ColumnValidationSettings>
                                        <ModelErrorMessage Text="" />
                                    </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                                <telerik:GridDateTimeColumn
                                        AllowFiltering="false"
                                        DataField="eventDate"
                                        UniqueName="eventDate"
                                        HeaderText="Date"
                                        SortExpression="eventDate"
                                        PickerType="None"
                                        ShowFilterIcon="false"
                                        DataFormatString="{0:D}">
                                        <HeaderStyle Width="160px"></HeaderStyle>
                                        <ItemStyle Width="160px" />
                                </telerik:GridDateTimeColumn>

                                <telerik:GridBoundColumn DataField="eventTypeName" FilterControlAltText="Filter typeName column"
                                        HeaderText="Event Type" SortExpression="eventTypeName" UniqueName="eventTypeName" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                                <telerik:GridTemplateColumn AllowFiltering="false" AllowSorting="false" ShowFilterIcon="false"  UniqueName="DeleteButton">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>

                                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-xs" ForeColor="White" CommandName="DeleteEvent"
                                                CommandArgument='<%# Eval("requestedEventID")%>' OnClientClick="javascript:if(!confirm('This action will delete the selected request. Are you sure?')){return false;}"
><i class="fa fa-trash"></i>&nbsp;&nbsp;Delete</asp:LinkButton>

                                            <br />
                                         </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                 <telerik:GridBoundColumn DataField="latitude" FilterControlAltText="Filter latitude column" Visible="false"
                                        HeaderText="latitude" SortExpression="latitude" UniqueName="latitude" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="longitude" FilterControlAltText="Filter longitude column" Visible="false"
                                        HeaderText="longitude" SortExpression="longitude" UniqueName="longitude" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="matchedLocationID" FilterControlAltText="Filter matchedLocationID column" Visible="false"
                                        HeaderText="matchedLocationID" SortExpression="matchedLocationID" UniqueName="matchedLocationID" FilterControlWidth="120px"
                                        FilterCheckListEnableLoadOnDemand="true">
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                </telerik:GridBoundColumn>

                            </Columns>

                        </MasterTableView>

                        <ClientSettings AllowColumnsReorder="true">

                        </ClientSettings>

                        <PagerStyle Position="TopAndBottom" />

                    </telerik:RadGrid>

                    <%--<asp:SqlDataSource ID="qryGetRequestedEvents_NoMatch" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                        SelectCommand="SELECT [requestedEventID], [locationName], [locationAddress], [locationCity], [locationState], [clientID], [eventTitle], [eventDate], [startTime], [endTime], [supplierName], [Brands], [eventTypeName], [CreatedBy], [CreatedByEmail], [latitude], [longitude], [matchedLocationID], [hours], [labelText], [requestType] FROM [qryGetRequestedEvents] WHERE ([matchedLocationID] = @matchedLocationID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="matchedLocationID" Type="Int32"></asp:Parameter>
                        </SelectParameters>
                    </asp:SqlDataSource>--%>


                        <asp:SqlDataSource ID="qryGetRequestedEvents_NoMatch" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [requestedEventID], [locationName], [locationAddress], [locationCity], [locationState], [clientID], [eventTitle], [eventDate], [startTime], [endTime], [supplierName], [Brands], [eventTypeName], [CreatedBy], [CreatedByEmail], [latitude], [longitude], [matchedLocationID], [hours], [labelText], [requestType] FROM [qryGetRequestedEvents] WHERE (([matchedLocationID] = @matchedLocationID) AND ([clientID] = @clientID))">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="matchedLocationID" Type="Int32"></asp:Parameter>
                                <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        </asp:Panel>

                </div>
            </div>
          </div>
        </asp:Panel>


    </asp:Panel>

</asp:Content>
