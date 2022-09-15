Public Class AvailableTestsControl
    Inherits System.Web.UI.UserControl
    Shared db As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim dbGUID As String = System.Web.HttpContext.Current.User.Identity.Name

        GUID.Value = System.Web.HttpContext.Current.User.Identity.Name
        SiteID.Value = GetSiteID()

        'Dim av As New List(Of AvailableTestList)

        'For Each x In db.AvailableTests(dbGUID, GetSiteID())
        '    av.Add(New AvailableTestList(x.QuizID, x.Title, x.dbGUID, x.Result, x.prerequisite, x.PreReqResult, x.Enabled, x.RetakeTestHrs, x.SiteID, x.GroupID, x.InstructorID))
        'Next

        'Dim i = db.AvailableTests(dbGUID, GetSiteID()).Count

        'Dim passed = (From p In av Where p.dbGUID = dbGUID And p.Result = "Passed" Select p).Count
        'Dim retake = (From p In av Where p.dbGUID = dbGUID And p.Result = "Retake Test" Select p).Count
        'Dim wait = (From p In av Where p.dbGUID = dbGUID And p.Result = "Wait" Select p).Count

        'If i = passed + retake + wait Then
        '    ' Panel1.Visible = True
        'End If
    End Sub

    Function getGroupTitle(ByVal groupid As String) As String

        Return (From p In db.TestGroups Where p.GroupID = groupid Select p.GroupTitle).FirstOrDefault

    End Function

    Function GetSiteID() As String

        Dim host As String = Request.Url.Host.ToLower

        Try
            Dim q = From p In db.Sites Where p.Host = host Select p

            For Each p In q
                Return (p.SiteID)
            Next
        Catch ex As Exception

        End Try

        Return host

    End Function
    Function ifAvailable(ByVal TestID, ByVal GUID)
        Dim myConnString As String = ConfigurationManager.ConnectionStrings("LMSConnection").ToString()
        Dim mySelectQuery As String = "SELECT Top 1 [Result] FROM TestScores WHERE ([TestID] = '" & TestID & "' AND [UserName] = '" & System.Web.HttpContext.Current.User.Identity.Name & "') Order By DateTimeCompleted DESC"
        Dim myConnection As New System.Data.SqlClient.SqlConnection(myConnString)
        Dim myCommand As New System.Data.SqlClient.SqlCommand(mySelectQuery, myConnection)

        myConnection.Open()

        Dim result As Object = myCommand.ExecuteScalar()

        myConnection.Close()

        Return (result)
    End Function

    Function getPrerequisiteResult(ByVal TestID, ByVal GUID)
        Dim myConnString As String = ConfigurationManager.ConnectionStrings("LMSConnection").ToString()
        Dim mySelectQuery As String = "SELECT Top 1 [Result] FROM TestScores WHERE ([TestID] = '" & TestID & "' AND [UserName] = '" & System.Web.HttpContext.Current.User.Identity.Name & "') Order By DateTimeCompleted DESC"
        Dim myConnection As New System.Data.SqlClient.SqlConnection(myConnString)
        Dim myCommand As New System.Data.SqlClient.SqlCommand(mySelectQuery, myConnection)

        myConnection.Open()

        Dim result As Object = myCommand.ExecuteScalar()

        myConnection.Close()

        Return (result)

    End Function

    Function getPreReqTest(ByVal PreReqResult, ByVal PreReqTitle)
        If PreReqResult = "0" Or PreReqResult = "Passed" Then
            Return ""
        Else
            Return "You must pass the <b>" & PreReqTitle & "</b> test before this test is available.<br>"
        End If

    End Function


    'Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)

    '    If e.Row.RowType = DataControlRowType.DataRow Then

    '        Dim PreReqResult As String = (DataBinder.Eval(e.Row.DataItem, "PreReqResult"))
    '        If PreReqResult = "Passed" Or PreReqResult = "0" Then
    '            e.Row.Cells(1).Enabled = True
    '        Else
    '            e.Row.Cells(1).Enabled = False
    '            e.Row.Cells(1).Text = "N/A"
    '            e.Row.Cells(1).Font.Bold = False
    '            ' e.Row.Cells(1).ControlStyle.CssClass = "btn btn-xs btn-defualt"
    '            'to hide to row set to False
    '            e.Row.Visible = False
    '        End If

    '        Dim Result As String = (DataBinder.Eval(e.Row.DataItem, "Result"))
    '        If Result = "Retake Test" Or Result = "Passed" Or Result = "Wait" Or Result = "N/A" Then
    '            e.Row.Visible = False
    '        End If


    '        Dim group As String = (DataBinder.Eval(e.Row.DataItem, "GroupID"))
    '        If validateGroup(group) = False Then
    '            e.Row.Visible = False
    '        End If



    '    End If

    'End Sub

    Function validateGroup(ByVal groupID As String) As Boolean

        Dim q = (From p In db.StudentsInGroups Where p.TestGoupID = groupID And p.UserName = System.Web.HttpContext.Current.User.Identity.Name Select p).Count
       
        If q = 0 Then
            Return False
        Else
            Return True
        End If
    End Function

    Private Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView1.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim Result As String = (DataBinder.Eval(e.Row.DataItem, "TestResult"))
            If Result = "Retake Test" Or Result = "Passed" Or Result = "Wait" Or Result = "N/A" Then
                e.Row.Visible = False
            End If

        End If

    End Sub


End Class