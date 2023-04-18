%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo([
  {
    "id": "e0441093-918d-11eb-b4c8-0233bdd64096",
    "externalId": "e044106f-918d-11eb-b4c8-0233bdd64096",
    "externalIdType": [
      "MDM"
    ],
    "status": "VALID",
    "statusLastChangedDate": "2021-03-30T19:26:50.000Z"
  }
])