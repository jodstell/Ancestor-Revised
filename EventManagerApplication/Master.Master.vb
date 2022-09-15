Public Class Master
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        ClientLogo.ImageUrl = "/images/GigEngyn_portal_logo.png"

        ''Add dynamic theme
        'Dim csslink As New HtmlLink
        'csslink.Attributes.Add("rel", "stylesheet")
        'csslink.Attributes.Add("href", GetTheme())
        'Me.head.Controls.Add(csslink)

        ''set favicon
        'Dim link1 As New HtmlLink
        'link1.Attributes.Add("type", "image/x-icon")
        'link1.Attributes.Add("rel", "shortcut icon")
        'link1.Attributes.Add("href", GetFavIcon())
        'Me.head.Controls.Add(link1)

        'Dim link2 As New HtmlLink
        'link2.Attributes.Add("type", "image/ico")
        'link2.Attributes.Add("rel", "icon")
        'link2.Attributes.Add("href", GetFavIcon())
        'Me.head.Controls.Add(link2)

    End Sub

    'Function GetTheme() As String

    '    Dim host As String = Request.Url.Host.ToLower

    '    Dim db As New DataClassesDataContext

    '    Dim q = (From p In db.tblSiteSettings Where p.HostName = host Select p).FirstOrDefault

    '    Return q.Theme

    'End Function

    'Function GetLogo() As String

    '    Dim host As String = Request.Url.Host.ToLower

    '    Dim db As New DataClassesDataContext

    '    Dim q = (From p In db.tblSiteSettings Where p.HostName = host Select p).FirstOrDefault

    '    Return ""

    'End Function

    'Function GetFavIcon() As String

    '    Dim host As String = Request.Url.Host.ToLower

    '    Dim db As New DataClassesDataContext

    '    Dim q = (From p In db.tblSiteSettings Where p.HostName = host Select p).FirstOrDefault

    '    Return q.FavIconURL

    'End Function

End Class