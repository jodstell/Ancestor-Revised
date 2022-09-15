
Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient

Public Class CreatePayrollTest
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ExportCSV(sender As Object, e As EventArgs)

        Dim constr As String = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SELECT * FROM getApprovedPayments_toProcess")
                Using sda As New SqlDataAdapter()
                    cmd.Connection = con
                    sda.SelectCommand = cmd

                    Dim myWriter As New System.IO.StreamWriter(MapPath("~/documents/MyTestCSV.csv"))

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

    End Sub


End Class