Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI
Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient

Public Class PayrollApproved
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

#Region "UserManager"
    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load




    End Sub

    Private Sub btnContinue_Click(sender As Object, e As EventArgs) Handles btnContinue.Click



        successLabel.Text = Common.ShowAlertNoClose("success", "<b>Congratulations!</> You have successfully generated the Payroll for the period " _
                & fromRadDatePicker.SelectedDate & " to " & toRadDatePicker.SelectedDate)

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        'create new payment id
        Dim r As New tblPayment
        r.dateSubmitted = Date.Now()
        r.payrollName = txtPayrollName.Text
        r.fromDate = fromRadDatePicker.SelectedDate
        r.toDate = toRadDatePicker.SelectedDate
        r.submittedBy = currentUser.Id
        r.clientID = Convert.ToInt32(Session("CurrentClientID"))

        db.tblPayments.InsertOnSubmit(r)
        db.SubmitChanges()

        'update status to paid
        Dim a1 = From p In db.GetApprovedPayments_toProcessByDate(fromRadDatePicker.SelectedDate, toRadDatePicker.SelectedDate) Select p
        For Each p In a1

            Dim q2 = (From i In db.tblEventStaffingRequirements Where i.RequirementID = p.RequirementID Select i).FirstOrDefault

            q2.paymentStatus = "Processing"
            q2.paymentID = r.paymentID
            q2.paymentDate = toRadDatePicker.SelectedDate

            db.SubmitChanges()
        Next

        btnDownloadCSV.NavigateUrl = "/payrollexport/" & r.payrollName & r.paymentID & ".csv"

        'create csv file
        Dim constr As String = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

        Using con As New SqlConnection(constr)

            'add new qry filtered by Processing
            Using cmd As New SqlCommand("SELECT * FROM getApprovedPayments_toProcessCSV")
                Using sda As New SqlDataAdapter()
                    cmd.Connection = con
                    sda.SelectCommand = cmd

                    Dim myWriter As New System.IO.StreamWriter(MapPath("~/payrollexport/" & r.payrollName & r.paymentID & ".csv"))

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


        'update status to paid
        Dim q1 = From i In db.tblEventStaffingRequirements Where i.paymentStatus = "Processing" Select i
        For Each i In q1
            i.paymentStatus = "Paid"

            db.SubmitChanges()
        Next

        'Next

        ProcessPanel.Visible = False
        FinalPanel.Visible = True


    End Sub

    Private Sub btnProcessExportPayroll_Click(sender As Object, e As EventArgs) Handles btnProcessExportPayroll.Click

        If ApprovedPaymentsRadGrid.Items.Count = 0 Then

            topMsgLabel.Text = "There is no items that are ready to be processed."

        Else

            ApprovedPanel.Visible = False
            ProcessPanel.Visible = True

        End If



    End Sub

    Private Sub btnChangeDateRange_Click(sender As Object, e As EventArgs) Handles btnChangeDateRange.Click

        Try

            TotalCountLabel.Text = (From p In db.GetApprovedPayments_toProcessByDate(fromRadDatePicker.SelectedDate, toRadDatePicker.SelectedDate) Select p).Count


            'TotalCountLabel.Text = (From p In db.qryViewApprovedPayments Where p.clientID = Convert.ToInt32(Session("CurrentClientID")) And p.eventDate > fromRadDatePicker.SelectedDate And p.eventDate < toRadDatePicker.SelectedDate Select p).Count

        Catch ex As Exception
            TotalCountLabel.Text = ex.Message()
        End Try

        Dim SumPayroll As Double
        Try

            SumPayroll = (From p In db.GetApprovedPayments_toProcessByDate(fromRadDatePicker.SelectedDate, toRadDatePicker.SelectedDate) Select p.Total).Sum
            ' SumPayroll = (From p In db.qryViewApprovedPayments Where p.clientID = Convert.ToInt32(Session("CurrentClientID")) And p.eventDate > fromRadDatePicker.SelectedDate And p.eventDate < toRadDatePicker.SelectedDate Select p.Total).Sum
        Catch ex As Exception
            SumPayroll = 0
        End Try

        Dim count As Double

        Try
            count = (From p In db.GetApprovedPayments_toProcessByDate(fromRadDatePicker.SelectedDate, toRadDatePicker.SelectedDate) Select p).Count
            'count = (From p In db.qryViewApprovedPayments Where p.clientID = Convert.ToInt32(Session("CurrentClientID")) And p.eventDate > fromRadDatePicker.SelectedDate And p.eventDate < toRadDatePicker.SelectedDate Select p).Count
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
            TotalHoursLabel.Text = (From p In db.GetApprovedPayments_toProcessByDate(fromRadDatePicker.SelectedDate, toRadDatePicker.SelectedDate) Select p.Hours).Sum
            'TotalHoursLabel.Text = (From p In db.qryViewApprovedPayments Where p.clientID = Convert.ToInt32(Session("CurrentClientID")) And p.eventDate > fromRadDatePicker.SelectedDate And p.eventDate < toRadDatePicker.SelectedDate Select p.hours).Sum
        Catch ex As Exception
            TotalHoursLabel.Text = "0"
        End Try

        Try
            AmbassadorCountLabel.Text = (From p In db.GetApprovedPayments_toProcessByDate(fromRadDatePicker.SelectedDate, toRadDatePicker.SelectedDate) Select p.FullName).Distinct().Count()

            'AmbassadorCountLabel.Text = (From p In db.qryViewApprovedPayments Where p.clientID = Convert.ToInt32(Session("CurrentClientID")) And p.eventDate > fromRadDatePicker.SelectedDate And p.eventDate < toRadDatePicker.SelectedDate Select p.FullName).Distinct().Count()
        Catch ex As Exception
            AmbassadorCountLabel.Text = "0"
        End Try



    End Sub

    ' Private Sub btnExportPayroll_Click(sender As Object, e As EventArgs) Handles btnExportPayroll.Click

    'Response.Redirect("/documents/payrollexport/3001.csv")


    'ApprovedPaymentsRadGrid.ExportSettings.ExportOnlyData = False
    'ApprovedPaymentsRadGrid.ExportSettings.IgnorePaging = True
    'ApprovedPaymentsRadGrid.ExportSettings.OpenInNewWindow = True
    'ApprovedPaymentsRadGrid.ExportSettings.UseItemStyles = False
    'ApprovedPaymentsRadGrid.ExportSettings.FileName = "BA_Pay_Import"

    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("UserName").Visible = False
    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("FullName").Visible = False
    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("Hours").Visible = False
    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("Labor").Visible = False
    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("Expenses").Visible = False
    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("Bonus").Visible = False
    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("Total").Visible = False
    ''EventDataGrid.MasterTableView.GetColumn("statusName").Visible = False
    ''EventDataGrid.MasterTableView.GetColumn("status").Visible = True
    ''EventDataGrid.MasterTableView.GetColumn("accountName").Visible = False
    ''EventDataGrid.MasterTableView.GetColumn("accountName1").Visible = True
    ''EventDataGrid.MasterTableView.GetColumn("address").Visible = True
    ''EventDataGrid.MasterTableView.GetColumn("city").Visible = True
    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("work_type_name").Visible = True
    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("quantity").Visible = True
    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("display_name").Visible = True
    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("external_worker_id").Visible = True
    'ApprovedPaymentsRadGrid.MasterTableView.GetColumn("email").Visible = True

    '' EventDataGrid.MasterTableView.GetColumn("marketName").HeaderText = "Market"

    '' ApprovedPaymentsRadGrid.ExportSettings.Csv.Format = GridExcelExportFormat.

    'ApprovedPaymentsRadGrid.MasterTableView.ExportToCSV()
    '  End Sub

End Class