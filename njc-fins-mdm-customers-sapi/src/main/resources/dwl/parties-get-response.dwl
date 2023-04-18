/**
 *  Parties Query Mapping for MDM System 
 */
%dw 2.0
output application/json
---
/**
 * Maps MDM PartyRole to CIM PartyRole format
 * @table CIM - partyRole, MDM - PARTY_ROLE,Description
 * @row id,ID,The party identifier stored in MDM
 * @row partyType,PARTY_TYPE,The party type stored in MDM
 * @row globalParty,GLOBAL_PARTY, The global party stored in MDM
 * @row noMergeReason,NO_MERGE_REASON, The reason for no merge
 */
payload map (item, index) ->
{
	id: item.ID,
	partyType: item.PARTY_TYPE,
	globalParty: item.GLOBAL_PARTY default "",
	noMergeReason: item.NO_MERGE_REASON default ""
}
