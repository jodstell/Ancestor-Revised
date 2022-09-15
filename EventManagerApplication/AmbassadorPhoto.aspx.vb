Imports System.Data.SqlClient

Public Class AmbassadorPhoto
    Inherits System.Web.UI.Page
    Protected WithEvents Image1 As System.Web.UI.WebControls.Image

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ShowTheImage()
    End Sub

    'Show Image Function
    Private Function ShowTheImage()

        Try
            Dim size As String = Request.QueryString("size")
            Dim query As String
            Dim SQL As String
            Select Case size

                Case 0
                    query = "headShot"
                    SQL = "SELECT headShot FROM tblAmbassador WHERE userID=" & Request.QueryString("ID")
                Case 1
                    query = "bodyShot"
                    SQL = "SELECT largeimage FROM auction_Image WHERE ImageID=" & Request.QueryString("ID")
                Case Else
                    query = ""
                    SQL = ""

            End Select

            Dim myConnection As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
            Dim command As New SqlCommand(SQL, myConnection)
            myConnection.Open()

            Dim dr As SqlDataReader
            dr = command.ExecuteReader
            dr.Read()
            Response.Clear()
            Response.ContentType = "image/GIF"
            Response.BinaryWrite(dr(query))

            dr.Close()
            myConnection.Close()

            Response.End()
        Catch ex As Exception

        End Try



#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths


End Class