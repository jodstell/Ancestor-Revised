Imports System.Globalization
Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security
Imports System.Reflection
Imports System.IO
Imports Telerik.Web.UI

Public Class BrandDocumentControl
    Inherits System.Web.UI.UserControl
    Dim db As New LMSDataClassesDataContext
    Dim db1 As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



        If Not Page.IsPostBack Then
            'BindLibrary()

            'Dim this = (From p In db1.tblBrands Where p.brandID = Session("SelectedBrandID") Select p).FirstOrDefault

        End If

    End Sub

    Sub BindLibrary()

        Dim this = (From p In db1.tblBrands Where p.brandID = Session("SelectedBrandID") Select p).FirstOrDefault

        If TestIfNull(this.courseGroupID) = "is null or empty" Then

            CourseIDTextBox.Text = Common.ShowAlertNoClose("warning", "There is no LMS Course assigned to this brand.  You can not upload documents.  Please assign the Brand to a Course first.")

            btnUploadFile.Visible = False

        Else
            CourseIDTextBox.Text = ""
            btnUploadFile.Visible = True

            'Dim q = From p In db.CourseFiles
            '        Join c In db.Files
            '        On c.ID Equals p.FileID
            '        Where p.CourseID = this.courseID And p.RelatedID = this.courseGroupID
            '        Select c.FileName, c.ID, c.Size, c.DateUploaded, c.UploadedBy, c.ContentType, p.FileID

            'DocumentsGrid.DataSource = q
            'DocumentsGrid.DataBind()

        End If



    End Sub

    Function TestIfNull(s As String) As String
        If String.IsNullOrEmpty(s) Then
            Return "is null or empty"
        Else
            Return ""
            'Return String.Format("(""{0}"") is neither null nor empty", s)
        End If
    End Function


    Function getFileType(type As String) As String

        Select Case type
            Case "application/pdf"
                Return ".pdf"
            Case "image/png"
                Return ".png"
            Case Else
                Return ""

        End Select
    End Function

    Private Sub btnUploadFile_Click(sender As Object, e As EventArgs) Handles btnUploadFile.Click
        LibraryPanel.Visible = False
        FileUploadPanel.Visible = True
    End Sub

    Private Sub btnExitUpload_Click(sender As Object, e As EventArgs) Handles btnExitUpload.Click
        LibraryPanel.Visible = True
        FileUploadPanel.Visible = False
    End Sub

    Private Sub btnSubmitFileUpload_Click(sender As Object, e As EventArgs) Handles btnSubmitFileUpload.Click



        Dim FileName As String = txtFileName.Text.ToString()
        Dim uploadID As String = System.Guid.NewGuid().ToString()

        Dim this = (From p In db1.tblBrands Where p.brandID = Session("SelectedBrandID") Select p).FirstOrDefault

        Try

            ' If FileUpload1.PostedFile IsNot Nothing AndAlso FileUpload1.PostedFile.FileName <> "" Then

            Dim file As UploadedFile = RadAsyncUpload.UploadedFiles(0)
            Dim s As String = file.FileName
            Dim path As String = System.IO.Path.GetFileName(s)

            Dim ThisFile As String = RadAsyncUpload.UploadedFiles(0).GetName
            Dim Contenttype As String = RadAsyncUpload.UploadedFiles(0).ContentType
            Dim fileSize As Integer = RadAsyncUpload.UploadedFiles(0).ContentLength
            Dim length As Single = Single.Parse(fileSize.ToString())
            Dim fileData As Byte() = New Byte(file.InputStream.Length - 1) {}
            file.InputStream.Read(fileData, 0, CInt(file.InputStream.Length))

            Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("LMSConnection").ConnectionString)

            Dim cmd As New SqlCommand()
            cmd.CommandText = "INSERT INTO Files(ID,FileName,Data,Size,ContentType,SiteID,DateUploaded,UploadedBy)" & " VALUES (@ID,@FileName,@Data,@Size,@ContentType,@SiteID,@DateUploaded,@UploadedBy)"
            cmd.CommandType = CommandType.Text
            cmd.Connection = conn

            Dim ID As New SqlParameter("@ID", SqlDbType.NVarChar, 50)
            ID.Value = uploadID
            cmd.Parameters.Add(ID)

            Dim File_Name As New SqlParameter("@FileName", SqlDbType.NVarChar, 100)
            File_Name.Value = ThisFile
            cmd.Parameters.Add(File_Name)

            Dim File_Content As New SqlParameter("@Data", SqlDbType.VarBinary)
            File_Content.Value = fileData
            cmd.Parameters.Add(File_Content)

            Dim File_Size As New SqlParameter("@Size", SqlDbType.BigInt, 99999)
            File_Size.Value = fileSize
            cmd.Parameters.Add(File_Size)

            Dim File_Type As New SqlParameter("@ContentType", SqlDbType.VarChar, 50)
            File_Type.Value = Contenttype
            cmd.Parameters.Add(File_Type)

            Dim Site_ID As New SqlParameter("@SiteID", SqlDbType.NVarChar, 50)
            Site_ID.Value = "GigEngyn"
            cmd.Parameters.Add(Site_ID)

            Dim Date_Uploaded As New SqlParameter("@DateUploaded", SqlDbType.SmallDateTime)
            Date_Uploaded.Value = Date.Now()
            cmd.Parameters.Add(Date_Uploaded)

            Dim Uploaded_By As New SqlParameter("@UploadedBy", SqlDbType.NVarChar, 50)
            Uploaded_By.Value = System.Web.HttpContext.Current.User.Identity.GetUserId()
            cmd.Parameters.Add(Uploaded_By)


            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            'add to course



            Dim newfile As New CourseFile
            newfile.FileID = uploadID
            newfile.CourseID = this.courseID
            newfile.RelatedID = this.courseGroupID

            db.CourseFiles.InsertOnSubmit(newfile)

            Dim db2 As New DataClassesDataContext
            Dim result = (From p In db2.tblBrands Where p.brandID = Session("SelectedBrandID") Select p).FirstOrDefault
            result.modifiedBy = Session("CurrentUserID")
            result.modifiedDate = Date.Now()

            db.SubmitChanges()

            LibraryPanel.Visible = True
            FileUploadPanel.Visible = False

            BindLibrary()

            txtFileName.Text = ""

            ' End If
        Catch ex As Exception
            ' Label1.Text = ex.Message.ToString()
        End Try

    End Sub

    Private Sub DocumentsGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles DocumentsGrid.ItemCommand


        Select Case e.CommandName
            Case "DeleteFile"

                Dim this = (From p In db1.tblBrands Where p.brandID = Session("SelectedBrandID") Select p).FirstOrDefault


                Try
                    db.DeleteSelectedCourseFile(e.CommandArgument)


                Catch ex As Exception

                End Try

                BindLibrary()

                '   DocumentsGrid.DataBind()




        End Select
    End Sub
End Class