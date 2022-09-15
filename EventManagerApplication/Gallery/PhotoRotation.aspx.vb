Imports System.IO
Imports System.Drawing
Imports System.Drawing.Imaging

Public Class PhotoRotation
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            'Create an Image object.  
            Dim theImage As Image = New Bitmap(Server.MapPath("~/Gallery/Images/sideways.jpg"))

            'Get the PropertyItems property from image. 
            Dim propItems As PropertyItem() = theImage.PropertyItems

            'For each PropertyItem in the array, display the id, type, and length. 
            Dim count As Integer = 0
            Dim propItem As PropertyItem
            For Each propItem In propItems

                'Do Response.Write it will write HTML on your page
                Response.Write("Property Item " + count.ToString() + "<br>")

                Response.Write("   iD: 0x" + propItem.Id.ToString("x") + "<br>")

                Response.Write("   type: " & propItem.Type.ToString() + "<br>")

                Response.Write("   length: " & propItem.Len.ToString() + "<br>")

                count += 1
            Next propItem

        Catch ex As ArgumentException

        End Try




        'Dim filename As String = Path.GetFileName(filePath)


        'Dim fs As FileStream = New FileStream(filePath, FileMode.Open, FileAccess.Read)

        'Dim br As BinaryReader = New BinaryReader(fs)

        'Dim bytes As Byte() = br.ReadBytes(Convert.ToInt32(fs.Length))


        'Dim ms As New MemoryStream(bytes)
        'Dim originalImage As Drawing.Image = System.Drawing.Image.FromStream(ms)





        'Dim tagMake As Integer = &H10F
        '' 271
        'Dim tagModel As Integer = &H110
        '' 272


        'Dim make As Byte() = originalImage.PropertyItems.[Single](Function(x) x.Id = tagMake).Value
        'Dim model As Byte() = originalImage.PropertyItems.[Single](Function(x) x.Id = tagModel).Value

        'Dim encoding = New System.Text.ASCIIEncoding()

        'Label1.Text = encoding.GetString(make)
        ' Returns: Canon
        'Console.WriteLine(encoding.GetString(model))
        ' Returns: Canon PowerShot S40












        'If originalImage.PropertyIdList.Contains(&H112) Then
        '    Dim rotationValue As Integer = originalImage.GetPropertyItem(&H112).Value(0)
        '    Select Case rotationValue
        '        Case 1

        '            Label1.Text = 1

        '            ' landscape, do nothing
        '            Exit Select

        '        Case 2

        '            Label1.Text = 2
        '            'originalImage.RotateFlip(RotateFlipType.RotateNoneFlipX)

        '            'Dim bmp As New Bitmap(originalImage)
        '            'Dim m As New IO.MemoryStream()
        '            'bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

        '            'Image.Image = m.GetBuffer()

        '            Exit Select

        '        Case 3
        '            ' bottoms up

        '            Label1.Text = 3
        '            'originalImage.RotateFlip(RotateFlipType.Rotate180FlipNone)

        '            'Dim bmp As New Bitmap(originalImage)
        '            'Dim m As New IO.MemoryStream()
        '            'bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

        '            'Image.Image = m.GetBuffer()

        '            Exit Select

        '        Case 4
        '            Label1.Text = 4
        '            'originalImage.RotateFlip(RotateFlipType.Rotate180FlipX)

        '            'Dim bmp As New Bitmap(originalImage)
        '            'Dim m As New IO.MemoryStream()
        '            'bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

        '            'Image.Image = m.GetBuffer()

        '            Exit Select

        '        Case 5
        '            Label1.Text = 5
        '            'originalImage.RotateFlip(RotateFlipType.Rotate90FlipX)

        '            'Dim bmp As New Bitmap(originalImage)
        '            'Dim m As New IO.MemoryStream()
        '            'bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

        '            'Image.Image = m.GetBuffer()

        '            Exit Select

        '        Case 6
        '            Label1.Text = 6
        '            ' rotated 90 left
        '            'originalImage.RotateFlip(RotateFlipType.Rotate90FlipNone)

        '            'Dim bmp As New Bitmap(originalImage)
        '            'Dim m As New IO.MemoryStream()
        '            'bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

        '            'Image.Image = m.GetBuffer()

        '            Exit Select

        '        Case 7
        '            Label1.Text = 7
        '            'originalImage.RotateFlip(RotateFlipType.Rotate270FlipX)

        '            'Dim bmp As New Bitmap(originalImage)
        '            'Dim m As New IO.MemoryStream()
        '            'bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

        '            'Image.Image = m.GetBuffer()

        '            Exit Select

        '        Case 8
        '            Label1.Text = 8
        '            ' rotated 90 right
        '            ' de-rotate:
        '            'originalImage.RotateFlip(RotateFlipType.Rotate270FlipNone)

        '            'Dim bmp As New Bitmap(originalImage)
        '            'Dim m As New IO.MemoryStream()
        '            'bmp.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)

        '            'Image.Image = m.GetBuffer()

        '            Exit Select

        '    End Select

        'Else

        '    Label1.Text = "none"
        'End If


        'br.Close()

        'fs.Close()





    End Sub

End Class