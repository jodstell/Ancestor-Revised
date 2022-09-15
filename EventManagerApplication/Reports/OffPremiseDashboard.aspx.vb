Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.Globalization


Public Class OffPremiseDashboard
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime


    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        hiddenUserID.Value = currentUser.Id

        If manager.IsInRole(currentUser.Id, "Student") Then
            Response.Redirect("/AccessDenied")
        End If



        If Not Page.IsPostBack Then

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 6 - dtNow.DayOfWeek, dtNow)

            'Displays first day of the week 
            ' lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")
            '   FromDatePicker.SelectedDate = weekStartDate
            '  ToDatePicker.SelectedDate = weekEndDate


            Dim dtFirst As New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
            Dim endDate As DateTime = dtFirst.AddMonths(1).AddDays(-1)

            FromDatePicker.SelectedDate = dtFirst
            ToDatePicker.SelectedDate = endDate

            'select first item
            SelectedSupplier.SelectedIndex = 0
            ' BindConsumersSampled()

        End If

    End Sub

    Private Sub btnViewMonth_Click(sender As Object, e As EventArgs) Handles btnViewMonth.Click
        btnViewMonth.CssClass = "btn btn-success"
        btnViewWeek.CssClass = "btn btn-default"
        Dim dtFirst As New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
        Dim endDate As DateTime = dtFirst.AddMonths(1).AddDays(-1)

        'Displays first day of the week 
        ' lblWeek.Text = dtFirst.ToString("dddd, MMMM dd") & " - " & endDate.ToString("dddd, MMMM dd")

        FromDatePicker.SelectedDate = dtFirst
        ToDatePicker.SelectedDate = endDate



    End Sub

    Private Sub btnViewWeek_Click(sender As Object, e As EventArgs) Handles btnViewWeek.Click
        btnViewWeek.CssClass = "btn btn-success"
        btnViewMonth.CssClass = "btn btn-default"
        dtNow = Date.Now()

        nowdayofweek = dtNow.DayOfWeek
        weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
        weekEndDate = DateAdd("d", 6 - dtNow.DayOfWeek, dtNow)

        'Displays first day of the week 
        '  lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")

        FromDatePicker.SelectedDate = weekStartDate
        ToDatePicker.SelectedDate = weekEndDate



    End Sub

    Protected Sub BindConsumersSampled()



        SelectedSupplierLabel.Text = (From p In db.tblSuppliers Where p.supplierID = SelectedSupplier.SelectedValue Select p.supplierName).FirstOrDefault & " Performance Metrics"


        Dim Sampled = (From p In db.getRecapResultsbyDateRange(0, 1, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.total).Sum()

        Dim Sold = (From p In db.getRecapResultsbyDateRange(0, 3, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.total).Sum()




        Try
            Dim conversionRate As Integer = (Sold / Sampled) * 100
            ConversionRateLabel.Text = String.Format("{0:0.0}%", conversionRate)

            DefaultMessage.Visible = False

        Catch ex As Exception
            ConversionRateLabel.Text = "There was an error"
            'no results
            ReportPanel.Visible = False

            DefaultMessage.Visible = False
            NoResultLabel.Visible = True
            NoResultLabel.Text = Common.ShowAlertNoClose("warning", "<b>Warning!</b>  There were no events found!  Please adjust your filter.")
            Exit Sub
        End Try


        Try

            VolumeLabel.Text = (From p In db.getRecapResultsbyDateRange(0, 1, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.total).Count()
            SampledTotalLabel.Text = (From p In db.getRecapResultsbyDateRange(0, 1, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.total).Sum()

            BottlesSoldTotalLabel.Text = (From p In db.getRecapResultsbyDateRange(0, 3, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.total).Sum()

            Try
                Dim myInt As Int64 = (From p In db.getRecapWeeklyEstimatedRevenue(FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue) Select p.TOTAL).Sum
                Dim nfi As NumberFormatInfo = New CultureInfo("en-US", False).NumberFormat
                nfi.CurrencyDecimalDigits = 0

                RevenueLabel.Text = myInt.ToString("C", nfi)
            Catch ex As Exception
                DefaultMessage.Visible = False
                NoResultLabel.Visible = True
                NoResultLabel.Text = Common.ShowAlertNoClose("warning", "<b>Warning!</b>  There was an error.")
            End Try

            Try
                Dim c = (From p In db.GetCaseCountByEventType_Supplier(FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.cases).FirstOrDefault

                Dim b = (From p In db.GetCaseDisplayCountByEventType_Supplier(FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.CaseDisplays).FirstOrDefault

                CaseDisplayLabel.Text = b

                AverageCasesLabel.Text = String.Format("{0:0.0}", c / b)


            Catch ex As Exception

            End Try


            NoResultLabel.Visible = False
            ReportPanel.Visible = True
        Catch ex As Exception

        End Try

    End Sub

    Function getPercentage(eventCount As Integer) As String
        Dim v As Integer = (From p In db.getRecapResultsbyDateRange(0, 1, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, SelectedSupplier.SelectedValue, 261) Select p.total).Count()

        Return String.Format("{0:0.0}%", eventCount / v * 100)

    End Function

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click
        Try
            BindConsumersSampled()
        Catch ex As Exception

        End Try


    End Sub
End Class