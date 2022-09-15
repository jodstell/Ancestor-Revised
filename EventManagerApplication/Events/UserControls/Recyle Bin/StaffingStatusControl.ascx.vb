Public Class StaffingStatusControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext
    Dim users As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getPositionName(id As Integer) As String
        Return (From p In db.tblStaffingPositions Where p.staffingPositionID = id Select p.positionTitle).FirstOrDefault
    End Function

    Function getFullName(username As String) As String
        Dim userid = (From p In users.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault

        Dim first_name = (From p In users.AspNetUsersProfiles Where p.UserID = userid Select p.FirstName).FirstOrDefault
        Dim last_name = (From p In users.AspNetUsersProfiles Where p.UserID = userid Select p.LastName).FirstOrDefault

        Return first_name & " " & last_name
    End Function

    Function getProfileImage(username As String) As String
        Dim userid = (From p In users.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault

        Return (From p In users.AspNetUsersProfiles Where p.UserID = userid Select p.PhotoUrl).FirstOrDefault
    End Function

    Private Sub StaffingList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles StaffingList.ItemDataBound
        If StaffingList.Items.Count < 1 Then

            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
            End If

        End If

    End Sub

    Function getUserID(username As String) As String
        Dim userdb As New LMSDataClassesDataContext

        Return (From p In userdb.AspNetUsers Where p.UserName = username Select p.Id).FirstOrDefault
    End Function

End Class