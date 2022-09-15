Imports Telerik.Web.UI

Public Class EditBrand
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Private Sub EditBrand_Init(sender As Object, e As EventArgs) Handles Me.Init

        If Not Page.IsPostBack Then

            BindForm()
            ' HiddenBrandGroupID.Value = "0"
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ClientNameLabel.Text = (From p In db.tblClients Where p.clientID = Common.GetCurrentClientID() Select p.clientName).FirstOrDefault
        ' ReturnLink.NavigateUrl = "/admin/ClientDetails?Action=0&ClientID=" & Common.GetCurrentClientID() & "&LoadState=Yes" & "#supplierstab/suppliers"


        If Not Page.IsPostBack Then
            bindInformationForm()

            Dim result = From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID")
            For Each p In result

                Try
                    ModifiedByLabel.Text = String.Format("Last modified by {0} on {1}", Common.GetFullName(p.modifiedBy), Common.GetTimeAdjustment(p.modifiedDate))
                    ReturnLink.NavigateUrl = "/admin/events/editsupplier?ClientID=" & Request.QueryString("ClientID") & "&SupplierID=" & Request.QueryString("SupplierID")
                Catch ex As Exception

                End Try
            Next
        End If



    End Sub

    Private Sub BindForm()

        Dim result = From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID")
        For Each p In result
            BrandNameLabel.Text = p.brandName

            Try
                ModifiedByLabel.Text = String.Format("Last modified by {0} on {1}", Common.GetFullName(p.modifiedBy), Common.GetTimeAdjustment(p.modifiedDate))
            Catch ex As Exception

            End Try
        Next

    End Sub

    Sub bindInformationForm()

        Dim q = From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p

        For Each p In q
            BrandNameTextBox.Text = p.brandName
            Try
                StartDateDatePicker.DbSelectedDate = p.brandStartDate
            Catch ex As Exception

            End Try
            Try
                EndDateDatePicker.DbSelectedDate = p.brandEndDate
            Catch ex As Exception

            End Try

            Try
                DataViewEndDateDatePicker.DbSelectedDate = p.brandDataEndDate
            Catch ex As Exception

            End Try


            Try
                'BrandGroupList.SelectedValue = p.brandGroupID
            Catch ex As Exception

            End Try



            Me.ActiveTextBox.SelectedValue = p.active
        Next
    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click

        Try
            'save the form
            Dim r = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault

            r.brandName = BrandNameTextBox.Text
            r.active = ActiveTextBox.Text
            r.brandStartDate = StartDateDatePicker.DbSelectedDate
            r.brandEndDate = EndDateDatePicker.DbSelectedDate
            r.brandDataEndDate = DataViewEndDateDatePicker.DbSelectedDate
            r.modifiedBy = Session("CurrentUserID")
            r.modifiedDate = Date.Now()

            RadNotification1.Show()

            Try
                ' r.brandGroupID = BrandGroupList.SelectedValue
            Catch ex As Exception

            End Try


            db.SubmitChanges()

            'show the confirmation
            'msgLabel.Text = Common.ShowAlert("success", "Your changes have been saved successfully!")

            BindForm()

            ClientScript.RegisterStartupScript(Page.ClientScript.GetType(), Page.ClientID, "resetDotNetScrollPosition();", True)

        Catch ex As Exception
            msgLabel.Text = Common.ShowAlert("warning", "There was an error saving your changes!  <br /> " & ex.Message().ToString())
        End Try


    End Sub

    'Protected Sub btnAddBrandGroup_Click(sender As Object, e As EventArgs)

    '    Dim txt As TextBox = DirectCast(BrandGroupList.Footer.FindControl("NewBrandGroupTextBox"), TextBox)

    '    If (Not [String].IsNullOrEmpty(txt.Text)) AndAlso (BrandGroupList.FindItemByText(txt.Text) Is Nothing) Then

    '        Dim newGroup As New tblBrandGroup With {.brandGroupName = txt.Text}
    '        db.tblBrandGroups.InsertOnSubmit(newGroup)
    '        db.SubmitChanges()

    '        'HiddenBrandGroupID.Value =

    '        'BrandGroupList.Items.Insert(0, New RadComboBoxItem(txt.Text))
    '        'BrandGroupList.SelectedIndex = 0
    '        'txt.Text = [String].Empty

    '        BrandGroupList.DataBind()
    '        BrandGroupList.SelectedValue = newGroup.brandGroupID

    '    End If


    'End Sub


End Class