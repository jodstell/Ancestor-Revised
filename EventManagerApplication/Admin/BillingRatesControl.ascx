<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BillingRatesControl.ascx.vb" Inherits="EventManagerApplication.BillingRatesControl" %>

<style>
    html body .RadInput_Bootstrap .riTextBox, html body .RadInputMgr_Bootstrap {
        height: 30px;
        padding: 6px 12px;
    }
</style>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel12">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel10" LoadingPanelID="RadAjaxLoadingPanel2" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="Panel12">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="Panel11" LoadingPanelID="RadAjaxLoadingPanel2" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<asp:Panel ID="Panel12" runat="server">

    <asp:Panel ID="Panel10" runat="server">

        <div class="col-md-12">
    <telerik:RadListView ID="BillingRates_EventTypeList" runat="server" DataKeyNames="BillingRateID"
        DataSourceID="getBillingRates_EventType" InsertItemPosition="FirstItem" Skin="Metro">

        <LayoutTemplate>
            <div class="RadListView RadListView_Metro1">
                <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                    CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New</asp:LinkButton>

                <h3>Event Type</h3>

                <div id="itemPlaceholder" runat="server">
                </div>
            </div>
        </LayoutTemplate>

        <ItemTemplate>
            <div class="rlvI1">
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                    CssClass="btn btn-xs btn-default" ToolTip="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>

                <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                    CssClass="btn btn-xs btn-danger" ToolTip="Edit"><i class="fa fa-trash"></i> Delete</asp:LinkButton>


                &nbsp;<asp:Label ID="RelatedItemIDLabel" runat="server" Text='<%# getEventTypeName(Eval("RelatedItemID"))%>' />:
                                                &nbsp;$<asp:Label ID="RateLabel" runat="server" Text='<%# Eval("Rate") %>' />/<asp:Label ID="BillingRateTypeLabel" runat="server" Text='<%# Eval("BillingRateType") %>' />

            </div>
        </ItemTemplate>

       

        <EditItemTemplate>
            <div class="rlvIEdit1">
                <div class="panel panel-default">
                    <div class="panel-body">


                        <div class="form-horizontal">
                            <div class="form-group">
                                <label for="ddlActivity" class="col-sm-2 control-label">Activity</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlActivity" runat="server" CssClass="form-control input-sm"
                                        DataSourceID="getEventTypeList" AppendDataBoundItems="true" DataTextField="eventTypeName" DataValueField="eventTypeID" SelectedValue='<%# Eval("RelatedItemID") %>'>
                                        <asp:ListItem Text="-- Select Activity --" Value="">
                                        </asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ErrorMessage="Activity is required" CssClass="errorlabel" ControlToValidate="ddlActivity"
                                    Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="RateTextBox" class="col-sm-2 control-label">Rate</label>
                                <div class="col-sm-5">
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-addon">$</span>
                                        <asp:TextBox ID="RateTextBox" runat="server" CssClass="form-control"
                                            Text='<%# Bind("Rate") %>' />
                                        <span class="input-group-addon">Hour</span>
                                    </div>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    ErrorMessage="Rate is required" CssClass="errorlabel" ControlToValidate="RateTextBox"
                                    Display="Dynamic" ValidationGroup="billing" /><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid number" CssClass="errorlabel" ControlToValidate="RateTextBox"
                                    Display="Dynamic" ValidationGroup="billing" ValidationExpression="^[1-9]\d*(\.\d+)?$" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"></label>
                                <div class="col-sm-10">
                                    <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-xs btn-primary" ValidationGroup="billing" />
                                    <asp:Button ID="btnCancelUpdate" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-xs btn-default" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </EditItemTemplate>

        <InsertItemTemplate>

            <div class="rlvIEdit1">
                <div class="panel panel-default">
                    <div class="panel-body">

                        <h5>Add new billing rate:</h5>

                        <div class="form-horizontal">
                            <div class="form-group">
                                <label for="ddlActivity1" class="col-sm-2 control-label">Activity</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlActivity1" runat="server" CssClass="form-control input-sm"
                                        DataSourceID="getEventTypeList" AppendDataBoundItems="true" DataTextField="eventTypeName"
                                        DataValueField="eventTypeID" SelectedValue='<%# Bind("RelatedItemID") %>'>
                                        <asp:ListItem Text="-- Select Activity --" Value="">
                                        </asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                    ErrorMessage="Activity is required" CssClass="errorlabel" ControlToValidate="ddlActivity1"
                                    Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="txtRate1" class="col-sm-2 control-label">Rate</label>
                                <div class="col-sm-5">
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-addon">$</span>
                                        <asp:TextBox ID="txtRate1" runat="server" CssClass="form-control"
                                            Text='<%# Bind("Rate")%>' />
                                        <span class="input-group-addon">Hour</span>
                                    </div>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ErrorMessage="Rate is required" CssClass="errorlabel" ControlToValidate="txtRate1"
                                    Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid number" CssClass="errorlabel" 
                                        ControlToValidate="txtRate1" Display="Dynamic" ValidationGroup="billing" ValidationExpression="^[1-9]\d*(\.\d+)?$" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"></label>
                                <div class="col-sm-10">
                                    <asp:Button ID="btnInsert1" runat="server" CommandName="PerformInsert" Text="Save" CssClass="btn btn-xs btn-primary" ValidationGroup="billing" />
                                    <asp:Button ID="btnCancelInsert1" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-xs btn-default" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </InsertItemTemplate>

        <EmptyDataTemplate>
             <div class="RadListView RadListView_Metro1">

                <asp:LinkButton ID="btnInsert1" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                    Text="" CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New</asp:LinkButton>

                <h3>Event Types</h3>
                <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add</strong> button above.</div>
            </div>
        </EmptyDataTemplate>

    </telerik:RadListView>
        </div>

    <asp:LinqDataSource ID="getBillingRates_EventType" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblSupplierBillingRates" Where="SupplierID == @SupplierID &amp;&amp; RateType == @RateType">
        <WhereParameters>
            <asp:QueryStringParameter DefaultValue="100" Name="SupplierID" QueryStringField="SupplierID" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="RateType" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="getEventTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="eventTypeName" TableName="qryEventTypeByClients" Where="clientID == @clientID">
        <WhereParameters>
            <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
        </WhereParameters>
    </asp:LinqDataSource>

        </asp:Panel>
    <hr />


        <div class="col-md-12">
                <hr />
                <h3>Agency Fees</h3>

                <table class="table tight_table" style="width: 600px
">
                    <tbody>
                        <tr>

                            <th style="width: 155px">Fee</th>
                            <th style="width: 200px">Rate</th>
                            <th></th>
                        </tr>
                        <tr>

                            <td style="width: 200px">Management Fee</td>
                            <td style="width: 200px">

                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="ManagementFeeNumericTextBox" Type="Percent" MinValue="0" MaxValue="100" Width="100px" NumberFormat-DecimalDigits="0" ValidationGroup="ManagementFee" /> <asp:Button ID="btnUpdateManagementFee" runat="server" Text="Update" CssClass="btn btn-sm btn-default" ValidationGroup="ManagementFee" />
                            </td>
                            <td><asp:RequiredFieldValidator ID="ManagementFeeRequiredFieldValidator" runat="server"
                            ErrorMessage="The value can not be blank" CssClass="errorlabel" ControlToValidate="ManagementFeeNumericTextBox"
                            Display="Dynamic" ValidationGroup="ManagementFee"></asp:RequiredFieldValidator>
                                </td>
                        </tr>
                        <tr>

                            <td>Sampling/Product Spend Fee</td>
                            <td>
                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="SamplingFeeNumericTextBox" Type="Percent" MinValue="0" MaxValue="100" Width="100px" NumberFormat-DecimalDigits="0" /> <asp:Button ID="btnUpdateSamplingFee" runat="server" Text="Update" CssClass="btn btn-sm btn-default" ValidationGroup="SamplingFee" />
                            </td>
                            <td><asp:RequiredFieldValidator ID="SamplingFeeRequiredFieldValidator" runat="server"
                            ErrorMessage="The value can not be blank" CssClass="errorlabel" ControlToValidate="SamplingFeeNumericTextBox"
                            Display="Dynamic" ValidationGroup="SamplingFee"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>

                            <td>POS Storage</td>
                            <td>
                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="POSNumberBox" Type="Currency" MinValue="0" Width="100px" NumberFormat-DecimalDigits="2" /> <asp:Button ID="btnUpdatePOS" runat="server" Text="Update" CssClass="btn btn-sm btn-default" ValidationGroup="POSNumber"  />


                            </td>
                            <td> <asp:RequiredFieldValidator ID="POSNumberBoxRequiredFieldValidator" runat="server"
                            ErrorMessage="The value can not be blank" CssClass="errorlabel" ControlToValidate="POSNumberBox"
                            Display="Dynamic" ValidationGroup="POSNumber"></asp:RequiredFieldValidator></td>
                    </tbody>
                </table>

<hr />
                                        </div>


<asp:Panel ID="Panel11" runat="server">
      <div class="col-md-12">
    <telerik:RadListView ID="BillingRates_MarketSurchargeList" runat="server" DataKeyNames="BillingRateID"
        DataSourceID="getMarketSurcharge" InsertItemPosition="FirstItem" Skin="Metro">

        <LayoutTemplate>
            <div class="RadListView RadListView_Metro1">

                <asp:LinkButton ID="btnInsert1" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                    CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New</asp:LinkButton>

                <h3>Market Surcharge</h3>
                <div id="itemPlaceholder" runat="server">
                </div>
            </div>
        </LayoutTemplate>

        <ItemTemplate>
            <div class="rlvI1">
                <asp:LinkButton ID="EditButton2" runat="server" CausesValidation="False" CommandName="Edit"
                    CssClass="btn btn-xs btn-default" ToolTip="Edit"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>

                <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                    CssClass="btn btn-xs btn-danger" ToolTip="Edit"><i class="fa fa-trash"></i> Delete</asp:LinkButton>

                &nbsp;<asp:Label ID="RelatedItemIDLabel" runat="server" Text='<%# getMarketName(Eval("RelatedItemID"))%>' />:
                                                &nbsp;$<asp:Label ID="RateLabel" runat="server" Text='<%# Eval("Rate") %>' />/<asp:Label ID="MarketLabel" runat="server" Text='<%# Eval("BillingRateType") %>' />
                <%--&nbsp;<asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="rlvBDel" Text=" " ToolTip="Delete" />--%>
            </div>
        </ItemTemplate>

        <EditItemTemplate>
            <div class="rlvIEdit1">
                <div class="panel panel-default">
                    <div class="panel-body">


                        <div class="form-horizontal">
                            <div class="form-group">
                                <label for="ddlMarkets" class="col-sm-2 control-label">Market</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlMarkets" runat="server" CssClass="form-control input-sm"
                                        DataSourceID="getMarketList" AppendDataBoundItems="true"
                                        DataTextField="marketName" DataValueField="marketID"
                                        SelectedValue='<%# Eval("RelatedItemID") %>'>
                                        <asp:ListItem Text="-- Select Market --" Value="">
                                        </asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    ErrorMessage="Market is required" CssClass="errorlabel" ControlToValidate="ddlMarkets"
                                    Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="RateTextBox" class="col-sm-2 control-label">Rate</label>
                                <div class="col-sm-5">
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-addon">$</span>
                                        <asp:TextBox ID="RateTextBox" runat="server" CssClass="form-control"
                                            Text='<%# Bind("Rate") %>' />
                                        <span class="input-group-addon">Hour</span>
                                    </div>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                    ErrorMessage="Rate is required" CssClass="errorlabel" ControlToValidate="RateTextBox"
                                    Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid number" CssClass="errorlabel" ControlToValidate="RateTextBox" 
                                        Display="Dynamic" ValidationGroup="billing" ValidationExpression="^[1-9]\d*(\.\d+)?$" ></asp:RegularExpressionValidator>

                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"></label>
                                <div class="col-sm-10">
                                    <asp:Button ID="btnUpdate3" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-xs btn-primary" ValidationGroup="billing" />
                                    <asp:Button ID="btnCancelUpdate3" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-xs btn-default" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </EditItemTemplate>

        <InsertItemTemplate>

            <div class="rlvIEdit1">
                <div class="panel panel-default">
                    <div class="panel-body">

                        <h5>Add new billing rate:</h5>

                        <div class="form-horizontal">
                            <div class="form-group">
                                <label for="ddlMarkets2" class="col-sm-2 control-label">Market</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlMarkets5" runat="server" CssClass="form-control input-sm"
                                        DataSourceID="getMarketList" AppendDataBoundItems="true"
                                        DataTextField="marketName" DataValueField="marketID"
                                        SelectedValue='<%# Bind("RelatedItemID") %>'>
                                        <asp:ListItem Text="-- Select Market --" Value="">
                                        </asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                    ErrorMessage="Market is required" CssClass="errorlabel" ControlToValidate="ddlMarkets5"
                                    Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="txtRate" class="col-sm-2 control-label">Rate</label>
                                <div class="col-sm-5">
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-addon">$</span>
                                        <asp:TextBox ID="txtRate5" runat="server" CssClass="form-control"
                                            Text='<%# Bind("Rate")%>' />
                                        <span class="input-group-addon">Hour</span>
                                    </div>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                    ErrorMessage="Rate is required" CssClass="errorlabel" ControlToValidate="txtRate5"
                                    Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid number" CssClass="errorlabel" 
                                        ControlToValidate="txtRate5" Display="Dynamic" ValidationGroup="billing" ValidationExpression="^[1-9]\d*(\.\d+)?$" ></asp:RegularExpressionValidator>

                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"></label>
                                <div class="col-sm-10">
                                    <asp:Button ID="btnInsert5" runat="server" CommandName="PerformInsert" Text="Save" CssClass="btn btn-xs btn-primary" ValidationGroup="billing" />
                                    <asp:Button ID="btnCancelInsert" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-xs btn-default" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </InsertItemTemplate>

        <EmptyDataTemplate>
           <div class="RadListView RadListView_Metro1">

               <asp:LinkButton ID="btnInsert1" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                    CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i> Add New</asp:LinkButton>

                <h3>Market Surcharge</h3>
                <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add</strong> button above.</div>
            </div>
        </EmptyDataTemplate>

    </telerik:RadListView>
          </div>
</asp:Panel>


</asp:Panel>



<asp:LinqDataSource ID="getMarketList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
    EntityTypeName="" OrderBy="marketName" TableName="tblMarkets">
</asp:LinqDataSource>

<asp:LinqDataSource ID="getMarketSurcharge" runat="server"
    ContextTypeName="EventManagerApplication.DataClassesDataContext"
    EnableDelete="True" EnableInsert="True" EnableUpdate="True"
    EntityTypeName="" TableName="tblSupplierBillingRates" Where="RateType == @RateType &amp;&amp; SupplierID == @SupplierID">
    <WhereParameters>
        <asp:Parameter DefaultValue="3" Name="RateType" Type="Int32" />
        <asp:QueryStringParameter Name="SupplierID" QueryStringField="SupplierID" Type="Int32" />
    </WhereParameters>
</asp:LinqDataSource>



