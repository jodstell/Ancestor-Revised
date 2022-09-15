Public Class PDF_Export
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim relativePath = "~/api/export/file"

        RadClientExportManager1.PdfSettings.ProxyURL = ResolveUrl(relativePath)
        RadClientExportManager1.ImageSettings.ProxyURL = ResolveUrl(relativePath)

    End Sub

End Class