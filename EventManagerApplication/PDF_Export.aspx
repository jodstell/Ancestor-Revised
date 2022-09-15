<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master"
    CodeBehind="PDF_Export.aspx.vb" Inherits="EventManagerApplication.PDF_Export" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }

        th, td {
            padding: 5px;
        }

        .k-pdf-export.pdfContainer {      
            margin: 50px;
            font-family: "Courier New", Courier, monospace;
            font-style: italic;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">

        <div class="row">
            <div class="col-md-12">


                <telerik:RadButton RenderMode="Lightweight" runat="server" Skin="Silk" OnClientClicked="exportPDF"
                    Text="Export element to PDF" AutoPostBack="false" UseSubmitBehavior="false">
                </telerik:RadButton>

                <br />
                <br />
                <br />

                <div class="pdfContainer">

                    <h2>Event Details</h2>

                    <table style="width: 70%; height: 100%;">

                        <tr>
                            <td>Event Name</td>
                            <td>Example</td>

                        </tr>

                        <tr>
                            <td>Date and Time</td>
                            <td>Example</td>

                        </tr>

                        <tr>
                            <td>Status</td>
                            <td>Example</td>

                        </tr>

                        <tr>
                            <td>Event Type</td>
                            <td>Example</td>

                        </tr>

                        <tr>
                            <td>Brand</td>
                            <td>Example</td>

                        </tr>

                        <tr>
                            <td>Additional Event Notes</td>
                            <td>Example</td>

                        </tr>

                    </table>

                </div>


            </div>

        </div>

    </div>


    <telerik:RadClientExportManager runat="server" ID="RadClientExportManager1">
        <PdfSettings MarginLeft="15px" MarginRight="15px;" FileName="HelloWorld.pdf" PaperSize="A3" />
    </telerik:RadClientExportManager>


    <script>
        var $ = $telerik.$;
        function exportPDF() {

            $find('<%=RadClientExportManager1.ClientID%>').exportPDF($(".pdfContainer"));
        }

        function exportImage() {
            $find('<%=RadClientExportManager1.ClientID%>').exportImage($(".pdfContainer"));
        }
    </script>

</asp:Content>
