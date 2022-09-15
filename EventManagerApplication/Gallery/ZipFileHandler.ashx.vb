Imports System.Web
Imports System.Web.Services
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.IO
Imports Telerik.Windows.Zip
Imports System.Drawing.Imaging
Imports System.Drawing

Public Class ZipFileHandler
    Implements System.Web.IHttpHandler

    Dim db As New DataClassesDataContext
    Dim folder As String
    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        Try

            ' add download feature to a zip file 

            Dim memStream As New MemoryStream()

            Using archive As New ZipArchive(memStream, ZipArchiveMode.Create, True, Nothing)

                folder = context.User.Identity.GetUserId()

                For Each photo As Photo In GetData()

                    Using entry As ZipArchiveEntry = archive.CreateEntry(photo.Name)

                        Dim writer As New BinaryWriter(entry.Open())

                        writer.Write(photo.Data)

                        writer.Flush()

                    End Using

                Next

            End Using

            'delete all items for the user
            Dim delete = db.DeletePhotoBin(context.User.Identity.GetUserId())

            memStream.Seek(0, SeekOrigin.Begin)

            If memStream IsNot Nothing AndAlso memStream.Length > 0 Then
                context.Response.Clear()
                context.Response.AddHeader("content-disposition", "attachment; filename=photos.zip")
                context.Response.ContentType = "application/zip"
                context.Response.BinaryWrite(memStream.ToArray())
                context.Response.[End]()
            End If


        Catch ex As Exception
            '  errorLabel.Text = ex.Message
        End Try

    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

    'Private Sub SendZipToClient(memStream As MemoryStream)

    '    memStream.Seek(0, SeekOrigin.Begin)

    '    If memStream IsNot Nothing AndAlso memStream.Length > 0 Then
    '        Response.Clear()
    '        Response.AddHeader("content-disposition", "attachment; filename=photos.zip")
    '        Response.ContentType = "application/zip"
    '        Response.BinaryWrite(memStream.ToArray())
    '        Response.[End]()
    '    End If

    'End Sub

    Function GetData() As IList(Of Photo)

        If _photos IsNot Nothing Then
            Return _photos
        End If

        _photos = New List(Of Photo)()

        For Each file As String In Directory.GetFiles(HttpContext.Current.Server.MapPath("~/documents/photobin/") & folder)

            Dim photo = New Photo()

            photo.Name = Path.GetFileName(file)



            Dim image__1 As Image = Image.FromFile(file)

            Using memoryStream = New MemoryStream()

                image__1.Save(memoryStream, ImageFormat.Png)

                photo.Data = memoryStream.ToArray()

            End Using

            _photos.Add(photo)

            'System.IO.File.Delete(file)



        Next

        Return _photos



    End Function



    Function GetPhotoByID(Id As Integer) As Photo

        Return GetData().Where(Function(d) d.Id = Id).First()

    End Function


    <ThreadStatic()> Private Shared _photos As List(Of Photo)

    Public Class Photo

        Private Shared ReadOnly _key As New Object()

        <ThreadStatic()> Private Shared _counter As Integer



        Public Sub New()

            Id = GetId()

        End Sub



        Public Property Name() As String

            Get

                Return m_Name

            End Get

            Set(ByVal value As String)

                m_Name = value

            End Set

        End Property

        Private m_Name As String

        Public Property Data() As Byte()

            Get

                Return m_Data

            End Get

            Set(ByVal value As Byte())

                m_Data = value

            End Set

        End Property

        Private m_Data As Byte()

        Public Property Id() As Integer

            Get

                Return m_Id

            End Get

            Private Set(ByVal value As Integer)

                m_Id = value

            End Set

        End Property

        Private m_Id As Integer

        Protected Shared Function GetId() As Integer

            SyncLock _key

                _counter += 1

            End SyncLock

            Return _counter

        End Function

    End Class

End Class