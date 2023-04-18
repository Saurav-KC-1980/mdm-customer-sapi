%dw 2.0
import mergeWith from dw::core::Objects
output application/json
---
if (vars.httpStatus == null and vars.currentParty != null) 
(vars.currentParty mergeWith {
	(contactPoints: vars.currentContactPoints default [])
}) else
{
  "errorCode": "404",
  "errorMessage": "Requested resource was not found",
  "transactionId": correlationId default "",
  "timeStamp": now()
} 