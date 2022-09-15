Imports Telerik.Web.UI

Partial Public Class PhotoGallery
    Inherits Page
    Private _initialID As System.Nullable(Of Integer)



    Public ReadOnly Property InitialId() As System.Nullable(Of Integer)

        Get

            If _initialID Is Nothing Then

                _initialID = If(Not String.IsNullOrEmpty(Request("PhotoID")), Integer.Parse(Request("PhotoID")), 0)

            End If

            Return _initialID

        End Get

    End Property



    Protected Function SetInitialIndex(ByVal container As RadRotatorItem) As String

        If CInt(DataBinder.Eval(container.DataItem, "PhotoID")) = InitialId Then

            DirectCast(container.NamingContainer, RadRotator).InitialItemIndex = container.Index

        End If

        Return String.Empty

    End Function

End Class