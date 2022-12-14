Imports System.Data.SqlClient

Public Class DownloadHandler
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim photoID As Integer = Request.QueryString("photoID")
        Try
            Dim db As New DataClassesDataContext

            Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault

            Dim data As Byte() = GetPhoto(photoID)

            HttpContext.Current.Response.Clear()
            HttpContext.Current.Response.ContentType = "application/octet-stream"
            HttpContext.Current.Response.AddHeader("content-disposition", Convert.ToString("attachment; filename=") & String.Format(_fileName.Replace(" ", String.Empty)))
            HttpContext.Current.Response.BinaryWrite(data)


        Catch ex As Exception

        End Try

    End Sub

    Private Function GetPhoto(photoId As Integer) As Byte()

        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Dim comm As New SqlCommand("SELECT Image FROM tblPhoto WHERE photoID = @photoID", conn)
        comm.Parameters.Add(New SqlParameter("@PhotoID", photoId))

        conn.Open()
        Dim data As Object = comm.ExecuteScalar()
        conn.Close()

        Return DirectCast(data, Byte())
    End Function

End Class