Imports System.Data.SqlClient

Public Class GetResume
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim filetype = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p.resumeFileType).FirstOrDefault
        Dim filename = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p.resumeFileName).FirstOrDefault

        Using con As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
            con.Open()

            Using Com As New SqlCommand("SELECT * FROM tblAmbassador WHERE UserID=@UserID", con)
                Com.CommandType = CommandType.Text
                Com.Parameters.AddWithValue("@UserID", Request.QueryString("UserID"))
                Using RDR = Com.ExecuteReader()
                    If RDR.Read Then
                        'Get the data out as a byte array
                        Dim Bytes() = DirectCast(RDR.Item(Request.QueryString("file")), Byte())
                        'Clear all response headers
                        Response.Clear()
                        'Set the type, my sample is a RAR file, you'll need to look up MIME types for yours
                        Response.AddHeader("Content-Type", filetype)
                        'Set the name of the file, if you don't set it browsers will use the name of this page which you don't want
                        Response.AddHeader("Content-Disposition", "inline; filename=" & filename)
                        'Optional but nice, set the length so users get a progress bar
                        Response.AddHeader("Content-Length", Bytes.Count.ToString())
                        'Push the bytes out raw
                        Response.BinaryWrite(Bytes)
                        'Close the response stream so no more HTML gets accidentally pushed out
                        Response.End()
                    Else
                        'Error, no file was found
                    End If
                End Using
            End Using
            con.Close()
        End Using

    End Sub

End Class