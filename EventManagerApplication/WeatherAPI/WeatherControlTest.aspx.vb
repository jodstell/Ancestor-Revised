Imports System.Net
Imports System.Web.Script.Serialization

Public Class WeatherControlTest
    Inherits System.Web.UI.Page
    Dim location As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        location = "Plovdiv, Bulgaria"

        Dim today As Date = Date.Now()
        Dim tomorrow As Date = Date.Now.AddDays(1)
        Dim day2 As Date = Date.Now.AddDays(2)

        lblDay0.Text = today.Day
        lblMonth0.Text = today.ToString("MMM")

        lblDay1.Text = tomorrow.Day
        lblMonth1.Text = tomorrow.ToString("MMM")

        lblDay2.Text = day2.Day
        lblMonth2.Text = day2.ToString("MMM")
        lblDayName2.Text = day2.ToString("dddd")

        BindWeatherGrid()
    End Sub

    Sub BindWeatherGrid()


        Dim appId As String = "a77cf9b3936cbf96fecb944778c5718c"
        Dim url As String = String.Format("http://api.openweathermap.org/data/2.5/forecast/daily?q={0}&units=metric&cnt=3&APPID={1}", txtCity.Text.Trim(), appId)
        Using client As New WebClient()
            Dim json As String = client.DownloadString(url)

            Dim weatherInfo As WeatherInfo = (New JavaScriptSerializer()).Deserialize(Of WeatherInfo)(json)
            lblMain0.Text = weatherInfo.list(0).weather(0).main
            lblMain1.Text = weatherInfo.list(1).weather(0).main
            lblMain2.Text = weatherInfo.list(2).weather(0).main

            imgWeatherIcon0.ImageUrl = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(0).weather(0).icon)
            imgWeatherIcon1.ImageUrl = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(1).weather(0).icon)
            imgWeatherIcon2.ImageUrl = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(2).weather(0).icon)

            lblTempMin0.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(0).temp.min, 1))
            lblTempMin1.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(1).temp.min, 1))
            lblTempMin2.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(2).temp.min, 1))

            lblTempMax0.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(0).temp.max, 1))
            lblTempMax1.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(1).temp.max, 1))
            lblTempMax2.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(2).temp.max, 1))

        End Using
    End Sub


    'Private Sub btnGetWeather_Click(sender As Object, e As EventArgs) Handles btnGetWeather.Click

    '    Dim appId As String = "a77cf9b3936cbf96fecb944778c5718c"
    '    Dim url As String = String.Format("http://api.openweathermap.org/data/2.5/forecast/daily?q={0}&units=metric&cnt=2&APPID={1}", txtCity.Text.Trim(), appId)
    '    Using client As New WebClient()
    '        Dim json As String = client.DownloadString(url)

    '        Dim weatherInfo As WeatherInfo = (New JavaScriptSerializer()).Deserialize(Of WeatherInfo)(json)
    '        lblCity_Country.Text = weatherInfo.city.name + "," + weatherInfo.city.country
    '        imgCountryFlag.ImageUrl = String.Format("http://openweathermap.org/images/flags/{0}.png", weatherInfo.city.country.ToLower())
    '        lblDescription.Text = weatherInfo.list(1).weather(0).description
    '        lblMain.Text = weatherInfo.list(1).weather(0).main
    '        imgWeatherIcon.ImageUrl = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(1).weather(0).icon)
    '        lblTempMin.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(1).temp.min, 1))
    '        lblTempMax.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(1).temp.max, 1))
    '        lblTempDay.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(1).temp.day, 1))
    '        lblTempNight.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(1).temp.night, 1))
    '        lblHumidity.Text = weatherInfo.list(1).humidity.ToString()
    '        tblWeather.Visible = True
    '    End Using

    'End Sub

    'Private Sub btnGetWeather_Click(sender As Object, e As EventArgs) Handles btnGetWeather.Click

    '    Dim appId As String = "a77cf9b3936cbf96fecb944778c5718c"
    '    Dim url As String = String.Format("http://api.openweathermap.org/data/2.5/forecast/daily?q={0}&units=metric&cnt=1&APPID={1}", txtCity.Text.Trim(), appId)
    '    Using client As New WebClient()
    '        Dim json As String = client.DownloadString(url)

    '        Dim weatherInfo As WeatherInfo = (New JavaScriptSerializer()).Deserialize(Of WeatherInfo)(json)
    '        lblCity_Country.Text = weatherInfo.city.name + "," + weatherInfo.city.country
    '        imgCountryFlag.ImageUrl = String.Format("http://openweathermap.org/images/flags/{0}.png", weatherInfo.city.country.ToLower())
    '        lblDescription.Text = weatherInfo.list(0).weather(0).description
    '        lblMain.Text = weatherInfo.list(0).weather(0).main
    '        imgWeatherIcon.ImageUrl = String.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list(0).weather(0).icon)
    '        lblTempMin.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(0).temp.min, 1))
    '        lblTempMax.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(0).temp.max, 1))
    '        lblTempDay.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(0).temp.day, 1))
    '        lblTempNight.Text = String.Format("{0}°С", Math.Round(weatherInfo.list(0).temp.night, 1))
    '        lblHumidity.Text = weatherInfo.list(0).humidity.ToString()
    '        tblWeather.Visible = True
    '    End Using

    'End Sub

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
End Class