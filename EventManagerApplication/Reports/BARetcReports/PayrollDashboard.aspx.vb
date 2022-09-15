Imports System.Data.SqlClient
Imports Telerik.Web.UI

Public Class PayrollDashboard
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
            'Dim endDate As DateTime = dtFirst.AddMonths(1).AddDays(-1)


            Label1.Text = dtNow.Day

            If dtNow.Day > 14 Then
                dtFirst.AddDays(14)
            Else

            End If

            Dim endDate As DateTime = dtFirst.AddDays(14)

            FromDatePicker.SelectedDate = dtFirst
            ToDatePicker.SelectedDate = endDate

            'Displays first day of the week 
            selectedDateLabel.Text = dtFirst.ToString("dddd, MMMM dd") & " - " & endDate.ToString("dddd, MMMM dd")



            Try
                TotalCountLabel.Text = (From p In db.qryViewUpcomingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = convert.ToInt32(Session("CurrentClientID")) Select p).Count

            Catch ex As Exception
                TotalCountLabel.Text = "0"
            End Try

            Dim SumPayroll As Double
            Try
                SumPayroll = (From p In db.qryViewUpcomingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Convert.ToInt32(Session("CurrentClientID")) Select p.Total).Sum
            Catch ex As Exception
                SumPayroll = 0
            End Try

            Dim count As Double

            Try
                count = (From p In db.qryViewUpcomingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Convert.ToInt32(Session("CurrentClientID")) Select p).Count
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
                TotalHoursLabel.Text = (From p In db.qryViewUpcomingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Convert.ToInt32(Session("CurrentClientID")) Select p.hours).Sum
            Catch ex As Exception
                TotalHoursLabel.Text = "0"
            End Try

            Try
                AmbassadorCountLabel.Text = (From p In db.qryViewUpcomingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Convert.ToInt32(Session("CurrentClientID")) Select p.FullName).Distinct().Count()
            Catch ex As Exception
                AmbassadorCountLabel.Text = "0"
            End Try

        End If
    End Sub

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click
        Try
            TotalCountLabel.Text = (From p In db.qryViewUpcomingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Convert.ToInt32(Session("CurrentClientID")) Select p).Count

        Catch ex As Exception
            TotalCountLabel.Text = "0"
        End Try

        Dim SumPayroll As Double
        Try
            SumPayroll = (From p In db.qryViewUpcomingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Convert.ToInt32(Session("CurrentClientID")) Select p.Total).Sum
        Catch ex As Exception
            SumPayroll = 0
        End Try

        Dim count As Double

        Try
            count = (From p In db.qryViewUpcomingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Convert.ToInt32(Session("CurrentClientID")) Select p).Count
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
            TotalHoursLabel.Text = (From p In db.qryViewUpcomingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Convert.ToInt32(Session("CurrentClientID")) Select p.hours).Sum
        Catch ex As Exception
            TotalHoursLabel.Text = "0"
        End Try

        Try
            AmbassadorCountLabel.Text = (From p In db.qryViewUpcomingPayments Where p.eventDate >= FromDatePicker.SelectedDate And p.eventDate <= ToDatePicker.SelectedDate And p.clientID = Convert.ToInt32(Session("CurrentClientID")) Select p.FullName).Distinct().Count()
        Catch ex As Exception
            AmbassadorCountLabel.Text = "0"
        End Try

        selectedDateLabel.Text = String.Format("{0:D} - {1:D}", FromDatePicker.SelectedDate, ToDatePicker.SelectedDate)

    End Sub

    Private Sub PastPayrollGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles PastPayrollGrid.ItemCommand
        Select Case e.CommandName
            Case "ExportPayroll"


                ' Dim r As New tblPayment
                Dim r = (From p In db.tblPayments Where p.paymentID = 1013 Select p).FirstOrDefault

                'create csv file

                Dim constr As String = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

                Using con As New SqlConnection(constr)

                    'add new qry filtered by Processing
                    Using cmd As New SqlCommand("SELECT * FROM getPaidPaymentsByPaymentID_toProcessCSV")
                        Using sda As New SqlDataAdapter()
                            cmd.Connection = con
                            sda.SelectCommand = cmd

                            Dim myWriter As New System.IO.StreamWriter(MapPath("~/documents/payrollexport/" & r.payrollName & r.paymentID & ".csv"))

                            Using dt As New DataTable()
                                sda.Fill(dt)

                                'Build the CSV file data as a Comma separated string.
                                Dim csv As String = String.Empty

                                For Each column As DataColumn In dt.Columns

                                    'Add the Header row for CSV file.
                                    csv += column.ColumnName + ","c
                                Next

                                'Add new line.
                                csv += vbCr & vbLf

                                For Each row As DataRow In dt.Rows

                                    For Each column As DataColumn In dt.Columns

                                        'Add the Data rows.
                                        csv += row(column.ColumnName).ToString().Replace(",", ";") + ","c
                                    Next

                                    'Add new line.
                                    csv += vbCr & vbLf
                                Next

                                myWriter.WriteLine(csv)

                                'Clean up
                                myWriter.Close()

                            End Using

                        End Using

                    End Using

                End Using
        End Select
    End Sub

    Function clientFolder() As String
        Try
            Select Case Session("CurrentClientID")
                Case "18"
                    Return "BARetc"
                Case "19"
                    Return "Gallo"
                Case "20"
                    Return "WindyHill"
                Case "21"
                    Return "Stoli"
            End Select

        Catch ex As Exception
            Return "BARetc"
        End Try

        Return "BARetc"

    End Function

End Class