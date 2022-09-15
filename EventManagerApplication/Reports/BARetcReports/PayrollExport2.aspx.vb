Public Class PayrollExport2
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 6 - dtNow.DayOfWeek, dtNow)

            Dim dtFirst As New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
            Dim endDate As DateTime = dtFirst.AddMonths(1).AddDays(-1)

            FromDatePicker.SelectedDate = dtFirst
            ToDatePicker.SelectedDate = endDate

            'Displays first day of the week 
            selectedDateLabel.Text = dtFirst.ToString("dddd, MMMM dd") & " - " & endDate.ToString("dddd, MMMM dd")


        End If
    End Sub

End Class