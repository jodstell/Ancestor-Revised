Imports System.Data.SqlClient
Imports Telerik.Web.UI

Public Class AddPOSItems
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Page.Title = "Add New Item"

        If Not Page.IsPostBack Then
            txtBrandName.Text = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p.brandName).FirstOrDefault

            'Dim q = (From p In db.qryIsBrandInGroups Where p.brandID = Request.QueryString("BrandID") Select p).Count

            'If q = 0 Then
            '    AddtoGroupPanel.Visible = False
            'Else
            '    AddtoGroupPanel.Visible = True
            'End If


        End If

    End Sub

    Private Sub AddItemWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles AddItemWizard.FinishButtonClick

        Try
            'insert the form

            If costPerUnitTextBoxRadNumericTextBox.Text = "" Or Nothing Then costPerUnitTextBoxRadNumericTextBox.Text = 0

            Dim newItem As New tblInventoryItem With {
                .inGroup = ckbxInGroup.SelectedValue,
                .itemName = ItemNameTextBox.Text,
                .retailPrice = RetailPriceTextBox.Text,
                .packageSize = PackageSizeTextBox.Text,
                .unitsInKit = HowManyUnitsTextBoxRadNumericTextBox.Text,
                .offPremiseKit = OffPremiseKitCheckBox.Checked,
                .onPremiseKit = OnPremiseKitCheckBox.Checked,
                .accountPlacement = AccountPlacementCheckBox.Checked,
                .giveaway = ConsumerGiveawayCheckBox.Checked,
                .accountGift = TradeAccountGiftCheckBox.Checked,
                .returnToInventory = YesCheckBox.Checked,
                .vendorURL = vendorURLTextBox.Text,
                .productID = productIDTextBox.Text,
                .costPerUnit = costPerUnitTextBoxRadNumericTextBox.Text,
                .packageShippingSize = packageShippingSizeTextBox.Text,
                .packageShippingWeight = packageShippingWeightTextBox.Text,
                .brandID = BrandComboBox.SelectedValue
                }

            db.tblInventoryItems.InsertOnSubmit(newItem)
            db.SubmitChanges()

            Dim posItem = (From p In db.tblInventoryItems Where p.itemID = newItem.itemID Select p).FirstOrDefault

            For Each file As UploadedFile In RadAsyncUpload1.UploadedFiles
                Dim bytes(file.ContentLength - 1) As Byte
                file.InputStream.Read(bytes, 0, file.ContentLength)

                posItem.image = MakeThumb(bytes, 500)
                posItem.thumbnail = MakeThumb(bytes, 100)
            Next



            Dim inv As New tblInventory With {.itemID = newItem.itemID, .action = "Recieved", .date = Date.Now(), .quantity = countInvertoryTextBoxRadNumericTextBox.Text, .balance = countInvertoryTextBoxRadNumericTextBox.Text, .location = "Plano, TX"}

            db.tblInventories.InsertOnSubmit(inv)
            db.SubmitChanges()

            ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", True)
        Catch ex As Exception
            msgLabel.Text = Common.ShowAlertNoClose("warning", ex.Message())
        End Try


    End Sub


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

    Private Sub AddItemWizard_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles AddItemWizard.CancelButtonClick
        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CancelEdit();", True)
    End Sub

    Private Sub SupplierComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles SupplierComboBox.SelectedIndexChanged

        BrandComboBox.Text = ""

        BrandComboBox.Items.Clear()

        BrandComboBox.Text = ""

        LoadBrands(e.Value)

    End Sub

    Protected Sub LoadBrands(ByVal supplierID As String)

        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        Dim adapter As New SqlDataAdapter("SELECT * FROM getBrandsbySupplier WHERE supplierID=@supplierID ORDER By brandName", connection)

        adapter.SelectCommand.Parameters.AddWithValue("@supplierID", supplierID)

        Dim dt As New DataTable()
        adapter.Fill(dt)

        BrandComboBox.DataSource = dt
        BrandComboBox.DataBind()

    End Sub

End Class