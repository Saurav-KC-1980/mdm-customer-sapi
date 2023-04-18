/**
 *  ContactPointPhone Create/Update Mapping for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
---
/**
 * Maps CIM ContactPointPhone to JSON which is used by stored procedure - sp_ContactPointPhone_Create or sp_ContactPointPhone_Uopdate
 * @table JSON used by the stored procedure,CIM,Default Value,Description
 * @row id,id, ,The id of the contactpoint
 * @row contactPointType,contactPointType, ,The type of contact point
 * @row activeFromDate,activeFromDate,now(),The date from which contactpoint is active
 * @row activeToDate,activeToDate, ,The date until which contactpoint is active
 * @row areaCode,areaCode, ,The area code of the contactpoint
 * @row bestTimeToContactEndTime,bestTimeToContactEndTime, ,The best time to contact end time
 * @row bestTimeToContactStartTime,bestTimeToContactStartTime, ,The best time to contact start time
 * @row countryName,countryName, ,The country name of the contact point phone
 * @row createdBy,auditInfo.createdBy,p('app.name'),Identifies the system or user which created the entity
 * @row createdDate,auditInfo.createdDate,now(),Timestamp of when the entity was created
 * @row extensionNumber,extensionNumber, ,The extension number of the contactpoint phone
 * @row formattedE164PhoneNumber,formattedE164PhoneNumber, ,The formatted E164 phone number
 * @row formattedInternationalPhoneNumber,formattedInternationalPhoneNumber, ,The formatted international phone number
 * @row formattedNationalPhoneNumber,formattedNationalPhoneNumber,"000-000-0000",The formatted national phone number
 * @row forBusinessUse,forBusinessUse, ,Flag to inidicate whether this contactpoint is used for business purpose
 * @row forPersonalUse,forPersonalUse, ,Flag to inidicate whether this contactpoint is used for personal use
 * @row isFaxCapable,isFaxCapable, ,Flag to indicate whether the contactpoint phone is fax capable
 * @row isSMSCapable,isSMSCapable, ,Flag to indicate whether the contactpoint phone is sms capable
 * @row name,name, ,The name of the contactpoint phone
 * @row phoneCountryCode,phoneCountryCode, ,The country code of the contactpoint phone
 * @row primaryFlag,primaryFlag, ,Flag to indicate if the phone is primary
 * @row primaryPhoneType,primaryPhoneType, ,The type of primary phone
 * @row profileFirstCreatedDate,profileFirstCreatedDate, ,Timestamp of when the profile was first created
 * @row profileLastUpdatedDate,profileLastUpdatedDate, ,Timestamp of when the profile was last updated
 * @row profileOccurrenceCount,profileOccurrenceCount, ,The occurence of profile
 * @row shortCode,shortCode, ,The short code of the contactpoint
 * @row telephoneNumber,telephoneNumber,"000-000-0000",Telephone number of the contactpoint
 * @row updatedBy,auditInfo.updatedBy,p('app.name'),Identifies the system or user which last updated the entity
 * @row updatedDate,auditInfo.updatedDate,now(),Timestamp of when the entity was last updated
 */
 
payload map(item,index) -> {
	id: item.id,
	contactPointType : item.contactPointType,
	activeFromDate: item.activeFromDate default now(),
	activeToDate: item.activeToDate,
	areaCode: item.areaCode,
	bestTimeToContactEndTime: item.bestTimeToContactEndTime,
	bestTimeToContactStartTime: item.bestTimeToContactStartTime,
	countryName: item.countryName,
	createdBy: item.auditInfo.createdBy default p('app.name'),
	createdDate: item.auditInfo.createdDate default now(),
	extensionNumber: item.extensionNumber,
	formattedE164PhoneNumber: item.formattedE164PhoneNumber,
	formattedInternationalPhoneNumber: item.formattedInternationalPhoneNumber,
	formattedNationalPhoneNumber: item.formattedNationalPhoneNumber default "000-000-0000",
	(forBusinessUse:   if(item.forBusinessUse) 1 else 0) if(!isEmpty(item.forBusinessUse)),
	(forPersonalUse:   if(item.forPersonalUse) 1 else 0) if(!isEmpty(item.forPersonalUse)),
	(isFaxCapable:   if(item.isFaxCapable) 1 else 0) if(!isEmpty(item.isFaxCapable)),
	(isSMSCapable:   if(item.isSMSCapable) 1 else 0) if(!isEmpty(item.isSMSCapable)),
	name: item.name,
	phoneCountryCode: item.phoneCountryCode,
	(primaryFlag:   if(item.primaryFlag) 1 else 0) if(!isEmpty(item.primaryFlag)),
	primaryPhoneType: item.primaryPhoneType,
	profileFirstCreatedDate: item.profileFirstCreatedDate,
	profileLastUpdatedDate: item.profileLastUpdatedDate,
	profileOccurrenceCount: item.profileOccurrenceCount,
	shortCode: item.shortCode,
	telephoneNumber: item.telephoneNumber default "000-000-0000",
	updatedBy: item.auditInfo.updatedBy default p('app.name'),
	updatedDate: item.auditInfo.updatedDate default now(),
	externalIds: item.externalIds map ((item, index) -> {
	  "id": item.id,
	  "externalId": item.externalId,
	  "externalIdType": item.externalIdType,
	  "createdBy": item.auditInfo.createdBy default p('app.name'),
  	  "updatedBy": item.auditInfo.updatedBy default p('app.name'),
	  "status": item.status,
	  "statusLastChangedDate": item.statusLastChangedDate})
}