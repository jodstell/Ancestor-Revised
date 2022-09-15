Imports System.IO
Imports System.Drawing
Imports System.Threading
Imports System.Windows.Forms

Public Class saveimage
    Inherits System.Web.UI.Page

    Dim accountID As Int32


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        accountID = 230344
    End Sub




    Protected Sub Capture(sender As Object, e As EventArgs)

        Dim NewTh As New Threading.Thread(AddressOf DoIT)
        NewTh.SetApartmentState(Threading.ApartmentState.STA)
        NewTh.Start()
        While NewTh.ThreadState = Threading.ThreadState.Running
        End While

        imgScreenShot.ImageUrl = "/Documents/230344.gif"

    End Sub

    Sub DoIT()
        Try
            Dim thumb As New GetSiteThumbnail.GetImage("http://" & txtUrl.Text, 1024, 768, 320, 240)
            Dim x As System.Drawing.Bitmap = thumb.GetBitmap()
            x.Save(Server.MapPath("~/documents/230344.gif"))

        Catch ex As Exception
            Dim y As System.IO.StreamWriter = System.IO.File.CreateText(Server.MapPath("/documents/error.txt"))
            y.WriteLine(ex.Message & vbCrLf & ex.Source)
            y.Flush()
            y.Close()
        Finally
        End Try
    End Sub








End Class