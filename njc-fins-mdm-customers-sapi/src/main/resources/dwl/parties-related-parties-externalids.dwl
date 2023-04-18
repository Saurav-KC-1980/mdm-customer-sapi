/**
 *  ExternalIds Query Mapping for MDM System 
 */
%dw 2.0
output application/json
/**
 * outputPayload variable is the maps the result of select query on MDM EXTERNAL_ID table.
 * @table Var,MDM, Description
 * @row id, id,The id of the entry in MDM system
 * @row externalId, externalId,A unique identifier assigned to the customer in another system
 * @row externalIdType, externalIdType,Identifies the system that owns or otherwise recognises this unique identifier
 * @row status, status,Indicates whether this identifier is currently valid or not
 * @row statusLastChangedDate, statusLastChangedDate,Date and time of the last change in status
 */
---
if(sizeOf(payload) > 0) ((payload groupBy ($.PARTY_ID) pluck $) map (item,index) -> {
        "partyId": (item[0].PARTY_ID), 
        "externalIds": (item map(item1,index1) -> {
                  	"id": item1.ID,
                   	"externalId": item1.EXTERNAL_ID,
                   	"externalIdType": [
  	                    item1.EXTERNAL_ID_TYPE_NAME
                    ],
                    "status": item1.STATUS,
                    "statusLastChangedDate": item1.STATUS_LAST_CHANGED_DATE as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"}
                 })
})else []
