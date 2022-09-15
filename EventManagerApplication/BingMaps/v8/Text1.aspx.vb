Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI

Public Class Text1
    Inherits System.Web.UI.Page
    Dim dtNow As DateTime
    Dim daycount As Integer
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())


        If Not Page.IsPostBack Then

            'Enter any Date in MDY format

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 13 - dtNow.DayOfWeek, dtNow)

            'Displays first day of the week 
            '  lblWeek.Text = weekStartDate.ToString("dddd, MMMM dd") & " - " & weekEndDate.ToString("dddd, MMMM dd")

            FromDatePicker.SelectedDate = weekStartDate
            ToDatePicker.SelectedDate = weekEndDate
        End If

    End Sub

End Class