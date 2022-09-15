<%@ Page Title="Edit POS Kit" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditPosKit.aspx.vb" Inherits="EventManagerApplication.EditPosKit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-group {
            margin-bottom: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <div class="container">

        <div class="row">
            <div class="col-xs-12 eventDetails">
                <h2>POS Kit Details</h2>

                <ol class="breadcrumb">
                    <li><a href="/">Dashboard</a></li>
                    <li><a href="/admin/viewPOS?LoadState=Yes">POS/Logistics</a></li>
                    <li class="active">POS Details</li>
                </ol>


                <div class="detail">

                    <div class="btn-group pull-right" role="group" aria-label="...">
                        <asp:LinkButton ID="btnReturn" runat="server" CssClass="btn btn-default" PostBackUrl="~/Admin/ViewPOS.aspx"><i class="fa fa-chevron-left" aria-hidden="true"></i> Return</asp:LinkButton>

                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CssClass="btn btn-danger"  
                        OnClientClick="javascript:if(!confirm('This action will delete the POS Kit. Are you sure?')){return false;}" >
                        <i class="fa fa-trash" aria-hidden="true"></i> Delete</asp:LinkButton>
                    </div>


                    Event Name:
                    <asp:Label ID="EventNameLabel" runat="server" Font-Bold="true" /><br />
                    Date:
                    <asp:Label ID="EventDateLabel" runat="server" Font-Bold="true" /><br />
                    Event ID:
                    <asp:Label ID="EventIDLabel" runat="server" Font-Bold="true" /><br />
                    Requested by:
                    <asp:Label ID="RequestedByLabel" runat="server" Font-Bold="true" /> on <asp:Label ID="OnLabel" runat="server" Font-Bold="true" /><br />

                    <asp:Label ID="TrackingResultLabel" runat="server" />

                </div>

                <hr />
            </div>
        </div>


        <div class="row">
            <div class="col-md-12">

                <div class="col-md-9">
                    <div class="widget stacked">
                        <div class="widget-content">

                            <telerik:RadListView ID="PosItemsLists" runat="server" DataKeyNames="PosKitItemID" DataSourceID="getKitItems" Skin="Bootstrap" InsertItemPosition="FirstItem">
                                <LayoutTemplate>
                                    <div class="RadListView RadListView_Bootstrap">
                                        <table style="width: 100%;">
                                            <thead>
                                                <tr class="rlvHeader">
                                                    <th>Qty</th>

                                                    <th>Item Name</th>

                                                    <th>Price</th>
                                                    <th>Total</th>
                                                    <th>&nbsp;</th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                                <tr runat="server" id="itemPlaceholder"></tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr class="rlvI">

                                        <td>
                                            <asp:Label Text='<%# Eval("qty") %>' runat="server" ID="qtyLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("itemName") %>' runat="server" ID="itemNameLabel" /></td>

                                        <td>
                                            <asp:Label Text='<%# Eval("price") %>' runat="server" ID="priceLabel" /></td>

                                        <td>$<%# getTotal(Eval("PosKitItemID")) %></td>

                                        <td>

                                            <div class="btn-group" role="group" aria-label="...">

                                            <asp:LinkButton runat="server" CommandName="Edit" ID="EditButton" CssClass="btn btn-sm btn-default" ToolTip="Edit" CausesValidation="False"><i class="fa fa-pencil" aria-hidden="true"></i> Edit</asp:LinkButton>

                                            <asp:LinkButton runat="server" CommandName="Delete"  ID="DeleteButton" CssClass="btn btn-sm btn-danger" ToolTip="Delete" CausesValidation="False" OnClientClick="javascript:if(!confirm('This action will delete the selected item. Are you sure?')){return false;}" ><i class="fa fa-trash" aria-hidden="true"></i> Delete</asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>


                                </ItemTemplate>

                                <EditItemTemplate>

                                    <tr class="rlvIEdit">


                                        <td>
                                            <telerik:RadNumericTextBox DbValue='<%# Bind("qty") %>' runat="server" ID="qtyTextBox" NumberFormat-DecimalDigits="0" DataType="Int32" MinValue="0"></telerik:RadNumericTextBox> <span class="text-danger">*</span>  
                                            <asp:RequiredFieldValidator ID="EventNameRequiredFieldValidator" runat="server"
                                            CssClass="errorlabel" ControlToValidate="qtyTextBox"
                                            Display="None" ValidationGroup="details"></asp:RequiredFieldValidator>
                                        </td>

                                        <td >
                                            <asp:TextBox Text='<%# Bind("itemName") %>' runat="server" ID="itemNameTextBox" CssClass="form-control" />
                                        </td>

                                        <td>
                                            <telerik:RadNumericTextBox DbValue='<%# Bind("price") %>' runat="server" ID="priceTextBox" DataType="Decimal" MinValue="0">
                                            </telerik:RadNumericTextBox> <span class="text-danger">*</span> 
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            CssClass="errorlabel" ControlToValidate="priceTextBox"
                                            Display="None" ValidationGroup="details"></asp:RequiredFieldValidator>
                                        </td>

                                        <td>$<%# getTotal(Eval("PosKitItemID")) %></td>


                                        <td>
                                            <div class="btn-group" role="group" aria-label="...">

                                            <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" CssClass="btn btn-sm btn-primary" ToolTip="Update" ValidationGroup="details" />
                                            <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" CssClass="btn btn-sm btn-default" ToolTip="Cancel" CausesValidation="False" />
                                                </div>
                                        </td>

                                    </tr>

                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <tr class="rlvIEdit">
                                        <td>
                                            <telerik:RadNumericTextBox DbValue='<%# Bind("qty") %>' runat="server" ID="qtyTextBox" NumberFormat-DecimalDigits="0" DataType="Int32" />
                                        </td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("itemName") %>' runat="server" ID="itemNameTextBox" CssClass="form-control" />
                                        </td>
                                        <td>

                                            <telerik:RadNumericTextBox DbValue='<%# Bind("price") %>' runat="server" ID="priceTextBox" DataType="Decimal" /></td>

                                        <td>&nbsp;</td>

                                        <td>

                                            <asp:LinkButton runat="server" CommandName="PerformInsert" Text=" " ID="PerformInsertButton" CssClass="btn btn-sm btn-success" ToolTip="Insert" > Add Item</asp:LinkButton>
                                            <asp:LinkButton runat="server" CommandName="Cancel" Text=" " ID="CancelButton" CssClass="btn btn-sm btn-default" ToolTip="Cancel" CausesValidation="False" >Cancel</asp:LinkButton>

                                        </td>


                                    </tr>
                                </InsertItemTemplate>
                                <EmptyDataTemplate>
                                    <div class="RadListView RadListView_Bootstrap">
                                        <div class="rlvEmpty">There are no items to be displayed.</div>
                                    </div>
                                </EmptyDataTemplate>
<%--                                <SelectedItemTemplate>
                                    <tr class="rlvISel">

                                        <td>
                                            <asp:Label Text='<%# Eval("qty") %>' runat="server" ID="qtyLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("itemName") %>' runat="server" ID="itemNameLabel" /></td>

                                        <td>
                                            <asp:Label Text='<%# Eval("price") %>' runat="server" ID="priceLabel" /></td>

                                        <td>Total</td>

                                        <td>
                                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" CssClass="btn btn-sm btn-primary" ToolTip="Edit" CausesValidation="False" />
                                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" CssClass="btn btn-sm btn-danger" ToolTip="Delete" CausesValidation="False" OnClientClick="javascript:if(!confirm('This action will delete the selected item. Are you sure?')){return false;}" />

                                        </td>
                                    </tr>
                                </SelectedItemTemplate>--%>
                            </telerik:RadListView>

                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getKitItems" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblPosKitItems" Where="kitID == @kitID" EnableDelete="True" EnableInsert="True" EnableUpdate="True">
                                <WhereParameters>
                                    <asp:QueryStringParameter QueryStringField="KitID" Name="kitID" Type="Int32"></asp:QueryStringParameter>
                                </WhereParameters>
                            </asp:LinqDataSource>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">

            <div class="col-md-12">

                <div class="col-md-6">

                    <div class="widget stacked">
                        <div class="widget-content">
                            <h3>Ship to:</h3>
                            <hr />
                            <div class="form-horizontal">

                                <div class="form-group">
                                    <asp:Label ID="NameLabel" runat="server" Text="Name" Font-Bold="true" class="col-sm-2 control-label"></asp:Label>

                                    <div class="col-sm-5">
                                        <asp:TextBox ID="NameTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="AddressLabel" runat="server" Text="Address" Font-Bold="true" class="col-sm-2 control-label"></asp:Label>

                                    <div class="col-sm-5">
                                        <asp:TextBox ID="AddressTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="CityLabel" runat="server" Text="City" Font-Bold="true" class="col-sm-2 control-label"></asp:Label>

                                    <div class="col-sm-5">
                                        <asp:TextBox ID="CityTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="StateLabel" runat="server" Text="State" Font-Bold="true" class="col-sm-2 control-label"></asp:Label>

                                    <div class="col-sm-3">

                                        <asp:DropDownList ID="StateDropDownList" runat="server" CssClass="form-control" Width="175px">
                                                <asp:ListItem Value="">Please Select</asp:ListItem>
                                                <asp:ListItem Value="AL">Alabama</asp:ListItem>
                                                <asp:ListItem Value="AK">Alaska</asp:ListItem>
                                                <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                                                <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                                                <asp:ListItem Value="CA">California</asp:ListItem>
                                                <asp:ListItem Value="CO">Colorado</asp:ListItem>
                                                <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                                                <asp:ListItem Value="DC">District of Columbia</asp:ListItem>
                                                <asp:ListItem Value="DE">Delaware</asp:ListItem>
                                                <asp:ListItem Value="FL">Florida</asp:ListItem>
                                                <asp:ListItem Value="GA">Georgia</asp:ListItem>
                                                <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                                                <asp:ListItem Value="ID">Idaho</asp:ListItem>
                                                <asp:ListItem Value="IL">Illinois</asp:ListItem>
                                                <asp:ListItem Value="IN">Indiana</asp:ListItem>
                                                <asp:ListItem Value="IA">Iowa</asp:ListItem>
                                                <asp:ListItem Value="KS">Kansas</asp:ListItem>
                                                <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                                                <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                                                <asp:ListItem Value="ME">Maine</asp:ListItem>
                                                <asp:ListItem Value="MD">Maryland</asp:ListItem>
                                                <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                                                <asp:ListItem Value="MI">Michigan</asp:ListItem>
                                                <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                                                <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                                                <asp:ListItem Value="MO">Missouri</asp:ListItem>
                                                <asp:ListItem Value="MT">Montana</asp:ListItem>
                                                <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                                                <asp:ListItem Value="NV">Nevada</asp:ListItem>
                                                <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                                                <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                                                <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                                                <asp:ListItem Value="NY">New York</asp:ListItem>
                                                <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                                                <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                                                <asp:ListItem Value="OH">Ohio</asp:ListItem>
                                                <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                                                <asp:ListItem Value="OR">Oregon</asp:ListItem>
                                                <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                                                <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                                                <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                                                <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                                                <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                                                <asp:ListItem Value="TX">Texas</asp:ListItem>
                                                <asp:ListItem Value="UT">Utah</asp:ListItem>
                                                <asp:ListItem Value="VT">Vermont</asp:ListItem>
                                                <asp:ListItem Value="VA">Virginia</asp:ListItem>
                                                <asp:ListItem Value="WA">Washington</asp:ListItem>
                                                <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                                                <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                                                <asp:ListItem Value="WY">Wyoming</asp:ListItem>

                                            </asp:DropDownList>



                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="ZipLabel" runat="server" Text="Zip" Font-Bold="true" class="col-sm-2 control-label"></asp:Label>

                                    <div class="col-sm-4">
                                        <asp:TextBox ID="ZipTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>

                                <hr />

                                 <div class="form-group">
                                    <label class="col-sm-2 control-label">Notes</label>

                                    <div class="col-sm-10">
                                        <asp:Label ID="NotesLabel" runat="server" />
                                    </div>
                                </div>




                            </div>
                        </div>
                    </div>

                    
                </div>

                <div class="col-md-6">

                    <div class="widget stacked">
                        <div class="widget-content">
                            <h3>Shipping Cost:</h3>
                            <hr />

                            <div style="margin: 10px;">

                                <div class="form-horizontal">

                                    <div class="form-group">

                                        <label class="col-sm-4 control-label">Shipping Vendor</label>
                                        <div class="col-sm-8">

                                            <telerik:RadComboBox ID="ShippingVendorComboBox" runat="server" DataSourceID="getShippingVendorList" AutoPostBack="true" MarkFirstMatch="True" AllowCustomText="True" DataTextField="ShippingVendorName" DataValueField="ShippingVendorID" EmptyMessage="Select Shipping Vendor"></telerik:RadComboBox>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getShippingVendorList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="ShippingVendorName" TableName="tblShippingVendors"></asp:LinqDataSource>

                                        </div>
                                    </div>


                                    <div class="form-group">

                                        <label class="col-sm-4 control-label">Shipping Method</label>
                                        <div class="col-sm-8">

                                            <telerik:RadComboBox ID="ShippingMethodComboBox" runat="server" MarkFirstMatch="True" AllowCustomText="True" DataTextField="shippingMethodTitle" DataValueField="shippingMethodID" Width="250px" EmptyMessage="Select Shipping Method" DataSourceID="getShippingMethodList"></telerik:RadComboBox>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getShippingMethodList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="shippingMethodID" TableName="tblShippingMethods" Where="shippingVendorID == @shippingVendorID">
                                                <WhereParameters>
                                                    <asp:ControlParameter ControlID="ShippingVendorComboBox" PropertyName="SelectedValue" Name="shippingVendorID" Type="Int32"></asp:ControlParameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>

                                        </div>
                                    </div>


                                    <div class="form-group">

                                        <label class="col-sm-4 control-label">Shipping Status</label>
                                        <div class="col-sm-8">

                                            <telerik:RadComboBox ID="ShippingStatusComboBox" runat="server" MarkFirstMatch="True" AllowCustomText="True" Width="250px">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Pending" Value="Pending" />
                                                    <telerik:RadComboBoxItem Text="Canceled" Value="Canceled" />
                                                    <telerik:RadComboBoxItem Text="Shipped" Value="Shipped" />
                                                    <telerik:RadComboBoxItem Text="Delivered" Value="Delivered" />
                                                </Items>
                                            </telerik:RadComboBox>



                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Date</label>
                                        <div class="col-sm-3">

                                            <telerik:RadDatePicker ID="DatePicker" runat="server" Culture="en-US">
                                                <DateInput runat="server" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%"></DateInput>
                                                <Calendar runat="server">
                                                    <SpecialDays>
                                                        <telerik:RadCalendarDay Repeatable="Today">
                                                            <ItemStyle CssClass="rcToday" />
                                                        </telerik:RadCalendarDay>
                                                    </SpecialDays>
                                                </Calendar>
                                            </telerik:RadDatePicker>

                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Shipping Cost</label>
                                        <div class="col-sm-3">

                                            <telerik:RadNumericTextBox ID="PriceNumericTextBox" runat="server" Culture="en-US" DbValueFactor="1" Type="Currency" Width="160px" Value="0">
                                                <NumberFormat ZeroPattern="$n"></NumberFormat>
                                                <ClientEvents OnBlur="OnBlur" />
                                            </telerik:RadNumericTextBox>

                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Handling Fee</label>
                                        <div class="col-sm-3">
                                            <telerik:RadNumericTextBox ID="HandlingFeeNumericTextBox" runat="server" Culture="en-US" DbValueFactor="1" Type="Currency" Width="160px" Value="0">
                                                <NumberFormat ZeroPattern="$n"></NumberFormat>
                                                <ClientEvents OnBlur="OnBlur" />
                                            </telerik:RadNumericTextBox>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <asp:Label ID="TrackingLabel" runat="server" Text="Tracking #" Font-Bold="true" class="col-sm-4 control-label"></asp:Label>

                                        <div class="col-sm-8">
                                            <asp:TextBox ID="TrackingTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <asp:Label ID="Label1" runat="server" Text="Return Tracking #" Font-Bold="true" class="col-sm-4 control-label"></asp:Label>

                                        <div class="col-sm-8">
                                            <asp:TextBox ID="ReturnTrackingTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>

                                </div>

                            </div>


                            <div class="pull-right">

                            <asp:Button ID="btnSubmit" runat="server" Text="Update" CssClass="btn btn-primary" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default" />
                        </div>

                        </div>
                    </div>


                    <div class="col-md-12">

                    </div>

                </div>






            </div>


        </div>
        </div>

        </telerik:RadAjaxPanel>

    <script>
        function OnBlur(sender, args) {
            if (sender.get_value() == "") {
                sender.set_value("0");
            }
        }

    </script>
</asp:Content>
