Imports Telerik.Reporting.Cache.Interfaces
Imports Telerik.Reporting.Services.Engine
Imports Telerik.Reporting.Services.WebApi
Imports Telerik.Reporting
Imports System.IO

'The class name determines the service URL. 
'ReportsController class name defines /api/report/ service URL.
Public Class ReportsController
    Inherits ReportsControllerBase

    Shared configurationInstance As Services.ReportServiceConfiguration

    Shared Sub New()
        'This is the folder that contains the trdx or trdp report definitions
        'In this case this is the Reports folder
        Dim appPath = HttpContext.Current.Server.MapPath("~/")
        Dim reportsPath = Path.Combine(appPath, "Reports")

        'Add resolver for trdx report definitions, 
        'then add resolver for class report definitions as fallback resolver; 
        'finally create the resolver and use it in the ReportServiceConfiguration instance.
        Dim resolver = New ReportFileResolver(reportsPath) _
                       .AddFallbackResolver(New ReportTypeResolver())

        'Setup the ReportServiceConfiguration
        Dim reportServiceConfiguration As New Services.ReportServiceConfiguration()
        reportServiceConfiguration.HostAppId = "EventManagerApplication"
        reportServiceConfiguration.ReportResolver = resolver
        reportServiceConfiguration.Storage = New Cache.File.FileStorage()
        ' reportServiceConfiguration.ReportSharingTimeout = 0
        ' reportServiceConfiguration.ClientSessionTimeout = 15
        configurationInstance = reportServiceConfiguration
    End Sub

    Public Sub New()
        'Initialize the service configuration
        Me.ReportServiceConfiguration = configurationInstance
    End Sub
End Class
