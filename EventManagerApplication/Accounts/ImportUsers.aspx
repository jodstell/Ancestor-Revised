<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ImportUsers.aspx.vb" Inherits="EventManagerApplication.ImportUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container min-height">

    <div class="row">
					<div class="col-xs-12">

                        <h3>Import Users</h3>

                        <asp:Button ID="btnImport" runat="server" Text="Begin Import" CssClass="btn btn-md btn-primary" />

                        <asp:Button ID="Button1" runat="server" Text="Button" />
                        

                        <div>

                            <asp:Label ID="msgLabel" runat="server" />

                        </div>

					</div>
				</div>

        </div>


</asp:Content>
