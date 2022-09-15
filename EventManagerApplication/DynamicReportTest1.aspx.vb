Imports Telerik.Web.UI

Public Class DynamicReportTest1
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)
        generateDynamicControls()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


#Region "Dynamic Methods"


    Public Sub generateDynamicControls()

        Dim myActivity = From p In db.Activities Select p
        For Each p In myActivity

            'create a header label
            CreateLabelControl(p.activityID, p.activityName)

            Dim result = From x In db.ActivityResults Where x.activityID = p.activityID Select x
            For Each x In result

                CreateTableControl(x.activityResultID, x.result, x.count, x.percent)


            Next

            'add a spacer here
            CreateSpaceControl()

        Next

    End Sub

    Private Sub CreateLabelControl(id As String, labelText As String)

        Dim div As New HtmlGenericControl("div")

        Dim lbl As New HtmlGenericControl("h4")
        lbl.InnerHtml = labelText
        div.Controls.Add(lbl)

        InsertPlaceHolder.Controls.Add(div)

    End Sub

    Private Sub CreateTableControl(id As String, result As String, count As String, percent As String)

        Dim table As New HtmlGenericControl("table")
        table.Attributes.Add("class", "table table-bordered")

        Dim tr As New HtmlGenericControl("tr")
        table.Controls.Add(tr)

        Dim col1 As New HtmlGenericControl("td")
        Dim col1Label As New HtmlGenericControl("label")
        col1.Attributes.Add("style", "width:30%")
        col1Label.InnerHtml = result
        col1.Controls.Add(col1Label)

        tr.Controls.Add(col1)

        Dim col2 As New HtmlGenericControl("td")
        col2.Attributes.Add("style", "width:50%")

        'add progress bar
        Dim progress As New RadProgressBar
        progress.ID = id
        progress.BarType = ProgressBarType.Percent
        progress.Value = percent
        progress.MinValue = 0
        progress.MaxValue = 100

        col2.Controls.Add(progress)
        tr.Controls.Add(col2)

        Dim col3 As New HtmlGenericControl("td")
        Dim col3Label As New HtmlGenericControl("label")
        col3.Attributes.Add("style", "width:20%")
        col3Label.InnerHtml = String.Format("{0} out of 20", count)
        col3.Controls.Add(col3Label)
        tr.Controls.Add(col3)

        'Dim col4 As New HtmlGenericControl("td")
        'Dim col4Label As New HtmlGenericControl("label")
        'col4.Attributes.Add("style", "width:10%")
        'col4Label.InnerHtml = String.Format("{0}%", percent)
        'col4.Controls.Add(col4Label)
        'tr.Controls.Add(col4)


        InsertPlaceHolder.Controls.Add(table)
    End Sub

    Private Sub CreateSpaceControl()
        Dim div As New HtmlGenericControl("div")
        div.Attributes.Add("style", "margin-top:35px;")
        InsertPlaceHolder.Controls.Add(div)
    End Sub

#End Region

End Class