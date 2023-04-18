/**
 *  RelatedParties Retrieve Mapping for MDM System 
 */
%dw 2.0
output application/json
/**
 * Maps MDM DB to CIM Json which is used by other process API's
 * @table CIM,MDM DB,Description
 * @row id, ID,The id of the entry in MDM system
 * @row relatedFromDate, RELATED_FROM_DATE,Related From Date with the Party
 * @row relatedToDate, RELATED_TO_DATE,Related To Date with the Party
 * @row relatedParty, PARTY_RELATED_PARTY_ID,Indicates the Party that its related to
 * @row partyRelationshipType, PARTY_RELATION_TYPE.NAME, Pre-defined relation ship between parties
 */ 
fun formatDate(dateformats) = if (dateformats !=null) (dateformats as String {format: "uuuu-MM-dd"})  else null
---
payload map (item,index) -> {
  "id": item.ID,
  "relatedFromDate": formatDate(item.RELATED_FROM_DATE),
  "relatedToDate": formatDate(item.RELATED_TO_DATE),
  "relatedParty":  [
  	{
  		"id": item.PARTY_RELATED_PARTY_ID,
  		"partyTpe": item.RELATED_PARTY_TYPE,
  		"externalIds": flatten (vars.relatedPartiesExternalIds filter ($.partyId == item.PARTY_RELATED_PARTY_ID) map $.externalIds),
  		auditInfo: {
			createdBy: item.CREATED_BY,
			createdDate: item.CREATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
			updatedBy: item.UPDATED_BY,
			updatedDate: item.UPDATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
			isDeleted: item.IS_DELETED default false
		}
  	}
  ],
  "partyRelationshipType":  [item.NAME],
  "party": [  	
 	{ 
 		"id": item.PARTY_ID,
 		"partyType": item.PARTY_TYPE,
 		"externalIds": vars.partyExternalIds,
 		auditInfo: {
			createdBy: item.CREATED_BY,
			createdDate: item.CREATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
			updatedBy: item.UPDATED_BY,
			updatedDate: item.UPDATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
			isDeleted: item.IS_DELETED default false
		}
 	}
  ]  
}
	