/**
 *  ContactPoint Retrieve Mapping for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
---
/**
 * Maps MDM ContactPoint to CIM ContactPoint format
 * @table CIM,MDM,Default Value,Description
 * @row For each caitem in CONTACT_POINT_ADDRESS
 * @row id,caitem.ID, ,The id of the contactpoint
 * @row activeFromDate,caitem.ACTIVE_FROM_DATE, ,The date from which contactpoint is active
 * @row activeToDate,caitem.ACTIVE_TO_DATE, ,The date until which contactpoint is active
 * @row addressLine1,caitem.ADDRESS_LINE1, ,The address line1 of the contactpoint address
 * @row addressLine2,caitem.ADDRESS_LINE2, ,The address line2 of the contactpoint address
 * @row addressLine3,caitem.ADDRESS_LINE3, ,The address line3 of the contactpoint address
 * @row addressLine4,caitem.ADDRESS_LINE4,,The address line4 of the contactpoint address
 * @row bestTimeToContactEndTime,caitem.BEST_TIME_TO_CONTACT_END_TIME, ,The best time to contact end time
 * @row bestTimeToContactStartTime,caitem.BEST_TIME_TO_CONTACT_START_TIME, ,The best time to contact start time
 * @row cityName,caitem.CITY_NAME, ,The city name of the contactpoint address
 * @row countryName,caitem.COUNTRY_NAME, ,The country name of the contactpoint address
 * @row contactPointType,"ContactPointAddress", ,The type of contactpoint type
 * @row forBusinessUse,caitem.FOR_BUSINESS_USE, ,Flag to indicate whether this contactpoint is used for business purpose
 * @row forPersonalUse,caitem.FOR_PERSONAL_USE, ,Flag to indicate whether this contactpoint is used for personal use
 * @row geoAccuracy,caitem.GEO_ACCURACY, ,The geo accuracy of the contactpoint address
 * @row geoLatitude,caitem.GEO_LATITUDE, ,The geo latitude of the contactpoint address
 * @row geoLongitude,caitem.GEO_LONGITUDE, ,The geo longitude of the contactpoint address
 * @row isUsedForBilling,caitem.IS_USED_FOR_BILLING, ,Flag to indicate whether the address is used for billing
 * @row isUsedForShipping,caitem.IS_USED_FOR_SHIPPING, ,Flag to indicate whether the address is used for billing
 * @row name,caitem.CONTACT_POINT_ADDRESS_NAME, ,The name of the contactpoint address
 * @row postalCodeText,caitem.POSTAL_CODE_TEXT, ,The postalcode of the contactpoint address
 * @row primaryFlag,caitem.PRIMARY_FLAG, ,Flag to indicate if the address is primary
 * @row profileFirstCreatedDate,caitem.PROFILE_FIRST_CREATED_DAT, ,Timestamp of when the profile was first created
 * @row profileLastUpdatedDate,caitem.PROFILE_LAST_UPDATED_DATE, ,Timestamp of when the profile was last updated
 * @row profileOccurrenceCount,caitem.PROFILE_OCCURRENCE_COUNT, ,The occurence of profile
 * @row stateProvinceName,caitem.STATE_PROVINCE_NAME, ,The state province of the contactpoint address
 * @row auditInfo.createdBy,caitem.CREATED_BY, ,Identifies the system or user which created the entity
 * @row auditInfo.createdDate,caitem.CREATED_DATE , ,Timestamp of when the entity was created
 * @row auditInfo.updatedBy,caitem.UPDATED_BY, ,Identifies the system or user which last updated the entity
 * @row auditInfo.updatedDate,caitem.UPDATED_DATE, ,Timestamp of when the entity was last updated
 * @row auditInfo.isDeleted,caitem.isDeleted ,false,Indicates whether or not the entity has been soft-deleted
 * @row END of foreach loop, , , ,
 * @row For each cpitem in CONTACT_POINT_PHONE, , , ,
 * @row id,cpitem.ID, ,The id of the contactpoint
 * @row activeFromDate,cpitem.ACTIVE_FROM_DATE, ,The date from which contactpoint is active
 * @row activeToDate,cpitem.ACTIVE_TO_DATE, ,The date until which contactpoint is active
 * @row areaCode,cpitem.AREA_CODE, ,The area code of the contactpoint
 * @row bestTimeToContactEndTime,cpitem.BEST_TIME_TO_CONTACT_END_TIME, ,The best time to contact end time
 * @row bestTimeToContactStartTime,cpitem.BEST_TIME_TO_CONTACT_START_TIME, ,The best time to contact start time
 * @row countryName,cpitem.COUNTRY_NAME, ,The country name of the contact point phone
 * @row contactPointType,"ContactPointPhone", ,The type of contact point
 * @row extensionNumber,cpitem.EXTENSION_NUMBER, ,The extension number of the contactpoint phone
 * @row forBusinessUse,cpitem.FOR_BUSINESS_USE, ,Flag to inidicate whether this contactpoint is used for business purpose
 * @row formattedE164PhoneNumber,cpitem.FORMATTED_E164_PHONE_NUMBER, ,The formatted E164 phone number
 * @row formattedInternationalPhoneNumber,cpitem.FORMATTED_INTERNATIONAL_PHONE_NUMBER, ,The formatted international phone number
 * @row formattedNationalPhoneNumber,cpitem.FORMATTED_NATIONAL_PHONE_NUMBER, ,The formatted national phone number
 * @row forPersonalUse,cpitem.FOR_PERSONAL_USE, ,Flag to inidicate whether this contactpoint is used for personal use
 * @row isFaxCapable,cpitem.IS_FAX_CAPABLE, ,Flag to indicate whether the contactpoint phone is fax capable
 * @row isSMSCapable,cpitem.IS_SM_SCAPABLE, ,Flag to indicate whether the contactpoint phone is sms capable
 * @row name, cpitem.CONTACT_POINT_PHONE_NAME, ,The name of the contactpoint phone
 * @row phoneCountryCode,cpitem.PHONE_COUNTRY_CODE, ,The country code of the contactpoint phone
 * @row primaryFlag,cpitem.PRIMARY_FLAG, ,Flag to indicate if the phone is primary
 * @row primaryPhoneType,cpitem.PRIMARY_PHONE_TYPE, ,The type of primary phone
 * @row profileFirstCreatedDate, cpitem.PROFILE_FIRST_CREATED_DATE, ,Timestamp of when the profile was first created
 * @row profileLastUpdatedDate,cpitem.PROFILE_LAST_UPDATED_DATE, ,Timestamp of when the profile was last updated
 * @row profileOccurrenceCount,cpitem.PROFILE_OCCURRENCE_COUNT, ,The occurence of profile
 * @row shortCode,cpitem.SHORT_CODE, ,The short code of the contactpoint
 * @row telephoneNumber,cpitem.TELEPHONE_NUMBER, ,Telephone number of the contactpoint
 * @row auditInfo.createdBy,cpitem.CREATED_BY, ,Identifies the system or user which created the entity
 * @row auditInfo.createdDate,cpitem.CREATED_DATE, ,Timestamp of when the entity was created
 * @row auditInfo.updatedBy,cpitem.UPDATED_BY, ,Identifies the system or user which last updated the entity
 * @row auditInfo.updatedDate,cpitem.UPDATED_DATE, ,Timestamp of when the entity was last updated
 * @row auditInfo.isDeleted,cpitem.isDeleted ,false,Indicates whether or not the entity has been soft-deleted
 * @row end of for each loop, , , ,
 * @row For each ceitem in CONTACT_POINT_EMAIL, , , ,
 * @row id,ceitem.ID, ,The id of the contactpoint
 * @row activeFromDate,ceitem.ACTIVE_FROM_DATE, ,The date from which contactpoint is active
 * @row activeToDate,ceitem.ACTIVE_TO_DATE, ,The date until which contactpoint is active
 * @row bestTimeToContactEndTime,ceitem.BEST_TIME_TO_CONTACT_END_TIME , ,The best time to contact end time
 * @row bestTimeToContactStartTime,ceitem.BEST_TIME_TO_CONTACT_START_TIME, ,The best time to contact start time
 * @row contactPointType,"ContactPointEmail", ,The type of contact point
 * @row emailAddress,ceitem.EMAIL_ADDRESS, ,The email address of the contactpoint 
 * @row emailBouncedReason,ceitem.EMAIL_LATEST_BOUNCE_REASON_TEXT, ,The reason indicating why the email bounces
 * @row emailDomain,ceitem.EMAIL_DOMAIN, ,The domain of the email address
 * @row emailLatestBounceDateTime,ceitem.EMAIL_LATEST_BOUNCE_DATE_TIME, ,Timestamp of when the email last bounced
 * @row emailMailBox,ceitem.EMAIL_MAIL_BOX, ,The email mail box to which email must be delivered
 * @row forBusinessUse,ceitem.FOR_BUSINESS_USE, ,Flag to indicate whether this contactpoint is used for business purpose
 * @row forPersonalUse,ceitem.FOR_PERSONAL_USE, ,Flag to indicate whether this contactpoint is used for personal use
 * @row name, ceitem.CONTACT_POINT_EMAILADDRESS_NAME, ,The name of the contactpoint email address
 * @row primaryFlag,ceitem.PRIMARY_FLAG, ,Flag to indicate if the email address is primary
 * @row profileFirstCreatedDate,ceitem.PROFILE_FIRST_CREATED_DATE, ,Timestamp of when the profile was first created
 * @row profileLastUpdatedDate,ceitem.PROFILE_LAST_UPDATED_DATE, ,Timestamp of when the profile was last updated
 * @row profileOccurrenceCount,ceitem.PROFILE_OCCURRENCE_COUNT, ,The occurence of profile
 * @row auditInfo.createdBy,ceitem.CREATED_BY, ,Identifies the system or user which created the entity
 * @row auditInfo.createdDate,ceitem.CREATED_DATE, ,Timestamp of when the entity was created
 * @row auditInfo.updatedBy,ceitem.UPDATED_BY, ,Identifies the system or user which last updated the entity
 * @row auditInfo.updatedDate,ceitem.UPDATED_DATE, ,Timestamp of when the entity was last updated
* @row auditInfo.isDeleted,ceitem.IS_DELETED ,false,Indicates whether or not the entity has been soft-deleted
* @row END of foreach loop, , , ,
*/
flatten([
	//Mappings for ContactPointAddress
	(vars.contactPointAddressDBRecords map (caitem,caindex) ->{
		id: caitem.ID,
		activeFromDate: if(caitem.ACTIVE_FROM_DATE !=null) (caitem.ACTIVE_FROM_DATE as String {format: "uuuu-MM-dd"}) else null,
		activeToDate: if(caitem.ACTIVE_TO_DATE != null) (caitem.ACTIVE_TO_DATE  as String {format: "uuuu-MM-dd"}) else null,
		addressLine1: caitem.ADDRESS_LINE1,
		addressLine2: caitem.ADDRESS_LINE2,
		addressLine3: caitem.ADDRESS_LINE3,
		addressLine4: caitem.ADDRESS_LINE4,
		bestTimeToContactEndTime: if(caitem.BEST_TIME_TO_CONTACT_END_TIME != null) (caitem.BEST_TIME_TO_CONTACT_END_TIME  as String {format: "HH:mm:ss"}) else null,
		bestTimeToContactStartTime: if(caitem.BEST_TIME_TO_CONTACT_START_TIME != null)  (caitem.BEST_TIME_TO_CONTACT_START_TIME  as String {format: "HH:mm:ss"}) else null,
		cityName: caitem.CITY_NAME,
		countryName: caitem.COUNTRY_NAME,
		contactPointType: ["ContactPointAddress"],
		forBusinessUse: caitem.FOR_BUSINESS_USE,
		forPersonalUse: caitem.FOR_PERSONAL_USE,
		geoAccuracy: caitem.GEO_ACCURACY,
		geoLatitude: caitem.GEO_LATITUDE,
		geoLongitude: caitem.GEO_LONGITUDE,
		isUsedForBilling: caitem.IS_USED_FOR_BILLING,
		isUsedForShipping: caitem.IS_USED_FOR_SHIPPING,
		name: caitem.CONTACT_POINT_ADDRESS_NAME,
		postalCodeText: caitem.POSTAL_CODE_TEXT,
		primaryFlag: caitem.PRIMARY_FLAG,
		profileFirstCreatedDate: if(caitem.PROFILE_FIRST_CREATED_DATE != null)  (caitem.PROFILE_FIRST_CREATED_DATE  as String {format: "uuuu-MM-dd"}) else null,
		profileLastUpdatedDate: if(caitem.PROFILE_LAST_UPDATED_DATE != null)  (caitem.PROFILE_LAST_UPDATED_DATE  as String {format: "uuuu-MM-dd"}) else null,
		profileOccurrenceCount: caitem.PROFILE_OCCURRENCE_COUNT,
		stateProvinceName: caitem.STATE_PROVINCE_NAME,
		auditInfo: {
			createdBy: caitem.CREATED_BY,
			createdDate: caitem.CREATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
			updatedBy: caitem.UPDATED_BY,
			updatedDate: caitem.UPDATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
			isDeleted: caitem.isDeleted default false
		},
		externalIds: vars.externalIdAddress filter ($.'contactPointId' == caitem.ID) map(item, index) -> item -- [ "contactPointId" ]
	}) if(sizeOf(vars.contactPointAddressDBRecords) > 0),
	
	//Mappings for ContactPointPhone
(vars.contactPointPhoneDBRecords map (cpitem,cpindex) ->{
	id: cpitem.ID,
	activeFromDate: if(cpitem.ACTIVE_FROM_DATE !=null) (cpitem.ACTIVE_FROM_DATE as String {format: "uuuu-MM-dd"}) else null,
	activeToDate: if(cpitem.ACTIVE_TO_DATE != null) (cpitem.ACTIVE_TO_DATE  as String {format: "uuuu-MM-dd"}) else null,
	areaCode: cpitem.AREA_CODE,
	bestTimeToContactEndTime:  if(cpitem.BEST_TIME_TO_CONTACT_END_TIME != null) (cpitem.BEST_TIME_TO_CONTACT_END_TIME  as String {format: "HH:mm:ss"}) else null,
	bestTimeToContactStartTime: if(cpitem.BEST_TIME_TO_CONTACT_START_TIME != null)  (cpitem.BEST_TIME_TO_CONTACT_START_TIME  as String {format: "HH:mm:ss"}) else null,
	countryName: cpitem.COUNTRY_NAME,
	contactPointType: ["ContactPointPhone"],
	extensionNumber: cpitem.EXTENSION_NUMBER,
	forBusinessUse: cpitem.FOR_BUSINESS_USE,
	formattedE164PhoneNumber: cpitem.FORMATTED_E164_PHONE_NUMBER,
	formattedInternationalPhoneNumber: cpitem.FORMATTED_INTERNATIONAL_PHONE_NUMBER,
	formattedNationalPhoneNumber: cpitem.FORMATTED_NATIONAL_PHONE_NUMBER,
	forPersonalUse: cpitem.FOR_PERSONAL_USE,
	isFaxCapable: cpitem.IS_FAX_CAPABLE,
	isSMSCapable: cpitem.IS_SM_SCAPABLE,
	name: cpitem.CONTACT_POINT_PHONE_NAME,
	phoneCountryCode:  cpitem.PHONE_COUNTRY_CODE,
	primaryFlag: cpitem.PRIMARY_FLAG,
	primaryPhoneType: cpitem.PRIMARY_PHONE_TYPE,
	profileFirstCreatedDate: if(cpitem.PROFILE_FIRST_CREATED_DATE != null)  (cpitem.PROFILE_FIRST_CREATED_DATE  as String {format: "uuuu-MM-dd"}) else null,
	profileLastUpdatedDate: if(cpitem.PROFILE_LAST_UPDATED_DATE != null)  (cpitem.PROFILE_LAST_UPDATED_DATE  as String {format: "uuuu-MM-dd"}) else null,
	profileOccurrenceCount:  cpitem.PROFILE_OCCURRENCE_COUNT,
	shortCode: cpitem.SHORT_CODE,
	telephoneNumber: cpitem.TELEPHONE_NUMBER,
	auditInfo: {
		createdBy: cpitem.CREATED_BY,
		createdDate: cpitem.CREATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
		updatedBy: cpitem.UPDATED_BY,
		updatedDate: cpitem.UPDATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
		isDeleted: cpitem.isDeleted default false
	},
	externalIds: vars.externalIdPhone filter ($.'contactPointId' == cpitem.ID) map(item, index) -> item -- [ "contactPointId" ]
}) if(sizeOf(vars.contactPointPhoneDBRecords) > 0),

	//Mappings for ContactPointEmail
(vars.contactPointEmailDBRecords map (ceitem,ceindex) ->{
	id: ceitem.ID,
	activeFromDate: if(ceitem.ACTIVE_FROM_DATE !=null) (ceitem.ACTIVE_FROM_DATE as String {format: "uuuu-MM-dd"}) else null,
	activeToDate: if(ceitem.ACTIVE_TO_DATE != null) (ceitem.ACTIVE_TO_DATE  as String {format: "uuuu-MM-dd"}) else null,
	bestTimeToContactEndTime: if(ceitem.BEST_TIME_TO_CONTACT_END_TIME != null) (ceitem.BEST_TIME_TO_CONTACT_END_TIME  as String {format: "HH:mm:ss"}) else null,
	bestTimeToContactStartTime: if(ceitem.BEST_TIME_TO_CONTACT_START_TIME != null)  (ceitem.BEST_TIME_TO_CONTACT_START_TIME  as String {format: "HH:mm:ss"}) else null,
	contactPointType: ["ContactPointEmail"],
	emailAddress: ceitem.EMAIL_ADDRESS,
	emailBouncedReason: ceitem.EMAIL_LATEST_BOUNCE_REASON_TEXT,
	emailDomain: ceitem.EMAIL_DOMAIN,
	emailLatestBounceDateTime: if(ceitem.EMAIL_LATEST_BOUNCE_DATE_TIME != null)  (ceitem.EMAIL_LATEST_BOUNCE_DATE_TIME  as String {format: "HH:mm:ss"}) else null,
	emailMailBox: ceitem.EMAIL_MAIL_BOX,
	forBusinessUse: ceitem.FOR_BUSINESS_USE,
	forPersonalUse: ceitem.FOR_PERSONAL_USE,
	name: ceitem.CONTACT_POINT_EMAILADDRESS_NAME,
	primaryFlag:  ceitem.PRIMARY_FLAG,
	profileFirstCreatedDate: if(ceitem.PROFILE_FIRST_CREATED_DATE != null)  (ceitem.PROFILE_FIRST_CREATED_DATE  as String {format: "uuuu-MM-dd"}) else null,
	profileLastUpdatedDate: if(ceitem.PROFILE_LAST_UPDATED_DATE != null)  (ceitem.PROFILE_LAST_UPDATED_DATE  as String {format: "uuuu-MM-dd"}) else null,
	profileOccurrenceCount:  ceitem.PROFILE_OCCURRENCE_COUNT,
	auditInfo: {
		createdBy: ceitem.CREATED_BY,
		createdDate: ceitem.CREATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
		updatedBy: ceitem.UPDATED_BY,
		updatedDate: ceitem.UPDATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
		isDeleted: ceitem.isDeleted default false
	},
	externalIds: vars.externalIdEmail filter ($.'contactPointId' == ceitem.ID) map(item, index) -> item -- [ "contactPointId" ]
}) if(sizeOf(vars.contactPointEmailDBRecords) > 0)
])