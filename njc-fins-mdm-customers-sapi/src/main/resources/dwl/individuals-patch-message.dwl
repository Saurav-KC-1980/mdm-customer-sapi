/**
 * Response in case update has been successful or resource not found
 */
%dw 2.0
output application/json
---
if(payload.affectedRows==0){
  "errorCode": "400",
  "errorMessage": "Requested resource was not found",
  "transactionId": correlationId default "",
  "timeStamp": now()
} else {
	responseStatus: "SUCCESS"
} 