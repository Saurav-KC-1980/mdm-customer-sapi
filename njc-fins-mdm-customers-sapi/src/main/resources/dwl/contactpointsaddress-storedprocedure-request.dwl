/**
 *  ContactPointAddress Create/Update Mapping for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
/**
 * Maps CIM ContactPointAddress to JSON which is used by stored procedure - sp_ContactPointAddress_Upsert 
 * @table JSON used by the stored procedure,CIM,Default Value,Description
 * @row id,id, ,The id of the contactpoint
 * @row contactPointType,contactPointType,ContactPointAddress,The type of contact point
 * @row activeFromDate,activeFromDate, ,The date from which contactpoint is active
 * @row activeToDate,activeToDate, ,The date until which contactpoint is active
 * @row addressLine1,addressLine1, ,The address line1 of the contactpoint address
 * @row addressLine2,addressLine2, ,The address line2 of the contactpoint address
 * @row addressLine3,addressLine3, ,The address line3 of the contactpoint address
 * @row addressLine4,addressLine4, ,The address line4 of the contactpoint address
 * @row bestTimeToContactEndTime,bestTimeToContactEndTime, ,The best time to contact end time
 * @row bestTimeToContactStartTime,bestTimeToContactStartTime, ,The best time to contact start time
 * @row cityName,cityName, ,The city name of the contactpoint address
 * @row countryName,countryName, ,The country name of the contactpoint address
 * @row createdBy,auditInfo.createdBy,p('app.name'),Identifies the system or user which created the contactpoint
 * @row createdDate,auditInfo.createdDate,now(),Timestamp of when the contactpoint was created
 * @row forBusinessUse,forBusinessUse, ,Flag to indicate whether this contactpoint is used for business purpose
 * @row forPersonalUse,forPersonalUse, ,Flag to indicate whether this contactpoint is used for personal use
 * @row geoAccuracy,geoAccuracy, ,The geo-accuracy of the contactpoint address
 * @row geoLatitude,geoLatitude, ,The geo-latitude of the contactpoint address
 * @row geoLongitude,geoLongitude, ,The geo-longitude of the contactpoint address
 * @row isUsedForBilling,isUsedForBilling, ,Flag to indicate whether the address is used for billing
 * @row isUsedForShipping,isUsedForShipping, ,Flag to indicate whether the address is used for shipping
 * @row name,name, ,The name of the contactpoint address
 * @row postalCodeText,postalCodeText, ,The postalcode of the contactpoint address
 * @row primaryFlag,primaryFlag, ,Flag to indicate if the address is primary
 * @row profileFirstCreatedDate,profileFirstCreatedDate, ,Timestamp of when the profile was first created
 * @row profileLastUpdatedDate,profileLastUpdatedDate, ,Timestamp of when the profile was last updated
 * @row profileOccurrenceCount,profileOccurrenceCount, ,The occurrence of profile
 * @row stateProvinceName,stateProvinceName, ,The state province of the contactpoint address
 * @row updatedBy,auditInfo.updatedBy,p('app.name'),Identifies the system or user which last updated the contactpoint
 * @row updatedDate,auditInfo.updatedDate, now(),Timestamp of when the contactpoint was last updated
 */
---
payload map(item,index) -> {
	
	id: item.id,
	contactPointType : item.contactPointType,
	activeFromDate: item.activeFromDate default now(),
	activeToDate: item.activeToDate,
	addressLine1: item.addressLine1,
	addressLine2: item.addressLine2,
	addressLine3: item.addressLine3,
	addressLine4: item.addressLine4,
	bestTimeToContactEndTime: item.bestTimeToContactEndTime,
	bestTimeToContactStartTime: item.bestTimeToContactStartTime,
	cityName: item.cityName,
	countryName: item.countryName,
	createdBy: item.auditInfo.createdBy default p('app.name'),
	createdDate: item.auditInfo.createdDate default now(),
	(forBusinessUse:   if(item.forBusinessUse) 1 else 0) if(!isEmpty(item.forBusinessUse)),
	(forPersonalUse:   if(item.forPersonalUse) 1 else 0) if(!isEmpty(item.forPersonalUse)),
	geoAccuracy: item.geoAccuracy,
	geoLatitude: item.geoLatitude,
	geoLongitude: item.geoLongitude,
	(isUsedForBilling:   if(item.isUsedForBilling) 1 else 0) if(!isEmpty(item.isUsedForBilling)),
	(isUsedForShipping:   if(item.isUsedForShipping) 1 else 0) if(!isEmpty(item.isUsedForShipping)),
	name: item.name,
	postalCodeText: item.postalCodeText,
	(primaryFlag:   if(item.primaryFlag) 1 else 0) if(!isEmpty(item.primaryFlag)),
	profileFirstCreatedDate: item.profileFirstCreatedDate,
	profileLastUpdatedDate: item.profileLastUpdatedDate,
	profileOccurrenceCount: item.profileOccurrenceCount,
	stateProvinceName: item.stateProvinceName,
	updatedBy: item.auditInfo.updatedBy default p('app.name'),
	updatedDate: item.auditInfo.updatedDate default now(),
	externalIds : item.externalIds map ((item, index) -> {
	  "id": item.id,
	  "externalId": item.externalId,
	  "externalIdType": item.externalIdType,
	  "status": item.status,
	  "createdBy" : item.auditInfo.createdBy default p('app.name'),
  	  "updatedBy" : item.auditInfo.updatedBy default p('app.name'),
	  "statusLastChangedDate": item.statusLastChangedDate})

}