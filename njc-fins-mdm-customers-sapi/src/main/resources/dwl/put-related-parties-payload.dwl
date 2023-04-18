/**
 *  RelatedParties Upsert Mapping for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
---
/**
 * Maps CIM to Json which is used by stored procedure - Parties_RelatedParties_Upsert
 * @table JSON used by the stored procedure,CIM,Description
 * @row id, id,The id of the entry in MDM system
 * @row createdBy, application name from properties, Identifies the system or user which created the entry
 * @row updatedBy, application name from properties,Identifies the system or user which last updated the entry
 * @row relatedFromDate, relatedFromDate,Related From Date with the Party
 * @row relatedToDate, relatedToDate,Related To Date with the Party
 * @row relatedParty, relatedParty,Indicates the Party that its related to
 * @row partyRelationshipType, partyRelationshipType, Pre-defined relation ship between parties
 */
payload map (item,index) -> {
  "id": item.id,
  "createdBy": p('app.name'),
  "updatedBy": p('app.name'),
  "relatedFromDate": item.relatedFromDate,
  "relatedToDate": item.relatedToDate,
  "relatedParty":  if((typeOf(item.relatedParty[0]) as String) =="Object") item.relatedParty[0].id else item.relatedParty[0],
  "partyRelationshipType":  item.partyRelationshipType[0]
}

