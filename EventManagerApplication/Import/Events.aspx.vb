Imports LinqToExcel
Public Class ImportEvents
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim count As Integer = 0
    Dim failed As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub btnImport_Click(sender As Object, e As EventArgs) Handles btnImport.Click

        'Try
        '    count = 0

        '    Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/event2.xls"))

        '    ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

        '    Dim events = From x In excel.Worksheet(Of EventList)("worksheet") _
        '                Select x



        '    For Each u In events
        '        Try
        '            Dim w = From p In db.tblEvents Where p.eventID = u.ID Select p

        '            If w.count = 0 Then
        '                Dim i As New tblEvent With {.eventID = u.ID,
        '                                       .eventTitle = u.EventName,
        '                                       .eventDate = u.EventDate,
        '                                       .startTime = u.StartTime,
        '                                       .endTime = u.EndTime,
        '                                       .marketName = u.Market,
        '                                       .programName = u.Program,
        '                                       .brandName = u.Brand,
        '                                       .typeName = u.EventType,
        '                                       .locationID = u.Vpid
        '                                       }

        '                db.tblEvents.InsertOnSubmit(i)
        '                db.SubmitChanges()

        '                count = count + 1

        '            Else
        '                failed = failed + 1
        '            End If


        '        Catch ex As Exception
        '            failed = failed + 1
        '            Response.Write(ex.Message)
        '        End Try

        '    Next

        '    msgLabel.Text = count & " records have been added.  " & failed & " records failed."
        'Catch ex As Exception
        '    msgLabel.Text = ex.Message
        'End Try

    End Sub
End Class