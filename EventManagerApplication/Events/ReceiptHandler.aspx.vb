
Imports System.Data.SqlClient

Public Class ReceiptHandler
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim id = Request.QueryString("eventExpenseID")
        Dim bytes As Byte()
        Dim fileName As String, contentType As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand()
                cmd.CommandText = "SELECT receipt FROM tblEventExpense WHERE eventExpenseID=@Id"
                cmd.Parameters.AddWithValue("@Id", id)
                cmd.Connection = con
                con.Open()
                Using sdr As SqlDataReader = cmd.ExecuteReader()
                    sdr.Read()
                    bytes = DirectCast(sdr("Data"), Byte())
                    contentType = "application/octet-stream"
                    fileName = sdr("eventExpenseID").ToString()
                End Using
                con.Close()
            End Using
        End Using

        Dim ext As String
        Select Case contentType
            Case "application/vnd.openxmlformats-officedocument.word"
                ext = ".docx"
            Case "video/x-ms-asf"
                ext = ".asf"
            Case "application/msword"
                ext = ".doc"
            Case "video/avi"
                ext = ".avi"
            Case "application/zip"
                ext = ".zip"
            Case "application/vnd.ms-excel"
                ext = ".xls"
            Case "image/gif"
                ext = ".gif"
            Case "image/jpeg"
                ext = ".jpeg"
            Case "audio/wav"
                ext = ".wav"
            Case "audio/mpeg3"
                ext = ".mp3"
            Case "video/mpeg"
                ext = ".mpeg"
            Case "application/rtf"
                ext = ".rtf"
            Case "application/pdf"
                ext = ".pdf"
            Case Else
                'Handle All Other Files
                ext = "application/octet-stream"
        End Select

        fileName = fileName.Replace(" ", "_")

        Response.Clear()
        Response.Buffer = True
        Response.BufferOutput = True
        Response.Charset = ""
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.ContentType = contentType
        Response.AppendHeader("Content-Disposition", "attachment; filename=" & fileName)
        Response.BinaryWrite(bytes)
        Response.Flush()
        Response.End()

    End Sub

End Class