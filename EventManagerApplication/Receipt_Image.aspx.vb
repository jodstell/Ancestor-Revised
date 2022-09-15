Public Class Recipt_Image
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub Recipt_Image_Error(sender As Object, e As EventArgs) Handles Me.[Error]

        Dim exc As Exception = Server.GetLastError()

        If TypeOf exc Is HttpUnhandledException Then

            Response.Redirect("/ImageError.html")
            msgLabel.Text = "There was an error retrieving the image.  The file is not an image format."
        End If




        Server.ClearError()


        Response.Redirect("/ImageError.html")

    End Sub
End Class