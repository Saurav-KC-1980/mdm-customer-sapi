/**
 * Create Household Mapping for MDM System. Maps CIM Household to payload which 
 * is used as input parameter to insert into Household table. The fields in both 
 * CIM and MDM are identical.
 */
%dw 2.0
output application/json skipNullOn="everywhere"
---
/**
  * Maps CIM Household to JSON which is used by stored procedure - sp_Households_Upsert
  * @table JSON used by the stored procedure,CIM,Description
  * @row householdDissolvedDate,householdDissolvedDate, DissolvedDate of HouseHold
  * @row householdFormedDate,householdFormedDate,Household Formed Date
  * @row householdMemberCount,householdMemberCount, Count of people in a Household
  * @row globalParty,globalParty,Global Party Id for Household
  * @row id,id,The id of the customer
  * @row name,name, A name given for a Household 
  * @row partyType,"Household",The type of party - default as Household
  * @row createdDate,auditInfo.createdDate,Identifies the system or user which created the entity - default as current timestamp
  * @row createdBy,auditInfo.createdBy,Timestamp of when the entity was created - default as current timestamp
  * @row updatedBy,auditInfo.updatedBy,Identifies the system or user which last updated the entity - default as property app.name 
  * @row updatedDate,auditInfo.updatedDate,Timestamp of when the entity was last updated - default as current timestamp
  */
{
	createdDate: payload.auditInfo.createdDate default now(),
	createdBy: payload.auditInfo.createdBy default p('app.name'),
	householdDissolvedDate: payload.householdDissolvedDate,
	householdFormedDate: payload.householdFormedDate,
	householdMemberCount: payload.householdMemberCount,
	globalParty: payload.globalParty,
	id: payload.id,
	name: payload.name,
	noMergeReason: payload.noMergeReason,
	partyType: payload.partyType,
	updatedBy: payload.auditInfo.updatedBy default p('app.name'),
	updatedDate: payload.auditInfo.updatedDate default now()
}