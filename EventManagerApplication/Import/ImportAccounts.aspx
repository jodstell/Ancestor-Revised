<%@ Page Title="Import Accounts" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ImportAccounts.aspx.vb" Inherits="EventManagerApplication.ImportAccounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div id="content">
			<div id="content-header">
				<h1><%: Title %></h1>
			</div>

			<div id="breadcrumb">
				<a href="/" title="Go to Home" class="tip-bottom"><i class="fa fa-home"></i> Home</a>
				<a href="#" class="current"><%: Title %></a>
			</div>

				<div class="row">
					<div class="col-xs-12">

                        <asp:Button ID="btnImport" runat="server" Text="Begin Import 1" /> 
                        <asp:Button ID="btnImport2" runat="server" Text="Begin Import 2" />
                        <asp:Button ID="btnImport3" runat="server" Text="Begin Import 3" />
                        <asp:Button ID="btnImport4" runat="server" Text="Begin Import 4" />
                        <asp:Button ID="btnImport5" runat="server" Text="Begin Import 5" />
                        <asp:Button ID="btnImport6" runat="server" Text="Begin Import 6" />
                        <asp:Button ID="btnImport7" runat="server" Text="Begin Import 7" />
                        <asp:Button ID="btnImport8" runat="server" Text="Begin Import 8" />
                        <asp:Button ID="btnImport9" runat="server" Text="Begin Import 9" />

                        <div>

                            <asp:Label ID="msgLabel" runat="server" />

                        </div>

					</div>
				</div>
		</div>
</asp:Content>
