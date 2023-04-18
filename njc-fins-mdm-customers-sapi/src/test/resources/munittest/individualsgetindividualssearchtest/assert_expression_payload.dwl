%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo([
  {
    "partyType": "Individual",
    "currentEmployerName": "Daniel - Trantow",
    "firstName": "Rodolfo",
    "id": "4c833802-8e7f-11eb-b4c8-0233bdd64096",
    "lastName": "Considine",
    "middleName": "Crooks",
    "mothersMaidenName": "Kulas",
    "nameSuffix": "Mrs.",
    "personName": "Ms. Sheryl Von",
    "auditInfo": {
      "createdBy": "accelerator-mdm-sys-api",
      "createdDate": "2021-03-26T22:04:56.000Z",
      "updatedBy": "accelerator-mdm-sys-api",
      "updatedDate": "2021-03-26T22:04:56.000Z",
      "isDeleted": false
    }
  }
])