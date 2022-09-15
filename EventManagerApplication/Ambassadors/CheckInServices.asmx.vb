Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="/webservices")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class CheckInServices
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function CheckinAmbassadorTime(mystring As String)

        Dim db As New DataClassesDataContext

        Dim s As String()
        s = Split(mystring, ";")

        db.AmbassadorCheckInTime(s(0), s(1))

#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths

    <WebMethod()>
    Public Function CheckinAmbassadorLocation(mystring As String)

        Dim db As New DataClassesDataContext

        Dim s As String()
        s = Split(mystring, ";")

        db.AmbassadorCheckInLocation(s(0), s(1), s(2), s(3))

#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths


    <WebMethod()>
    Public Function setCheckInLocation(mystring As String)

        Dim db As New DataClassesDataContext

        Dim s As String()
        s = Split(mystring, ";")

        db.CheckInTest(s(0), s(1), s(2), s(3))


        'Dim myCheckIn As New tempCheckIn With {.UserID = s(0), .Latitude = s(1), .Longtitude = s(2), .eventID = s(3), .timeStamp = Date.Now()}

        'db.tempCheckIns.InsertOnSubmit(myCheckIn)
        'db.SubmitChanges()





#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths

    <WebMethod()>
    Public Function setCheckinTime(mystring As String)

        Dim db As New DataClassesDataContext

        Dim s As String()
        s = Split(mystring, ";")

        db.CheckInTime(s(0), s(1))


        'Dim myCheckIn As New tempCheckIn With {.UserID = s(0), .Latitude = s(1), .Longtitude = s(2), .eventID = s(3), .timeStamp = Date.Now()}

        'db.tempCheckIns.InsertOnSubmit(myCheckIn)
        'db.SubmitChanges()





#Disable Warning BC42105 ' Function doesn't return a value on all code paths
    End Function
#Enable Warning BC42105 ' Function doesn't return a value on all code paths

End Class