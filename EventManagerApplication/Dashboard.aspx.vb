Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI

Public Class Dashboard
    Inherits System.Web.UI.Page

    Dim dtNow As DateTime
    Dim daycount As Integer
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime

    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        'If manager.IsInRole(currentUser.Id, "GlobalAdmin") Then
        '    Response.Redirect("/GlobalAdmin/dashboard")
        'End If


        If Not manager.IsInRole(currentUser.Id, "Administrator") And manager.IsInRole(currentUser.Id, "Student") Then

            'check if active
            Dim thisAmbassador = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p).FirstOrDefault
            If thisAmbassador.Status = "Terminated" Then
                Response.Redirect("/Account/Lockout")
            Else
                Response.Redirect("/ambassadors/dashboard")
            End If

        End If

        Dim disableIP = Request.ServerVariables("REMOTE_ADDR")
        If disableIP = "78.130.243.230" Then
            LoadMapPanel.Visible = False
        End If

        If Not Page.IsPostBack Then

            'Enter any Date in MDY format

            dtNow = Date.Now()

            nowdayofweek = dtNow.DayOfWeek
            weekStartDate = DateAdd("d", 0 - dtNow.DayOfWeek, dtNow)
            weekEndDate = DateAdd("d", 13 - dtNow.DayOfWeek, dtNow)

            ' FromDatePicker.SelectedDate = weekStartDate
            ' ToDatePicker.SelectedDate = weekEndDate


        End If

    End Sub

End Class