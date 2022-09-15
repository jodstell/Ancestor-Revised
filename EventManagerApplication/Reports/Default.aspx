<%@ Page Title="Reports" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Default.aspx.vb" Inherits="EventManagerApplication._Default4" %>



<%@ Register Assembly="Telerik.ReportViewer.Html5.WebForms, Version=10.2.16.914, Culture=neutral, PublicKeyToken=a9d7983dfcc261be" Namespace="Telerik.ReportViewer.Html5.WebForms" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="content">
			<div id="content-header">
				<h1><%: Title %></h1>
				<div class="btn-group">
					<a class="btn btn-large" title="Manage Files"><i class="fa fa-file"></i></a>
					<a class="btn btn-large" title="Manage Users"><i class="fa fa-user"></i></a>
					<a class="btn btn-large" title="Manage Comments"><i class="fa fa-comment"></i><span class="label label-danger">5</span></a>
					<a class="btn btn-large" title="Manage Orders"><i class="fa fa-shopping-cart"></i></a>
				</div>
			</div>
			<div id="breadcrumb">
				<a href="/" title="Go to Home" class="tip-bottom"><i class="fa fa-home"></i> Home</a>
				<a href="#" class="current"><%: Title %></a>
			</div>
				<div class="row">
					<div class="col-xs-12">
                        <telerik:ReportViewer ID="ReportViewer1" runat="server"></telerik:ReportViewer>
					</div>
				</div>
		</div>
</asp:Content>
