/**
 *  PartyRoles Retrieve Mapping for MDM System 
 */
%dw 2.0
output application/json
fun formatDate(dateformats) = if (dateformats !=null) (dateformats as String {format: "uuuu-MM-dd"})  else null
---
/**
 * Maps MDM PartyRole to CIM PartyRole format
 * @table CIM - partyRole, MDM - PARTY_ROLE,Description
 * @row id,ID,The id of the customer in MDM system
 * @row partyRoleType,PARTY_ROLE_TYPE,The party role type stored in MDM
 * @row party.id,PARTY_ID,The party identifier stored in MDM
 * @row partyType,PARTY_TYPE,The party type stores in MDM 
 * @row globalParty,GLOBAL_PARTY, The global party stored in MDM
 * @row noMergeReason,NO_MERGE_REASON, The reason for no merge
 */
payload map (item, index) ->
{
	id: item.ID,
	partyRoleType: item.PARTY_ROLE_TYPE,
	party: [{
		id: item.PARTY_ID,
		partyType: item.PARTY_TYPE,
		globalParty: item.GLOBAL_PARTY default "",
		noMergeReason: item.NO_MERGE_REASON default ""
	}]
}