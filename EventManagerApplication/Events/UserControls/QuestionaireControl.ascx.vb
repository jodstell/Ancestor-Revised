Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI

Public Class QuestionaireControl
    Inherits System.Web.UI.UserControl
    Dim db As New DataClassesDataContext
    Dim ClientID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim _eventTypeID = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p.eventTypeID).FirstOrDefault
        HiddenEventTypeID.Value = _eventTypeID

        Dim thisEvent = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault

        ClientID = thisEvent.clientID

        'Dim EventTypeRecapHeaderLabel As Label = CType(EventRecapQuestions.FindControl("EventTypeRecapHeaderLabel"), Label)
        'EventTypeRecapHeaderLabel.Text = (From p In db.tblEventTypes Where p.eventTypeID = _eventTypeID Select p.eventTypeName).FirstOrDefault & " Event Details"

        Dim NeedRefresh = thisEvent.Modified

        If NeedRefresh = True Then
            'delete recap questions from temp list
            db.DeleteTempEventRecapQuestion(Convert.ToInt32(Request.QueryString("ID")))

            'add recap questions to temp list
            bindRecapQuestions()

            Dim NeedRefresh2 = (From p In db.tblEvents Where p.eventID = Request.QueryString("ID") Select p).FirstOrDefault
            NeedRefresh2.Modified = False
            db.SubmitChanges()
        End If

        'get the status of the recap
        Dim hasRecap = thisEvent.recapStatus
        If hasRecap <> 0 Then

            RadListView1.DataSource = getBrandList2
            RadListView1.DataBind()

            EventRecapQuestions.DataSource = getEventRecapQuestions
            EventRecapQuestions.DataBind()

        Else
            RadListView1.DataSource = getBrandList
            RadListView1.DataBind()

            EventRecapQuestions.DataSource = getTempEventRecapQuestions
            EventRecapQuestions.DataBind()

        End If


    End Sub

    Function getTitleLabel() As String

        Return (From p In db.tblEventTypes Where p.eventTypeID = HiddenEventTypeID.Value Select p.eventTypeName).FirstOrDefault & " Event Details"
    End Function
    Sub bindRecapQuestions()

        Dim order As Integer = 0
        Dim eventID = Request.QueryString("ID")
        Dim eventypeID = (From p In db.tblEvents Where p.eventID = eventID Select p.eventTypeID).FirstOrDefault

        Dim m = From e In db.tblBrandInEvents Where e.eventID = Request.QueryString("ID") Select e
        For Each e In m
            'get the default recap questions for each brand
            Dim a = From p In db.tblDefaultRecapQuestions Select p Order By p.QuestionID
            For Each p In a

                Dim recap0 As New tempEventRecapQuestion
                recap0.eventID = eventID
                recap0.brandID = e.brandID
                Dim q1 As String = Replace(p.Question, "[BrandName]", getBrandNameForRecap(e.brandID))
                recap0.question = Replace(q1, "[PPS]", getPPS(e.brandID))
                recap0.questionType = p.QuestionType
                recap0.recapID = 0
                recap0.recapQuestionID = p.QuestionID
                recap0.sortorder = order + 1

                db.tempEventRecapQuestions.InsertOnSubmit(recap0)
                db.SubmitChanges()

            Next

            'add brand recap questions
            Dim r = From p In db.tblBrandRecapQuestions Where p.brandID = e.brandID Order By p.sortOrder
            For Each p In r

                Dim recap1 As New tempEventRecapQuestion
                recap1.eventID = eventID
                recap1.brandID = e.brandID
                recap1.question = p.question
                recap1.questionType = p.questionType
                recap1.recapID = 1
                recap1.recapQuestionID = p.brandRecapQuestionID
                recap1.sortorder = order + 1

                db.tempEventRecapQuestions.InsertOnSubmit(recap1)
                db.SubmitChanges()
            Next

            'Next
        Next

        'add event type questions
        Dim i = From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = eventypeID And p.clientID = ClientID Order By p.sortorder Select p
        For Each p In i
            Dim recap3 As New tempEventRecapQuestion
            recap3.eventID = eventID
            If p.questionType = "label" Then
                recap3.question = String.Format("<h3>{0}</h3>", p.question)
            Else
                recap3.question = p.question
            End If
            recap3.question = p.question
            recap3.questionType = p.questionType
            recap3.recapID = 2
            recap3.recapQuestionID = p.eventTypeRecapQuestionID
            recap3.sortorder = p.sortorder

            db.tempEventRecapQuestions.InsertOnSubmit(recap3)
            db.SubmitChanges()
        Next

    End Sub

    Function getQuestionFormat(type As String) As String
        If type = "label" Then
            Return "headerLabel"
        Else
            Return ""
        End If
    End Function

    Function getAnswerFormat(type As String) As String
        If type = "label" Then
            Return ""
        Else
            Return "active"
        End If
    End Function

    Function getPPS(id As Integer) As String
        Dim pps = (From p In db.tblBrands Where p.brandID = id Select p.packageSize).FirstOrDefault

        If pps = "" Then
            Return "bottles"
        Else
            Return pps & " bottles"
        End If

    End Function

    Function getBrandNameForRecap(id As Integer) As String

        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault & " "
    End Function

    Function getBrandName(id As Integer) As String

        Return (From p In db.tblBrands Where p.brandID = id Select p.brandName).FirstOrDefault & " Brand Recap"
    End Function

    Private Sub btnRebuildEventTypeRecap_Click(sender As Object, e As EventArgs) Handles btnRebuildEventTypeRecap.Click
        Dim order As Integer = 0


        ' delete the current questions
        Dim d = db.DeleteEventRecapQuestionsByEvent(Convert.ToInt32(Request.QueryString("ID")), 2)

        'add eventtype recap questions
        Dim i = From p In db.tblEventTypeRecapQuestions Where p.eventTypeID = HiddenEventTypeID.Value Select p
        For Each p In i
            Dim recap3 As New tblEventRecapQuestion
            recap3.eventID = Request.QueryString("ID")
            recap3.question = p.question
            recap3.questionType = p.questionType
            recap3.recapID = 2
            recap3.recapQuestionID = p.eventTypeRecapQuestionID
            recap3.sortorder = order + 1

            db.tblEventRecapQuestions.InsertOnSubmit(recap3)
            db.SubmitChanges()
        Next

        EventRecapQuestions.DataBind()

    End Sub
End Class