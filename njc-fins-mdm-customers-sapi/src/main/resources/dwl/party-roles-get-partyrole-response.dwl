%dw 2.0
import mergeWith from dw::core::Objects
output application/json
var updatedParty = (vars.currentParty mergeWith {
	(contactPoints: vars.currentContactPoints default [])
}) 
---
if(vars.httpStatus == null and vars.currentCustomer.id != null)
((vars.currentCustomer - "party") ++ ({
	"party" : [updatedParty] 
})) else
({
  "errorCode": "404",
  "errorMessage": "Requested resource was not found",
  "transactionId": correlationId default "",
  "timeStamp": now()
})