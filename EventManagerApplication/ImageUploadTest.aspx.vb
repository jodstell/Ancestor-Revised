Imports System.Drawing
Imports System.Web.Services
Imports Telerik.Web.UI

Public Class ImageUploadTest
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub RadAjaxManager1_AjaxRequest(sender As Object, e As AjaxRequestEventArgs) Handles RadAjaxManager1.AjaxRequest
        Thumbnail.ImageUrl = "~/images/" + e.Argument.ToString()
    End Sub


    'Protected Sub FileUploaded() Handles upldPhoto.FileUploaded

    '    Dim bitmapImage As Bitmap = ResizeImage(upldPhoto.UploadedFiles(0).InputStream)
    '    Dim stream As System.IO.MemoryStream = New System.IO.MemoryStream()
    '    bitmapImage.Save(stream, System.Drawing.Imaging.ImageFormat.Bmp)
    '    imgBinaryPhoto.DataValue = stream.ToArray()

    'End Sub


    '<WebMethod()>
    'Public Shared Function flieUploaded(userID As String) As Boolean

    '    Dim db As New DataClassesDataContext

    '    Dim x = (From p In db.tblAmbassadorPhotos Where p.userID = userID Select p).FirstOrDefault
    '    'headshot image
    '    For Each file As UploadedFile In RadAsyncUpload1.UploadedFiles
    '        Dim bytes(file.ContentLength - 1) As Byte
    '        file.InputStream.Read(bytes, 0, file.ContentLength)

    '        x.headshot = MakeThumb(bytes, 500)
    '        x.headshot_thumbnail = MakeThumb(bytes, 100)
    '        a.headShotUploaded = True
    '    Next

    'End Function

    Public Function ResizeImage(ByVal stream As IO.Stream) As Bitmap
        Dim originalImage As System.Drawing.Image = Bitmap.FromStream(stream)

        Dim height As Integer = 331
        Dim width As Integer = 495

        Dim scaledImage As New Bitmap(width, height)

        Using g As Graphics = Graphics.FromImage(scaledImage)
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic
            g.DrawImage(originalImage, 0, 0, width, height)
            g.DrawString("My photo from the upload", New Font("Tahoma", 18), Brushes.White, New PointF(0, 0))
            Return scaledImage
        End Using

    End Function

End Class