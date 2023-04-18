/**
 *  Retrieve and Search Household Mapping for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
fun formatDate(dateformats) = if (dateformats !=null) (dateformats as String {format: "uuuu-MM-dd"})  else null
---
/**
  * Maps Database table Household to CIM JSON
  * @table CIM,MDM DB,Description
  * @row householdDissolvedDate,HOUSEHOLD_DISSOLVED_DATE, DissolvedDate of HouseHold
  * @row householdFormedDate,HOUSEHOLD_FORMED_DATE,Household Formed Date
  * @row householdMemberCount,HOUSEHOLD_MEMBER_COUNT, Count of people in a Household
  * @row globalParty,GLOBAL_PARTY,Global Party Id for Household
  * @row id,id,The id of the customer
  * @row name,name, A name given for a Household 
  * @row partyType,PARTY_TYPE,The type of party - default as Household
  * @row (externalIds ,vars.customerExternalIds) if (vars.customerExternalIds !=null and !(isEmpty(vars.customerExternalIds))),The external Ids of the customer that are stored in Core Banking System
  * @row auditInfo.createdDate,CREATED_DATE,Identifies the system or user which created the entity - default as current timestamp
  * @row auditInfo.createdBy,CREATED_BY,Timestamp of when the entity was created - default as current timestamp
  * @row auditInfo.updatedBy,UPDATED_BY,Identifies the system or user which last updated the entity - default as property app.name 
  * @row auditInfo.updatedDate,UPDATED_DATE,Timestamp of when the entity was last updated - default as current timestamp
  */
(payload map (item, index) ->
{
	globalParty: item.GLOBAL_PARTY,
	id:	item.ID,
	householdMemberCount: item.HOUSEHOLD_MEMBER_COUNT ,
	householdDissolvedDate: formatDate(item.HOUSEHOLD_DISSOLVED_DATE),
	householdFormedDate: formatDate(item.HOUSEHOLD_FORMED_DATE),
	partyType: item.PARTY_TYPE, 
	noMergeReason: item.NO_MERGE_REASON,
	name: item.NAME,
	(externalIds: vars.householdsExternalIds) if (vars.householdsExternalIds != null and !(isEmpty(vars.householdsExternalIds))),
	auditInfo: {
		createdBy: item.CREATED_BY,
		createdDate: item.CREATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
		updatedBy: item.UPDATED_BY,
		updatedDate: item.UPDATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
		isDeleted: item.isDeleted default false
	}
})