Imports System.Drawing
Imports System.Data.SqlClient
Imports System.IO

Public Class ImageEditor
    Inherits System.Web.UI.Page

    Dim con As New SqlConnection()
    Dim _path As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        ' Dim MyConverter As ImageConverter = New System.Drawing.ImageConverter()
        ' Dim MyImage As Image = ImageConverter.ConvertFrom(byteArray)




        ' get the full path of image url

        Dim path As String = Server.MapPath(Image1.ImageUrl)
        Dim NewPath As String = Server.MapPath("~/Gallery/Clock2.jpg")

        ' creating image from the image url
        Dim i As System.Drawing.Image = System.Drawing.Image.FromFile(path)

        ' rotate Image 90' Degree
        i.RotateFlip(RotateFlipType.Rotate90FlipXY)

        ' save it to its actual path
        i.Save(NewPath)

        ' release Image File
        i.Dispose()


        ' Set Image Control Attribute property to new image(but its old path)
        Image1.Attributes.Add("ImageUrl", NewPath)

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






    '   Private Sub button1_Click(sender As Object, e As EventArgs)
    'If openFileDialog1.ShowDialog() = DialogResult.OK Then
    '    _path = openFileDialog1.FileName
    '    InsertInSQL(_path)
    'End If
    '  End Sub

    '    Private Sub InsertInSQL(_path As String)
    '        con.ConnectionString = Pic.Properties.Settings.[Default].ConnectionS
    '        Dim strQ As String = "insert into dbo.PicTBL(Pic)values(@p)"
    '        Dim command As New SqlCommand(strQ, con)
    '        command.Parameters.AddWithValue("@p", ImageToBinary(_path))
    '        con.Open()
    '        command.ExecuteNonQuery()
    '        con.Close()
    '    End Sub

    '    Public Shared Function ImageToBinary(_path As String) As Byte()
    '        Dim fS As New FileStream(_path, FileMode.Open, FileAccess.Read)
    '        Dim b As Byte() = New Byte(fS.Length - 1) {}
    '        fS.Read(b, 0, CInt(fS.Length))
    '        fS.Close()
    '        Return b
    '    End Function

    '    'Convert Binary to imge and save in a folder
    '    'Private Sub button1_Click_1(sender As Object, e As EventArgs)
    '    '    Dim dt As DataTable = Rimage()
    '    '    For Each row As DataRow In dt.Rows
    '    '        Dim b As Byte() = DirectCast(row("Pic"), Byte())
    '    '        Dim img As Image = BinaryToImage(b)
    '    '        img.Save("D:\NewFolder\" + row("ID").ToString() + ".jpg")
    '    '    Next
    '    'End Sub

    '    Private Function BinaryToImage(b As Byte()) As Image
    '        If b Is Nothing Then
    '            Return Nothing
    '        End If

    '        Dim memStream As New MemoryStream()
    '        memStream.Write(b, 0, b.Length)

    '        Return Image.FromStream(memStream)
    '    End Function

    '    Private Function Rimage() As DataTable
    '        con.ConnectionString = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
    '        Dim cmd As New SqlCommand()
    '        cmd.CommandText = "SELECT Image FROM tblPhoto WHERE photoID = @photoID"
    '        cmd.Connection = con
    '        cmd.Parameters.Add(New SqlParameter("@PhotoID", photoId))
    '        Dim adp As New SqlDataAdapter(cmd)
    '        Dim dt As New DataTable()
    '        con.Open()
    '        adp.Fill(dt)

    '        Return dt


    '        Byte2Image(PictureBox1.Image, ImageByteArr)


    '    End Function
End Class