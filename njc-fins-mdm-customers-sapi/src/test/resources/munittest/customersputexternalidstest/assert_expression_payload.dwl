%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo({
  "errorCode": "400",
  "errorMessage": "Invalid request message",
  "transactionId": "7f260690-91c7-11eb-9aa6-147dda9c38fd",
  "timeStamp": "2021-03-30T21:19:22.684-05:00"
})