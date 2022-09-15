Imports System.Net
Imports System.Web.Script.Serialization
Imports System.Globalization

Module Module1

    Sub Main()

        Dim db As New DataClassesDataContext

        Console.WriteLine("Deleting expired weather records")
        'delete all weather records that are greater than today.
        db.DeleteWeather()


        Console.WriteLine("Importing weather...")

        'insert new weather records for the next three days for only the locations with events

        'url = String.Format("http://api.openweathermap.org/data/2.5/forecast/daily?zip={0}&units=imperial&cnt=3&APPID={1}", a.zipCode, appId)
        'url = String.Format("http://api.openweathermap.org/data/2.5/forecast/daily?q={0}&units=imperial&cnt=3&APPID={1}", a.city, appId)


        Dim i = From a In db.qryGetUpcomingEventLocations Select a
        For Each a In i

            Dim url As String

            Try
                Dim appId As String = "a77cf9b3936cbf96fecb944778c5718c"
                url = String.Format("http://api.openweathermap.org/data/2.5/forecast/daily?zip={0}&units=imperial&cnt=3&APPID={1}", a.zipCode, appId)
                Using client As New WebClient()
                    Dim json As String = client.DownloadString(url)

                    Dim weatherInfo As WeatherInfo = (New JavaScriptSerializer()).Deserialize(Of WeatherInfo)(json)
                    Dim lblMain0 As String = weatherInfo.list(0).weather(0).main
                    Dim lblMain1 As String = weatherInfo.list(1).weather(0).main
                    Dim lblMain2 As String = weatherInfo.list(2).weather(0).main

                    Dim icon1 As String = weatherInfo.list(0).weather(0).icon
                    icon1 = icon1.Replace("n", "d")

                    Dim icon2 As String = weatherInfo.list(1).weather(0).icon
                    icon2 = icon2.Replace("n", "d")

                    Dim icon3 As String = weatherInfo.list(2).weather(0).icon
                    icon3 = icon3.Replace("n", "d")

                    Dim imgWeatherIcon0 As String = String.Format("http://openweathermap.org/img/w/{0}.png", icon1)
                    Dim imgWeatherIcon1 As String = String.Format("http://openweathermap.org/img/w/{0}.png", icon2)
                    Dim imgWeatherIcon2 As String = String.Format("http://openweathermap.org/img/w/{0}.png", icon3)

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

                    ' Console.WriteLine("OK: " & url)
                    Console.WriteLine("OK: " & a.zipCode)

                End Using
            Catch ex As Exception
                'MsgBox(ex.Message() & ": " & url)

                ' MsgBox(ex.Message() & ": " & a.zipCode)

                'Console.WriteLine(ex.Message() & ": " & url)
            End Try

        Next

        Console.WriteLine("Import Completed")
        ' MsgBox("Import Completed")



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
            Case Else
                Return "Sunday"
        End Select
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

End Module
