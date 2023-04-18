/**
 * Create organization Mapping for MDM System.
 * Maps CIM organization to JSON which is used by stored procedure sp_Organizations_Create.
 * The fields in both CIM and JSON are identical.
 */
%dw 2.0
output application/json skipNullOn="everywhere"
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
	id: payload.id , 
	createdDate: payload.auditInfo.createdDate default now(),
	createdBy: payload.auditInfo.createdBy default p('app.name'),
	globalParty: payload.globalParty,
	legalName: payload.legalName,
	name: payload.name,
	noMergeReason: payload.noMergeReason,
	partyType: payload.partyType default "Organization",
	primaryAccount: payload.primaryAccount,
	updatedBy: payload.auditInfo.updatedBy default p('app.name'),
	updatedDate: payload.auditInfo.updatedDate default now() 

}