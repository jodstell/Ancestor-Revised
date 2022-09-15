Imports Telerik.Web.UI
Imports System.Globalization
Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.IO
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Public Class SiteVisits
    Inherits System.Web.UI.Page
    Dim db As New LMSDataClassesDataContext
    Dim db1 As New DataClassesDataContext
    Dim siteid As String = "GigEngyn"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getRoles(id As String) As String
        Dim myline As String

        Dim q = From p In db.qryUserRoles Where p.UserId = id Select p

        For Each p In q
            Dim name As String
            If p.Name = "Student" Then
                name = "Ambassador"
            Else
                name = p.Name
            End If
            'myline = p.Name
            Return myline.Join(",", name).ToString()
        Next

#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths




End Class