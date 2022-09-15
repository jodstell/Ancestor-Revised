Imports Telerik.Reporting

Public Class GalloPayroll
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then




            '  reportViewer1.ReportSource.Identifier = String.Format("ClientReports/Stoli/PayrollReport.trdp", "Stoli")
            '  reportViewer1.ReportSource.IdentifierType = "UriReportSource"


            '    dtNow = Date.Now()

            '    nowdayofweek = dtNow.DayOfWeek
            '    weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            '    weekEndDate = DateAdd("d", 6 - dtNow.DayOfWeek, dtNow)

            '    Dim dtFirst As New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
            '    Dim endDate As DateTime = dtFirst.AddMonths(1).AddDays(-1)

            '    FromDatePicker.SelectedDate = dtFirst
            '    ToDatePicker.SelectedDate = endDate



            'End If

            'If Not IsPostBack Then
            '    Dim typeReportSource As New TypeReportSource()
            '    typeReportSource.TypeName = "PayRollReport, ReportLibrary"
            '    ReportViewer1.ReportSource = typeReportSource
            '    ReportViewer1.RefreshReport()
        End If


        '  reportViewer1.ReportSource.Identifier = ""

    End Sub

End Class