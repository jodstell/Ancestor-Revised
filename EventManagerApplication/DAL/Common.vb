
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.Drawing
Imports System.Drawing.Drawing2D
Imports System.Web.Script.Serialization
Imports System.Net
Imports System.Globalization

Public Class Common

    Shared Function GetCurrentClientID() As String
        Try
            Dim db As New DataClassesDataContext

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            Dim result = (From p In db.tblProfiles Where p.userID = currentUser.Id Select p).FirstOrDefault

            If result.currentClientID Is Nothing Then
                result.currentClientID = (From i In db.tblStaffClients Where i.userID = currentUser.Id Select i.clientID).FirstOrDefault
                db.SubmitChanges()

                Return String.Format("{0}", (From i In db.tblStaffClients Where i.userID = currentUser.Id Select i.clientID).FirstOrDefault)
            End If

            Return String.Format("{0}", result.currentClientID)
        Catch ex As Exception

            Return "0"
        End Try


    End Function

    Shared Function GetTimeAdjustment(ByVal d As Date) As String

        Try

            Dim db As New LMSDataClassesDataContext
            Dim db1 As New DataClassesDataContext

            Dim manager = New UserManager()
            Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

            Dim MyTimeZone As String

            Dim currentuser_TimeZone = (From p In db1.tblProfiles Where p.userID = currentUser.Id Select p.timeZone).FirstOrDefault

            If currentuser_TimeZone = "" Or Nothing Then
                MyTimeZone = (From p In db.Sites Where p.SiteID = "GigEngyn" Select p.DefaultTimeZone).FirstOrDefault
            Else
                MyTimeZone = currentuser_TimeZone
            End If

            Dim MyCulture As String = (From p In db.Sites Where p.SiteID = "GigEngyn" Select p.CultureInfoCode).FirstOrDefault

            Dim cstZone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(MyTimeZone)

            Dim cstTime As DateTime = TimeZoneInfo.ConvertTimeFromUtc(d, cstZone)

            'add culture
            Dim culture As CultureInfo = CultureInfo.CreateSpecificCulture(MyCulture)

            Dim loginTime As String = String.Format("{0:t}", ShortTimeZoneFormat(MyTimeZone))

            Return String.Format("{0} ({1})", cstTime.ToString(culture.DateTimeFormat), loginTime)
        Catch ex As Exception
            'Return d
        End Try

#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths

    Shared Function ShortTimeZoneFormat(timeZoneStandardName As String) As String
        Dim TimeZoneElements As String() = timeZoneStandardName.Split(" "c)
        Dim shortTimeZone As String = [String].Empty
        For Each element As String In TimeZoneElements
            'copies the first element of each word
            shortTimeZone += element(0)
        Next
        Return shortTimeZone
    End Function

    Shared Function getBrandName(ByVal id As String) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function


    Shared Function getShippingMethodTitle(ByVal id As String) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblShippingMethods Where p.shippingMethodID = id Select p.shippingMethodTitle).FirstOrDefault
    End Function

    Shared Function getShippingVendorName(ByVal id As String) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblShippingVendors Where p.ShippingVendorID = id Select p.ShippingVendorName).FirstOrDefault
    End Function

    Shared Function formatProperCase(val As String) As String
        Return StrConv(val, VbStrConv.ProperCase)
    End Function

    Shared Function getAccountTypeName(id As Integer) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblAccountTypes Where p.accountTypeID = id Select p.accountTypeName).FirstOrDefault
    End Function

    Shared Function getActivityTypeName(id As Integer) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblActivityTypes Where p.activityTypeID = id Select p.activityName).FirstOrDefault
    End Function

    Shared Function getMarketName(id As Integer) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblMarkets Where p.marketID = id Select p.marketName).FirstOrDefault
    End Function

    Shared Function formatBoolean(ByVal value As Boolean) As String

        Select Case value
            Case True
                Return "Yes"
            Case False
                Return "No"
        End Select

        Return "There was an error."

    End Function

    Public Shared Function FormatPhoneNumber(phoneStr As String) As String

        Try
            Dim builder As New StringBuilder()
            builder.Append("(")
            builder.Append(phoneStr.Substring(0, 3))
            builder.Append(") ")
            builder.Append(phoneStr.Substring(3, 3))
            builder.Append("-")
            builder.Append(phoneStr.Substring(6, 4))
            Return builder.ToString()

        Catch ex As Exception
            Return Nothing
        End Try
    End Function

    Shared Function ScaleImage(image As System.Drawing.Image, maxImageHeight As Integer) As System.Drawing.Image

        ' we will resize image based on the height/width ratio by passing expected height as parameter. Based on Expected height and current image height, new ratio will be arrived and using the same we will do the resizing of image width.


        Dim ratio = CDbl(maxImageHeight) / image.Height
        Dim newWidth = CInt(image.Width * ratio)
        Dim newHeight = CInt(image.Height * ratio)
        Dim newImage = New Bitmap(newWidth, newHeight)
        Using g = Graphics.FromImage(newImage)
            g.DrawImage(image, 0, 0, newWidth, newHeight)
        End Using
        Return newImage
    End Function

    Shared Function GetCurrentClientID(id As String) As Integer
        Dim db As New DataClassesDataContext

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(id)

        Return (From p In db.tblProfiles Where p.userID = currentUser.Id Select p.currentClientID).FirstOrDefault

    End Function

    Shared Function GetCurrentClientName() As String
        Dim db As New DataClassesDataContext

        Return (From p In db.tblClients Where p.clientID = GetCurrentClientID() Select p.clientName).FirstOrDefault
    End Function

    Shared Function getIcon(fileType As String) As String

        Select Case fileType
            Case "application/pdf"
                Return "<i class='fa fa-file-pdf-o' aria-hidden='True'></i>"

            Case "image/jpeg"
                Return "<i class='fa fa-file-image-o' aria-hidden='True'></i>"

            Case "image/jpg"
                Return "<i class='fa fa-file-image-o' aria-hidden='True'></i>"

            Case "image/png"
                Return "<i class='fa fa-file-image-o' aria-hidden='True'></i>"

            Case "image/gif"
                Return "<i class='fa fa-file-image-o' aria-hidden='True'></i>"

            Case "application/vnd.openxmlformats-officedocument.word"
                Return "<i class='fa fa-file-word-o' aria-hidden='True'></i>"

            Case "application/msword"
                Return "<i class='fa fa-file-word-o' aria-hidden='True'></i>"

            Case Else
                Return "<i class='fa fa-file-o' aria-hidden='True'></i>"
        End Select

    End Function

    Shared Function getStatusName(ByVal id As String) As String
        Dim db As New DataClassesDataContext

        Return (From p In db.tblStatus Where p.statusID = id Select p.statusName).FirstOrDefault
    End Function

    Shared Function GetFullName(ByVal id As String) As String
        Try
            Dim db As New LMSDataClassesDataContext
            Dim db1 As New DataClassesDataContext

            ' Dim manager = New UserManager()
            ' Dim currentUser = manager.FindById(id)

            'Dim result = (From p In db.AspNetUsersProfiles Where p.UserID = currentUser.Id Select p).FirstOrDefault
            Dim result = (From p In db1.tblProfiles Where p.userID = id Select p).FirstOrDefault

            Return String.Format("{0} {1}", result.firstName, result.lastName)
        Catch ex As Exception

            Return "Unknown"

            MailHelper.SendMailMessage("no-reply@gigengyn.com", "There was an error on events.gigengyn.com", "There was an error finding a profile for UserID: " & id)


        End Try


    End Function

    Public Class UserManager
        Inherits UserManager(Of ApplicationUser)
        Public Sub New()
            MyBase.New(New UserStore(Of ApplicationUser)(New ApplicationDbContext()))
        End Sub
    End Class

    Function getStateName(ByVal abr As String) As String

        Select Case abr

            Case "AL"
                Return "Alabama"
            Case "AK"
                Return "Alaska"
            Case "AZ"
                Return "Arizona"
            Case "AR"
                Return "Arkansas"
            Case "CA"
                Return "California"
            Case "CO"
                Return "Colorado"
            Case "CT"
                Return "Connecticut"
            Case "DC"
                Return "District of Columbia"
            Case "DE"
                Return "Delaware"
            Case "FL"
                Return "Florida"
            Case "GA"
                Return "Georgia"
            Case "HI"
                Return "Hawaii"
            Case "ID"
                Return "Idaho"
            Case "IL"
                Return "Illinois"
            Case "IN"
                Return "Indiana"
            Case "IA"
                Return "Iowa"
            Case "KS"
                Return "Kansas"
            Case "KY"
                Return "Kentucky"
            Case "LA"
                Return "Louisiana"
            Case "ME"
                Return "Maine"
            Case "MD"
                Return "Maryland"
            Case "MA"
                Return "Massachusetts"
            Case "MI"
                Return "Michigan"
            Case "MN"
                Return "Minnesota"
            Case "MS"
                Return "Mississippi"
            Case "MO"
                Return "Missouri"
            Case "MT"
                Return "Montana"
            Case "NE"
                Return "Nebraska"
            Case "NV"
                Return "Nevada"
            Case "NH"
                Return "New Hampshire"
            Case "NJ"
                Return "New Jersey"
            Case "NM"
                Return "New Mexico"
            Case "NY"
                Return "New York"
            Case "NC"
                Return "North Carolina"
            Case "ND"
                Return "North Dakota"
            Case "OH"
                Return "Ohio"
            Case "OK"
                Return "Oklahoma"
            Case "OR"
                Return "Oregon"
            Case "PA"
                Return "Pennsylvania"
            Case "RI"
                Return "Rhode Island"
            Case "SC"
                Return "South Carolina"
            Case "SD"
                Return "South Dakota"
            Case "TN"
                Return "Tennessee"
            Case "TX"
                Return "Texas"
            Case "UT"
                Return "Utah"
            Case "VT"
                Return "Vermont"
            Case "VA"
                Return "Virginia"
            Case "WA"
                Return "Washington"
            Case "WV"
                Return "West Virginia"
            Case "WI"
                Return "Wisconsin"
            Case "WY"
                Return "Wyoming"

            Case Else
                Return ""
        End Select

    End Function

    Shared Function ShowAlert(ByVal type As String, ByVal msg As String) As String
        Return String.Format("<div class='alert alert-{0}'><a class='close' data-dismiss='alert' href='#' aria-hidden='true'>&times;</a>{1}</div>", type, msg)
    End Function

    Shared Function ShowAlertNoClose(ByVal type As String, ByVal msg As String) As String
        Return String.Format("<div class='alert alert-{0}'>{1}</div>", type, msg)
    End Function

    Shared Sub InsertEventActivity(ByVal eventID As Integer, ByVal activity As String, ByVal detail As String)

        Dim db As New DataClassesDataContext

        Dim i As New tblEventLog With {.eventID = eventID,
                                       .activity = activity,
                                       .detail = detail,
                                       .createdBy = "Logged In User",
                                       .createdDate = Date.Now()}

        db.tblEventLogs.InsertOnSubmit(i)
        db.SubmitChanges()

    End Sub

    Shared Sub InsertWeather(city As String, state As String, location As String)

        Try
            Dim db As New DataClassesDataContext

            db.DeleteWeatherByLocation(location)

            Dim appId As String = "a77cf9b3936cbf96fecb944778c5718c"
            Dim url As String = String.Format("http://api.openweathermap.org/data/2.5/forecast/daily?q={0}&units=imperial&cnt=3&APPID={1}", location, appId)
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
                q0.cityName = city
                q0.stateName = state
                q0.weatherDate = Date.Now()
                q0.lowTemp = lblTempMin1
                q0.highTemp = lblTempMax1
                q0.icon = imgWeatherIcon1
                q0.condition = lblMain1
                q0.location = location
                q0.day = getDayofWeek(Date.Now().DayOfWeek)
                q0.dayNumber = Date.Now().Day

                db.tblWeatherInfos.InsertOnSubmit(q0)


                Dim q1 As New tblWeatherInfo
                q1.cityName = city
                q1.stateName = state
                q1.weatherDate = Date.Now().AddDays(1)
                q1.lowTemp = lblTempMin0
                q1.highTemp = lblTempMax0
                q1.icon = imgWeatherIcon0
                q1.condition = lblMain0
                q1.location = location
                q1.day = getDayofWeek(Date.Now().AddDays(1).DayOfWeek)
                q1.dayNumber = Date.Now().AddDays(1).Day

                db.tblWeatherInfos.InsertOnSubmit(q1)

                Dim q2 As New tblWeatherInfo
                q2.cityName = city
                q2.stateName = state
                q2.weatherDate = Date.Now().AddDays(2)
                q2.lowTemp = lblTempMin0
                q2.highTemp = lblTempMax0
                q2.icon = imgWeatherIcon0
                q2.condition = lblMain0
                q2.location = location
                q2.day = getDayofWeek(Date.Now().AddDays(2).DayOfWeek)
                q2.dayNumber = Date.Now().AddDays(2).Day

                db.tblWeatherInfos.InsertOnSubmit(q2)

                db.SubmitChanges()

            End Using
        Catch ex As Exception

        End Try


    End Sub

    Shared Function getDayofWeek(day As Integer) As String

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
                Return ""
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

End Class
