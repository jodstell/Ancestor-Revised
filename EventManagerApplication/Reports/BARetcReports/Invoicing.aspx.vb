Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.Globalization
Imports Telerik.Web.UI

Public Class Invoicing
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Dim dtNow As DateTime
    Dim nowdayofweek As Integer
    Dim weekStartDate, weekEndDate As DateTime
    Private Shared ReadOnly CookieName As String = "EventGridPF"

    Private Sub Events_Init(sender As Object, e As EventArgs) Handles Me.Init
        RadPersistenceManager1.StorageProviderKey = CookieName
        RadPersistenceManager1.StorageProvider = New CookieStorageProvider(CookieName)
    End Sub

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        hiddenClientID.Value = Session("CurrentClientID")
        hiddenUserID.Value = currentUser.Id

        If manager.IsInRole(currentUser.Id, "Student") Then
            Response.Redirect("/AccessDenied")
        End If



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

            'select first item
            SelectedSupplier.SelectedIndex = 0
            ' BindConsumersSampled()

        End If

        If Request.Cookies(CookieName) IsNot Nothing Then


            If Request.QueryString("LoadState") IsNot Nothing Then

                Dim state = Request.QueryString("LoadState")

                If state = "Yes" Then
                    If Not Page.IsPostBack Then

                        '
                        Try
                            RadPersistenceManager1.LoadState()

                            'set the date range from session state
                            FromDatePicker.SelectedDate = Session("FromDate")
                            ToDatePicker.SelectedDate = Session("ToDate")


                            InvoiceList.Rebind()
                        Catch ex As Exception

                        End Try

                    End If
                    ' End If
                End If

            End If

        End If

    End Sub

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click

        Dim _startDate As Date = FromDatePicker.SelectedDate
        Dim _endDate As Date = ToDatePicker.SelectedDate

        selectedDateLabel.Text = _startDate.ToString("dddd, MMMM dd") & " - " & _endDate.ToString("dddd, MMMM dd")

        InvoiceList.DataBind()
    End Sub

    Private Sub InvoiceList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles InvoiceList.ItemCommand
        If e.CommandName = "ViewInvoice" Then


            RadPersistenceManager1.SaveState()
            Session.Add("FromDate", FromDatePicker.SelectedDate)
            Session.Add("ToDate", ToDatePicker.SelectedDate)

            Response.Redirect("/Reports/BARetcReports/Invoice?ID=" & e.CommandArgument)
        End If
    End Sub
End Class