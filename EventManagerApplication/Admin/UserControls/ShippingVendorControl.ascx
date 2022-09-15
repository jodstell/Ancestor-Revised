<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ShippingVendorControl.ascx.vb" Inherits="EventManagerApplication.ShippingVendorControl" %>

    <telerik:RadGrid ID="ShippingVendorGrid" runat="server" DataSourceID="GetShippingVendorList" 
            AllowPaging ="True"
            AllowSorting="True"
            ShowFooter="True"
            ShowStatusBar="true"
            AllowFilteringByColumn="True"
            PageSize="20"
            CellSpacing="-1"
            FilterType="HeaderContext"
            EnableHeaderContextMenu="true"
            EnableHeaderContextFilterMenu="true"
            EnableLinqExpressions="False">


         <MasterTableView DataKeyNames="ShippingVendorID" DataSourceID="GetShippingVendorList" AutoGenerateColumns="False" CommandItemDisplay="Top" AllowSorting="true">
        
 
               <NoRecordsTemplate>

                    <br />
                    <div class="col-md-12">
                        <div class="alert alert-warning" role="alert"><strong>No Shipping vendors Found.</strong>  Please adjust your filter options.</div>
                    </div>

                </NoRecordsTemplate>

                <RowIndicatorColumn>
                    <HeaderStyle Width="20px"></HeaderStyle>
                </RowIndicatorColumn>

                <CommandItemTemplate>
                    <div style="padding: 3px 0 3px 5px">
                        <asp:LinkButton ID="btnAddNew" runat="server" CommandName="AddNew" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Shiping Vendor</asp:LinkButton>
                        <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                        <div class="pull-right" style="padding-right: 3px">
                            <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export Excel</asp:LinkButton>
                        </div>
                    </div>
                </CommandItemTemplate>

                <Columns>
                
                    <%--<telerik:GridBoundColumn DataField="ShippingVendorID" ReadOnly="True" HeaderText="ShippingVendorID" SortExpression="ShippingVendorID" UniqueName="ShippingVendorID" DataType="System.Int32" FilterControlAltText="Filter ShippingVendorID column"></telerik:GridBoundColumn>--%>
               
                    <telerik:GridTemplateColumn AllowFiltering="false" EnableHeaderContextMenu="false" UniqueName="ViewButton">
                            <ItemStyle Width="75px" />
                            <ItemTemplate>

                                <asp:LinkButton ID="btnEditShippingVendor" runat="server" CssClass="btn btn-xs btn-default" ForeColor="Black" CommandArgument='<%# Eval("ShippingVendorID") %>' CommandName="EditShipingVendor"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>

                            </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="ShippingVendorName" HeaderText="Shipping Vendor" SortExpression="ShippingVendorName" UniqueName="ShippingVendorName" FilterControlAltText="Filter ShippingVendorName column"></telerik:GridBoundColumn>
                
                    <%--<telerik:GridBoundColumn DataField="TrackingURL" HeaderText="TrackingURL" SortExpression="TrackingURL" UniqueName="TrackingURL" FilterControlAltText="Filter TrackingURL column"></telerik:GridBoundColumn>--%>

                </Columns>

         </MasterTableView>

    </telerik:RadGrid>

    <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetShippingVendorList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblShippingVendors"></asp:LinqDataSource>
