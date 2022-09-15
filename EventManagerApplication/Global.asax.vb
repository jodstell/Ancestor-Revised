Imports System.Web.Http
Imports System.Web.Optimization
Imports Telerik.Reporting.Cache.Interfaces
Imports Telerik.Reporting.Services.Engine
Imports Telerik.Reporting.Services.WebApi
Imports Telerik.Reporting
Imports Telerik.ReportViewer

Public Class Global_asax
    Inherits HttpApplication

    Sub Application_Start(sender As Object, e As EventArgs)

        Services.WebApi.ReportsControllerConfiguration.RegisterRoutes(System.Web.Http.GlobalConfiguration.Configuration)
        ' Fires when the application is started
        GlobalConfiguration.Configure(AddressOf WebApiConfig.Register)
        RouteConfig.RegisterRoutes(RouteTable.Routes)
        BundleConfig.RegisterBundles(BundleTable.Bundles)
    End Sub

    Sub Session_Start(ByVal Sender As Object, ByVal E As EventArgs)
        If Not Request.Cookies("otmData") Is Nothing Then
            'If a cookie exists, set the session-object with the data from the cookie.
            Session("MyCulture") = Server.HtmlEncode(Request.Cookies("otmData")("languagePref"))
        Else
            'If the cookie doen’t exist (user visits the website for the first time) set the session-object to the default value, in this case English. And ‘create the cookie.
            Session("MyCulture") = "en"
            Dim aCookie As New HttpCookie("otmData")
            aCookie.Values("languagePref") = Session("MyCulture")
            aCookie.Expires = System.DateTime.Now.AddDays(21)
            Response.Cookies.Add(aCookie)
        End If

    End Sub


    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)

        Dim context As HttpContext = HttpContext.Current
        Dim exception As Exception = Server.GetLastError

        'custom exception handling:
        If Not IsNothing(exception) Then

            If Not IsNothing(exception.InnerException) Then

                'ViewState Exception:
                If exception.InnerException.GetType = GetType(ViewStateException) Then
                    'The state information is invalid for this page and might be corrupted.

                    'Caused by VIEWSTATE|VIEWSTATEENCRYPTED|EVENTVALIDATION hidden fields being malformed
                    ' + could be page is submitted before being fully loaded
                    ' + hidden fields have been malformed by proxies or user tampering
                    ' + hidden fields have been trunkated by mobile devices
                    ' + remotly loaded content into the page using ajax causes the hidden fields to be overridden with incorrect values (when a user navigates back to a cached page)

                    MailHelper.SendMailMessage("no-reply@gigengyn.com", "There was ViewStateException ProofMktg", exception.StackTrace.ToString())

                    'Remedy: reload the request page to replenish the viewstate:
                    Server.ClearError()
                    Response.Clear()
                    Response.Redirect(context.Request.Url.ToString, False)
                    Exit Sub
                End If

            End If

        End If

    End Sub
End Class