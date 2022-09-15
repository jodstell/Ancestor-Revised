<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="BillingRates.aspx.vb" Inherits="EventManagerApplication.BillingRates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
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

        .form-group {
            margin-bottom: 10px;
        }
        .RadListView_Metro {
            margin: 5px;
        }

        .RadListView div.rlvI, .RadListView div.rlvA, .RadListView div.rlvISel, .RadListView div.rlvIEmpty, .RadListView div.rlvIEdit1 {
            border-bottom: 0px solid;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <telerik:RadListView ID="BillingRates_EventTypeList" runat="server" DataKeyNames="BillingRateID"
        DataSourceID="getBillingRates_AgencyFee" InsertItemPosition="FirstItem" Skin="Metro">

        <LayoutTemplate>
            <div class="RadListView RadListView_Metro1">
                <telerik:RadButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                    Text="Add" CssClass="btn btn-xs btn-secondary pull-right">
                </telerik:RadButton>
               <br />
                <div id="itemPlaceholder" runat="server">
                </div>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <div class="rlvI1">
                <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                    CssClass="btn btn-xs btn-primary" Text="Edit" ToolTip="Edit" />

            <%--    &nbsp;<asp:Label ID="RelatedItemIDLabel" runat="server" Text='<%# getEventTypeName(Eval("RelatedItemID"))%>' />:--%>
                &nbsp;$<asp:Label ID="RateLabel" runat="server" Text='<%# Eval("Rate") %>' />/<asp:Label ID="BillingRateTypeLabel" runat="server" Text='<%# Eval("BillingRateType") %>' />
                <%--&nbsp;<asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="rlvBDel" Text=" " ToolTip="Delete" />--%>
            </div>
        </ItemTemplate>
        <AlternatingItemTemplate>
            <div class="rlvI1">
                <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                    CssClass="btn btn-xs btn-primary" Text="Edit" ToolTip="Edit" />

               <%-- &nbsp;<asp:Label ID="RelatedItemIDLabel" runat="server" Text='<%# getEventTypeName(Eval("RelatedItemID"))%>' />:--%>
                &nbsp;$<asp:Label ID="RateLabel" runat="server" Text='<%# Eval("Rate") %>' />/<asp:Label ID="BillingRateTypeLabel" runat="server" Text='<%# Eval("BillingRateType") %>' />
            </div>
        </AlternatingItemTemplate>

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
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"></label>
                                <div class="col-sm-10">
                                    <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-xs btn-primary" />
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
                                <label for="ddlActivity" class="col-sm-2 control-label">Activity</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlActivity" runat="server" CssClass="form-control input-sm"
                                        DataSourceID="getEventTypeList" AppendDataBoundItems="true" DataTextField="eventTypeName" 
                                        DataValueField="eventTypeID" SelectedValue='<%# Eval("RelatedItemID") %>'>
                                        <asp:ListItem Text="-- Select Activity --" Value="">                      
                                        </asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="txtRate" class="col-sm-2 control-label">Rate</label>
                                <div class="col-sm-5">
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-addon">$</span>
                                        <asp:TextBox ID="txtRate" runat="server" CssClass="form-control"
                                            Text='<%# Eval("Rate")%>' />
                                        <span class="input-group-addon">Hour</span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"></label>
                                <div class="col-sm-10">
                                    <asp:Button ID="btnInsert" runat="server" CommandName="PerformInsert" Text="Save" CssClass="btn btn-xs btn-primary" />
                                    <asp:Button ID="btnCancelInsert" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-xs btn-default" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </InsertItemTemplate>

        <EmptyDataTemplate>
            <div class="RadListView RadListView_Metro">
                <div class="rlvEmpty">
                    There are no items to be displayed.
                </div>
            </div>
        </EmptyDataTemplate>

       
    </telerik:RadListView>

    
    <asp:LinqDataSource ID="getBillingRates_AgencyFee" runat="server" 
        ContextTypeName="EventManagerApplication.DataClassesDataContext" 
        EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" 
        TableName="tblSupplierBillingRates" Where="SupplierID == @SupplierID &amp;&amp; RateType == @RateType">
        <WhereParameters>
            <asp:QueryStringParameter DefaultValue="100" Name="SupplierID" QueryStringField="SupplierID" Type="Int32" />
            <asp:Parameter DefaultValue="2" Name="RateType" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="getEventTypeList" runat="server" 
        ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="eventTypeName" TableName="tblEventTypes"></asp:LinqDataSource>

</asp:Content>
