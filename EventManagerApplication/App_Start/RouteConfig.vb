Imports System.Web.Routing
Imports Microsoft.AspNet.FriendlyUrls

Public Module RouteConfig
    Sub RegisterRoutes(ByVal routes As RouteCollection)
        Dim settings As FriendlyUrlSettings = New FriendlyUrlSettings()
        settings.AutoRedirectMode = RedirectMode.Permanent
        routes.EnableFriendlyUrls(settings)

        routes.RouteExistingFiles = True

        'route the event details page to the latest version
        'routes.MapPageRoute("EventDetails", "Events/EventDetails", "~/Events/Event_Details.aspx")

        ' routes.MapPageRoute("ViewEvents", "ViewEvents", "~/Events/EventDetailsV4.aspx")

        ' routes.MapPageRoute("EventDetails", "Events/EventDetails", "~/Events/EventDetailsV1.aspx")

        'route the request event page
        routes.MapPageRoute("RequestEvent", "Event_Request/{supplier}", "~/Account/RequestEvent.aspx")
        routes.MapPageRoute("RequestEvent2", "Event_Request/{supplier}/{action}", "~/Account/RequestEvent.aspx")

        'the following routes will not work due to the security on the master page
        ' routes.MapPageRoute("Root", "", "~/dashboard.aspx")
        ' routes.MapPageRoute("Default", "/", "~/dashboard.aspx")



    End Sub
End Module
