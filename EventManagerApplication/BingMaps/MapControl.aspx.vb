Imports System.Net
Imports System.Web.Script.Serialization

Public Class MapControl
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim eventID As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        eventID = "469862"

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

        bindEvent()


    End Sub

    Sub bindEvent()
        Dim q = (From p In db.tblEvents Where p.eventID = eventID Select p).FirstOrDefault

        'bind account by locationID
        bindAccount(q.locationID)

        Dim l = getEventLocation(q.locationID)
        BindWeatherGrid(l)

        'populate labels
        Me.EventNameLabel.Text = q.eventTitle
        Me.EventDateLabel.Text = String.Format("{0:D}", q.eventDate)
        Me.EventIDLabel.Text = q.eventID

        'event details
        '  Me.EventTypeLabel.Text = q.typeName
        Me.SupplierLabel.Text = ""
        Me.BrandsLabel.Text = ""
        '  Me.MarketLabel.Text = q.marketName

        Me.AttireLabel.Text = q.attire
        Me.POSLabel.Text = q.posRequirements
        Me.SamplingLabel.Text = q.samplingNotes

    End Sub

    Sub bindAccount(ByVal id As String)
        Dim q = (From p In db.tblAccounts Where p.Vpid = id Select p).FirstOrDefault

        'populate labels
        Me.AccountNameLabel.Text = q.accountName
        Me.LatitudeTextBox.Value = q.latitude
        Me.LongtitudeTextBox.Value = q.longitude

        Me.AccountAddressLabel.Text = String.Format("{0} {1}, {2} {3}", q.streetAddress1, q.city, q.state, q.zipCode)


    End Sub

    Function getEventLocation(id As String) As String

        Dim q = (From p In db.tblAccounts Where p.Vpid = id Select p).FirstOrDefault

        Return String.Format("{0},{1}", q.city, q.state)
    End Function
    Sub BindWeatherGrid(location As String)


        Dim appId As String = "a77cf9b3936cbf96fecb944778c5718c"
        Dim url As String = String.Format("http://api.openweathermap.org/data/2.5/forecast/daily?q={0}&units=metric&cnt=3&APPID={1}", location, appId)
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
