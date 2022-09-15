Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class ScoresControl
    Inherits System.Web.UI.UserControl
    Dim db As DataClassesDataContext
    Dim users As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try


            ' msgLabel.Text = (From p In db.tblEventStaffingRequirements Where p.eventID = Request.QueryString("ID") Select p.assignedUserName).FirstOrDefault



            ' AmbassadorTestResultsList.DataSource = (From p In db.qryEventStaffingStatus Where p.eventID = 500045 Select p).FirstOrDefault
            'AmbassadorTestResultsList.DataBind()
        Catch ex As Exception
            msgLabel.Text = Common.ShowAlertNoClose("warning", ex.Message)
        End Try


    End Sub

    'Function getFullName(username As String) As String
    '    If username = "Not Staffed" Then
    '        Return "<span class='label label-danger'>Not Staffed</span>"
    '    Else
    '        Dim userid = (From p In users.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault

    '        Dim first_name = (From p In db.tblAmbassadors Where p.userID = userid Select p.FirstName).FirstOrDefault
    '        Dim last_name = (From p In db.tblAmbassadors Where p.userID = userid Select p.LastName).FirstOrDefault

    '        Return first_name & " " & last_name
    '    End If


    'End Function

End Class