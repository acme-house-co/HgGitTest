declare @leadid nvarchar(20)		= '953600000000356009',
		@potentialid nvarchar(20)	= '953600000013161070',
		@contactid nvarchar(20)		= ''

select
	l.LEADID,
	coalesce(l.Prediction,'')			as Prediction,
	coalesce(l.[Property Address],'')	as PropertyAddress,
	coalesce(l.Lead,'')					as Lead,
	coalesce(l.[Lead Source],'')		as LeadSource,
	coalesce(l.[Lead Status],'')		as LeadStatus,
	coalesce(l.[First Name],'')			as FirstName,
	coalesce(l.[Last Name],'')			as LastName,
	coalesce(l.[Partner First Name],'') as PartnerFirstName,
	coalesce(l.[Partner Last Name],'')	as PartnerLastName,
	l.[Partnership Property],

	coalesce(l.Email,'')				as Email,
	coalesce(l.[Secondary Email],'')	as SecondaryEmail,
	coalesce(l.[Additional Email 1],'')	as AdditionalEmail1,
	coalesce(l.[Additional Email 2],'')	as AdditionalEmail2,
	coalesce(l.Phone,'')				as Phone,
	coalesce(l.Mobile,'')				as MobilePhone,
	
	coalesce(l.Neighborhood,'')						as Neighborhood,
	coalesce(l.Street,'')							as Street,
	coalesce(l.City,'')								as City,
	coalesce(l.State,'')							as State,
	coalesce(l.[Zip Code],'')						as Zip,

	coalesce(l.[Mailing Address],'')				as MailingAddress,
	coalesce(l.[Mailing City],'')					as MailingCity,
	coalesce(l.[Mailing State/Province],'')			as MailingState,
	coalesce(l.[Mailing Zip],'')					as MailingZip,

	coalesce(l.[Country],'')						as Country,
	coalesce(l.[Misc Country Postal Code],'')		as MiscCountryTownCity,
	coalesce(l.[Misc Country Town/City],'')			as MiscCountryPostalCode,

	coalesce(l.Tag,'') as Tag,
	coalesce(l.[Property Type],'') as PropertyType,

	coalesce(l.[Square Footage] ,0)					as SquareFootage,

	coalesce(l.Beds,0)								as NumBeds,
	coalesce(l.Baths,0)								as NumBaths,
	coalesce(l.[Half Baths],0)						as NumHalfBaths,

	l.Pool											as IsPool,
	l.Spa											as IsSpa,

	l.Garage										as IsGarage,
	l.[Covered Patio]								as IsCoveredPatio,
	l.[Fire Feature]								as IsFireFeature,
	l.Cabana										as IsCabana,
	l.[Outdoor Shower]								as IsOutdoorShower,
	l.[Outdoor Kitchen]								as IsOutdoorKitchen,
	l.[Water Features]								as IsWaterFeatures,
	l.[Pool Table]									as IsPoolTable,
	l.[Putting Green]								as IsPuttingGreen,
	coalesce(l.Casita, '')							as Casita,
	l.[Ping Pong Table]								as IsPingPongTable,
	coalesce(l.[Other Amenities], '')				as OtherAmenities,

	coalesce(l.[AirBnB Link], '')					as UrlAirBnB,
	coalesce(l.[Flipkey Link], '')					as UrlFlipkey,
	coalesce(l.[Homeaway Link], '')					as UrlHomeAway,
	coalesce(l.[TripAdvisor Link], '')				as UrlTripAdvisor,
	coalesce(l.[VacationRentals Link], '')			as UrlVacationRentals,
	coalesce(l.[VRBO Link], '')						as UrlVrbo,
	coalesce(l.[Other Listing Link], '')			as UrlOtherListing,

	l.[Projected Launch Date],
	coalesce(l.[Projected Launch Date Delay], '')	as ProjectedLaunchDateDelay,

	coalesce(l.[Currently Rented], '')				as CurrentlyRented,
	coalesce(l.[Current Annual Revenue], '')		as CurrentAnnualRevenue, 
	coalesce(l.[Currently Rented Notes], '')		as CurrentlyRentedNotes,
	coalesce(l.[Goal Revenue], 0)					as GoalRevenue,
	coalesce(l.Challenges, '')						as Challenges,
	coalesce(l.Objections, '')						as Objections,
	coalesce(l.Expectations, '')					as Expectations,
	coalesce(l.[Multiple Decision Makers], '')		as MultipleDecisionMakers,
	coalesce(l.[Retirement Plans], '')				as RetirementPlans,
	coalesce(l.Goals, '')							as Goals,
	coalesce(l.[Personal Usage], '')				as PersonalUsage,
	coalesce(l.Incentives, '')						as Incentives,
	coalesce(l.[General Notes], '')					as GeneralNotes,

	coalesce(l.Twitter, '')							as SocialTwitter,
	coalesce(l.Facebook, '')						as SocialFacebook,
	coalesce(l.[Skype ID], '')						as SocialSkype,
	coalesce(l.LinkedIn, '')						as SocialLinkedIn,
	coalesce(l.[Google+], '')						as SocialGooglePlus,

	l.[Lead Owner],
	l.[Created By],
	l.[Created Time],
	l.[Modified By],
	l.[Modified Time],
	l.[Last Activity Time]
from Leads l
where l.LEADID = @leadid

select
	p.POTENTIALID,
	coalesce(p.Prediction,'')			as Prediction,
	coalesce(p.[Account Name],'')		as AccountName,
	coalesce(p.[Potential Name],'')		as PotentialName,
	coalesce(p.[Name (F/L)],'')			as FullName,
	coalesce(p.[Partner First Name],'') as PartnerFirstName,
	coalesce(p.[Partner Last Name],'')	as PartnerLastName,
	p.[Partnership Property]			as IsPartnershipProperty,

	coalesce(p.Neighborhood,'')						as Neighborhood,
	coalesce(p.Street,'')							as Street,
	coalesce(p.City,'')								as City,
	coalesce(p.State,'')							as State,
	coalesce(p.[Zip Code],'')						as Zip,

	coalesce(p.[Mailing Address],'')				as MailingAddress,
	coalesce(p.[Mailing City],'')					as MailingCity,
	coalesce(p.[Mailing State/Province],'')			as MailingState,
	coalesce(p.[Mailing Zip],'')					as MailingZip,

	coalesce(p.[Misc Country Postal Code],'')		as MiscCountryTownCity,
	coalesce(p.[Misc Country Town/City],'')			as MiscCountryPostalCode,
	coalesce(p.[Misc Complexes],'')					as MiscComplexes,

	coalesce(p.Lead,'')								as Lead,
	coalesce(p.[Lead Source],'')					as LeadSource,
	coalesce(p.[Type],'')							as Type,

	p.Probability									as Probability,
    coalesce(p.Stage, '')							as Stage,
    coalesce(p.[Campaign Source], '')				as CampaignSource,
    p.[Closing Date]								as ClosingDate,
    coalesce(p.[Contact Name], '')					as ContactName,
    --coalesce(p.[Contact Type], '')					as ContactType,

	coalesce(p.Tag,'')								as Tag,
	coalesce(p.[Property Type],'')					as PropertyType,

	p.[Weekly Appt Date]							as WeeklyApptDate,
	coalesce(p.[Weekly Notes],'')					as WeeklyNotes,
	coalesce(p.[Next Step],'')						as NextSteps,

	coalesce(p.[Square Footage] ,0)					as SquareFootage,
	coalesce(p.Beds,0)								as NumBeds,
	coalesce(p.Baths,0)								as NumBaths,
	coalesce(p.[Half Baths],0)						as NumHalfBaths,

	coalesce(p.[Interior Bedrooms],'')		as InteriorBedrooms,
	coalesce(p.[Interior Kitchen],'')			as InteriorKitchen,
	coalesce(p.[Interior Bathrooms],'')			as InteriorBathrooms,
	coalesce(p.[Additional Interior Spaces],'')	as AdditionalInteriorSpaces,
	coalesce(p.[Exterior Additional Spaces],'')	as ExteriorAdditionalSpaces,
	coalesce(p.[Exterior Curb Appeal],'')		as ExteriorCurbAppeal,
	coalesce(p.[Exterior Pool Area],'')			as ExteriorPoolArea,
	coalesce(p.[Misc Complexes],'')				as MiscComplexes,

	coalesce(p.[Specific Needs],'')				as SpecificNeeds,
	coalesce(p.[Offered],'')					as Offered,

	p.Pool											as IsPool,
	p.Spa											as IsSpa,
	p.Garage										as IsGarage,
	p.[Pergola or Cabana]							as IsCabana,
	p.[Fire Feature]								as IsFireFeature,
	p.[Pergola or Cabana]							as IsCabana,
	p.[Outdoor Shower]								as IsOutdoorShower,
	p.[Outdoor Kitchen]								as IsOutdoorKitchen,
	p.[Water Features]								as IsWaterFeatures,
	p.[Pool Table]									as IsPoolTable,
	p.[Putting Green]								as IsPuttingGreen,
	coalesce(p.Casita, '')							as Casita,
	p.[Pool/Ping Pong Table]						as IsPingPongPoolTable,
	coalesce(p.[Other Amenities], '')				as OtherAmenities,

	coalesce(p.[AirBnB Link], '')					as UrlAirBnB,
	coalesce(p.[Flipkey Link], '')					as UrlFlipkey,
	coalesce(p.[Homeaway Link], '')					as UrlHomeAway,
	coalesce(p.[TripAdvisor Link], '')				as UrlTripAdvisor,
	coalesce(p.[VacationRentals Link], '')			as UrlVacationRentals,
	coalesce(p.[VRBO Link], '')						as UrlVrbo,
	coalesce(p.[Other Listing Link], '')			as UrlOtherListing,

	p.[Projected Launch Date],
	coalesce(p.[Projected Launch Date Delay], '')	as ProjectedLaunchDateDelay,

	coalesce(p.[Currently Rented], '')				as CurrentlyRented,
	coalesce(p.[Current Annual Revenue], '')		as CurrentAnnualRevenue, 
	coalesce(p.[Currently Rented Notes], '')		as CurrentlyRentedNotes,
	coalesce(p.[Goal Revenue], 0)					as GoalRevenue,
	coalesce(p.Challenges, '')						as Challenges,
	coalesce(p.Objections, '')						as Objections,
	coalesce(p.[Expectations/Goals], '')			as Expectations,
	coalesce(p.[Retirement Plans], '')				as RetirementPlans,
	coalesce(p.[Personal Usage], '')				as PersonalUsage,
	p.Amount,

	p.[Potential Owner],
	p.[Created By],
	p.[Created Time],
	p.[Modified By],
	p.[Modified Time],
	p.[Last Activity Time],

	coalesce(p.ACCOUNTID, '')				as ACCOUNTID,
	coalesce(p.CAMPAIGNID, '')				as CAMPAIGNID,
	coalesce(p.CONTACTID, '')				as CONTACTID

	--,p.*
from Potentials p
where p.POTENTIALID = @potentialid


select
	c.CONTACTID,
	coalesce(c.[Account Name],'')		as AccountName,
	coalesce(c.Salutation,'')			as Salutation,
	coalesce(c.[First Name],'')			as FirstName,
	coalesce(c.[Last Name],'')			as LastName,
	coalesce(c.[Partner First Name],'') as PartnerFirstName,
	coalesce(c.[Partner Last Name],'')	as PartnerLastName,
	c.[Partnership Property]			as IsPartnershipProperty,

	coalesce(c.[Vendor Name], '')					as VendorName,
    coalesce(c.[Contact Type], '')					as ContactType,

	coalesce(c.Email,'')				as Email,
	coalesce(c.[Secondary Email],'')	as SecondaryEmail,
	c.[Email Opt Out]					as IsEmailOptOut,

	coalesce(c.Phone,'')				as Phone,
	coalesce(c.Mobile,'')				as MobilePhone,
	coalesce(c.[SMS Phone],'')			as SMSPhone,
	coalesce(c.[Work Phone],'')			as WorkPhone,
	coalesce(c.[Fax],'')				as Fax,


	coalesce(c.[Mailing Address],'')				as MailingAddress,
	coalesce(c.[Mailing City],'')					as MailingCity,
	coalesce(c.[Mailing State/Province],'')			as MailingState,
	coalesce(c.[Mailing Zip],'')					as MailingZip,

	coalesce(c.[Misc Country Postal Code],'')		as MiscCountryTownCity,
	coalesce(c.[Misc Country Town/City],'')			as MiscCountryPostalCode,


	/*
	coalesce(c.Lead,'')								as Lead,
	coalesce(c.[Lead Source],'')					as LeadSource,
	coalesce(c.[Type],'')							as Type,

	c.Probability									as Probability,
    coalesce(c.Stage, '')							as Stage,
    coalesce(c.[Campaign Source], '')				as CampaignSource,
    c.[Closing Date]								as ClosingDate,
    coalesce(c.[Contact Name], '')					as ContactName,
    --coalesce(c.[Contact Type], '')					as ContactType,

	coalesce(c.Tag,'')								as Tag,
	coalesce(c.[Property Type],'')					as PropertyType,

	c.[Weekly Appt Date]							as WeeklyApptDate,
	coalesce(c.[Weekly Notes],'')					as WeeklyNotes,
	coalesce(c.[Next Step],'')						as NextSteps,

	coalesce(c.[Square Footage] ,0)					as SquareFootage,
	coalesce(c.Beds,0)								as NumBeds,
	coalesce(c.Baths,0)								as NumBaths,
	coalesce(c.[Half Baths],0)						as NumHalfBaths,

	coalesce(c.[Interior Bedrooms],'')		as InteriorBedrooms,
	coalesce(c.[Interior Kitchen],'')			as InteriorKitchen,
	coalesce(c.[Interior Bathrooms],'')			as InteriorBathrooms,
	coalesce(c.[Additional Interior Spaces],'')	as AdditionalInteriorSpaces,
	coalesce(c.[Exterior Additional Spaces],'')	as ExteriorAdditionalSpaces,
	coalesce(c.[Exterior Curb Appeal],'')		as ExteriorCurbAppeal,
	coalesce(c.[Exterior Pool Area],'')			as ExteriorPoolArea,
	coalesce(c.[Misc Complexes],'')				as MiscComplexes,

	coalesce(c.[Specific Needs],'')				as SpecificNeeds,
	coalesce(c.[Offered],'')					as Offered,

	c.Pool											as IsPool,
	c.Spa											as IsSpa,
	c.Garage										as IsGarage,
	c.[Pergola or Cabana]							as IsCabana,
	c.[Fire Feature]								as IsFireFeature,
	c.[Pergola or Cabana]							as IsCabana,
	c.[Outdoor Shower]								as IsOutdoorShower,
	c.[Outdoor Kitchen]								as IsOutdoorKitchen,
	c.[Water Features]								as IsWaterFeatures,
	c.[Pool Table]									as IsPoolTable,
	c.[Putting Green]								as IsPuttingGreen,
	coalesce(c.Casita, '')							as Casita,
	c.[Pool/Ping Pong Table]						as IsPingPongPoolTable,
	coalesce(c.[Other Amenities], '')				as OtherAmenities,

	coalesce(c.[AirBnB Link], '')					as UrlAirBnB,
	coalesce(c.[Flipkey Link], '')					as UrlFlipkey,
	coalesce(c.[Homeaway Link], '')					as UrlHomeAway,
	coalesce(c.[TripAdvisor Link], '')				as UrlTripAdvisor,
	coalesce(c.[VacationRentals Link], '')			as UrlVacationRentals,
	coalesce(c.[VRBO Link], '')						as UrlVrbo,
	coalesce(c.[Other Listing Link], '')			as UrlOtherListing,

	c.[Projected Launch Date],
	coalesce(c.[Projected Launch Date Delay], '')	as ProjectedLaunchDateDelay,

	coalesce(c.[Currently Rented], '')				as CurrentlyRented,
	coalesce(c.[Current Annual Revenue], '')		as CurrentAnnualRevenue, 
	coalesce(c.[Currently Rented Notes], '')		as CurrentlyRentedNotes,
	coalesce(c.[Goal Revenue], 0)					as GoalRevenue,
	coalesce(c.Challenges, '')						as Challenges,
	coalesce(c.Objections, '')						as Objections,
	coalesce(c.[Expectations/Goals], '')			as Expectations,
	coalesce(c.[Retirement Plans], '')				as RetirementPlans,
	coalesce(c.[Personal Usage], '')				as PersonalUsage,
	c.Amount,
	*/

	coalesce(l.Twitter, '')							as SocialTwitter,
	coalesce(l.Facebook, '')						as SocialFacebook,
	coalesce(l.[Skype ID], '')						as SocialSkype,
	coalesce(l.LinkedIn, '')						as SocialLinkedIn,
	coalesce(l.[Google+], '')						as SocialGooglePlus,


	c.[Contact Owner],
	c.[Created By],
	c.[Created Time],
	c.[Modified By],
	c.[Modified Time],
	c.[Last Activity Time],

	coalesce(c.ACCOUNTID, '')				as ACCOUNTID,
	coalesce(c.VENDORID, '')				as VENDORID,

	, c.*
from Contacts c
--where c.CONTACTID = @contactid