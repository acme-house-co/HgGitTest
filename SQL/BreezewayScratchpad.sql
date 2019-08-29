/*
truncate table TaskCosts
truncate table TaskSupplies
truncate table TaskSummaries
truncate table Properties
truncate table Owners
truncate table QuickBooksCustomers
*/

/*
update TaskSummaries
set PropertyID = (
		select p.EscapiaID
		from Properties p
		where p.PropertyName = Property
	)

update Owners
set IsActive = (
		case when UnitCode like '%*%' then 0 else IsActive end
	),
	UnitCode = replace(replace(UnitCode, ' ', ''), '*', ''),
	PropertyID = (
		select p.EscapiaID
		from Properties p
		where p.UnitCode = Owners.UnitCode
	)

update Owners 
set QuickBooksID = (
		select qbc.ID
		from QuickBooksCustomers qbc
		where qbc.DisplayName like '%(' + UnitCode + ')%'
	)
where IsActive = 1
*/

select * 
from Owners o 
--where --o.IsActive = 1 --and o.QuickBooksID is null
	 --o.UnitCode = 'olp#16' or o.PropertyID is null
	/*
	and o.PropertyID in (
		select s.PropertyID
		from TaskSummaries s
		where s.IsInvoicable = 1
			and (
			s.PropertyID = 0 or s.PropertyID is null or s.QuickBooksCustomerID is null
			)
	)
	*/
where o.QuickBooksID is null
--where o.UnitCode = 'pd1733'
order by o.UnitCode

select * from Properties p 
--where p.UnitCode = 'olp#16'
--where p.UnitCode = 'pd1733'
order by p.UnitCode


select * 
from TaskSummaries s 
	where s.IsInvoicable = 1
		and (
			s.PropertyID = 0 or s.PropertyID is null
			or s.QuickBooksCustomerID is null
			or s.QuickBooksCustomerID = 294
		)
--where s.QuickBooksCustomerID = 294
--where s.Status = 'Approved'
--where s.PropertyID is null
order by s.Property

select * from TaskSupplies ts
select * from TaskCosts tc

select * from QuickBooksCustomers qbc 
where qbc.DisplayName like '%MID#602%'
order by qbc.DisplayName


select *
from Owners o
where o.IsActive = 1
/*
where o.PropertyID in (
		select ts.PropertyID
		from TaskSummaries ts
	)
	and o.QuickBooksID is null
	*/


	/*
	select count(o.OwnerID), o.QuickBooksID, o.PropertyID, ts.PropertyID
	from Owners o
		left join TaskSummaries ts on ts.PropertyID = o.PropertyID
	where o.PropertyID is not null --and ts.PropertyID = 150078
	group by o.QuickBooksID, o.PropertyID, ts.PropertyID
	having count(o.OwnerID) > 1


		select count(o.OwnerID), o.QuickBooksID
			 , o.PropertyID
			 , ts.PropertyID
		from Owners o
			left join TaskSummaries ts on ts.PropertyID = o.PropertyID
		--where ts.PropertyID = 150078
		group by o.QuickBooksID
			   , o.PropertyID
			   , ts.PropertyID
		having count(o.OwnerID) > 1
		order by o.PropertyID

		*/

select 
	count(w.ID),
	w.PropertyID,
	o.UnitCode,
	qb.DisplayName
from TaskSummaries w
	left join TaskSupplies s on s.ID = w.ID
	left join TaskCosts c on c.ID = w.ID
	left join Owners o on o.PropertyID = w.PropertyID
	left join QuickBooksCustomers qb on qb.ID = o.QuickBooksID
where w.IsInvoicable = 1
	and (
		s.IsTaxable = 1
		or c.IsTaxable = 1
	)
group by w.ID,
	w.PropertyID,
	qb.DisplayName,
	o.UnitCode



select *
from QuickBooksCustomers qbc
order by qbc.FirstName

select 
	p.PropertyID				as PMSID,
	coalesce(p.UnitCode, '')		as UnitCode,
	coalesce(p.Name, '')			as Name,
	coalesce(p.Address1, '')		as Address1,
	coalesce(p.Address2,'')		as Address2,
	coalesce(p.City, '')		as City,
	coalesce(p.Province, '')		as State,
	coalesce(p.Status,'')		as Status,
	p.UnitID
from Properties p
order by p.Address1, p.Name

/*
select
	ts.ID,
	cast(isnull(ts.TimeToComplete, '00:00:00') as time(0)) as TimeToComplete
from TaskSummaries ts

select
	ID,
	count(ts.ID)
from TaskSummaries ts
group by ts.ID
having count(ts.ID) > 1
*/

/*
update TaskSummaries
set PropertyID = null


update TaskSummaries
set PropertyID = (
	select top(1) p.PropertyID
	from Properties p
	where 
		TaskSummaries.PropertyID is null
		and (
			dbo.fnAddressStrip(TaskSummaries.Property) like '%' + dbo.fnAddressStrip(p.Name) + '%'
			or dbo.fnAddressStrip(TaskSummaries.Property) like '%' + dbo.fnAddressStrip(p.Address1) + '%'
		)
)
update TaskSummaries
set PropertyID = (
	select top(1) p.PropertyID
	from Properties p
	where 
		TaskSummaries.PropertyID is null
		and (
		dbo.fnAddressStrip(p.Name) like '%' + dbo.fnAddressStrip(TaskSummaries.Property) + '%'
		or dbo.fnAddressStrip(p.Address1) like '%' + dbo.fnAddressStrip(TaskSummaries.Property) + '%'
		)
)
*/


select 
	ts.Property,
	ts.PropertyID,
	p.UnitCode,
	p.Name,
	p.Address1
from TaskSummaries ts
	left join Properties p on p.PropertyID = ts.PropertyID
where ts.PropertyID is null
group by ts.Property, ts.PropertyID, p.UnitCode, p.Name, p.Address1
order by p.Name

select 
	--dbo.fnAddressStrip(p.Name),
	--dbo.fnAddressStrip(p.Address1),
	*
from Properties p
where p.PropertyID not in (
		select ts.PropertyID
		from TaskSummaries ts
		where ts.PropertyID is not null
	)
order by p.Name





select count(ts.SummaryID) as NullPropertyID
from TaskSummaries ts
where ts.PropertyID is null
	and ts.Status = 'approved'

select count(ts.SummaryID) as NOTNullPropertyID
from TaskSummaries ts
where ts.PropertyID is not null	
	and ts.Status = 'approved'

select
	dbo.fnAddressStrip(ts.Property),
	ts.PropertyID
from TaskSummaries ts
order by ts.Property

select
	p.PropertyID,
	dbo.fnAddressStrip(p.Name),
	dbo.fnAddressStrip(p.Address1)
from Properties p
order by p.Address1


declare @tblprops table (ID int, Property nvarchar(250), PropertyID int, Status nvarchar(50))
insert into @tblprops
	select
		ts.ID,
		ts.Property,
		p.EscapiaID,
		ts.Status
	from TaskSummaries ts
		left join Properties p on 
			dbo.fnAddressStrip(ts.Property) = dbo.fnAddressStrip(p.PropertyName) 
			or dbo.fnAddressStrip(ts.Property) = dbo.fnAddressStrip(p.Address1)
	where ts.Status = 'approved'

select count(ts.SummaryID) as 'Not Null'
from TaskSummaries ts
where ts.Status = 'approved'
	and ts.PropertyID is not null

select count(ts.SummaryID) as 'Null'
from TaskSummaries ts
where ts.Status = 'approved'
	and ts.PropertyID is null

select count(p.PropertyID)
from @tblprops p
where p.PropertyID is not null

select count(p.PropertyID)
from @tblprops p
where p.PropertyID is  null