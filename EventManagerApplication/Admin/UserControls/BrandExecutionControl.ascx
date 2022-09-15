<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BrandExecutionControl.ascx.vb" Inherits="EventManagerApplication.BrandExecutionControl" %>

<div style="min-height: 400px">
<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

    <style>
        .eqbox {
            min-height: 180px;
        }

        .multibox {
            height: 165px;
        }
        .RadListView .rlvEmpty, .RadListView .rlvIEmpty {
            font-style: normal !important;
        }
    </style>

    <asp:Panel runat="server" ID="EventExecutionListPanel">
    <telerik:RadListView ID="EventExecutionList" runat="server" DataKeyNames="brandEventExecutionID"
        DataSourceID="getBrandExecutionList" InsertItemPosition="FirstItem">
        <LayoutTemplate>
            <div>
                <div class="row">
                    <div class="col-sm-12">
                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                            CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Item</asp:LinkButton>
                    </div>
                </div>
                <div id="itemPlaceholder" runat="server">
                </div>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <div>
                <h3>
                    <div class="btn-group" role="group" aria-label="...">
                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-default btn-sm" ToolTip="Edit"><i class="fa fa-pencil"></i>  Edit</asp:LinkButton>
                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-sm btn-danger" Text="Delete" ToolTip="Delete" OnClientClick="javascript:if(!confirm('This action will delete the selected question. Are you sure?')){return false;}"><i class="fa fa-trash"></i>  Delete</asp:LinkButton>
                    </div>
                    <asp:Label ID="eventTypeIDLabel" runat="server" Font-Bold="true" Text='<%# getEventTypeTitle(Eval("eventTypeID")) %>' />
                </h3>
            </div>

            <div class="col-sm-3">
                <strong>Attire:</strong>
                <div class="panel panel-default eqbox">
                    <div class="panel-body">
                        <asp:Label ID="attireLabel" runat="server" Text='<%# Eval("attire") %>' />
                    </div>
                </div>

            </div>
            <div class="col-sm-3">
                <strong>POS:</strong>
                <div class="panel panel-default eqbox">
                    <div class="panel-body">
                        <asp:Label ID="posLabel" runat="server" Text='<%# Eval("pos") %>' />
                    </div>
                </div>

            </div>
            <div class="col-sm-3">
                <strong>Sampling Instructions:</strong>
                <div class="panel panel-default eqbox">
                    <div class="panel-body">
                        <asp:Label ID="samplingInstructionsLabel" runat="server" Text='<%# Eval("samplingInstructions") %>' />
                    </div>
                </div>

            </div>
            <div class="col-sm-3">
                <strong>Event Details:</strong>
                <div class="panel panel-default eqbox">
                    <div class="panel-body">
                        <asp:Label ID="eventDetailsLabel" runat="server" Text='<%# Eval("eventDetails") %>' />
                    </div>
                </div>

            </div>
            <%--     <div class="rlvI">
               
                &nbsp;<asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="rlvBDel" Text=" " ToolTip="Delete" />
            </div>--%>
        </ItemTemplate>

        <EditItemTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="col-sm-3" style="margin-bottom: 15px;">
                        <strong>Type: <span class="text-danger">*</span></strong>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="getEventTypeList" SelectedValue='<%# Bind("eventTypeID")%>'
                            DataTextField="eventTypeName" DataValueField="eventTypeID" CssClass="form-control">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="EventNameRequiredFieldValidator" runat="server"
                            ErrorMessage="The type is required" CssClass="errorlabel" ControlToValidate="DropDownList1"
                            Display="Dynamic" ValidationGroup="details"></asp:RequiredFieldValidator>

                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12">

                    <div class="col-sm-3">
                        <strong>Attire:</strong>
                        <telerik:RadEditor ID="attireRadEditor" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("attire")%>' Width="100%"></telerik:RadEditor>
                    </div>

                    <div class="col-sm-3">
                        <strong>POS:</strong>
                        <telerik:RadEditor ID="posRadEditor" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("pos")%>' Width="100%"></telerik:RadEditor>
                    </div>

                    <div class="col-sm-3">
                        <strong>Sampling Instructions:</strong>
                        <telerik:RadEditor ID="samplingInstructionsRadEditor" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("samplingInstructions")%>' Width="100%"></telerik:RadEditor>
                        
                    </div>

                    <div class="col-sm-3">
                        <strong>Event Details:</strong>
                        <telerik:RadEditor ID="eventDetailsRadEditor" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("eventDetails")%>' Width="100%"></telerik:RadEditor>
                    </div>
                </div>
            </div>

            <div style="padding:15px 0 15px 0;">
            <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-sm btn-primary" ToolTip="Update" ValidationGroup="details">Save Changes</asp:LinkButton>
            <asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-sm btn-default" ToolTip="Cancel">Cancel</asp:LinkButton>
            </div>

            <hr />


        </EditItemTemplate>
        <InsertItemTemplate>

            <div class="row">
                <div class="col-sm-12">
                    <div class="col-sm-3" style="margin-bottom: 15px;">
                        <strong>Type: <span class="text-danger">*</span></strong>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="getEventTypeList" SelectedValue='<%# Bind("eventTypeID")%>'
                            DataTextField="eventTypeName" DataValueField="eventTypeID" CssClass="form-control" AppendDataBoundItems="true">
                            <asp:ListItem Text="-- Select Event Type --" Value=""></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="EventNameRequiredFieldValidator" runat="server"
                            ErrorMessage="The type is required" CssClass="errorlabel" ControlToValidate="DropDownList1"
                            Display="Dynamic" ValidationGroup="details"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12">

<div class="col-sm-3">
                        <strong>Attire:</strong>
                        <telerik:RadEditor ID="attireRadEditor" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("attire")%>' Width="100%"></telerik:RadEditor>
                    </div>

                    <div class="col-sm-3">
                        <strong>POS:</strong>
                        <telerik:RadEditor ID="posRadEditor" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("pos")%>' Width="100%"></telerik:RadEditor>
                    </div>

                    <div class="col-sm-3">
                        <strong>Sampling Instructions:</strong>
                        <telerik:RadEditor ID="samplingInstructionsRadEditor" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("samplingInstructions")%>' Width="100%"></telerik:RadEditor>
                        
                    </div>

                    <div class="col-sm-3">
                        <strong>Event Details:</strong>
                        <telerik:RadEditor ID="eventDetailsRadEditor" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("eventDetails")%>' Width="100%"></telerik:RadEditor>
                    </div>
                </div>
            </div>

            <div style="padding:15px 0 15px 0;">
            <asp:LinkButton ID="btnInsert" runat="server" CommandName="PerformInsert" CssClass="btn btn-sm btn-primary" ToolTip="Insert" ValidationGroup="details">Save Changes</asp:LinkButton>
            <asp:LinkButton ID="btnCancelInsert" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-sm btn-default" ToolTip="Cancel">Cancel</asp:LinkButton>
            </div>

            <hr />

        </InsertItemTemplate>
        <EmptyDataTemplate>
            <div class="RadListView RadListView_Default">
                <div class="rlvEmpty">
                     <div class="row">
                    <div class="col-sm-12">
                        <%--<asp:LinkButton ID="btnInsert2" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                            CssClass="btn btn-xs btn-primary pull-right"><i class="fa fa-plus"></i> Add New Item</asp:LinkButton>--%>
                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                            CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Item</asp:LinkButton>
                    </div>
                </div>
                    <div class="col-sm-12" style="margin-top:8px">
                    <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Item</strong> button above.</div>
                </div>
                    </div>
            </div>
        </EmptyDataTemplate>

    </telerik:RadListView>
</asp:Panel>


    <asp:LinqDataSource ID="getEventTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="eventTypeName" 
        TableName="qryEventTypeByClients" Where="clientID == @clientID">
        <WhereParameters>
            <asp:QueryStringParameter Name="clientID" QueryStringField="ClientID" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="getBrandExecutionList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblBrandEventExecutions" Where="brandID == @brandID">
        <WhereParameters>
            <asp:SessionParameter DbType="Int32" Name="brandID" SessionField="SelectedBrandID" />
        </WhereParameters>
    </asp:LinqDataSource>
</telerik:RadAjaxPanel>


</div>