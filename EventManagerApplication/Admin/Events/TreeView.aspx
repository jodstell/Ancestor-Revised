<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="TreeView.aspx.vb" Inherits="EventManagerApplication.TreeView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="MainPanel" runat="server">

        <div class="container">

            <div class="row">
                <div class="col-md-12">

                    <div style="margin: 0 0 15px 0">
                        <h2>Tree View
                        </h2>
                        <%--<p>
                            Use this form to add a new client.  Complete each section below and click on the Next button to continue to the next tab.<br />
                            Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                        </p>--%>
                    </div>

                    <asp:Label ID="msgLabel" runat="server"></asp:Label>

                    <div class="widget stacked">
                        <div class="widget-content min-height">

                            <%--<asp:TreeView ID="TreeView1" runat="server"></asp:TreeView>--%>

                            <telerik:RadTreeView RenderMode="Lightweight" ID="RadTreeView3" runat="server" Width="280px" Height="100%"
                                DataFieldID="CategoryID" DataFieldParentID="ParentID" DataTextField="Name"
                                DataSourceID="SqlDataSource1">
                                <DataBindings>
                                    <telerik:RadTreeNodeBinding Expanded="true"></telerik:RadTreeNodeBinding>
                                </DataBindings>
                            </telerik:RadTreeView>

                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [tblCategory]">
                            </asp:SqlDataSource>

                        </div>
                    </div>

                </div>

            </div>

        </div>


    </asp:Panel>
</asp:Content>
