<%@ Page Title="Import File History" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EventImportHistory.aspx.vb" Inherits="EventManagerApplication.EventImportHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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

                </div>
            </div>

            <div class="row margintop20">
                <div class="col-xs-12">

                    <telerik:RadGrid ID="ImportGrid" runat="server" DataSourceID="getEventImportListing"
                        AllowPaging="True"
                        AllowSorting="True"
                        ShowFooter="True"
                        ShowStatusBar="true"
                        AllowFilteringByColumn="True"
                        PageSize="20" CellSpacing="-1"
                        FilterType="HeaderContext"
                        EnableHeaderContextMenu="true"
                        EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="ImportGrid_FilterCheckListItemsRequested"
                        EnableLinqExpressions="False">

                        <ExportSettings IgnorePaging="true" OpenInNewWindow="true"></ExportSettings>

                        <MasterTableView DataSourceID="getEventImportListing" AutoGenerateColumns="False" CommandItemDisplay="Top" AllowSorting="true">
                            <CommandItemSettings ShowAddNewRecordButton="false"  />

                            <NoRecordsTemplate>

                                <br />
                                <div class="col-md-12">
                                    <div class="alert alert-warning" role="alert"><strong>No Events Found.</strong>  Please adjust your filter options.</div>
                                </div>

                            </NoRecordsTemplate>

                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>

                            <Columns>

                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnViewEvents" runat="server" CssClass="btn btn-primary btn-xs" ForeColor="White" CommandName="ViewEvent" CommandArgument='<%# Eval("eventImportID")%>'>View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridBoundColumn DataField="SupplierName" HeaderText="SupplierName" SortExpression="SupplierName" UniqueName="SupplierName" FilterControlAltText="Filter SupplierName column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="createdDate" HeaderText="Imported Date" SortExpression="createdDate" UniqueName="createdDate" DataType="System.DateTime" FilterControlAltText="Filter createdDate column"
                                  DataFormatString="{0:MM/dd/yyyy}" ></telerik:GridBoundColumn>


                                <telerik:GridBoundColumn DataField="requestedBy" HeaderText="Requested By" SortExpression="requestedBy" UniqueName="requestedBy" FilterControlAltText="Filter requestedBy column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="CreatedBy" HeaderText="Imported By" SortExpression="CreatedBy" UniqueName="CreatedBy" FilterControlAltText="Filter CreatedBy column"></telerik:GridBoundColumn>


                                <telerik:GridTemplateColumn DataField="fileName" HeaderText="Import File Name" SortExpression="fileName" UniqueName="fileName" FilterControlAltText="Filter fileName column">
                                    <ItemTemplate>
                                        <a href='https://bletsianstor01.blob.core.windows.net:443/baretc/ImportFiles/<%# Eval("fileName") %>.xlsx'><%# Eval("fileName") %>.xlsx</a>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>


                            </Columns>
                        </MasterTableView>

                        <PagerStyle Position="TopAndBottom" />
                    </telerik:RadGrid>

                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getEventImportListing" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="createdDate desc" TableName="qryGetEventImportLists"></asp:LinqDataSource>
                </div>
            </div>


        </div>
    </asp:Panel>
</asp:Content>
