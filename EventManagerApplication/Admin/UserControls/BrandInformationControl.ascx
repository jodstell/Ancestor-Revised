<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandInformationControl.ascx.vb" Inherits="EventManagerApplication.BrandInformationControl" %>
<%@ Register Src="~/Admin/UserControls/AssociatedSuppliersControl.ascx" TagPrefix="uc1" TagName="AssociatedSuppliersControl" %>


<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">



    <div class="form-horizontal">

        <div class="form-group">
            <label for="BrandNameTextBox" class="col-sm-2 control-label">Brand Name:</label>
            <div class="col-sm-6">
                <asp:TextBox ID="BrandNameTextBox" runat="server" CssClass="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label for="AssociatedSuppliersListBox" class="col-sm-2 control-label">Associated Suppliers:</label>
            <div class="col-sm-10">
                <uc1:AssociatedSuppliersControl runat="server" ID="AssociatedSuppliersControl" />
            </div>
        </div>

        <div class="form-group">
            <label for="ActiveTextBox" class="col-sm-2 control-label">Active:</label>
            <div class="col-sm-2">
                <asp:DropDownList ID="ActiveTextBox" runat="server" CssClass="form-control" Width="150px">
                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                </asp:DropDownList>

            </div>
        </div>

        <div class="form-group">
            <label for="StartDateTextBox" class="col-sm-2 control-label">Brand Start Date:</label>
            <div class="col-sm-10">
                <div class="form-inline">
                    <telerik:RadDatePicker ID="StartDateTextBox" runat="server" Width="150px"
                        CssClass="form-control">
                    </telerik:RadDatePicker>

                    <label for="EndDateTextBox" class="control-label" style="padding-right: 15px; padding-left: 20px;">Brand End Date:</label>
                    <telerik:RadDatePicker ID="EndDateTextBox" runat="server" Width="150px" CssClass="form-control"></telerik:RadDatePicker>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="DataViewEndDateTextBox" class="col-sm-2 control-label">Data View End Date:</label>
            <div class="col-sm-2">
                <telerik:RadDatePicker ID="DataViewEndDateTextBox" runat="server" Width="150px" CssClass="form-control"></telerik:RadDatePicker>
            </div>
        </div>

        <hr />

        <div class="form-group">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-10">
                <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CssClass="btn btn-md btn-primary" />
            </div>
        </div>

    </div>

</telerik:RadAjaxPanel>

