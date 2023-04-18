/**
 *  ContactPointEmail Create/Update Mapping for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
---
/**
 * Maps CIM ContactPointEmail to JSON which is used by stored procedure - sp_ContactPointEmail_Create or sp_ContactPointEmail_Update
 * @table JSON used by the stored procedure,CIM,Default Value,Description
 * @row id,id, ,The id of the contactpoint
 * @row contactPointType,contactPointType, ,The type of contact point
 * @row activeFromDate,activeFromDate,now(),The date from which contactpoint is active
 * @row activeToDate,activeToDate, ,The date until which contactpoint is active
 * @row	bestTimeToContactEndTime,bestTimeToContactEndTime, ,The best time to contact end time
 * @row	bestTimeToContactStartTime,bestTimeToContactStartTime, ,The best time to contact start time
 * @row	createdBy,auditInfo.createdBy,p('app.name'),Identifies the system or user which created the entity
 * @row	createdDate,auditInfo.createdDate,now(),Timestamp of when the entity was created
 * @row	emailAddress,emailAddress,"",	The email address of the contactpoint 
 * @row	emailBouncedReason,emailBouncedReason, ,The reason indicating why the email bounces
 * @row	emailDomain,emailDomain, ,The domain of the email address
 * @row	emailLatestBounceDateTime,emailLatestBounceDateTime, ,Timestamp of when the email last bounced
 * @row	emailMailBox,emailMailBox, ,The email mail box to which email must be delivered
 * @row	forBusinessUse,forBusinessUse, ,Flag to indicate whether this contactpoint is used for business purpose
 * @row	forPersonalUse,forPersonalUse, ,Flag to indicate whether this contactpoint is used for personal use
 * @row	isUsedForBilling,isUsedForBilling, ,Flag to indicate whether the email address is used for billing
 * @row	isUsedForShipping,isUsedForShipping, ,Flag to indicate whether the email address is used for shipping
 * @row	name,name, ,The name of the contactpoint email address
 * @row	primaryFlag,primaryFlag, ,Flag to indicate if the email address is primary
 * @row	profileFirstCreatedDate,profileFirstCreatedDate, ,Timestamp of when the profile was first created
 * @row	profileLastUpdatedDate,profileLastUpdatedDate, ,Timestamp of when the profile was last updated
 * @row	profileOccurrenceCount,profileOccurrenceCount, ,The occurrence of profile
 * @row	updatedBy,auditInfo.updatedBy,p('app.name'),Identifies the system or user which last updated the entity
 * @row	updatedDate,auditInfo.updatedDate,now(),Timestamp of when the entity was last updated
 */
payload map(item,index) -> {
	id: item.id,
	contactPointType: item.contactPointType,
	activeFromDate: item.activeFromDate default now(),
	activeToDate: item.activeToDate,
	bestTimeToContactEndTime: item.bestTimeToContactEndTime,
	bestTimeToContactStartTime: item.bestTimeToContactStartTime,
	createdBy: item.auditInfo.createdBy default p('app.name'),
	createdDate: item.auditInfo.createdDate default now(),
	emailAddress: item.emailAddress default "",
	emailBouncedReason: item.emailBouncedReason,
	emailDomain: item.emailDomain,
	emailLatestBounceDateTime: item.emailLatestBounceDateTime,
	emailMailBox: item.emailMailBox,
	(forBusinessUse:   if(item.forBusinessUse) 1 else 0) if(!isEmpty(item.forBusinessUse)),
	(forPersonalUse:   if(item.forPersonalUse) 1 else 0) if(!isEmpty(item.forPersonalUse)),
	(isUsedForBilling:   if(item.isUsedForBilling) 1 else 0) if(!isEmpty(item.isUsedForBilling)),
	(isUsedForShipping:   if(item.isUsedForShipping) 1 else 0) if(!isEmpty(item.isUsedForShipping)),
	name: item.name,
	(primaryFlag:   if(item.primaryFlag) 1 else 0) if(!isEmpty(item.primaryFlag)),
	profileFirstCreatedDate: item.profileFirstCreatedDate,
	profileLastUpdatedDate: item.profileLastUpdatedDate,
	profileOccurrenceCount: item.profileOccurrenceCount,
	updatedBy: item.auditInfo.updatedBy default p('app.name'),
	updatedDate: item.auditInfo.updatedDate default now(),
	externalIds : item.externalIds map ((item, index) -> {
	  "id": item.id,
	  "externalId": item.externalId,
	  "externalIdType": item.externalIdType,
	  "createdBy" : item.auditInfo.createdBy default p('app.name'),
  	  "updatedBy" : item.auditInfo.updatedBy default p('app.name'),
	  "status": item.status,
	  "statusLastChangedDate": item.statusLastChangedDate})
	
}