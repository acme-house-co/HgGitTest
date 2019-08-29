declare 
	@datestart	date		= '2019-05-01',
	@dateend	date		= '2019-05-31'

declare @tblWorkOrderIDs table (ID int)

-- initiate base of IDs
insert into @tblWorkOrderIDs (ID)
	select s.ID
	from TaskSummaries s
	where
		(s.Created >= @datestart and s.Created <= @dateend)
		or (s.Updated >= @datestart and s.Updated <= @dateend)	
		or (s.Started >= @datestart and s.Started <= @dateend)	
		or (s.Assigned >= @datestart and s.Assigned <= @dateend)	
		or (s.Completed >= @datestart and s.Completed <= @dateend)	

-- Select raw summaries
select *
from TaskSummaries s
where s.ID in (
	select ID
	from @tblWorkOrderIDs
)
	and s.TimeToComplete <> '00:00:00'
order by s.TimeToComplete

-- select Statuses
select
	s.Status,
	count(s.Status) as TotalStatus
from TaskSummaries s
where s.ID in (
	select ID
	from @tblWorkOrderIDs
)
group by s.Status
order by s.Status

-- Select Assignments
select
	s.AssignedTo,
	count(s.AssignedTo) as TotalAssigned
from TaskSummaries s
where s.ID in (
	select ID
	from @tblWorkOrderIDs
)
group by s.AssignedTo
order by s.AssignedTo

-- Select Completed by
select
	s.CompletedBy,
	count(s.CompletedBy) as TotalCompletedBy
from TaskSummaries s
where s.ID in (
	select ID
	from @tblWorkOrderIDs
)
group by s.CompletedBy
order by s.CompletedBy

-- Select Requested By
select
	s.RequestedBy,
	count(s.RequestedBy) as TotalRequestedBy
from TaskSummaries s
where s.ID in (
	select ID
	from @tblWorkOrderIDs
)
group by s.RequestedBy
order by s.RequestedBy

-- Select Created By
select
	s.CreatedBy,
	count(s.CreatedBy) as TotalCreatedBy
from TaskSummaries s
where s.ID in (
	select ID
	from @tblWorkOrderIDs
)
group by s.CreatedBy
order by s.CreatedBy


-- Calculate billable hours
declare @tblBilledHours table (AssignedTo nvarchar(500), TotalHours float, TotalMins int, TotalSecs float, RawHours int, RawMins int, RawSecs int)
insert into @tblBilledHours (AssignedTo, RawHours, RawMins, RawSecs)
	select
		--sum(substring((cast(s.TimeToComplete as time)), 0, 2)) as TotalHours

		s.CompletedBy,
		sum(cast(substring(replace(s.TimeToComplete,':',''), 0, 2) as int)) as RawHours,
		sum(cast(substring(replace(s.TimeToComplete,':',''), 2, 2) as int)) as RawMins,
		sum(cast(substring(replace(s.TimeToComplete,':',''), 4, 2) as int)) as RawSecs	
		--s.TimeToComplete,
		--count(s.TimeToComplete) as TotalTimeToComplete
	from TaskSummaries s
	where s.ID in (
		select ID
		from @tblWorkOrderIDs
	)
	group by s.CompletedBy
	order by s.CompletedBy

select
	b.AssignedTo,
	((
		b.RawSecs +
		(b.RawMins * 60) +
		(b.RawHours *60 *60) 
	) / 60 / 60 ) as TotalHours,

	(((
		(b.RawSecs) +
		(b.RawMins * 60)
	) / 60)%60 ) as TotalMins,

	(b.RawSecs%60) as TotalSecs
from @tblBilledHours b