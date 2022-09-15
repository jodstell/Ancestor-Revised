Imports System.Net
Imports System.Web.Script.Serialization
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports iTextSharp.text.pdf
Imports iTextSharp.text
Imports System.IO
Imports Telerik.Web.UI
Imports System.Drawing
Imports System.Data.SqlClient

Public Class Maintenace
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim lmsdb As New LMSDataClassesDataContext


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        'delete all eventCourse records
        db.DeleteWeather()


        Dim i = From a In db.qryGetUpcomingEventLocations Select a
        For Each a In i


            Try
                Dim appId As String = "a77cf9b3936cbf96fecb944778c5718c"
                Dim url As String = String.Format("http://api.openweathermap.org/data/2.5/forecast/daily?q={0}&units=imperial&cnt=3&APPID={1}", a.location, appId)
                Using client As New WebClient()
                    Dim json As String = client.DownloadString(url)

                    Dim weatherInfo As WeatherInfo = (New JavaScriptSerializer()).Deserialize(Of WeatherInfo)(json)
                    Dim lblMain0 As String = weatherInfo.list(0).weather(0).main
                    Dim lblMain1 As String = weatherInfo.list(1).weather(0).main
                    Dim lblMain2 As String = weatherInfo.list(2).weather(0).main

                    Dim imgWeatherIcon0 As String = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(0).weather(0).icon)
                    Dim imgWeatherIcon1 As String = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(1).weather(0).icon)
                    Dim imgWeatherIcon2 As String = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(2).weather(0).icon)

                    Dim lblTempMin0 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(0).temp.min, 1))
                    Dim lblTempMin1 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(1).temp.min, 1))
                    Dim lblTempMin2 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(2).temp.min, 1))

                    Dim lblTempMax0 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(0).temp.max, 1))
                    Dim lblTempMax1 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(1).temp.max, 1))
                    Dim lblTempMax2 As String = String.Format("{0}°F", Math.Round(weatherInfo.list(2).temp.max, 1))


                    Dim q0 As New tblWeatherInfo
                    q0.cityName = a.city
                    q0.stateName = a.state
                    q0.weatherDate = Date.Now()
                    q0.lowTemp = lblTempMin1
                    q0.highTemp = lblTempMax1
                    q0.icon = imgWeatherIcon1
                    q0.condition = lblMain1
                    q0.location = a.location
                    q0.day = getDayofWeek(Date.Now().DayOfWeek)
                    q0.dayNumber = Date.Now().Day

                    db.tblWeatherInfos.InsertOnSubmit(q0)


                    Dim q1 As New tblWeatherInfo
                    q1.cityName = a.city
                    q1.stateName = a.state
                    q1.weatherDate = Date.Now().AddDays(1)
                    q1.lowTemp = lblTempMin0
                    q1.highTemp = lblTempMax0
                    q1.icon = imgWeatherIcon0
                    q1.condition = lblMain0
                    q1.location = a.location
                    q1.day = getDayofWeek(Date.Now().AddDays(1).DayOfWeek)
                    q1.dayNumber = Date.Now().AddDays(1).Day

                    db.tblWeatherInfos.InsertOnSubmit(q1)

                    Dim q2 As New tblWeatherInfo
                    q2.cityName = a.city
                    q2.stateName = a.state
                    q2.weatherDate = Date.Now().AddDays(2)
                    q2.lowTemp = lblTempMin0
                    q2.highTemp = lblTempMax0
                    q2.icon = imgWeatherIcon0
                    q2.condition = lblMain0
                    q2.location = a.location
                    q2.day = getDayofWeek(Date.Now().AddDays(2).DayOfWeek)
                    q2.dayNumber = Date.Now().AddDays(2).Day

                    db.tblWeatherInfos.InsertOnSubmit(q2)

                    db.SubmitChanges()

                End Using
            Catch ex As Exception
                Label1.Text = ex.Message()
            End Try

        Next

        Label1.Text = "Import Completed"





    End Sub
    Function getDayofWeek(day As Integer) As String

        Select Case day

            Case 1
                Return "Monday"
            Case 2
                Return "Tuesday"
            Case 3
                Return "Wednesday"
            Case 4
                Return "Thursday"
            Case 5
                Return "Friday"
            Case 6
                Return "Saturday"
            Case 7
                Return "Sunday"
        End Select
    End Function
    Function getBrandCourseGroupName(groupID As String) As String
        Return (From p In lmsdb.CurriculumGroups Where p.CurriculumGroupID = groupID Select p.Title).FirstOrDefault
    End Function


#Region "Weather Classes"

    Public Class WeatherInfo
        Public Property city As City
        Public Property list As List(Of List)
    End Class

    Public Class City
        Public Property name As String
        Public Property country As String
    End Class

    Public Class Temp
        Public Property day As Double
        Public Property min As Double
        Public Property max As Double
        Public Property night As Double
    End Class

    Public Class Weather
        Public Property description As String
        Public Property main As String
        Public Property icon As String
    End Class

    Public Class List
        Public Property temp As Temp
        Public Property humidity As Integer
        Public Property weather As List(Of Weather)
    End Class

#End Region

End Class