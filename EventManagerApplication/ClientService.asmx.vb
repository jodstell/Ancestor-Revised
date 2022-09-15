Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports Newtonsoft.Json
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports CoreLibrary
Imports System.Data.SqlClient
Imports System.IO
Imports System.Drawing

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="/webservices")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class ClientService
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function getEvents(ByVal period As String, ByVal supplierID As Integer, ByVal brandID As Integer, ByVal marketID As Integer, ByVal teamID As Integer, ByVal eventTypeID As Integer) As String
        Return "Hello World"
    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getUserName(userID As String) As String

        Return JsonConvert.SerializeObject("Hello " & userID)
    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function validateUserName(userName As String) As List(Of ValidUserList)

        Dim myView As New List(Of ValidUserList)()

        'check if user exists
        Dim user As New LMSDataClassesDataContext
        Dim q = From p In user.AspNetUsers Where p.UserName = userName Select p

        ' If q.Count <> 0 Then
        For Each p In q
            myView.Add(New ValidUserList(p.UserName, 1))
        Next



        If q.Count <> 1 Then
            myView.Add(New ValidUserList("Nobody is here", 0))
        End If



        Return myView

    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function validateUserEmail(email As String) As List(Of ValidUserList)

        Dim myView As New List(Of ValidUserList)()

        'check if user exists
        Dim user As New LMSDataClassesDataContext
        Dim q = From p In user.AspNetUsers Where p.Email = email Select p

        ' If q.Count <> 0 Then
        For Each p In q
            myView.Add(New ValidUserList(p.UserName, 1))
        Next



        If q.Count <> 1 Then
            myView.Add(New ValidUserList("Nobody is here", 0))
        End If



        Return myView

    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAvailableAmbassadorMapbyEventID(EventID As String) As List(Of EventList)
        Dim db As New DataClassesDataContext

        Dim s As String()
        s = Split(EventID, ";")

        Dim _eventID As String = s(0)
        Dim _marketID As String = s(1)
        Dim _positionID As String = s(2)

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        Dim MyUserID As String = currentUser.Id

        Dim myView As New List(Of EventList)()
        Dim linkButton As String
        Dim thumbnail As String

        ' Dim q = From p In db.GetAvailableEventsMapbyAmbassador(MyUserID) Select p

        Dim q = From p In db.qryViewEvents Where p.eventID = Convert.ToInt32(_eventID) Select p

        For Each p In q

            linkButton = String.Format("<a target='_blank' style='position: absolute; top: 77%; left: 70%;' class='btn btn-primary btn-xs pull-right' href='/Events/EventDetails?ID={0}'>{1}</a>", p.eventID, "View Event")

            myView.Add(New EventList(p.accountName, p.latitude, p.longitude, getPushPinColor("Scheduled"), p.eventDate, p.startTime, p.endTime, p.eventID, FormatDateTime(p.eventDate, DateFormat.LongDate), FormatDateTime(p.startTime, DateFormat.LongTime), linkButton, p.accountName, p.address, p.city, p.state))
        Next

        Dim a = From p In db.getAvailableAmbassadorbyMarketID(Convert.ToInt32(_marketID), Convert.ToInt32(_positionID)) Select p

        For Each p In a

            linkButton = String.Format("<a target='_blank' style='position: absolute; top: 77%; left: 55%;' class='btn btn-primary btn-xs pull-right' href='/Ambassadors/ViewAmbassadorDetails?UserID={0}'>{1}</a>", p.userID, "View Ambassador")

            thumbnail = String.Format("<img src='/events/thumbnailhandler.ashx?ID={0}' width='50px'>", p.userID)
            myView.Add(New EventList(p.FullName, p.latitude, p.longitude, getPushPinColor("Booked"), Date.Now, Date.Now, Date.Now, _eventID, Date.Now, Date.Now, linkButton, thumbnail, checkSchedule(p.userID, _eventID), p.City, p.State))
        Next

        Return myView

    End Function

    Function checkSchedule(userID As String, eventID As Integer) As String

        Dim db As New DataClassesDataContext

        'get event date
        Dim thisEvent = (From p In db.tblEvents Where p.eventID = eventID Select p).FirstOrDefault

        Dim event_date As Date = thisEvent.eventDate

        Dim q = (From p In db.getScheduleConflicts Where p.userID = userID And p.eventDate = event_date Select p).Count

        Dim IsAssigned = (From p In db.getScheduleConflicts Where p.userID = userID And p.eventDate = event_date And p.eventID = thisEvent.eventID Select p).Count

        If IsAssigned > 0 Then
            Return "<span class='label label-success'>Assigned to this event</span>"
            Exit Function
        End If

        If q = 0 Then
            Return ""
        Else

            Return "<span class='label label-danger'>There is a potential conflict</span>"
        End If

    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAvailableEventsMapbyAmbassador(UserID As String) As List(Of EventList)
        Dim db As New DataClassesDataContext

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        Dim MyUserID As String = currentUser.Id

        Dim myView As New List(Of EventList)()

        Dim q = From p In db.GetAvailableEventsMapbyAmbassador(MyUserID) Select p

        For Each p In q
            myView.Add(New EventList(p.eventTitle, p.latitude, p.longitude, getPushPinColor("Scheduled"), p.eventDate, p.startTime, p.endTime, p.eventID, FormatDateTime(p.eventDate, DateFormat.LongDate), FormatDateTime(p.startTime, DateFormat.LongTime), p.supplierName, p.AccountName, p.address, p.city, p.state))
        Next

        Return myView

    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAvailableEventsMapbyAmbassadorSelectedEvent(UserID As String) As List(Of EventList)
        Dim db As New DataClassesDataContext

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        Dim MyUserID As String = currentUser.Id

        Dim myView As New List(Of EventList)()

        Dim q = From p In db.GetAvailableEventsMapbyAmbassadorSelectedEvent(MyUserID, Convert.ToInt32(UserID)) Select p

        For Each p In q
            myView.Add(New EventList(p.eventTitle, p.latitude, p.longitude, getPushPinColor(p.StatusName), p.eventDate, p.startTime, p.endTime, p.eventID, FormatDateTime(p.eventDate, DateFormat.LongDate), FormatDateTime(p.startTime, DateFormat.LongTime), p.supplierName, p.AccountName, p.address, p.city, p.state))
        Next

        Return myView

    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getEventsByDateRange(startDate As String, endDate As String, id As String) As List(Of EventList)

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        Dim userID As String = currentUser.Id

        Dim myView As New List(Of EventList)()

        Dim db As New DataClassesDataContext
        Dim _teamID = (From p In db.tblProfiles Where p.userID = userID Select p.teamID).FirstOrDefault


        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault

        If _teamID > 0 Then

            If isAllMarkets = True And isAllSuppliers = False Then
                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.teamID = _teamID
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                For Each p In q
                    myView.Add(New EventList(p.eventTitle, p.lat, p.lo, p.pincolor, p.eventDate, p.startTime, p.endTime, p.eventID, FormatDateTime(p.eventDate, DateFormat.LongDate), FormatDateTime(p.startTime, DateFormat.LongTime), p.supplierName, p.accountName, p.address, p.city, p.state))
                Next

                Return myView

            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And p.teamID = _teamID
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                For Each p In q
                    myView.Add(New EventList(p.eventTitle, p.lat, p.lo, p.pincolor, p.eventDate, p.startTime, p.endTime, p.eventID, FormatDateTime(p.eventDate, DateFormat.LongDate), FormatDateTime(p.startTime, DateFormat.LongTime), p.supplierName, p.accountName, p.address, p.city, p.state))
                Next

                Return myView

            End If

            If isAllMarkets = False Then
                Dim q = From p In db.qryViewEventsbyMarkets
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And p.userID = userID And p.teamID = _teamID
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                For Each p In q
                    myView.Add(New EventList(p.eventTitle, p.lat, p.lo, p.pincolor, p.eventDate, p.startTime, p.endTime, p.eventID, FormatDateTime(p.eventDate, DateFormat.LongDate), FormatDateTime(p.startTime, DateFormat.LongTime), p.supplierName, p.accountName, p.address, p.city, p.state))
                Next

                Return myView

            End If

            Return myView

        Else

            If isAllMarkets = True And isAllSuppliers = False Then
                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                For Each p In q
                    myView.Add(New EventList(p.eventTitle, p.lat, p.lo, p.pincolor, p.eventDate, p.startTime, p.endTime, p.eventID, FormatDateTime(p.eventDate, DateFormat.LongDate), FormatDateTime(p.startTime, DateFormat.LongTime), p.supplierName, p.accountName, p.address, p.city, p.state))
                Next

                Return myView

            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                For Each p In q
                    myView.Add(New EventList(p.eventTitle, p.lat, p.lo, p.pincolor, p.eventDate, p.startTime, p.endTime, p.eventID, FormatDateTime(p.eventDate, DateFormat.LongDate), FormatDateTime(p.startTime, DateFormat.LongTime), p.supplierName, p.accountName, p.address, p.city, p.state))
                Next

                Return myView

            End If

            If isAllMarkets = False Then
                Dim q = From p In db.qryViewEventsbyMarkets
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And p.userID = userID
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                For Each p In q
                    myView.Add(New EventList(p.eventTitle, p.lat, p.lo, p.pincolor, p.eventDate, p.startTime, p.endTime, p.eventID, FormatDateTime(p.eventDate, DateFormat.LongDate), FormatDateTime(p.startTime, DateFormat.LongTime), p.supplierName, p.accountName, p.address, p.city, p.state))
                Next

                Return myView

            End If

            Return myView

        End If

    End Function

    <WebMethod()>
    Public Function SendParameters(name As String, age As Integer) As String
        Return String.Format("Name: {0}{2}Password: {1}", name, age, Environment.NewLine)
    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPhotoBinCount(userID As String) As String

        Dim db As New DataClassesDataContext

        Return (From p In db.tblPhotoBins Where p.userID = userID Select p).Count

    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function DownloadPhoto(photoID As Integer) As String

        Try
            Dim db As New DataClassesDataContext

            Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault

            Dim data As Byte() = GetPhoto(photoID)

            HttpContext.Current.Response.Clear()
            HttpContext.Current.Response.ContentType = "application/octet-stream"
            HttpContext.Current.Response.AddHeader("content-disposition", Convert.ToString("attachment; filename=") & _fileName)
            HttpContext.Current.Response.BinaryWrite(data)


        Catch ex As Exception

        End Try

    End Function

    Private Function GetPhoto(photoId As Integer) As Byte()

        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Dim comm As New SqlCommand("SELECT LargeImage FROM tblPhoto WHERE photoID = @photoID", conn)
        comm.Parameters.Add(New SqlParameter("@PhotoID", photoId))

        conn.Open()
        Dim data As Object = comm.ExecuteScalar()
        conn.Close()

        Return DirectCast(data, Byte())
    End Function


    <System.Web.Services.WebMethod()>
    Public Function AddPhotoToBin(HiddenSessionGUID As String, photoID As Integer) As String

        Dim db As New DataClassesDataContext

        'create folder
        Dim folder As String = HiddenSessionGUID 'Context.User.Identity.GetUserId()
        Dim path = Server.MapPath(Convert.ToString("~/documents/photobin/") & folder)
        Dim directory = New DirectoryInfo(path)
        If directory.Exists = False Then
            directory.Create()
        End If

        Try

            Dim addtobin = db.InsertPhotoBin(photoID, Context.User.Identity.GetUserId(), HiddenSessionGUID)
            db.SubmitChanges()

        Catch ex As Exception

        End Try

        Try
            Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault

            Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
                sqlconnection.Open()

                Dim selectQuery As String = String.Format("SELECT Image FROM tblPhoto WHERE photoID ={0}", photoID)

                Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)
                Dim reader As SqlDataReader = selectCommand.ExecuteReader()
                If reader.Read() Then
                    Dim byteData As Byte() = DirectCast(reader(0), Byte())
                    Dim strData As String = Encoding.UTF8.GetString(byteData)

                    System.IO.File.WriteAllBytes(Server.MapPath(Convert.ToString("~/documents/photobin/" & folder & "/" & _fileName)), byteData)

                End If
                sqlconnection.Close()
            End Using
        Catch ex As Exception

        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Function RotateImage(photoID As Integer) As String

        Dim db As New DataClassesDataContext

        'get the image from sql and save as to disk
        Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault

        Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
            sqlconnection.Open()

            Dim selectQuery As String = String.Format("SELECT Image FROM tblPhoto WHERE photoID ={0}", photoID)

            Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)
            Dim reader As SqlDataReader = selectCommand.ExecuteReader()
            If reader.Read() Then
                Dim byteData As Byte() = DirectCast(reader(0), Byte())
                Dim strData As String = Encoding.UTF8.GetString(byteData)

                System.IO.File.WriteAllBytes(Server.MapPath(Convert.ToString("~/documents/rotator/" & _fileName)), byteData)

            End If
            sqlconnection.Close()
        End Using

        'rotate the image
        ' get the full path of image url

        Dim path As String = Server.MapPath("~/documents/rotator/" & _fileName)
        Dim newpath As String = Server.MapPath("~/documents/rotator/new/" & photoID & ".png")

        ' creating image from the image url
        Dim i As System.Drawing.Image = System.Drawing.Image.FromFile(path)

        ' rotate Image 90' Degree
        i.RotateFlip(RotateFlipType.Rotate90FlipNone)

        ' save it to its actual path
        i.Save(newpath)

        ' release Image File
        i.Dispose()


        'save image to sql
        Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
            sqlconnection.Open()

            Dim bytes As Byte() = Nothing
            Dim fs As New FileStream(newpath, FileMode.Open, FileAccess.Read)
            Dim br As New BinaryReader(fs)
            bytes = br.ReadBytes(CInt(fs.Length))


            Dim selectQuery As String = String.Format("UPDATE tblPhoto set Image = @image, ThumbImage = @thumbimage, SmallImage = @smallimage, LargeImage = @largeimage WHERE photoID = @photoID")
            Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)


            selectCommand.Parameters.Add(New SqlParameter("@photoID", photoID))
            selectCommand.Parameters.Add(New SqlParameter("@image", MakeThumb(bytes, 1200)))
            selectCommand.Parameters.Add(New SqlParameter("@thumbimage", MakeThumb(bytes, 100)))
            selectCommand.Parameters.Add(New SqlParameter("@smallimage", MakeThumb(bytes, 350)))
            selectCommand.Parameters.Add(New SqlParameter("@largeimage", MakeThumb(bytes, 500)))

            selectCommand.ExecuteNonQuery()
            sqlconnection.Close()

        End Using

        Return "Success"

    End Function

    <System.Web.Services.WebMethod()>
    Public Function RotateImageLeft(photoID As Integer) As String

        Dim db As New DataClassesDataContext

        'get the image from sql and save as to disk
        Dim _fileName As String = (From p In db.tblPhotos Where p.photoID = photoID Select p.fileName).FirstOrDefault

        Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
            sqlconnection.Open()

            Dim selectQuery As String = String.Format("SELECT Image FROM tblPhoto WHERE photoID ={0}", photoID)

            Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)
            Dim reader As SqlDataReader = selectCommand.ExecuteReader()
            If reader.Read() Then
                Dim byteData As Byte() = DirectCast(reader(0), Byte())
                Dim strData As String = Encoding.UTF8.GetString(byteData)

                System.IO.File.WriteAllBytes(Server.MapPath(Convert.ToString("~/documents/rotator/" & _fileName)), byteData)

            End If
            sqlconnection.Close()
        End Using

        'rotate the image
        ' get the full path of image url

        Dim path As String = Server.MapPath("~/documents/rotator/" & _fileName)
        Dim newpath As String = Server.MapPath("~/documents/rotator/new/" & photoID & ".png")

        ' creating image from the image url
        Dim i As System.Drawing.Image = System.Drawing.Image.FromFile(path)

        ' rotate Image 90' Degree
        i.RotateFlip(RotateFlipType.Rotate270FlipNone)

        ' save it to its actual path
        i.Save(newpath)

        ' release Image File
        i.Dispose()


        'save image to sql
        Using sqlconnection As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
            sqlconnection.Open()

            Dim bytes As Byte() = Nothing
            Dim fs As New FileStream(newpath, FileMode.Open, FileAccess.Read)
            Dim br As New BinaryReader(fs)
            bytes = br.ReadBytes(CInt(fs.Length))


            Dim selectQuery As String = String.Format("UPDATE tblPhoto set Image = @image, ThumbImage = @thumbimage, SmallImage = @smallimage, LargeImage = @largeimage WHERE photoID = @photoID")
            Dim selectCommand As New SqlCommand(selectQuery, sqlconnection)


            selectCommand.Parameters.Add(New SqlParameter("@photoID", photoID))
            selectCommand.Parameters.Add(New SqlParameter("@image", MakeThumb(bytes, 1200)))
            selectCommand.Parameters.Add(New SqlParameter("@thumbimage", MakeThumb(bytes, 100)))
            selectCommand.Parameters.Add(New SqlParameter("@smallimage", MakeThumb(bytes, 350)))
            selectCommand.Parameters.Add(New SqlParameter("@largeimage", MakeThumb(bytes, 500)))

            selectCommand.ExecuteNonQuery()
            sqlconnection.Close()

        End Using

        Return "Success"

    End Function

    <WebMethod()>
    Public Function ResetTrainingCourse(supplierID As Integer)

        Dim db As New DataClassesDataContext
        Dim db1 As New LMSDataClassesDataContext

        'set the events to need update
        db.UpdateEventCourseList(supplierID)

        'add all BA's to course
        Try
            Dim _courseID = (From p In db.tblSuppliers Where p.supplierID = supplierID Select p.CourseID).FirstOrDefault

            Dim r = From p In db.getAssignedLists Where p.supplierID = supplierID Select p
            For Each p In r
                db1.AddStudentToCourse(p.assignedUserName, _courseID)
            Next
        Catch ex As Exception

        End Try


    End Function

    <WebMethod()>
    Public Function LoadBingMap(mystring As String)

        Dim db As New DataClassesDataContext

        ' Dim s As String()
        ' s = Split(mystring, ";")

        db.UpdateLoadCount(mystring)

    End Function

    <WebMethod()>
    Public Function CheckinAmbassador(mystring As String)

        Dim db As New DataClassesDataContext

        Dim s As String()
        s = Split(mystring, ";")

        db.CheckInAmbassador(s(0), s(1), s(2), s(3))

    End Function

    Function getPushPinIcon(ByVal status As String) As String
        Select Case status
            Case "Approved"
                Return "/images/light_blue.png"

            Case "Scheduled"
                Return "/images/orange.png"

            Case "Booked"
                Return "/images/green.png"

            Case "Cancelled"
                Return "/images/red.png"

            Case "Shippingrequested"
                Return "/images/med_blue.png"

            Case "Toplined"
                Return "/images/purple.png"
        End Select
    End Function

    Function getPushPinColor(ByVal status As String) As String

        Select Case status
            Case "Approved"
                Return "rgba(51, 152, 203, 1)"

            Case "Scheduled"
                Return "rgba(254, 152, 0, 1)"

            Case "Booked"
                Return "rgba(102, 152, 51, 1)"

            Case "Cancelled"
                Return "rgba(200, 48, 44, 1)"

            Case "Shippingrequested"
                Return "rgba(1, 89, 144, 1)"

            Case "Toplined"
                Return "rgba(86, 61, 123, 1)"

            Case "Cancelled Last Minute"
                Return "rgba(200, 48, 44, 1)"
        End Select
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=True)>
    Public Function getLocations() As List(Of AccountList)

        Dim db As New DataClassesDataContext

        Dim myView As New List(Of AccountList)
        Dim q = From p In db.tblAccounts Where p.latitude <> "0" Or p.longitude <> "0" Select p
        For Each p In q
            myView.Add(New AccountList(p.accountName, p.latitude, p.longitude))
        Next

        Return myView

    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getAllLocations() As List(Of AccountList)

        Dim db As New DataClassesDataContext

        Dim myView As New List(Of AccountList)
        Dim q = From p In db.tblAccounts Select p
        For Each p In q
            myView.Add(New AccountList(p.accountName, p.latitude, p.longitude))
        Next

        Return myView

    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getAllLocationsByMarketID(marketID As Integer) As List(Of AccountList)

        Dim db As New DataClassesDataContext

        Dim myView As New List(Of AccountList)
        Dim q = From p In db.tblAccounts Where p.marketID = marketID Select p
        For Each p In q
            myView.Add(New AccountList(p.accountName, p.latitude, p.longitude))
        Next

        Return myView

    End Function

    '<WebMethod>
    '<ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    'Public Function GetData() As List(Of Temp)
    '    Dim list = New List(Of Temp)()
    '    list.Add(New Temp("Item1"))
    '    list.Add(New Temp("Item2"))
    '    Return list
    'End Function

    'Public Class Temp
    '    Private _text As String

    '    Public Property Text() As String
    '        Get
    '            Return _text
    '        End Get
    '        Set(ByVal value As String)
    '            _text = value
    '        End Set
    '    End Property

    '    Public Sub New(ByVal pText As String)
    '        _text = pText
    '    End Sub
    'End Class

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getTotalEventSummaryByDateRange(startDate As String, endDate As String, id As String) As List(Of EventSummary)

        Dim db As New DataClassesDataContext
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userID As String = currentUser.Id

        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault

        Dim _teamID = (From p In db.tblProfiles Where p.userID = userID Select p.teamID).FirstOrDefault

        If _teamID > 0 Then
            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.teamID = _teamID
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Total Events", q.Count))

                Return myView
            End If


            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)
                myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))

                Return myView


            Else

                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Total Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.userID = userID Select p).Count))

                Return myView
            End If

        Else

            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Total Events", q.Count))

                Return myView
            End If


            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)
                myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))

                Return myView


            Else

                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Total Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.userID = userID Select p).Count))

                Return myView
            End If
        End If


    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getApprovedEventSummaryByDateRange(startDate As String, endDate As String, id As String) As List(Of EventSummary)

        Dim db As New DataClassesDataContext
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userID As String = currentUser.Id

        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault

        Dim _teamID = (From p In db.tblProfiles Where p.userID = userID Select p.teamID).FirstOrDefault

        If _teamID > 0 Then

            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.teamID = _teamID And p.statusName = "approved"
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Approved Events", q.Count))

                Return myView
            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Approved Events", (From p In db.qryViewEvents Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "approved" Select p).Count))
                Return myView
            Else
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Approved Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "approved" And p.userID = userID Select p).Count))
                Return myView
            End If

        Else

            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.statusName = "approved"
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Approved Events", q.Count))

                Return myView
            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Approved Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "approved" Select p).Count))
                Return myView
            Else
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Approved Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "approved" And p.userID = userID Select p).Count))
                Return myView
            End If
        End If





    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getScheduledEventSummaryByDateRange(startDate As String, endDate As String, id As String) As List(Of EventSummary)

        Dim db As New DataClassesDataContext
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userID As String = currentUser.Id

        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault

        Dim _teamID = (From p In db.tblProfiles Where p.userID = userID Select p.teamID).FirstOrDefault

        If _teamID > 0 Then
            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.teamID = _teamID And p.statusName = "scheduled"
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Scheduled Events", q.Count))

                Return myView
            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Scheduled Events", (From p In db.qryViewEvents Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "scheduled" Select p).Count))

                Return myView
            Else
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Scheduled Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "scheduled" And p.userID = userID Select p).Count))

                Return myView
            End If
        Else
            'user is not assigned to a team
            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.statusName = "scheduled"
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Scheduled Events", q.Count))

                Return myView
            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Scheduled Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "scheduled" Select p).Count))

                Return myView
            Else
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Scheduled Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "scheduled" And p.userID = userID Select p).Count))

                Return myView
            End If
        End If






    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getBookedEventSummaryByDateRange(startDate As String, endDate As String, id As String) As List(Of EventSummary)

        Dim db As New DataClassesDataContext
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userID As String = currentUser.Id

        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault

        Dim _teamID = (From p In db.tblProfiles Where p.userID = userID Select p.teamID).FirstOrDefault

        If _teamID > 0 Then
            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.teamID = _teamID And p.statusName = "booked"
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Booked Events", q.Count))

                Return myView
            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Booked Events", (From p In db.qryViewEvents Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "booked" Select p).Count))

                Return myView
            Else
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Booked Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "booked" And p.userID = userID Select p).Count))

                Return myView
            End If

        Else
            'user is not assigned to a team
            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.statusName = "booked"
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Booked Events", q.Count))

                Return myView
            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Booked Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "booked" Select p).Count))

                Return myView
            Else
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Booked Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "booked" And p.userID = userID Select p).Count))

                Return myView
            End If

        End If





    End Function



    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getToplinedEventSummaryByDateRange(startDate As String, endDate As String, id As String) As List(Of EventSummary)

        Dim db As New DataClassesDataContext
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userID As String = currentUser.Id

        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault


        Dim _teamID = (From p In db.tblProfiles Where p.userID = userID Select p.teamID).FirstOrDefault

        If _teamID > 0 Then
            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.teamID = _teamID And p.statusName = "toplined"
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Toplined Events", q.Count))

                Return myView
            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Toplined Events", (From p In db.qryViewEvents Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "toplined" Select p).Count))

                Return myView
            Else
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Toplined Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "toplined" And p.userID = userID Select p).Count))

                Return myView
            End If

        Else
            'user is not assigned to a team
            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.statusName = "toplined"
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Toplined Events", q.Count))

                Return myView
            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Toplined Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "toplined" Select p).Count))

                Return myView
            Else
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Toplined Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusName = "toplined" And p.userID = userID Select p).Count))

                Return myView
            End If

        End If






    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getCancelledEventSummaryByDateRange(startDate As String, endDate As String, id As String) As List(Of EventSummary)

        Dim db As New DataClassesDataContext
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userID As String = currentUser.Id

        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault

        Dim _teamID = (From p In db.tblProfiles Where p.userID = userID Select p.teamID).FirstOrDefault

        If _teamID > 0 Then
            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.teamID = _teamID And p.statusID = "3" Or
                            p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.teamID = _teamID And p.statusID = "7"
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Canceled Events", q.Count))

                Return myView
            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Canceled Events", (From p In db.qryViewEvents Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.statusID = "3" Or p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.statusID = "7" Select p).Count))

                Return myView
            Else
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Canceled Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.teamID = _teamID And p.eventDate >= startDate And p.eventDate <= endDate And p.statusID = "3" And p.userID = userID Or p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusID = "7" And p.userID = userID And p.teamID = _teamID Select p).Count))

                Return myView
            End If
        Else
            'user is not assigned to a team
            If isAllMarkets = True And isAllSuppliers = False Then
                Dim myView As New List(Of EventSummary)
                ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
                ' Return myView

                Dim q = From p In db.qryViewEvents
                        Join c In db.tblAccounts On c.Vpid Equals p.locationID
                        Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                        Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.statusID = "3" Or
                            p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.statusID = "7"
                        Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

                myView.Add(New EventSummary("Canceled Events", q.Count))

                Return myView
            End If

            If isAllMarkets = True And isAllSuppliers = True Then
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Canceled Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusID = "3" Or p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusID = "7" Select p).Count))

                Return myView
            Else
                Dim myView As New List(Of EventSummary)

                myView.Add(New EventSummary("Canceled Events", (From p In db.qryViewEventsbyMarkets Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusID = "3" And p.userID = userID Or p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate And p.statusID = "7" And p.userID = userID Select p).Count))

                Return myView
            End If
        End If







    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getShippingRequestedSummaryByDateRange(startDate As String, endDate As String, id As String) As List(Of EventSummary)

        Dim db As New DataClassesDataContext
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userID As String = currentUser.Id

        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault

        If isAllMarkets = True And isAllSuppliers = False Then
            Dim myView As New List(Of EventSummary)
            ' myView.Add(New EventSummary("Total Events", (From p In db.qryViewEvents Where p.clientID = id And p.eventDate >= startDate And p.eventDate <= endDate Select p).Count))
            ' Return myView

            Dim q = From p In db.qryViewEvents
                    Join c In db.tblAccounts On c.Vpid Equals p.locationID
                    Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                    Where p.eventDate >= startDate And p.eventDate <= endDate And p.clientID = id And i.userID = userID And p.statusName = "requested"
                    Select p.eventTitle, lat = c.latitude, lo = c.longitude, d = p.eventDate, pincolor = getPushPinColor(p.statusName), p.eventDate, p.startTime, p.endTime, p.eventID, p.supplierName, p.accountName, p.address, p.city, p.state

            myView.Add(New EventSummary("Requested Events", q.Count))

            Return myView
        End If

        If isAllMarkets = True And isAllSuppliers = True Then
            Dim myView As New List(Of EventSummary)

            myView.Add(New EventSummary("Shipping Requested", (From p In db.tblRequestedEvents Where p.clientID = id And p.deleted Is Nothing Select p).Count))

            Return myView
        Else
            Dim myView As New List(Of EventSummary)

            myView.Add(New EventSummary("Shipping Requested", (From p In db.tblRequestedEvents Where p.clientID = id And p.deleted Is Nothing Select p).Count))



            Return myView
        End If




    End Function



    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getEventBrandsByDateRange(startDate As String, endDate As String, id As String) As List(Of EventSummary)

        Dim db As New DataClassesDataContext
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userID As String = currentUser.Id

        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault

        If isAllMarkets = True And isAllSuppliers = False Then
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventBrandsCount(startDate, endDate, id)
                    Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                    Where i.userID = userID Order By p.brandName
                    Select p.count, p.supplierID, p.brandName, p.brandID

            For Each p In q
                myView.Add(New EventSummary(getBrandName(p.brandID), p.count))
            Next

            Return myView

        End If


        If isAllMarkets = True And isAllSuppliers = True Then
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventBrandsCount(startDate, endDate, id) Order By p.brandName
            For Each p In q
                myView.Add(New EventSummary(getBrandName(p.brandID), p.count))
            Next

            Return myView
        Else
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventBrandsCountbyMarkets(startDate, endDate, id, currentUser.Id) Order By p.brandID
            For Each p In q
                myView.Add(New EventSummary(getBrandName(p.brandID), p.count))
            Next

            Return myView
        End If


    End Function

    Public Function getBrandName(ByVal id As Integer) As String
        Dim db As New DataClassesDataContext
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function



    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getEventSupplierByDateRange(startDate As String, endDate As String, id As String) As List(Of EventSummary)

        Dim db As New DataClassesDataContext
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userID As String = currentUser.Id

        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault

        If isAllMarkets = True And isAllSuppliers = False Then
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventSupplierCount(startDate, endDate, id)
                    Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                    Where i.userID = userID
                    Select p.count, p.supplierID
            For Each p In q
                myView.Add(New EventSummary(getSupplierName(p.supplierID), p.count))
            Next

            Return myView
        End If

        If isAllMarkets = True And isAllSuppliers = True Then
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventSupplierCount(startDate, endDate, id)
            For Each p In q
                myView.Add(New EventSummary(getSupplierName(p.supplierID), p.count))
            Next

            Return myView

        End If

        If isAllMarkets = False And isAllSuppliers = False Then
            Dim myView As New List(Of EventSummary)
            Dim q = From p In db.getEventSupplierCount(startDate, endDate, id)
                    Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                    Where i.userID = userID
                    Select p.count, p.supplierID
            For Each p In q
                myView.Add(New EventSummary(getSupplierName(p.supplierID), p.count))
            Next

            Return myView
        Else
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventSupplierCountbyMarkets(startDate, endDate, id, currentUser.Id)
            For Each p In q
                myView.Add(New EventSummary(getSupplierName(p.supplierID), p.count))
            Next

            Return myView
        End If


    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getEventTypeByDateRange(startDate As String, endDate As String, id As String) As List(Of EventSummary)

        Dim db As New DataClassesDataContext
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userID As String = currentUser.Id

        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault

        If isAllMarkets = True And isAllSuppliers = False Then
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventTypeCount(startDate, endDate, id)
                    Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                    Where i.userID = userID
                    Select p.count, p.supplierID, p.eventTypeID
            For Each p In q
                myView.Add(New EventSummary(getEventTypeName(p.eventTypeID), p.count))
            Next

            Return myView
        End If

        If isAllMarkets = True And isAllSuppliers = True Then
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventTypeCount_AllSuppliers(startDate, endDate, id)
            For Each p In q
                myView.Add(New EventSummary(getEventTypeName(p.eventTypeID), p.count))
            Next

            Return myView

        End If

        If isAllMarkets = False And isAllSuppliers = False Then
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventTypeCount(startDate, endDate, id)
                    Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                    Where i.userID = userID
                    Select p.count, p.supplierID, p.eventTypeID
            For Each p In q
                myView.Add(New EventSummary(getEventTypeName(p.eventTypeID), p.count))
            Next

            Return myView
        Else
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventTypeCountbyMarkets(startDate, endDate, id, currentUser.Id)
            For Each p In q
                myView.Add(New EventSummary(getEventTypeName(p.eventTypeID) & " 5", p.count))
            Next

            Return myView
        End If


    End Function


    Public Function getEventTypeName(id As Integer) As String
        Dim db As New DataClassesDataContext

        Return (From p In db.tblEventTypes Where p.eventTypeID = id Select p.eventTypeName).FirstOrDefault

    End Function

    Public Function getSupplierName(id As Integer) As String
        Dim db As New DataClassesDataContext

        Return (From p In db.tblSuppliers Where p.supplierID = id Select p.supplierName).FirstOrDefault

    End Function

    <WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function getEventStateByDateRange(startDate As String, endDate As String, id As String) As List(Of EventSummary)

        Dim db As New DataClassesDataContext
        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())
        Dim userID As String = currentUser.Id

        Dim isAllMarkets = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllMarkets).FirstOrDefault
        Dim isAllSuppliers = (From p In db.tblProfiles Where p.userID = userID Select p.enableAllSuppliers).FirstOrDefault

        If isAllMarkets = True And isAllSuppliers = False Then
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventStateCountByUserID(startDate, endDate, id)
                    Join i In db.tblStaffSuppliers On i.supplierID Equals p.supplierID
                    Where i.userID = userID
                    Select p.count, p.supplierID, p.state
            For Each p In q
                myView.Add(New EventSummary(getStateName(p.state).TrimEnd, p.count))
            Next

            Return myView

        End If



        If isAllMarkets = True And isAllSuppliers = True Then
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventStateCount(startDate, endDate, id)
            For Each p In q
                myView.Add(New EventSummary(getStateName(p.state).TrimEnd, p.count))
            Next

            Return myView

        End If

        If isAllMarkets = False And isAllSuppliers = False Then
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventStateCountbyMarkets(startDate, endDate, id, currentUser.Id)
            For Each p In q
                myView.Add(New EventSummary(getStateName(p.state).TrimEnd, p.count))
            Next

            Return myView
        Else
            Dim myView As New List(Of EventSummary)

            Dim q = From p In db.getEventStateCountbyMarkets(startDate, endDate, id, currentUser.Id)
            For Each p In q
                myView.Add(New EventSummary(getStateName(p.state).TrimEnd, p.count))
            Next

            Return myView
        End If


    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=True)>
    Public Function getNewGuid() As String


        Return Guid.NewGuid().ToString()


    End Function


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

            Case ""
                Return ""
        End Select

    End Function

    Const sizeThumb As Integer = 100

    Public Shared Function MakeThumb(ByVal fullsize As Byte()) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim targetH, targetW As Integer

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image
        If (iOriginal.Height > iOriginal.Width) Then
            targetH = sizeThumb
            targetW = CInt(iOriginal.Width * (sizeThumb / iOriginal.Height))
        Else
            targetW = sizeThumb
            targetH = CInt(iOriginal.Height * (sizeThumb / iOriginal.Width))
        End If
        iThumb = iOriginal.GetThumbnailImage(targetW, targetH, Nothing, System.IntPtr.Zero)
        Dim m As New IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function


    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal newwidth As Integer, ByVal newheight As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scaleH, scaleW As Double
        Dim srcRect As Drawing.Rectangle


        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))
        ' Find Height and Width for Thumbnail Image

        scaleH = iOriginal.Height / newheight
        scaleW = iOriginal.Width / newwidth
        If scaleH = scaleW Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = iOriginal.Height
            srcRect.X = 0
            srcRect.Y = 0
        ElseIf (scaleH) > (scaleW) Then
            srcRect.Width = iOriginal.Width
            srcRect.Height = CInt(newheight * scaleW)
            srcRect.X = 0
            srcRect.Y = CInt((iOriginal.Height - srcRect.Height) / 2)
        Else
            srcRect.Width = CInt(newwidth * scaleH)
            srcRect.Height = iOriginal.Height
            srcRect.X = CInt((iOriginal.Width - srcRect.Width) / 2)
            srcRect.Y = 0
        End If

        iThumb = New System.Drawing.Bitmap(newwidth, newheight)
        Dim g As Drawing.Graphics = Drawing.Graphics.FromImage(iThumb)
        g.DrawImage(iOriginal, New Drawing.Rectangle(0, 0, newwidth, newheight), srcRect, Drawing.GraphicsUnit.Pixel)

        Dim m As New IO.MemoryStream()
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return m.GetBuffer()
    End Function

    Public Shared Function MakeThumb(ByVal fullsize As Byte(), ByVal maxwidth As Integer) As Byte()
        Dim iOriginal, iThumb As System.Drawing.Image
        Dim scale As Double

        ' Grab Original Image
        iOriginal = System.Drawing.Image.FromStream(New IO.MemoryStream(fullsize))

        If iOriginal.Width > maxwidth Then

            scale = iOriginal.Width / maxwidth
            Dim newheight As Integer = CInt(iOriginal.Height / scale)

            iThumb = New System.Drawing.Bitmap(iOriginal, maxwidth, newheight)
            Dim m As New IO.MemoryStream()
            iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg)
            Return m.GetBuffer()
        Else
            Return fullsize
        End If
    End Function

End Class