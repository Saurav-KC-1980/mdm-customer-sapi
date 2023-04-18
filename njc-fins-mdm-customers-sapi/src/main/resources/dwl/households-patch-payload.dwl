/**
 * Mapping for MDM System to Update Household. Maps CIM Household to payload 
 * which is used as input parameter in the update Household table. The fields in
 * both CIM and MDM are identical. PATCH payload is created by validating the 
 * Input Request payload with DB Record Payload.
 */
%dw 2.0
output application/json skipNullOn="everywhere"
/**
 * payloadRecordfromDB is the existing customer record in MDM system
 */
var payloadRecordfromDB = vars.householdDBRecord
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
	householdMemberCount: (if(payload.householdMemberCount?) payload.householdMemberCount else payloadRecordfromDB.householdMemberCount),
	createdBy: p('app.name'),
	createdDate: now(),
	householdDissolvedDate: (if(payload.householdDissolvedDate?) payload.householdDissolvedDate else payloadRecordfromDB.householdDissolvedDate),
	householdFormedDate: (if(payload.householdFormedDate?) payload.householdFormedDate else payloadRecordfromDB.householdFormedDate),
	name:  (if(payload.name?) payload.name else payloadRecordfromDB.name),
	globalParty: (if(payload.globalParty?) payload.globalParty else payloadRecordfromDB.globalParty),
	id: vars.householdId,
	noMergeReason: (if(payload.noMergeReason?) payload.noMergeReason else payloadRecordfromDB.noMergeReason),
	partyType: (if(payload.partyType?) payload.partyType else payloadRecordfromDB.partyType),
	updatedBy: p('app.name'),
	updatedDate: now()
}


