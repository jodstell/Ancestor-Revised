Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports xi = Telerik.Web.UI.ExportInfrastructure
Imports System.Web.UI
Imports System.Web
Imports Telerik.Web.UI.GridExcelBuilder
Imports System.Drawing
Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class EventPhotoGalleryControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Then
            btnAddPhotos.Visible = False
        End If

    End Sub

    Protected Sub RadSlider1_ValueChanged(ByVal sender As Object, ByVal e As EventArgs)


        Dim selectedValue = DirectCast(sender, RadSlider).Value

        If selectedValue = 1D Then
            ImageHeight = Unit.Pixel(150)
            ImageWidth = Unit.Pixel(150)
            PhotoListView.PageSize = 20

        ElseIf selectedValue = 2D Then
            ImageHeight = Unit.Pixel(200)
            ImageWidth = Unit.Pixel(200)
            PhotoListView.PageSize = 10

        ElseIf selectedValue = 3D Then
            ImageHeight = Unit.Pixel(350)
            ImageWidth = Unit.Pixel(350)
            PhotoListView.PageSize = 6

        End If

        PhotoListView.CurrentPageIndex = 0
        PhotoListView.Rebind()

    End Sub

    Protected Property ImageWidth() As Unit

        Get
            Dim state As Object = If(ViewState("ImageWidth"), Unit.Pixel(200))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageWidth") = value
        End Set

    End Property



    Protected Property ImageHeight() As Unit

        Get
            Dim state As Object = If(ViewState("ImageHeight"), Unit.Pixel(200))
            Return DirectCast(state, Unit)
        End Get

        Private Set(ByVal value As Unit)
            ViewState("ImageHeight") = value
        End Set

    End Property

    Protected Function CreateWindowScript(ByVal eventID As Integer, ByVal photoID As Integer) As String
        Return String.Format("var win = window.radopen('/PhotoGallery.aspx?ID={0}&PhotoID={1}','Details');win.center();", eventID, photoID)
    End Function


    Protected Sub TextBox1_TextChanged(ByVal sender As Object, ByVal e As EventArgs)

        Dim textBox = DirectCast(sender, TextBox)
        Dim keyValue = CInt(DirectCast(textBox.NamingContainer, RadListViewDataItem).GetDataKeyValue("photoID"))

        ' DataProvider.Update(keyValue, textBox.Text.Trim())

    End Sub

    Private Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click


        For Each file As UploadedFile In RadAsyncUpload1.UploadedFiles

            Dim bytes(file.ContentLength - 1) As Byte
            file.InputStream.Read(bytes, 0, file.ContentLength)


            Dim image As New tblPhoto
            image.Image = bytes '0
            image.LargeImage = MakeThumb(bytes, 500) '1
            image.SmallImage = MakeThumb(bytes, 350) '2
            image.ThumbImage = MakeThumb(bytes, 100) '3

            image.eventID = Request.QueryString("ID")

            image.photoTitle = "Sample Image"

            db.tblPhotos.InsertOnSubmit(image)
            db.SubmitChanges()

        Next

        Try
            Dim insertlog = db.InsertEventLog(Request.QueryString("ID"), "Photo(s) uploaded", "Photos have been uploaded to the events gallery", Context.User.Identity.GetUserId(), Date.Now())
        Catch ex As Exception
            msgLabel.Text = ex.Message.ToString()
        End Try


        PhotoListView.DataBind()

        GalleryPanel.Visible = True
        UploadPanel.Visible = False
    End Sub



    'Public Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
    '    RadSkinManager.GetCurrent(Page).Skin = "Bootstrap"
    'End Sub

    Const sizeThumb As Integer = 100

    Public Shared Function MakeThumb(ByVal fullsize As Byte()) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim targetH, targetW As Integer

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image
        If (iOriginal.Height > iOriginal.Width) Then
            targetH = sizeThumb
            targetW = CInt(iOriginal.Width * (sizeThumb / iOriginal.Height))
        Else
            targetW = sizeThumb
            targetH = CInt(iOriginal.Height * (sizeThumb / iOriginal.Width))
        End If
        iThumb = iOriginal.GetThumbnailImage(targetW, targetH, Nothing, System.IntPtr.Zero)
        Dim m As New IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function


    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal newwidth As Integer, ByVal newheight As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scaleH, scaleW As Double
        Dim srcRect As Drawing.Rectangle


        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image

        scaleH = iOriginal.Height / newheight
        scaleW = iOriginal.Width / newwidth
        If scaleH = scaleW Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = iOriginal.Height
            srcRect.X = 0
            srcRect.Y = 0
        ElseIf (scaleH) > (scaleW) Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = CInt(newheight * scaleW)
            srcRect.X = 0
            srcRect.Y = CInt((iOriginal.Height - srcRect.Height) / 2)
        Else
            srcRect.Width = CInt(newwidth * scaleH)
            srcRect.Height = iOriginal.Height
            srcRect.X = CInt((iOriginal.Width - srcRect.Width) / 2)
            srcRect.Y = 0
        End If

        iThumb = New System.Drawing.Bitmap(newwidth, newheight)
        Dim g As Drawing.Graphics = Drawing.Graphics.FromImage(iThumb)
        g.DrawImage(iOriginal, New Drawing.Rectangle(0, 0, newwidth, newheight), srcRect, Drawing.GraphicsUnit.Pixel)

        Dim m As New IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function

    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal maxwidth As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scale As Double

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))

        If iOriginal.Width > maxwidth Then

            scale = iOriginal.Width / maxwidth
            Dim newheight As Integer = CInt(iOriginal.Height / scale)

            iThumb = New System.Drawing.Bitmap(iOriginal, maxwidth, newheight)
            Dim m As New IO.MemoryStream()
            iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
            Return m.GetBuffer()
        Else
            Return fullsize
        End If

    End Function




    Private Sub btnCancelUpload_Click(sender As Object, e As EventArgs) Handles btnCancelUpload.Click
        GalleryPanel.Visible = True
        UploadPanel.Visible = False
    End Sub

    Private Sub PhotoListView_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PhotoListView.ItemCommand
        If e.CommandName = "DeleteImage" Then

            Dim id As Integer = e.CommandArgument

            Try
                Dim deletephoto = db.DeletePhoto(id)

                PhotoListView.DataBind()
            Catch ex As Exception
                errorLabel.Text = ex.Message
            End Try


        End If
    End Sub

    Private Sub btnAddPhotos_Click(sender As Object, e As EventArgs) Handles btnAddPhotos.Click

        GalleryPanel.Visible = False
        UploadPanel.Visible = True

    End Sub

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