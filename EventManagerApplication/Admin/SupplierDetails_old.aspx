<%@ Page Title="" Language="vb" AutoEventWireup="false" MaintainScrollPositionOnPostback="true" MasterPageFile="~/Dashboard.Master" CodeBehind="SupplierDetails_old.aspx.vb" Inherits="EventManagerApplication.SupplierDetails" %>

<%@ Register Src="~/Admin/BrandsControl.ascx" TagPrefix="uc1" TagName="BrandsControl" %>
<%@ Register Src="~/Admin/BillingRatesControl.ascx" TagPrefix="uc1" TagName="BillingRatesControl" %>
<%@ Register Src="~/Admin/SupplierDocumentsControl.ascx" TagPrefix="uc1" TagName="SupplierDocumentsControl" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .label-standard {
            background-color: #000;
        }

        .form-group {
            margin-bottom: 10px;
        }


        .rlvI1 {
            font-size: 14px;
            border-bottom: 0px solid;
            padding-top: 5px;
            padding-bottom: 3px;
        }

        .rlvIEdit1 {
            width: 400px;
            margin: 15px;
        }

        .RadListView_Metro {
            margin: 5px;
        }

        .RadListView div.rlvI, .RadListView div.rlvA, .RadListView div.rlvISel, .RadListView div.rlvIEmpty, .RadListView div.rlvIEdit1 {
            border-bottom: 0px solid;
        }
    </style>

    <script type="text/javascript">
        // close the div in 5 secs    
        window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version        
            $("#messageHolder").fadeOut("slow", null);
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">



    <div class="container">
        
        <div class="row">

             <div class="row">
             <div id="messageHolder">
                <asp:Literal ID="msgLabel" runat="server" />
             </div>
             </div>


            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                <div style="margin: 0 0 15px 0">
                    <h2>Client Details: 
                        <asp:Label ID="ClientNameLabel" runat="server" Font-Bold="true" />
                    
</h2>
                    <h3>Supplier Details:  <asp:Label ID="SupplierNameLabel" Font-Bold="true" runat="server" /></h3>
              </div> 
                </telerik:RadScriptBlock> 
        </div>

        <div class="row">
            <!-- Tabs -->
            <div id="Tabs" role="tabpanel">
                <ul id="MainTab" class="nav nav-tabs" role="tablist" style="margin-bottom: 3px; border-bottom: 0px">
                    <li class="active"><a href="#defaultinfo" aria-controls="defaultinfo" role="tab" data-toggle="tab">Default Information</a></li>
                    <li class=""><a href="#billingrates" aria-controls="billingrates" role="tab" data-toggle="tab">Billing Rates</a></li>
                    <li class=""><a href="#billingcontact" aria-controls="billingcontact" role="tab" data-toggle="tab">Billing Contact</a></li>
                    <li class=""><a href="#contracts" aria-controls="contracts" role="tab" data-toggle="tab">Contracts/POs/Docs</a></li>
                    <li class=""><a href="#budget" aria-controls="budget" role="tab" data-toggle="tab">Budget Tracking</a></li>
                    <li class=""><a href="#event" aria-controls="event" role="tab" data-toggle="tab">Event Tracking</a></li>
                
                    <li class="pull-right secondarytab"><a href="/admin/ClientDetails?ClientID=<%= Common.GetCurrentClientID()%>#eventtab/suppliers"><i class="fa fa-angle-double-left"></i> &nbsp;Client Overview</a></li>

                </ul>

                <div class="tab-content">

                    <!-- Default Information Tab -->
                    <div class="tab-pane fade active in" role="tabpanel" id="defaultinfo">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <h2>Default Information</h2>

                                <div class="form-horizontal">

                                    <div class="form-group">
                                        <label for="SupplierNameTextBox" class="col-sm-2 control-label">Supplier Name:</label>
                                        <div class="col-sm-6">
                                            <asp:TextBox ID="SupplierNameTextBox" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="SupplierNameTextBox" class="col-sm-2 control-label">Associated Brands:</label>
                                        <div class="col-sm-10">
                                           <uc1:BrandsControl runat="server" id="BrandsControl" />
                                        </div>
                                    </div>



                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- Billing Rates Tab -->

                    <div class="tab-pane fade" role="tabpanel" id="billingrates">
                        <div class="widget stacked">
                            <div class="widget-content">

                               

                                    <h2>Billing Rates</h2>
                               <uc1:BillingRatesControl runat="server" id="BillingRatesControl" />
                            </div>
                        </div>
                    </div>


                    <!-- Billing Contacts Tab -->
                    <div class="tab-pane fade" role="tabpanel" id="billingcontact">
                        <div class="widget stacked">
                            <div class="widget-content">
                                <h2>Billing Contact</h2>
                                
                                <asp:FormView ID="SupplierDetailForm" runat="server" DefaultMode="Edit" DataKeyNames="supplierID" DataSourceID="getSupplier" Width="100%">
                                    <EditItemTemplate>

                                        <asp:Button ID="btnUpdateBillingContact" runat="server" Text="Save Changes" CommandName="Update" CssClass="btn btn-md btn-primary" />
                                        <hr />


                                        <div class="row">

                                            <div class="col-md-6">

                                                <div class="col-md-12">
                                                    <h3>Corporate Address</h3>
                                                </div>


                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                    </div>


                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-6 control-label">Supplier Address 1:</label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="supplierAddress1" runat="server" CssClass="form-control" Text='<%# Bind("supplierAddress1")%>' />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-6 control-label">Supplier Address 2:</label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="supplierAddress2" runat="server" CssClass="form-control" Text='<%# Eval("supplierAddress2")%>' />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-6 control-label">City:</label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="supplierCity" runat="server" CssClass="form-control" Text='<%# Eval("supplierCity")%>' />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-6 control-label">State:</label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="supplierState" runat="server" Width="45px" CssClass="form-control" Text='<%# Eval("supplierState")%>' />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-6 control-label">Zip:</label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="supplierZip" runat="server" Width="90px" CssClass="form-control" Text='<%# Eval("supplierZip")%>' />
                                                        </div>
                                                    </div>
                                                </div>


                                            </div>


                                            <div class="col-md-6">

                                                <div class="col-md-12">
                                                    <h3>Primary Contact</h3>
                                                </div>

                                                <div class="form-horizontal">

                                                    <div class="form-group">
                                                        <label for="ContactName" class="col-sm-6 control-label">Contact Name:</label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="contactName" runat="server" CssClass="form-control" Text='<%# Eval("contactName")%>' />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-6 control-label">Email:</label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="contactEmail" runat="server" CssClass="form-control" Text='<%# Eval("contactEmail")%>' />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-6 control-label">Phone Number:</label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="phoneNumber" runat="server" CssClass="form-control" Text="" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-6 control-label">Supplier Web Site:</label>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="supplierWebSite" runat="server" CssClass="form-control" Text='<%# Eval("supplierWebSite")%>' />
                                                        </div>
                                                    </div>
                                                </div>


                                            </div>

                                        </div>

                                        <hr />


                                        <div class="row">


                                            <div class="col-md-5">
                                                <div class="col-md-12">
                                                    <div class="form-horizontal">
                                                        <div class="form-group">

                                                            <div class="col-md-12">
                                                                <h3>Invioce Header/Bill To:</h3>
                                                                <asp:TextBox ID="invoiceHeader" TextMode="multiline" runat="server"
                                                                    Height="130px" CssClass="form-control" Text='<%# Eval("invoiceHeader")%>' />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-7">

                                                <div class="form-horizontal">
                                                    <h3></h3>
                                                    <br />
                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-4 control-label">Billing Contact Name:</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="billingContactName" runat="server" CssClass="form-control" Text='<%# Eval("billingContactName")%>' />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-4 control-label">Billing Contact Email:</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="billingContactEmail" runat="server" Width="345px" CssClass="form-control" Text='<%# Eval("billingContactEmail")%>' />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="#" class="col-sm-4 control-label">Billing Contact Phone #:</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="billingContactPhone" runat="server" Width="345px" CssClass="form-control" Text='<%# Eval("billingContactPhone")%>' />
                                                        </div>
                                                    </div>

                                                </div>



                                            </div>


                                        </div>
                                        <!-- End Row -->
                                        <hr />

                                        <div class="form-group">
                                            <h3>Billing Notes</h3>
                                            <asp:TextBox ID="billingNotes" TextMode="multiline" runat="server" Height="100px" CssClass="form-control" Text='<%# Eval("billingNotes")%>' />
                                        </div>

                                    </EditItemTemplate>
                                </asp:FormView>
                                
                            </div>
                        </div>
                    </div>


                    
                    <div class="tab-pane fade" role="tabpanel" id="contracts">
                        <div class="widget stacked">
                            <div class="widget-content min-height">
                                <h2>Contracts/POs/Docs</h2>
                                <hr />

                                <uc1:SupplierDocumentsControl runat="server" ID="SupplierDocumentsControl" />
                            </div>
                        </div>
                    </div>


                    <!-- Budget Tracking Tab -->
                    <div class="tab-pane fade" role="tabpanel" id="budget">
                        <div class="widget stacked">
                            <div class="widget-content min-height">
                                <h2>Budget</h2>
                                <hr />

                                <div class="alert alert-warning" role="alert">The Budget Tracking control has not been created yet.</div>

                            </div>
                        </div>
                    </div>


                      <!-- Event Tracking Tab -->
                    <div class="tab-pane fade" role="tabpanel" id="event">
                        <div class="widget stacked">
                            <div class="widget-content min-height">
                                <h2>Event</h2>
                                <hr />
                                <div class="alert alert-warning" role="alert">The Event Tracking control has not been created yet.</div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

            <asp:HiddenField ID="TabName" runat="server" />

            

           

            <br />
          

        </div>

    </div>

     <asp:LinqDataSource ID="getSupplier" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
                EnableUpdate="True" EntityTypeName="" TableName="tblSuppliers" 
                Where="supplierID == @supplierID">
                <WhereParameters>
                    <asp:QueryStringParameter DefaultValue="100" Name="supplierID" QueryStringField="SupplierID" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>

    <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
    <script>

        $(function () {
            var tabName = $("[id*=TabName]").val() != "" ? $("[id*=TabName]").val() : "defaultinfo";
            $('#Tabs a[href="#' + tabName + '"]').tab('show');
            $("#Tabs a").click(function () {
                $("[id*=TabName]").val($(this).attr("href").replace("#", ""));
            });
        });

    </script>
        </telerik:RadScriptBlock>
</asp:Content>
