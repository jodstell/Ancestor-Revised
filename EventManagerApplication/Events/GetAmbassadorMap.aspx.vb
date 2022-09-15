Public Class GetAmbassadorMap1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Lable1.Text = Request.QueryString("Label")
    End Sub

End Class