Imports Microsoft.AspNet.Identity

Public Class Clients
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim _ClientID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            'If Common.GetCurrentClientID() IsNot Nothing Then
            '    ClientID = Common.GetCurrentClientID()
            'Else
            _ClientID = GetCurrentClientID()
            'End If

            Try
                Me.ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = _ClientID Select p.clientName).FirstOrDefault

            Catch ex As Exception
                'Me.ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = 18 Select p.clientName).FirstOrDefault
            End Try

            BindClient()

            GetEventCounts(_ClientID)
            'Me.AccountTypeCountLabel.Text = GetAccountTypeCount(_ClientID)
            'Me.MarketCountLabel.Text = GetMarketCount(_ClientID)

            Dim action = Request.QueryString("Action")

            Select Case action
                Case "0"

                Case "1"
                    msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

                Case "2"
                    msgLabel.Text = Common.ShowAlert("success", "The new brand was saved successfully!")
            End Select

        End If

    End Sub

    Function GetCurrentClientID() As String
        Try
            Dim db As New DataClassesDataContext

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

            Dim result = (From p In db.tblProfiles Where p.userID = currentUser.Id Select p).FirstOrDefault

            Return String.Format("{0}", result.currentClientID)
        Catch ex As Exception

            Return "There was an error"
        End Try


    End Function

    Public Sub BindClient()


    End Sub

    Function GetAccountTypeCount(clientID As Integer) As String

        Return (From p In db.tblClientAccountTypes Where p.clientID = _ClientID Select p).Count
    End Function

    Function GetMarketCount(clientID As Integer) As String

        Return (From p In db.tblClientMarkets Where p.clientID = _ClientID Select p).Count
    End Function


    Public Sub GetEventCounts(clientID As Integer)

        'lblEventTypeCount.Text = (From p In db.tblClientEventTypes Where p.clientID = _ClientID Select p).Count
        'lblSupplierCount.Text = (From p In db.tblSuppliers Where p.clientID = _ClientID Select p).Count
        'lblBrandCount.Text = (From p In db.tblBrands Where p.clientID = _ClientID Select p).Count
        'lblBrandGroups.Text = (From p In db.qryGetBrandGroupsByClientIDs Where p.clientID = _ClientID Select p).Count
        'lblTeamsCount.Text = (From p In db.tblTeams Select p).Count

    End Sub

    Private Sub getClientConfig_Updated(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getClientConfig.Updated

        Response.Redirect("/admin/Clients?Action=1&ClientID=18#configurationtab/#clientconfig")

    End Sub


End Class