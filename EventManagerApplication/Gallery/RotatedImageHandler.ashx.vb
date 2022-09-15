Imports System.Data.SqlClient
Imports System.Web
Imports System.Web.Services

Public Class RotatedImageHandler
    Implements System.Web.IHttpHandler

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        Dim photoID As String = context.Request.QueryString("PhotoID")
        If photoID > 0 Then
            context.Response.BinaryWrite(RetrieveProductImage(photoID))
            context.Response.[End]()
        End If

    End Sub

    Private Function RetrieveProductImage(PhotoID As String) As [Byte]()
        'fetch the connection string from web.config
        Dim connString As String = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

        'SQL statement to fetch thumbnail photo
        Dim sql As String = "SELECT SmallImage FROM tblPhoto WHERE photoID =" & PhotoID

        Dim dtGalleryPhoto As New DataTable()
        'Open SQL Connection
        Using conn As New SqlConnection(connString)
            conn.Open()
            'Initialize command object
            Using cmd As New SqlCommand(sql, conn)
                Dim adapter As New SqlDataAdapter(cmd)
                'Fill the result set
                adapter.Fill(dtGalleryPhoto)
            End Using
        End Using
        Return DirectCast(dtGalleryPhoto.Rows(0)(0), [Byte]())
    End Function

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property


End Class