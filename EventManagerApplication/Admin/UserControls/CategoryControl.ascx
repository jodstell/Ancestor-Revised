<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CategoryControl.ascx.vb" Inherits="EventManagerApplication.CategoryControl" %>


<style>
    ul.treeview-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    li.treeview-item {
        float: left;
        width: 228px;
        padding-right: 4px;
        border-left: solid 1px #b1d8eb;
    }

    div.text {
        font: 13px 'Segoe UI', Arial, sans-serif;
        color: #4888a2;
        padding: 6px 18px;
        display: block;
    }

    div.RadTreeView {
        line-height: 16px;
    }

        div.RadTreeView .rtSp {
            height: 14px;
        }

        div.RadTreeView .rtHover .rtIn,
        div.RadTreeView .rtSelected .rtIn {
            padding: 0px 1px 0px;
        }

        div.RadTreeView .rtIn {
            padding: 1px 2px 1px;
        }
</style>

<%--<telerik:RadPersistenceManagerProxy ID="RadPersistenceManager1" runat="server">
    <PersistenceSettings>
        <telerik:PersistenceSetting ControlID="CategoryRadTreeView" />
    </PersistenceSettings>
</telerik:RadPersistenceManagerProxy>--%>


<asp:Panel ID="MainPanel" runat="server">

    <asp:Label ID="ClientID" runat="server" />

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" BackgroundPosition="Top"></telerik:RadAjaxLoadingPanel>

    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">


        <div class="row">
            <div class="col-md-12">

                <%--<div style="margin: 0 0 15px 0">
                        <h2>Tree View
                        </h2>
                        
                    </div>--%>

                <asp:Label ID="msgLabel" runat="server"></asp:Label>

                <div class="widget stacked">
                    <div class="widget-content min-height">

                        <div class="col-md-6">

                            <div>
                                <asp:Label ID="SelectedCategoryLabel" runat="server" Visible="true" />
                            </div>

                            <telerik:RadTreeView RenderMode="Lightweight" ID="CategoryRadTreeView" runat="server" Width="280px" Height="100%"
                                EnableContextMenu="True" AllowNodeEditing="True"
                                DataFieldID="CategoryID" DataFieldParentID="ParentID" DataTextField="Name" DataValueField="CategoryID"
                                OnNodeClick="CategoryRadTreeView_NodeClick"
                                OnContextMenuItemClick="CategoryRadTreeView_ContextMenuItemClick"
                                OnNodeEdit="CategoryRadTreeView_NodeEdit"
                                DataSourceID="SqlDataSource1">
                                <ExpandAnimation Type="OutQuart" Duration="300" />
                                <CollapseAnimation Type="OutQuint" Duration="200" />
                                <DataBindings>
                                    <telerik:RadTreeNodeBinding Expanded="false"></telerik:RadTreeNodeBinding>
                                </DataBindings>
                                <ContextMenus>
                                    <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server">
                                        <Items>

                                            <telerik:RadMenuItem Value="Delete" Text="Delete"></telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadTreeViewContextMenu>
                                </ContextMenus>
                            </telerik:RadTreeView>

                            <%-- <telerik:RadTreeList RenderMode="Lightweight" ID="RadTreeList1" runat="server" DataSourceID="SqlDataSource1"
                                ParentDataKeyNames="ParentID" DataKeyNames="CategoryID" AllowPaging="true"
                                AutoGenerateColumns="false" AllowSorting="true" ExpandCollapseMode="Server">
                                <Columns>
                                    <telerik:TreeListBoundColumn DataField="CategoryID" UniqueName="CategoryID" HeaderText="Category ID" />

                                    <telerik:TreeListBoundColumn DataField="Name" UniqueName="Name" HeaderText="Name" />

                                </Columns>
                            </telerik:RadTreeList>--%>

                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [tblCategory] WHERE ([ClientID] = @ClientID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ClientID" PropertyName="Text" Name="ClientID" Type="Int32"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>

                        </div>

                        <div class="col-md-6" style="margin-top: 10px">
                            <div id="NewCategoryPanel" class="panel panel-primary" runat="server">
                                <div class="panel-heading">Add New Category</div>
                                <div class="panel-body">
                                    Title:<br />
                                    <asp:TextBox ID="TitleTextBox" runat="server" CssClass="form-control"></asp:TextBox><br />

                                    Parent Category<br />

                                    <telerik:RadDropDownTree RenderMode="Lightweight" runat="server" ID="RadDropDownTree1" Width="100%"
                                        DataSourceID="SqlDataSource1"
                                        DefaultMessage="Choose a category" DefaultValue="0"
                                        DataTextField="Name" DataFieldID="CategoryID" DataFieldParentID="ParentID" DataValueField="CategoryID">
                                        <DropDownSettings Height="140px" CloseDropDownOnSelection="true" />
                                    </telerik:RadDropDownTree>
                                    <br />

                                    <div style="margin-top: 10px">
                                        <asp:Button ID="BtnAddNew" runat="server" Text="Add New" CssClass="btn btn-primary pull-right" /><br />

                                        
                                    </div>



                                </div>
                            </div>


                            <%--<div class="widget stacked">

                                <div class="widget-header">
                                    <i class="icon-star"></i>
                                    <h3>Add New Category</h3>
                                </div>
                                <!-- /widget-header -->


                                <div class="widget-content">
                                    
                                </div>

                            </div>--%>
                        </div>


                    </div>
                </div>

            </div>

        </div>

    </telerik:RadAjaxPanel>

</asp:Panel>

