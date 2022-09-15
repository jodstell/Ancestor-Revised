Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI

Public Class _Default
    Inherits System.Web.UI.Page

    Dim dtNow As DateTime
    Dim daycount As Integer
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime

    Dim db As New DataClassesDataContext

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        Response.Redirect("/dashboard")

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Administrator") Then
            'everything is okay

        End If


        If Not manager.IsInRole(currentUser.Id, "Administrator") And manager.IsInRole(currentUser.Id, "Student") Then
            Response.Redirect("/ambassadors/dashboard")
        End If

        If Not Page.IsPostBack Then

            'Enter any Date in MDY format

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 13 - dtNow.DayOfWeek, dtNow)

            'FromDatePicker.SelectedDate = weekStartDate
            'ToDatePicker.SelectedDate = weekEndDate


        End If

    End Sub


End Class