Imports Telerik.Web.UI
Imports BingGeocoder
Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Imports System.Xml.Linq

Public Class ViewRequestedEvents
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext

    Dim lmsdb As New LMSDataClassesDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim q = From p In db.tblRequestedEvents Where p.matchedLocationID = 0 Select p

        If q.Count = 0 Then
            NoMatchPanel.Visible = False
        Else
            NoMatchPanel.Visible = True
        End If
    End Sub

    Private Sub RequestedEventsGrid_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RequestedEventsGrid.ItemCommand
        Select Case e.CommandName
            Case "ViewEvent"
                Response.Redirect("/Events/NewRequestedEvent?requestedEventID=" & e.CommandArgument)
            Case "DeleteEvent"
                db.DeleteRequestedEvent(Convert.ToInt32(e.CommandArgument), 0)

                RequestedEventsGrid.DataBind()
        End Select
    End Sub

    Protected Sub EventDataGrid_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)

        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        e.ListBox.DataSource = GetDataTable(DataField)
        e.ListBox.DataKeyField = DataField
        e.ListBox.DataTextField = DataField
        e.ListBox.DataValueField = DataField
        e.ListBox.DataBind()

    End Sub

    Public Function GetDataTable(field As String) As DataTable

        Dim query As String = String.Format("SELECT DISTINCT {1} FROM qryGetRequestedEvents where clientid = {0} order by {1}", Session("CurrentClientID"), field)

        Dim ConnString As [String] = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString

        Dim conn As New SqlConnection(ConnString)
        Dim adapter As New SqlDataAdapter()

        adapter.SelectCommand = New SqlCommand(query, conn)

        Dim myDataTable As New DataTable()

        conn.Open()

        Try
            adapter.Fill(myDataTable)
        Finally
            conn.Close()
        End Try

        Return myDataTable

    End Function

    Function getAccountName(id As String) As String
        Return (From p In db.tblAccounts Where p.Vpid = id Select p.accountName).FirstOrDefault
    End Function

    Function getAccountAddress(id As String) As String
        Return (From p In db.tblAccounts Where p.Vpid = id Select p.streetAddress1).FirstOrDefault
    End Function

    Function getAccountCity(id As String) As String
        Return (From p In db.tblAccounts Where p.Vpid = id Select p.city).FirstOrDefault
    End Function

    Function getAccountState(id As String) As String
        Return (From p In db.tblAccounts Where p.Vpid = id Select p.state).FirstOrDefault
    End Function


    Function getAddress(ByVal ID As Integer) As String

        Dim q = (From p In db.tblRequestedEvents Where p.requestedEventID = ID Select p).FirstOrDefault

        Dim address As String = String.Format("{0}, {1}, {2}, {3}", q.locationAddress, q.locationCity, q.locationState, q.locationZip)

        Dim a = getLatitude(address.Replace("#", ""))

        Dim b As String = a.Substring(0, 5)

        Dim c = getLongitude(address.Replace("#", ""))

        Dim d As String = c.Substring(0, 5)


        Return a & "<br>" & c
        ' Return b & "<br>" & d
        '  Return address
        ' Return getLatitude(address.Replace("#", ""))

    End Function

    'Function getMatch(ByVal ID As Integer) As String
    '    Try
    '        Dim q = (From p In db.tblRequestedEvents Where p.requestedEventID = ID Select p).FirstOrDefault
    '        Dim address As String = String.Format("{0}, {1}, {2}, {3}", q.locationAddress, q.locationCity, q.locationState, q.locationZip)

    '        Dim loc1 = getLatitude(address.Replace("#", ""))
    '        Dim loc2 = getLongitude(address.Replace("#", ""))

    '        Dim b As String = loc1.Substring(0, 5)

    '        Dim c As String = loc2.Substring(0, 5)

    '        Dim r = (From p In db.getShortGeoLocations Where p.shortLatitude = b And p.shortLongitude = c Select p).FirstOrDefault


    '        Return r.Vpid
    '    Catch ex As Exception
    '        Return "0"
    '    End Try


    'End Function

    Function getLatitude(ByVal address As String) As String

        Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

        Dim geocoder = New BingGeocoderClient(BingKey)
        Dim result = New BingGeocoderResult()
        result = geocoder.Geocode(address)

        Return result.Latitude

    End Function

    Function getLongitude(ByVal address As String) As String

        Dim BingKey As String = ConfigurationManager.AppSettings("BingMapsAPIKey").ToString()

        Dim geocoder = New BingGeocoderClient(BingKey)
        Dim result = New BingGeocoderResult()
        result = geocoder.Geocode(address)

        Return result.Longitude

    End Function

    Protected Sub ToggleRowSelection(ByVal sender As Object, ByVal e As EventArgs)

        TryCast(TryCast(sender, CheckBox).NamingContainer, GridItem).Selected = TryCast(sender, CheckBox).Checked
        Dim checkHeader As Boolean = True
        For Each dataItem As GridDataItem In RequestedEventsGrid.MasterTableView.Items
            If Not TryCast(dataItem.FindControl("CheckBox1"), CheckBox).Checked Then
                checkHeader = False
                Exit For
            End If
        Next
        Dim headerItem As GridHeaderItem = TryCast(RequestedEventsGrid.MasterTableView.GetItems(GridItemType.Header)(0), GridHeaderItem)
        TryCast(headerItem.FindControl("headerChkbox"), CheckBox).Checked = checkHeader
    End Sub

    Protected Sub ToggleSelectedState(ByVal sender As Object, ByVal e As EventArgs)
        Dim headerCheckBox As CheckBox = TryCast(sender, CheckBox)
        For Each dataItem As GridDataItem In RequestedEventsGrid.MasterTableView.Items
            TryCast(dataItem.FindControl("CheckBox1"), CheckBox).Checked = headerCheckBox.Checked
            dataItem.Selected = headerCheckBox.Checked
        Next
    End Sub

    Private Sub RequestedEventsGrid_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles RequestedEventsGrid.ItemDataBound

        'If TypeOf e.Item Is GridDataItem Then
        '    Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
        '    Dim strTxt As String = item("MarketName").Text.ToString()
        'End If

        'If e.Item.RowType = DataControlRowType.DataRow Then


        '    Dim chkbox As CheckBox = DirectCast(e.Row.FindControl("chkSelect"), CheckBox)

        '    If e.Row.Cells(3).Text = "BCA" Then



        '        chkbox.Enabled = False
        '    Else




        '        chkbox.Enabled = True

        '    End If
        'End If


    End Sub

    Private Sub btnCreateEvents_Click(sender As Object, e As EventArgs) Handles btnCreateEvents.Click

        If RequestedEventsGrid.SelectedItems.Count = 0 Then
            topMsgLabel.Text = "You must select at least one event."

        Else
            'we need to create an invoice for each supplier in the selected grid
            For Each item As GridDataItem In RequestedEventsGrid.SelectedItems

                topMsgLabel.Text = ""

                'add new event functions

                ' Dim vpid As Integer = getMatch(item("requestedEventID").Text)

                Dim id As String = item.GetDataKeyValue("requestedEventID").ToString()


                'Dim id As String = item("requestedEventID").Text


                Dim myEvent = (From p In db.tblRequestedEvents Where p.requestedEventID = id Select p).FirstOrDefault

                Dim a = (From p In db.tblAccounts Where p.Vpid = myEvent.matchedLocationID Select p).FirstOrDefault

                'save the event
                Dim newevent As New tblEvent
                newevent.eventTitle = myEvent.eventTitle
                newevent.supplierID = myEvent.supplierID
                newevent.eventTypeID = myEvent.eventTypeID

                newevent.eventDescription = myEvent.eventDescription
                newevent.eventDate = myEvent.eventDate
                newevent.startTime = myEvent.startTime
                newevent.endTime = myEvent.endTime

                newevent.distributer = myEvent.distributer
                newevent.requestedBy = myEvent.CreatedBy

                newevent.teamID = myEvent.teamID


                If myEvent.teamID > 0 Then
                    Dim hasBA = (From p In db.tblProfiles Where p.teamID = myEvent.teamID And p.IsStaff = 0 Select p.userName).Count
                    If hasBA = 0 Then
                        newevent.statusID = 4 'set to Scheduled
                    Else
                        newevent.statusID = 2 'set to Booked
                    End If

                Else
                    newevent.statusID = 4 'set to Scheduled
                End If

                newevent.brandID = 0 'unused
                newevent.billableEvent = True
                newevent.clientID = myEvent.clientID
                newevent.recapStatus = 0
                newevent.CreatedDate = Date.Now()
                newevent.CreatedBy = Context.User.Identity.GetUserId()
                newevent.Modified = 1
                newevent.importFileID = myEvent.importFileID

                If myEvent.requestType = "Online" Then
                    newevent.createdSource = 3  'set to Requested
                End If

                If myEvent.requestType = "Import" Then
                    newevent.createdSource = 2  'set to Imported
                End If


                newevent.locationID = myEvent.matchedLocationID
                newevent.marketID = a.marketID

                db.tblEvents.InsertOnSubmit(newevent)
                db.SubmitChanges()



                Dim i = (From p In db.tblBrandsInRequestedEvents Where p.requestedEventID = id Select p)
                For Each p In i
                    Dim neweventbrand As New tblBrandInEvent
                    neweventbrand.eventID = newevent.eventID
                    neweventbrand.brandID = p.brandID

                    db.tblBrandInEvents.InsertOnSubmit(neweventbrand)
                    db.SubmitChanges()

                    'append attire
                    Dim attire_Text = (From w In db.tblBrandEventExecutions Where w.brandID = p.brandID And w.eventTypeID = myEvent.eventTypeID Select w.attire).FirstOrDefault
                    Dim attireText As String = String.Format("<p><b>{0}:</b> {1}</p>", getBrandName(p.brandID), attire_Text)

                    db.UpdateEventAttireText(newevent.eventID, attireText)

                    'append posRequirement
                    Dim posRequirements_Text = (From d In db.tblBrandEventExecutions Where d.brandID = p.brandID And d.eventTypeID = myEvent.eventTypeID Select d.pos).FirstOrDefault
                    Dim posRequirementsText As String = String.Format("<p><b>{0}:</b> {1}</p>", getBrandName(p.brandID), posRequirements_Text)

                    db.UpdatePosRequirementsText(newevent.eventID, posRequirementsText)

                    'append sampling notes
                    Dim samplingNotes_Text = (From x In db.tblBrandEventExecutions Where x.brandID = p.brandID And x.eventTypeID = myEvent.eventTypeID Select x.samplingInstructions).FirstOrDefault
                    Dim samplingNotesText As String = String.Format("<p><b>{0}:</b> {1}</p>", getBrandName(p.brandID), samplingNotes_Text)

                    db.UpdateSamplingNotesText(newevent.eventID, samplingNotesText)

                Next

                'add position to event
                Dim position_ID As Integer
                Select Case myEvent.eventTypeID
                    Case "261"
                        position_ID = 1
                    Case "262"
                        position_ID = 2
                End Select

                Try
                    Dim Counter As Integer
                    For Counter = 1 To myEvent.BA_Count

                        Dim position As New tblEventStaffingRequirement
                        position.eventID = newevent.eventID

                        position.positionID = position_ID

                        position.startTime = myEvent.startTime
                        position.endTime = myEvent.endTime

                        position.rate = (From p In db.tblStaffingPositions Where p.staffingPositionID = position_ID Select p.payRate).FirstOrDefault

                        position.billingRate = (From p In db.GetBillingRateBySupplier(newevent.supplierID, newevent.eventTypeID, position_ID, newevent.marketID) Select p.billingRate).FirstOrDefault


                        If myEvent.teamID > 0 And myEvent.teamID <> 30 Then
                            position.assignedUserName = (From p In db.tblProfiles Where p.teamID = myEvent.teamID And p.IsStaff = 0 Select p.userName).FirstOrDefault

                            position.assigned = True
                        Else
                            position.assigned = False
                        End If

                        db.tblEventStaffingRequirements.InsertOnSubmit(position)
                        db.SubmitChanges()

                    Next
                Catch ex As Exception
                    Dim position As New tblEventStaffingRequirement
                    position.eventID = newevent.eventID

                    position.positionID = position_ID

                    position.startTime = myEvent.startTime
                    position.endTime = myEvent.endTime

                    position.rate = (From p In db.tblStaffingPositions Where p.staffingPositionID = position_ID Select p.payRate).FirstOrDefault

                    position.billingRate = (From p In db.GetBillingRateBySupplier(newevent.supplierID, newevent.eventTypeID, position_ID, newevent.marketID) Select p.billingRate).FirstOrDefault

                    position.assigned = False

                    If myEvent.teamID > 0 Then
                        position.assignedUserName = (From p In db.tblProfiles Where p.teamID = myEvent.teamID And p.IsStaff = 0 Select p.userName).FirstOrDefault
                    Else
                        'do nothing
                    End If

                    db.tblEventStaffingRequirements.InsertOnSubmit(position)
                    db.SubmitChanges()
                End Try




                'delete all eventCourse records
                db.deleteEventCourse(Convert.ToInt32(newevent.eventID))

                'get brands
                Dim r = From p In db.getCourseForEvents Where p.eventID = newevent.eventID Select p

                For Each p In r

                    Dim course = From l In lmsdb.Curriculums Where l.CurriculumGroupID = p.curriculum Order By l.SortOrder Select l

                    If course.Count = 0 Then

                    Else
                        For Each l In course

                            Dim newCourse As New tblEventCourse
                            newCourse.eventID = newevent.eventID
                            newCourse.CourseTitle = getBrandCourseGroupName(p.CourseTitle)

                            Dim _CurriculumLists = (From u In lmsdb.CurriculumLists Where u.CurriculumID = l.CurriculumID Select u).FirstOrDefault

                            Dim type = _CurriculumLists.ContentType
                            Dim _testID = _CurriculumLists.TestID

                            newCourse.contentID = _CurriculumLists.ContentType
                            newCourse.testID = _CurriculumLists.TestID

                            Dim icon As String = ""

                            Select Case type
                                Case "1"
                                    icon = "<i class='fa fa-file-text-o' aria-hidden='True'></i>"

                                    newCourse.icon = icon
                                    newCourse.curriculumTitle = l.CurriculumTitle
                                    newCourse.curriculumID = l.CurriculumID

                                Case "2"
                                    icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

                                    newCourse.icon = icon
                                    newCourse.curriculumTitle = l.CurriculumTitle
                                    newCourse.curriculumID = l.CurriculumID

                                Case "3"
                                    icon = "<i class='fa fa-file-video-o' aria-hidden='true'></i>"

                                    newCourse.icon = icon
                                    newCourse.curriculumTitle = l.CurriculumTitle
                                    newCourse.curriculumID = l.CurriculumID

                                Case "4"
                                    icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                                    newCourse.icon = icon
                                    newCourse.curriculumTitle = l.CurriculumTitle
                                    newCourse.curriculumID = l.CurriculumID

                                Case "5"
                                    icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                                    newCourse.icon = icon
                                    newCourse.curriculumTitle = l.CurriculumTitle
                                    newCourse.curriculumID = l.CurriculumID

                                Case "6"
                                    icon = "<i class='fa fa-file-text-o' aria-hidden='true'></i>"

                                    newCourse.icon = icon
                                    newCourse.curriculumTitle = l.CurriculumTitle
                                    newCourse.curriculumID = l.CurriculumID

                                Case "7"
                                    icon = "<i class='fa fa-check-square-o' aria-hidden='true'></i>"

                                    newCourse.icon = icon
                                    newCourse.curriculumTitle = l.CurriculumTitle
                                    newCourse.curriculumID = l.CurriculumID

                            End Select

                            db.tblEventCourses.InsertOnSubmit(newCourse)
                            db.SubmitChanges()

                        Next

                    End If


                Next

                Try
                    db.UpdateBudgetQuestionEventID(Convert.ToInt32(id), newevent.eventID)
                Catch ex As Exception

                End Try


                Dim type2 = (From p In db.tblRequestedEvents Where p.requestedEventID = id Select p).FirstOrDefault

                If type2.requestType = "Online" Then

                    Dim insertlog = db.InsertEventLog(newevent.eventID, "Event Created", "The event was created from online request type. It's was reqested by " & type2.CreatedBy & " on " & type2.CreatedDate & ".", Context.User.Identity.GetUserId(), Date.Now())

                End If


                If type2.requestType = "Import" Then

                    Dim insertlog = db.InsertEventLog(newevent.eventID, "Event Created", "The event was created from import request type. It's was imported by " & type2.CreatedBy & " on " & type2.CreatedDate & ".", Context.User.Identity.GetUserId(), Date.Now())

                End If

                Try
                    Dim result = (From p In db.qryViewEvents Where p.eventID = newevent.eventID Select p).FirstOrDefault

                    Dim xmlDoc As XDocument = XDocument.Load(Server.MapPath("\Documents\Events.xml"))

                    Dim root As New XElement("Event", New XAttribute("EventID", newevent.eventID),
                                     New XAttribute("CreatedDate", DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss")),
                                     New XAttribute("CreatedBy", Common.GetFullName(newevent.CreatedBy)),
                                     New XAttribute("Source", type2.requestType),
                                     New XElement("Details",
                                                  New XElement("EventDate", newevent.eventDate),
                                                  New XElement("EventTitle", newevent.eventTitle),
                                                  New XElement("Supplier", result.supplierName),
                                                  New XElement("Market", result.marketName),
                                                  New XElement("Brands", result.brands),
                                                  New XElement("EventType", result.eventTypeName),
                                                  New XElement("Location",
                                                               New XElement("Name", result.accountName),
                                                               New XElement("Address", result.address),
                                                               New XElement("City", result.city),
                                                               New XElement("State", result.state))
                                                               ))

                    xmlDoc.Root.Add(root)
                    xmlDoc.Save(Server.MapPath("\Documents\Events.xml"))
                Catch ex As Exception
                    ' MailHelper.SendMailMessage("no-reply@gigengyn.com", "Error adding to xml file", ex.Message())
                End Try


                'delete the event from tblRequestedEvent

                db.DeleteRequestedEvent(id, newevent.eventID)

            Next
        End If

        RequestedEventsGrid.DataBind()

    End Sub

    Function getBrandCourseGroupName(groupID As String) As String
        Return (From p In lmsdb.CurriculumGroups Where p.CurriculumGroupID = groupID Select p.Title).FirstOrDefault

    End Function

    Function getBrandName(id As Integer) As String
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function

    Function getPPS(id As Integer) As String
        Dim pps = (From p In db.tblBrands Where p.brandID = id Select p.packageSize).FirstOrDefault

        If pps = "" Then
            Return "bottles"
        Else
            Return pps & " bottles"
        End If

    End Function

    Private Sub RequestedEventsGrid_NoMatch_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RequestedEventsGrid_NoMatch.ItemCommand
        Select Case e.CommandName
            Case "ViewEvent"
                Response.Redirect("/Events/NewRequestedEvent?requestedEventID=" & e.CommandArgument)
            Case "DeleteEvent"
                db.DeleteRequestedEvent(Convert.ToInt32(e.CommandArgument), 0)

                RequestedEventsGrid_NoMatch.DataBind()
        End Select
    End Sub

    Private Sub ViewRequestedEvents_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        For Each col As GridColumn In RequestedEventsGrid.Columns
            col.ItemStyle.VerticalAlign = VerticalAlign.Top
        Next
    End Sub
End Class