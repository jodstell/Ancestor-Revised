Imports System.Data.SqlClient

Public Class UpdateInventoryCount
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Me.Page.Title = "Receive Inventory Item"

        If Not Page.IsPostBack Then

            If Request.QueryString("itemID") IsNot Nothing Then

                Dim _itemID = Request.QueryString("itemID")

                LoadPhoto(_itemID)


                ' Dim q = (From p in db.getInventoryListByUserIDAndClientID())

            End If

        End If

    End Sub

    Protected Sub LoadPhoto(ByVal itemID As String)

        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        ' Select a country based on the continentID.

        Dim adapter As New SqlDataAdapter("SELECT * FROM [tblInventoryItem] where itemID = @itemID", connection)

        adapter.SelectCommand.Parameters.AddWithValue("@itemID", itemID)


        Dim dt As New DataTable()

        adapter.Fill(dt)


        PhotoItemRepeater.DataSource = dt

        PhotoItemRepeater.DataBind()

    End Sub

    Private Sub btnSubmitInventory_Click(sender As Object, e As EventArgs) Handles btnSubmitInventory.Click

        Dim itemID = Request.QueryString("itemID")

        Try
            db.UpdateInventoryItemCount(itemID, NewInventoryCountTextBox.Text, NotesTextBox.Text)

            ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", True)


        Catch ex As Exception
            msgLabel.Text = ex.Message()
        End Try





    End Sub

    Private Sub btnCancelInventory_Click(sender As Object, e As EventArgs) Handles btnCancelInventory.Click

        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", True)

    End Sub
End Class