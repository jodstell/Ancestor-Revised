<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AccessDenied.aspx.vb" Inherits="EventManagerApplication.AccessDenied" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">
	
	<div class="row">
		
		<div class="col-md-12">
			
			<div class="error-container">
				<h1>Oops!</h1>
				
				<h2>Acess Denied</h2>
				
				<div class="error-details">
					Sorry, you do not have permission to view this page!
					
				</div> <!-- /error-details -->
				
				<div class="error-actions">
					<a href="/dashboard" class="btn btn-primary btn-lg">
						<i class="icon-chevron-left"></i>
						&nbsp;
						Back to Dashboard						
					</a>
					
					<a href="/support" class="btn btn-default btn-lg">
						<i class="icon-envelope"></i>
						&nbsp;
						Contact Support						
					</a>
					
				</div> <!-- /error-actions -->
							
			</div> <!-- /error-container -->			
			
		</div> <!-- /span12 -->
		
	</div> <!-- /row -->
	
</div> <!-- /container -->

</asp:Content>
