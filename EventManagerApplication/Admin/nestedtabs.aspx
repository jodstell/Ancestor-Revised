<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="nestedtabs.aspx.vb" Inherits="EventManagerApplication.nestedtabs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .widget .widget-content {
            /*padding-top: 5px;*/
        }

        .widget1 {
            border-top-right-radius: 0px;
        }

        .sec {
            background: rgba(0, 0, 0, 0.08) none repeat scroll 0% 0%;
            border-top-right-radius: 5px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row">
        </div>


        <div class="row">
            <div class="col-md-12">


    <div class="tabbable">

        <ul id="MainTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0px">
                        <li class="active"><a href="#detailstab" data-toggle="tab">Client Details</a></li>
                        <li><a href="#configurationtab" data-toggle="tab">Configuration</a></li>
                        <li class=""><a href="#eventtab" data-toggle="tab">Events</a></li>
                        <li class=""><a href="#accounttab" data-toggle="tab">Accounts</a></li>
                    </ul>

        <div class="tab-content tab-container">

            <div class="tab-pane active" id="detailstab">
                <div class="widget stacked">
                                <div class="widget-content">
                                    <div class="col-sm-12">
                                        <div class="row">
                                            <div class="col-sm-12">

                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-horizontal">
                                                            <div class="form-group">
                                                                <label for="inputEmail3" class="col-sm-3 control-label">Name</label>
                                                                <div class="col-sm-9">
                                                                    <asp:TextBox ID="clientNameTextBox" runat="server" Text='<%# Bind("clientName")%>' CssClass="form-control" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-horizontal">
                                                            <div class="form-group">
                                                                <label for="inputEmail3" class="col-sm-3 control-label">Active</label>
                                                                <div class="col-sm-9">
                                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("clientName")%>' CssClass="form-control" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>

                                            </div>



                                        </div>
                                    </div>
                                </div>
                            </div>
                
            </div>

            <div class="tab-pane" id="configurationtab">
                <div class="tabbable tabs-left">

                    <ul id="configTab" class="nav nav-tabs sec" style="margin-bottom: 3px; border-bottom: 0px">
                                <li class="secondarytab active"><a href="#clientconfig" data-toggle="tab">Client Configuration</a></li>
                                <li class="secondarytab"><a href="#eventconfig" data-toggle="tab">Event Configuration</a></li>
                                <li class="secondarytab"><a href="#toolsconfig" data-toggle="tab">Tools</a></li>
                            </ul>

                    <div class="tab-content tab-info">
                        <div class="tab-pane active" id="clientconfig">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    P2 child 1 
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="eventconfig">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    P2 child 2
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="toolsconfig">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    P2 child 3
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane" id="eventtab">
               <div class="tabbable tabs-left">

                    <ul id="eventsTab" class="nav nav-tabs sec" style="margin-bottom: 3px; border-bottom: 0px">
                                <li class="secondarytab active"><a href="#eventype" data-toggle="tab">Event Types</a></li>
                                <li class="secondarytab"><a href="#suppliers" data-toggle="tab">Suppliers</a></li>
                                <li class="secondarytab"><a href="#brands" data-toggle="tab">Brands</a></li>
                                <li class="secondarytab"><a href="#teams" data-toggle="tab">Teams</a></li>
                                <li class="secondarytab"><a href="#contacttype" data-toggle="tab">Contact Types</a></li>
                                <li class="secondarytab"><a href="#eventsections" data-toggle="tab">Event Sections</a></li>
                                <li class="secondarytab"><a href="#customfields" data-toggle="tab">Custom Fields</a></li>
                            </ul>

                    <div class="tab-content tab-info">
                        <div class="tab-pane active" id="eventype">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <div class="col-sm-12">
                                        <h2>Event Types</h2>
                <hr />
                 <div style="margin-bottom:10px;">
                 <asp:LinkButton ID="btnAddNewEventType" runat="server" CssClass="btn btn-primary btn-md"><i class="fa fa-plus"></i> Add New Event Type</asp:LinkButton>
                </div>

                 <telerik:RadGrid ID="EventTypeList" runat="server" DataSourceID="getEventTypeList">
                     <MasterTableView AutoGenerateColumns="False" DataKeyNames="eventTypeID" DataSourceID="getEventTypeList">
                         <Columns>

                             <telerik:GridTemplateColumn>
                                 <ItemTemplate>
                                     <a href="#" class="btn btn-xs btn-primary" style="color:white">Edit</a>
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>

                             <telerik:GridBoundColumn DataField="eventTypeName" 
                                 FilterControlAltText="Filter eventTypeName column" 
                                 HeaderText="Name" 
                                 SortExpression="eventTypeName" 
                                 UniqueName="eventTypeName">
                                 <ColumnValidationSettings>
                                     <ModelErrorMessage Text="" />
                                 </ColumnValidationSettings>
                             </telerik:GridBoundColumn>

                             <telerik:GridTemplateColumn HeaderText="# of Events">
                                 <ItemTemplate>
                                     <asp:Label ID="EventCountLabel" runat="server" Text="Label" />
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>


                            <telerik:GridTemplateColumn>
                                 <ItemTemplate>
                                     <span class="label label-success">Active</span>
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>

                         </Columns>
                     </MasterTableView>
                 </telerik:RadGrid>

                 <asp:LinqDataSource ID="getEventTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblEventTypes" OrderBy="eventTypeName">
                 </asp:LinqDataSource>
                 </div> 
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="suppliers">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <div class="col-sm-12">
                <h2>Suppliers</h2>
                <hr />

                 
                <div style="margin-bottom:10px;">
                 <asp:LinkButton ID="btnAddNewSupplier" runat="server" CssClass="btn btn-primary btn-md"><i class="fa fa-plus"></i> Add New Brand</asp:LinkButton>
                </div>

                 <telerik:RadGrid ID="SupplierList" runat="server" DataSourceID="getSuppliers">
                     <MasterTableView AutoGenerateColumns="False" DataKeyNames="supplierID" DataSourceID="getSuppliers">
                         <Columns>

                             <telerik:GridTemplateColumn>
                                 <ItemTemplate>
                                     <a href='SupplierDetails?SupplierID=<%# Eval("supplierID")%>' class="btn btn-xs btn-primary" style="color:white">View</a>
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>

                             <telerik:GridBoundColumn DataField="supplierID" DataType="System.Int32" FilterControlAltText="Filter supplierID column" HeaderText="supplierID" ReadOnly="True" SortExpression="supplierID" UniqueName="supplierID">
                                 <ColumnValidationSettings>
                                     <ModelErrorMessage Text="" />
                                 </ColumnValidationSettings>
                             </telerik:GridBoundColumn>

                             <telerik:GridBoundColumn DataField="supplierName" FilterControlAltText="Filter supplierName column" HeaderText="supplierName" SortExpression="supplierName" UniqueName="supplierName">
                                 <ColumnValidationSettings>
                                     <ModelErrorMessage Text="" />
                                 </ColumnValidationSettings>
                             </telerik:GridBoundColumn>

                             <telerik:GridCheckBoxColumn DataField="active" DataType="System.Boolean" FilterControlAltText="Filter active column" HeaderText="active" SortExpression="active" UniqueName="active">
                             </telerik:GridCheckBoxColumn>
                         </Columns>
                     </MasterTableView>
                 </telerik:RadGrid>
                 <asp:LinqDataSource ID="getSuppliers" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="supplierName" TableName="tblSuppliers">
                 </asp:LinqDataSource>
            </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="brands">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    P1 child 3
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="teams">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    P1 child 3
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="contacttype">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    P1 child 3
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="eventsections">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    P1 child 3
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="customfields">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    P1 child 3
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane" id="accounttab">
                <div class="tabbable tabs-left">

                    <ul id="accountTab" class="nav nav-tabs sec" style="margin-bottom: 3px; border-bottom: 0px">
                                <li class="secondarytab active"><a href="#markets" data-toggle="tab">Markets</a></li>
                                <li class="secondarytab"><a href="#accounttypes" data-toggle="tab">Account Types</a></li>
                                <li class="secondarytab"><a href="#accountactivities" data-toggle="tab">Account Activities</a></li>
                            </ul>

                    <div class="tab-content tab-info">
                        <div class="tab-pane active" id="markets">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    Markets 
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="accounttypes">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    Account Types
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="accountactivities">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    Account Activities
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>
            </div>
        </div>

</asp:Content>
