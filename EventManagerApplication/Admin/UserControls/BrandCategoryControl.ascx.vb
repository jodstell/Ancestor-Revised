Imports System.IO
Imports CuteWebUI
Imports Telerik.Web.UI

Public Class BrandCategoryControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindForm()
        End If
    End Sub

    Sub BindForm()
        Dim q = From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p

        For Each p In q
            Try
                ddlCategory.SelectedValue = p.categoryID
            Catch ex As Exception

            End Try

            Try
                ddlCategoryType.SelectedValue = p.typeID
            Catch ex As Exception

            End Try

            Try
                ddlCategorySubType.SelectedValue = p.varietyID
            Catch ex As Exception

            End Try

            Try
                ddlCountry.SelectedValue = p.countryOrigin
            Catch ex As Exception

            End Try

            Try
                ddlPackageSize.SelectedValue = p.packageSize
            Catch ex As Exception

            End Try

            UpcTextBox.Text = p.upc
            txtABV.Text = p?.abv

            Try
                RadNumerictxtAveragePrice.Text = p?.avaeragePrice
            Catch ex As Exception
                RadNumerictxtAveragePrice.Text = 0
            End Try




        Next
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Try
            Dim q = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault

            If ddlCategory.SelectedValue = "" Then
                'do nothing
            Else
                q.categoryID = ddlCategory.SelectedValue
            End If

            If ddlCategoryType.SelectedValue = "" Then
                'do nothing
            Else
                q.typeID = ddlCategoryType.SelectedValue
            End If

            If ddlCategorySubType.SelectedValue = "" Then
                'do nothing
            Else
                q.varietyID = ddlCategorySubType.SelectedValue
            End If

            If ddlCountry.SelectedValue = "" Then
                'do nothing
            Else
                q.countryOrigin = ddlCountry.SelectedValue
            End If

            If ddlPackageSize.SelectedValue = "" Then
                'do nothing
            Else
                q.packageSize = ddlPackageSize.SelectedValue
            End If

            q.upc = UpcTextBox.Text
            q.abv = txtABV.Text

            If RadNumerictxtAveragePrice.Text = "" Then
                'do nothing
            Else
                q.avaeragePrice = RadNumerictxtAveragePrice.Text
            End If



            'For Each file As UploadedFile In RadAsyncUpload1.UploadedFiles
            '    Dim bytes(file.ContentLength - 1) As Byte
            '    file.InputStream.Read(bytes, 0, file.ContentLength)

            '    q.photo = bytes
            'Next


            'upload the photo
            If lblPath.Text = "" Then

            Else

                Dim filePath As String = Server.MapPath(lblPath.Text)

                Dim filename As String = Path.GetFileName(filePath)


                Dim fs As FileStream = New FileStream(filePath, FileMode.Open, FileAccess.Read)

                Dim br As BinaryReader = New BinaryReader(fs)

                Dim bytes As Byte() = br.ReadBytes(Convert.ToInt32(fs.Length))

                Dim i = (From p In db.tblBrandImages Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
                i.photo = bytes


                br.Close()

                fs.Close()

            End If



            'Dim i = (From p In db.tblBrandImages Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
            'For Each file As UploadedFile In RadAsyncUpload1.UploadedFiles
            '    Dim bytes(file.ContentLength - 1) As Byte
            '    file.InputStream.Read(bytes, 0, file.ContentLength)

            '    i.photo = bytes
            'Next

            Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
            result.modifiedBy = Session("CurrentUserID")
            result.modifiedDate = Date.Now()

            db.SubmitChanges()

            PhotoPanel.Visible = False
            PhotoList.Visible = True
            lblInfoPhoto.Visible = False

            PhotoList.DataBind()

            'msgLabel2.Text = Common.ShowAlert("success", "The changes have been saved successfully!")

            RadNotification1.Show()

        Catch ex As Exception
            msgLabel2.Text = Common.ShowAlert("danger", ex.Message())
        End Try


        Try
            Dim filePath2 As String = Server.MapPath(lblPath.Text)
            System.IO.File.Delete(filePath2)
        Catch ex As Exception
            'do nothing
        End Try


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


    Private Sub ddlCategory_SelectedIndexChanged(sender As Object, e As DropDownListEventArgs) Handles ddlCategory.SelectedIndexChanged
        ddlCategoryType.SelectedIndex = -1
        ddlCategorySubType.SelectedIndex = -1
    End Sub

    Private Sub ddlCategoryType_SelectedIndexChanged(sender As Object, e As DropDownListEventArgs) Handles ddlCategoryType.SelectedIndexChanged
        ddlCategorySubType.SelectedIndex = -1
    End Sub

End Class