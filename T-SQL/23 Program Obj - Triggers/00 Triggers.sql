USE TSQLV4
GO


select 1
declare @eventdata XML = EVENTDATA()

select @eventdata