Imports Telerik.Web.UI

Public Class Profile_Image
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            Dim imageType As Integer = Request.QueryString("image")

            Select Case imageType

                Case 1

                    HeadshotRepeater.Visible = True

                ''fix the saved filename for the headshot
                'Dim HeadshotImage As RadBinaryImage = CType(HeadshotRepeater.FindControl("HeadshotImage"), RadBinaryImage)

                'Dim _firstName As String = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p.FirstName).FirstOrDefault
                'Dim _lastName As String = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p.LastName).FirstOrDefault

                'HeadshotImage.SavedImageName = String.Format("{0}{1}.jpg", _firstName, _lastName)

                Case 2

                    BodyshotRepeater.Visible = True

                    ''fix the saved filename for the bodyshot
                    'Dim BodyshotImage As RadBinaryImage = CType(BodyshotRepeater.FindControl("BodyshotImage"), RadBinaryImage)

                    'Dim _firstName2 As String = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p.FirstName).FirstOrDefault
                    'Dim _lastName2 As String = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p.LastName).FirstOrDefault

                    'BodyshotImage.SavedImageName = String.Format("{0}{1}b.jpg", _firstName2, _lastName2)

            End Select
        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try


    End Sub

    Function getHeadShotFileName(ByVal userid As String) As String

        Dim _firstName As String = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p.FirstName).FirstOrDefault
        Dim _lastName As String = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p.LastName).FirstOrDefault

        Return String.Format("{0}{1}", _firstName, _lastName)
    End Function

    Function getBodyShotFileName(ByVal userid As String) As String

        Dim _firstName As String = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p.FirstName).FirstOrDefault
        Dim _lastName As String = (From p In db.tblAmbassadors Where p.userID = Request.QueryString("UserID") Select p.LastName).FirstOrDefault

        Return String.Format("{0}{1}b", _firstName, _lastName)
    End Function

End Class