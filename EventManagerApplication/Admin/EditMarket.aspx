<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditMarket.aspx.vb" Inherits="EventManagerApplication.EditMarket1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Edit Market</title>

    <link href="/Theme/css/base-admin-3.css" rel="stylesheet" />
    <link href="/Theme/css/custom.css" rel="stylesheet" />
    <link href="/Theme/css/custom1.css" rel="stylesheet" />
    <link href="/Theme/css/bootstrap.min.css" rel="stylesheet" />


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
 
            function Close()
            {
                GetRadWindow().close();
            }
    </script>

</head>

<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />

        <div class="container">

            <div class="col-sm-12">

                <h1>Edit Market</h1>

                <div style="margin-top:20px;">
                <asp:LinkButton ID="BtnEdit" runat="server" CssClass="btn btn-primary" ValidationGroup="details" CausesValidation="true">Save</asp:LinkButton>
                <asp:LinkButton ID="BtnCancel" runat="server" CssClass="btn btn-default">Cancel</asp:LinkButton>
                <hr />
                </div>

                <asp:Label ID="msgLabel" runat="server" />

                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-2 control-label">Market Name: <span class="text-danger">*</span></label>
                        <div class="col-sm-6">
                            <asp:TextBox ID="MarketNameTextBox" runat="server" CssClass="form-control" />

                            <asp:RequiredFieldValidator ID="EventNameRequiredFieldValidator" runat="server"
                            ErrorMessage="Market Name is required" CssClass="errorlabel" ControlToValidate="MarketNameTextBox"
                            Display="Dynamic" ValidationGroup="details"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">Active</label>
                        <div class="col-sm-3">
                            <telerik:RadComboBox ID="ActiveComboBox" runat="server">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Yes" Value="True" />
                                    <telerik:RadComboBoxItem Text="No" Value="False" />
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">Region</label>
                        <div class="col-sm-3">
                            <telerik:RadComboBox ID="RegionComboBox" runat="server">
                                <Items>
                                    <telerik:RadComboBoxItem Text="USA" Value="1" />
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">Latitude <span class="text-danger">*</span></label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="LatitudeTextBox" runat="server" CssClass="form-control" />

                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                            ErrorMessage="Latitude is required" CssClass="errorlabel" ControlToValidate="LatitudeTextBox"
                            Display="Dynamic" ValidationGroup="details"></asp:RequiredFieldValidator>

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">Longitude <span class="text-danger">*</span></label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="LongitudeTextBox" runat="server" CssClass="form-control" />

                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                            ErrorMessage="Longitude is required" CssClass="errorlabel" ControlToValidate="LongitudeTextBox"
                            Display="Dynamic" ValidationGroup="details"></asp:RequiredFieldValidator>

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">Time Zone</label>
                        <div class="col-sm-6">
                            <telerik:RadComboBox ID="TimeZoneComboBox" runat="server" DataSourceID="getTimeZones" Width="400px"
                             EmptyMessage="Select Time Zone"  DataTextField="DisplayName" DataValueField="Id"></telerik:RadComboBox>

                                                    <asp:LinqDataSource ID="getTimeZones" runat="server"
                                                        ContextTypeName="EventManagerApplication.LMSDataClassesDataContext"
                                                        EntityTypeName="" OrderBy="TimeZoneID" TableName="TimeZones"></asp:LinqDataSource>

                        </div>
                    </div>
                    
                </div>

            </div>
                    
        </div>
    </form>
</body>

</html>
