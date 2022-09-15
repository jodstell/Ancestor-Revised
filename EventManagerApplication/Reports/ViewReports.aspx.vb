Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class ViewReports
    Inherits System.Web.UI.Page
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
            Response.Redirect("/AccessDenied")
        End If

        BindConsumersSampled()

    End Sub

    Protected Sub BindConsumersSampled()


        Dim Sampled = (From p In db.getRecapResultsbyDateRange(0, 1, "3/1/2016", "3/31/2016", 183, 261) Select p.total).Sum()

        Dim Sold = (From p In db.getRecapResultsbyDateRange(0, 3, "3/1/2016", "3/31/2016", 183, 261) Select p.total).Sum()



        Dim conversionRate As Integer = (Sold / Sampled) * 100
        ConversionRateLabel.Text = String.Format("{0:0.0}%", conversionRate)


        VolumeLabel.Text = (From p In db.getRecapResultsbyDateRange(0, 1, "3/1/2016", "3/31/2016", 183, 261) Select p.total).Count()
        SampledTotalLabel.Text = (From p In db.getRecapResultsbyDateRange(0, 1, "3/1/2016", "3/31/2016", 183, 261) Select p.total).Sum()

        BottlesSoldTotalLabel.Text = (From p In db.getRecapResultsbyDateRange(0, 3, "3/1/2016", "3/31/2016", 183, 261) Select p.total).Sum()

        RevenueLabel.Text = String.Format("{0:c}", Sold * 14.5)





    End Sub

End Class