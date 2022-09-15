Imports System.Data.SqlClient
Imports System.Web
Imports System.Web.Services

Public Class ReceiptImageHandler
    Implements System.Web.IHttpHandler

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        Dim eventExpenseID As String = context.Request.QueryString("eventExpenseID")
        If eventExpenseID > 0 Then
            context.Response.BinaryWrite(RetrieveReceiptImage(eventExpenseID))
            context.Response.[End]()
        End If

    End Sub

    Private Function RetrieveReceiptImage(eventExpenseID As Integer) As [Byte]()
        'fetch the connection string from web.config
        Dim connString As String = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

        'SQL statement to fetch thumbnail photo
        Dim sql As String = "SELECT receipt FROM tblEventExpense WHERE eventExpenseID =" & eventExpenseID

        Dim dtReceiptPhoto As New DataTable()
        'Open SQL Connection
        Using conn As New SqlConnection(connString)
            conn.Open()
            'Initialize command object
            Using cmd As New SqlCommand(sql, conn)
                Dim adapter As New SqlDataAdapter(cmd)
                'Fill the result set
                adapter.Fill(dtReceiptPhoto)
            End Using
        End Using
        Return DirectCast(dtReceiptPhoto.Rows(0)(0), [Byte]())
    End Function

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property


End Class