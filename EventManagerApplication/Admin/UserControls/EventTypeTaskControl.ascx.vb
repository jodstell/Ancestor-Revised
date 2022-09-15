Public Class EventTypeTaskControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub getEventTypeTasks_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getEventTypeTasks.Inserting
        Dim id = Request.QueryString("EventTypeID")

        Dim l As tblEventTypeTask
        l = CType(e.NewObject, tblEventTypeTask)
        l.eventTypeID = id

    End Sub

    Function formatTimeOffset(ByVal t As String) As String

        Select Case t
            Case "0"
                Return "0 days"
            Case "-1"
                Return "1 day prior"
            Case "-2"
                Return "2 days prior"
            Case "-3"
                Return "3 days prior"
            Case "-4"
                Return "4 days prior"
            Case "-5"
                Return "5 days prior"
            Case "-6"
                Return "6 days prior"
            Case "-7"
                Return "7 days prior"
            Case "-14"
                Return "14 days prior"
            Case "-30"
                Return "30 days prior"
            Case "1"
                Return "1 day after"
            Case "2"
                Return "2 days after"
            Case "3"
                Return "3 days after"
            Case Else
                Return ""
        End Select

    End Function

End Class