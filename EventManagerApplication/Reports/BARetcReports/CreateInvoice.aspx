<%@ Page Title="Create Invoices" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="CreateInvoice.aspx.vb" Inherits="EventManagerApplication.CreateInvoice" %>

<%@ Register Src="~/Reports/UserControls/SideMenuControl.ascx" TagPrefix="uc1" TagName="SideMenuControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        #span1 {
            display: none;
        }
    </style>


    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnResponseEnd="" ClientEvents-OnRequestStart="ValidatePage()">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="MainPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="MainPanel" />
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
            <%--<div class="col-md-2">
                <div class="widget stacked">
                    <uc1:SideMenuControl runat="server" ID="SideMenuControl" />
                </div>

            </div>--%>

            <div class="col-md-12">


                <div class="row">
                    <div class="col-md-6">
                        <h3>Create Invoices</h3>
                        <p>Use this form to create invoices from Events that have been <b>Toplined</b> or <b>Approved</b>
                            
                        </p>
                    </div>


                    <div class="col-md-6 pull-right">
                        <div class="pull-right">

                            <%--something goes here--%>
                        </div>


                    </div>

                </div>

                <asp:Panel ID="SearchPanel" runat="server">
                <div class="row">
                    <div class="col-md-12">

                        <div class="widget stacked">
                            <div class="widget-content">

                                <!-- fisrt column -->
                                <div class="col-md-4">
                                    <h4 style="font-weight: bold; color: #3276B1;">Date Range</h4>
                                    <p>Select the date range</p>

                                    <asp:Label ID="Label1" runat="server" Text="From Date" Width="80px" CssClass="fromDateLabel"></asp:Label>

                                    <telerik:RadDatePicker ID="FromDate" runat="server">
                                    </telerik:RadDatePicker>

                                    <br />
                                    <br />
                                    <asp:Label ID="Label2" runat="server" Text="To Date" Width="77px" CssClass="toDateLabel"></asp:Label>

                                    <telerik:RadDatePicker ID="ToDate" runat="server">
                                    </telerik:RadDatePicker>

                                </div>

                                <!-- second column -->
                                <div class="col-md-4">
                                    <h4 style="font-weight: bold; color: #3276B1; margin-bottom: 15px;">Supplier</h4>

                                    <telerik:RadListBox RenderMode="Lightweight" ID="SupplierList" runat="server" CheckBoxes="true" ShowCheckAll="true" Width="300"
                                        DataSourceID="getSupplier" DataTextField="supplierName" DataValueField="supplierID"
                                        Height="300px">
                                    </telerik:RadListBox>

                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getSupplier" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="supplierName" Select="new (supplierID, supplierName)" TableName="tblSuppliers" Where="clientID == @clientID">
                                        <WhereParameters>
                                           <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                        </WhereParameters>
                                    </asp:LinqDataSource>
                                    <br style="margin-bottom: 10px;" />
                                </div>

                                <!-- third column -->
                                <div class="col-md-4">
                                    <h4 style="font-weight: bold; color: #3276B1; margin-bottom: 10px;">Markets</h4>


                                    <telerik:RadListBox RenderMode="Lightweight" ID="MarketList" runat="server" CheckBoxes="true" ShowCheckAll="true" Width="300"
                                        DataSourceID="getMarketList" DataTextField="marketName" DataValueField="marketID"
                                        Height="300px">
                                    </telerik:RadListBox>



                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getMarketList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="marketName" TableName="tblMarkets"></asp:LinqDataSource>

                                    <asp:HiddenField ID="HF_SelectedMarkets" runat="server" />
                                    <asp:HiddenField ID="HF_SelectedSuppliers" runat="server" />

                                </div>

                                <!-- button row -->
                                 <div class="col-md-12">
                                      

                                     <div>

                                     <asp:LinkButton ID="btnFindEvents" runat="server" CssClass="btn btn-success" OnClientClick="ValidatePage()">Start  <i class="fa fa-play" aria-hidden="true"></i></asp:LinkButton>

                                         <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-default">Cancel</asp:LinkButton>
                                     </div>

                                     <div id="span1">
                                         <asp:Panel ID="Panel1" runat="server">

                                             <i class="fa fa-refresh fa-spin fa fa-fw"></i>
                                                <span>Searching for Events...</span>

                                         </asp:Panel>

                                     </div>

                                    <asp:Label ID="ResultsLabel" runat="server" ForeColor="Red" />

                                
                                 </div>
                            </div>
                        </div>

                    </div>
                </div>
                    </asp:Panel>

                <asp:Panel ID="ResultPanel" runat="server" Visible="false" >
                    <div class="row">
                    <div class="col-md-12">

                        <div class="widget stacked">
                            <div class="widget-content min-height">

                                <asp:Label ID="ResultPanelCountLabel" runat="server" />

                                <div>


                                    <div style="margin-bottom:8px;">
                                        <p>Select each event that you want included on the invoice.   <asp:Label ID="topMsgLabel" runat="server" ForeColor="red" Font-Bold="true"  /></p>
                                    <asp:Button ID="Button2" runat="server" Text="Create Invoice" CssClass="btn btn-primary" /> <asp:Button ID="Button3" runat="server" Text="Cancel" CssClass="btn btn-default" PostBackUrl="/Reports/BARetcReports/Invoicing" />

                                        
                                    </div>


                                    <telerik:RadGrid ID="ResultsGrid" runat="server" AllowMultiRowSelection="true" DataKeyNames="eventID" 
                                        AutoGenerateColumns="False" CellSpacing="-1" 
                                        AllowPaging="False"
                                        AllowSorting="True"
                                        ShowFooter="True"
                                        ShowStatusBar="true"
                                        AllowFilteringByColumn="True"
                                        FilterType="HeaderContext"
                                        EnableHeaderContextMenu="true"
                                        EnableHeaderContextFilterMenu="true"
                                        OnFilterCheckListItemsRequested="ResultsGrid_FilterCheckListItemsRequested">
                                       
                                        <MasterTableView AllowSorting="True">
                                          <NoRecordsTemplate>
                                              No Records Found, Please Refine Your Search 
                                          </NoRecordsTemplate>
                                            <Columns>
                                                <telerik:GridTemplateColumn UniqueName="CheckBoxTemplateColumn" AllowFiltering="false">
                                                    <HeaderStyle Wrap="false" />
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="ToggleRowSelection"
                                                            AutoPostBack="True" />
                                                    </ItemTemplate>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="headerChkbox" runat="server" OnCheckedChanged="ToggleSelectedState"
                                                            AutoPostBack="True" />
                                                    </HeaderTemplate>
                                                </telerik:GridTemplateColumn>

                                              <%--  <telerik:GridTemplateColumn DataField="eventID" HeaderText="Event ID" SortExpression="eventID" UniqueName="eventID" DataType="System.Int32" FilterControlAltText="Filter eventID column">
                                                    <ItemTemplate>
                                                        <a href="/events/eventdetails?ID=<%# Eval("eventID") %>" target="_blank" class="btn btn-default btn-sm"><i class="fa fa-external-link" aria-hidden="true"></i> View</a>
                                                    </ItemTemplate>
                                        <ItemStyle  Wrap="false"/>
                                        <HeaderStyle Wrap="false" />
                                                </telerik:GridTemplateColumn>--%>

                                               <telerik:GridBoundColumn UniqueName="eventID" DataField="eventID" HeaderText="Event ID" SortExpression="eventID" FilterControlAltText="Filter eventID column">
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn UniqueName="Account" DataField="Account" HeaderText="Account" SortExpression="Account" FilterControlAltText="Filter Account column">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn UniqueName="eventDate" DataField="eventDate" HeaderText="Event Date" DataFormatString="{0:d}" SortExpression="eventDate" FilterControlAltText="Filter eventDate column">
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn UniqueName="EventType" DataField="EventType" HeaderText="Event Type" SortExpression="EventType" FilterControlAltText="Filter EventType column">
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                

                                                <telerik:GridBoundColumn UniqueName="Supplier" DataField="Supplier" HeaderText="Supplier" SortExpression="Supplier" FilterControlAltText="Filter Supplier column">
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn UniqueName="Brands" DataField="Brands" HeaderText="Brands" SortExpression="Brands" FilterControlAltText="Filter Brands column">
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn UniqueName="Market" DataField="Market" HeaderText="Market" 
                                                    SortExpression="Market" FilterControlAltText="Filter Market column">
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridBoundColumn>


                                                <telerik:GridBoundColumn UniqueName="purchaseOrderNumber" DataField="purchaseOrderNumber" 
                                                    HeaderText="PO #" SortExpression="purchaseOrderNumber" 
                                                    FilterControlAltText="Filter purchaseOrderNumber column">
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn UniqueName="requestedBy" DataField="requestedBy" HeaderText="Requested By" SortExpression="requestedBy" FilterControlAltText="Filter requestedBy column">
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn UniqueName="Status" DataField="Status" HeaderText="Status" SortExpression="Status" 
                                                    FilterControlAltText="Filter Status column"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridBoundColumn>

                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>

                                    <br />

                                    <asp:Button ID="Button1" runat="server" Text="Create Invoice" CssClass="btn btn-primary" /> <asp:Button ID="btnCancelInvoice" runat="server" Text="Cancel" CssClass="btn btn-default" />

                                    <br />
                                    <asp:Label ID="MessageLabel" runat="server" />



                                </div>


                                </div>

                            </div>
                        </div>
                        </div>

                </asp:Panel>

            </div>
        </div>

    </div>

   </asp:Panel>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript">

        function ValidatePage() {
            $("#span1").show();
            $('#<%= ResultsLabel.ClientID %>').hide();
        }
     </script>
    </telerik:RadScriptBlock>

</asp:Content>
