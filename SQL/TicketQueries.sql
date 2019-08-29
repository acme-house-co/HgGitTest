declare @userid int = 10


-- ticket status
select
	s.ticketstatusid			as StatusID,
	s.englishname				as Status,
	count(t.ticketstatusid)		as TicketCount
from st_ticketstatuses s
	left join st_tickets t on t.ticketstatusid = s.ticketstatusid 
where t.userid = @userid
	or t.userid_customer = @userid
group by s.ticketstatusid, s.englishname, t.ticketstatusid

-- ticket history
select
	t.ticketid,
	t.ticketpriorityid,
	p.englishname		as Priority,
	t.ticketstatusid,
	s.englishname		as Status,
	t.departmentid,
	d.displayname		as Department,
	t.subject,

	t.dateopenedutc		as DateOpened,
	t.datefollowuputc	as DateFollowup,
	t.dateclosedutc		as dateclosed,

	cast(case when exists (select a.ticketattachmentid from st_ticketattachments a where a.ticketid = t.Ticketid) then 1 else 0 end as bit) as HasAttachment
from st_tickets t
	left join st_ticketpriorities p on p.ticketpriorityid = t.ticketpriorityid
	left join st_ticketstatuses s on s.ticketstatusid = t.ticketstatusid
	left join st_departments d on d.departmentid = t.departmentid
where t.userid = @userid or t.userid_customer = @userid


-- badge count
declare @datelastlogin datetime = '2019-03-28 16:45'
select
	count(m.ticketmessageid) as MessageCount
from st_ticketmessages m
	left join st_tickets t on t.ticketid = m.ticketid and (t.userid = @userid or t.userid_customer = @userid)
where m.datereceivedutc >= @datelastlogin

-- Ticket
declare @ticketid int = 30
select t.ticketid
	 , t.ticketpriorityid
	 , p.englishname as priority
	 , t.ticketstatusid
	 , s.englishname as status
	 , t.departmentid
	 , d.displayname as department
	 , t.subject
	 , t.dateopenedutc as dateopened
	 , t.datefollowuputc as datefollowup
	 , t.dateclosedutc as dateclosed
	 , cast(case
		   when exists (
				   select a.ticketattachmentid
				   from st_ticketattachments a
				   where a.ticketid = t.ticketid
			   ) then 1
		   else 0
	   end as bit) as hasattachment
from st_tickets t
	left join st_ticketpriorities p on p.ticketpriorityid = t.ticketpriorityid
	left join st_ticketstatuses s on s.ticketstatusid = t.ticketstatusid
	left join st_departments d on d.departmentid = t.departmentid
where t.ticketid = @ticketid
	and (t.userid = @userid	or t.userid_customer = @userid)

select 
	m.ticketmessageid,
	cast(case when m.userid_from = @userid then 1 else 0 end as bit) as IsMe,
	m.userid_from		as userid,
	u.displayname,
	m.subject,
	m.bodyhtml			as body,
	m.datereceivedutc as datesent
from st_ticketmessages m
	left join st_users u on u.userid = m.userid_from
where m.ticketid = @ticketid
order by m.datereceivedutc desc

select
	a.ticketattachmentid		as AttachmentID,
	cast(case when a.userid = @userid then 1 else 0 end as bit) as IsMe,
	a.userid,
	u.displayname,
	a.filenameoriginal,
	a.filenameondisk,
	a.creationdateutc			as DateUploaded
from st_ticketattachments a
	left join st_users u on u.userid = a.userid
where a.ticketid = @ticketid and a.isdeleted = 0
