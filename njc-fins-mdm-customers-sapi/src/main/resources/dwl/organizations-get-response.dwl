/**
 *  Retrieve Organization Mapping for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
fun formatDate(dateformats) = if (dateformats !=null) (dateformats as String {format: "uuuu-MM-dd"})  else null
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
(payload map (item, index) ->
{
	globalParty: item.GLOBAL_PARTY,
	partyType: item.PARTY_TYPE, 
	noMergeReason: item.NO_MERGE_REASON,
	(externalIds: vars.organizationsExternalIds) if (vars.organizationsExternalIds != null and !(isEmpty(vars.organizationsExternalIds))),
	name: item.NAME,
	id: item.ID,
	legalName:		item.LEGAL_NAME,
	auditInfo: {
		createdBy: item.CREATED_BY,
		createdDate: item.CREATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
		updatedBy: item.UPDATED_BY,
		updatedDate: item.UPDATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
		isDeleted: item.isDeleted default false
	}
})