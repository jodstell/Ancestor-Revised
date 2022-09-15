Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.IO
Imports System.Globalization
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Telerik.Web.UI
Imports System.Data.SqlClient

Public Class UserManagerControl
    Inherits System.Web.UI.UserControl
    Dim db2 As New LMSDataClassesDataContext
    Dim db As New DataClassesDataContext
    Dim siteid As String = "GigEngyn"

    Private Sub UserManagerControl_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        For Each col As GridColumn In StaffList.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Dim userlist As New List(Of SiteUsers)

        'Dim i = From p In db.UserDetails Where p.SiteID = siteid Select p
        'For Each p In i
        '    userlist.Add(New SiteUsers(p.Id, siteid, p.UserName, p.FirstName, p.LastName, checkIfAdmin(p.UserName), checkIfInstr(p.UserID), checkIfEditor(p.UserID), checkIfStudent(p.UserID), p.LastLoginDate, "Active"))
        'Next

        'Dim q = From p In userlist
        '        Where p.SiteID = siteid Select p

        'UsersTable.DataSource = q
        'UsersTable.DataBind()


    End Sub

    Function checkIfAdmin(ByVal id As String) As Boolean
        Try
            Dim manager = New UserManager()
            Dim currentUser = manager.FindByName(id)

            If manager.IsInRole(currentUser.Id, "Administrator") Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try

        Return False

    End Function

    Function checkIfInstr(ByVal id As String) As Boolean
        Try
            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(id)

            If manager.IsInRole(currentUser.Id, "Instructor") Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try

    End Function

    Function checkIfEditor(ByVal id As String) As Boolean
        Try
            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(id)

            If manager.IsInRole(currentUser.Id, "Editor") Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try

    End Function

    Function checkIfStudent(ByVal id As String) As Boolean
        Try
            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(id)

            If manager.IsInRole(currentUser.Id, "Student") Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try

    End Function

    Function getLastLoginDate(ByVal currentUser)

        Try
            Dim manager = New UserManager()

            Dim user As ApplicationUser = manager.FindByName(currentUser)

            Dim q = (From p In db2.UserDetails Where p.UserID = user.Id Select p.LastLoginDate).FirstOrDefault

            Return GetTimeAdjustment(q)
        Catch ex As Exception
            Return ""
        End Try

    End Function

    Function GetTimeAdjustment(ByVal d As Date) As String

        Try

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            Dim MyTimeZone As String

            Dim currentuser_TimeZone = (From p In db2.AspNetUsersProfiles Where p.UserID = currentUser.Id Select p.TimeZone).FirstOrDefault

            If currentuser_TimeZone = "" Or Nothing Then
                MyTimeZone = (From p In db2.Sites Where p.SiteID = siteid Select p.DefaultTimeZone).FirstOrDefault
            Else
                MyTimeZone = currentuser_TimeZone
            End If

            Dim MyCulture As String = (From p In db2.Sites Where p.SiteID = siteid Select p.CultureInfoCode).FirstOrDefault

            Dim cstZone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(MyTimeZone)

            Dim cstTime As DateTime = TimeZoneInfo.ConvertTimeFromUtc(d, cstZone)

            'add culture
            Dim culture As CultureInfo = CultureInfo.CreateSpecificCulture(MyCulture)


            Return String.Format("{0} ({1})", cstTime.ToString(culture.DateTimeFormat), ShortTimeZoneFormat(MyTimeZone))
        Catch ex As Exception
            Return ""
        End Try

    End Function

    Private Function ShortTimeZoneFormat(timeZoneStandardName As String) As String
        Dim TimeZoneElements As String() = timeZoneStandardName.Split(" "c)
        Dim shortTimeZone As String = [String].Empty
        For Each element As String In TimeZoneElements
            'copies the first element of each word
            shortTimeZone += element(0)
        Next
        Return shortTimeZone
    End Function

    Function getformat(ByVal status As String) As String

        Select Case status
            Case "Active"
                Return "success"
            Case "Pending"
                Return "secondary"
            Case Else
                Return ""

        End Select

    End Function


    Private Sub StaffList_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles StaffList.ItemCommand
        If e.CommandName = "ViewProfile" Then
            Response.Redirect("/admin/users/userprofile?UserID=" & e.CommandArgument)
        End If
    End Sub

    Protected Sub EventDataGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)
        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()
    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {0} FROM tblProfiles where IsStaff = true order by {0}", field)

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()

        adapter.SelectCommand = New SqlCommand(query, conn)

        Dim myDataTable As New DataTable()

        conn.Open()

        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function

    Public Sub ConfigureExport()

        StaffList.ExportSettings.ExportOnlyData = False
        StaffList.ExportSettings.IgnorePaging = True
        StaffList.ExportSettings.OpenInNewWindow = True
        StaffList.ExportSettings.UseItemStyles = False
        StaffList.ExportSettings.FileName = "Users"

    End Sub

    Function getOnlineStatus(id As String) As String

        Dim q = (From p In db.qryGetLoggedInUsers Where p.userID = id Select p).Count

        If q = 0 Then Return "No" Else Return "Yes"
    End Function

    Function getRoles(id As String) As String
        Dim myline As String

        Dim q = From p In db2.qryUserRoles Where p.UserId = id Select p

        For Each p In q
            'myline = p.Name
            Return myline.Join(",", p.Name).ToString()
        Next

#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Protected Sub btnCancelFilter2_Click(sender As Object, e As EventArgs)
        Response.Redirect("/admin/siteadministration#_" & "users")
    End Sub
End Class