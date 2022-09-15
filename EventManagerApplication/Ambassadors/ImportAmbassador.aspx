<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ImportAmbassador.aspx.vb" Inherits="EventManagerApplication.ImportAmbassador" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


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
						

						<div>

							<asp:Label ID="msgLabel" runat="server" />

						</div>

					</div>
				</div>
		</div>

</asp:Content>
