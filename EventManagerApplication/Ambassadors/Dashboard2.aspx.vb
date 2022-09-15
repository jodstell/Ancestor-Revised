Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class Dashboard21
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim userdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Session.Add("CurrentUserID", currentUser.Id)
        Dim userid As String = Session("CurrentUserID")

        Session.Add("CurrentUserName", currentUser.UserName)

        '   Guid.Value = System.Web.HttpContext.Current.User.Identity.Name

        Dim action = Request.QueryString("action")

        'Select Case action
        '    Case 0
        '        msgLabel2.Text = Common.ShowAlert("success", "Your recap has been saved and you can return to finish it later.")
        '    Case 1
        '        msgLabel2.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")
        '    Case 2
        '        msgLabel2.Text = Common.ShowAlert("success", "Your recap has been successfully submitted!")
        '    Case 3
        '        msgLabel2.Text = Common.ShowAlert("danger", "There was an error saving your recap.  The site administrator has been notified!  Sorry of the inconvience.")

        'End Select

        If Not Page.IsPostBack Then

            '  BindCurrentCourses()


            ' BindForm(userid)

            '     FullNameLabel.Text = String.Format("{0} {1}", (From p In db.tblAmbassadors Where p.userID = userid Select p.FirstName).FirstOrDefault, (From p In db.tblAmbassadors Where p.userID = userid Select p.LastName).FirstOrDefault)
            ' AccountNameLabel.Text = (From p In db.tblAmbassadors Where p.userID = userid Select p.FirstName).FirstOrDefault
            '  CountLabel.text = (From p In db.qryViewPastEventsByAmbassadors Where p.userID = currentUser.Id Select p).Count
            '  TotalHoursLabel.Text = "0"

            '   CurrentDateLabel.Text = String.Format("{0:D}", Date.Now)

            Try
                Dim birthDate As Date
                birthDate = (From p In db.tblAmbassadors Where p.userID = userid Select p.DOB).FirstOrDefault

            Catch ex As Exception

            End Try

        End If

        'get count labels

        AvailableCountLabel.Text = (From p In db.GetAvailableEventsbyAmbassador(userid) Select p).Count
        '  RecapCountLabel.Text = (From p In db.qryViewNeedsRecapEventsByAmbassadors Where p.userID = userid Select p).Count
        '  UpcomingCountLabel.Text = (From p In db.qryViewCurrentEventsByAmbassadors Where p.userID = userid Select p).Count
        '  PreviousCountLabel.Text = (From p In db.qryViewPastEventsByAmbassadors Where p.userID = userid Select p).Count
    End Sub

End Class