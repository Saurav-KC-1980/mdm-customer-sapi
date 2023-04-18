/**
 * Create Organization Mapping for MDM System 
 * Maps CIM Organization to payload which is used as input parameter in the update query of ORGANIZATION table.
 * The fields in both CIM and MDM are identical.
 * PATCH payload is created by validating the Input Request payload with DB Record Payload.
 */
%dw 2.0
output application/java
/**
 * payloadRecordfromDB is the existing customer record in MDM system
 */
var payloadRecordfromDB = vars.organizationDBRecord
---
/**
 * Maps CIM Organization to MDM Organization as in DB
 * @table CIM,MDM DB,Description
 * @row name,NAME,Name of the organization
 * @row createdBy,CREATED_BY,Identifies the system or user which created the organization - default as property app.name
 * @row createdOn,CREATED_ON,Identifies the date on which the organization was created - default as sysdate
 * @row globalParty,GLOBAL_PARTY,Global Party of the the organization
 * @row id,ID,Unique Id to identify the organization
 * @row legalName,LEGAL_NAME,Legal name of the organization
 * @row noMergeReason,NO_MERGE_REASON, Reason to not merge the organization
 * @row partyType,PARTY_TYPE,Party type of the organization
 * @row updatedBy,UPDATED_BY,Identifies the system or user which updated the organization - default as property app.name
 * @row updatedOn,UPDATED_ON,Identifies the date on which the organization was updated - default as sysdate
 */
{
	createdBy: p('app.name'),
	createdDate: now(),
	name: (if(payload.name?) payload.name else payloadRecordfromDB.name),
	globalParty: (if(payload.globalParty?) payload.globalParty else payloadRecordfromDB.globalParty),
	id: vars.organizationId,
	legalName: (if(payload.legalName?) payload.legalName else payloadRecordfromDB.legalName),
	noMergeReason: (if(payload.noMergeReason?) payload.noMergeReason else payloadRecordfromDB.noMergeReason),
	partyType: (if(payload.partyType?) payload.partyType else payloadRecordfromDB.partyType),
	updatedBy: p('app.name'),
	updatedDate: now()
	
}