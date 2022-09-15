Imports System.Net
Imports System.Web.Script.Serialization
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports iTextSharp.text.pdf
Imports iTextSharp.text
Imports System.IO

Public Class TodaysEventsControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

            hiddenUserName.Text = (From p In db.tblAmbassadors Where p.userID = currentUser.Id Select p.userName).FirstOrDefault

            Dim hasEvent As Integer = (From p In db.qryViewEventsByAmbassadors Where p.userID = currentUser.Id And p.eventDate = Date.Today() Select p).Count

            If hasEvent = 0 Then
                NoEventPanel.Visible = True
                EventPanel.Visible = False
            Else
                NoEventPanel.Visible = False
                EventPanel.Visible = True

                Dim q = (From p In db.qryViewEventsByAmbassadors Where p.userID = currentUser.Id And p.eventDate = Date.Today() Select p).FirstOrDefault
                hiddenEventID.Text = q.eventID
                SupplierNameLabel.Text = q.supplierName
                AccountNameLabel.Text = q.accountName
                AddressLabel.Text = q.address
                CityStateLabel.Text = String.Format("{0}, {1}  {2}", q.city, q.state, "")
                EventTimeLabel.Text = String.Format("{0:t} - {1:t}", q.startTime, q.endTime)

                If q.checkedIn = True Then
                    CheckInPanel.Visible = True
                    NotCheckInPanel.Visible = False
                Else
                    NotCheckInPanel.Visible = True
                    CheckInPanel.Visible = False
                End If
                'PhoneLabel.Text = getAccountPhone(q.accountID)
                'ContactNameLabel.Text = getAccountContactName(q.accountID)
            End If

        End If
    End Sub


    Function getAccountPhone() As String

        Return ""

    End Function

End Class