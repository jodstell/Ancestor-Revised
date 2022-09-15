<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="OffPremiseReport.aspx.vb" MaintainScrollPositionOnPostback="true"
    Inherits="EventManagerApplication.RetailOffPremiseReport" %>

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

    </style>

<%--    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">

        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="RadGrid1">

                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>

                </UpdatedControls>

            </telerik:AjaxSetting>

        </AjaxSettings>

    </telerik:RadAjaxManager>--%>

    <asp:HiddenField ID="hiddenUserID" runat="server" />
    <asp:HiddenField ID="hiddenClientID" runat="server" />


    <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">



                <h2>Sales Recap Report:  Retail/Off Premise</h2>
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



                <h3 style="margin-top: 15px;">Retail Sales Recap</h3>

                <p style="font-size: 12px;">
                    <asp:Label ID="DateRangeLabel" runat="server" Font-Bold="true" /></p>


                  <!-- Date Filter -->
            <div class="widget-content-sidebar sidemenu" style="padding: 15px 5px 15px;">

                 <telerik:RadComboBox RenderMode="Lightweight" ID="SelectedSupplier" runat="server"
                                        Label="Supplier:" EmptyMessage="Select Supplier" AllowCustomText="true" MarkFirstMatch="true"
                                        Height="200px" Width="375px" DataSourceID="GetSupplierList" DataValueField="supplierID" DataTextField="supplierName">
                                    </telerik:RadComboBox>

                    <asp:SqlDataSource runat="server" ID="GetSupplierList" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetSuppliersByUserIDandClientID" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hiddenUserID" PropertyName="Value" Name="userID" Type="String"></asp:ControlParameter>
                            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>       

                        </SelectParameters>
                    </asp:SqlDataSource>

                <strong> From:</strong>
                <telerik:RadDatePicker ID="FromDatePicker" runat="server" Culture="en-US" SelectedDate="2016-03-01">
                    <DateInput DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy"  LabelWidth="40%">
                    </DateInput>
                     <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>

                </telerik:RadDatePicker>
                <strong> To:</strong>
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
                <asp:Button ID="btnChangeDateRange" runat="server" Text="Go" CssClass="btn btn-default" />

                <%--<a id='filterbutton' class="filterbutton" href="#">Advanced Filter</a>--%>


                <div class="btn-group pull-right" role="group" aria-label="...">
                    <asp:Button ID="btnViewWeek" runat="server" Text="Week" CssClass="btn btn-success" />
                    <asp:Button ID="btnViewMonth" runat="server" Text="Month" CssClass="btn btn-default" />
                </div>
            </div>


                <asp:Panel ID="LabelPanel" runat="server" Visible="false">
                <div class="col-sm-12">


                    <div class="feature col-sx-4 col-sm-2 center">

                            <div class="well bluebox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="VolumeLabel" runat="server" /></h2>
                                <h5 class="text-center">Event<br />Volume
                                    </h5>
                            </div>

                    </div>

                    <div class="feature col-sx-4 col-sm-2 center">

                            <div class="well redbox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="SampledTotalLabel" runat="server" /></h2>
                                <h5 class="text-center">Consumers<br />Sampled</h5>
                            </div>

                    </div>


                   <div class="feature col-sx-4 col-sm-2 center">

                            <div class="well darkbluebox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="BottlesSoldTotalLabel" runat="server" /></h2>
                                <h5 class="text-center">Bottles<br />Sold</h5>
                            </div>

                    </div>

                    <div class="feature col-sx-4 col-sm-2">

                            <div class="well purplebox smbox center">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="ConversionRateLabel" runat="server" /></h2>
                                <h5 class="text-center">Conversion<br />Rate</h5>
                            </div>

                    </div>


                    <div class="feature col-sx-4 col-sm-2 center">

                            <div class="well greenbox smbox">
                                <div class="marginbotton10"></div>
                                <h2 class="text-center">
                                    <asp:Label ID="RevenueLabel" runat="server" /></h2>
                                <h5 class="text-center">Estimated<br />Revenue</h5>
                            </div>

                    </div>



                </div>
</asp:Panel>




                <div class="col-sm-12">

                <asp:Panel ID="MainPanel" runat="server">

                    <div runat="server" id="DefaultMessage" class="alert alert-info" role="alert">Select a supplier and date range above.</div>

                    <asp:Label ID="NoResultLabel" runat="server" />

                </asp:Panel>

                 <asp:Panel ID="ReportPanel" runat="server" Visible="false">

                    <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" DataSourceID="getEvents" GroupPanelPosition="Top" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" AllowMultiRowSelection="False" GridLines="None" >

                        <MasterTableView DataSourceID="getEvents" AutoGenerateColumns="False" DataKeyNames="eventID" EnableHierarchyExpandAll="true" AllowMultiColumnSorting="True" RetainExpandStateOnRebind="true" CommandItemDisplay="Top" >

                             <CommandItemTemplate>

                                    <div style="padding: 3px 0 3px 5px">

                                                            <asp:LinkButton ID="btnExport" runat="server" CommandName="ExportML" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export to Excel</asp:LinkButton>

                                       <%-- <asp:LinkButton ID="LinkButton1" runat="server" CommandName="ExportXLSX" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export to ExcelXLSX</asp:LinkButton>

                                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="ExportToExcel" CssClass="btn btn-secondary btn-sm" ForeColor="White"><i class="fa fa-download"></i> Export to CSV</asp:LinkButton>--%>

                                        </div>

                                        </CommandItemTemplate>
                            <DetailTables>
                                <telerik:GridTableView EnableHierarchyExpandAll="true" DataKeyNames="eventID" DataSourceID="getBrands" Width="100%"
                                    runat="server">

                                    <ParentTableRelation>

                                        <telerik:GridRelationFields DetailKeyField="eventID" MasterKeyField="eventID"></telerik:GridRelationFields>

                                    </ParentTableRelation>
                                    <Columns>


                                        <telerik:GridBoundColumn SortExpression="brandName" HeaderText="Brand Name" HeaderButtonType="TextButton"
                                            DataField="brandName" UniqueName="brandName">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn SortExpression="sampled" HeaderText="Total Sampled" HeaderButtonType="TextButton"
                                            DataField="sampled" UniqueName="sampled">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn SortExpression="bottlesSold" HeaderText="Bottles Sold" HeaderButtonType="TextButton"
                                            DataField="bottlesSold" UniqueName="bottlesSold">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn SortExpression="ConversionRate" HeaderText="Conversion Rate" HeaderButtonType="TextButton"
                                            DataField="ConversionRate" UniqueName="ConversionRate">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn SortExpression="Revenue" HeaderText="Estimated Revenue" HeaderButtonType="TextButton"
                                            DataField="Revenue" UniqueName="Revenue">
                                        </telerik:GridBoundColumn>
                                      

                                       

                                    </Columns>
                                    <PagerStyle Position="TopAndBottom" />

                                </telerik:GridTableView>
                            </DetailTables>




                            <Columns>


                                <telerik:GridBoundColumn DataField="eventDate" ReadOnly="True" HeaderText="Event Date" SortExpression="eventDate" UniqueName="eventDate" FilterControlAltText="Filter eventDate column"></telerik:GridBoundColumn>


                                <telerik:GridBoundColumn DataField="startTime" ReadOnly="True" HeaderText="Start Time" SortExpression="startTime" UniqueName="startTime" FilterControlAltText="Filter startTime column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="endTime" ReadOnly="True" HeaderText="End Time" SortExpression="endTime" UniqueName="endTime" FilterControlAltText="Filter endTime column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="eventType" ReadOnly="True" HeaderText="Event Type" SortExpression="eventType" UniqueName="eventType" FilterControlAltText="Filter eventType column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="accountType" ReadOnly="True" HeaderText="Account Type" SortExpression="accountType" UniqueName="accountType" FilterControlAltText="Filter accountType column"></telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="accountName" HeaderText="Account Name" SortExpression="accountName" UniqueName="accountName" FilterControlAltText="Filter accountName column"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="marketName" HeaderText="Market Name" SortExpression="marketName" UniqueName="marketName" FilterControlAltText="Filter marketName column"></telerik:GridBoundColumn>


                                <telerik:GridBoundColumn SortExpression="sampled" HeaderText="Total Sampled" HeaderButtonType="TextButton"
                                    DataField="sampled" UniqueName="sampled">
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn SortExpression="bottlesSold" HeaderText="Bottles Sold" HeaderButtonType="TextButton"
                                    DataField="bottlesSold" UniqueName="bottlesSold">
                                </telerik:GridBoundColumn>

                               <telerik:GridBoundColumn SortExpression="conversionRate" HeaderText="Conversion Rate" HeaderButtonType="TextButton"
                                    DataField="conversionRate" UniqueName="conversionRate" DataType="System.String">
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn SortExpression="estimatedRevenue" HeaderText="Estimated Revenue" HeaderButtonType="TextButton"
                                    DataField="estimatedRevenue" UniqueName="estimatedRevenue" >
                                </telerik:GridBoundColumn>

                            </Columns>
                        </MasterTableView>
                        <PagerStyle Position="TopAndBottom" />
                    </telerik:RadGrid>

                     </asp:Panel>


                    <asp:SqlDataSource ID="getEvents" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [qrySalesRecapReport_OffPremise] WHERE (([eventDate] >= @eventDate) AND ([eventDate] <= @eventDate2) AND ([statusID] = @statusID) AND ([supplierID] = @supplierID))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="FromDatePicker" Name="eventDate" Type="DateTime"  />
                            <asp:ControlParameter ControlID="ToDatePicker" Name="eventDate2" Type="DateTime" />

                            <asp:Parameter DefaultValue="1" Name="statusID" Type="Int32"></asp:Parameter>
                            <asp:ControlParameter ControlID="SelectedSupplier" Name="supplierID"  DefaultValue="173" />

                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="getBrands" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [qrySalesRecapReportBrandTotals] WHERE ([eventID] = @eventID)">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="eventID" Name="eventID" Type="Int32"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>



                </div>



            </div>





        </div>

    </div>

</asp:Content>

