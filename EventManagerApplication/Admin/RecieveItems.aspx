<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RecieveItems.aspx.vb" Inherits="EventManagerApplication.RecieveItems" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="../Theme/css/custom1.css" rel="stylesheet" />
    <link href="/theme/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />

    <title></title>

    <script type="text/javascript">
            function CloseAndRebind(args)
            {
                GetRadWindow().BrowserWindow.refreshGrid(args);
                GetRadWindow().close();
            }

            function GetRadWindow()
            {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

                return oWindow;
            }

            function CancelEdit()
            {
                GetRadWindow().close();
            }
        </script>

    <style>
        html {
            overflow: hidden !important;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <div class="container">

        <div class="row">
            <h3>Receive Inventory Item</h3>

             <div class="col-md-8 margintop20">
                <div class="form-horizontal">

                <div class="form-group">
                    <label for="SupplierComboBox" class="col-sm-3 control-label">Brand</label>
                    <div class="col-md-6">

                        <telerik:RadComboBox ID="SupplierComboBox" runat="server" EmptyMessage="Select a Brand" Width="320px" MarkFirstMatch="True" AllowCustomText="True" DataTextField="brandName" DataValueField="brandID" DataSourceID="getBrandList" AutoPostBack="true">
                        </telerik:RadComboBox>


                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getBrandList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="brandName" Select="new (brandID, brandName)" TableName="tblBrands"></asp:LinqDataSource>
                    </div>
                </div>
                                   

                <div class="form-group">
                    <label for="ItemComboBox" class="col-sm-3 control-label">Item Name</label>
                    <div class="col-md-6">

                        <telerik:RadComboBox ID="ItemComboBox" runat="server" EmptyMessage="Select an Item" Width="320px" MarkFirstMatch="True" AllowCustomText="True" DataTextField="itemName" DataValueField="itemID" AutoPostBack="true"></telerik:RadComboBox>

                    </div>
                </div>

                <asp:SqlDataSource runat="server" ID="getInventoryList" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [qryViewPOSKitbySupplier] WHERE ([clientID] = @clientID)">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                    </SelectParameters>

                </asp:SqlDataSource>


                <div class="form-group">
                    <label for="RecievedDateTextBox" class="col-sm-3 control-label">Shipment Received Date</label>
                    <div class="col-md-4">
                        <telerik:RadDatePicker ID="RecievedDateTextBox" runat="server"></telerik:RadDatePicker>
                    </div>
                </div>

                <div class="form-group">
                    <label for="QtyTextBox" class="col-sm-3 control-label">Quantity Received</label>
                    <div class="col-md-3">
                        <telerik:RadNumericTextBox ID="QtyTextBox" Type="Number" runat="server"  Skin="Bootstrap" Width="100px" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" MinValue="0" Value="0"></telerik:RadNumericTextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="NotesTextBox" class="col-sm-3 control-label">Notes</label>
                    <div class="col-md-7">
                        <asp:TextBox ID="NotesTextBox" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                    </div>
                </div>
                    
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-9">
                        <asp:Button ID="btnSubmitInventory" runat="server" Text="Submit" CssClass="btn btn-primary"  />
                        <asp:Button ID="btnCancelEditExpense" runat="server" Text="Cancel" CssClass="btn btn-default" />

                    </div>
                </div>

                </div>
            </div>



            <div class="col-md-4 margintop20">
                <div class="form-horizontal">

                    <asp:Repeater ID="PhotoItemRepeater" runat="server">
                        <ItemTemplate>

                        <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                            <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="thumbnail"
                                DataValue='<%#IIf(TypeOf (Eval("image")) Is DBNull, Nothing, Eval("image"))%>'
                                Height="240px" Width="240px" ResizeMode="Fit" />
                            </div>

                        </div>

                        </ItemTemplate>
                    </asp:Repeater>


                </div>
            </div>


        </div>

    </div>
    </form>
</body>
</html>
