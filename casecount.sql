declare	@startDate date = '7/1/2016'
declare	@endDate date = '7/31/2016'
declare	@supplierID int = 173
declare	@eventTypeID int = 261

select eventTypeRecapQuestionID, tblEventTypeRecapQuestion.eventTypeID, reportID, tblEvent.eventID, tblEventTypeRecapQuestion.question, tblEventRecapQuestions.answer, 
tblEvent.clientID, tblEvent.supplierID, tblEvent.eventDate
from tblEventTypeRecapQuestion 
join tblEventRecapQuestions on tblEventTypeRecapQuestion.eventTypeRecapQuestionID = tblEventRecapQuestions.recapQuestionID
join tblEvent on tblEventRecapQuestions.eventID = tblEvent.eventID
where reportID = 1 and tblEventRecapQuestions.answer = 'Yes'

select eventTypeRecapQuestionID, tblEventTypeRecapQuestion.eventTypeID, reportID, tblEvent.eventID, tblEventTypeRecapQuestion.question, tblEventRecapQuestions.answer,
tblEvent.clientID, tblEvent.supplierID, tblEvent.eventDate
from tblEventTypeRecapQuestion 
join tblEventRecapQuestions on tblEventTypeRecapQuestion.eventTypeRecapQuestionID = tblEventRecapQuestions.recapQuestionID
join tblEvent on tblEventRecapQuestions.eventID = tblEvent.eventID
where reportID = 2


select count(tblEvent.eventID) as 'CaseDisplays'
from tblEventTypeRecapQuestion 
join tblEventRecapQuestions on tblEventTypeRecapQuestion.eventTypeRecapQuestionID = tblEventRecapQuestions.recapQuestionID
join tblEvent on tblEventRecapQuestions.eventID = tblEvent.eventID
where reportID = 1 and tblEventRecapQuestions.answer = 'Yes' and tblEvent.supplierID = @supplierID and tblEventTypeRecapQuestion.eventTypeID = @eventTypeID and tblEvent.eventDate between @startDate and @endDate


select sum(cast(tblEventRecapQuestions.answer as int)) as 'cases'
from tblEventTypeRecapQuestion 
join tblEventRecapQuestions on tblEventTypeRecapQuestion.eventTypeRecapQuestionID = tblEventRecapQuestions.recapQuestionID
join tblEvent on tblEventRecapQuestions.eventID = tblEvent.eventID and tblEvent.supplierID = @supplierID and tblEventTypeRecapQuestion.eventTypeID = @eventTypeID and tblEvent.eventDate between @startDate and @endDate
where reportID = 2


