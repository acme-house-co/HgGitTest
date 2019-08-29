use Breezeway_Dev

--/*
drop table TaskSupplies
drop table TaskCosts
drop table TaskSummaries
--drop table Properties
--drop table Owners
--drop table QuickBooksCustomers
--*/
go

create table TaskSummaries
	(
		Type nvarchar(250),
		ID int not null unique,
		Property nvarchar(250),

		PropertyID int,
		PropertyMarketingID nvarchar(10),
		PropertyInternalID int,

		Name nvarchar(250),
		Status  nvarchar(50),
		CreatedBy  nvarchar(250),
		Created datetime,
		Updated datetime,
		Started datetime,
		Assigned datetime,
		AssignedTo nvarchar(250) default(''),
		AssignedDate datetime,
		Completed datetime,
		CompletedBy nvarchar(250),
		TimeToComplete nvarchar(50) default('00:00:00'), -- time null 
		Description nvarchar(max) default(''),
		ReportSummary nvarchar(max) default(''),
		EstimateTimeToComplete nvarchar(50) default ('00:00:00'), -- time
		RatePaid float default(0),
		RateType nvarchar(250) default(''),
		TotalCost float default(0),
		CostDescription nvarchar(max) default(''),
		BillTo nvarchar(250) default(''),
		RequestedBy nvarchar(250) default(''),

		-- Custom fields
		QuickBooksCustomerID int,
		IsInvoicable as (
			cast(
				case when Status = 'approved' and Billto = 'Owner' then 1 else 0 end
			as bit)
		),
		IsLocked bit not null default(0),
		QuickBooksInvoiceNum varchar(50),
		QuickBooksInvoiceID int,
		DateQboUploaded datetime,
		SummaryID int not null identity(1000,1),
		DateImported datetime null default(getdate()),
		constraint PK_TaskSummaries_SummaryID primary key(SummaryID)
	)


create table TaskSupplies
	(
		Type nvarchar(250),
		ID int,
		Property nvarchar(250),

		PropertyID int,
		PropertyMarketingID nvarchar(10),
		PropertyInternalID int,

		Name nvarchar(250),

		Status  nvarchar(50),
		CreatedBy  nvarchar(250),
		Created datetime,
		Updated datetime,
		Started datetime,
		Assigned datetime,
		AssignedTo nvarchar(250) default(''),
		AssignedDate datetime,
		Completed datetime,
		CompletedBy nvarchar(250),
		TimeToComplete nvarchar(50) default('00:00:00'), -- time null 
		Description nvarchar(max) default(''),
		ReportSummary nvarchar(max) default(''),

		Supply nvarchar(500),
		--DescriptionDupe nvarchar(max),
		Quantity int,
		UnitCost float,
		TotalCost float,

		-- Custom fields
		IsTaxable as (
			cast(
				case when 
					Supply like '%labor%' 
					or Supply like '%service%' 
					or Supply like '%gift%' 
					or Supply like '%Vendor Access%' 
					or Supply like '%Trash Pick%Up%' 
				then 0 else 1 end
			as bit)
		),
		SupplyID int identity(1000,1),
		DateImported datetime null default(getdate()),
		constraint PK_TaskSupplies_SupplyID primary key(SupplyID),
		constraint FK_TaskSupplies_TaskSummary_ID foreign key (ID) references TaskSummaries(ID)
	)


create table TaskCosts
	(
		Type nvarchar(250),
		ID int,
		Property nvarchar(250),

		PropertyID int,
		PropertyMarketingID nvarchar(10),
		PropertyInternalID int,

		Name nvarchar(250),

		Status  nvarchar(50),
		CreatedBy  nvarchar(250),
		Created datetime,
		Updated datetime,
		Started datetime,
		Assigned datetime,
		AssignedTo nvarchar(250) default(''),
		AssignedDate datetime,
		Completed datetime,
		CompletedBy nvarchar(250),
		TimeToComplete nvarchar(50) default('00:00:00'), -- time null 
		Description nvarchar(max) default(''),
		ReportSummary nvarchar(max) default(''),

		ItemType nvarchar(250) default(''),
		ItemDescription nvarchar(max) default(''),
		ItemCost float default(0),
		BillTo nvarchar(250) default(''),

		SupplyID nvarchar(250) default(''),
		SupplyNameItemDescription nvarchar(max) default(''),
		SupplyQuantity int default(1),
		SupplyUnitCost float,

		-- duplicates
		/*
		SupplyID_Dupe1 nvarchar(250) default(''),
		SupplyNameItemDescription_Dupe1 nvarchar(max) default(''),
		SupplyQuantity_Dupe1 int,
		SupplyUnitCost_Dupe1 float,

		SupplyID_Dupe2 nvarchar(250) default(''),
		SupplyNameItemDescription_Dupe2 nvarchar(max) default(''),
		SupplyQuantity_Dupe2 int,
		SupplyUnitCost_Dupe2 float,
		*/
		-- end duplicates

		-- Custom fields
		ItemTotal as (
			case when 
				[ItemType]='supply' and  
				[SupplyNameItemDescription] not like '%gift%' and 
				[ItemDescription] not like '%gift%' 
			then 
				[SupplyUnitCost] 
			else 
				[ItemCost]*(1.25)
			end
		),
		LineTotal as (
			case when 
				[ItemType]='supply' and  
				[SupplyNameItemDescription] not like '%gift%' and 
				[ItemDescription] not like '%gift%' 
			then 
				[SupplyUnitCost] 
			else 
				[ItemCost]*(1.25)
			end
			* SupplyQuantity
		),
		--IsTaxable bit default(1),
		IsTaxable as (
			cast(
				case when 
					SupplyNameItemDescription like '%labor%' 
					or SupplyNameItemDescription like '%service%' 
					or SupplyNameItemDescription like '%gift%' 
					or SupplyNameItemDescription like '%Vendor Access%' 
					or SupplyNameItemDescription like '%Trash Pick%Up%' 

					or ItemDescription like '%labor%' 
					or ItemDescription like '%service%' 
					or ItemDescription like '%gift%' 
					or ItemDescription like '%Vendor Access%' 
					or ItemDescription like '%Trash Pick%Up%' 

				then 0 else 1 end
			as bit)
		),
		CostID int identity(1000,1),
		DateImported datetime null default(getdate()),
		constraint PK_TaskCost_CostID primary key(CostID),
		constraint FK_TaskCost_TaskSummary_ID foreign key (ID) references TaskSummaries(ID)
	)
/*
create table Properties
	(
		BwPropertyID int unique,
		EscapiaID int default(0),
		UnitCode nvarchar(10) default(''),
		PropertyName nvarchar(250),
		Address1 nvarchar(250),
		Address2 nvarchar(250) default(''),
		City nvarchar(250),
		State nvarchar(250),
		ZipCode nvarchar(50),
		-- Custom fields
		UnitID int identity(1000,1),
		constraint PK_Properties_UnitID primary key(UnitID)
	)

create table Owners
	(
		textbox4 nvarchar(250) default(''),
		UnitCode nvarchar(10) default(''),
		Name nvarchar(500) default(''),
		Address1 nvarchar(250) default(''),
		City nvarchar(250) default(''),
		State nvarchar(50) default(''),
		ZipCode nvarchar(10) default(''),
		Phone1 nvarchar(25) default(''),
		FirstName nvarchar(500) default(''),
		Email nvarchar(250) default(''),
		-- Custom Fields
		PropertyID int,
		IsActive bit default(1),
		QuickBooksID int,
		OwnerID int not null identity(1000,1),
		constraint PK_Owners_OwnerID primary key(OwnerID)
	)
*/

/*
create table QuickBooksCustomers
	(
		QboID int identity,
		ID int,
		IsActive bit,
		Title nvarchar(15) default(''),
		FirstName nvarchar(25) default(''),
		MiddleName nvarchar(25) default(''),
		LastName nvarchar(25) default(''),
		FullyQualifiedName nvarchar(1000) default(''),
		CompanyName nvarchar(50) default(''),
		DisplayName nvarchar(100) default(''),
		PrimaryPhone nvarchar(21) default(''),
		AlertnatePhone nvarchar(21) default(''),
		MobilePhone nvarchar(21) default(''),
		Email nvarchar(100) default(''),
		Notes nvarchar(max) default(''),
		constraint PK_QuickBooksCustomers_QboID primary key(QboID)
	)
*/


/*
alter table TaskCosts
drop column IsTaxable

alter table TaskCosts
add IsTaxable as (
			cast(
				case when 
					SupplyNameItemDescription like '%labor%' 
					or SupplyNameItemDescription like '%service%' 
					or SupplyNameItemDescription like '%gift%' 
					or SupplyNameItemDescription like '%Vendor Access%' 
					or SupplyNameItemDescription like '%Trash Pick%Up%' 

					or ItemDescription like '%labor%' 
					or ItemDescription like '%service%' 
					or ItemDescription like '%gift%' 
					or ItemDescription like '%Vendor Access%' 
					or ItemDescription like '%Trash Pick%Up%' 

				then 0 else 1 end
			as bit)
		);
go

alter table TaskSupplies
drop column IsTaxable

alter table TaskSupplies
add IsTaxable as (
			cast(
				case when 
					Supply like '%labor%' 
					or Supply like '%service%' 
					or Supply like '%gift%' 
					or Supply like '%Vendor Access%' 
					or Supply like '%Trash Pick%Up%' 
				then 0 else 1 end
			as bit)
		);
go
--*/