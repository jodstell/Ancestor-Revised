Public Class BrandStaffingPositionControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function getPositionName(ByVal positionID As Integer) As String
        Return (From p In db.tblStaffingPositions Where p.staffingPositionID = positionID Select p.positionTitle).FirstOrDefault
    End Function

    Function formatTimeOffset(ByVal t As String) As String

        Select Case t
            Case "0"
                Return "0 minutes"
            Case "-120"
                Return "120 minutes prior"
            Case "-90"
                Return "90 minutes prior"
            Case "-60"
                Return "60 minutes prior"
            Case "-45"
                Return "45 minutes prior"
            Case "-30"
                Return "30 minutes prior"
            Case "-15"
                Return "15 minutes prior"
            Case "15"
                Return "15 minutes after"
            Case "30"
                Return "30 minutes after"
            Case "45"
                Return "45 minutes after"
            Case "60"
                Return "60 minutes after"
            Case "90"
                Return "90 minutes after"
            Case "120"
                Return "120 minutes after"
            Case Else
                Return ""
        End Select

    End Function

    Private Sub getStaffingPositions_Inserting(sender As Object, e As LinqDataSourceInsertEventArgs) Handles getStaffingPositions.Inserting

        Dim position As tblBrandStaffingPosition
        position = CType(e.NewObject, tblBrandStaffingPosition)
        position.brandID = Request.QueryString("BrandID")

    End Sub

    Private Sub getStaffingPositions_Inserted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getStaffingPositions.Inserted
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub

    Private Sub getStaffingPositions_Updated(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getStaffingPositions.Updated
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub

    Private Sub getStaffingPositions_Deleted(sender As Object, e As LinqDataSourceStatusEventArgs) Handles getStaffingPositions.Deleted
        Dim result = (From p In db.tblBrands Where p.brandID = Request.QueryString("BrandID") Select p).FirstOrDefault
        result.modifiedBy = Session("CurrentUserID")
        result.modifiedDate = Date.Now()

        db.SubmitChanges()
    End Sub
End Class