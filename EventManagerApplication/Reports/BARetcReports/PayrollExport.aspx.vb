Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class PayrollExport
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

        Try
            TotalCountLabel.Text = (From p In db.qryViewPendingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Session("CurrentClientID") Select p).Count

        Catch ex As Exception
            TotalCountLabel.Text = "0"
        End Try

        Dim SumPayroll As Double
        Try
            SumPayroll = (From p In db.qryViewPendingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Session("CurrentClientID") Select p.Total).Sum
        Catch ex As Exception
            SumPayroll = 0
        End Try

        Dim count As Double

        Try
            count = (From p In db.qryViewPendingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Session("CurrentClientID") Select p).Count
        Catch ex As Exception
            count = 0
        End Try

        If count = 0 Then
            AgeragePayLabel.Text = "$0.00"
        Else

            AgeragePayLabel.Text = String.Format("{0:c}", SumPayroll / count)
        End If



        TotalPayrollLabel.Text = String.Format("{0:c}", SumPayroll)


        Try
            TotalHoursLabel.Text = (From p In db.qryViewPendingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Session("CurrentClientID") Select p.hours).Sum
        Catch ex As Exception
            TotalHoursLabel.Text = "0"
        End Try

        Try
            AmbassadorCountLabel.Text = (From p In db.qryViewPendingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Session("CurrentClientID") Select p.FullName).Distinct().Count()
        Catch ex As Exception
            AmbassadorCountLabel.Text = "0"
        End Try


        selectedDateLabel.Text = String.Format("{0:D} - {1:D}", FromDatePicker.SelectedDate, ToDatePicker.SelectedDate)


    End Sub

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click

        Try
            TotalCountLabel.Text = (From p In db.qryViewPendingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Session("CurrentClientID") Select p).Count

        Catch ex As Exception
            TotalCountLabel.Text = "0"
        End Try

        Dim SumPayroll As Double
        Try
            SumPayroll = (From p In db.qryViewPendingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Session("CurrentClientID") Select p.Total).Sum
        Catch ex As Exception
            SumPayroll = 0
        End Try

        Dim count As Double

        Try
            count = (From p In db.qryViewPendingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Session("CurrentClientID") Select p).Count
        Catch ex As Exception
            count = 0
        End Try

        If count = 0 Then
            AgeragePayLabel.Text = "$0.00"
        Else

            AgeragePayLabel.Text = String.Format("{0:c}", SumPayroll / count)
        End If



        TotalPayrollLabel.Text = String.Format("{0:c}", SumPayroll)


        Try
            TotalHoursLabel.Text = (From p In db.qryViewPendingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Session("CurrentClientID") Select p.hours).Sum
        Catch ex As Exception
            TotalHoursLabel.Text = "0"
        End Try

        Try
            AmbassadorCountLabel.Text = (From p In db.qryViewPendingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Session("CurrentClientID") Select p.FullName).Distinct().Count()
        Catch ex As Exception
            AmbassadorCountLabel.Text = "0"
        End Try

    End Sub

    Private Sub PendingPaymentsRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles PendingPaymentsRadGrid.ItemCommand

        Select Case e.CommandName
            Case "Approve"

                If PendingPaymentsRadGrid.SelectedItems.Count = 0 Then

                    topMsgLabel.Text = "You must select at least one item."

                Else

                    'create new paymentID

                    'Dim payment As New tblPayment With {.dateSubmitted = Date.Now(), .fromDate = FromDatePicker.SelectedDate, .toDate = ToDatePicker.SelectedDate, .submittedBy = Context.User.Identity.GetUserId()}

                    'db.tblPayments.InsertOnSubmit(payment)
                    'db.SubmitChanges()

                    'Session.Add("PaymentID", payment.paymentID)

                    Dim sb As New StringBuilder()
                    For Each item As GridDataItem In PendingPaymentsRadGrid.SelectedItems
                        Dim name As String = item("RequirementID").Text



                        'sb.Append(item("RequirementID").Text + ",")
                        ' sb.Append(item.GetDataKeyValue("RequirementID").ToString() + ",")

                        Dim q = (From p In db.tblEventStaffingRequirements Where p.RequirementID = item.GetDataKeyValue("RequirementID").ToString() Select p).FirstOrDefault

                        q.paymentStatus = "Approved"
                        ' q.paymentID = payment.paymentID

                        db.SubmitChanges()

                    Next

                    'load new grid to show summary
                    Response.Redirect("/Reports/BARetcReports/PayrollApproved")
                    ' PendingPaymentsRadGrid.Visible = False
                    ' ApprovedPaymentsRadGrid.Visible = True


                    'show freindly message

                End If


            Case "Reject"

                If PendingPaymentsRadGrid.SelectedItems.Count = 0 Then

                    topMsgLabel.Text = "You must select at least one item."

                Else

                    Dim sb As New StringBuilder()
                    For Each item As GridDataItem In PendingPaymentsRadGrid.SelectedItems
                        Dim name As String = item("RequirementID").Text

                        Dim q = (From p In db.tblEventStaffingRequirements Where p.RequirementID = item.GetDataKeyValue("RequirementID").ToString() Select p).FirstOrDefault

                        q.paymentStatus = "Rejected"

                        db.SubmitChanges()

                        'sb.Append(item.GetDataKeyValue("RequirementID").ToString() + ",")

                    Next

                    PendingPaymentsRadGrid.DataBind()


                    ' Label1.Text = sb.ToString()

                End If



        End Select



    End Sub

    Protected Function CreateReceiptScript(ByVal eventExpenseID As Integer) As String
        Return String.Format("var win = window.radopen('/Receipt_Image.aspx?eventExpenseID={0}','Details');win.center();", eventExpenseID)
    End Function

    Protected Sub PendingPayments_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetAssignmentDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Public Function GetAssignmentDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM qryViewPendingPayments where eventDate >= '{1}' and eventDate <= '{2}' and clientid = {3} order by {0}", field, FromDatePicker.SelectedDate, ToDatePicker.SelectedDate, Session("CurrentClientID"))

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()

        adapter.SelectCommand = New SqlCommand(query, conn)

        Dim myDataTable As New DataTable()

        conn.Open()

        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function




End Class