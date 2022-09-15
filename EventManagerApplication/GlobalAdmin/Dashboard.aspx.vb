Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.IO
Imports System.Globalization
Imports System.Web.Script.Serialization
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports System.Net

Public Class Dashboard5
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim db2 As New LMSDataClassesDataContext
    Dim siteid As String = "GigEngyn"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'get counts
        CurrentLoginCountLabel.Text = (From p In db.qryGetLoggedInUsers Select p).Count
        TotalLoginCount.Text = (From p In db.qryGetLoggedInUsers_last24hours Select p).Count

        Dim con0 = (From p In db.GetLoggedInUserTotals() Select p).FirstOrDefault

        If con0.Difference = 0 Then
            CurrentLoginIcon.Text = ""
            TotalLoginIcon.Text = ""
        ElseIf con0.Difference > 0 Then
            CurrentLoginIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
            TotalLoginIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            CurrentLoginIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
            TotalLoginIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        Dim total = (From p In db.qryGetLoggedInUsers_last24hours Select p).Count
        Dim visits = (From p In db.qryGetNewVisits_last24hours Select p).Count

        NewVisitPercentLabel.Text = String.Format("{0:0%}", visits / total)

        Dim con = (From p In db.GetNewVisitsTotals() Select p).FirstOrDefault

        If con.Difference = 0 Then
            NewVisitPercentIcon.Text = ""
        ElseIf con.Difference > 0 Then
            NewVisitPercentIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewVisitPercentIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If




        RecapsSubmittedLabel.Text = (From p In db.qryGetRecapCreated_last24hours Select p).Count

        Dim con1 = (From p In db.GetLastHourChangeCount("Recap Completed") Select p).FirstOrDefault

        If con1.Total = 0 Then
            RecapsSubmittedIcon.Text = ""
        ElseIf con1.Total > 0 Then
            RecapsSubmittedIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            RecapsSubmittedIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        ApprovedEventsCountLabel.Text = (From p In db.qryGetApprovedEvents_last24hrs Select p).Count
        Dim con2 = (From p In db.GetLastHourChangeCount("Event Approved") Select p).FirstOrDefault
        If con2.Total = 0 Then
            ApprovedEventIcon.Text = ""
        ElseIf con2.Total > 0 Then
            ApprovedEventIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            ApprovedEventIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If



        'New Events Count
        NewEventsCountLabel.Text = (From p In db.qryGetNewEvents_last24hours Select p).Count

        Dim con3 = (From p In db.GetLastHourChangeCount("Event Created") Select p).FirstOrDefault
        If con3.Total = 0 Then
            NewEventIcon.Text = ""
        ElseIf con3.Total > 0 Then
            NewEventIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewEventIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If

        NewRegistrationsLabel.Text = (From p In db.qryGetRegistrations_last24hrs Select p).Count
        Dim con5 = (From p In db.GetNewRegistrations() Select p).FirstOrDefault
        If con5.Difference = 0 Then
            NewRegistrationsIcon.Text = ""
        ElseIf con5.Difference > 0 Then
            NewRegistrationsIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewRegistrationsIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        NewAmbassadorsLabel.Text = (From p In db.qryGetNewAmbassadors_last24hrs Select p).Count


        NewAssignmentsLabel.Text = (From p In db.qryGetAmbassadorAssigned_last24hrs Select p).Count

        Dim con4 = (From p In db.GetLastHourChangeCount("Ambassador Assigned") Select p).FirstOrDefault
        If con4.Total = 0 Then
            NewAssignmentsIcon.Text = ""
        ElseIf con4.Total > 0 Then
            NewAssignmentsIcon.Text = "<i Class='fa fa-arrow-down redicon' aria-hidden='true'></i>"
        Else
            NewAssignmentsIcon.Text = "<i Class='fa fa-arrow-up greenicon' aria-hidden='true'></i>"
        End If


        'LMSVersionLabel.Text = (From p In db2.Sites Where p.SiteID = "GigEngyn" Select p.RequiredTestText).FirstOrDefault

        lblASPVersion.Text = String.Format("Build Version: {0} ", System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString())
    End Sub

End Class