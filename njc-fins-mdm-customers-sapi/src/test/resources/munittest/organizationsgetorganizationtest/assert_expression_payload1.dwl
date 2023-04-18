%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo({
  "globalParty": "c33530a6-56b7-4926-8939-2603cffbec2e",
  "partyType": "Organization",
  "noMergeReason": "neural",
  "externalIds": [
    {
      "id": "03459c83-e40f-11eb-b8a7-0233bdd64096",
      "externalId": "03459c64-e40f-11eb-b8a7-0233bdd64096",
      "externalIdType": [
        "MDM"
      ],
      "status": "VALID",
      "statusLastChangedDate": "2021-07-13T19:17:49.000Z"
    },
    {
      "id": "03dab87e-e40f-11eb-b8a7-0233bdd64096",
      "externalId": "",
      "externalIdType": [
        "SALESFORCE_CORE"
      ],
      "status": "VALID",
      "statusLastChangedDate": "2021-07-13T19:17:50.000Z"
    }
  ],
  "name": "Torp - Connelly",
  "id": "03459c64-e40f-11eb-b8a7-0233bdd64096",
  "legalName": "O'Reilly, Abernathy and Hickle",
  "auditInfo": {
    "createdBy": "accelerator-mdm-sys-api",
    "createdDate": "2021-07-14T10:26:29.000Z",
    "updatedBy": "accelerator-mdm-sys-api",
    "updatedDate": "2021-07-14T10:26:29.000Z",
    "isDeleted": false
  }
})