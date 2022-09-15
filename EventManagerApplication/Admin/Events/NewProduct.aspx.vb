Imports System.IO
Imports CuteWebUI
Imports Telerik.Web.UI

Public Class NewProduct
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub UploadAttachments1_Photo(ByVal sender As Object, ByVal args As UploaderEventArgs)

        Try

            If lblPath.Text = "" Then

                'Get the full path of file that will be saved.
                Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
                lblPath.Text = virpath

                'Map the path to to a physical path.
                Dim savepath As String = Server.MapPath(virpath)

                'Do not overwrite an existing file
                If System.IO.File.Exists(savepath) Then
                    Return
                End If

                'Move the uploaded file to the target location
                args.MoveTo(savepath)


                'Get the data of uploaded file		
                'Dim link As New HyperLink()
                'link.Text = Convert.ToString("Open " + args.FileName + " : ") & virpath
                'link.NavigateUrl = virpath
                'link.Target = "_blank"
                'link.Style(HtmlTextWriterStyle.Display) = "block"

                PhotoList.Visible = False
                PhotoPanel.Visible = True
                lblInfoPhoto.Visible = True
                Image1.ImageUrl = virpath
                Image1.DataBind()

            Else

                Try
                    Dim filePath2 As String = Server.MapPath(lblPath.Text)
                    System.IO.File.Delete(filePath2)
                    lblPath.Text = ""
                Catch ex As Exception
                    'do nothing
                End Try

                'Get the full path of file that will be saved.
                Dim virpath As String = String.Format("~/App_Files/uploader/{0}{1}", args.FileGuid, System.IO.Path.GetExtension(args.FileName))
                lblPath.Text = virpath

                'Map the path to to a physical path.
                Dim savepath As String = Server.MapPath(virpath)

                'Do not overwrite an existing file
                If System.IO.File.Exists(savepath) Then
                    Return
                End If

                'Move the uploaded file to the target location
                args.MoveTo(savepath)


                'Get the data of uploaded file		
                'Dim link As New HyperLink()
                'link.Text = Convert.ToString("Open " + args.FileName + " : ") & virpath
                'link.NavigateUrl = virpath
                'link.Target = "_blank"
                'link.Style(HtmlTextWriterStyle.Display) = "block"

                PhotoList.Visible = False
                PhotoPanel.Visible = True
                lblInfoPhoto.Visible = True
                Image1.ImageUrl = virpath
                Image1.DataBind()


            End If



        Catch ex As Exception
            msgLabel2.Text = Common.ShowAlert("danger", ex.Message())
        End Try


    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

    End Sub
End Class