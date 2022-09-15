
Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI

Public Class NeedRecapControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext
    Dim eventID As Integer
    Dim eventTypeID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub NeedsRecapEventsList_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles NeedsRecapEventsList.ItemCommand

        Dim manager = New UserManager()
        Dim currentUser = manager.FindById(Context.User.Identity.GetUserId())

        Dim lmsdb As New LMSDataClassesDataContext

        If e.CommandName = "StartRecap" Then

            Dim order As Integer
            Dim eventID = Convert.ToInt32(e.CommandArgument)

            Dim s = (From p In db.tblEvents Where p.eventID = eventID Select p.recapStatus).FirstOrDefault

            Select Case s
                Case "0"
                    'first delete any recap questions that might exist
                    db.DeleteAllEventRecapQuestions(eventID)


                    'create the recap questions

                    ' 1. get the selected brands
                    Dim brandlist = From y In db.tblBrandInEvents Where y.eventID = eventID Select y
                    For Each y In brandlist

                        order = 0

                        ' get the default recap questions for each brand
                        Dim a = From p In db.tblDefaultRecapQuestions Select p Order By p.QuestionID
                        For Each p In a

                            Dim recap0 As New tblEventRecapQuestion
                            recap0.eventID = eventID
                            recap0.brandID = y.brandID
                            Dim q1 As String = Replace(p.Question, "[BrandName]", getBrandName(y.brandID))
                            recap0.question = Replace(q1, "[PPS]", getPPS(y.brandID))
                            recap0.questionType = p.QuestionType
                            recap0.recapID = 0
                            recap0.recapQuestionID = p.QuestionID
                            recap0.sortorder = order + 1
                            recap0.createdBy = currentUser.Id
                            recap0.createdDate = Date.Now()
                            recap0.description = "" ' there is not a description column
                            recap0.required = False
                            recap0.digit = 0
                            recap0.numberDecimalPlace = 0
                            recap0.showPercentage = False
                            recap0.dateDefaultValue = "None"
                            recap0.displayOption = ""
                            recap0.lines = 1
                            recap0.yes_noDefaultValue = "No"
                            recap0.dateFormat = ""
                            recap0.dateDisplay = ""

                            If p.QuestionType = "currency" Then
                                recap0.answer = 0
                            End If

                            db.tblEventRecapQuestions.InsertOnSubmit(recap0)
                            db.SubmitChanges()

                        Next

                        ' 2.  get the custom brand questions for each brand
                        Dim r = From p In db.tblBrandRecapQuestions Where p.brandID = y.brandID
                        For Each p In r

                            Dim recap1 As New tblEventRecapQuestion
                            recap1.eventID = eventID
                            recap1.brandID = y.brandID
                            recap1.question = p.question
                            recap1.questionType = p.questionType
                            recap1.recapID = 1
                            recap1.recapQuestionID = p.brandRecapQuestionID
                            recap1.sortorder = order + 1
                            recap1.description = p.description
                            recap1.displayOption = p.displayOption
                            recap1.lines = p.lines
                            recap1.yes_noDefaultValue = p.yes_noDefaultValue
                            recap1.numberDecimalPlace = p.numberDecimalPlace
                            recap1.numberDefaultValue = p.numberDefaultValue
                            recap1.showPercentage = p.showPercentage
                            recap1.dateFormat = p.dateFormat
                            recap1.dateDefaultValue = p.dateDefaultValue
                            recap1.timeFormat = p.timeFormat
                            recap1.dateDisplay = p.dateDisplay
                            recap1.required = p.required
                            recap1.digit = p.numberDecimalPlace
                            recap1.createdBy = currentUser.Id
                            recap1.createdDate = Date.Now()

                            If p.questionType = "choice" Then
                                recap1.displayOption = p.displayOption
                                If p.displayOption = "check" Then
                                    recap1.answer = ""
                                End If

                            Else
                                recap1.displayOption = ""
                            End If

                            If p.questionType = "currency" Then
                                recap1.answer = 0
                            End If

                            If p.questionType = "number" Then
                                recap1.answer = p.numberDefaultValue
                            End If

                            db.tblEventRecapQuestions.InsertOnSubmit(recap1)
                            db.SubmitChanges()
                        Next

                    Next

                    Dim CurrentClientID = (From p In db.tblEvents Where p.eventID = eventID Select p.clientID).FirstOrDefault
                    'end the loop through the brands

                    'get the eventtype
                    Dim typeid = (From p In db.tblEvents Where p.eventID = eventID And p.clientID = CurrentClientID Select p.eventTypeID).FirstOrDefault

                    ' 3. add eventtype recap questions
                    Dim i = From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = typeid And p.clientID = CurrentClientID Order By p.sortorder Select p
                    For Each p In i
                        Dim recap3 As New tblEventRecapQuestion
                        recap3.eventID = eventID
                        recap3.question = p.question
                        recap3.questionType = p.questionType
                        recap3.recapID = 2
                        recap3.recapQuestionID = p.eventTypeRecapQuestionID
                        recap3.sortorder = p.sortorder
                        recap3.description = p.description
                        recap3.displayOption = p.displayOption
                        recap3.lines = p.lines
                        recap3.yes_noDefaultValue = p.yes_noDefaultValue
                        recap3.numberDecimalPlace = p.numberDecimalPlace
                        recap3.numberDefaultValue = p.numberDefaultValue
                        recap3.showPercentage = p.showPercentage
                        recap3.dateFormat = p.dateFormat
                        recap3.dateDefaultValue = p.dateDefaultValue
                        recap3.timeFormat = p.timeFormat
                        recap3.dateDisplay = p.dateDisplay
                        recap3.required = p.required
                        recap3.digit = p.numberDecimalPlace
                        recap3.createdBy = currentUser.Id
                        recap3.createdDate = Date.Now()


                        If p.questionType = "choice" Then
                            recap3.displayOption = p.displayOption
                            If p.displayOption = "check" Then
                                recap3.answer = ""
                            End If

                        Else
                            recap3.displayOption = ""
                        End If

                        If p.questionType = "currency" Then
                            recap3.answer = 0
                        End If

                        If p.questionType = "number" Then
                            recap3.answer = p.numberDefaultValue
                        End If


                        db.tblEventRecapQuestions.InsertOnSubmit(recap3)
                        db.SubmitChanges()
                    Next

                    'add to history log
                    lmsdb.InsertHistoryLog(Context.User.Identity.GetUserId(), eventID, Date.Now(), "Recap Created", "", Request.ServerVariables("REMOTE_ADDR"), Request.UserAgent.ToString().ToLower(), Request.Url.PathAndQuery)

                    Response.Redirect("/ambassadors/EventRecap?EventID=" & eventID)

                Case "1"
                    Response.Redirect("/ambassadors/EventRecap?EventID=" & eventID)
            End Select

        End If


    End Sub

    Function getPPS(id As Integer) As String
        Dim pps = (From p In db.tblBrands Where p.brandID = id Select p.packageSize).FirstOrDefault

        If pps = "" Then
            Return "bottles"
        Else
            Return pps & " bottles"
        End If

    End Function

    Function getBrandName(id As Integer) As String
        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault
    End Function

    Private Sub NeedsRecapEventsList_ItemDataBound(sender As Object, e As RadListViewItemEventArgs) Handles NeedsRecapEventsList.ItemDataBound

        'Dim manager = New UserManager()
        'Dim currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId())

        'If e.Item.ItemType = ListViewItemType.DataItem Or e.Item.ItemType = RadListViewItemType.AlternatingItem Then

        '    If manager.IsInRole(currentUser.Id, "Student") Then
        '        Dim btnRecap As Button = CType(e.Item.FindControl("btnRecap"), Button)
        '        Dim AccountNameLabel As Label = CType(e.Item.FindControl("AccountNameLabel"), Label)
        '        btnRecap.Visible = True
        '        AccountNameLabel.Visible = True
        '    End If

        '    If manager.IsInRole(currentUser.Id, "Agency") Then
        '        Dim btnRecap As Button = CType(e.Item.FindControl("btnRecap"), Button)
        '        Dim AccountNameLabel As Label = CType(e.Item.FindControl("AccountNameLabel"), Label)
        '        btnRecap.Visible = False
        '        AccountNameLabel.Visible = True
        '    End If

        '    If manager.IsInRole(currentUser.Id, "Client") Then
        '        Dim btnRecap As Button = CType(e.Item.FindControl("btnRecap"), Button)
        '        Dim AccountNameLabel As Label = CType(e.Item.FindControl("AccountNameLabel"), Label)
        '        AccountNameLabel.Visible = True
        '        btnRecap.Visible = False
        '    End If



        '    'AccountNameHyperLink

        '    If manager.IsInRole(currentUser.Id, "Administrator") Then
        '        Dim AccountNameHyperLink As HyperLink = CType(e.Item.FindControl("AccountNameHyperLink"), HyperLink)
        '        AccountNameHyperLink.Visible = True
        '    End If

        '    If manager.IsInRole(currentUser.Id, "EventManager") Then
        '        Dim AccountNameHyperLink As HyperLink = CType(e.Item.FindControl("AccountNameHyperLink"), HyperLink)
        '        AccountNameHyperLink.Visible = True
        '    End If

        '    If manager.IsInRole(currentUser.Id, "Recruiter/Booking") Then
        '        Dim AccountNameHyperLink As HyperLink = CType(e.Item.FindControl("AccountNameHyperLink"), HyperLink)
        '        AccountNameHyperLink.Visible = True
        '    End If

        '    If manager.IsInRole(currentUser.Id, "Accounting") Then
        '        Dim AccountNameHyperLink As HyperLink = CType(e.Item.FindControl("AccountNameHyperLink"), HyperLink)
        '        AccountNameHyperLink.Visible = True
        '    End If

        'End If

    End Sub
End Class