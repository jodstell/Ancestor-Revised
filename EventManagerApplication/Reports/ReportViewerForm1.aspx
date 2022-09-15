<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ReportViewerForm1.aspx.vb" Inherits="EventManagerApplication._ReportViewerForm1" %>

<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Telerik HTML5 Web Forms Report Viewer Form</title>
	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>

	<style>
		#reportViewer1 {
			position: absolute;
			left: 5px;
			right: 5px;
			top: 5px;
			bottom: 5px;
			overflow: hidden;
			font-family: Verdana, Arial;
		}
	</style>

</head>
<body>
    <form runat="server">
        <telerik:ReportViewer
            ID="reportViewer1" ServiceUrl=""
			Width="1300px"
			Height="900px"
            runat="server">
            <ReportSource IdentifierType="UriReportSource" Identifier="SampleReport.trdp">
            </ReportSource>
        </telerik:ReportViewer>
    </form>
</body>
</html>