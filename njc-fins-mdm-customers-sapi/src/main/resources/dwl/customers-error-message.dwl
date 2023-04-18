/**
 * Error response returned for an invalid request
 */
%dw 2.0
output application/json
---
{
  "errorCode": "400",
  "errorMessage": "Invalid request message",
  "transactionId": correlationId default "",
  "timeStamp": now()
}
