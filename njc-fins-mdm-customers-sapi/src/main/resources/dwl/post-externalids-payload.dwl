/**
 *  ExternalIds Upsert Mapping for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
---
/**
 * Maps CIM to Json which is used by stored procedure - sp_Individual_ExternalIds_Upsert
 * @table JSON used by the stored procedure,CIM,Description
 * @row id, id,The id of the entry in MDM system
 * @row externalId, externalId,A unique identifier assigned to the individual in another system
 * @row createdBy, application name from properties, Identifies the system or user which created the entry
 * @row updatedBy, application name from properties,Identifies the system or user which last updated the entry
 * @row externalIdType, externalIdType,Identifies the system that owns or otherwise recognises this unique identifier
 * @row status, status,Indicates whether this identifier is currently valid or not
 * @row statusLastChangedDate, statusLastChangedDate,Date and time of the last change in status
 */
payload map (item,index) -> {
  "id": item.id,
  "externalId": item.externalId,
  "createdBy": p('app.name'),
  "updatedBy": p('app.name'),
  "externalIdType": item.externalIdType,
  "status": item.status,
  "statusLastChangedDate": item.statusLastChangedDate
}

