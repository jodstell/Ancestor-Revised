Public Class CompletedTestsControl
    Inherits System.Web.UI.UserControl
    Shared hostname As String = HttpContext.Current.Request.Url.Host.ToLower
    Shared db As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GUID.Value = System.Web.HttpContext.Current.User.Identity.Name
        SiteID.Value = GetSiteID()

        'Dim timeUtc As Date = Date.UtcNow

        'Dim UserName As String = System.Web.HttpContext.Current.User.Identity.Name
        'Dim MyTimeZone As String = (From p In db.Applicants Where p.dbGUID = UserName Select p.TimeZone).FirstOrDefault

        'Dim cstZone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(MyTimeZone)

        'Dim cstTime As Date = TimeZoneInfo.ConvertTimeFromUtc(timeUtc, cstZone)

        'Label1.Text = String.Format("{0:g}", cstTime)

    End Sub

    Function GetSiteID() As String

        Dim host As String = Request.Url.Host.ToLower

        Try
            Dim q = From p In db.Sites Where p.Host = host Select p

            For Each p In q
                Return (p.SiteID)
            Next
        Catch ex As Exception

        End Try

        Return host

    End Function

    Function GetTimeAdjustment(ByVal d As Date) As String
        Try
            Dim UserName As String = System.Web.HttpContext.Current.User.Identity.Name
            Dim MyTimeZone As String = (From p In db.StudentDetails Where p.UserName = UserName Select p.TimeZone).FirstOrDefault

            Dim cstZone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(MyTimeZone)

            Dim cstTime As DateTime = TimeZoneInfo.ConvertTimeFromUtc(d, cstZone)

            Return String.Format("{0} ({1})", cstTime, ShortTimeZoneFormat(MyTimeZone))
        Catch ex As Exception
            Return d
        End Try

    End Function

    Private Function ShortTimeZoneFormat(timeZoneStandardName As String) As String
        Dim TimeZoneElements As String() = timeZoneStandardName.Split(" "c)
        Dim shortTimeZone As String = [String].Empty
        For Each element As String In TimeZoneElements
            'copies the first element of each word
            shortTimeZone += element(0)
        Next
        Return shortTimeZone
    End Function

End Class