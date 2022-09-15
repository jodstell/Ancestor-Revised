Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.IO
Imports Telerik.Windows.Zip
Imports System.Drawing.Imaging
Imports System.Drawing

Public Class ViewGallery
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim filterOn As Boolean
    Dim folder As String

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Private Sub ViewGallery_Load(sender As Object, e As EventArgs) Handles Me.Load

        PhotoBinCountLabel.Text = getPhotoBinCount()


        '   Dim strDownloadPageURL As String = "ZipFileHandler.ashx"

        '  btnDownBin.Attributes.Add("onclick", "window.open('" + strDownloadPageURL + "', 'Download', 'menubar=0, toolbar=0, location=0, status=0, resizable=0, width=50, height=50');")


        If Not Page.IsPostBack Then

            HiddenSessionGUID.Value = Guid.NewGuid().ToString()

            ' Label3.Text = HiddenSessionGUID.Value

            HyperLink2.NavigateUrl = "DownLoadZipHandler.aspx?sessionID=" & HiddenSessionGUID.Value

            PhotoListView.DataSource = getImageList

        End If


        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        If manager.IsInRole(currentUser.Id, "Student") Then
            Response.Redirect("/AccessDenied")
        End If

        If Not Page.IsPostBack Then
            filterOn = False
        End If



    End Sub


    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        HiddenSessionGUID.Value = Guid.NewGuid().ToString()
        PhotoBinCountLabel.Text = getPhotoBinCount()

    End Sub


    Protected Function CreateWindowScript2(ByVal eventID As Integer) As String
        Return String.Format("window.open('/Events/EventDetails?ID={0}','_blank');return false;", eventID)
    End Function


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

    Function getPhotoBinCount()
        Dim userid = Context.User.Identity.GetUserId()

        Return (From p In db.tblPhotoBins Where p.userID = userid And p.sessionID = HiddenSessionGUID.Value Select p).Count



    End Function

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
        Return String.Format("var win = window.radopen('/PhotoGallery.aspx?ID={0}&PhotoID={1}','Details');win.center();return false;", eventID, photoID)
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
            image.Image = MakeThumb(bytes, 800) '0
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

    'Private Sub btnAddPhotos_Click(sender As Object, e As EventArgs) Handles btnAddPhotos.Click
    '    GalleryPanel.Visible = False
    '    UploadPanel.Visible = True
    'End Sub

    Private Sub btnCancelUpload_Click(sender As Object, e As EventArgs) Handles btnCancelUpload.Click
        GalleryPanel.Visible = True
        UploadPanel.Visible = False
    End Sub

    Private Sub PhotoListView_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles PhotoListView.ItemCommand

        Dim action As String = e.CommandName
        Dim photoid As Integer = e.CommandArgument

        Select Case action
            Case "DeleteImage"

                Try
                    Dim deletephoto = db.DeletePhoto(photoid)

                    PhotoListView.DataBind()
                Catch ex As Exception
                    errorLabel.Text = ex.Message
                End Try

            Case "AddtoBin"
                'create folder


                Dim folder As String = HiddenSessionGUID.Value 'Context.User.Identity.GetUserId()
                Dim path = Server.MapPath(Convert.ToString("~/documents/photobin/") & folder)
                Dim directory = New DirectoryInfo(path)
                If directory.Exists = False Then
                    directory.Create()
                End If


                Try

                    Dim addtobin = db.InsertPhotoBin(photoid, Context.User.Identity.GetUserId(), HiddenSessionGUID.Value)

                    PhotoBinCountLabel.Text = getPhotoBinCount()

                Catch ex As Exception
                    errorLabel.Text = ex.Message
                End Try

                Try
                    Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoid Select p.fileName).FirstOrDefault

                    Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
                        sqlconnection.Open()

                        Dim selectQuery As String = String.Format("SELECT Image FROM tblPhoto WHERE photoID ={0}", photoid)

                        Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)
                        Dim reader As SqlDataReader = selectCommand.ExecuteReader()
                        If reader.Read() Then
                            Dim byteData As Byte() = DirectCast(reader(0), Byte())
                            Dim strData As String = Encoding.UTF8.GetString(byteData)

                            System.IO.File.WriteAllBytes(Server.MapPath(Convert.ToString("~/documents/photobin/" & folder & "/" & _fileName)), byteData)

                        End If
                        sqlconnection.Close()
                    End Using
                Catch ex As Exception
                    errorLabel.Text = ex.Message
                End Try


            Case "DownloadImage"

                Try

                    Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoid Select p.fileName).FirstOrDefault

                    Dim data As Byte() = GetPhoto(photoid)

                    Response.Clear()
                    Response.ContentType = "application/octet-stream"
                    Response.AddHeader("content-disposition", Convert.ToString("attachment; filename=") & _fileName)
                    Response.BinaryWrite(data)


                Catch ex As Exception
                    FilterLabel.Text = ex.Message
                End Try

            Case "View"

                'get either the accountid or eventid


        End Select


    End Sub

    Private Function GetPhoto(photoId As Integer) As Byte()

        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Dim comm As New SqlCommand("SELECT LargeImage FROM tblPhoto WHERE photoID = @photoID", conn)
        comm.Parameters.Add(New SqlParameter("@PhotoID", photoId))

        conn.Open()
        Dim data As Object = comm.ExecuteScalar()
        conn.Close()

        Return DirectCast(data, Byte())
    End Function

    'Public Shared Sub ReadByteArrayFromSqlDatabase(id As Integer)
    '    Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
    '        sqlconnection.Open()

    '        Dim selectQuery As String = String.Format("SELECT LargeImage FROM tblPhoto WHERE photoID ={0}", id)

    '        ' Read Byte [] Value from Sql Table 
    '        Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)
    '        Dim reader As SqlDataReader = selectCommand.ExecuteReader()
    '        If reader.Read() Then
    '            Dim byteData As Byte() = DirectCast(reader(0), Byte())
    '            Dim strData As String = Encoding.UTF8.GetString(byteData)

    '            System.IO.File.WriteAllBytes("c:\\YourFile.png", byteData)

    '        End If
    '        sqlconnection.Close()
    '    End Using
    'End Sub


    Private Sub SendZipToClient(memStream As MemoryStream)

        memStream.Seek(0, SeekOrigin.Begin)

        If memStream IsNot Nothing AndAlso memStream.Length > 0 Then

            Response.Clear()
            Response.AddHeader("content-disposition", "attachment; filename=photos.zip")
            Response.ContentType = "application/zip"
            Response.BinaryWrite(memStream.ToArray())
            Response.[End]()

        End If


    End Sub

    Private Sub btnDeletePhotoBin_Click(sender As Object, e As EventArgs) Handles btnDeletePhotoBin.Click
        Dim delete = db.DeletePhotoBin(Context.User.Identity.GetUserId())

        PhotoBinCountLabel.Text = getPhotoBinCount()

        Dim userid = Context.User.Identity.GetUserId()

        Dim q = (From p In db.tblPhotoBins Where p.userID = userid Select p).Count
        If q = 0 Then
            folder = Context.User.Identity.GetUserId()


            Dim path = Server.MapPath(Convert.ToString("~/documents/photobin/") & folder)
            Dim directory = New DirectoryInfo(path)
            If directory.Exists = True Then
                directory.Delete(True)
            End If
        End If

    End Sub

    'Private Sub btnDownBin_Click(sender As Object, e As EventArgs) Handles btnDownBin.Click

    '    Try

    '        ' add download feature to a zip file 

    '        Dim memStream As New MemoryStream()

    '        Using archive As New ZipArchive(memStream, ZipArchiveMode.Create, True, Nothing)

    '            folder = Context.User.Identity.GetUserId()

    '            For Each photo As Photo In GetData()

    '                Using entry As ZipArchiveEntry = archive.CreateEntry(photo.Name)

    '                    Dim writer As New BinaryWriter(entry.Open())

    '                    writer.Write(photo.Data)

    '                    writer.Flush()

    '                End Using

    '            Next

    '        End Using

    '        'delete all items for the user
    '        Dim delete = db.DeletePhotoBin(Context.User.Identity.GetUserId())

    '        PhotoBinCountLabel.Text = getPhotoBinCount()


    '        SendZipToClient(memStream)



    '    Catch ex As Exception
    '        errorLabel.Text = ex.Message
    '    End Try


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


    Private Sub btnFilter_Click(sender As Object, e As EventArgs) Handles btnFilter.Click
        FilterPanel.Visible = True
        GalleryPanel.Visible = False
        ButtonPanel.Visible = False


    End Sub


    Protected Sub FromDate_SelectedDateChanged(sender As Object, e As Calendar.SelectedDateChangedEventArgs)
        ToDate.SelectedDate = FromDate.SelectedDate
    End Sub

    Protected Sub ApplyFilter_Click(sender As Object, e As EventArgs)




        ' show and hide panels
        FilterPanel.Visible = False
        GalleryPanel.Visible = True
        ButtonPanel.Visible = True

        PhotoListView.PageSize = 5000
        PhotoListView.AllowPaging = False

        Dim dateSelected As Integer = 0

        Try
            'check if date is filtered
            If FromDate.SelectedDate IsNot Nothing Then
                dateSelected = 1
            End If
        Catch ex As Exception
            FilterLabel.Text = ex.Message
        End Try



        ' check if market is filtered
        Dim marketSelected As Integer = 0
        For Each li As ListItem In MarketCheckBoxList.Items
            If li.Selected Then
                marketSelected = marketSelected + 1
            End If
        Next

        ' check if brand is filtered
        Dim brandSelected As Integer = 0

        Dim collection As IList(Of RadListBoxItem) = BrandCheckBoxList.CheckedItems

        For Each item As RadListBoxItem In collection
            brandSelected = brandSelected + 1
        Next


        'For Each li As RadLightBox In BrandCheckBoxList.Items
        '    If li.Selected Then

        '    End If
        'Next

        'date is filtered
        If dateSelected = 1 Then
            Try
                ' If ToDate.SelectedDate = "" Then ToDate.SelectedDate = FromDate.SelectedDate

                PhotoListView.DataSource = getImageListByDateRange
                PhotoListView.DataBind()

                DateRangeLabel.Visible = True
                DateRangeLabel.Text = "From " & FromDate.SelectedDate & " to " & ToDate.SelectedDate

                FilterPanel.Visible = False
                GalleryPanel.Visible = True
                ButtonPanel.Visible = True
            Catch ex As Exception
                FilterLabel.Text = ex.Message
            End Try



        End If

        'both brand and market are filtered
        If brandSelected > 0 And marketSelected > 0 And dateSelected = 0 Then

            ' Create the list to store.
            Dim MarketList As List(Of [String]) = New List(Of String)()
            ' Loop through each item.
            For Each item As ListItem In MarketCheckBoxList.Items

                If item.Selected Then
                    ' If the item is selected, add the value to the list.
                    MarketList.Add(item.Value)
                    ' Item is not selected, do something else.
                Else
                End If
            Next

            ' Join the string together using the ; delimiter.
            Dim MarketStr As [String] = [String].Join(",", MarketList.ToArray())

            HF_SelectedMarkets.Value = MarketStr


            ' Create the list to store.
            Dim BrandList As List(Of [String]) = New List(Of String)()
            ' Loop through each item.

            '  Dim collection As IList(Of RadListBoxItem) = BrandCheckBoxList.CheckedItems

            For Each item As RadListBoxItem In collection
                BrandList.Add(item.Value)
            Next

            'For Each item As ListItem In BrandCheckBoxList.Items

            '    If item.Selected Then
            '        ' If the item is selected, add the value to the list.
            '        BrandList.Add(item.Value)
            '        ' Item is not selected, do something else.
            '    Else
            '    End If
            'Next
            ' Join the string together using the ; delimiter.
            Dim BrandStr As [String] = [String].Join(",", BrandList.ToArray())

            DateRangeLabel.Visible = False

            BrandFilterLabel.Visible = True
            BrandFilterLabel.Text = BrandStr

            MarketFilterLabel.Visible = True
            MarketFilterLabel.Text = MarketStr

            HF_SelectedBrands.Value = BrandStr

            PhotoListView.DataSource = getImageListByBrandAndMarket
            PhotoListView.DataBind()

            FilterPanel.Visible = False
            GalleryPanel.Visible = True
            ButtonPanel.Visible = True

        End If

        'both brand and market and date range are filtered
        If brandSelected > 0 And marketSelected > 0 And dateSelected = 1 Then

            ' Create the list to store.
            Dim MarketList As List(Of [String]) = New List(Of String)()
            ' Loop through each item.
            For Each item As ListItem In MarketCheckBoxList.Items

                If item.Selected Then
                    ' If the item is selected, add the value to the list.
                    MarketList.Add(item.Value)
                    ' Item is not selected, do something else.
                Else
                End If
            Next

            ' Join the string together using the ; delimiter.
            Dim MarketStr As [String] = [String].Join(",", MarketList.ToArray())

            HF_SelectedMarkets.Value = MarketStr


            ' Create the list to store.
            Dim BrandList As List(Of [String]) = New List(Of String)()
            ' Loop through each item.

            For Each item As RadListBoxItem In collection
                BrandList.Add(item.Value)
            Next


            'For Each item As ListItem In BrandCheckBoxList.Items

            '    If item.Selected Then
            '        ' If the item is selected, add the value to the list.
            '        BrandList.Add(item.Value)
            '        ' Item is not selected, do something else.
            '    Else
            '    End If
            'Next
            ' Join the string together using the ; delimiter.
            Dim BrandStr As [String] = [String].Join(",", BrandList.ToArray())


            DateRangeLabel.Visible = True
            DateRangeLabel.Text = "From " & FromDate.SelectedDate & " to " & ToDate.SelectedDate


            DateRangeLabel.Visible = True
            DateRangeLabel.Text = "From " & FromDate.SelectedDate & " to " & ToDate.SelectedDate

            BrandFilterLabel.Visible = True
            BrandFilterLabel.Text = BrandStr

            MarketFilterLabel.Visible = True
            MarketFilterLabel.Text = MarketStr

            HF_SelectedBrands.Value = BrandStr





            PhotoListView.DataSource = getImageListByBrandAndMarketAndDateRange
            PhotoListView.DataBind()

            FilterPanel.Visible = False
            GalleryPanel.Visible = True
            ButtonPanel.Visible = True

        End If



        'only brand is filtered
        If brandSelected > 0 And marketSelected = 0 And dateSelected = 0 Then

            ' Create the list to store.
            Dim BrandList As List(Of [String]) = New List(Of String)()
            ' Loop through each item.
            For Each item As RadListBoxItem In collection
                BrandList.Add(item.Value)
            Next

            'For Each item As ListItem In BrandCheckBoxList.Items

            '    If item.Selected Then
            '        ' If the item is selected, add the value to the list.
            '        BrandList.Add(item.Value)
            '        ' Item is not selected, do something else.
            '    Else
            '    End If
            'Next
            ' Join the string together using the ; delimiter.
            Dim BrandStr As [String] = [String].Join(",", BrandList.ToArray())

            DateRangeLabel.Visible = False
            MarketFilterLabel.Visible = False
            BrandFilterLabel.Visible = True

            BrandFilterLabel.Text = BrandStr

            HF_SelectedBrands.Value = BrandStr

            PhotoListView.DataSource = getImageListByBrand
            PhotoListView.DataBind()

            FilterPanel.Visible = False
            GalleryPanel.Visible = True
            ButtonPanel.Visible = True

        End If

        'only brand and date range is filtered
        If brandSelected > 0 And marketSelected = 0 And dateSelected = 1 Then

            ' Create the list to store.
            Dim BrandList As List(Of [String]) = New List(Of String)()
            ' Loop through each item.
            For Each item As RadListBoxItem In collection
                BrandList.Add(item.Value)
            Next

            'For Each item As ListItem In BrandCheckBoxList.Items

            '    If item.Selected Then
            '        ' If the item is selected, add the value to the list.
            '        BrandList.Add(item.Value)
            '        ' Item is not selected, do something else.
            '    Else
            '    End If
            'Next
            ' Join the string together using the ; delimiter.
            Dim BrandStr As [String] = [String].Join(",", BrandList.ToArray())

            DateRangeLabel.Visible = True
            MarketFilterLabel.Visible = False
            BrandFilterLabel.Visible = True

            DateRangeLabel.Text = "From " & FromDate.SelectedDate & " to " & ToDate.SelectedDate
            BrandFilterLabel.Text = BrandStr

            HF_SelectedBrands.Value = BrandStr

            PhotoListView.DataSource = getImageListByBrandAndDateRange
            PhotoListView.DataBind()

            FilterPanel.Visible = False
            GalleryPanel.Visible = True
            ButtonPanel.Visible = True

        End If


        'only market is filtered
        If brandSelected = 0 And marketSelected > 0 And dateSelected = 0 Then

            ' Create the list to store.
            Dim MarketList As List(Of [String]) = New List(Of String)()
            Dim MarketNameList As List(Of [String]) = New List(Of String)()
            ' Loop through each item.
            For Each item As ListItem In MarketCheckBoxList.Items

                If item.Selected Then
                    ' If the item is selected, add the value to the list.
                    MarketList.Add(item.Value)
                    MarketNameList.Add(item.Text)
                    ' Item is not selected, do something else.
                Else
                End If
            Next
            ' Join the string together using the ; delimiter.
            Dim MarketStr As [String] = [String].Join(",", MarketList.ToArray())
            Dim MarketNameStr As [String] = [String].Join(",", MarketNameList.ToArray())

            DateRangeLabel.Visible = False
            BrandFilterLabel.Visible = False
            MarketFilterLabel.Visible = True

            MarketFilterLabel.Text = "Markets selected: " & MarketNameStr

            ' FilterLabel.Text = "Brand selected count: " & brandSelected & "  Market selected count: " & marketSelected

            HF_SelectedMarkets.Value = MarketStr

            PhotoListView.DataSource = getImageListByMarket
            PhotoListView.DataBind()

            FilterPanel.Visible = False
            GalleryPanel.Visible = True
            ButtonPanel.Visible = True

        End If

        'only market and date range is filtered
        If brandSelected = 0 And marketSelected > 0 And dateSelected = 1 Then

            ' Create the list to store.
            Dim MarketList As List(Of [String]) = New List(Of String)()
            ' Loop through each item.
            For Each item As ListItem In MarketCheckBoxList.Items

                If item.Selected Then
                    ' If the item is selected, add the value to the list.
                    MarketList.Add(item.Value)
                    ' Item is not selected, do something else.
                Else
                End If
            Next
            ' Join the string together using the ; delimiter.
            Dim MarketStr As [String] = [String].Join(",", MarketList.ToArray())

            DateRangeLabel.Visible = True
            BrandFilterLabel.Visible = False
            MarketFilterLabel.Visible = True

            DateRangeLabel.Text = "From " & FromDate.SelectedDate & " to " & ToDate.SelectedDate
            MarketFilterLabel.Text = MarketStr

            HF_SelectedMarkets.Value = MarketStr

            PhotoListView.DataSource = getImageListByMarketAndDateRange
            PhotoListView.DataBind()

            FilterPanel.Visible = False
            GalleryPanel.Visible = True
            ButtonPanel.Visible = True

        End If

        'if nothing is filtered
        If brandSelected = 0 And marketSelected = 0 And dateSelected = 0 Then
            PhotoListView.DataSource = getImageList

            DateRangeLabel.Visible = False
            MarketFilterLabel.Visible = False
            BrandFilterLabel.Visible = False

            PhotoListView.DataBind()

            FilterPanel.Visible = False
            GalleryPanel.Visible = True
            ButtonPanel.Visible = True

        End If








        ' Write to the page the value.
        'Label3.Text = ([String].Concat("Selected Items: ", YrStr))

        'Dim selected As New List(Of ListItem)()
        'For Each item As ListItem In CheckBoxList2.Items
        '    If item.Selected Then
        '        selected.Add(item)
        '    End If
        'Next

        'PhotoListView.CurrentPageIndex = 0

        'PhotoListView.FilterExpressions.Clear()

        ''If Not RadDatePicker1.SelectedDate = "" And Keywords.Text = "" Then
        ''    PhotoListView.FilterExpressions.BuildExpression().GreaterThanOrEqualTo("dateUploaded", RadDatePicker1.SelectedDate).And().Contains("keywords", Keywords.Text).Build()
        ''End If


        'PhotoListView.FilterExpressions.BuildExpression().GreaterThanOrEqualTo("dateUploaded", RadDatePicker1.SelectedDate).And().LessThanOrEqualTo("dateUploaded", RadDatePicker1.SelectedDate).Build()






        'PhotoListView.Rebind()


        'String.Format("document.getElementById('page1').style.display = 'none';")

        System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script", "removePager()", True)

    End Sub

    Protected Sub CancelFilter_Click(sender As Object, e As EventArgs)

        'PhotoListView.DataSource = getImageList

        'PhotoListView.DataBind()

        'FilterPanel.Visible = False
        'GalleryPanel.Visible = True
        'ButtonPanel.Visible = True


        FilterPanel.Visible = False
        GalleryPanel.Visible = True
        ButtonPanel.Visible = True

        PhotoListView.CurrentPageIndex = 0
        PhotoListView.FilterExpressions.Clear()
        PhotoListView.Rebind()

    End Sub

    Protected Sub ClearFilter_Click(sender As Object, e As EventArgs)

    End Sub


End Class